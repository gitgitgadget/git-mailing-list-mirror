Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D3D151991
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751517822; cv=none; b=TDZqMwM/kOu8EVUh7M1yF0rZ+6L/lqVudkDKXkM+9CnGrLee7ktPBbY4PHXJBfY3DEACQhP/v0aIXpLJDyliQscyNNU/pZWVgJcH3yOUmwjEAZ3XmAb6aSyhSJeMBcFUUU/9rZU3CL8+0jM6GjDHMMQRLSNRe6tjf6A7xCvR6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751517822; c=relaxed/simple;
	bh=6TEuQz9+Zt4hm1cp/mjQiozIZUcfS5Bpotm1ZwLpNbA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t38Kpam5bHODex0DuUzce1F6pdUv7RdgKyntAwJTiLTIR+tQQ4hXr8socclZK4/65hgI141ezPhMkl4/N4LgIZoWXwasPO2V7nqjgIXO76SsUSGNcPCIzlfHl7BGSlmzEBk3iKfPHbC46RwEuY6eCo6UCspyA3ubNeDN+dEDyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EJKfp/9p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mav4YAd3; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EJKfp/9p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mav4YAd3"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id CEF921D00257;
	Thu,  3 Jul 2025 00:43:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 03 Jul 2025 00:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751517818; x=1751604218; bh=iKLuFk0o1a
	q1x5C18ILKy/jRBr+SGCOHocnZx6kGOtA=; b=EJKfp/9pb4/kp79UORsTgVlVVB
	+BS++2T4Q6ztUARJGC7ttgW4KwasxDRtPb3yXQTKPtITcfI5NUIsqiAc774PjS8i
	Ox8x/zSkdbqis46buJTCJpEQr/ya+pnYizs1PUNZG2uUKh+/pjdGCkQh0JtQ91JA
	/gRjasEtQ/JO4MfYrWGmOJfUey1WO/8FzNPZw13EKhuRcfymRBUU/iaQmN6L2qPj
	Okxhc7bkHC0hD4145tDjwEktYy/zs9FBYaBfr/G0rI76iqD4+jxDSxBMUJfDo36O
	kE8AsCByKa0u5bFlGLPWceARfPvJPCAVlE3r+swjAm0bKbal/X17iuL693bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751517818; x=1751604218; bh=iKLuFk0o1aq1x5C18ILKy/jRBr+SGCOHocn
	Zx6kGOtA=; b=Mav4YAd3/syCejw/SOxQ3kgT22E4rjHNZqQL1zNmBYprXE+HZ1I
	g8aF9m17G49zxH73x8+6x8KSjNT0REAfSPciGxnds8iZI/rGWSFjnaf4sjBs6Aq3
	T6Z2M77yoiHlRVeWlJRvi7cNa1Iuss2wiWijfvp4RlKPoUogOv9bNFx6FOLhwDgY
	b/4m4qBV3nkLxd7Je4zHMdshFLOBIfFEwUFYZePvZdMdQ7NuQvk0dShNYLEXxBGi
	c68+MtQqEPJ7AElCVT4268y9dFSzNz/flshpeQeZzZPtUOKYEH5m4DoeCHNTDgl7
	jc10g+11RYG/mOgCmch1pZaCRjaGnebCE1g==
X-ME-Sender: <xms:egpmaGWnQgJiPs-b8-jxyhERpFrndOIRsv1WjNw-WJCm2tPRVhxNCw>
    <xme:egpmaCkg2AfzmTTatIdSRT9wkDH9c_Mvh2uRTYUKC0XsOSFdA2PV5u7RNOGgYn7ib
    MCmfDkONJbPJ6r47A>
X-ME-Received: <xmr:egpmaKbfFq_b5u8PntKGI5DUdAlgKuARckxMGmCtZ_ZDAtxn93HlDtjb6K8oaMNFo557cL3ZKOffvn9zsNNBuGj1QCPhVaSR9l52DDfvXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephe
    ekfeefgeegvdegvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    jhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrhigvnhhushesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:egpmaNXJl39a7i3NwSNLIT1Ea65niPkAJdJNRUlB346XFZlI2SKtvA>
    <xmx:egpmaAkSlrUme1GMHjzFi4CF-fn9Wz--5cod6aStJ0vZz3TXxuiufA>
    <xmx:egpmaCdgTBS7Z6GgXRzLe3YKVQ-GEpcaLvlM1KzUaaoLUCjxwUgfRA>
    <xmx:egpmaCGMeSvekQWP5oeThPyb3NG7WoP37knX0wef-4ggpTMXrmn0xg>
    <xmx:egpmaO8LTePl-Jefs2S8cmv5UvWm0pQuHRc4tSKHdlRnL5PHCPBwMicT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 00:43:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab956013 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 04:43:36 +0000 (UTC)
