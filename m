Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200921A262A
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313642; cv=none; b=d5HYpALmBWtM0A+5yo1HgDGERGMpzVlom4PnbjMx9OkhbQgpBUvHGPy8DoR+GiMvFRfwaKGwhDcNAx/lLpW2T7u4736csGTx98sqnQiM3Du/h8UCx+ibJ0SiRVV/7yFIYkFxYjJN8tV0dFAZMpyCIHFLCg1Qci3Xh0mM8zd9Bvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313642; c=relaxed/simple;
	bh=R5p7RjqWYSoqb5HH0RdV1XCr6P7N8E574NXfsRZOZWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2AGxl5CmYwBapru4lVomrbih9U1LZw0tGsXvOUOCiVV++HpZaTvhDGE44G0UA3Cn5zp1xVfz4UaVhKodveRuqiG2yFz5QGUGxhjWiE4SKLonB+lGt69cHPtSRcpzMzA3oWAPh17aoGuljjsKx1/uG5VsjWhhLJ81pdnfx+qIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jLT2GDgL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=acQksZi8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jLT2GDgL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="acQksZi8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BB5F1D0013A;
	Mon,  8 Sep 2025 02:40:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Sep 2025 02:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757313637; x=1757400037; bh=awVRANQ6Np
	94DWLis1oeZ0X9X6a+FWgebqYhaHirAAc=; b=jLT2GDgLhomzyuN61auolud65T
	WhWehSqCjeHsJSoUEQDRNcWW/WZGJU1FF/ktHoU4MCXrOiY+PKTG1Z/bghSg9l5o
	xKuEAFXZLzwZjmIkW2fw5R1m7E5zEJTU+vrZxDrJZmUkhDHXc8Gg5dJ/8OflIZpI
	HPOAexREkcoy1uID30y1fvgLn9/8EE+gH73z7cqOCNf5MXwZZav3ePLSn3rriNAJ
	z96t2xWmcXBtllmfF/NZ5ZxPXvvaEvPKDPi8eXx6ENxT3lkW06G7Wce89SSLwMyw
	wDoLfB6fxf8Z7n0Cnt9qqcxEkdTJ7E8aiC6w7+rcgU+U78L2dJh+uykE1KPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757313637; x=1757400037; bh=awVRANQ6Np94DWLis1oeZ0X9X6a+FWgebqY
	haHirAAc=; b=acQksZi8tCFPyMAZHQTjfatqC31jzTDwm/JVUJkHAw6hXntJmuH
	/QxukMg6Hf4gvNePUXGiWS5/nbKFUbTjJ//D0WO3i4QGA3AI0EIr/FEaST/5uAd8
	OAXdaAZUmhOpMFl5C006syuuGP39cgVOw/Apio8K97W1euNqfEXk8kKWhGrRuKqQ
	/iumwzg64iH2b+zntEXILviK9HWBreA/fagSaLD6KmiuP5T7/j0RvUAL88hMLKa7
	zN9OV18YQcM/h6ME8Zk/JQgfWGFWVV+Q1+JzPr3zfirzY4UL0O792GcnxtDyLMEm
	VCLvU4bIBObgdbIS4PDrVY5fNswXAzxt4yA==
X-ME-Sender: <xms:ZHq-aD9em9PAaYKzLoermHFeoQKoMGek2voaBc_ZEbCcsz2Uu5wkgA>
    <xme:ZHq-aHUznytujbDQb1ATtyx7bHQzH0NEcwdRmgeuMgf4-MkL4Aoi9e1UX0TybHDLn
    kDDE9_CLqfl8wU5jw>
X-ME-Received: <xmr:ZHq-aBMOqZYc4iQzwJPT8xvibXrN3jk6LVEqe1VrWGhvLS8JEBmoR0GLpUERpkvGIiEc3Re_1EfDh0kCL99JTzoZGgnfnzKS343YabhSP3xE1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhhsehglhgrnhguihhumhdrohhrghdprhgtphhtthhopehsthgvrggumhhonhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehmhhgrudelleefsehlihhvvgdruggvpdhrtghpthhtoheprhhssggvtghkvghrsehnvg
    igsghrihgughgvrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZHq-aHf15eLVrZzbJp_rom9bWVNojr_WE22gyjN7XLLQceMTA5Py4Q>
    <xmx:ZHq-aIwUOHhGBNpGLGJwpfCoYsJ-bvwEaLofT49N74R8s8qlsVzovg>
    <xmx:ZHq-aAgkYbmdfhv-aAcWmw--vvJk8wCt2Qhegyhvu_bVNURAjganjQ>
    <xmx:ZHq-aN56bF64r6DPBKL1Z6lwVemiWx9QrIE23eXY9_wgb_dj85emzQ>
    <xmx:ZXq-aHj2g-jDYClxmerQQ_wo1L4NDgn30QfVZ5o1x68qptF9qJzTeLb6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:40:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49afa221 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:40:32 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:40:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Christian Brabandt <cb@256bit.org>,
	Eli Schwartz <eschwartz@gentoo.org>,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
	Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
Message-ID: <aL56XQFIRRjg88YD@pks.im>
References: <xmqqh5xszf91.fsf@gitster.g>
 <aLbSA5KsBdD4wW_B@pks.im>
 <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im>
 <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
 <aLl6iFXeAvL_hvqR@pks.im>
 <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
 <ada227ec-94aa-4563-800e-05c116a361a8@gmail.com>
 <ba386547-10e0-45e2-95ad-c47e84919abf@gmail.com>
 <xmqqplc43o7c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplc43o7c.fsf@gitster.g>

On Fri, Sep 05, 2025 at 08:37:27AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> > 3) There is a period of a small number of years where we continue to
> >    provide security updates for a version of git that can be built
> >    without rust. This is intended to  allow a realistic time for
> >    distributors on platforms without a rust compiler to port one or make
> >    other arrangements for providing future security updates without
> >    placing an undue burden on the project to provide security updates
> >    for niche platforms indefinitely.
> 
> I am not willing to see such a support for multiple years, though.
> If the first item is 6 months, this backporting stale releases
> should be on the same order of timeperiod.
> 
> If it were "3 years of optional period, 18 months of backporting
> security updates", I would find it more realistic.  It would give
> those platform maintainers enough time to robby, fundraise, or
> otherwise campaign to bring Rust on their system.  I personally find
> that 6 months is way too short (if we are _only_ looking for an
> excuse to say "we have given them ample time to react, and now it is
> their problem", 6 months may be good enough, though).

Yeah, I also think that six months is a bit short, but three years on
the other hand feels like it will cause quite some pain on our side. My
plan is shooting for roughly one year of optional support, which is
still way shorter than the three years you mention.

How would you feel about:

  - Pinning a date for Git 3.0 at the end of next year and tying
    mandatory Rust to it.

  - Guaranteeing at least one year of security backports for 2.99 (or
    whatever the last release before Git 3.0 is).

  - Explicitly stating that if anybody requires to maintain that version
    afterwards, we are happy to let the community maintain that branch
    going forward.

That means that we stop supporting 2.99 in a bit more than ~two years
from now, but we don't fully close the door on it if people still rely
on it.

Patrick
