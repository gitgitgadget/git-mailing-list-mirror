Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F07464
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723100431; cv=none; b=fLfvOU+P2mTspyKDD5GzHkEzBSa7FMXraJfvJE3Eq/84bExMWyxkuqaCft5xah5goP210k11TfzpAIKcr8K7p+hc3/o3SmWZenJYB+MVESw9ACReE1+qANNH2zhvUbIiATCVCOJ6C6hOsJv7W8wn2R/1MerM8IxBMjaLVvMnEa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723100431; c=relaxed/simple;
	bh=Kd+6aAjnRQ63pKZRlLQHiF9Y3EpuKuaNX4Lj86iHdGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcLXae9vQKGpPuADEQbwvWa8xA41hs6TnkdQnx3MxRUPSkUnWjivCFLY1mbcVmcZ/MkDj806/HhyV1NNjSDlfFUzJ27jZZOo3wp/neIUR6JwV417qY6kAfp+Xgy8RD3OQtlp3UZMzLDznWAREfhYcMKpMWWrzXHze7cuDoKwzNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m8RMA/wt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RXRo1fdY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m8RMA/wt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RXRo1fdY"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E03001151B82;
	Thu,  8 Aug 2024 03:00:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 08 Aug 2024 03:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723100428; x=1723186828; bh=cdVBeCSqwy
	HD7NUdWwLDlBaqyOPi5czOtw2hy+ltY/Y=; b=m8RMA/wthLLzXHGitiVgpJt9Xi
	3Uhz4J9T9Gel9I29+sX8PVl8ziWVsA4ZMxTkxB0k0M2i/kSvFtyIsJJk6jFaPuPs
	fZss1oX0ZPFIHSTyUsmt9rJB0y1GhwV9LJ0d8+mmcHmVIh9J1ez8Ydz5Usj3Ixdc
	aCOKe9s0mmxUQ4/NUMWxWD9XOLXNSN6TpoZNycqgGpTa+wZlFqcHrhRbus5f3ucp
	gQnqij5Pd0vmXQcs/ShWoMOQkP2QaTMriqN6oB3pTtlfyaI2KgrhjO/LHojX6PUv
	i339gAHL615OpANsf/NyfwKD3ezGwfoVpCQwexg66x/nwEZrVCJQqPVQSwQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723100428; x=1723186828; bh=cdVBeCSqwyHD7NUdWwLDlBaqyOPi
	5czOtw2hy+ltY/Y=; b=RXRo1fdYjaPAkZakMrZgkHPYay1a2qRtpa0S8uvEtW/5
	+OJ134dhv1lIZG7kVpFg3AP/ERbcoWYhSgqxJ6L4UWonHP0wV+k/Iq065QMZ028c
	Q5pmT86ViBjel/zZq+UY24Q4CIReDZ7lkQSRUTbdzUK5gK7XHUbjmkRCjv59sSxD
	msQQ3TZ/jQ8biq187R4uotLcR6HcSS1dWfc114AJmMeUkU3g+Rcz/uxXe+qxD8Ru
	KyIDihNIxOaE1gehcIXdL32mgSAaLC6L5nU8S8+5sz0seN94b4iBby5HW33/j0eZ
	Aiv1pa9QFDlHqsmtohM5vWW6aZ5z7qt5npwWDwNydw==
X-ME-Sender: <xms:DG20Zh1ZwTIlZ_jizvYWI9GsAopgdMqcz7NWh_-4SAzIl5P-ofXK2Q>
    <xme:DG20ZoEbFec-ukQfCUUOQ2q7BXRpQf7dE4l6b-bPorj8cbmdSOKSALS7kI97m50s6
    JcZ7wLtkB9tiYsVSw>
X-ME-Received: <xmr:DG20Zh70_ooiLq9nnLX5qmJGeireePUR7l3mjyMrs2NlVXZBpEnnJYsyZdq9WzIAkv5VTsSf4FkazSLLxP_H4DfXsxUNklD5C1BtvMED3zwq3_mp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeg
    hefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhholhgrnhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:DG20Zu1QbJJS_JdEfvbWUq5U7NmtIOtjVcuKCkPg3fXpLJHxHMumxQ>
    <xmx:DG20ZkEnkwVqYKANjJH0zzwSph3mbWZHCjTN54DYcC8Xj8uSigiMlw>
    <xmx:DG20Zv-4vqNGcoKRsDBGKBKSOSbFMxCVoGS13yV78LpLPRxYn0fpDQ>
    <xmx:DG20ZhlwGzKCL6ycSMPIVp5SDPFyTnFvYqlpZJjFY_0LCYMbbwcNbA>
    <xmx:DG20ZgiJt4_eHQYDlXSOCFcoVMrohV-L2YbwN49WF797iJmgYk6Pxf6Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 03:00:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d0323f3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 07:00:19 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:00:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>
