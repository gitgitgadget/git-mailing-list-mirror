Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81609216E2B
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568075; cv=none; b=GUrxalQUHMQouAw6N/cJuyolvr0W3iDC/JPd4jUXomgfPwdMgvUqV3bJXuFRd1QRFb0M1Dqw/smhvduICUpOP3nZnDrSGWCXTK0EOfIePIi1xrCFFPO94zTZIO5tIz1k7YEOSmb7Yz1sKo5OXYrBlv0NmQgCSoB5rvRMFeahkbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568075; c=relaxed/simple;
	bh=UOHrBsgQ7TeYVQa72jsYOth3OEFRFkV6x2GP02j4kQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDP1rql1lRyUN0TBmqaUxRY3WN3CoOj5WH16JGRUZbdLdJUjQT156uW2F36iEKJAn0UNO9paIJnZex2qxZ6XHAujVFvewZ61VDeii/B7DJz6FBNtW5yTTs5A9HbF1y/2o8jmaYvwqkd+VrWlhPMWMvZbwM6ZaAybystmmsQS0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B9W6Sqd3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uMO647/S; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B9W6Sqd3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uMO647/S"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BEA71380143;
	Fri, 25 Apr 2025 04:01:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 25 Apr 2025 04:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745568072;
	 x=1745654472; bh=yn/jY4GRpBJxCfQyu64IBLRcQ4YxeZnt/U4NkpbJbGo=; b=
	B9W6Sqd3ivmKYTMbXqaJRzsaBuCrkAOfPFGsX9lXdZVMZkWmed8dSQzZhTwJy6Tr
	Lux2NEGkC1ta7dDknXxDpfZQFgyoZ/xngKVMAVPuGOJmNp9Al4AbFuMT2IVeQ13Q
	J/V+uDSy0BbzEjBq6daG3biyC3F1DsoOKLn2BoSZIEylUJJlFZnpPSwZ/xqhbmy8
	iJ6IhcMXx/ccOMeDrxmE1RG6bqm6WwP2JtXhgrsMZ3HVNQduxrHJjq1pFDcklFt6
	TVgKqeOZOGRcVRNQO/Nf93IkgBVlkL++7JmHMwF+Gs0i3t1q+VsoO4NrgtYx0eg+
	pacNQgVwJHv4+mMHiu8STg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745568072; x=
	1745654472; bh=yn/jY4GRpBJxCfQyu64IBLRcQ4YxeZnt/U4NkpbJbGo=; b=u
	MO647/SuG+wvwtA/FqqOPrtqddghjp1tdu5zkJICrWfrJ/UrRGi+wHSW6BlMbZaF
	PpTE2CBfXO0wRaNfopo6/Ptn+5E2Ev5v1j7fF6KdePRf4fIcU5KTRsumAtQ65GHN
	00V2mTbFArEFanjJhWk92P3TT2X08KZJn78oo99wcRspzlUKEBIAeuhp2X8qPeSW
	Sqb/o//0Gm5CZ9fA5vMay/vkuDFx+6l513YZLIVw4cpFEPQks/jJUku3fWAUT5W9
	Nzm7ocIZOKt/wUNmREcRJ/hRABgzu41p/gKG6P5fQYEyWjsu0iWIQrGaL3qrcz9T
	XiwpPI6wst/wsUGSZf9iw==
X-ME-Sender: <xms:SEELaPWHu7N6THwTK-HrLZuuvRrcrcNfNtRTwnWxqdOWDUv_6_OGoA>
    <xme:SEELaHkd0RaKUebyUQzNhGexYibZKY1GqhK4Basb3a7Gop0KnRYl3ritgMimo_A8u
    1AHglFqqCQJkuK2nA>
X-ME-Received: <xmr:SEELaLaacKiC8KOtC1huoc_Mj6dsQoeo9_7zpuKwkm5dSvlw_4YZ13VAG3SJ50qYzB7BMEG19fPmskWg-MZzhKH6WgaW5Gkf5mR-QiRN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedukedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhm
X-ME-Proxy: <xmx:SEELaKXPnJu2ZMUZ_mHyc-oWM6NN1yVuIw-673GPqviRctTUNynsVg>
    <xmx:SEELaJlrsuKvN8eDkL7mDvH6fxRXUtNBUTmnAiHBHlxAgq_SGVYt_g>
    <xmx:SEELaHfilTLwyf2Jyi5j_iD2I6A6CtdwbHOHJBIxrNTPXS1_ppuucw>
    <xmx:SEELaDHomZ3UqumKuyJLEwazaPSb1RP-SFjtieFq_UglayTqinLwEw>
    <xmx:SEELaALzBJ9s4opc2t2vJIE8Tf7Nw1HuJXrOxYW_FY8W7pf0vtVIxqAv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 04:01:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fcafb8c8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 08:01:09 +0000 (UTC)
Date: Fri, 25 Apr 2025 10:01:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 4/5] meson: wire up benchmarks
Message-ID: <aAtBQ67Vveg1f598@pks.im>
References: <20250425-pks-meson-benchmarks-v4-0-6b89555052c3@pks.im>
 <20250425-pks-meson-benchmarks-v4-4-6b89555052c3@pks.im>
 <CAP8UFD0rq7Z=6PUPyPZOXaKyXzbWW7Eb0rDfoTxrd7k4Qo8ciQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0rq7Z=6PUPyPZOXaKyXzbWW7Eb0rDfoTxrd7k4Qo8ciQ@mail.gmail.com>

On Fri, Apr 25, 2025 at 09:57:33AM +0200, Christian Couder wrote:
> On Fri, Apr 25, 2025 at 9:28 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Wire up benchmarks in Meson. The setup is mostly the same as how we wire
> > up our tests. The only difference is that benchmarks get wired up via
> > the `benchmark()` option instead of via `test()`, which gives them a bit
> > of special treatment:
> >
> >   - Benchmarks never run in parallel.
> >
> >   - Benchmarks aren't run by default when tests are executed.
> >
> >   - Meson does not inject the `MALLOC_PERTURB` environment variable.
> 
> [...]
> 
> > diff --git a/meson.build b/meson.build
> > index 410bbf93dad..2cd05a9b1ba 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -70,6 +70,12 @@
> >  #      # Execute single test interactively such that features like `debug ()` work.
> >  #      $ meson test -i --test-args='-ix' t1400-update-ref
> >  #
> > +#      # Execute all benchmarks.
> > +#      $ meson test -i --benchmark
> > +#
> > +#      # Execute single benchmark.
> > +#      $ meson test -i --benchmark p0000-*
> > +#
> >  #   Test execution is parallelized by default and scales with the number of
> >  #   processor cores available. You can change the number of processes by passing
> >  #   the `-jN` flag to `meson test`.
> 
> Doesn't the above give the impression that benchmarks are also
> parallelized by default while the commit message says they are not?

To me it doesn't because it talks about test execution, not benchmark
execution. The comments for each of the invocations also discern between
tests and benchmarks. I'm happy to hear about alternative ways to word
this though.

Patrick
