Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30961DFD1
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728359903; cv=none; b=QpA6XAqpBYEWNkqFnS3GL4uhkmCCUL/W04/atRXqv2seOGfbtkBvNicFa5FGqzWKKWP0waZ325wJa+B/TJJP3kohlJIdZz9r+pxBdbQx7bsEVFmCylQB0UmWvZwyzWjgD8j8UubxG1wZ5Kp9Rr0t/m6jb/dRKZ63ihFsBImT4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728359903; c=relaxed/simple;
	bh=OcEYughh8KwlxhoLvSVerrYSt4yPPgmfkFr9YGvCkho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wp+nRRv2JyfsCT6xfGZuJFlR3zAohVzfLJYZgMhGzOKWh3lFU9KLrbBwfM+cVYYQ0OuWOrzn9qzDmbORCKgjObgO0SPtY6BRrwDXOtzKR4VqhBwhE3n4Uk6+Uira++pWEN5mH6kAe4Lsmdy4sQxApLwbm5U44SUQlBj7xqWFP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pREpBiQW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h7fPECo0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pREpBiQW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h7fPECo0"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9E0B114023A;
	Mon,  7 Oct 2024 23:58:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 07 Oct 2024 23:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728359897; x=1728446297; bh=Nqwjd9QmtY
	qQQlbFAo0QYa1kTP+WOi9WoeJ0jzXvRrk=; b=pREpBiQW1w0LYazOWHKtO8cRtO
	o0qG83b8SPZq6T79n3yewfhgPohpx93dPOafyP+hb+/1TLcu6OPXKW1uSF1YxqgF
	CNQY/gNU66mOo0vPjAGOMVmkjrYlnXl6fvSTRoIvsIH5ckifGfwEB7rhWjlzPpmT
	+Hk4cjNhalrYjEZtYTUgv7BTquObNk23GJmC1A11SujACFKojy8Ey07bwliWkoMu
	MXrs09UvMO/WpRrcbmACVe4qdBQdwnTBTopr/ZXiQ9fqUQNTFFBigwY4oBN02T0m
	Wbxe3/fuI2940r7mhFLtkT+RoWazSxbvyxtCoOfFbjA7wlOOAxhQKasf3peg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728359897; x=1728446297; bh=Nqwjd9QmtYqQQlbFAo0QYa1kTP+W
	Oi9WoeJ0jzXvRrk=; b=h7fPECo0fyMFOHc5WZQw2QavWugW7zRvpehN+bSIXKBD
	4jDHSeWkyKJvdMicePG1dHLqngMRR4M/uzI52HPTrexyVTzvEEjlGJWg+KMixb0C
	EDDFsBxXwdOXmSSoXkXyVuFMYZSj7cfvxxuIYVMls81drcYNGu2SQtKtzMs178pT
	eYIDbaJvujrmjNGbW8++DLHfb8Xu/RXa04R0vxeFfBAuGS7HBLZ0AJhaXxyIhqF9
	Xzas2TQNtFw9vc/ZuYVsqXJSqGhWdWqTgmPyoFb+2FjlyVCxbX39FiPJ6Y+4G2E1
	E9iLjM3yvVDrYhmBtVNp49C/ztCM7I3v7fRRH8yYDQ==
X-ME-Sender: <xms:2a0EZ_F5ZULmf5WA0ttb2X0nGz1Bl8vrxC4HjNws69M8etv-xsaGBg>
    <xme:2a0EZ8WN5SCL5Xgo_MdHz61ffFxGyF4JQDQSmtrPkKrlMVi1pddNON6nJ6PUe3bUK
    lK7R8wvW4WYU2r-HA>
X-ME-Received: <xmr:2a0EZxKzGL51N_-DQCJntuj-A_qu1ZDRZseQ6ocLp4WYOmfDCgTpKO5ubr4ec_CvcIHUDPdPNGYzgrHsxVyy4v9Nrbq4hoF58_-rrS2jpr8xr2Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeftddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhgvvhhrrghiphhhihhlihhpphgvsghlrghinhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2a0EZ9HW4RbMiqe6uX0ayusiScDcODdIQTTaZYSOSPQTuBC2QZ1QPQ>
    <xmx:2a0EZ1UBGCi6KZLuQ092pQ7R1HsV7_J7LiNFny8Dy76nYlZUHHgrvg>
    <xmx:2a0EZ4OLrRRTJurGTP1Kbb0PiN6LU4--cjS-uWUAYsDm4c3uqNen8g>
    <xmx:2a0EZ02qnWIwLVNlXtZZO6N18COR4-jGJr__s70qBJmFW7W99TuKLw>
    <xmx:2a0EZ7xVK2jYWAuITLgDkQGNF3OlIBIj-VM7Vz6-FCeCwzBmfr-hN7ie>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 23:58:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 711067c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Oct 2024 03:57:13 +0000 (UTC)
Date: Tue, 8 Oct 2024 05:58:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o
Message-ID: <ZwSt0ZrlDaYCzfRX@pks.im>
References: <pull.1810.git.1728323033680.gitgitgadget@gmail.com>
 <xmqqldyz76ui.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldyz76ui.fsf@gitster.g>

On Mon, Oct 07, 2024 at 05:53:41PM -0700, Junio C Hamano wrote:
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Philippe Blain <levraiphilippeblain@gmail.com>
> >
> > The clar source file '$(UNIT_TEST_DIR)/clar/clar.c' includes the
> > generated 'clar.suite', but this dependency is not taken into account by
> > our Makefile, so that it is possible for a parallel build to fail if
> > Make tries to build 'clar.o' before 'clar.suite' is generated.
> >
> > Correctly specify the dependency.
> >
> > Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> > ---
> >     Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o
> >     
> >     Hi Patrick,
> >     
> >     I tried building v2.47.0 and stumbled onto this small issue. It
> >     reproduces for me from a fresh clone on my old 2009 Mac with make -j -l
> >     2.5, it's a little curious that no one ran into this yet.
> 
> I suspect that nobody tells make to build clar.o (and nothing else).
> 
> Instead, the t/unit-tests/bin/unit-tests target is what is typically
> built, which is part of $(CLAR_TEST_PROG) that has clar.suite as one
> of its dependencies.
> 
>     $ make
>     $ rm -f t/unit-tests/clar.suite t/unit-tests/clar/clar.o
>     $ make -j1 t/unit-tests/bin/unit-tests
>     GEN t/unit-tests/clar.suite
>     CC t/unit-tests/clar/clar.o
>     LINK t/unit-tests/bin/unit-tests
> 
> What is possible to happen from the broken dependencies is when I
> did not remove clar.o in the above experiment.  We may rebuild
> clar.suite and then link clar.o that is outdated without realizing.

Makes sense. In any case, the fix looks good to me, thanks!

Patrick
