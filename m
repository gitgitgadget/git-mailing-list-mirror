Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2D1C8639
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363738; cv=none; b=tsNOA3Oy8ut41n4ABGu6ZgE+5w8DTNG9QLE2M3OpzNeeIPvslrw/F3gjlMVbAVqNIpYVDylz2p13xTcfDvyNeXr1aQi4rKsZ81fM22Or9xuyhfOwvtgNQVgP1XUEFOzlDmOp9iOgE3ERhHKSxBZlx/EOR4RxVm+bWGwoFSe3n4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363738; c=relaxed/simple;
	bh=QTcmOL4rEDmePvelbL/vaw2uhSlrrkbuRCTmIAjkUBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KipBcVhePw95Sz9D5j2wERwkNRbPQxwpWC3pz6UR3zBdFI9Ds5vfTY0ShVlRL+XE/xleHlowW9fmA6U+GD2b2MKTZESDvJUvtgOnCDBr2g0xLFAG45RzpaGWd4DRe/jRGslkrdh0qnsw8Q3hK9OZR4j0oWg94/seuyGVgqBFLa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WnX0mFDG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fy7Iy7Ll; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WnX0mFDG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fy7Iy7Ll"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F30C138028E;
	Fri, 11 Apr 2025 05:28:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 11 Apr 2025 05:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744363734; x=1744450134; bh=7bS/04Cg0X
	+D6vmhBfh+/6sEByona/D1VWnkvxS0MoU=; b=WnX0mFDGB4jT3TFotBSC2StrPv
	8Jjk3D+R7qKAr/R/cCdPkfiy63AAM4xmKlgVv284ilyTq2DdnJcijSxW/GEkLPdW
	BLZIMpVDFHXa9m/9TVS27baENMQNwrj3YPqF8WSSm/CQZWVLDg2MGR1NKTQLZnme
	sL4fib6DWtRmimo5eYnp2byFjNFaE3GCjSYy1PLMukDtcCigUe5gB1+t7aBMRQP2
	V/GJL2S8h1RK+eDS2zR1tacrUb1FdtjCoDOD70DCO3A+jJ7whO/flsGQhNyechQy
	vLhIbpD+MBQXPePwqirkLarq8nTXmqEfKAfCiwRprQhkOBSTYq0qvYQXL3DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744363734; x=1744450134; bh=7bS/04Cg0X+D6vmhBfh+/6sEByona/D1VWn
	kvxS0MoU=; b=fy7Iy7Ll/3lDnd+419LDTDJ8lMtZNThHJ24XwZrZujg9ISw8dch
	0OPK3wrBMbPalLSCHKENfQysxS4mJAfl/rBbVit6g2g0zTLi14+0H4mVG/Mjs+LT
	pRx82ri5wiOrN4U1bFiAnHDaNZXqLCTrQztFBYkFCLxCF/+GM5HzWjMOxNzJjV7d
	VEvTfgsZBWBaLbJQc9hE5zUK1ZYEeLpeLri+U7sNYaRMmNlo2KfudZDZFj4IaCsU
	CRXFIRSbjjDSUIAiFUk7cd4FkQxQjkd2X/VYHfUXQQBpcWfsMAZEoDvxBx3DjHyT
	oP7VHGnt28fC5NQe58+2G++4Q+e2nI+HPqA==
X-ME-Sender: <xms:1eD4Z7k0Xb_eD3Q6HUJzXCe51qEPC5SqK1gaMUsgIb53grIzMchNMg>
    <xme:1eD4Z-3Ej4jQHNlGfTH1BrEUT876oylOw3Bp0CiT6CSWbP82jbp22ZUlXq4cBDsgS
    rlDLxGD4KFP3RouGg>
X-ME-Received: <xmr:1eD4ZxofAFh8dNtnQisNml8T3F3onLAG4hLQ6wTSV2Vh4sfQJF9nSlsZlDktX5Gkcb1ki9piAzTmzhc_VEgoSKPFUwbZacL6YfrJO1FHnR6FfJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegshhgrthgvrghrnh
    grvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghonhhguggrnhhhqhigsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheplhgvvhhrrghiphhhihhlihhpphgvsghlrghinhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprh
    gtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:1eD4ZzkG2hAsczYF-45vCn7zOPtuqhIvIvqzVG2p5jO8enAYfz4w6w>
    <xmx:1eD4Z52gO3XQGB27EFEWAj4BAmB2s7OZRKviCPVsroiROR6OgYNaIw>
    <xmx:1eD4ZysNUzS6Aa0n5kuDmMlfElJtwCDT9QU-h93QIncMfHtXObZrvw>
    <xmx:1eD4Z9XOcsVraZBhc-BvWnhpXynYvcJcH7bcMCVZe-2ijPbUScxthQ>
    <xmx:1uD4Z9-yABmDQsfbAbTRnRO_7POS5NNUxYip6rXUKWuDsIhyh6-NBPBL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:28:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 293f4fd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:28:50 +0000 (UTC)
Date: Fri, 11 Apr 2025 11:28:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Arnav Bhate <bhatearnav@gmail.com>,
	Christian Fredrik Johnsen <christian@johnsen.no>,
	=?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: "What's cooking" interim report
Message-ID: <Z_jg0KHpBelL6UXl@pks.im>
References: <xmqqy0w9orsn.fsf@gitster.g>
 <CAOLa=ZRMmEjPoD9-M=XFU37_VoGebYDnH-=nfCyPx0nTvD1=oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRMmEjPoD9-M=XFU37_VoGebYDnH-=nfCyPx0nTvD1=oQ@mail.gmail.com>

On Thu, Apr 10, 2025 at 02:10:28AM -0700, Karthik Nayak wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Since the issue #02 of this month, a handful of topics have been
> > picked up, a few topics have been replaced by their newer
> > iterations, a topic that is already in 'next' gained an additional
> > commit on top, and a topic got its description extended.
> >
> > --------------------------------------------------
> > Born topics
> >
> > [New Topics]
> >
> >  * kn/bundle-dedup-optim (2025-04-08) 2 commits
> >   - bundle: fix non-linear performance scaling with refs
> >   - t6020: test for duplicate refnames in bundle creation
> >
> >   Optimize the code to dedup references recorded in a bundle file.
> >
> >   Will merge to 'next'?
> >   source: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-0-0802fc36a23d@gmail.com>
> >
> 
> Toon approved/tested the newer version. I'm still wary if some edge-case
> was missed. However the series has added more tests and everything seems
> to be good. So we could merge to next.

I had also reviewed it internally before it was sent to the mailing list
and couldn't spot anything wrong with the current version.

Patrick
