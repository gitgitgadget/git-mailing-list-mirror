Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381229CEF
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558851; cv=none; b=XMrEa1fCBM/xveQe09pWtFU3VVSPjqan5sDwQsEnIaZn5uKA0nceUICejLVDF/MFcYdXcXGnJC6AsBygsGbch4v0936lhawq3oaCF3cTkJW8f3ywYSGGNNWzcyhAeYcQEJzx7JfdhV8ZVbLtxWsCJ5GxrcVJ4TjEYNQvCVp1bQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558851; c=relaxed/simple;
	bh=U02SfRmvCfVDnmlWylHQc/xMGoa2JabEE1fDJlpHPhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9hiH3f4r8VKEDgS5uGmn+Vst1U433Z7LHRiW2101az4RjWDaJl4S//ShOFbrhBl/wx0hjQ0u14H/7Txdszso7IzSd7LtiSO6iFFis0V0IZkMN7l3oQAntUydZlwMACv6U7GZYSiQqVNrQDPk0pzIq+nFNw67j8YWuCRWFuO0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZjxKsl+V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ADyLqw2L; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZjxKsl+V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ADyLqw2L"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4D65E1380059;
	Mon,  8 Apr 2024 02:47:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 08 Apr 2024 02:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712558849; x=1712645249; bh=rIJosIOkGl
	ZlhM+8CMjeq7n1/4+LXL20PvyO3aTVYxE=; b=ZjxKsl+VhPIpfEwDB5GxhyCMHc
	iJBQMr975vJWLQHU+ANj2HEIHge0uGsQqVHYZq66xgX6nhZbjabke6epgKp8aoX+
	ojr76DSn9Y8z1LouQ7ToqbGYiT4nHaTTMyK7vh92DdsV4aB+Gq847cizZP+dbJD/
	9BsfT8HKLAR4guWhDOFCTKMsVJ24tBCRMs/z7BaHfgqXNbPkNfoSkJRdsI71Q69/
	ckDRyAp0rsL4RqDmLPAhb2LA79SXm2G/Q3r1FtJNEV63s9RnrOX2xajwyoj9dVw0
	JIGyHdGv3eNCtC/WZLT87xb5Qh6NNZRDAw82Rp0oLnRdgB5IPwB09ww0rE2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712558849; x=1712645249; bh=rIJosIOkGlZlhM+8CMjeq7n1/4+L
	XL20PvyO3aTVYxE=; b=ADyLqw2L5AKnbPuxyqGb/hy520KlkETaQOb/S8dD/xLg
	XzNb66Tb2INakJc5uFDaXGFoRyDwAIuE0Luz48ksIsDdjhgXHqXZCK+KlYBUO6qC
	Xdk1SjWGhL//Zo1M2HRoJ/jlDX3NZ4rykZ5hVfv6bR52KiK9EUZWrTlUBjliyUlp
	KgpgAE03yxeTJqsEIYLszAAf2ZKiJAdM8zbsfLGz5uiR4/K9uk1AYgEbmJAat35T
	dHVU+N8EMfAupVnf1GvYH+HpsQed4lMe8+1C2vYWiy71OPOt6ZOji+Txdh+69KO4
	JIsqShh3oyWYQcalBxC28IOWmo3lmbUFG6rUF98onA==
X-ME-Sender: <xms:AZMTZq-HFnFOkcSTnpNubEwslkv_yZAVIrC17SfBMbxqiQJYHx3UDQ>
    <xme:AZMTZqsbyYO8Vam9LMOff6N9RWihMdhow-9Ttnb-uEaWm-hdt5pS8px1Ls8ITg-48
    AgyrnonIEia_mZaDQ>
X-ME-Received: <xmr:AZMTZgDCgI7zPYwyCvpgZsP_8SVuChBTrtyIyBeex7p8wET7G0-0cAOwMMcYpd2DlcgHS-Bxk3tczoBCDnFNV-GMje1ymK6Vq1t1-qSu9cg1N3XkoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeifedvhefgkeeijeeukedtlefhieehledttdelkeeiveeiheelkedtgfevteek
    teenucffohhmrghinhepvhgvtghtohhrrdgttgenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:AZMTZicGAnh19hu8XxBTfHiqMrxBXd9s_hDIS29fHlp6HW0FChgi3g>
    <xmx:AZMTZvNsm6THxsMz5IwtGWVuLTxzgzM4gTRFbQGQYASpHQdGtIwCFQ>
    <xmx:AZMTZslR-mT_ekYPFzIaVcngUS2w5CqDUtbZZW31hdpnP_goo8wIDA>
    <xmx:AZMTZhv6-Am816ote--RsgJ2maV56SW7ccGkRF8XnZ-KfZmu2cNI3Q>
    <xmx:AZMTZq1Ognc1tNVaOdH4FExxKVyAwhgY0HD2fFw-gFFXRzyYVdOaHtv8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:47:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 19208f45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:47:21 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:47:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/12] ci: rename "runs_on_pool" to "distro"
