Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251A32E13A
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814760; cv=none; b=HPfnTMpVO2cTbYboVx/04b05ifSoK2xOMt5IjeBuT16qpmqAeWKj0CghMkoDLmVtPf//IFub9iWwYcOSswoHoRLiRA+TKzIS5yLXmNAg6eQdicfhpXCPGUtN/rx2bVh5RIVXCnUZAlEmAThu3+YsLbxtV1zmFhK3BMkw8fCPduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814760; c=relaxed/simple;
	bh=59KvhKjjqjjmL4vnZFqE65e13FQt7FlCkUXQHXo9yqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2fGgbMwc2lj5Wi093boy+GnyVsF2bXqC9Qe1nudPvxTMl7h8KUh3xlE1DHXyOIhvNz4GRG3CS2cDEne7z2V5TOiIjTBMhKx6LKybhwWc0q+p8wOAb6mwJP5SBxxLfF3wB7PECNK1zk+YszrPjuzVRCMF/OGIPJFnUprsVKCGg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q8TUJq1M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x/K2lyBG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q8TUJq1M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x/K2lyBG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C6E02EC0114;
	Thu, 30 Oct 2025 04:59:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 04:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761814757; x=1761901157; bh=t0g9TOpLbO
	2epLNStyJKoLBq8a/gXmsmB4QiqtcnbMk=; b=Q8TUJq1MDo2s8V+yVgk9m8D6sj
	GePdF37AJnEyodfISR8MVLWnXlZw2vvkyJwsPto+VrVLwqeRTWVVSbQPaRIRarJD
	fCDBhuvIEELpsWDZKMYy++ruodfRmN3I7+ZWfAC50zrsqkvpvbuEKVPxoiEkZUMy
	azo4B/uUpYAIuz3rPyKhA8A46Hg8w4YHsqMm/RxqMjAX6Kwz3AWJHwqAlzYHiL5N
	I5s0Gzus2OYng3WgvtdlEo9gkPSFi5ldfV7Ia0NDE40Qn9rjKQPAo5SaMGlpSDhK
	Xn8bnYwhSVpOTYcccQs/mTXOz3KWQxbNPFDQ45TanIEZJWlj4fnoo2Gb++jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761814757; x=1761901157; bh=t0g9TOpLbO2epLNStyJKoLBq8a/gXmsmB4Q
	iqtcnbMk=; b=x/K2lyBGCU3Q3zkSiE+jx5z6g/lu0I/CZwK6fGSDgTk6wQ6xe61
	4oSfoWLC9+X3/xHhBulg3ZTAN0Oz3rFg6/dhXCBgIiMq7pzJ8s+PlpfSdIMKANBJ
	nu+QQCDnKm8FaxK5emq52xBhzvCYPZSHvd6k34WLeh7bjMVDFfL3Lqi7wTx+KW+c
	pRdInoO5GnOu2xv6dizMuVIQJ5pFtEmh4IQfI8zuSC5jfGeXJC8TUqGaXUB8Xo1Y
	9gyO8lJT7qqa0VnNEvCCVEzBFgtsYhDpEaTPPNFWqCUlnGxklotGBXKPF6cdfKjo
	dcZIo+PI0YvmV4Jkwih8YOcucrsXv11aw6w==
X-ME-Sender: <xms:5SgDaTFAiBBZ2dSEuQmAG6MMdMaCpuiVdJcy6_cCQbDZMULbAV-0sw>
    <xme:5SgDaXUbCoLRER0da9BjuqgqMch76D1JIwtdFGCLmCyD-Qv2kOrjNFGcY7rw8MAJS
    PRTrSAZODFVqEpjddR6e4kRPFNNvbEjSJRQnfOsga6LLNCNYncamw>
X-ME-Received: <xmr:5SgDaaLcvqb_Wh9T-WepmBfS2vtm7KCuQjoeTXHTHx_fWdpTVH-Yu6GEL-v22L0hFTFdbqHmFUMswCNUP0DDrxtdRapJNr3JP99zaEfvEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:5SgDaf-K9TPPN81E4Jls0pkQNEed0nm9nTWDBtprlb_86pKfKOUpNQ>
    <xmx:5SgDaVJ-wqws21uuxb1SZ6hbq53KUpX7tFVbL-I_cm8lgi5ZgvI85w>
    <xmx:5SgDacnCeyp-dR0OYEGcVedo5UYTpV571jnXAwrFYHr_URUE8MIj2A>
    <xmx:5SgDaROZ6a5T1ZOsahRVXQQPLyQDzg5WLq4Ftvq-49sPoPVYKJ7jKQ>
    <xmx:5SgDaVph9Yt9MLr99sF9hBuaZsAICS7UK_chYV5HujoFGWHqxEoAxLUb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 04:59:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50210aa9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 08:59:15 +0000 (UTC)
Date: Thu, 30 Oct 2025 09:59:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/8] builtin/pack-objects: simplify logic to find kept or
 nonlocal objects
Message-ID: <aQMo4PqG_U6JIkOt@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-5-1a3b82030a7a@pks.im>
 <875xbxrc4q.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xbxrc4q.fsf@iotcl.com>

On Wed, Oct 29, 2025 at 03:55:17PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The function `has_sha1_pack_kept_or_nonlocal()` takes an object ID and
> > then searches through packed objects to figure out whether the object
> > exists in a kept or non-local pack. As a performance optimization we
> > remember the packfile that contains a given object ID so that the next
> > call to the function first checks that same packfile again.
> >
> > The way this is written is rather hard to follow though, as the caching
> > mechanism is intertwined with the loop that iterates through the packs.
> > Consequently, we need to do some gymnastics to re-start the iteration if
> > the cached pack does not contain the objects.
> 
> Okay, this took me while, but yes this function was really hard to
> understand. Thanks for simplifying.
> 
> Naive question, what's the point of keeping a "last_found"? We have one
> global "last_found" for the last time this function was called, and we
> have no control which OIDs get passed to this function. Why look into
> "last_found" first?

I guess it's just a micro-optimization. I'm sure it exists for a reason,
but honestly I didn't feel like opening that can of worms. The caching
just made me scratch my head in subsequent refactorings, so I cared more
about making it maintainable than questioning its existence.

Patrick
