Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBEBE6F
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112981; cv=none; b=dzs0BDkFHbzSNHdqmQB/N7HJhbb5xVKzszoqinM9BZP7MaXsf0HdgP3wQPKwfrKkAzWp9T6dCrJOhV3+PikcosHMQ9Az/EDMW/LpI5VV4TFvDtnwJAuH17h1fOHpzSpjlGigLQ1l1eDCJK97nt7tMO9JZFLEDL6K0m67w1WsIvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112981; c=relaxed/simple;
	bh=2RluyzcKD6e9tSFD/cHMrgci7Bh2MEc2fS+OqBTriis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=le/2oAQX4B8rXV5GpKX6I3Je08Cw1zK1n6q76p02qsZzLYwxFgyWTMXK71V3jeUVFfPjHIXu6H3JqE0q40EFWB//E8nHtUxZKzLoY3GlYxgOlIdI9qTgw1xAZFbs1cZtmdWM6Hxz+gVuU1b/2gfZPEb5sjB4INuwvqNQzEBeIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mUun7zn4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tq2jrde0; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mUun7zn4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tq2jrde0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 02A30180006E;
	Mon,  5 Feb 2024 01:02:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 05 Feb 2024 01:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707112977; x=1707199377; bh=JDofFTA6eb
	2toDFo2Bem51E0a3RlUlYJyvlbLaalDyE=; b=mUun7zn4sURpoV61uFp/RedhFf
	uVTdIjes1xKZj1MY6Z0SKYJ1QsnVhwegRcfc1MPSrARiJBynzzls0MgrsEAdMRD8
	qr4pniu3VGmhsy6zNmCOpniY9AVvnzlS52vSE8yoxaHRtN3ftWcz75VfuW0DXOOl
	Of3pUB5S0kkK5njyDjyeIXCMc0OmUxq9dtEUBQcF6za32rIf6CEYSA/U3+VnsCg9
	3VFe6+ZKIPwBrYSMSi1ARln8YZrlboqwabxnCpAnQUlqSE1PbYtJ608R6jfYQZMC
	O4FGCO6iGGTTdnjGWZuaZdWf2AVcA18CbPX2g70AA/qIJGs4eI0MnsXgEFHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707112977; x=1707199377; bh=JDofFTA6eb2toDFo2Bem51E0a3Rl
	UlYJyvlbLaalDyE=; b=tq2jrde04QJE3rmMOCMJY+e/Bip/+0GFFwJ8GAXGvief
	bwgu7ElMiN0DLK4LsxgksogHGo+DwZIL1zSK1EfNQwwmEogKdAIo5C4YgubsdY8H
	00L8nmDCmKb7ObJsbwtrel6Z73YLI3tyEMfeyARyY1jxemszkpbuiU5v2DopYHT1
	S0p85+RGzcqU6dg+qDYyzd2yxpa+3kufMbriZYDm/mOSMRgB4IgRFK8UGWdZR+D8
	UDLRVFoXKyODNTg5eSnDpnLPKs9g4MfIwP2okobkhMzf9ZsIkmCGjtG4U/l+8GL4
	ltTTZFfFIleZ8W+1jlzamU2EXr80nNb3PiaYsTRc4g==
X-ME-Sender: <xms:EXrAZa64KCF0pqA5ywY4YWh78LXnBKTkWzS_S2pP8g58oPTwmKtTOQ>
    <xme:EXrAZT4SoSAlKeiXlA9aGuShdYG_m_ednTn6gLWPioKdXvkY2MNrQTd6iY7bNmaJm
    Lbxtsrkg0zmyvPxiw>
X-ME-Received: <xmr:EXrAZZfQgCd0jiCfSUVcYsuidEALeShMOEVPiNOSgiB3Zqf3kZEy1BCeK-fqcIFUWT8MRDy_L7SgcGUZSjgW3aVkTV9PAjt5tPRUQn78VjMz3bE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EXrAZXLmVw8LoZo10EQq057fAD-8MQ0gjtwbPCDuaW-4VixRwvLgIA>
    <xmx:EXrAZeJO0wp5-IKum38E9nUUhjyUYzwMQ2gYYtOA4foKf3PvTm8W8g>
    <xmx:EXrAZYw-FqrnSA3Fg0uGEgY4VWGqYTkBk7aaCQvFZUIOKGbfZ9KXQA>
    <xmx:EXrAZTEMLbqSxJlA1uKcS92kxUlKpU9uQlMwi2ezHFIS90Lc2dSf2waghfg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 01:02:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba563444 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Feb 2024 05:59:29 +0000 (UTC)
Date: Mon, 5 Feb 2024 07:02:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 2/2] ci: add jobs to test with the reftable backend
Message-ID: <146bb95c03dd1ac43931f3d43b0a5779493fffc8.1707109509.git.ps@pks.im>
References: <cover.1706601199.git.ps@pks.im>
 <cover.1707109509.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mMKBFHKWW6DLM1Vq"
Content-Disposition: inline
In-Reply-To: <cover.1707109509.git.ps@pks.im>


