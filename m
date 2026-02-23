Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6D36997D
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878141; cv=none; b=u6CXWJ5cxwBXvs5hn7vWl7NQDYkvQvOcDmg30X1Ml23xkKwxWTJtO1f94PZRUDMAdXL3/OyTRXTyP+nVch1FofdDhrD6Sf41uIliPE3mtyw1PbLbs0YE3Tpvvc4oqDdqh1UWNHIFAT3j9xaIMtgx1JbLosmsx5eWXn+Ibufo7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878141; c=relaxed/simple;
	bh=nAXKUoAnuHzr268X/V7dJ+CMtbVDAdNEOkRiMnJfeYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LSmLHPFfnQOcdqMKU1W/mocCmWtVAV7sYlX4tmOlFeqLTd/xIYnUSmy+NXvQqR6k+1AeuQdtxde3r8miJj2J2W0HMcNpB3FM4sKOkn/rmg7v4UT39f3KjR776A+saHsVT9FTRIzz4yVXH90hwcW2+9hm4WwDN0UlYm4smJu4lWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oh87QfSE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h2dnRPz6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oh87QfSE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h2dnRPz6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 91AC314001D0;
	Mon, 23 Feb 2026 15:22:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 15:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771878139;
	 x=1771964539; bh=41YHiMvkemgnuYK/cpnLyL38ZstRNMy56gMoH3b02zg=; b=
	Oh87QfSEzsNh22OjVftq73DphZeUGQ7RClATqUl1+vUleDbgOJkMZ1tQ7fN/qUNA
	4BCb4ckBgvBalLKqc3cXHXE3lDe13AKXb1KZAMv2ZavOYVLpaCpPdmA5wC5RxQSd
	qYF7ycqebbAd5h8ZqJo/7voF2BXyhKa0fdp7OeEBMYebBPxUOOZNeB05jDbHJi5i
	21K6JOgwT63QOxt1tK9+Mb5w3aWnwF+KK54BFYy5lZ2+7Q5QqjovXZhwuNvrAHEj
	jHhckm9xNpdOuz4G9C8tmwm2Ncl5+S6LHXBV4nuoSfcO7mmmzSxu/lA/7u9NyS/r
	Dd/O3CCjuKw2ASHlm3kDGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771878139; x=
	1771964539; bh=41YHiMvkemgnuYK/cpnLyL38ZstRNMy56gMoH3b02zg=; b=h
	2dnRPz6UPMeF6fe4tkgVCS22JmkYs29RQkRGSe1cxlPzRdYn6GU7//RoBBXobg62
	SLf9O5AxA8sWegtVAMOVnIXKKbqwgkVSbZzl+JJIQpmdgN/R17fRtMkFsluBhUQs
	O+apfyPhcDs++M4tIl8GtCxlUzsHSkEKdDVA8kYx374YTg8rcXtNwqcrlWplFoAI
	ZO9bjGW2dpopv2PnmwxZt2Mmn4AcNfygzRc0jo8HgqKIFIeqwK7MHtdlO6ObRo9w
	zvhBt3pe5lRt2rmEkAmPAMce9m68GnEGx+rmIT7aE4uyRGkZ/mE/nctE+G47zoxx
	UAg+SIbfBCjcobt/pS3gA==
X-ME-Sender: <xms:-7acaRSuln4E5UhUNo_P1Gzi7ySdL18fMpUUFx7BECVW7XTf2MnlmQ>
    <xme:-7acadAazBdT1Ymy7JWj8LGV3-aVfVnybNGXDw-UdTvqnpihmiLctm3eeTfyWyScf
    mF2ackr7XNqnl4lC6ANaDHYZl0mxqIIn9OFTAsW_F2WD9NDWYwYclQ>
X-ME-Received: <xmr:-7acaZEmAoUxicIjuafIYEnouVBihKCABqzZb9chzOiwPsSPuwSeprf22ei23ZLQypRUlO5ql7GNex-T9H9kxOIUa7DoXWObsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhho
    nhgrthgrnhesjhhonhhtvghsrdhprghgvgdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopegsvghnkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-7acafAf7Gq1iid8wZGskr4biS1UdUs1tp_LFzjYfPZiAnokDEpMsQ>
    <xmx:-7acaZUNMIRUmhEPeYKKGI4yttHEwRDhOIX0unsfbNBV9G7G_f6Oag>
    <xmx:-7acaToGU4JCnZmtjU9aVNYpJ5b5URQYGqyutcji7ag3FeV-pYy1cg>
    <xmx:-7acaVQeRJLRyogmzMmJBYxI_53YRsalr_EzaIzOQTVBNfRwvwTaqw>
    <xmx:-7acaWXncQ0p6RzP82IB6Tmx0chEon25TzZsQvdNS93r-gHYlwvTv12c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 15:22:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Jonatan Holmgren" <jonatan@jontes.page>,  git@vger.kernel.org,  "Jeff
 King" <peff@peff.net>,  "D . Ben Knoble" <benknoble@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] alias: support non-alphanumeric names via
 subsection syntax
In-Reply-To: <6706edc2-04c7-4bd0-81ec-33710088f0bc@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 23 Feb 2026 17:07:10 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260210183110.1151072-1-jonatan@jontes.page>
	<20260210183110.1151072-3-jonatan@jontes.page>
	<112cccfd-ee04-4c23-bc5e-fd269ebc6c1f@app.fastmail.com>
	<6706edc2-04c7-4bd0-81ec-33710088f0bc@app.fastmail.com>
Date: Mon, 23 Feb 2026 12:22:17 -0800
Message-ID: <xmqqzf4zky6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Feb 23, 2026, at 10:29, Kristoffer Haugsbakk wrote:
>>>[snip]
>>
>> The HTML output shows the list continuation character (+).
>>
>>     + Note that the first word of an alias does not ...
>>
>>>  command. It can be a command-line option that will be passed into the
>>
>> And there are two more outside this context which I suspect are knock-ons?
>>
>>     + If the alias expansion is prefixed ..
>>
>>     ...
>>
>>     + * Shell commands will be executed ...
>>
>> See `Documentation/doc-diff master next`.
>>
>> • master: 7c02d39f (The 6th batch, 2026-02-20)
>> • next: 4a7958ca (Sync with 'master', 2026-02-20)
>>
>>> diff --git a/alias.c b/alias.c
>>>[snip]
>
> Sorry that I just replied to the first hit that I found in my
> inbox. This applies to the latest version which is in `next`.

And your fix is the [v7 5/4] <followup-alias-i18n.3e0@msgid.xyz>?

Thanks for being careful.
