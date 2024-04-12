Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711941BC20
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897044; cv=none; b=W6LU0aGALYdu/H/65oHSp3XUw6F6u3KazGaBsuZT8auLjWAwN0qsRmMhhYX8BxlAHpTmvkiGHfsar7nhS8gEX5wkOpZLg3KCXM6NXe5clbP7tdNyxi6txcU2lUUaiputpGscuplnsILGLVESmlfp9L3PW5i5ZtNRCi5bEvZylyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897044; c=relaxed/simple;
	bh=v8bZufYaDK91f6ZgUGZF0eRI4DMD/VHiYDK3dmGAKUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW1ekAbamtOqrmux6bXI1Iy233/uKLuTz3K9rkZvmVCjUyvolIJXXFOElSix/9Xa+fKCFDfCv3wswQT9F7+J4WVtUwtXecakX9CoClsJC2JXr9dSIHA7W+11Jxx0JanhB1mfoLhHPl0vQ5nY0FlPtPcgQwF2GMkBn6wxYNwWyOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GUzBtH3L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x0nvqCta; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GUzBtH3L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x0nvqCta"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 178E713802C9;
	Fri, 12 Apr 2024 00:44:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 12 Apr 2024 00:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897040; x=1712983440; bh=w2PiDLnzlC
	j7tn6Yx6N4n/UzkDz6lFfvLPDrdZkqIi0=; b=GUzBtH3L+rdlVMjFNmTCxlEhVy
	IJDDrBUbmb3t6qHPsUYmahlX2BFQRWg6bghDULsuctvbHUCnyi+KN5ho/TzY5HHg
	lXxfoE+xtX+4AF4lFrBs4CrIzEZWgJv2z7NkHrQV+nxeuwhHqS0QRsjY+s4q0jWc
	tmHM082DjkGX1Xaq3mF0or/DxnH4A7f+mrmwh/uAULNZ8ObIh70N9m4AR+xp4+WW
	+Z1ZTWJsL11bvfroH64W/D32ZFhQVTF5AHrz57DUkKtwTxz6ERRdkMcT2L57hvJH
	j4sP5E1SXBq39OXAq4/n7ZvWZC3M33/fJInGn2VdbJeDN47YT8UEYZs4TB9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897040; x=1712983440; bh=w2PiDLnzlCj7tn6Yx6N4n/UzkDz6
	lFfvLPDrdZkqIi0=; b=x0nvqCtaJvjtBOf5AV8KzXQ4icoY2baknJgvG89489Ez
	XSkHxdsWD/XEio/sjJVnxyT8eS4Md1ZaDzF6A4pY8B3Oa0Kgs0j5s90Xg6SmsOBn
	q6Iskt0dPHPTzi2QuZzfYjjdIwhhZMnqVW6wM8/2Cseb39po/M+1pn8WE3D+BpPx
	gpRDZx5kPmgUKRx1wmbvM5/3UWRdPmKBGaJjPMuXdnJUldIIQSSXeiL81X01PxZX
	UXUtR6dh7Jq87qbwQ0cPShyZwjV8z6gA5e64YFBqQTRE3SByJ/WhFjoLLgWFgER0
	GxOfCMamMfjv3FswzPFup+2zF9up79mXfvkrprlJtQ==
X-ME-Sender: <xms:D7wYZhB3OABceptjveRXBYL8rPJxAgMBZTOC76CWRXcV-hIR7QXLdQ>
    <xme:D7wYZvgtub2Irxw-Th1o6gn5cnyvYcUDClTkY7Ein-VTzJ5Kr-mzBgKq1Y2yyiprv
    VIzmCQ25Eh5nhePpg>
X-ME-Received: <xmr:D7wYZsm6JY-9DRYtDPSaWAsh2P1Z1fOYO7QkaW5m76piLQYquEsrttAVYlmqIwfLVxqstTN0QFBRqKCwbSE4QP2_a9FDWZEtcHEH4_wUw6eU3I6vOAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:D7wYZryJEJ3VcINpLysFq_I-p8JmvvMrIWSe562ET7UdjAIdOHgNRA>
    <xmx:D7wYZmRRXfnUF6ycWRHbmkdCIj6AiMbqD8o4r7gUy9erZo00NcAgVw>
    <xmx:D7wYZuYb8kScbQpA0ExAPRJ_G42cl6BnI5De4cQjXDD0z29s4PJx-A>
    <xmx:D7wYZnQWzH5L7Nyys865S1KSbkAjsCxHJ3QM6hNcoYKvpHiVVyRC8w>
    <xmx:ELwYZjQmKmVJ1cmZ9j5ZbofITjziDn8fuWogxEsPa2ynLCS0RrDgsdpr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:43:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 63836125 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:43:41 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:43:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 00/13] t: exercise Git/JGit reftable compatibility
Message-ID: <cover.1712896868.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VKPI+shQkDHPNtgR"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--VKPI+shQkDHPNtgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

here's the (hopefully last) version of my patch series that introduces
Git/JGit compatibility tests for the reftable format. Only a single
commit changed, where I fixed two typos and added a missing signoff.

Thanks!

Patrick

