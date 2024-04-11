Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D574143C75
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826603; cv=none; b=EU+YbgDD4tp3fwv1PqL4SqW1b94K/QtfW+QiOyJTwJx3PV3eS++4cQ8fp1mq7IqUqjbJT6ygesINDRUiVMy3t6GZkH4kLFVPFudYHjmwsw8+spGDGa7ZZWbRzD5LS+qW/vWINKbTNC2byvzCAo3qQ85N6fT2fb6TvdCkBd6YK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826603; c=relaxed/simple;
	bh=PaOP4IQIuau8Qi2g0rxqkSEYw2aWULuBoNtu+hIzKW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPudmMmQPcAYnID6bHQW8jGnIkKiZLYivEsRbQQNS9TBRBj3u9jrse9rPBVH99m9JwfW5Zxn5PrdkDRCYGxBPxWFulunsAR2PSlYH0t+I/HNPJAhkuJdiHWBAaeeOQKWyY+w9Kd36ks3Sfsb7QsTj2haHpkVqtUzLUU/3xemWgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=moxqcXOO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yu0HZdTa; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="moxqcXOO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yu0HZdTa"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3AB0A1380130;
	Thu, 11 Apr 2024 05:10:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 11 Apr 2024 05:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826601; x=1712913001; bh=xUM34d+qMf
	LgaFBi3LMIYtZ4N78vD9LWtj2rI8Vy4tU=; b=moxqcXOO5AKnV+J2ehp6rmiOmB
	0ozVBccPz4YUVFniKSuptPqpfaatA+qLsneP3L3gRCnCIA7nM0wVVBr9IhGSOhOK
	UBVsQCCiCqrtGCxHkU30KWbM5QexIag45V9v6A1gLDO/H+c4B4EDin7jtMzsNS1Z
	lPrKn0hepBsv2uJUKF6R/92hcnC8CBW2wzayS4KovTtj6a3JFcSmXVMPMGAsT07y
	SeaohzLFjzbwYGUptuz0oU4V9CV69+6ZT/dGh5Td0HOkuvQP3kl1zwr4fASe1t09
	7SioI3l0UZmVn+XmTR4p6wdQdujrMS/5CEgfuRRgieu0KP+0MglH2/dnZ8VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826601; x=1712913001; bh=xUM34d+qMfLgaFBi3LMIYtZ4N78v
	D9LWtj2rI8Vy4tU=; b=Yu0HZdTacTZMXBDOc88sJuhkuHPMuDcu1ug7d50zcDXt
	iyZacZM7wqFztWJRuaxHBTPtifXgO2boPuspAihukZoPaiEIqGJ5ha225KO5ubEJ
	XkoJNZWQbqu58btpv00GHSQZP3HF/Zl8/NLdyC5vkd3IWpSKondb1NuZ7jku6J2B
	uKgd3O7zJWJ446zcOlOcgJTPIw00twcC0MBJjL9oQX/wxYmdoWIboFyuYC+TOHdv
	rGJsB+Hlnw/OmkKuFCz3pd0ap0v6vxV6PSvyKKaKSY8QchEcqlqtrPi6vwY5Vtsj
	o4A6r6yS/bVnUrpwZxbIlRixIPhbHtypXamvj6+8mg==
X-ME-Sender: <xms:6agXZq4KpmYtGX08o28fYkA7SDOTyfGaVkbX3BtYo-TPMC24JwEqWw>
    <xme:6agXZj78qOaANmIyazdEbL9lbPfPorUPRXJO4xmLBkx8IMGTdVwnT0VOsoGuQb6u-
    EY71JcshpUK1aYdeQ>
X-ME-Received: <xmr:6agXZpdyG00wH2RGbBbm9BYf9ffhCDnEnqgeKqYu-VzVw9ZyAeXj5n1K-xA66HrSV7hQEqD92jQL3EcxYFRI6f7kv5bY6oqO3Z-NUOjdctjhMQQ_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieefvdehgfekieejueektdelhfeiheeltddtleekieevieehleektdfgveetkeet
    necuffhomhgrihhnpehvvggtthhorhdrtggtnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6agXZnLgulcvce7WtTZws52nHRBrD1DL4nM-HZ-oWeslA_eysh5IkA>
    <xmx:6agXZuLAk0E8qyd070jShiUefkdxf2e16gihixH6JW00DzHxxfV0KQ>
    <xmx:6agXZozIcvj_x5qT3QllZoYxqdmsRpfCrvVdpb8UbwlK7HJftTXc3A>
    <xmx:6agXZiK9uqTs3dV4gBKuvaeQeH3xH-f5T-68bBBSwI_X_tjBBDKfkQ>
    <xmx:6agXZvoRYmEOeuTKBcO-MCchiRR-wb4oKJMz2pkFO0GataEgVgnLRi1D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:09:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e4b35702 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:09:47 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:09:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 01/13] ci: rename "runs_on_pool" to "distro"
Message-ID: <46502bbe22e3404d41ab8da152d9498c607470b7.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lMYZ/1daiGRXy6eI"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--lMYZ/1daiGRXy6eI
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


--lMYZ/1daiGRXy6eI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqOQACgkQVbJhu7ck
PpSOwBAArHpjtA3yiXyjyva5nQC+PGQNwSoYtQ1cuKxubZnkOw5rgxWgGLdoZzi+
7WvsyOnCRWJniEYhaYFlAHFfVducknv9jztcqKWvg1BELrz/pzB8lnbAt0VTdo4b
b0jhUvEdHTspbXQBnfLaHYhqaiN0uNmQg6M4/4ZO67DnVulbDNgqCl+VM6JBq3+g
F526GQJaQMd3aBt3St97D9APOZoOkdApPoAuTVvvB/wLTe5zSLFZYI8V+aYEwzgQ
9swKK5duSqGeWRixS49CKrqRt87hH4bKxIzLWrVAJmZ1ro5w3ZPjhSY6UVONSP7e
ph5IQZMQ88Zq7QAaSsqbOlxxfitUp45h5o+A6Ey0GI3I+O539YhmH7zxfWt6/uzK
ipnuZaQ/+r++nFF/hzfahBsiiFQJrhf6I5RYJXLyjzy0DuBTkg7+mctl2r1ChPZv
RPC0Svfy3rA1nC2PaQMg8htyOaBDaUaUKixBX0FvyRb/nZNIqkUth6okC5AYcmYM
6pekznnb07YxJRs/qw4ymLc2g8oi9BgPA/xThcemX9q9c9ADmqqtjywzlIA76/MT
VO5m8Ga+iR0H22AELI8wIkEXl1tpkJNB//ysdI3B9KiFHJ0A+/BmtcWKMhj6GJfq
cD+CqcPUmUTVIULubVrceGZjhSmZbJquACOpa8FuGxSYBWrxR0c=
=BP0d
-----END PGP SIGNATURE-----

--lMYZ/1daiGRXy6eI--
