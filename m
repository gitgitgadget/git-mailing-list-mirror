Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879D19F11B
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294529; cv=none; b=H09n/H1TZrLS21EQ00+YmYLaF4Ln3KmZolwj0dUd0cNnZitN2Hci5y9TiTUzJtfojbWzJVfAnGKjOkRAzSEdBRqlUIYN9CwcN4ZGbyn9G1a3on9IgV/Gwgj8Fm29qh7Xq3QL5zIJoxQdwdo+japxnYfDBwFzXEMfByFKcqBbw6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294529; c=relaxed/simple;
	bh=hzb/EUNYAvwU5k98dHc3GHLz+x5MXsEAi9Ca/w5SiAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sIb0xC/exzWY3sAAYprxEQe/fGEMGWXzVX4PjVLaOASiAHpAOkBcWjprcAkN7Ao9QwH/2e4dEjJ/MI2TIrJonYQIIrbqhePDnBCEX5G9SXsJrqBiPrif740LlHvZtDsuxMolhNCC0tXn38N5GY1x/2cxUnPU1oELPgm0qqVy00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jiSp6M1a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=doA5FLda; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jiSp6M1a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="doA5FLda"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 714BCEC01EC;
	Fri, 15 Aug 2025 17:48:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 15 Aug 2025 17:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755294526;
	 x=1755380926; bh=sA/xNuk7vx0PTCs11uCGMLhoxtK/Q4jtvDcmYmcSma4=; b=
	jiSp6M1aYDfkg/MIgQo+9/ZTFQKUX8u+gb9o7QGJkhDonLaYNDUlr0awOExlr+z+
	A2DJoe/aG0+LY7CJxE4YhFLE73IcRxIIdpi+SQKOyUgBoYLfcZv+lJlCi3wTFAbl
	W2jpXWivvxFC4G4MMAlHe29zwnEacJTgWz/El1EcC7y0nUv+Atk/uZxtD1QzYlkq
	N2RlDC0lfUNguFGmaT9tECG1m1ACRD8RqDRyZdS1lWpb+8bc9hI4iP77EkP8VSmq
	AeIX5gvgoCtnN0tQsl63GLdP0mNQzQXfRWg7AjG6oDYJUMP6U10jPqTf5oeIXEuY
	4RP21nTc6Kb7haoZLttxbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755294526; x=
	1755380926; bh=sA/xNuk7vx0PTCs11uCGMLhoxtK/Q4jtvDcmYmcSma4=; b=d
	oA5FLdaqHMzKCqGerrZu3vmPPIVr0L6zlxl36jTLXYc2OD4drLof4iJKAEVeeNN/
	Z73ayNOmrKY8tn+cm0kNWocyFx1pLNtkx3f+C7nIFaRSgNvTB1qfqA/EAWhwjYvI
	zwmEU97j/Ac7d+K1nZ6nu5Y4wqBSXoCYiKUyusITqjpt+/wYmx4JrakhFLV9sZJN
	qj7BbaLoXbq6IbUjpAwy4mAGBh7bKib4i3SZWiNsfxZfxdmNPvTRCtiuqVluHEHr
	hUd6Jp+tCr1SuZEui7C8/5l8ClZE8x5nCt/VCbOGyA847uw6Y157OVQaZEV3uRxV
	bXXmCmlBGALmUqwGRH0ZQ==
X-ME-Sender: <xms:PaufaL0AEfKv70_ZHmCj-8uCsV5cMRaiI5qnAW2exWMR5KolBWz1FQ>
    <xme:PaufaPk9wjaI3xjFSNFZsdzM9Qjh-dfodxVbgz-6533ydEa25MYNPhwVuoqMpzS6B
    3bpKGbkAN2gr6G6sA>
X-ME-Received: <xmr:PaufaEOwCEZcxZzMw5friCwCqC4t3_nT192XmSIFdWCyeRIzy-126VTTkd56RGgTCbCYVoHSqOKbYN4lCj1bBTWvNGzTb7yK8rv7EiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefggeeuuefhhfejieeigefgieevleelueffueduvdeuhfejueeugfefjeel
    ffeiieenucffohhmrghinhepmhhitghrohhsohhfthdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhhrgduleelfeeslhhivhgvrdguvgdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihht
    rdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:PaufaO79idOTtLAOFWi2iBR2ROZYL-thLV-KWA35WpNaBjBna_Q7ew>
    <xmx:PaufaP2oQ4tz6yKlcFTKyQEc-5DAtnW2QRZnLf3ceJml_P9UAQncMA>
    <xmx:PaufaEpLhFpOq42twGnJHldXYlLsECx-iKJFqLD6GfehdAsr6WbHVQ>
    <xmx:PaufaBnoEw9xtha_1bodyxMabhOIiuj1CkRFO-RRXBtBs-fR2WriJg>
    <xmx:PqufaFF74U9WIsctMDxBt0SaM8MBmlB9sS5J7CPqJJS4-lOeZT0GcBMe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 17:48:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Taylor Blau <me@ttaylorr.com>,
  Christian Brabandt <cb@256bit.org>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,
  "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Sam James
 <sam@gentoo.org>,  Collin Funk <collin.funk1@gmail.com>,  Mike Hommey
 <mh@glandium.org>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 09/17] Do support Windows again after requiring Rust
In-Reply-To: <DB9P250MB0692900F30A3E71E4F01DFFFA534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
	("Matthias =?utf-8?Q?A=C3=9Fhauer=22's?= message of "Fri, 15 Aug 2025
 19:12:56 +0200")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<96041a10d545e0e431d05b93544771c6bdfc06f1.1755220973.git.gitgitgadget@gmail.com>
	<DB9P250MB0692900F30A3E71E4F01DFFFA534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Date: Fri, 15 Aug 2025 14:48:43 -0700
Message-ID: <xmqq349sntms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Matthias Aßhauer <mha1993@live.de> writes:

>>         ifeq (MINGW64,$(MSYSTEM))
>> 		prefix = /mingw64
>> 		HOST_CPU = x86_64
>> 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
>> +		CARGO_BUILD_TARGET = x86_64-pc-windows-gnu
>
> I've said it when Johannes originally sent this patch[1], but it bears
> repeating: The *-pc-windows-gnu targets will pass CI, but would mean
> raising the required Windows version from 8.1 to 10. We'd want to use
> the *-win7-windows-gnu targets[2] to keep Windows 8.1 supported.

It seems that Dscho did not respond on the list to your initial
objection in the discussion you cited.

I do not think we spell out which releases of various platforms are
still supported by us (we do list requirements for platforms in the
Platform Support Policy document, though), but in general we should
not be attempting to give extended support to systems that the
vendor no longer supports.  As Windows 8.1 is no longer supported by
Microsoft since Jan 2023, and Windows 10 will go out of support in a
few month after Oct 2025, if I am reading the table correctly, so as
long as we document our intention of dropping a commercial system
that is no longer supported by its vender clearly, I do not mind the
above that discards 8.1 [*].

But I may be biased, as I do not live in the Microsoft ecosystem.


* https://learn.microsoft.com/en-us/lifecycle/products/windows-81
* https://learn.microsoft.com/en-us/lifecycle/products/windows-10-home-and-pro
* https://learn.microsoft.com/en-us/lifecycle/products/windows-10-enterprise-and-education
