Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0F41C62
	for <git@vger.kernel.org>; Mon,  6 May 2024 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973728; cv=none; b=KO/erO/jbJgju4pxfwvwaY/ZcXtXNGQTuoXHB00i6jRJEGl1NPTgYbRXXlZVj1y0vx9mrScUHxYjP9tOyPii3KPYeIX1VuyNdvtZ1PewZdR0Jf35NnWI9EprKLdoRX6lCd+6LZ2xNnVo4OSUmz7DgO7buf3KuN1t9EvmZZgsgWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973728; c=relaxed/simple;
	bh=MwFh0NgRu08U1r9UZFWNLAIcKJltbZ+pvhJtNlvsE5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lqYCFEuKKkQ7oqtB3EPeh6dKFH5nUgWLLcBCTWokaNRgKdcoNmGJAtH4Zuyt0gow3ZoT4NcsuULLPUKHVenMpjTvKvjWx7ARR10cIfDBcsrRadF6tc80rGUYw03SftvDdySgGlA/ui4kbBEubjjGeW2wipe8zCyfqzyzL0Xzhxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lqGSstW2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XOX4sddc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lqGSstW2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XOX4sddc"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3491C114013D;
	Mon,  6 May 2024 01:35:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 06 May 2024 01:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1714973724; x=1715060124; bh=SnAD4F+tKRjNFIxG9jW6e4UFbTibqRus
	7YY8cj0yx6A=; b=lqGSstW2AaUg2AgrEdeO28KvHjbK6iLl6DyKmkcAwmQvQ2rB
	1foFH5SjFRGmidXJThUJBSIamTzLB1HUoGpaZYNdA6oAIMgODBiXJGGMwFXXpJ9f
	05hdNZ5wbJhTYJCbE4c9FmHShVp2mSDEKbaK3NH6/EGTZJ7mtYLsOKtbu0Mq4gU5
	RfBGlLLVhNdPpmqRqHW3pIE+LFitHNrjSRMXSDvxtHOfP+VtS1CBhWZ/GECgknzl
	Aa0mMx2Vf050+Xy+U9pGidr6BaKCb1bImxJ5tTuOF3abo5ILK7U3LQo1YguZlfGR
	GrRyNv9sroOInbz1lbQRO1GXEYy+ZPbE5SbRfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1714973724; x=1715060124; bh=SnAD4F+tKRjNFIxG9jW6e4UFbTibqRus7YY
	8cj0yx6A=; b=XOX4sddc6nnDkFrPb6oqJZSkqURQk5ofJ4ANeWKEB71gJ9ZeL89
	g/pBG0Y9T4q7T9zck61cmweuGPd/F/mKxCFGqYVnaPmfuabjDG24WgtSO0jwP3Ri
	/WxIh9tznpDyUUi9EgUoVU8nUMltk/i70gRqVqhhMNbU3CEpo/8hkrvXEKSAqM6k
	Ufbl4LsVPyPvUPkwo3uAYwqikUKHS0Z+RPKFgWVPhXugN7hYsc+gtzN2boHOywD4
	2yzi5A6uiVH+1fm/ypSE/x/Nqad6CV81KOdF76Ms6QbmYdi8KJRaKSiGL/9S81pM
	0jMIE5S2cWl67SgsTNY+neBR8SpAskXN/xQ==
X-ME-Sender: <xms:HGw4Zhv642ugVp9BJXiplZUNM4v6d3VIcBWBbthmZs0SzTadFJXyRw>
    <xme:HGw4ZqfbnwUOH3EzuI2tKDw4shDXK0d2YdLVpiRGsyWnvsVmfataviCdoWjLoizEo
    jVy69Frhy1KQT7YGg>
X-ME-Received: <xmr:HGw4ZkzovEuv_asSaW4iQvjcl4xDwvc_WY5apvT4N4xLiiGfoJz3QcspAeFfvMgcZB9vwJFhgc6L5cFwth66ffC5Jk0dtXT9XHaKiDH7OyVaWilp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuedtgfelgfevieevhfejueejvddtfefgjedugfeftdeguefhtefhfeekfeehfeelnecu
    ffhomhgrihhnpedvtddvgedqtdegqdduvddrtghipdhlihgsrdhshhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HGw4ZoOcFktTul-P9AUZ6ST4WldyYoB4iTugHw2prBWT8bG8s6IztQ>
    <xmx:HGw4Zh8aRmhQlsGMWY1iSlm5_7_5gjEN3cAwl2SwgZQs6KW3tZxI8w>
    <xmx:HGw4ZoWVy9jTGzdo6cCq3lgJuXy8NMlRycVhYZbAMu8uMufAHr78Tw>
    <xmx:HGw4Zie5PdaNEljkbKMGyjdNldwz4QHHn2img50YAV3jcub6AfclLw>
    <xmx:HGw4ZsZG_YDXBDDHJeKhLBrIQ1wi1cO5ushmb3KYQ27su49kuI_3t1ni>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 01:35:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a776ae3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 05:35:14 +0000 (UTC)
