Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9E5FB82
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237111; cv=none; b=BU3Dacmdl3KOKzweA8d0enFfx+s2uo8Sbwy/1Sh87JhelWYHafR256c6SfUtVc8v27PEHA7Ce76SY5wBigzxWH5K3yyNIcLLYc64qiqA6JHMOzqguSNaQfHz9j7e36G7s6H5b50ERsL9vUFq8o+bMOh2/iBrtpP3B9CutpXM85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237111; c=relaxed/simple;
	bh=MJ83/98hfc6bYKYJ7wvjqVBYNLcMQuUmMYs2BIKv03s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8NTOg3CViPuFyvIuhDiMoqKZJ+aQ9lRAEQ1aFj2x1xLfkkc7DdF0IMgYJjpfSvApJ+5AuOkYRT6xEy6fMcL5AnlR/gBsUGxvW5olCIh2PCChMkTue7+pUQNYg8sLFxQeJ8EPqlmxwpdrTnwJngss6HaUhUoDdRvC7e3RhcU/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CcDNksed; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FSlSGgw1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CcDNksed";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FSlSGgw1"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 045911380177;
	Thu,  4 Apr 2024 09:25:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Apr 2024 09:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712237107; x=1712323507; bh=Ra+gPwCkG/
	2WDZFmd4OxcWI7ckjLSsfVRW0TLkD3OsY=; b=CcDNksedtkacJxBF7Xhm8vvUCJ
	/92Jjy/gg1+hL1yEq4NVJaDARgzawelWur0LmRzkDzUtcrlTkejJfr5+BppFG2g0
	frj49nnF7Gxq03S8qoICrjPk2QzFZaylF8Cj4xO+5Vk7Y4GvNVW4RIWWs4nUmY/X
	MvemsHfpfviePL8c+yPjvADoUFftZ9c3cltXPIr6oKvDRAEmmZIys7BFYZ+qNTEq
	VYfrJPgdlpbNE3OqaSyRk7KWzZIkyyXqtd9FAiC863wexJCoaxHIsSbKPvhywFQf
	2VVUYfRT3XRnRWffoQi1TijawWjbc3gzfc6biyp/qkfxAjly/XnJopuK/LYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712237107; x=1712323507; bh=Ra+gPwCkG/2WDZFmd4OxcWI7ckjL
	SsfVRW0TLkD3OsY=; b=FSlSGgw1vg1Da/84HiMgNWRqf3i2kUK17jGZsOlFOEb5
	R7WKVCZBrTNZnjdxFCTJbLxmRcmL0BW3cbaAT1uP8qBvPU0cI5LiEywtPL/V41M4
	4LmkYH36YmNha9EQWDuxGeOncnrxyiHJrs9Vz/8SOpJsJHUedm182PJak6NnBSPi
	reb1kzmRr84EprGKp95Q6bL5gI8mUOuxYYYMWetoOdFB27DhrbshXjI3+VkEmhrI
	Sx497eFjvcZ2oNOL6xlqb71HeMGg2NM9t/JYSnRYnQ4P6j8dTx1TX7NITOzvm8kU
	rpwV7SYahc3jRbfhhve19QAf1M7mhezJea+BZ5J7vA==
X-ME-Sender: <xms:M6oOZmsVZZCrnVi-a9sXWtcHGYRR1UgVhy8vKCXwOUvoqCnyhFZoNw>
    <xme:M6oOZrdc4hyQrjguZztYPQj3j9eZnyfPdgdZM5O73N1UCoBXMU79goT_QGjqk29uG
    g3FRZELXIfXI0sXPQ>
X-ME-Received: <xmr:M6oOZhw8ws1HPkdy6t9DzehZQhQPv19FBKZm2s-6x5_B8sFuPwTAIosBthfiEdIF9dX7IUO6PXxW6WC9xKZyVHb6kck5SMjsjTqXzCrCo2o8uzSx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieefvdehgfekieejueektdelhfeiheeltddtleekieevieehleektdfgveetkeet
    necuffhomhgrihhnpehvvggtthhorhdrtggtnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:M6oOZhMsaBSc_YBF6MATLktbDx6EWkqzRE5UgKXG2lDd9yAa75K5QA>
    <xmx:M6oOZm-au59ZptT5pgSajSVdmwEWLiUhU4b-EOagEgulLDSdu3hq-A>
    <xmx:M6oOZpUX27BLtDk8mgzg2bzh0hzh2u3uJkUXXH6fh61UO7U8fWRxfw>
    <xmx:M6oOZvd5coqty6txPcpGll8pEQ0bPPyo3pJAfAgUk15dWeRwKszu9A>
    <xmx:M6oOZmyrvvOxU9Pk8uGoHNHFYvjVBhckae9a30bcRPtWp9y7tAKhK6A7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 09:25:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8b9f99e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 13:25:03 +0000 (UTC)
Date: Thu, 4 Apr 2024 15:25:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: [PATCH 01/12] ci: rename "runs_on_pool" to "distro"
Message-ID: <e6181295490ea02aae9269dca533d83f037d6960.1712235356.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fIKU3dZCzBwBa3Jf"
Content-Disposition: inline
In-Reply-To: <cover.1712235356.git.ps@pks.im>


--fIKU3dZCzBwBa3Jf
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


--fIKU3dZCzBwBa3Jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOqjAACgkQVbJhu7ck
PpSa3g/+NnZO4DdHg9/kcXOkXvqh7K1QlUz+bphHvwlM4vceeKgC3W6u+8AgDC7I
7FJbA1K+kyCja0JHtESk6aOFccdd/26hSTpL0ceV/YbaO1UEBaPuCXPNlUCNHY0M
8oitdGJCNrEyOPMfYhnU4ywyyNdn4Viatc9Q6Xjo69nushyPnqLsMpZGKk+y278c
rRt/2RLuZgRcQpuWyvxQa/BFuceEMuU6f4VoS1IpVNFAdWx+S2yMHcp5IXECFapQ
UapX1+ERKRwdCcS/gkV8boaoXlYpxVgrEzrI2+SLWo+XyqS0mM6DkENfeegqFS0t
+gJhch7CG9xmRQfmHtg98TfDEpNQjXFmWXW7xjsXe01a1EQNst7i792EduwQ80wT
4Ek7ssdTMdA26kck2rMgiVXxbx7UsrwviNs2W6s61USOr/RikpTAa1JkyM+LxAU1
SY9dwgpjK206WSYqg2gtTuOLWn3jW8hi4uKIdY4p27AujxzAh4WECVBTxe4+3XGs
BaZvajUuGxTzAgoyfoWXDSclximyltCaB4aHQ9V16s/L8kdvMoXHWWaSLHY2T8k4
XDmmwSz4ATJTN2pBVChPELqX0Jh2MLxP85Gc9qfXst5Ux2CbmZJFK8zdBkbSWvs5
apUrO3XRZN8042VvdU7d/vj4zZ2L60qBQpdyiEKQSz2Virku9gY=
=wDc+
-----END PGP SIGNATURE-----

--fIKU3dZCzBwBa3Jf--
