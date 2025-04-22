Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95934F510
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308417; cv=none; b=VPyc4YsZCAtG+LQFo1OkgpAikzzdtatwBCU/Tw8/21/I9KsWhCnJjCzC2stHr2ynIwD5y/D7I7PvktY+FP31ZcIntYpOjjAW3WyUBAIPUciYltxwU2c94CTekshk+wkmSYA3Jc3WP+BNGVWMvb3IBAsWT0Kh1hGdvjr03hkOSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308417; c=relaxed/simple;
	bh=KVi1qIYD1TglQPzSH+OYLuZK8N/IMvadwpSPFN+Qit8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O33euO6iOJWaEfHyi2TrkN+pAEkx1RNu9kWeo/MduxMJSQ1/PO+2uW7f2SF0z1AwxhYtW/SV/4RW3aS2VpO7UaGJkoPPnNKT555Pw1TVNFa1siCcWx3/3OleqXXsONjRma5jiGVIqvTbvNwi7ucuC+wS8/e0iQYVXDHs1tCR5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lvNg50+m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MFZVQyKW; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lvNg50+m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MFZVQyKW"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 73D57114019F;
	Tue, 22 Apr 2025 03:53:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 22 Apr 2025 03:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745308414;
	 x=1745394814; bh=sgwfGAQrG5OPBUU7fvc99620mjzauzYeH8T0GiFqQHo=; b=
	lvNg50+m/FKFA7olq8YePHalVURy7jfi7EKzl/sFRQwTguXaQ6Os3E9TvTMZxM5z
	UcLzqykTpyKbDnETBGUj88DCmBxd+gvMxBUQBSWppA9Je8z6TRFSbRBQHnMAMPtu
	NttpolpoyOWleF0C3m7NAwlGE4eUeaRPA4ANI+T9xUCWCyi97k896addXsI5BPsc
	ENtCq6/CHOOUHWTOGcnbY8dt6rTq9kxO1+ETtKvD6LX0hdulBbrXByFgt3ZkzbL1
	XREGuBe7ebu0qpzZ8HdCTSn3YxNAWlGvn6Lnd0VLFBZSxX7zZ3gS5jF23rZ66zaM
	XOIkzaSJ+xsPbnwSPNN6Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745308414; x=
	1745394814; bh=sgwfGAQrG5OPBUU7fvc99620mjzauzYeH8T0GiFqQHo=; b=M
	FZVQyKWzt+9HUKbNUwXswHrbWjIXkrl/I23qaSfajoHhcc/MrZSqWSa+IjcPvbW3
	7XnxHtM/gCEdTwIklL7V8AaFRc3+oETdAe4/kU5LWbIFVOD6ok5BQzEhqNd2YFIC
	tPvCxKECyzIRzg2N2iHy/lFxv3XVuKkS36zhnVcH9aFg/cofH/gwH8XolGilAt/9
	Qvn5FN51wjrKrLH5of3D9dEiIt2hpjDTqCurj909Jc26CzG/yz2YFMnpbzPGTSAB
	lEnHxtzT0h5smaHkz5C5JseX+w4KSBlAyeBArUXkUpCdskIbDuAdQ7MqiDnHRbsY
	XZyVcF6qeid9CSD4KWelA==
X-ME-Sender: <xms:_UoHaOiETTiIZ96KMw0Yv5BR7XLjF90fvQ_PHt1wW3FpCCfp3kmxKw>
    <xme:_UoHaPAiQJx2mDr2A_zAbGobJYTyI3ev5F2MGSDAaM9towAEOAF4gHt3ZFYcOJmIa
    6Ba38x25XGIByiHzQ>
X-ME-Received: <xmr:_UoHaGHYUnOQG7-jYS3lMCleuJY4iO6GmrwWdwhC_ZFAqsvp8ZbdxIKfsEV2k9KiwZaRwqbKawfesfIsigtwGT9sgwvHGVMt8BUeHYIvbts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetheffvddtleettdetueeukedugeettedutdeg
    ueeukeetheefueevvdeitddtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgt
    ohhm
X-ME-Proxy: <xmx:_UoHaHSz_GSD-JpaDKxvXE6CDCe0ml1_Mp31hHz1p-MVq_gSVHd75A>
    <xmx:_UoHaLxkBkwAr937EzMQL_0bFW8FOI3VrMFiv9G6H3rETAkYf4jltA>
    <xmx:_UoHaF5ocINrMvKe0rXECA6gZCgbUg9aWwKVHT9xWFjJfVXgg2mC8g>
    <xmx:_UoHaIx15iEwX2996FsGrjDVyZh_fKUw_0GRW6cJEJ9vC4lcVbSLfA>
    <xmx:_koHaJ263BGnLG6CmHaIkF-87hgRd4VggeyK8NMOylWpM70Y8M92x9EL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 03:53:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id edee782d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 07:53:30 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:53:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/5] meson: wire up support for benchmarks
Message-ID: <aAdK9gnXOO3ERq7w@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
 <CAP8UFD3Nr_f7WSzjv4AEKzH9Kpsf6soOd+VSO9ng=-ZSws6P3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3Nr_f7WSzjv4AEKzH9Kpsf6soOd+VSO9ng=-ZSws6P3g@mail.gmail.com>

On Tue, Apr 22, 2025 at 09:27:57AM +0200, Christian Couder wrote:
> On Tue, Apr 22, 2025 at 8:50 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Hi,
> >
> > this small patch series implements support for running our benchmarks in
> > "t/perf" via Meson. The series does not aim to replace "t/perf/run",
> > which is more fully-featured and allows running benchmarks against
> > multiple different trees. Instead, this series only allows running the
> > benchmarks against the current tree. Users are thus expected to continue
> > using "t/perf/run" for more advanced usecases.
> >
> > Changes in v2:
> >   - Adapt "aggregate.perl" to use a "/usr/bin/env perl" shebang.
> >   - Link to v1: https://lore.kernel.org/r/20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im
> >
> > Changes in v3:
> >   - Document how to run benchmarks in "meson.build".
> >   - Expand the message for the commit that enables out-of-tree
> >     benchmarking.
> >   - Link to v2: https://lore.kernel.org/r/20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im
> 
> In https://lore.kernel.org/git/CAP8UFD2jKwYzmc40knXY7k+FQabjZbGTqs9fowF=-0OqfNYp_w@mail.gmail.com/
> I wrote:
> 
> "I wonder what happens when we run `meson test -C build --benchmark`
> but 'time' is not found."
> 
> because I wasn't sure if it would just do nothing in that case which
> might not be very user friendly.

Ah, sorry, forgot to answer that question. What Meson does in that case
is to print "No tests defined". We could help improve usability a bit by
printing benchmarks as part of the auto-detected features after setup of
the build directory has finished. That would make it more discoverable
that benchmarks have been disabled.

Patrick