Date: Mon, 6 May 2024 07:35:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jtobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] ci: fix Python dependency on Ubuntu 24.04
Message-ID: <cb8cefc20f373a3516695e7cbee975132553ea95.1714973381.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TPNXRtSk2iOWZ13U"
Content-Disposition: inline


--TPNXRtSk2iOWZ13U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Newer versions of Ubuntu have dropped Python 2 starting with Ubuntu
23.04. By default though, our CI setups will try to use that Python
version on all Ubuntu-based jobs except for the "linux-gcc" one.

We didn't notice this issue due to two reasons:

  - The "ubuntu:latest" tag always points to the latest LTS release.
    Until a few weeks ago this was Ubuntu 22.04, which still had Python
    2.

  - Our Docker-based CI jobs had their own script to install
    dependencies until 9cdeb34b96 (ci: merge scripts which install
    dependencies, 2024-04-12), where we didn't even try to install
    Python at all for many of them.

Since the CI refactorings have originally been implemented, Ubuntu
24.04 was released, and it being an LTS versions means that the "latest"
tag now points to that Python-2-less version. Consequently, those jobs
that use "ubuntu:latest" broke.

Address this by using Python 2 on Ubuntu 20.04, only, whereas we use
Python 3 on all other Ubuntu jobs. Eventually, we should think about
dropping support for Python 2 completely.

Reported-by: Justin Tobler <jtobler@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Note: this topic depends on ps/ci-test-with-jgit at 70b81fbf3c (t0612:
add tests to exercise Git/JGit reftable compatibility, 2024-04-12).

 ci/lib.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 473a2d0348..273f3540a6 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -325,9 +325,13 @@ ubuntu-*)
 		break
 	fi
=20
-	PYTHON_PACKAGE=3Dpython2
-	if test "$jobname" =3D linux-gcc
+	# Python 2 is end of life, and Ubuntu 23.04 and newer don't actually
+	# have it anymore. We thus only test with Python 2 on older LTS
+	# releases.
+	if "$distro" =3D "ubuntu-20.04"
 	then
+		PYTHON_PACKAGE=3Dpython2
+	else
 		PYTHON_PACKAGE=3Dpython3
 	fi
 	MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D/usr/bin/$PYTHON_PACKAGE"

base-commit: b6db6b1598946fbf777e55ff0d187b11ff3bd21f
--=20
2.45.0


--TPNXRtSk2iOWZ13U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4bBAACgkQVbJhu7ck
PpShcxAAhT/dYbfxaoRKRjAaUwBH2bPGKU1BCSdoWwtpJJ/6u92w5ilx5fDZTvAP
WzYQrVZ/NGFTdOmJySniOKwKsS7VhWpcHkkWD2SUpu/0fEe1nvtdmuGAGQkM8xYu
sZ/uzozPgb1HVmedAmiDQ+fnyoQKHA5DEnMfpBM1Ua34QI0Gl5/Q+8TMJB7By41S
xIZ3DGdnClcSaPyoYu3pwj+QZ6yYDzrky4Qc43n0RvYASJPiQOk7TsE48KPYrBfr
ujWxs5D8/GCDWLjrhNg0nKEXj8CexoA2s4gxTccdmkOu9p+03tyrolHLz84amftN
coBsVFWoDA2zqqRdYeRT4/+q39EwT+7CXsd6U7KIo4YSdKs2j8e0hkMKG5vM6VOQ
Tes42LfRqJYuBHy1dA0YxaPS07ztkLs7MhJUCxCPpeoeyss/pvJiMGUl+pdYgzYc
BzVzeyVZXHIUB53BtE3vMVeweDbMaaj9reH8C/RdfynIFDOecLMYNDA1cwXUJiIJ
qtej2vBchpbPkCDtSt47FMgjPMTBp+li/FeVJMrC1ITxki96jN0Tq+7fGqVBZFMG
WqPqX7bhP+liQyQq2nxtQ17EnN8/nCWPDxFsmAy/pr8iLDz5g5l4+7ri/2Sgg0dP
AKYx5bB8FvblDKibLcqMYC5rVv8fH83yT/IG8gGQgKgkJQGp5hk=
=SKUR
-----END PGP SIGNATURE-----

--TPNXRtSk2iOWZ13U--
