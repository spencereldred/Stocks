require 'sinatra'
require 'sinatra/reloader'
require 'yahoofinance'
#  Stock App
get '/' do

  @method = "post"
  @action   = "/stock"

  erb :form
end

# Responds with a form to get a new stock symbol
get '/stock/new' do

  @method = "post"
  @action   = "/stock"

  erb :form
end

# Receives 'new' stock symbol
post '/stock' do
  quote_type = YahooFinance::StandardQuote
  quote_symbols = params['stock_symbol']
  @quotes = [{'yhoo' => 109.22}]
  YahooFinance::get_quotes( quote_type, quote_symbols ) do |qt|
    @quotes.push( {
      name: qt.name,
      date: qt.date,
      time: qt.time,
      symbol: qt.symbol,
      previousClose: qt.previousClose,
      changePoints: qt.changePoints,
      changePercet: qt.changePercent,
      lastTrade: qt.lastTrade,
      volume: qt.volume,
      open: qt.open,
      high: qt.dayHigh,
      low: qt.dayLow
      } )
    @quotes.shift
end
  erb :index
end

