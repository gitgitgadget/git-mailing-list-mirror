Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008E279DC2
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774417025; cv=none; b=t7xZEHZY7ZpOYcyAoR//hOwP+wo+Lj9X+RdJV56GaJdY/RRiLNmYtOYFzMpyDiZqgBl2OKrR3lubl/IVpCsyv7soAop/i+bh5O4iWkk38b91pFTpw0zIw3G89weHJa9eKL5/ARpzbZ4q++slJ9dcZhWUQpvyG2HYkRgRzvditTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774417025; c=relaxed/simple;
	bh=jSgvS+8syVtH19s+4RwUstU1dRGRQXrTNxBLPfcQ+g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUA2XxIovzqaueu44vGAMOmziRingBb7/RzQVDFqv0sOEBrkK3X81Riq7yF4bs3UwKlBRJr7I0rVQ657PYs67l5tqlad4UP0HeJLqT0SWjObJo90lVxKyPVLK/L4m6itTs/oFah5kRDZxEon5ZOK+6H9E6UIp2bv/mSWFy8qqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YZ+1uf3Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=32xxYHxE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YZ+1uf3Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="32xxYHxE"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E9769EC01DE;
	Wed, 25 Mar 2026 01:37:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 25 Mar 2026 01:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774417022; x=1774503422; bh=H/5FWdVSjz
	+FB9yrFGynnrCfnxmJEdl7zQVdtLR52Dc=; b=YZ+1uf3YeA3dqgi+FxHjOlE1yy
	mVK7blV/bidfsz10QBzAEQ0518pb9VeK6MNS1fG4oVNOTn/O6JShSZgoiva4wf5P
	+wNu59T28LoCpMRRvHtrslB27dFRTMm67+4UPXqvHNduGjpjand1CIyd9D7DcrKA
	yWx1fRiqrSeFgeq6n7v9UYMMWTT10H2O91qNIv/GnbdS/NVRAbk2BibWrUSokWZW
	U7L8GiT7CS3XxHggCUDyvzCfEldKBOvJotlTZ5Dil10qPZdl/4sgd2F1s7ooVDaB
	Ou/5tajtPYBu3dz5VkzMVAarQ8u8TuYYeXD1Hk5h2bLf2uSJN5vLLTQ9uM3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774417022; x=1774503422; bh=H/5FWdVSjz+FB9yrFGynnrCfnxmJEdl7zQV
	dtLR52Dc=; b=32xxYHxElppS+ssaONdrbxOtpdz1onzJ/1P7VpQMSsZBOqZ7pTe
	E69ujdtDA4PHxgBdoa7qchGbpJ00nSyAbsY9rE0FMsunpGfJQGE5hCMeIS/sYn+e
	1dFp7ClHWMsx1g4aDWcReNgvcRHY7VACPCxqI8fHMNhaUtw3KEioy34HXrU6Z0fC
	I4vWAxTtjsmCSEe8Md8DfWJXzN6Qy+2dHdEsiSjRgyEykdxtVsROqUMmTjpAaiRa
	2zSthckqCfcfZXIMenI1AK9MNc/8IYQHhpqHBpbVpIywfwAcEjbuDNSKkRAuC2Ty
	a9G/2o1SP/jWJOconG3ZG8+5hNCjUSXXxqA==
X-ME-Sender: <xms:fnTDaQoNxttZSo4oeS9pAQ3OGh1Nwx-Wlq9G6SOiVpl5wZk2g4PQsg>
    <xme:fnTDaeGAFObF1MmW4PBKFgLX3GDHutOZw4Mk7_rlh2HonhDWRm6sDSDfNPmuj0G6a
    IIM2dFtIqrcglyK0GOK0h6SM3OE14gBjNEkHJb0XLv5mHuu-FMt_A>
X-ME-Received: <xmr:fnTDaSkOb4RIU47SMbMt3vK-D4RXoLz_WL9hSW4uvIVh7PQotM5PGMv6TkN5a7EoBSXEQbH5Vy4RWXApn5PFy9dqxguuC250aY4_JqnCv1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephfeghfegkeehgfevtdegleevudelheehtdefkeelkefftddvieffgfefueelueegnecu
    ffhomhgrihhnpehgohgusgholhhtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fnTDaRlhmK6tVMc5qeki1iSazsNELVwFFJFC3H5toc62S_rtWZN2Rw>
    <xmx:fnTDaTtJi9mXY_OufwSIZEEvKx8Cnppa21bwTCzmHCa4b7R9-k5fng>
    <xmx:fnTDaUmxDnvjibvkpY6zxy63JVcgTJ6G3Ps5SZ_fB-XA17jdbC7V-w>
    <xmx:fnTDaesbqMP4MmkdOC7_0avw4qTc55fHpysb3jzuagc_uYMg4C0PrQ>
    <xmx:fnTDaWGuFj-uBws8L3MDLB4j3ByQa5UZ_yD678Zq_v0W__w3jw_gseig>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 01:37:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f00554b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Mar 2026 05:37:00 +0000 (UTC)
Date: Wed, 25 Mar 2026 06:36:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] commit-graph: fix writing generations with dates
 exceeding 34 bits
Message-ID: <acN0efJvZ9liex8d@pks.im>
References: <20260317-pks-commit-graph-overflow-v1-1-e6bee22cd826@pks.im>
 <20260324-pks-commit-graph-overflow-v2-1-843568cf8780@pks.im>
 <xmqq1ph92pzs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1ph92pzs.fsf@gitster.g>

On Tue, Mar 24, 2026 at 08:42:31AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Changes in v2:
> >   - Account for platforms where `timestamp_t` has 32 bit precision. This
> >     matches logic in `write_graph_chunk_data()`, where we also depend on
> >     the size of the commit timestamps.
> 
> > +static timestamp_t compute_generation_offset(struct commit *c)
> > +{
> > +	timestamp_t masked_date;
> > +
> > +	if (sizeof(timestamp_t) > 4)
> > +		masked_date = c->date & (((timestamp_t) 1 << 34) - 1);
> > +	else
> > +		masked_date = c->date;
> 
> It is a bit surprising that on a platform where timestamp_t is only
> 32-bit wide, a smart-enough compiler would not find (1<<34) as
> suspicious. 

It probably would, but we don't test on any system where that's the case
to the best of my knowledge. `timestamp_t` is defined as `uintmax_t`,
and that should be 64 bit on almost all platforms. There's going to be
exceptions though, even though I'm not sure whether such platforms even
matter to us. But I later realized that we had similar checks elsewhere,
so I decided to adapt accordingly.

> IOW, I would have expected this to be done not with runtime switch but
> with conditional compilation.

Well, it's written as a runtime switch, but I would expect all compilers
to essentially turn this into conditional compilation. They should note
that the condition is always true (or false) on a given platform. And
checking Godbolt my assumption seems to hold. On x86-64 using GCC [1]:

    compute_generation_offset(unsigned long, unsigned long):
            movabs  rax, 17179869183
            and     rdi, rax
            mov     rax, rsi
            sub     rax, rdi
            ret

Thanks!

Patrick

[1]: https://godbolt.org/z/oa4xPohGb
