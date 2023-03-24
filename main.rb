require 'dotenv/load'
require 'openai'

OpenAI.configure do |config|
  config.access_token = ENV.fetch('OPENAI_ACCESS_TOKEN')
  # config.organization_id = ENV.fetch('OPENAI_ORGANIZATION_ID') # Optional.
end

system = <<~TEXT
あなたは大学情報サイトの運営者です。

日本の大学の学部・学科を、
文化・地理・歴史
法律・政治・経済
社会・マスコミ
国際・語学
芸術・文学・表現
家政・生活
人間・心理・教育・福祉
スポーツ・健康・医療
数学・物理・化学
生物
地球・環境・エネルギー
工学・建築・技術
の１２種類に分類してください。

返答は名前だけでよいです。
TEXT

client = OpenAI::Client.new(request_timeout: 25)

response = client.chat(
  parameters: {
    model: 'gpt-3.5-turbo',
    messages: [
      { role: 'system', content: system},
      { role: 'user', content: '人間関係学部,心理学科'},
    ],
    temperature: 0.7,
  })
puts response.dig('choices', 0, 'message', 'content')

response = client.chat(
  parameters: {
    model: 'gpt-3.5-turbo',
    messages: [
      { role: 'system', content: system},
      { role: 'user', content: '体育学部,スポーツ科学科'},
    ],
    temperature: 0.7,
  })
puts response.dig('choices', 0, 'message', 'content')

response = client.chat(
  parameters: {
    model: 'gpt-3.5-turbo',
    messages: [
      { role: 'system', content: system},
      { role: 'user', content: '仏教学部,禅学科'},
    ],
    temperature: 0.7,
  })
puts response.dig('choices', 0, 'message', 'content')
