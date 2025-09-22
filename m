Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78411E502
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 22:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581808; cv=none; b=LvH2FlYicr5xeJFmbBuKYswGYrng9M+L3JBX1K4s2J8BwBSsDyXcSrWyKhAGjsURxjPScPhg0130umIuOVododQMlZEXhiv1AXynxDB9qKPoFejcMrmVoNSk65Ok+t1xWv9Os3Hc0q/xKSOgD4YaaIte/O8SxEN7U/DngfylRkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581808; c=relaxed/simple;
	bh=yxVY+3WuxPmtpKFcjxP1enK5uolnMJpJ8PzkFT45gQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LyyKaq/NRqRGj3DtZn+vd8cAJZy5SKF+9f5pie6C31xkEwCP/HL/fPLhZ+X8Y0XMIX/MbOerh3j01ZleFhVaNm9DSJvDoSQTDf5EQGOwFuStO/7IHIOP3oYhBp0hyOVHDXdOvUbWu4NzCitT3dBP4yMB0uV7wQtZgZ2FT4qF5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gJMQUGwv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pjp9U0hE; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gJMQUGwv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pjp9U0hE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 598757A0043;
	Mon, 22 Sep 2025 18:56:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 22 Sep 2025 18:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758581805; x=1758668205; bh=DlO9jetaMw
	zT5NpGu56+1ijo858lBqadVRxTxVgt6oE=; b=gJMQUGwvtmGmek0HLU7S0Y6+NV
	a5XkGpbSj72hL3UmJOFkiqyIgks7VtZlvwaZ/Xu1gaSkfRF37F7ASgQIGfvkqf8f
	KbJk5fKlNMyEiUuurrJN88++egPsPr8UWnFjKZ3cGILSRcH57m+UGxkjQfRAv56k
	xOi3W0812uuyMJ2oUygWCl+5xqHwyYry1wqROQr7iqLw3jGej/0ii1J07uSvWXeX
	9Dq3SVNsK9wEA57ZpIlIN1L58UN2bmAqiuNKRvKrXCXUS+8KHFWpaJqVhx75Blf1
	wKpg+EYhGF+e+B3mPcKShlouz06JQIyQ7FZJ4WZVeiJlLRuxSv9eYmbCjq9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758581805; x=1758668205; bh=DlO9jetaMwzT5NpGu56+1ijo858lBqadVRx
	TxVgt6oE=; b=Pjp9U0hEXx/YkZ5WZKA8TbU9h/EU5PK+VaiDlE+bQ+KwQ09Ru9x
	JgHNk7cnGfi3D3Yumofo04EBrXPRHTeDSE8ybCvUD3o5toBlnEGWJVxxRHhwffrR
	y2XUK6whLRe7i8J06HQ6JRPNKbWAtDWVHnLMjRkebzNkJxILyG4Mixfra1JAECZx
	wbKd4oyCwlN7fwL1qmVhHjqMtaYu1cwCTy8XbPUlmMGbQWeWQ1bAu+8y5Ya/UQlb
	cdmI+jyW1C9A2Hdc790IF8boJxfRE3OADO8PdCAs/EFo184uR+Haxg8MpVmFhBwP
	XkEQRr6586KxrdnBkT1VAjGJX3BcAvDHpiw==
X-ME-Sender: <xms:LNTRaIQZpfasg5pbEm_ecwHysFwjXWCfxd9i3UrhYo0HPJaszeSUMw>
    <xme:LNTRaCE_agSNKvia4nC0TOuI0WM9GHYnHnbRiT-iCHbJLybMa0LGbFEvT37sH4gKe
    DPErXWMBV8UsGT5ApP9xQ00cMq1KdAP1cd3QusAfpHM-29u8nQR>
X-ME-Received: <xmr:LNTRaHcpVuAlv4zYl7sIN4lhWpKQkA_jBe5X8QEcZoKXwAvgCpPmTwuHp3sWinlxpNe38f3epOeJ8Er7o9RnN2KsYdwrvX46RwPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehleduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedukedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhishdr
    mhgvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhllhhinhdrfhhunhhk
    udesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhooh
    drohhrgh
X-ME-Proxy: <xmx:LNTRaJJQ6aJxFrvXV_TLOA23jtT_xnvtg0zB-I-9MFKQ_5Dr7B-irQ>
    <xmx:LNTRaGoWNKG3YncS2KYyHT6-12yaeaUgEPKAqqTiQuNUAgXcnPFBGg>
    <xmx:LNTRaPWfrico1XdcAoPTU956a0k-8MUtI2OHjeHkCMwtsEcCOZXeFA>
    <xmx:LNTRaB3sq8G5mZpSg7nTUPOIKqSZlfUBaVp3nvedSHPdU0co0ifvTw>
    <xmx:LdTRaP-LE_ea2cKvzpE3QnazxPFCbhQHGXqtid7w0ZSiS_JC7Oy4hFSs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 18:56:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  Ben Knoble <ben.knoble@gmail.com>,  Christian
 Brabandt <cb@256bit.org>,  Collin Funk <collin.funk1@gmail.com>,  Eli
 Schwartz <eschwartz@gentoo.org>,  Elijah Newren <newren@gmail.com>,
  Ezekiel Newren <ezekielnewren@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Phillip Wood <phillip.wood123@gmail.com>,
  Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,  Sam James
 <sam@gentoo.org>,  Taylor Blau <me@ttaylorr.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
In-Reply-To: <aNHKdFkiGLPcLEjP@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 22 Sep 2025 22:15:16 +0000")
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
	<20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
	<aMsxhp6ZO2Cdz7+k@szeder.dev>
	<aMteF4VTq2C5sAhK@fruit.crustytoothpaste.net>
	<aNGkt/DdnbjNu3s8@szeder.dev> <xmqq348etd9n.fsf@gitster.g>
	<aNHKdFkiGLPcLEjP@fruit.crustytoothpaste.net>
Date: Mon, 22 Sep 2025 15:56:42 -0700
Message-ID: <xmqqplbiqeol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:


>> As I already said a few times (e.g. <xmqq8qipzhg3.fsf@gitster.g>), I
>> feel that the timeline hinted by any of these documents that were
>> proposed is way too aggressive for affected people to practically
>> prepare for.
>
> I don't think it's substantially more aggressive than the
> interoperability code.  Both are aggressive timelines, but getting LLVM
> ported to some of the affected targets isn't out of the question
> (especially since older versions of it supported some of those targets)
> and once that's done, I'm pretty sure Rust upstream would be on board
> with supporting those systems.

Our timeline being agressive to cause more intense work on our
people is one thing.  It does not make much sense to me to compare
it with the timeline being aggressive to others who do not control
our timeline.

Putting it in another way, I'd call it hopelessly optimistic to
expect that those currently without Rust can somehow come up with a
plan to help their vendors (or they may be vendors themselves, then
convince their management) prepare their platforms to support Rust
within 18 months.  And giving them ultimatum based on the optimism
was never my favorite part of this whole thing.


>> [Footnote]
>> 
>> * By the way, I _think_ I never saw that policy document until
>>   Ezekiel started his topic and sent it out as one of the component
>>   patches; how did it get there from brian to Ezekiel's topic?
>
> I had it in a branch of mine that I was going to submit at some point
> and I mentioned it to Ezekiel, who modified it and incorporated it.  The
> original branch should be `rust` on my remote for those who are
> interested.

I figured that something like that happened.  I was mostly
interested in how firm those original authors supported the version
with Ezekiel's changes, as outsides would not be able to telll how
extensive the change were.

Thanks.
