Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB0224DB
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897083; cv=none; b=cY/vTTzr2sDG18KOHjqF+pGfiB6hyS1GkB1levPGLqL5OD0Qme0gYG20F1mhDOTjV+oLxEFyOLOfESQ7AYgE2LB2DiA/ZQ1SYvh5+0F4CMiutRJZxdtBrIjX9cvXiSexIRs04SmJB22zXDcQKoXpigQFBabPi3VKSti2lA0pxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897083; c=relaxed/simple;
	bh=A0QdMs3tr4XG9cji3OBd1FBCqNV2pFkHPGMhAMNnl4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld3sQpbFfg9MGN8/AwdDK84GPiB+rRLQ2fzNyXJL0wZGOhHYIOjETOTpxrHyb7TZT1E3h8bxd9GUPHL3mG20+HGSW86xg/kEvz6kip1Ol6Z2FUFUVRXEjASjlW2CI/m+Td+y+oF3MDT1tXphTfx4Tue+891fNBKKKe6P7E3BsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RpPY2sWf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3273I6w; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RpPY2sWf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3273I6w"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 036FC11401D5;
	Fri, 12 Apr 2024 00:44:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 12 Apr 2024 00:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897081; x=1712983481; bh=1GUUf6HYMI
	OavK6CIPV38Rh1+jA3RUbsRXSQ8p9tMp8=; b=RpPY2sWfoxoDbYUNRDpqjEcMxU
	w80gkeU3z1Z7eX5ul4mOpd5jq/8jfPgYvxO86W5UgMOU5rXXeihDFyNCd0xnCLXh
	aAFvjRRS13ZLqTLSU18gHhU5/hRDtFJryPf+6gfF0M0DbHiTdSevCZHk1R8doJeK
	+BINTQIJi9MG+rfHHeSt8flTXxKDRclzDpX8Y53XKqXgjyq5D2gD8/Y8EP/I0dQx
	ZEBD1aZ8RZzQO/Hyr4TYCJ/3OQhA5xG24A1zwrxM8TzRy4/JqWWzyIAipRObi9NP
	T1iVbdfYC1qkceU3r3FMfizIi+SSxYY7OldEj7H3LaXLtdia2afUUZIGueuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897081; x=1712983481; bh=1GUUf6HYMIOavK6CIPV38Rh1+jA3
	RUbsRXSQ8p9tMp8=; b=l3273I6wH5yz0jAVRQOXDaYiQfO1gLgKyZsQBwIyG1yM
	w84me7lVNN7zuiJlfeqvpyHLDHV8bEzmm42v8VUOirqqozObcuY3qYzyVxJQs5T9
	NoNwp8AUbZ1j8Gx75BDCEAvLUEPFs1WYSAKVqXuB+z857mVEf3H4P7dT0RpW7Ppy
	kilB3fxpMoiDDZMFSEDoHEXOb+gK8LB10zv87cKfEJDqGzpPVofIMD2kFE8el2md
	RJm1xvepu2fcqiMc8eQeluPosySKqIlCgLca35rO+4PaCjQCP+gABsIZVHdbsXCh
	vfmwxRFv4LsYXlKbmIhXDouI1gBYJRug3i4WBouwdA==
X-ME-Sender: <xms:OLwYZvJjlPhRBHw3awW7TFkqjbMalB9sD8CPPIe1TcvjPPWA7djpMQ>
    <xme:OLwYZjIWCHBmxzmlWrdvpwnXidsJXNtuqHCFpak838uacmyroTsMLWVtct2X7A38r
    mJXIDqfCdAVPTPuLA>
X-ME-Received: <xmr:OLwYZnu32sBeiLnrvF3_2NPCabz2Qq1R03TicHLv0hp_KcfPJFw0WOfHj8vzPJZAa5gkeqkIga2XWC50j5ts2zR2SnZITpB-ctrvr0Up2jSy_5hLlJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:OLwYZoYNQLK37STN7OPMIl3PsMOWe-9IoDgh3IZ73sLJ3isnr2JvGA>
    <xmx:OLwYZmbqN1m5XCDkFYeXaYnB-XIsfWWtD4HrxW21TlWVx7ZczvMKRw>
    <xmx:OLwYZsANVUQoXIyYec5-ThMm8HkFG0pjaIE4MR7A-imbyOICiP9VbA>
    <xmx:OLwYZkbsLiISqGBH5TSt95N1VsdGNfgDeir0-hadJrWKktd3us-xfw>
    <xmx:OLwYZu6QS0M02_42Ee_5YrQBn9gRhLtV0QtrR-gSVcqZjQh9Ktj9wNPE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:44:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id da7b5254 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:44:26 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:44:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 09/13] ci: make Perforce binaries executable for all users
Message-ID: <720d5a46822231ce8cce26a0704d5a3e6ec95b58.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SNPvH3yDbtRl3s8P"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--SNPvH3yDbtRl3s8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The Perforce binaries are only made executable for the current user. On
GitLab CI though we execute tests as a different user than "root", and
thus these binaries may not be executable by that test user at all. This
has gone unnoticed so far because those binaries are optional -- in case
they don't exist we simply skip over tests requiring them.

Fix the setup so that we set the executable bits for all users.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index e673797115..0b9bb686d8 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -47,7 +47,7 @@ ubuntu-*)
 	mkdir --parents "$CUSTOM_PATH"
 	wget --quiet --directory-prefix=3D"$CUSTOM_PATH" \
 		"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
-	chmod u+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
+	chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
=20
 	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.g=
z"
 	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
--=20
2.44.GIT


--SNPvH3yDbtRl3s8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvDQACgkQVbJhu7ck
PpRn4w/8DY70NW1654PzCXsMeUd66aKeG9UV9h6XkZpYJGTw8ATgxRErDqNtrCNY
c005/sja/obazT1VZ2A6h08acgUYWGxZlo9MkFz5o08/togfdrVGD3dEP+V/f6YF
D8BI4ImkKUrqmAah7o0FvQPrkj76eA5CGG8azYRrtDu4DnC2VTXLo6lEYyh/6y7Y
/SflHrvKVm0EXwMWZN4OxMb3H023ThMXFCtDu4H19WvkAq3CFjsa4yKZMeLT1yHT
mnf5BGX9U21grL9YWJX+FKhnFVeECjKG/Qrqxsn7tUWfpgLDoSE+WIXE0NVvdEqc
DjU0S6jaoQiGwi+oWLLeRIySUNgKlvHgr0yNezj3+1hdu8e/GqDVgjut0sTFS65N
sL/9Ther6Xxr0KBdZzXEuLlWaGahvG5Odz0Mb4yRf+0t4I9CzDNy0PHVNo2QMRWq
8gE5YuZYy0sZDl7BA5x3bL0ZneIw130+mNjya5D0/cifrkYrZszGy638olRU5PUG
X4Np+L2+zOv1irSyjKcDl8TWDQL5wgVUz1MpCOnwMjz8TjgYc31p1uP8PqN3YrNb
YJHD5KxlUa1ryX/AGOWvQer3IJi4077lwleVYKQiSUhN1OU5WhZ8hFz5y01Bs02B
ur3Tt8fbc+he9UJE3alZ9KOlU0C7vI/6GZ/0cUd06UjalGPg6p8=
=3jUJ
-----END PGP SIGNATURE-----

--SNPvH3yDbtRl3s8P--
