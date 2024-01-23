Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A95FDA3
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023349; cv=none; b=iHF860RRJoXZGvv0+o1nVb9KXh7X7Vm9pPC+OU6juMrQN/XKslX6L0dEc2JqamSqtPidW1fZYxOtPtRFfBxyxdw7kJx2TMg+SCED8n2PuPFYUB8RWpEFVuxbScLdW741untLSWhPFED2CYyfQ4MgLj7+xiLIdMF93YEdvKZzljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023349; c=relaxed/simple;
	bh=LEuLibCpt1VYDN0r+HE6OjTpNXTWxQ8jpclrSjuxtqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXwjannfMQQmso97t2qWHqGRqRYNNMpse4cNWPqugPHtIPCXWXpfznmJFBejk9iwS2uMRlE2Ie1uMXUb/D+465cBKG3yJ6tKTkej92h5PCr8bPYSzHxuZf/8nUTwqPDiX6XgQUjn/9GX4Q0x3LFOCf7Wh11CAj2FwBfNHqQlPDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RjctkSop; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/ThsRYd; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RjctkSop";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/ThsRYd"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9407B5C00A3;
	Tue, 23 Jan 2024 10:22:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 23 Jan 2024 10:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706023345; x=1706109745; bh=hLqIRO0bqm
	cw7Dn0ttvUVk/nxM6tD6Pj1e/EgHy3pfE=; b=RjctkSopyBBCoeWEwKdk+WmohZ
	0ADTtfza7hzJHHSPUHm7j74uHA4539v7vtkKk+I7kXdFo8jFjD5Y2hy07X/W/LUo
	7C+CKEU+v7Gxp4Xg47hnHdXOkA60Cau6wrJLksPpi3Yksa/APsl+E62H7T9fN2jB
	qr5yIoHKpw93Kn0OVrxJlZTcsl3jeIBl8jFGvxGnR6U1qtx41tVt/GeNZIo0ZtFt
	cKX0Mwo4JI7lpW4LjZWYrEjJIBeogPgz+ZIfj6hyC4DpkbOdMK2ck+2pXDddy8Xs
	GhwdcWw6reTke+TMtz3NBGsZOeMlvOuv0Vke7CxJxeunn95ZELMvxVkL3QDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706023345; x=1706109745; bh=hLqIRO0bqmcw7Dn0ttvUVk/nxM6t
	D6Pj1e/EgHy3pfE=; b=A/ThsRYdRhC3xhC6YV4Uzz7NDcnzNyPvbCzXoNfqxqsY
	g6YXl6vv+x+e98Bf/KT00xtKBHTR0czOeU7Kft9q0tbfAYtLGPZRPZEEEZmLmYJM
	jZRzhEGuwbq0QKi0/eg/lrfyh++rk1A2Iae4LilC/mTPCzjiDcZ32V4qcw+HUEh8
	ZVV8MeAzfp8wpJcD9dmFFOBj5BTrMa0O2Fxr662ltLKWqyIHOrK9CYo2/vK0P8m0
	LoOp7jplWHBuBufPvdecxjlEi++S1HPhAslOLIlhSUj75bUQyraBVId3sf6nCl7T
	XzPt7JZMCXSMLhJWTq7ITMNC1jahiMpJbXU0mOmBPg==
X-ME-Sender: <xms:sdmvZZKyAG-_QATYq1fUJLuY44JsDTr9pIYTHCqMRvD8pjRCsZaHlA>
    <xme:sdmvZVJQSWaPRi6TfP-iT2YSASNZg4VZJyTHfU8jh9BTwiMBD_TAVTdMPdgRKzRYY
    kDwGZqacEI-r6VRgA>
X-ME-Received: <xmr:sdmvZRs3WYraT0hUXNqqISgA5_mMBV6Tol-1ev9pAab_PSnIE7GToZ2LDhBPfE3Acl1wMWGuk28-dYuf96Jufj68eT57D9GoucstvqnceypT9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:sdmvZaYkRou8m0BKMRiRyb-p9LwH8ZKPIhBFpJq7FiO5d-HYWo28Lw>
    <xmx:sdmvZQaDFkvPEBQBCqkZ9J3wzsGEwkw8lEnlUobQ7CqA3uQvIsZk4g>
    <xmx:sdmvZeDJu7Byaspv1EmnrHdM6fOHbpqGt9LIAsp7dMXrtUO0EYasRA>
    <xmx:sdmvZfmq8A82hg9zueAmoGP9jwaa_lP-3mT7RiRx9XmC2EMjKNdPvQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 10:22:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ae538504 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Jan 2024 15:19:19 +0000 (UTC)
