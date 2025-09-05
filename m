Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44136CE01
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082547; cv=none; b=tiXlnq8ywhlM9QK0w9VuMT7YAjn6clt0yz1f5Ir/ofBX/buSJAYfSTpX8FNWa5bUVIax7ZmGbl+31APskUKWUl++XLni3udn9Sh1QCGAn1SjQQhZkZaEHw7iwQVzwXd/0xk0bvV4JXh0OcF9GQPDDFXFaCHt/bOn9NsPdgslRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082547; c=relaxed/simple;
	bh=zYbWL8lDh24ykTIKnZWWwlu0LIKLWaMkpbaCFagUC0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFtk1ji8j4DKcsGfFc/dE5yfdn2qaJTNYwRKiHwA+x8lLsi4EVhy99295SskufSHvsqTZ/KLZZyUJN3JefnOY0UZEUzUmpmnNM2UICaPssWLoY0Cfseo1xkjb/Jw39+ej7982fzOcQWDbllSn3esqJopwOkzQIPil0MRh7uehrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rpfArfOV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UqO8dIp5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rpfArfOV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UqO8dIp5"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCB9B14003F7;
	Fri,  5 Sep 2025 10:29:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 05 Sep 2025 10:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757082544; x=1757168944; bh=d4hF5Pn0Eg
	z2J80RGz3ORoqQd2ji5YkJrH6m4UyFZH4=; b=rpfArfOV62JsFWFvuFR8uALMGO
	eDeHyyuNeHYUhHec+8xMj/0GzR6zuxynHSWIl82yufc/xHuQ14FYrqWeVL/VAsoO
	k0V0R/DWe2tXEuSlX2uRd0AoAVHrCPynyqgWbbceLCu5UuxNZp/cT/iSsCDx/Fe8
	mNF8jdP/xqVJlxzwR0r+xChQt+k88HC6R+YMlIPl1rHuATMFTfmGiHxkesYVgJiC
	PytcAYpH1Mm/PRU8k9i0TxvzYz3k49YYQuj3lH/DHPKdZlZQWNQEbDesdrzwR+CV
	T9OvVwxBr7tGKKyCXnv1qpLSYnbEi76tPTtDDCxPSavpESfJEyS+jiO3/vlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757082544; x=1757168944; bh=d4hF5Pn0Egz2J80RGz3ORoqQd2ji5YkJrH6
	m4UyFZH4=; b=UqO8dIp5PgGEE6O+nFhLIgnwxVe38IGNA8O1n1QtHw9ltMvitR8
	QGMFf9UfoA7COEpEqFXTrwxZelRb0Lp8jHleMjCQJxnWwrJ0PlDUs5if4uB0YkuK
	kDEbKyA/xlZt3V5cYeOK+TnAzsWSi4dnsqZ27XW8am/4hUS2ne0XYuXrgLEqJB6Y
	rgSoudCurxGAtjUFumDZC7Rc7vxzzVKa+rlx93G6u2LKXxcOhntf+kpIHC/9Dowq
	4I3EIXyujb42glvpCdGG8sXRs0fs0w8Occ7VIRQBE9yac391abIpmQ7XWsTS14P1
	NnRXNgnFRsDxOr+4j+07qqX5NsyFf/DakFQ==
X-ME-Sender: <xms:r_O6aO4D5iuu47tcvEvRjNIRF2C6ms8y-mbWTbbEjqeJ__a-x1ojqA>
    <xme:r_O6aDsgpgh6k7fx9XMxcptHeTxI3yYVtAJWZNjQhaWRvzwdW_GiQ0Yd2yjknoqfU
    Wqa2T8oLfdwVFdnCw>
X-ME-Received: <xmr:r_O6aD7fe-vxBYxgOsocV-xFBloTaIos_kIWYqBIWQKv6Pp8JnAoPbiazyjR23qTQKqk0v08md0wg8mebeuPY01zuT781Nse4JirrAmSxJIi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeludefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhes
    ghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhkpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsg
    gvtghoshhmrdgtohhm
