Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38E28506C
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930972; cv=none; b=GAgkACE4Chd/kG0Wtmt8jMif64AoVCJXnt0W1+JAP2uf1fzVReCaqitKP5J9Otx2cU0ruPj8abLf2QvuqDVfLqx3KGaAPJpF8WPIonTs0R0/5Qv0IfzzGZveav+GYvGmkkP/rqYjTmVXnczN9uxM4KXglMBrwabZJIfbA8lbHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930972; c=relaxed/simple;
	bh=keMsswzRizi3GTqk7PJwbeMyNlxFok/P9I+yzr4goy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVVIrVbCdHvYkC9jLpZvR7td/vKv3EvwZqo7nnYhDMTJfvhPC/Xs/JZaK5+IWT4GehegxLyL5161HLsP6PR3tpO20yc8vSfloDlTNBVj0YwRGKjSamk42UJPNZu1xfTIDbPtJnQMR1KGwrrCXZsYJ+41NNmFwLOJkJn8zn/OLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jmgVqzm9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R2GWwCIp; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jmgVqzm9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2GWwCIp"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id CD6361D0008D;
	Wed,  8 Oct 2025 09:42:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 08 Oct 2025 09:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759930969; x=1760017369; bh=6H7mmySc2N
	2fX1RphtfhUV2Sg/qso8ShuSwR/gCOt/k=; b=jmgVqzm9OelHeE1b/CN2/HlnIz
	KD9eqlt/lj5BcbhK8XnYAiDabom9QN6ayHBMBjwO6RapKaHgNbvL+ody0UytsTZS
	oqptLNRGww4hmyqihA0G+6osY7r7njluMVUnKrU5CKSL4GQZiIgLRPoKhjHq+nrW
	e4gzBkWs0e3TLQXHVX7bykjvajUoKAGoB3fhIzWYzBjp4dFdpD670FwOlZh9S0gj
	tz47I8ioC/ZSUDx1PpXk693vZFEacebHGFGZhWt8aPDngQWHJNjMqgL3Wl11OIT2
	zYd7fIdLpEPoKkNphHhDitfMx6X3ZDHsBhjIdVPJN/hXjiEfcIj0fv/vv5Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759930969; x=1760017369; bh=6H7mmySc2N2fX1RphtfhUV2Sg/qso8ShuSw
	R/gCOt/k=; b=R2GWwCIpdxTX/D3nXkZ8qJDaelqWWe3mUXCrmu+fkbD9Qyix59A
	V8QKPqtb1Iz4Ll5YBLXImDv7k8kW+Lnpx2E+G764nSnA4oNNStOpUdfiOwxogBAS
	XWi9NuacvskhKnszpWDWAqLmzxVZUX9bYnT9ImUUxVZL8oBhNAA6dhAPdbDcypW7
	ommKtloo2NE67AHglQ9n2M5MV/UyDxjkizr2KRT0FJads4x3wCIo9OfT6s4f+xAj
	wYs2J66Zr2b+R1JYF16ukf5dFKha/3lcHq1ZAPcC/XlVY5s+vm8/0BMPHXnPo1A+
	yy/H7G5IiKhsyDuDMevYjdblfYIpasuwvpA==
X-ME-Sender: <xms:WWrmaGGfir2UGQD-_xivJac1xWZUSdJ5xt3Sd4kGamrajopQm3LN1g>
    <xme:WWrmaNWhNiP47ho3mV7ChFdYdMDYH_XtbKJddp0cN-UGe3cr_kW7NAWWJkgHdC_Yq
    FcAbY0MTZgJOLOP5GEkxBWOlWrU6SLpC0Z98UAq9LjKT3SucIT_>
X-ME-Received: <xmr:WWrmaNw7TS59SK_3PxQUuwA3CBc-izN13W_BmMM5-BQ_xP8qNbcUq5-Cl5kJRsoWT3B_f6JkExx89XTSTQgUAwLvycxdcXTTD1J_Ij9C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WWrmaLNtVDknetAkBVrldzGTxiJbqT9QG43abykaZYvx9lj8ex59TA>
    <xmx:WWrmaO4ETIhVsZEOfs2Pf6ik5yVynnBNaNWU9z64eQdMU_S1Igv9kw>
    <xmx:WWrmaMPYy-EpMBxC79GbPrJFHvyxy271kggX-Vy8TMMCHOuoWqXFSQ>
    <xmx:WWrmaMkv4xGtYsR_RkNjE_Zo1_UyY9OrGfe-cte-T8bqRYgNSerkqg>
    <xmx:WWrmaG3onLPdD-KhVy-Nx-653b0KEVb2ERzILdeCCnR0Kn_qLkt3psaG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 09:42:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ebb9894 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 13:42:47 +0000 (UTC)
Date: Wed, 8 Oct 2025 15:42:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/13] refs: introduce wrapper struct for `each_ref_fn`
Message-ID: <aOZqVAOjVboM3sm3@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-1-916cc7c6886b@pks.im>
 <jrst5hft3o7ee72hrmswhrnz46rgvjihdxgfsougg5u5vs6os4@2prgx3uw6qp7>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jrst5hft3o7ee72hrmswhrnz46rgvjihdxgfsougg5u5vs6os4@2prgx3uw6qp7>

On Tue, Oct 07, 2025 at 01:05:15PM -0500, Justin Tobler wrote:
> On 25/10/07 12:58PM, Patrick Steinhardt wrote:
> > The `each_ref_fn` callback function type is used across our code base
> > for several different functions that iterate through reference. There's
> > a bunch of callbacks implementing this type, which makes any changes to
> > the callback signature extremely noisy. An example of the required churn
> > is e8207717f1 (refs: add referent to each_ref_fn, 2024-08-09): adding a
> > single argument required us to change 48 files.
> > 
> > It was already proposed back then [1] that we might want to introduce a
> > wrapper structure to alleviate the pain going forward. While this of
> > course requires the same kind of global refactoring as just introducing
> > a new parameter, it at least allows us to more change the callback type
> > afterwards by just extending the wrapper structure.
> > 
> > One counterargument to this refactoring is that it makes the structure
> > more opaque. While it is obvious which callsites need to be fixed up
> > when we change the function type, it's not obvious anymore once we use
> > a structure. That being said, we only have a handful of sites that
> > actually need to populate this wrapper structure: our ref backends and
> > "refs/iterator.c".
> 
> It looks like we also populate `stuct reference` in a couple other spots
> where we invoke the callback explicitly.

Fair, let me mention that.

[snip]
> >  /*
> >   * The signature for the callback function for the for_each_*()
> >   * functions below.  The memory pointed to by the refname and oid
> >   * arguments is only guaranteed to be valid for the duration of a
> >   * single callback invocation.
> >   */
> 
> Should we update this comment now that these fields are contained the
> wrapper struct?

Yeah, will do.

Patrick
