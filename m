Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EF223278D
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755937415; cv=none; b=oF6OYNBU404P0T0GVgbxlckRHP1LdRLAn1cKjrzs+7Qecuv9kL/zS4ixD5pucLer0y648DKu0LZPAtOcwvQ24/YyVApWAkl7Ls64nLByxzx7+teZiw70pTgzUNsBFs3gofwYcGAW6KaKpjmF7FVsgb7kE45LADHlANbII9KpggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755937415; c=relaxed/simple;
	bh=abph2z6N5iamAU3Asoftgj2m3MlJQXhVumafNgqCd/U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Li6viovtYCppPOYUPXC0BBd6bBQ2vey0R0X5sNdYBFi3Tu0QhNcCTZOLp40xq4K06uZ8pQ01Lzu1LRw5pf1F9VUWm35MqSJxY2BIXkIMY7dFcvcsMYlAcGRsYvHOHHsQIFBuqA0tRzWV7WCJuH1DU98qkjBxNe5X/qD2QEF8wZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bXRnbHMy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FFjFRmAd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bXRnbHMy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFjFRmAd"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CD9DEC0092;
	Sat, 23 Aug 2025 04:23:32 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sat, 23 Aug 2025 04:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755937412;
	 x=1756023812; bh=AO6fbziTgB3dkS8SW5GrOzTQHRzRJCUxs5LRAeMbYgk=; b=
	bXRnbHMymW4y6VWssqIjsBQzMXkohbqmYkYZyUmWVI3rWREW0KeiqX7UZm/UMv3G
	G1VZXjPPftyjP1lD+YRRpZ6Bm0sc8SGnn/at+a0RMQb+2zVDmZEz88B6+cCgze4y
	sEmQeMeX2nzkq91d47NWteFmNZGBk5neL/ybVFfsTIyKXdwy4/ewdKWtrpKDTIZv
	LCcWTqXJ7SOBu8lQiThAWnbWuRKCVEUHFDJaHrP0jQs6zzN8SVBLFS2kZ9QxoJ2P
	AQdR+zGhdrLZa7+t5QqvUsX16N4ExE7w/xTIeTgO2UZjCsFOP86Pseh/Pz9qgpAx
	J5MpJyfX3KRf/vzwK3IAxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755937412; x=
	1756023812; bh=AO6fbziTgB3dkS8SW5GrOzTQHRzRJCUxs5LRAeMbYgk=; b=F
	FjFRmAduBKHLEFLpKhTuMZY8rkAzFtNqMAIWf9c5u31AMNgCa0MsK9gW2/cQmiT+
	TbDV/wUtSjNzXRTu1GW8AD9bC2/X74JQZ7pD7NpQaNU3gM+GjrSyg38pZWQHWg5F
	lepwKB3V+uBIu/F7RvIUZlJOecgORWT8pIWT9We2pZqXGLp51ZdE99Ay/lXZUC1a
	oYEsCP7R0hl/5fnFdI8vbuGsE5PPru8JfsnTIgStBdLRoAhmhSxeWwiFZ7iq9Uuj
	wByCHkRuomyY5XE1sNh5V0d03CnrgoYTE+LQLbE6GgLP6I2aq+lRegHbso2ePUG7
	NtmYVW+D5bgYhVmF50QSw==
X-ME-Sender: <xms:hHqpaNHJUUOONW_3pyaM5Upxr2Ll3Xt4amYzjAB8USO2Rny8ntwfF8U>
    <xme:hHqpaCXQxrfGg0BR8Jn6VA8RIDeDY-z7FVb8IzMHs070R0jxnlH5Q6m5hL9o7aF2e
    NOye8qfRCyEuk2XlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeiudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveej
    gfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnh
    grshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegtohguvgeskhhh
    rghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hHqpaKNfDsR1FZgFFEyjwW-ZMW7sXZOroBNAImFYjTGch0QWQmbKgg>
    <xmx:hHqpaCZgkJWG0NgfKThV8k4eb8_X11kQk05acZWZ4TqFU0DalCOBpg>
    <xmx:hHqpaA1ieUrzGMISvSxVv4tFsP86OqYulkTjx2nd2vTjkaT4Fpbx_Q>
    <xmx:hHqpaAeBrfVFv8gfPvp4miK9TU5tyaG9kmA7pUqBGg2J6fdLjXH6iw>
    <xmx:hHqpaKeHGc32cN35Uv1ift9PZXapP8uRfhh18A5Y3v095Ee1G1Yf0qnL>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 100C71EA0066; Sat, 23 Aug 2025 04:23:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Abor0eZdrBxZ
Date: Sat, 23 Aug 2025 10:23:11 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Emily Shaffer" <nasamuffin@google.com>
Message-Id: <2289e675-47b0-4cd1-aeb2-53664597e0f7@app.fastmail.com>
In-Reply-To: <xmqq5xeosgm3.fsf@gitster.g>
References: <20210723175950.64955-1-felipe.contreras@gmail.com>
 <52a6177e706d8653251c61bc660f10b703ea6a9e.1755256099.git.code@khaugsbakk.name>
 <xmqq5xeosgm3.fsf@gitster.g>
Subject: Re: [PATCH v2] bugreport: use quoted line prefixes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025, at 18:18, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Quoted line prefixes make it easier to distinguish between the questi=
ons
>> and the answers, both for the reporter and for the readers.
>
> This may improve things a bit, but the #1 thing that made the
> reports most hard to read for me, while reading bugreport output
> posted here over time, is lack of a blank line between each question
> and its answer (and the tail end of an answer and the beginning of
> the next question).

I=E2=80=99ve added this in the [v3].

[v3]: <3d00cdbe8535fda8f9e72b5243090e6d953c133e.1755866791.git.code@khau=
gsbakk.name>

>> -"Thank you for filling out a Git bug report!\n"
>> -"Please answer the following questions to help us understand your is=
sue.\n"
>> +"> Thank you for filling out a Git bug report!\n"
>> +"> Please answer the following questions to help us understand your =
issue.\n"
>>  "\n"
>
> I do not see a need to quote the above.  Nobody will write in this
> space between the above introductory text and the first question
> below.

I agree.  This has been changed as well in v3.

>
>> -"What did you do before the bug happened? (Steps to reproduce your i=
ssue)\n"
>> +"> What did you do before the bug happened? (Steps to reproduce your=
 issue)\n"
>>  "\n"
> [snip]
