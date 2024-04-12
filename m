Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC21BC23
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897045; cv=none; b=I6UoIQ9231CCUdyRC6BnFemccYzKHK5QOCJuerRO5XhvI7Dwh/Wk4bLgizIxGbe5f/vuuQjvVOyU49245Klg/kgkOhWM/8Xwh5UeOkZQI1631LwtxqAt2HpWtP4vERBjvChn6IFj0W6CmEQ8dLcfwpiwJncmQYScq2aA74LkucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897045; c=relaxed/simple;
	bh=ycbp+YcUsmXszMOkQCbJL8Db/GaF8D/ZugsGC59cX10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9+70lTifAqHThW46BAIYhw+K+91UpNbqKj6QnBB2NoGvv4rXrj7ogjDXiLr/pu7kk/v8zSUreAR344XamKsi3OJRgT306QtkPyg1SGMdxXr880klc4xxfHVFCB65o6U7+FGo6eebwnRma4rQxdGMyZQ8eBsI625i1sr/u7O7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aMRbKAMe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kAocKsQD; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aMRbKAMe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kAocKsQD"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C871011401D1;
	Fri, 12 Apr 2024 00:44:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 12 Apr 2024 00:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712897041; x=1712983441; bh=fUFQu0AMvW
	FG37/QXKbinhWw+OzgpQ2+yU7ty1t79wk=; b=aMRbKAMevgbP0oK+nInPXi3QuZ
	/H8lzqSNiF9Ys1tSqVltSBDd6VWeO6DzIwzjV9v+64Tcx5/zl5chnIiRrAXFheGr
	4Dtr5P0Sysb9GQMiOrPxp53MWUx1xgEAGv5bDrTxiNQVfIgiWlcOCV2nfIY+kxtP
	UjMxEGHTHMgcI7M9ijLzvPMJYO9RtEAzaQ2u7Mcpr/+h13JExflap7sncKWFZxd9
	xR8nCseAkW8RIx0mEdN6WPtvnU+GQS3Ung9iZEwwhA44o+5ufKQsxpcnex+54H27
	THYG2MyDEHTClH4DPRAqnPicc0Qq5eC/Q80t1c7eyvaZuWwUTMxuzYMC67HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712897041; x=1712983441; bh=fUFQu0AMvWFG37/QXKbinhWw+Ozg
	pQ2+yU7ty1t79wk=; b=kAocKsQDzP8ZSqnexSc7ZqqMgRbYORT5YZZWy0QMialM
	53xbC49gwsMI2xNV5LoR4qF4+j6yST18gmxjTOxrEkIuzJ1SzkxnyrJfjADEhuU/
	c7GWG+ap6hzINx5HC8zAjuSkKpH0f8xrA9zj3gb+3ybdM6F8T20AvAI/aCchgrBt
	vX3yobt+hvT4r0hlAbcHZtY+4ehrcg0ubYA32U1jFgg4jTsLj/SV3VC8qy6f1bIG
	rO1s504N9Iesm2oauEFK8a+S/yMx4cFCmw9a3tmTdDN36KZNHoFbvXoahd1Uv4eP
	IFX4WSEKDKM2tcj/tQj9BHa6lGtEeH3eOeGeOTIqKw==
X-ME-Sender: <xms:EbwYZvvoXEG03seWiZfdEjtOLOfSwqpmfRWLF7J3sHQce8zeNPQqbw>
    <xme:EbwYZgfROgflaLNgfbjUqM83o6kqXqw8_kkZBnqOfHXwB8enFnE7aY47-ewykvebE
    v4UUoHoNuoJ6KBKpw>
X-ME-Received: <xmr:EbwYZiyiq6dNjqSRzK0gn37d3iv4vb-nL9B7QFOIoMwjeyzoLBqyd_W2yfnp_t6TCecKAyRT1-U7jbvOapXxyY1Yk9aRdnSgNCHikkLfmVx0rglD18Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieefvdehgfekieejueektdelhfeiheeltddtleekieevieehleektdfgveetkeet
    necuffhomhgrihhnpehvvggtthhorhdrtggtnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:EbwYZuMAO4Vd0ZUnvwJCCTIpN6dri13dYuDyTPtzJgibTrSpcTvdlQ>
    <xmx:EbwYZv8Wc6TL9H8NOKZFQoCGq3Y4a2ShWy9bOagvZgv1EyzbFeC1EQ>
    <xmx:EbwYZuWApEEcXcVVjPPJdZ2qdXbj-AVZ8WetUjFCQ3OixNZpGeFn2A>
    <xmx:EbwYZgcxkprfChDOftT69PLN392Gs6B_lBTZjVyL5BdI6j_OGiSaFA>
    <xmx:EbwYZgOrJpWmCbuObybOiUQu0gXmGg6r2PZHyeByKEc2bWsBVPcxRQZv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 00:44:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b1588bd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Apr 2024 04:43:46 +0000 (UTC)
Date: Fri, 12 Apr 2024 06:43:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 01/13] ci: rename "runs_on_pool" to "distro"
Message-ID: <99b0b60359c1466fd291e890b8403d9cbfd706c8.1712896869.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DEAvc2d83fRv0Hlp"
Content-Disposition: inline
In-Reply-To: <cover.1712896868.git.ps@pks.im>


--DEAvc2d83fRv0Hlp
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


--DEAvc2d83fRv0Hlp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYYvAwACgkQVbJhu7ck
PpRE/hAAiWBp4GdVmBXo4m/75LCPAVZv3g7noHkUS1IZl2jaHUJuoPadXQdhMlS1
lSqYwaR83Pz45wsaZgIBzoKmccFLtVr7iYueRPdTBZvFKVVNhT1JuiWfiQURayo5
f6BTHOqKMxFd0sT567VGIVD71QjizY4/SCSTdmXUslM7rlAmh6cKbu30ZKeSF8GW
dV1CW3NSEUWL5HIdtr1ltAmFMFLtPP/of8ptxXKdmtw5PYXYPRTPKFWGkG+5hmKG
SXP4xSzSzCNSUGs9gQPx0AuKumunpwVNsYuPJbv3MmisFsRVnIJ7upmaJJ4ggpca
UMMxdHl+gJjuDXnYld5WHSqfj7G5ojLE7c8CHwkZILTQIkmjeDkhLQ/iSbqf2BBJ
USiwjJGgD3gLRZoSR0XUkNuFljDzvzjLZB55OmbcHT3gtjZyipobi2EkfkEDbugU
4EZYG7piK2yK1X/p58QmH1hvbJvi5IWkuvLA2YPcCA10rJSOqsV2THn0PPYxSL02
mTDTjr965GML/C/nB8lBKaE1xvooEzPdbNDEORraHWERIOUVmaZ2ntIF+8CoRzm5
afIERkT59kHLfLnLYjrAx7uKGZJpZUuJPWvE4kcKoIXTiRaMhmwIfzA4Z/kYLfsz
bCzGJ+0BoVsWrVnWUAq/A+2JXYris2o7ZhHe0x1vtFEfsSCWDl0=
=C3xD
-----END PGP SIGNATURE-----

--DEAvc2d83fRv0Hlp--
