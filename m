Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A9A920
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554654; cv=none; b=uIIBFLgK7PU2wsQVSWqEwjdiajxktASGiz+fF5Sa2GrcecgSI+GJd1MOYALBzHSQM4FgyVcywwqFrlFAsPFvN4VVvRvCzMJw/KQx042KdpB1zuAamMkefOB6P/KNZusTjOFPjrZP8FASSDiX6RUTy7VXgIAF52UHb0qIlukAHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554654; c=relaxed/simple;
	bh=QPYCyuLhn++2soyAvTg82g0zq1gB0L3M6yjqO7a2oP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4Wk8MGjc+Yj42Q7Xf0g4P1jAZAQWGZmadUwhayTgUJVh/ILG3I3cMdaAyeKhMvzFxBRFeapiA+Aj/nWSCpzPA3Kbbs3PMEoyvrle9rCQGNJppdbHWh/WndcLv4vyDAD5r6StWk2d1z1L7avP9LL0MKSZpP0W/KZUHObDQPfU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lj5LF0em; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=moTLLD1z; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lj5LF0em";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="moTLLD1z"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BB241380494;
	Tue, 17 Sep 2024 02:30:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 17 Sep 2024 02:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726554650; x=1726641050; bh=fYNG2Zl8RJ
	ccJkVUhuG6YNpsKWz9HvVZGmtRGVq+It0=; b=Lj5LF0emj+XXDKZU0atzYLuK7W
	2yQGjQo4L0ahCeS3qhibaRjqL3f4y8n2Mve1rl09tErkZrqbwqSXOkLvaytEHxSL
	u0YxAZTyJw0tSJbXpV75tdVDoQuvKmLaI8jhzoj5kgdxTSMzpZGy+JdypZwmoEMz
	3SdRQqgnzGdqC3IsKPYQQScDFgzdaTAI15bBTFC94eA49+n4EqAUJzpstWAIHpMd
	BVKy9stx1FLiYNpuAdAys3D7QYVAx5I82KdsKhhCGhfHLTuQb7yIFvZiCtHy7aF9
	1HXAcGNNOXbYVtgmPdyBQDsNM5MJXUpBWRDHxtSKGV5IcCeyfssxVnDT0nsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726554650; x=1726641050; bh=fYNG2Zl8RJccJkVUhuG6YNpsKWz9
	HvVZGmtRGVq+It0=; b=moTLLD1zPP+o2D+LQlIAb7EIbPRVzXIw9IFHpOZua1F8
	EjjBIF2vsBy5ER2YWxh7RMlEV7YeglktfQnPgNKYYSMw4+UyMGr6v3HWl7BS4THh
	5XqfbyuCrgQlel2/DJrBZdvWcAf8mjYhuLo6bqJbRZa34X1mOMH0c2h+Z7FMzInf
	CJFUSw22m1WB5fYrLcS83Vx7afGT3JdUIZmth6uuicZoFOLDexpHEMFNlnwJ4jSr
	fvIhHUfQDIjKDWC4L6k4hMrhUyj544vY1jW1N3P8TnaBJPlx+fKNC5a4exKraaVl
	zzUAi/Dh76/MTKpFwRlT391RHspxd3TjwtmYG9Nk2w==
X-ME-Sender: <xms:GSLpZpsMwLfTLsyu134RbQSB65KwTaFQt5udBEQhJUpxYlO_iBI1Xg>
    <xme:GSLpZie88hgl1nwu5DK50rvGSGhjiyAlggj6iExx0zrIIfac_cKGjP9bf67mY5bTb
    _4db2l6CN6TIbQEWg>
X-ME-Received: <xmr:GSLpZsx-ufFhhqAsthjrAXWImRf09eavZdegGnEnqu_Qu_SPWe4C_QSDJVAwcdpw0r6FFzTfwqSZDLJ6q1B3tCcmnLRRWuHMH5-XrpFS-N52>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekiedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GSLpZgOx2aSeIcZhkoMNwf1UeYdC51PNgUOu_7auszRI3g2PMqROEw>
    <xmx:GSLpZp_UwMpqAK3xvN6Bxy_T9u0t-gCV-v1nYmQ8z_nJtDnn6fJTJA>
    <xmx:GSLpZgX-m_ghmJ-Z7m2PTg8cIrKFSGU7TgcReE5lNsuwlesZVGAiTQ>
    <xmx:GSLpZqc33fW9wZyNmkH8pAdPacH31GsZDKfKx6ifg_htmGNc0JjrUw>
    <xmx:GiLpZkY_QqaSvrJdlR3DwgVeOiWSojwqubCwix44EbYcIhGeWR3GlFEr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 02:30:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a1b0fba3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 06:30:27 +0000 (UTC)
Date: Tue, 17 Sep 2024 08:30:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2024, #05; Fri, 13)
Message-ID: <ZukiD4-GP-rcUWnS@pks.im>
References: <xmqqwmjerqvl.fsf@gitster.g>
 <ZuiJjQCZ23DznwJo@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuiJjQCZ23DznwJo@nand.local>

On Mon, Sep 16, 2024 at 03:39:57PM -0400, Taylor Blau wrote:
> On Sat, Sep 14, 2024 at 12:12:46PM -0700, Junio C Hamano wrote:
> > * tb/weak-sha1-for-tail-sum (2024-09-06) 9 commits
> >  - csum-file.c: use fast SHA-1 implementation when available
> >  - Makefile: allow specifying a SHA-1 for non-cryptographic uses
> >  - hash.h: scaffolding for _fast hashing variants
> >  - sha1: do not redefine `platform_SHA_CTX` and friends
> >  - i5500-git-daemon.sh: use compile-able version of Git without OpenSSL
> >  - pack-objects: use finalize_object_file() to rename pack/idx/etc
> >  - finalize_object_file(): implement collision check
> >  - finalize_object_file(): refactor unlink_or_warn() placement
> >  - finalize_object_file(): check for name collision before renaming
> >
> >  The checksum at the tail of files are now computed without
> >  collision detection protection.
> >
> >  Will merge to 'next'?
> >  source: <cover.1725651952.git.me@ttaylorr.com>
> 
> Let's hold off on this one. Patrick raised a good point in [1] that I
> think I have a fix for, but want to hear some further discussion before
> I convince myself that's the case.

There was also the open question of whether we want to rename the new
`_fast` hash functions to `_unsafe` to make it stand out more that they
are indeed not safe for cryptographic uses.

Patrick