Message-ID: <89723b68124fa6c91653e93a23cf15e475592fc7.1712555682.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kwyGNYnfalgPIe/S"
Content-Disposition: inline
In-Reply-To: <cover.1712555682.git.ps@pks.im>


--kwyGNYnfalgPIe/S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "runs_on_pool" environment variable is used by our CI scripts to
distinguish the different kinds of operating systems. It is quite
specific to GitHub Actions though and not really a descriptive name.

Rename the variable to "distro" to clarify its intent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 ci/install-dependencies.sh | 2 +-
 ci/lib.sh                  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 3428773b09..684ef5c00d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -303,7 +303,7 @@ jobs:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
       jobname: ${{matrix.vector.jobname}}
-      runs_on_pool: ${{matrix.vector.pool}}
+      distro: ${{matrix.vector.pool}}
     runs-on: ${{matrix.vector.pool}}
     steps:
     - uses: actions/checkout@v4
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index b4e22de3cb..7d247b5ef4 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -11,7 +11,7 @@ UBUNTU_COMMON_PKGS=3D"make libssl-dev libcurl4-openssl-de=
v libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
=20
-case "$runs_on_pool" in
+case "$distro" in
 ubuntu-*)
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
diff --git a/ci/lib.sh b/ci/lib.sh
index 0a73fc7bd1..d882250db5 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -279,7 +279,7 @@ then
=20
 	cache_dir=3D"$HOME/none"
=20
-	runs_on_pool=3D$(echo "$CI_JOB_IMAGE" | tr : -)
+	distro=3D$(echo "$CI_JOB_IMAGE" | tr : -)
 	JOBS=3D$(nproc)
 else
 	echo "Could not identify CI type" >&2
@@ -318,7 +318,7 @@ export DEFAULT_TEST_TARGET=3Dprove
 export GIT_TEST_CLONE_2GB=3Dtrue
 export SKIP_DASHED_BUILT_INS=3DYesPlease
=20
-case "$runs_on_pool" in
+case "$distro" in
 ubuntu-*)
 	if test "$jobname" =3D "linux-gcc-default"
 	then
--=20
2.44.GIT


--kwyGNYnfalgPIe/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTkvwACgkQVbJhu7ck
PpTYng/+Ipc9ZRd9ryz7umC0uIdpolbkD60SIUkO4CZhI12SOmmagTgihitFNA+E
9TxtlzMyt/vXhcnUwERc88c2Yik/e+yi9S4gLcglu8QTAkSi+nFy+jGSqgDJezrl
0RH1thKpMFX5Br9Rm6S4mv5tzYUXG1zmu+bs+QSoP40NWqqG9r5DeMXgH/KVa0rA
qPpWUJAiZTs7PN9p9uiBTNIhtD9ZFKy4Z816WUXF3aTt1/7kKWFbyyDDNHbqacXZ
6Kr07VQbaYXaPIMgtHaUWDFu85xJBn+U2d+g9IsLYcuAzqZ58ohzuRla+3iOCw2O
GCggdCk7ujW5LGDRxb6x68i9POCGIYhZRrZALdN2QQGPJ16In8BOWSHXsIkp3Ghc
5iArW2XCz75+OlXH1FmYDAGmip5jpvpahk7jF2hlXc/3ypozhAd08JiownigX05+
fOYidHLUvEL4YHsVKUWV/zIZIZHPyvy6+w25EuVBdIEO5S3Q3paKqRKSgTJ5Uwhk
CNj9laIv+mfSaryPCkGXARBtt0k2g12ooF7vmkhC1YJhK3yIkJX9RxV+x1NsFWnK
Vu/0W548KzZYXsTqUx74ba1hyts+f6wM5bn+YnUBYE2DcwehF96xtWh/PKSoZm+H
BJODcX5JAG2XEbl2Qcq5PQeIKSgX3i4gxROTLYjVcvMM9TOvfZU=
=6zkf
-----END PGP SIGNATURE-----

--kwyGNYnfalgPIe/S--
