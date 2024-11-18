Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48461DFED
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918314; cv=none; b=cVyj9CTa9nsWwXSz06c4Im0B+pphvVfBVHS9fnMi7li3MVRNUBBU8uhmZqS3e37fhgRwjmOkj50K5DsDEMLCif3RZJb8jsdXgOW7Gm+Xb+fT2dzk0v8Zf5+Jq9Zj3JodfeADI2BbdGHtjy+q03c82XS6caSrecUoqbTksQ/tCJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918314; c=relaxed/simple;
	bh=wb333WmBhTxTDQDowFGoEGWaKIj5Aw6TRWt2OCYdlME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqN60JWRFk0HIi1th5/B0Sfd+pivojEM7eFZK8DoJgtmWMS5HZoX+tftTEQgrrNtXkKk3UYZRQYXVQBUw7ZV1P+oyAoJd+eOTV9Wa1sj6/yKUy9tRmwb1zflSOplCFSe8t6FmV6szRh8EsQljPPibCa0pn7obzb5ZMfNSGiO4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZYZcm8Jr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=deGI78G8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZYZcm8Jr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="deGI78G8"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9EAC2114008F;
	Mon, 18 Nov 2024 03:25:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 18 Nov 2024 03:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731918310; x=1732004710; bh=TtcbOCNz7X
	kEqWRzYKll8mvca5dcrVdH7Tu0x9sxvnQ=; b=ZYZcm8Jr1Oj0Xh1NpQhj2YFgas
	h0uKHmSe8yXSmIdVtfJTrYGrfdmEzWjK6V9Pp3IbFvHlJIE+HhGtH2U9pwUfmf9r
	8Wm2wvqnuNGZ/R8xD17PHf4TGqJk9vpQZCuPlMrgDtvGrFbdmshQ5czgLFnytQOQ
	smN3pISp+bDR9Bgbp3BkGe6BPYFKyNY121+zei8gHOwiyBi9U8l4uvQMfO42tqvS
	iJAtSxMa/f2tTrH2B6F9ppiBXzCW/X+jv5dtT2sXHdmdVlw0z6VsbseTD2PrTC3K
	qvWtCOZF2Yzoxvgff2SL93hHUVP/hZC5+xF8oHB7WjiHCss6lcD9sl1x3bNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731918310; x=1732004710; bh=TtcbOCNz7XkEqWRzYKll8mvca5dcrVdH7Tu
	0x9sxvnQ=; b=deGI78G8RZWHmyNeNIcnaPhTfYPIN9198NXRyajkDV8BBVWZmf5
	OeNKAEraqMQI+plBC3GCSj8/YEZ3AcRMWs1JOzwhmwMCS/8w7tV4m4urI6+BocZb
	9VGtiXhB1CJ86tHJRJqkzSer0rL2zobyEkfl13Cmyu/thdcoc19Z2EX78JLVXzhV
	m2/OjsAaFIMiyGWlCE8YxEc9tQxkIeRdOSwHHIXZAPWMV54e+0lo5L8hAvn+DXMr
	Mxkf/2APzHqMa6iuerWpHYDoZIa3X2pElp8EWj/gRaTd/yMDQHU5/u6JWOY268qE
	uihJXTQl+zZbUbJxg3fKVq54dIsLKEvAnVw==
X-ME-Sender: <xms:5fk6Z6Nepf7My_iCngWevmOGnU1dKubOxeYNTJ-XLobkiUHyRfyvCg>
    <xme:5fk6Z4_Zqd_0k_Ue1xJsjSkFOzJT5SJDzOjmQCmWjHu_biuOcXBvt0Y9EAEuBdtdi
    B_3QpW7a7BYElGRgQ>
