Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273914A0BC
	for <git@vger.kernel.org>; Wed, 14 May 2025 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747190412; cv=none; b=kP2LG/Ax3867iPzYfJTZaJEiE8DDSGmKZt3AUjwNuvYjKcB47kuGKFoAPUDQW/anHAlo75A2/ZuSRI4Lw/x6QzDKG77jO4R6qQcYVVvBnsRrZ7uxhewNRUpDkXcwX7ap7uwL7UwAQkPt6FDDv/ISQC5W0melWmzhAsZ3wNaUVhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747190412; c=relaxed/simple;
	bh=McuVna2XOPpvd6RtO/gUxWhMzoM4Rfh76Y/PLLq0+4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFFIF07btGTExFd9LWGPmzNIZ+XIbf0avplPav1NwpIBngSK6Kk7zL79gmhQAldIz1RC5wdIM46my6SIZyB10raUe052hI1OE7ixsmycFOjYZGbOEH+4TOMvvqARozZ5FbiXwQIWhJIzSEQq/+VWfFGGLMA2C6XR8WKNk+fyUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wWsRCaly; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A8bTgn+Z; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wWsRCaly";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A8bTgn+Z"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C76C13801ED;
	Tue, 13 May 2025 22:40:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 May 2025 22:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747190408; x=1747276808; bh=Tmck/gBZaK
	D++uDcLb+L2PVczzt/4MkxiCtGAYIcU7A=; b=wWsRCalyeunATvht7tif5JxwK1
	nTrwMT5riN8KEX+jByDeZ9eDG+EgyM29z9WdMNLOFxH8wkJhDFrxFMcxE+ZC8yZk
	u2JN/YTjuoaYxs7M2gBdYE2A+kFxxlhaxscyxl/2UYaFZVt9aRy7vQUSLc9ASfXk
	zET58dFfQyamWqSJ6xLwVKUdxX0nY37LcWzZqbB7MoUrtaycScWpxDeFLf5+jq9G
	jPsgmscgX9cQ/s/09bI4pN9EGuLa+rujkkSe55oLs4HAS8br1tcB/w4xuwPLl4JF
	/mDLO0P5uqWPA6jxOm0qW2cJGdsS+dOrPwW68Oq4jsThdIR0+jThQSPwSFDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747190408; x=1747276808; bh=Tmck/gBZaKD++uDcLb+L2PVczzt/4MkxiCt
	GAYIcU7A=; b=A8bTgn+Zp1j9kR0yaN+VPigoC9NW3klPG2M+HVTRlwXfwElcqCO
	9kIHoUq0l/v7cArU/toF9vhFcCYYn5tnlLpUh2Yp/VD9r4ifE6MNNo4bwU+bhr0x
	2RnABx/u/s0weSWB6xbHVb4M3QYfGbLyQfsGx9RM7sGgoWwYK7ftvzbu0aDZeh84
	8M15ev6yHzPrzOWTHONAjcRVsTj/N8TUYLQZVJY2fk88+ZVtxceuHM6drR3mxPcv
	r9uGplWL7PpuDi6k8nArXwD/0tRiIcDYOx3V0bnefn+oUZrPfhiicQLicciJv5MY
	zHNm2QjoNTHqzWdas6vWrt7KNJK1ZpkBiPg==
X-ME-Sender: <xms:iAIkaF8zyGM8iroHaUhxBhYhDMLvgmB-jyj5v_Q7-2DXm5PmL-xpxg>
    <xme:iAIkaJtV71-7B1dBMyQeEqMX0g9_oBk2JfMOOvUATgkMzNs-qJARjSN4-qaFWD0yl
    _fGrf2Hz7Q5kpJ9yg>
X-ME-Received: <xmr:iAIkaDANFSwnf52W4dFXilFYnK0VIbeFrT6KYd_E7AfpUOj7qy2RoDd5cvxbPH8QtJjRxQP6wnjfIBaELoGaQsKy5_fOBRYAhmQd94D36uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdehkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iAIkaJcp87teAGUIDYow3ncNOwRrPkUhHbjhch8P4gwQlbeITIE1ow>
    <xmx:iAIkaKMjXgPI6JsvK-j54-tu5akrJSmyV6-FuwTB9sz4kTbVU7gPhw>
    <xmx:iAIkaLk6RLj2JUx6AcL3SQqvn2Mozd9_WM5uunSexURbfTUSZEs_zA>
    <xmx:iAIkaEvI-MQfog8p2Qmx0Zbln2QaN0DgBW6cfdC5wBW6XywaUvhJsg>
    <xmx:iAIkaO7JoiEYOX2vrhdGOZa5DU5D6mq-lCH-bQgWJssukrDyC8ChfU7h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 22:40:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fc37d956 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 02:40:05 +0000 (UTC)
Date: Wed, 14 May 2025 04:40:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [GSoC PATCH v2 2/2] json-writer: describe the usage of jw_*
 functions
Message-ID: <aCQChKpJRD8zntBS@pks.im>
References: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
 <20250512020935.73140-3-lucasseikioshiro@gmail.com>
 <CAOLa=ZQooC0TsjGG109MY_njoTm5GjW-WNf7-L2W6BN8umRL2Q@mail.gmail.com>
 <F862E606-C784-433C-BAB1-283C678E20D5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F862E606-C784-433C-BAB1-283C678E20D5@gmail.com>

On Tue, May 13, 2025 at 07:22:26PM -0300, Lucas Seiki Oshiro wrote:
> > Overall this looks good, but I do have to wonder if it is needed given
> > that your previous patch already has documentation for each function.
> 
> Agreed, it looks like too much information. This second patch was
> created after the review of v1, and to be honest, I think that this
> overview is more clear as it focus in the what we want (write a JSON)
> instead of documenting each function.
> 
> So, if I need to choose one of them, I'll choose this.
> 
> > But I'll leave that decision to you.
> 
> Ok, I'll keep the second!

I think that both are useful. It's a common pattern to provide a
high-level overview of how a certain subsystem is being used, but to
also document how respective functions work. The former is useful to get
a general understanding, whereas the latter is useful to get a better
understanding of specific edge cases and how for example error handling
works.

Patrick