Patrick Steinhardt (13):
  ci: rename "runs_on_pool" to "distro"
  ci: expose distro name in dockerized GitHub jobs
  ci: skip sudo when we are already root
  ci: drop duplicate package installation for "linux-gcc-default"
  ci: convert "install-dependencies.sh" to use "/bin/sh"
  ci: merge custom PATH directories
  ci: fix setup of custom path for GitLab CI
  ci: merge scripts which install dependencies
  ci: make Perforce binaries executable for all users
  ci: install JGit dependency
  t06xx: always execute backend-specific tests
  t0610: fix non-portable variable assignment
  t0612: add tests to exercise Git/JGit reftable compatibility

 .github/workflows/main.yml             |   8 +-
 .gitlab-ci.yml                         |   6 +-
 ci/install-dependencies.sh             | 101 +++++++++++++------
 ci/install-docker-dependencies.sh      |  46 ---------
 ci/lib.sh                              |  14 +--
 t/t0600-reffiles-backend.sh            |   8 +-
 t/t0601-reffiles-pack-refs.sh          |   9 +-
 t/t0610-reftable-basics.sh             |  15 ++-
 t/t0612-reftable-jgit-compatibility.sh | 132 +++++++++++++++++++++++++
 9 files changed, 229 insertions(+), 110 deletions(-)
 delete mode 100755 ci/install-docker-dependencies.sh
 create mode 100755 t/t0612-reftable-jgit-compatibility.sh

Range-diff against v3:
 1:  46502bbe22 =3D  1:  99b0b60359 ci: rename "runs_on_pool" to "distro"
 2:  d076ed9857 =3D  2:  e1d4e1320d ci: expose distro name in dockerized Gi=
tHub jobs
 3:  cc0c29052f =3D  3:  44a0e07600 ci: skip sudo when we are already root
 4:  803f5020e0 =3D  4:  8e58ce38d9 ci: drop duplicate package installation=
 for "linux-gcc-default"
 5:  d2745e9438 =3D  5:  b8f56a5e67 ci: convert "install-dependencies.sh" t=
o use "/bin/sh"
 6:  61f108d954 =3D  6:  ce4f0c766c ci: merge custom PATH directories
 7:  ef61b578da !  7:  9fc462b578 ci: fix setup of custom path for GitLab CI
    @@ Commit message
         root user, but runs tests as a separate, unprivileged user. As the=
ir
         respective home directories are different, we will end up using two
         different custom path directories. Consequently, the unprivileged =
user
    -    will not be able eto find the binaries that were setu up as root u=
ser.
    +    will not be able to find the binaries that were set up as root use=
r.
    =20
         Fix this issue by allowing CI to override the custom path, which a=
llows
         GitLab to set up a constant value that isn't derived from "$HOME".
    =20
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    +
      ## .gitlab-ci.yml ##
     @@ .gitlab-ci.yml: workflow:
     =20
 8:  7748f87f8c =3D  8:  e7a17d57e7 ci: merge scripts which install depende=
ncies
 9:  f7399382f2 =3D  9:  720d5a4682 ci: make Perforce binaries executable f=
or all users
10:  b835ff8b78 =3D 10:  77f6d6ecaa ci: install JGit dependency
11:  7136c8b6c2 =3D 11:  acf0c28550 t06xx: always execute backend-specific =
tests
12:  cf4ee9c427 =3D 12:  a9b71e8eea t0610: fix non-portable variable assign=
ment
13:  a9cd20eebc =3D 13:  218c694d2e t0612: add tests to exercise Git/JGit r=
eftable compatibility

base-commit: 436d4e5b14df49870a897f64fe92c0ddc7017e4c
--=20
2.44.GIT


--VKPI+shQkDHPNtgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvAEACgkQVbJhu7ck
PpRClQ/9FM1zDAzlTPpoqggTMtdJFu2wZPQDRqN1McjHWt5DzOTNzIvwDVccOzFw
VS2ur3W9o0gQwnC0fNIkooYFC9DQmsRr7gm3DdU5IPDV2WiTD6TMTr/LprTVZX7F
dt5K4sHkdgOYZlcbvE/EsxT/F6BDf4I5tdYjkPwXCE2xNNUungO9UdRPJ2HX/PrQ
skYqbvM6+AU3QrMRVFzaCG9sJQ5EuHTcA0itN8DiZaewMODggrlwU5Cq2/Fbd1aZ
e1Zz1GLvHFYDftcZpMAGQ2hUs7/mP/Pjn6u8KpRyy8826jc7LnJNLtfrMkrGu3Qh
IQuE6yAKPOUhb7Taiv3XR9hrdYuYL8WSI4NTiVp6LILnZBLiAHz6n1lU50HZxO/7
/low5aEvaUT6uq8xtthMnyJjkttmB3HnQ1/JkX5/lnCfnJyXgqr4qz9YhAVbuAh4
wtPicfp9TkCoxwJjrMJE8dplxYFtwWZAgGQnAS1dFVcJns2x/QPIWG0SBk0oNVH0
6XO9w8S0bdHu4WJRFRCDAu2F+T8ERZmsd5kSqn3CHTZywknW+LuttidKsK2DG6Jq
G184JQEhBulaad7Ebx2PB51fMyon3XOulUBg0VIzO6OaIJ/IDFFeYegFGMnsO29s
95TvxibWuOELcq27A1h1JfoIUhpKvzO4Y+Kko5Ox/uVg2K7uZ9E=
=amaB
-----END PGP SIGNATURE-----

--VKPI+shQkDHPNtgR--
