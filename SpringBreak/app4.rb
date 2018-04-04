require 'rubygems'
require 'oauth'
require 'json'

consumer_key = OAuth::Consumer.new(
    "",
    "") 
#Insert API Key info above

access_token = OAuth::Token.new(
    "",
    "")
#Insert API acess token info above

baseurl = "https://api.twitter.com"
path = "/1.1/statuses/update.json"

address = URI("#{baseurl}#{path}")
request = Net::HTTP::Post.new address.request_uri
request.set_form_data(
  "status" => "You are the best!"
)

http = Net::HTTP.new address.host, address.port
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

request.oauth! http, consumer_key, access_token
http.start
response = http.request request

tweet = nil
if response.code == '200' then
  tweet = JSON.parse(response.body)
  puts "Success:  #{tweet["text"]}"
else
  puts "Game Over" +
  "Code:#{response.code} Body:#{response.body}"
end