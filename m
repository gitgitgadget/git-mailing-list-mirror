Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC4B23315A
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569629; cv=none; b=lf6qHSpdddNjMMokif3HBbIfETtXBx6Q1MNAq7efZZzlX80/FmNnRRBa/gsgKmat9WjT5alVM+UlMKAVj42/kL0abvARfhEiwjAgeV20xFGKPrwG9vUt4x9u4Ir6hb09dRLbkzqNdTVGKzpf47lMv/xjVxBRsxo7VOrwG/jUSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569629; c=relaxed/simple;
	bh=wnXHND8slrf86OMOcL/FmVGe6hj51S633MvTnEW9jbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNy9IA7yjq+U48bJOxswgrMa5vnyIQb8O13GU70CFzV+0RGxYXQCgI1EtD/m8vIZIdQm4MTq1VVdDiKQlPdwzhghkap7baVd+zh5Eh9JGttOPCsKdyX671K5aWg4O11IlKwoUuhB2BgeLsEHx14TuSg54lTyEZuhIb8C07FBZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FqmquN+U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JP5d9YMv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FqmquN+U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JP5d9YMv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CC7841380192;
	Fri, 25 Apr 2025 04:27:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 04:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745569626;
	 x=1745656026; bh=kMx4QcIKDt6uaTUqxUbjXT869Xb7NGTinDurr/u6LzQ=; b=
	FqmquN+UApezDFy8xvJilXwsroq2QfI7sLUS3t1Qui/RNG/KmbwMczqtRE2VipKr
	pqz84U/LhebB7DvIRzp07ASifyWkzeMgr+QnhDEHoEYfOEKzVCpXFCW3lv7uXHvh
	lnpz7dFq2hWdWhw/ZtcTo5eQKBuP1JwOph2/Gdq5ryFl287Q07C6jIfv8xt+jgab
	6N9xwVINx0vcyNQyR4vS1jkSYv97oyivf7UXfUJ4gcyRJo19mR37H/UKs29hxFDb
	YQ1mTZwT8pwMMICdCRLR17y34gxSZv6QVkT4lLacYk30REll5C72fzAXrABykctu
	NSGkqGhanJugdSWz0RR02w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745569626; x=
	1745656026; bh=kMx4QcIKDt6uaTUqxUbjXT869Xb7NGTinDurr/u6LzQ=; b=J
	P5d9YMvpORg+0F0k/YfDriuDgKrORJ2eYWpClD8X0pYbjvfYVyUTnc66kl5AJu2J
	Dt7mjTaove4e+p5QMnNJ4lJC/qFORmVGN36QPkli5HUuuO+KIN7qBcQR3PjllmEd
	AfxiqVL13zgf23WLUXiDXLL9hccj3B62eRMF/uHL2SMeTvcXs0ac0+heR5u3ZB8O
	nobi15bZO/GuTCpMbgsIxzAFvljbQ1+4TAyuxl8uYz8PNV3lEql/Lb5nEG65axqT
	VPZTShqdacd8O86rDuLlHKE55MN/o8cqT0QxtfVC91JqiqSOntjyfBXmipRN3ih7
	Fwu84pQYDel8e3wkVkF/Q==
X-ME-Sender: <xms:WkcLaPQx5f-hkUU-J3eMbI6Gdyl1sX50qxDsF3cJkL2j4sRk5xdBOQ>
    <xme:WkcLaAyZXcyx4xtOoED43hSrkRjq08RDB3W48Hnz2jTnY4SYf88yeK3JQ2CkFm-oi
    ebxclz33K-o-db7Nw>
X-ME-Received: <xmr:WkcLaE1Ky5G0aIcL1kahhfwxQxcDWT6Z5D3jB2xpoEubw34stSP7YRllStBc3kBKo9hfc1rA9ysA1KUlXUEsFw_8hsM61HsEKjBhbxnX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedukeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:WkcLaPA8L0Lvo7PCWpiMIMM5qStzgHi-DisqzIY1Vs4TbZ9D7AY5WA>
    <xmx:WkcLaIhWYCinWpRuInOJxwJ5r3fpX0NB-luMLv4oF9X1aMlP3UN5YQ>
    <xmx:WkcLaDqkCfWJban1fYeT7eJyItSOjviJHGwCTr3mFgvTUk90XaqS2g>
    <xmx:WkcLaDiavCLIkj3EyPOjxVkVzNZzimTMetz6P2VZoLTuO0uIJzC_1g>
    <xmx:WkcLaC1zjM-SSj3I2CmG_PRpHKk_2-LLLEEjPbeXiJFUFnDM-_3WMVyH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 04:27:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d890743 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 08:27:04 +0000 (UTC)
Date: Fri, 25 Apr 2025 10:27:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 4/5] meson: wire up benchmarks
Message-ID: <aAtHV9rk30j739Kx@pks.im>
References: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
 <20250425-pks-meson-benchmarks-v4-4-6b89555052c3@pks.im>
 <CAP8UFD0rq7Z=6PUPyPZOXaKyXzbWW7Eb0rDfoTxrd7k4Qo8ciQ@mail.gmail.com>
 <aAtBQ67Vveg1f598@pks.im>
 <CAP8UFD37tRiCyZSzJwSbbL=D5b61TGOBMgM5qzeHOQaP-hzbow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD37tRiCyZSzJwSbbL=D5b61TGOBMgM5qzeHOQaP-hzbow@mail.gmail.com>

On Fri, Apr 25, 2025 at 10:09:18AM +0200, Christian Couder wrote:
> On Fri, Apr 25, 2025 at 10:01 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Fri, Apr 25, 2025 at 09:57:33AM +0200, Christian Couder wrote:
> > > On Fri, Apr 25, 2025 at 9:28 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > >
> > > > Wire up benchmarks in Meson. The setup is mostly the same as how we wire
> > > > up our tests. The only difference is that benchmarks get wired up via
> > > > the `benchmark()` option instead of via `test()`, which gives them a bit
> > > > of special treatment:
> > > >
> > > >   - Benchmarks never run in parallel.
> > > >
> > > >   - Benchmarks aren't run by default when tests are executed.
> > > >
> > > >   - Meson does not inject the `MALLOC_PERTURB` environment variable.
> > >
> > > [...]
> > >
> > > > diff --git a/meson.build b/meson.build
> > > > index 410bbf93dad..2cd05a9b1ba 100644
> > > > --- a/meson.build
> > > > +++ b/meson.build
> > > > @@ -70,6 +70,12 @@
> > > >  #      # Execute single test interactively such that features like `debug ()` work.
> > > >  #      $ meson test -i --test-args='-ix' t1400-update-ref
> > > >  #
> > > > +#      # Execute all benchmarks.
> > > > +#      $ meson test -i --benchmark
> > > > +#
> > > > +#      # Execute single benchmark.
> > > > +#      $ meson test -i --benchmark p0000-*
> > > > +#
> > > >  #   Test execution is parallelized by default and scales with the number of
> > > >  #   processor cores available. You can change the number of processes by passing
> > > >  #   the `-jN` flag to `meson test`.
> > >
> > > Doesn't the above give the impression that benchmarks are also
> > > parallelized by default while the commit message says they are not?
> >
> > To me it doesn't because it talks about test execution, not benchmark
> > execution. The comments for each of the invocations also discern between
> > tests and benchmarks. I'm happy to hear about alternative ways to word
> > this though.
> 
> Maybe something like:
> 
> "Test execution (but not benchmark execution) is parallelized by default ..."

Okay. I amended this locally, but will hold off sending another
iteration just for this change. Thanks!

Patrick
