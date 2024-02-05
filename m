Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E644BA30
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112974; cv=none; b=amv1jkGtbm0J6/j4Sp9YRooucfoVRNveoqE1W6fpre5yA/bUFpRxmzV2MFOAzAeERsX/phll3NFPhffdrdEP5Y8IRK7MicvcM6bsU4T1SJ9bWOyZ0qf2FG5KGys2xyRYwmpHjxUXGXYE95bvjgXTrDmUmkINJP53d1t1fNBXPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112974; c=relaxed/simple;
	bh=GPk+vsaxm/O4uTszSg2vTfWqgTza1LsOj2eLJKFwtNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l13swF0fdvii7xfG7bDRTU+5eoDYMHe8gv2F2ZlGIbvSM3E9Uj7BhAlbTf7rFKgAsN7dcLw8BmyZqfB6cgC9bnHih0xCUxlLiKW4GYmEmUlpzX+5WSvxrDzUP2TCHdUasCH1Pm9lqIj9wXlP5BgZNX1q9Z40kMF90GJVUJvMQg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MZH4rDG+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r+mS3xnX; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MZH4rDG+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r+mS3xnX"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 3777D1C00045;
	Mon,  5 Feb 2024 01:02:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Feb 2024 01:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707112970; x=1707199370; bh=yy1UvjVCAL
	U2YDbiym1ttuHfxAchveQsdvj8mz9gEss=; b=MZH4rDG+5fRXwBAUIWRmqD1vdC
	TUR6CqrJyR7hEwmVMIYE/Isv1u09qDnabPzrfJ+5d7zQg1v6UxRg7a5Dylou/Kiq
	JYvxW5mkpDjELSF9gB1yYDnVnf6Qlpp1C4X55Jj3fvuXD307YbjPHwyuhs2W3n+P
	m6Vkj8neUdIcEAl1m3tg3H9TEhXsq656SqBTa7Gf5xEqFbeJx6WvQ6n/jBKpi6Ps
	k7ecycxDb47nMZaFeFQGslZ4jQu4achBx8D3WKG0JtNzBfbdSmN7zHgpJErIWHiW
	lDXZDVPtdapad1N9LLQ05+0BCgBTZUl/fhI4idrrU5xkbSBSgDEm6Sq2/z5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707112970; x=1707199370; bh=yy1UvjVCALU2YDbiym1ttuHfxAch
	veQsdvj8mz9gEss=; b=r+mS3xnX9+W+dSxRUZXTLb6vZm6iYCaS5EDmcfpYmnsS
	gLIZrXjVHDd3noj57ixbaKKZMi5i5//iSI8lG3/5/aKI9j+rMZMXE8O/awQ16s0K
	l49l5/7Cp65TFGcRJb7tgGrTeypzkZMW61P92EhripyQBCnf6K/mG0AzVFD6zDid
	or+dS0Tz9+xRM2JItbQh5lBbeeeDNqB1bh3Bwfnv4pQa+Q5xO2YS3M3jyViiU2aq
	dn9idx7wof2NmzCgKTOeVQMjo01oHdDutQfr6Cn+Emjv240fxdvXi6stc158J1rq
	zyRtFxjc6Pvbd6nAEUcFW38pkNjf7lcPVlfbjpqhqQ==
X-ME-Sender: <xms:CnrAZXh3tydMYpQxVyZdUMC_Dj1mXVzJPZVnFCXSQGP5ccDL1wy3rg>
    <xme:CnrAZUDKCTnWATXQrlCOGi6af-FGIUMxEOkELrjMPJhJGN3FdDzWcNSR96U_ChNax
    -yEdpXwGxUlThyekg>
X-ME-Received: <xmr:CnrAZXH1QP8lTH--gdR6vPvxA8omIGdvRe1H2obnZcAOBzF69zIeq2EClM7cNLDllBol8MmY6Zo7TdcvjGmlV_PtVhdyMmbCg9QnlEQBeoGDDJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepkefhkeevleeifffhteehteevfffgleeluedtjeegiefhfefhgffggeefhfeiueeu
    necuffhomhgrihhnpehhthhtphgurdhshhdpuhhpuggrthgvrdhnvgifnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CnrAZURzO5JAtSaz35g-IsWWqSPya7yRrkoVwe66aSUULeD4zDBV6Q>
    <xmx:CnrAZUzw0iOzixkYeUA7TRTl7f1reV4KLMDtQ14MSjAuraZphCi7fg>
    <xmx:CnrAZa40q7O5YrjF9hChNZSgJuxJUhhs8EzZtpwdM_apExVhj-LVoA>
    <xmx:CnrAZes5leONOgr5YWvGbR8WT2QKB2unbZ85xPniOD6O9Crn6jCkgg780d8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 01:02:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f7422e51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Feb 2024 05:59:20 +0000 (UTC)
Date: Mon, 5 Feb 2024 07:02:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/2] refs: introduce reftable backend
Message-ID: <cover.1707109509.git.ps@pks.im>
References: <cover.1706601199.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c31Nztv4TUHRrsFs"
Content-Disposition: inline
In-Reply-To: <cover.1706601199.git.ps@pks.im>