--mMKBFHKWW6DLM1Vq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add CI jobs for both GitHub Workflows and GitLab CI to run Git with the
new reftable backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 9 +++++++++
 .gitlab-ci.yml             | 9 +++++++++
 ci/lib.sh                  | 2 +-
 ci/run-build-and-tests.sh  | 3 +++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 4d97da57ec..1b43e49dad 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -266,6 +266,9 @@ jobs:
           - jobname: linux-sha256
             cc: clang
             pool: ubuntu-latest
+          - jobname: linux-reftable
+            cc: clang
+            pool: ubuntu-latest
           - jobname: linux-gcc
             cc: gcc
             cc_package: gcc-8
@@ -277,6 +280,9 @@ jobs:
           - jobname: osx-clang
             cc: clang
             pool: macos-13
+          - jobname: osx-reftable
+            cc: clang
+            pool: macos-13
           - jobname: osx-gcc
             cc: gcc
             cc_package: gcc-13
@@ -287,6 +293,9 @@ jobs:
           - jobname: linux-leaks
             cc: gcc
             pool: ubuntu-latest
+          - jobname: linux-reftable-leaks
+            cc: gcc
+            pool: ubuntu-latest
           - jobname: linux-asan-ubsan
             cc: clang
             pool: ubuntu-latest
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 43bfbd8834..c0fa2fe90b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -26,6 +26,9 @@ test:linux:
       - jobname: linux-sha256
         image: ubuntu:latest
         CC: clang
+      - jobname: linux-reftable
+        image: ubuntu:latest
+        CC: clang
       - jobname: linux-gcc
         image: ubuntu:20.04
         CC: gcc
@@ -40,6 +43,9 @@ test:linux:
       - jobname: linux-leaks
         image: ubuntu:latest
         CC: gcc
+      - jobname: linux-reftable-leaks
+        image: ubuntu:latest
+        CC: gcc
       - jobname: linux-asan-ubsan
         image: ubuntu:latest
         CC: clang
@@ -79,6 +85,9 @@ test:osx:
       - jobname: osx-clang
         image: macos-13-xcode-14
         CC: clang
+      - jobname: osx-reftable
+        image: macos-13-xcode-14
+        CC: clang
   artifacts:
     paths:
       - t/failed-test-artifacts
diff --git a/ci/lib.sh b/ci/lib.sh
index d5dd2f2697..0a73fc7bd1 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -367,7 +367,7 @@ linux-musl)
 	MAKEFLAGS=3D"$MAKEFLAGS NO_REGEX=3DYes ICONV_OMITS_BOM=3DYes"
 	MAKEFLAGS=3D"$MAKEFLAGS GIT_TEST_UTF8_LOCALE=3DC.UTF-8"
 	;;
-linux-leaks)
+linux-leaks|linux-reftable-leaks)
 	export SANITIZE=3Dleak
 	export GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue
 	export GIT_TEST_SANITIZE_LEAK_LOG=3Dtrue
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 7a1466b868..c192bd613c 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -37,6 +37,9 @@ linux-clang)
 linux-sha256)
 	export GIT_TEST_DEFAULT_HASH=3Dsha256
 	;;
+linux-reftable|linux-reftable-leaks|osx-reftable)
+	export GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable
+	;;
 pedantic)
 	# Don't run the tests; we only care about whether Git can be
 	# built.
--=20
2.43.GIT


--mMKBFHKWW6DLM1Vq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXAeg0ACgkQVbJhu7ck
PpQrVw/+IAd7JWmtJI9ujO4vMkTQOfC5YStnIrVB3SnV8XX269Gl8hp88MXZ2WGp
ruDsbZozr+2p2OJ5eGYTaMTkhy+p8GZF78kgscibGIQ0dpzhVdgusBJNINeBjY8M
ekDwLMp/yXE3xAoImjLffRoRo6YknpRZHjsdBDK3QF6nNyL8tvGLN7jAGKEYy7/T
LNNF6zV68y0mVjD2kNO+RU2LXVOjePqvFnF6W53GJnjkHGM97Xsiw6JdHxOeFcZh
lVMoTAra4tK2urzBdVZNbdyHfqmrMxOCHHcZcrSeK6kQAU+nKQ960ogp7TgKQLWB
hVg0U778ifY67/i2HS8YqgeOuu0PZtCEvEXU6qsWu64TNiQqf/rOW0CsS6t0RX4R
wnngY9Eb5cEZGCMltv5Ms3wCRi01JhAxchS4rziBbKkV/BpPr4F4V+FkJM8WqxTj
8xdNBJBNHg9ShKsR0u9RxMLgFQhAq29VLw+Lg0rXypcXyjICmRrHgAhT9jQIJRCP
re2TeOF8N3RtsfnmTPwBDQIm3jACc1Kqum/175PeXKAuj/Qb/kw9NcA0QXvRw5bR
zUSkWZY3KFDdWCCkS2WxDDem05pTixjv7PpPOuipYupI1N0TzqpAYUU5aV3mDaCf
yMUisr0u3Koi134luh5Kw6ASDJzsNRhvXOVjtPphiLisjshOcPc=
=TddB
-----END PGP SIGNATURE-----

--mMKBFHKWW6DLM1Vq--