Date: Tue, 23 Jan 2024 16:22:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/6] t1300: make tests more robust with non-default
 ref backends
Message-ID: <Za_ZrtRMEmVHu_o5@tanuki>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
 <0552123fa30243d6d8d6b378991651dd6ade7de3.1704877233.git.ps@pks.im>
 <87ede8qhw9.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LPg93JBaVyp+eXza"
Content-Disposition: inline
In-Reply-To: <87ede8qhw9.fsf@iotcl.com>


--LPg93JBaVyp+eXza
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 02:41:17PM +0100, Toon Claes wrote:
>=20
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > [[PGP Signed Part:Undecided]]
> > [1. text/plain]
> > The t1300 test suite exercises the git-config(1) tool. To do so we
> > overwrite ".git/config" to contain custom contents. While this is easy
> > enough to do, it may create problems when using a non-default repository
> > format because we also overwrite the repository format version as well
> > as any potential extensions. With the upcoming "reftable" ref backend
> > the result is that we may try to access refs via the "files" backend
> > even though the repository has been initialized with the "reftable"
> > backend.
> >
> > Refactor tests which access the refdb to be more robust by using their
> > own separate repositories, which allows us to be more careful and not
> > discard required extensions.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
>=20
> > @@ -2009,11 +2020,11 @@ test_expect_success '--show-origin getting a si=
ngle key' '
> >  '
> >
> >  test_expect_success 'set up custom config file' '
> > -	CUSTOM_CONFIG_FILE=3D"custom.conf" &&
> > -	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
> > +	cat >"custom.conf" <<-\EOF &&
> >  	[user]
> >  		custom =3D true
> >  	EOF
> > +	CUSTOM_CONFIG_FILE=3D"$(test-tool path-utils real_path
> >  custom.conf)"
> >  '
>=20
> From the commit message it was not clear to me this change was needed.
> Do you think it's worth it to add something to the commit message
> explaining you now need to copy the custom.conf into each seperate
> repository?

Good point in fact. The problem here is that before, CUSTOM_CONFIG_FILE
was using a relative path that wouldn't be found when cd'ing into the
respective subrepositories. By using `path-utils real_path` we resolve
the relative path to the full path, and thus we can find the file
regardless of our shell's current working directory.

Not sure whether this is worth a reroll, but in case you or others think
that it is then I'm happy to add this explanation.

Patrick

--LPg93JBaVyp+eXza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWv2a0ACgkQVbJhu7ck
PpQ+AA//bJ+TAyNh8Aq92918JHvEwGCEu90nyZUfj31a7Ar9qtrw2DhYd0nM+L3Q
nDxiA1LTVoAx5aUxX8kVBfkta5PS6z3y8YhOgNgZHce2oEj/SNJN+LMhkBUi1/ux
KLwtVNdWcLZ5XyKAsCKDkBGPIQ6DNd5yeGxL8S8dxqBqMCYwtwnR09/3TlXAtg7Q
lbbUeODYGzeTRTXHkEl4fLBUQ1hmEJ0mlRiHlDFFzKYKQi2H98WyNa6N3yXJlCmP
+16J/JkzBgv0vhkcCPBY2H6sRVncETD5ETtrS6Nc5e4e1qmloTeXRNcu52r2FSyR
Pohh9B7qtRu+Lgp6h28pyOX8YjF8nveh40LRbMZafp9KAhBPSZ2/W43xaLvoYiF7
4Ihi2RaHQsQecdS+O0eZOCNvo/ZEvruKoqlWWwBwwUgihNJZq+jxIxGkOjdfWw6O
wBXBDMzzmffQTjl7DIDpRe+LWaWJgAqVlrbQLKxyKptyI8MHOVgCbMBpdNUNIA6C
CE45GlL1+d+irGiHS3nz2eyGArpBQtEHV0XlOGef8Mn48fMM69erJCOJvHNOfTYI
uMLBUEM4vNXN80vUD1D2oPLhW+S2rxiVi9SQ75LxM4YiKnO1mLxqYjiZyEz2n1et
EiNmsl9AwgeendbGoYjhC06EpOBJqKfhmTlIDazMm+1f+AtBRls=
=fxYe
-----END PGP SIGNATURE-----

--LPg93JBaVyp+eXza--
