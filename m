Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3151F3D902F
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343280; cv=none; b=eCP40utBmfAMyzfiLr0Eao4Ok5Pqgfl3wN69stn/SWpeApZdwFctbFK4p8irEOS2w4lfBoOodUJJrKKEtoW8Svc0tbF8FoxHmkk23KUf5zF7GqJmxVFLsKfnxcgQ4dmZKeM7OY9Nns6qoeG9Ao/wICd7R/8PMrXGswlLlNmnRII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343280; c=relaxed/simple;
	bh=zLps3VSqD6PED/NzyvlpAPrugJ43fC8sRQt0F7lPPFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT46PrPPghvXJcdFA6pw5gjYKif1s5RKTQAD6eqeKtBBQusCM1h6hRcexMBVjwbMarnqtkXSXA743iEd1SyOHW/+A5O7mXNxvaK/UjXaW0nkovefJZg2v8v+fZUuyiBUuMcegWGiTeuO78wW9fV9gatlQ+EVt4s4IroDSKaxcAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SMZXpd8x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5f0xxZgm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SMZXpd8x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5f0xxZgm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F0FD1400213;
	Tue, 24 Mar 2026 05:07:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Mar 2026 05:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774343278; x=1774429678; bh=DfQEtXpjqa
	TI6zmzr21q7XGfBzEUiWow7cWYPHuCYmk=; b=SMZXpd8xRcQCC+2EpUKWCEkB7l
	OzvcJghako8uc5ryh4lkYBPaRgQsddVxnthircvz4g99OhO2MvwmGar8vg9mSFQ2
	Ri1ae45tcieVSqLArp2uHGT5Oom4YXXZsaiig6TZ/hhgoE6KN6t/dt1PPEft2TA7
	NI2TAgDLciOx+XAKqBbkFbZ69BvAFUs/ozVumCSsKZQZkf0GnVArDSPTFWQfrn1S
	XPG3OinjKjqVvBJWHvix23nbak7EiJ1eYDLPxhfei7tSTmquUUZ6eMi8RETK2/Oc
	6NE1pGX+Gf1VGjRadbhbzproUY36QrGZ6AJ06LdDVcCIJLY9/mpxcn4hH6Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774343278; x=1774429678; bh=DfQEtXpjqaTI6zmzr21q7XGfBzEUiWow7cW
	YPHuCYmk=; b=5f0xxZgmLQjRNbVI67M2SCMtzB89IsYo2wpMN4+27t9aHE9IKHW
	zypfpE7s/CcEam75NCbshwfkNmzd1IlOXTXfXEDaoyfXyk1lWVw/58YGHRXi4RJF
	8wA3LbGGjf/oqj/3NsPDlJpMXqSoETFG7RQi10VBlxLQgHoblrpdUKRFYspshm4m
	tRU0JQv+C5Fj3+Bv3/XPqQqbHS55EHPP9trFRzz758ZscHvFFyFHmwEnsSkUHWhO
	MObP0Y2buLkl83yMWeDHcPSERkfskdlU3REfVjfqQ2Vhb6HvxIgwRpxlodyjaAYO
	GeDUG3aQk5745W5Imflcr7TAfbdiV8xtGwQ==
X-ME-Sender: <xms:blTCaV0Dc3D_us1H10kv21aNh2ImKthYV3S9Yda_rIkp5w9KYlcLvQ>
    <xme:blTCaY_R13zcoZaIOtJC12imtYD3EkQQ9wZUYIMCeKY_YbiK9bhwWJzEWUvyBRnCv
    aqzoBPTzGqaZS3lyIXCE-TVksPDfHli0VfqDWYAspbgD1iauF1ZiA>
X-ME-Received: <xmr:blTCaVppi02YM_4XJPVJbWge-2AXleRV94NdieVo14XOe_atTtPYnTyt7wsGdU0mfB_h9U4W0ww6nr7m1coE2epxdfraTq0-EYv3jJGC4Tj4Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprggurhhi
    rghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepshhtvggrug
    hmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:blTCaSTnevHWnRnyDE_EJwkU3SdQa7ZoU1qyAjUz4s0MKcRuv_XPvg>
    <xmx:blTCaYN40JuZZIRj40SDATj6PuiJgyMPJztQSEtZEdCCzJiJhKn0Zw>
    <xmx:blTCaQj-0x9mhOxDMkBtrgf_oP1aWcLrR_Tuw8zaQAMswIFjV1dmZQ>
    <xmx:blTCaVlAqpqlU7vGYxvMC8Jt54C33gs8dJWtACrp3p3_59QAoE-wsA>
    <xmx:blTCafrYKQpdycPUD1nvcQ-hMpHR99eLZ1XDKWDJkv-vjj9TiCEB2Nj7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 05:07:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 88c682c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 09:07:56 +0000 (UTC)
Date: Tue, 24 Mar 2026 10:07:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 6/9] hook: add -j/--jobs option to git hook run
Message-ID: <acJUaVquXMhYn8CD@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-7-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320135311.331463-7-adrian.ratiu@collabora.com>

On Fri, Mar 20, 2026 at 03:53:08PM +0200, Adrian Ratiu wrote:
> diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
> index e7d399ae57..b4c95a31a8 100644
> --- a/Documentation/git-hook.adoc
> +++ b/Documentation/git-hook.adoc
> @@ -140,6 +141,18 @@ OPTIONS
>  	mirroring the output style of `git config --show-scope`. Traditional
>  	hooks from the hookdir are unaffected.
>  
> +-j::
> +--jobs::
> +	Only valid for `run`.
> ++
> +Specify how many hooks to run simultaneously. If this flag is not specified,
> +the value of the `hook.jobs` config is used, see linkgit:git-config[1]. If
> +neither is specified, defaults to 1 (serial execution). Some hooks always run
> +sequentially regardless of this flag or the `hook.jobs` config, because git
> +knows they cannot safely run in parallel: `applypatch-msg`, `pre-commit`,
> +`prepare-commit-msg`, `commit-msg`, `post-commit`, `post-checkout`, and
> +`push-to-checkout`.

I guess this is the place where we need to point out that this will also
override the `hook.<friendly-name>.parallel` setting.

Patrick
