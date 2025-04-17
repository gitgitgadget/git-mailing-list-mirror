Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD446205E2F
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744920824; cv=none; b=EvY6Yr+s8XJrJ/fB8vW+T4Awy3kTamYQ1MoyqybemKL5goILLlmUapchc9pEQ9f/LWhS9hE04fW0VxcRRUg///F8AtcdNinMXtRS5bolUyMzqhRFAEUOjglEqZ8o/tNtor8KyqUr2mm4VhLjE5OkFrxZn7fMxjOCLCGSpsje1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744920824; c=relaxed/simple;
	bh=5xW9HDFVR+sunft4cB9xo0Vqh6TokYVUj7OfgFKLMpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c6dE6ckq1cMEo400mTb7j+ctiuM7V2sxzuPK1RRRcXJA8GsaOEL6YHYdyKD5GT/QohQVyIUu47CYxoeU2xGTxj/iSu3wOW6y9bOQkKpocYEn9A7lzj7D3DW6t9puXKTwzukNTncLzxbW/Dsqvdiuo+IifXP6FLw0K9UW2e1kghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nAaOwqV0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fSQi4jGE; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nAaOwqV0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fSQi4jGE"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E01072540101;
	Thu, 17 Apr 2025 16:13:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 17 Apr 2025 16:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744920820; x=1745007220; bh=511v/MG3rW
	tjfcltoKewIxJ8kcUVWNZhJ95pw+jfs+w=; b=nAaOwqV0FzFqUjMUVwzBsIKYS2
	/0pcfQStDnHFnyn49weJv1jSET5YweqWbE6ivqVZiznivNiQ+TyNNYny9Iqhghhz
	NZNzziOgNPOyS47iJ6xkthtKIsTHt/aR0x9TDWJH3C/y0Rnule2qq5m4F5y5nqn/
	XtiJSJndS2QAUCy3dJLspEpsVkBW8eCgZxWErVTLGdeeIrTsv6JMQavwPfEy7g27
	2EjAJlrNsxPMMxm4TP9cO68cxV9eItJI1q9HuDftuaL7C4Bl+eiyB8dZy55q+P1F
	O/C1H6NQmqsYpdLRZcIxF4eMrlyTKqGV1yishZb4VnFTFcbfWT0KZoTzn4TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744920820; x=1745007220; bh=511v/MG3rWtjfcltoKewIxJ8kcUVWNZhJ95
	pw+jfs+w=; b=fSQi4jGEi3nVw7IZepoAg91U75Hz1rXqnPShzTsCH/fAIQxJJFy
	SxKCn9hnsSn8qX5lK7aDx3MUhP8ky4y3JySALNKtXoHfi0PUBbPX5fi67RiHeiHu
	ol7c4CVDDs6pBrtPM5llYknEz+7FUMQVS8u3z9x8mG0eNkTVFX7J1KJQ/VYCksVY
	byJnFRITJMMwujudELRgYQxDsaRivSsnmRtz3KMMrJdE/TpeOVgfdtHwJj3fPyZY
	Fjt9raqQnriFRymiPbzufU65W2+S2GEVrObLPSAwSZe5SBHALCMpVESkzhfnkSLG
	hIJDJYsp38pHIL7nCM+6my2CVEwrd9eG5pQ==
X-ME-Sender: <xms:9GABaKk6kjHsKloLNbvGfYt-4O8dVU6OAYZStHMEB9EyLNrezlKFyw>
    <xme:9GABaB3suGUYzZf-8tWHxi6Uctmcau0foQSjM4ns9UXVSSMqJLSNX1lOBRvDtJfAB
    aB7BNIZqy2jL4yYVA>
X-ME-Received: <xmr:9GABaIru-jva2IulQPE21o7Iszd2zPDauX8UInQExUAQGpvtqBGvkLuXZDJ8Gen0rnl8NV_L7n7qQPoyMrXSdYc3bZpmnL1NFgY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:9GABaOn4QtQ0VaFiMULahsLM7JCrNgFt-it8tTv4Rj0TFyBWEpcGPg>
    <xmx:9GABaI0VNU1AC0C_j7m9IIEH39O_uzh_09iho04dAWC_DbZYVpT07A>
    <xmx:9GABaFt32TVIDF6O4p12PsW741yB8_l52ndrg4OK3J6czW-hIzDaiQ>
    <xmx:9GABaEUlVbO3Q3WDd163MOxaBGvjvBWYZMJKc-AD6KiAEOfqZjhUrA>
    <xmx:9GABaMggYsISy0sqqAE3hUKeDzTWrLreFTZ8lkGVyi6W5L0sNpn9UfGy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 16:13:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH v3 13/13] config.mak.uname: set CSPRNG_METHOD to
 getrandom on Linux
In-Reply-To: <aee15694-6a15-4409-9854-dad5f511dc48@ramsayjones.plus.com>
	(Ramsay Jones's message of "Thu, 17 Apr 2025 19:27:43 +0100")
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
	<20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
	<20250416231835.2492562-14-ramsay@ramsayjones.plus.com>
	<xmqq4iymgadz.fsf@gitster.g>
	<aee15694-6a15-4409-9854-dad5f511dc48@ramsayjones.plus.com>
Date: Thu, 17 Apr 2025 13:13:38 -0700
Message-ID: <xmqqr01qeebx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 17/04/2025 14:55, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> [snip]
>>> The arc4random routines (ar4random_buf() is the one actually used) were
>> 
>> arc4random_buf(), if I am not mistaken?
>
> Oops, yes ... an unfortunate tyop! ;)
>
> Do you want a v4? (The cygwin v3 'make test' has been running for under
> two hours, I could Ctrl-C it ...)

Nah, if you send one I will replace my copy with it, but in the
meantime I'll locally make a typofix myself to v3.

Thanks.
