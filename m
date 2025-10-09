Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B5173
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759987783; cv=none; b=M08VfJAv7sGuFOhz2yT7/sCc978uMCfoZcHdq7N+cdGQkYaWBeS3vVA+7LvgPUjWu5kLZjHDpQGxrMehosqSvU3uCZuBrlsiHx/+CZkgV4aKoP/aDiZYYqRciVQV3EBzaS+o9V/+K+XTxEeZE772y1W7RgnQ8VYJIOtoYhSSbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759987783; c=relaxed/simple;
	bh=KhCq5mpbYx858UGjTmi/ewFY+OhxFlUTVIexbkPT74g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvJ9Mb++ZQBWQTCc3Jpxf4bLGTZ3ZOFlFmKX7vke8fZLKJB75ySmxadorfPBujBoQjHF58BQv1vJjfpIyw2FQ604HmHZtBK1ce/jNrv+2oFMdBet6+uKQ1y0fgqAhghBHGfzYBijElyPshrq9ylcZ4pl6aQqGnbklf/2C5iSqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MgrBRREg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vd8u7J0t; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MgrBRREg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vd8u7J0t"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 779D71400079;
	Thu,  9 Oct 2025 01:29:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 01:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759987780; x=1760074180; bh=2Fg+E7u1Fi
	+8nGnUkpo2Cg15cK7qV6Wzyv4rM88NyZM=; b=MgrBRREg3X5i3Mfv8LrmfRCyCc
	18cecyAYitAsr1txHpauM/764ZiQj1JGhrShF24617+b29tZCMEFSNpWBVCyGTq0
	zXkMmLlX6VsLmzzxyjgDWe0ixheon698bsCUlFN9XSVI2OIsWXmMYzJ0ur+YZs59
	DwHpLlFnlX5RUeQ4Kis9Q1EWe+lGMfLyJ6c53zDUs1SfR/QY+ySGD8qH6F/czBC6
	HI3tBhOOfHfPYO25cNuxVCeqW37lF5i/NRkZdZzNucBUbafrOtZddt84Ql9K/iFb
	c1ea6iV7j9hfIs8MKqUuSTYTJ8cNAHot6yrVM67lZaqC4PWtv/lB6y6UTWqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759987780; x=1760074180; bh=2Fg+E7u1Fi+8nGnUkpo2Cg15cK7qV6Wzyv4
	rM88NyZM=; b=Vd8u7J0tUKSXKcboCaC4t9J39n06aVSt03DlcMg2Bb6EZKZO06c
	F76InR35wOtOANlHZnb+nJM2cfmffl2MRLGQ7E4IzGyTTw+DFVUl4Z9Dyj5A+yAJ
	rJoPJV7Ajng6eVO1B9TG101F32DLEAhlnQjd/NMNIUqsDJlARnet5Co860RpR07F
	hbZi+nAAKguvjVDOXEcWvOX1lvkqiNlsjhlPnn83T8pcBK6YeZ1l86/8+ZByICtX
	US9sFdaA1v27xQZKqDhRCOlKcQK4/pVPAsbO49zMud2QH28iShc+O3AZvx+35dbm
	LuwF3Vs7E+uIVaKw+OyYYK0kxf9EByZO6nw==
X-ME-Sender: <xms:REjnaGGL5SDo0nUScl1JwfM7_S3djMlEXhHhhh9ERnNl5ICBwBLpSA>
    <xme:REjnaLC_0s_Z4ittfWymArJEbu9ErxJ89ciB7fqPqH4zMeY7qy6GwcL_Z671dQI06
    KYyrR7B5J050SpMVAmpeHss1Rnh04UW5IFfo5htlv0ZZjKatXULKA>
X-ME-Received: <xmr:REjnaJ8Y93O2WJeGxQqlkEQ_QVCC_7J5KlUAbEobLN5WczDjW2zWZaqxtG6L0RhYlz25KoToDUl4OJzjTwsCb77L2xxKgpf3njZtUQ1WfWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstg
    hhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepvghrihgtshhunhhshhhinhgv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:REjnaHDF1dgt9KHgLf2gHcrLBoWvQFtWNxfPYrwzqdyPYdapzbxEUg>
    <xmx:REjnaOR_HexfCilaGFWTwxkg_PPzik_6--zlO1O0zHN4ysQpuOpQSw>
    <xmx:REjnaOtq1jZexdeyfVwkEd23iGUHoHsNm_NPcPI_jcuG1X3o14KfbA>
    <xmx:REjnaK0eB2ZxcPc5WODxDAEo-aoxmuf-8GGkynzU7n66Eer3xNTT7w>
    <xmx:REjnaDHWQw-GLm14G_fUQj3Bvb_-ZfsRxNnZf-4vYxzNcuxnLhhqgYZd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 01:29:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5a96816 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 05:29:37 +0000 (UTC)
Date: Thu, 9 Oct 2025 07:29:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <ericsunshine@gmail.com>, git@vger.kernel.org,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
Message-ID: <aOdIPjE2iTpN6L7q@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
 <CAPig+cQ7xJky+F=g=NMrN6BQfP+ZV2KF4RF2eLqtULKgMTR5_g@mail.gmail.com>
 <aOWXSO5GInJI8-NZ@fruit.crustytoothpaste.net>
 <aOXsjnWBOt0qFGwc@pks.im>
 <xmqqms61h0g1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms61h0g1.fsf@gitster.g>

On Wed, Oct 08, 2025 at 08:34:22AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> ... but I also think we should take this
> >> opportunity to choose the Rust defaults for Rust.  C, Perl, and text
> >> formats like AsciiDoc do not have rigid defaults about indentation
> >> style, tabs vs. spaces, and line length; Rust does.  We wouldn't use
> >> tabs in Rust (the default is four spaces) because we use it everywhere
> >> else, so I think we should take the opportunity to use the Rust defaults
> >> here as well.
> >
> > I am also slightly leaning into the direction of sticking with Rust's
> > default of 100 characters. It's not substantially more than 80, should
> > be reasonable to accommodate for in most modern setups, and sticks with
> > what the remainder of the ecosystem is doing.
> >
> > So for now I'll leave it at 80 characters. But I don't feel strongly
> > about this, so if there is a majority in favor of 80 characters I'm
> > happy to adjust.
> 
> So the question is if we want consistency across files regardless of
> what language they are written in (i.e. 80-columns everywhere) or we
> treat our existing rules a "fallback rules" we have adopted while
> dealing with languages without their own strict rules, and use the
> default for a language with its own rule (i.e. whatever rustfmt
> wants is used for Rust, our own rules still apply to everything
> else)?

Yeah, exactly.

> I actually am fine with the latter myself.

Okay.

> If people strongly prefer, I also can be talked into adopting
> slightly wider limit for our fallback rules for everything else, but
> that is probably a separate discussion.  It is a bit unfriendly move
> against folks with aging eyeballs like myself, though.

Yup, this feels like a separate question indeed.

Thanks!

Patrick