Date: Thu, 3 Jul 2025 06:43:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com
Subject: Re: [PATCH 1/2] BreakingChanges: announce switch to "reftable" format
Message-ID: <aGYKdYGvCIGR_YF3@pks.im>
References: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
 <20250702-pks-reftable-default-backend-v1-1-84dbaddafb50@pks.im>
 <xmqqbjq2ed9e.fsf@gitster.g>
 <aGWi1bZMlbKCgB74@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGWi1bZMlbKCgB74@fruit.crustytoothpaste.net>

On Wed, Jul 02, 2025 at 09:21:25PM +0000, brian m. carlson wrote:
> On 2025-07-02 at 17:03:25, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> > > index c6bd94986c5..c96b5319cdd 100644
> > > --- a/Documentation/BreakingChanges.adoc
> > > +++ b/Documentation/BreakingChanges.adoc
> > > @@ -118,6 +118,45 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
> > >  <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
> > >  <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
> > >  
> > > +* The default storage format for references in newly created repositories will
> > > +  be changed from "files" to "reftable". The "reftable" format provides
> > > +  multiple advantages over the "files" format:
> > > ++
> > > +  ** It is impossible to store two references that only differ in casing on
> > > ...
> > > +  ** Writing many references at once is slow with the "files" backend because
> > > +     every reference is created as a separate file. The "reftable" backend
> > > +     significantly outperforms the "files" backend by multiple orders of
> > > +     magnitude.
> > 
> > These list benefits of using "reftable".  Can we also add one point
> > that stresses why we want to make it the default?  Something like
> > "Having to do X once per user to make them opt-in is too cumbersome"
> > is probably good enough.
> 
> Maybe an additional line about "most people pick the default option and,
> given the information above, we think that users will have a better
> experience with reftable as the default" (especially, in my view, users
> on case-insensitive file systems).

Yup, makes sense. This is what I've queued:

    Users that get immediate benefit from the "reftable" backend could
    continue to opt-in to the "reftable" format manually by setting the
    "init.defaultRefFormat" config. But defaults matter, and we think
    that overall users will have a better experience with less
    platform-specific quirks with the new backend.

> > > +A prerequisite for this change is that the ecosystem is ready to support the
> > > +"reftable" format. Most importantly, alternative implementations of Git like
> > > +JGit, libgit2 and Gitoxide need to support it.
> > 
> > ... in order for them to access the same repository.
> > 
> > How common is it to use a single repository from these multiple
> > implementations these days, I have to wonder?
> 
> Pretty common.  I know Rust's Cargo package manager uses libgit2 and I'm
> sure there are other development tools that do so.  At a previous
> employer, we had a linting tool that used libgit2 and we used
> command-line Git for normal operations.  I don't work with Java on a
> regular basis, but I expect that similar kinds of things happen there,
> especially in Java-based IDEs.

Yeah, I have hit issues with Cargo myself. JGit users should be mostly
fine as it already supports reftables, but IIRC it only supported v0 of
the format where there is no explicit hash function yet.

I'll try to engage with the respective communities and figure out a way
forward to get reftable support landed. For libgit2 I might be able to
have my team do it. For Gitoxide I plan to have a chat with Byron to
figure something out. The missing support for explicit hash functions in
JGit I've already mentioned to folks.

> > > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> > > index f11a40811f2..e0f27484192 100755
> > > --- a/t/t0001-init.sh
> > > +++ b/t/t0001-init.sh
> > > @@ -658,6 +658,22 @@ test_expect_success 'init warns about invalid init.defaultRefFormat' '
> > >  	test_cmp expected actual
> > >  '
> > >  
> > > +test_expect_success 'default ref format' '
> > > +	test_when_finished "rm -rf refformat" &&
> > > +	(
> > > +		sane_unset GIT_DEFAULT_REF_FORMAT &&
> > > +		git init refformat
> > > +	) &&
> > > +	if test_have_prereq WITH_BREAKING_CHANGES
> > > +	then
> > > +		echo reftable >expect
> > > +	else
> > > +		echo files >expect
> > > +	fi &&
> > > +	git -C refformat rev-parse --show-ref-format >actual &&
> > > +	test_cmp expect actual
> > > +'
> 
> I might just make a recommendation here for a `default-ref-format` key
> (or some similar name) to `git version --build-options` as well.  That
> will get put in bug reports and troubleshooting output and will help
> people figure out what might be going wrong if there are any problems.

D'oh, obviously, given that I have recommended the same on your series
:P

Patrick