Subject: Re: [PATCH 1/6] builtin/submodule: allow cloning with different ref
 storage format
Message-ID: <ZrRtB46vu9rC000y@tanuki>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723032100.git.ps@pks.im>
 <a450759bd1e0d84192fd8b278b660fc8527369ca.1723032100.git.ps@pks.im>
 <xmqqwmkslz7m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uDgne/nf5kVKXOpe"
Content-Disposition: inline
In-Reply-To: <xmqqwmkslz7m.fsf@gitster.g>


--uDgne/nf5kVKXOpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 03:55:57PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > -update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] =
[-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--de=
pth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <f=
ilter-spec>] [--] [<path>...]::
> > +update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] =
[-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--re=
f-format <format>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]sin=
gle-branch] [--filter <filter-spec>] [--] [<path>...]::
> >  +
> >  --
> >  Update the registered submodules to match what the superproject
> > @@ -185,6 +185,9 @@ submodule with the `--init` option.
> >  If `--recursive` is specified, this command will recurse into the
> >  registered submodules, and update any nested submodules within.
> > =20
> > +If `--ref-format <format>`  is specified, the ref storage format of ne=
wly
> > +cloned submodules will be set accordingly.
> > +
> >  If `--filter <filter-spec>` is specified, the given partial clone filt=
er will be
> >  applied to the submodule. See linkgit:git-rev-list[1] for details on f=
ilter
> >  specifications.
>=20
> Presumably, if the named submodule has already been initialized, we
> are not converting its ref backend with --ref-format=3D<format> option
> when "git submodule update --ref-format=3D<format>" is run.  Would it
> make sense to say it is an error to give it without "--init", I
> wonder.  If so, we probably would need to see if other existing
> options like "--filter" also need a similar sanity check, if not
> already done.

Well, even when "--init" was given it is not sure whether the ref
storage format will actually end up being used, because that option only
tells us to initialize uninitialized submodules. So if the submodule was
initialized already, then the ref storage format won't be used.

We probably could add such a sanity check. But as you say, other options
like "--filter", "--depth", "--reference" and "--recommend-shallow"
don't have that check, either, so it would feel a bit like opening a can
of worms. So personally, I'd rather defer this to another day where we
then implement the check for all of these options.

Patrick

--uDgne/nf5kVKXOpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0bQYACgkQVbJhu7ck
PpSsiQ/6A50PgsKZ+7mXPjseUtCyMA77Nm5T6+aoskg3iLCsUVPvRwQRWbj5kj5b
GHr/28QxVRWMr2YNoV6GfjmzMBTavjumRBCueLN2HymerTBfjoG5RPmwhq/RDERW
WG06ebB1x3ENNjMreDnpFACG6i6VaiRn7jM5nfzv41PpmPi+dacHdqPtgu6mr4r2
1ldVs86zN9QPWYS5+q/Jopo23a50iIENYCf/T/N2vbbz70sfd8pd55UZ8XkfIesc
KBW5mq71xVErRbnrfTdbsmjkGG/CyIkolkvlRcqzY4T1Yxu/ozlCu1qxWU+X6ZOF
ZiyRK0NF08Hdqxm2XmVVF2ez/oR3FLQeL+eZDF5K1ZeCA4b7sYmF0qGah70t/cTg
zkPGDc8uuFbakGm5FrJUfvvVXb32/Jf+quPe6lylxxII2H2aRFxeiF3HFmRICLB2
W/2K193bhnfC1fknvsQ33W+aqLajQP1S+hkzRv86oPMdjRW2xK+24iH64NBinVH6
xbVDfMCoQTUPS5N4bFX1SgSqoJZXvOBl94P+8Wxrp45QZE3OzjtExFlXi6Nfohk0
WYPK6g5DzIQBW0qQ49eiVF9cjlP1TpPovtSKY6YTC0yiZch99MgrR1YaeziRD8Ze
sNOr///0DEQtRF6vI8VnRlWSjFxBp6w33woTtFzakjYzHTxt2/Y=
=VWPb
-----END PGP SIGNATURE-----

--uDgne/nf5kVKXOpe--