X-ME-Received: <xmr:5fk6ZxR0_F1_7OimgUn1dUjQM5wcCJ2lCWdMZoMFJx2KqWbDbCX7Y3Q097Kp5ZC3vsk4SwwXP4wBo-NIRjrXpnUGERDa0CCKtpXp3tD2YpMvRxc_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepfh
    gvrhguihhnrghnugihrdgsvghntggvsehtthhkrdgvlhhtvgdrhhhupdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:5fk6Z6vQGnROhqyxKcYPqdWkyqkyjcjRleaZJnaPOLumkR158VtsXA>
    <xmx:5fk6Zyc_zGpZTPu5dimpIrrD4EnLa87hK-eMEQhMS5y5rm4jT0jurQ>
    <xmx:5fk6Z-2JjoQb60vQbxSoEivo4IGFwGBUcCx94kusKQDRXkRv0ODTDw>
    <xmx:5fk6Z285tZ9BLivTj_tjxR6WZuYsawlQGgco_TWqmlj5tNbWzd9Mwg>
    <xmx:5vk6Zy5yAXvCh_nqr9xaGz4saI42FodMbbamY_hLSDf2BNTvElzUXxOZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 03:25:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ba2165a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 08:24:19 +0000 (UTC)
Date: Mon, 18 Nov 2024 09:24:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Bence Ferdinandy <ferdinandy.bence@ttk.elte.hu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	phillip.wood@dunelm.org.uk,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	karthik.188@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v12 2/8] refs: atomically record overwritten ref in
 update_symref
Message-ID: <Zzr50O7AkczbqIo7@pks.im>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-3-bence@ferdinandy.com>
 <xmqqr07d11wt.fsf@gitster.g>
 <D5OUMKNX6UU5.23Y4V7NHKGUWX@ttk.elte.hu>
 <ZzrrMrhRxOuB6QKH@pks.im>
 <D5P5FWL8I3SY.DPYSUTU8GAYJ@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D5P5FWL8I3SY.DPYSUTU8GAYJ@ferdinandy.com>

On Mon, Nov 18, 2024 at 09:08:13AM +0100, Bence Ferdinandy wrote:
> On Mon Nov 18, 2024 at 08:22, Patrick Steinhardt <ps@pks.im> wrote:
> > This behaviour isn't documented anywhere, so I wouldn't declare it a bug
> > in the reftable backend. But what is a bug is that the two backends
> > behave differently, and that should be fixed indeed.
> >
> > I couldn't find any callsites of `refs_read_symbolic_ref()` where we
> > rely on the current behaviour of either of the backends. We do have a
> > check whether `refs_read_symbolic_ref()` returns negative in "refs.c" in
> > `migrate_one_ref()`, but that one should be mostly fine given that we
> > check for the type of the ref beforehand. "Mostly" though because it can
> > happen that we race with another writer that happened to convert the ref
> > we are about to migrate from a symbolic ref into a normal ref. Unlikely,
> > but it can happen in theory.
> >
> > I think it's an easy mistake to make to check for a negative return
> > code. So maybe we should adapt both backends to return -1 for generic
> > failures and -2 in case the ref is a regular ref?
> 
> I've been wondering about this when writing other parts of the series and now
> is a good a time as any to ask: I've already seen this pattern of returning
> various negative integers as error codes, but never quite got the logic behind
> it. Why not just return the same numbers but positive?

It's a matter of style, I guess. Many functions use the return value as
both an indicator for error and as the actual returned value. Think e.g.
function calls like open(3p), where a negative value indicates an error
and everything else is an actual file descriptor. This carries over into
our codebase for many functions, but we're not consistent.

> Anyhow, the proposed solution sounds good and as far as I see how things are
> done in the code. I guess if I want the series to land I should just fix that
> as well, there are already a couple of not-entirely-related fixes in there :)
> 
> Two questions about that:
> 
> - what would be the ideal place to document this behaviour? In refs.c with
>   `refs_read_symbolic_ref` or with the `struct ref_storage_be` in
>   refs/refs-internal.h?

I'd document this in "refs.h", where the user-facing function is
declared, and in "refs-internal.h", where the callback is defined.

> - should I look into adding specific tests for this? Since the rest of the
>   series will depend on this behaviour it will be implicit tested anyway, so
>   I don't particularly think it would be necessary, but I don't know what the
>   general approach is.

I had a look and couldn't find another way to test the behaviour because
we use `refs_read_symbolic_ref()` sparingly, only. So I think it's okay
to implicitly test this, only.

Patrick