X-ME-Proxy: <xmx:r_O6aH3GorNvvqRFbzEsnttJIYLfGhpEMoa7FRtokuPUbYuS59xLqQ>
    <xmx:r_O6aGhEiU8m0r5oyOGHG9CBRi_jy2MIS5w7lAlamBpg746Ppkgq-w>
    <xmx:r_O6aHoAq9HsANjoqKThNHPTCLNEOb4S5o8cPcAvQMsYY6aT9yXziA>
    <xmx:r_O6aJOfRns_V8rkezM1Om9a0K8dgRQDH5MBgtMeH68lRj-mrrjgZw>
    <xmx:sPO6aB4KCKEh0Yh8fByYJH6xmp8ONN5cqLY-RMfEV3gTK2roTN34xSIF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 10:29:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 013714eb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 14:29:00 +0000 (UTC)
Date: Fri, 5 Sep 2025 16:28:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 0/7] Introduce Rust and announce that it will
 become mandatorty
Message-ID: <aLrzqR2Z9jz5CuJu@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com>

On Fri, Sep 05, 2025 at 03:14:25PM +0100, Phillip Wood wrote:
> On 05/09/2025 12:50, Patrick Steinhardt wrote:
> > this small patch series introduces Rust into the core of Git. This patch
> > series is designed as a test balloon, similar to how we introduced test
> > balloons for C99 features in the past. The goal is threefold:
> > 
> >    - Give us some time to experiment with Rust and introduce proper build
> >      infrastructure.
> > 
> >    - Give distributors time to ease into the new toolchain requirements.
> >      Introducing Rust is impossible for some platforms and hard for
> >      others.
> 
> These sound good
> 
> >    - Announce that Git 3.0 will make Rust a mandatory part of our build
> >      infrastructure.
> 
> I'm not sure if we really want to wait that long. So far Git 3.0 has been
> about user facing changes rather than build requirements. In [1] I suggested
> a period of six months from the initial announcement to making rust
> mandatory to allow distributors time to either adjust their build procedures
> or notify their users that they will only be offering security updates in
> the future.

More on that below.

> > The test balloon itself is quite uninteresting: I've chosen to convert
> > the "varint.c" subsystem, mostly because it is trivial and does not have
> > any dependencies. But it does allow us to verify that C to Rust interop
> > works as expected, and to play around with tooling. All tests pass with
> > the "varint.rs" implementation.
> > 
> > For now, the series only contains support for Meson. If we agree to go
> > down this route I'll also introduce support for Rust into our Makefiles
> > at a later point in time.
> 
> It looks like this version does include the necessary Makefile changes which
> is great. I do think though, that for the test balloon to be valuable, we
> need make building with rust the default with an error message that tells
> people how to build without rust if that fails. Otherwise it is easy for
> people building on platforms without rust support to miss that we're going
> to be making it mandatory soon.

I have a plan layed out in the BreakingChanges document that mentions
how I'm proposing to do the transition:

  1. We introduce it with auto-detection for Meson and default-disabled
     for our Makefile in Git 2.52.

  2. We enable Rust by default in case WITH_BREAKING_CHANGES is enabled
     in Git 2.53.

  3. We always enable Rust by default in Git 2.54.

  4. We unconditionally enable Rust in Git 3.0.

This is basically gradually tightening the screws, which both gives us
time to build the infra and gives downstream time to become aware of the
change and adapt.

I think making it mandatory in Git 3.0 makes sense because I also
propose to make the last version without mandatory Rust be an LTS
version. And if we connect that with it being the last version before
3.0 I think that's an additional benefit, as there will be other
breaking changes in 3.0.

In the end it kind of hinges on when we think we want to release Git
3.0. If we can agree on the above plan, we could also think about making
Git 2.55 become 3.0 instead. That'd be in a bit less than a year from
now, which I think is a good timeframe for that breaking release. I
personally don't see a reason to push it out into the future for way
longer than that, and it would be good anyway if we built some consensus
around its release date.

Patrick