--c31Nztv4TUHRrsFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that introduces the
reftable backend.

The only real change in this version is that I've pulled in
kn/for-all-refs at 693e807311 (for-each-ref: avoid filtering on empty
pattern, 2024-01-29) as a dependency. This series introduces a new
DO_FOR_EACH_INCLUDE_ALL_REFS flag that we need to handle in the reftable
backend. With this change all tests should pass again.

Patrick

Patrick Steinhardt (2):
  refs: introduce reftable backend
  ci: add jobs to test with the reftable backend

 .github/workflows/main.yml                    |    9 +
 .gitlab-ci.yml                                |    9 +
 Documentation/ref-storage-format.txt          |    2 +
 .../technical/repository-version.txt          |    5 +-
 Makefile                                      |    1 +
 ci/lib.sh                                     |    2 +-
 ci/run-build-and-tests.sh                     |    3 +
 contrib/workdir/git-new-workdir               |    2 +-
 path.c                                        |    2 +-
 path.h                                        |    1 +
 refs.c                                        |    1 +
 refs/refs-internal.h                          |    1 +
 refs/reftable-backend.c                       | 2297 +++++++++++++++++
 repository.h                                  |    5 +-
 t/t0610-reftable-basics.sh                    |  887 +++++++
 t/t0611-reftable-httpd.sh                     |   26 +
 t/test-lib.sh                                 |    2 +
 17 files changed, 3248 insertions(+), 7 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100755 t/t0610-reftable-basics.sh
 create mode 100755 t/t0611-reftable-httpd.sh

Range-diff against v2:
1:  d6548dcfad ! 1:  d83e66e980 refs: introduce reftable backend
    @@ refs/reftable-backend.c (new)
     +{
     +	switch (log->value_type) {
     +	case REFTABLE_LOG_UPDATE:
    -+		/* when we write log records, the hashes are owned by a struct
    -+		 * oid */
    ++		/*
    ++		 * When we write log records, the hashes are owned by the
    ++		 * caller and thus shouldn't be free'd.
    ++		 */
     +		log->value.update.old_hash =3D NULL;
     +		log->value.update.new_hash =3D NULL;
     +		break;
    @@ refs/reftable-backend.c (new)
     +			break;
     +
     +		/*
    -+		 * The files backend only lists references contained in
    -+		 * "refs/". We emulate the same behaviour here and thus skip
    -+		 * all references that don't start with this prefix.
    ++		 * Unless DO_FOR_EACH_INCLUDE_ALL_REFS is set, we only list
    ++		 * refs starting with "refs/" to mimic the "files" backend.
     +		 */
    -+		if (!starts_with(iter->ref.refname, "refs/"))
    ++		if (!(iter->flags & DO_FOR_EACH_INCLUDE_ALL_REFS) &&
    ++		    !starts_with(iter->ref.refname, "refs/"))
     +			continue;
     +
     +		if (iter->prefix &&
2:  63eafc9f5b =3D 2:  146bb95c03 ci: add jobs to test with the reftable ba=
ckend
--=20
2.43.GIT


--c31Nztv4TUHRrsFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXAegUACgkQVbJhu7ck
PpQBmQ/+Llsn9J97XZBiYxYZZ4eKZ/rBc2V+FX1i/c4+LHR/OjBXNgwbSthniZrT
QU3JFaPdKVTTskCeT//i6gqpl9yl5ySpmYDgavmb83qAtdzYgCB42EFFGy9vEuAl
wtxnElCdN40HVnN8wHnPFe9e9xCIOeTZsAdUmAI8u4mH8YDv7nZoM3XNEHD7wcgQ
q11grPN5w4Rfbu9RYrg0m+eB3/QMTA0bexlq2Qss828iLW9uCSqq29gdGcy/hKpQ
470mQ13+ZGYqHt4fSUDoMI5P9wVbTsQ7z/Bxh8pJmgy0w4A3zIKZO7Lz1eYmeKAt
yLcPiRJWZTz/CVMpRpnGOQnzMWtmtj1tcoWml/ys0n+IWkp+wqf21mim4iDgUONt
VG/G7o6JdDOYmMcfCqPkZBXWFpAmISB5HKC0qm98rrcF5Cia9OpgPv/SuV4WTPxG
JYa1tzEpvLWZakSnxqQI+Hb79shnntBERDeS9EA3DwLa3IFc+wFA5i4kx2yo0s+8
GLgc2NDJVjbkQlQNKk3zT4EXUWmhJ00PGkz0Uk0txT0BkNKVByK3SS+EG/HF4SXq
XVjaFMBJzUPMcTGcj8dY2dJK1YvxvjOLaWUlHUIeNpsebQH4meE3lSnECfABsErS
AKuDmhlftLuqmFCjQHGBoBcjThJj4Hpuo+zwLHaAAY404OFVbws=
=rPSD
-----END PGP SIGNATURE-----

--c31Nztv4TUHRrsFs--
