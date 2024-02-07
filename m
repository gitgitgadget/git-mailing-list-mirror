Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767C200A4
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290441; cv=none; b=Zko0MYtnwSlpmmhBWYRqzGdizetgBxWM4UmVxUNUYuPXWcUKHq/doXYXXRnbDuHoQVgd52wKloORpEXxKfb94wuOtVY6pD58C2FWPldHpsECKRsVcS5ApNqZ6pPx2HFeD653vraFpBTSrvXLCRIY720JG/aXY13ftkobsfsH8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290441; c=relaxed/simple;
	bh=rmgpegzryuQjozZcm2wGM+8C2I5qgRjSBVTMlrK1UFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMP0+HdoXlaeYdeM3dbwRIcOid9kGtQCsziFNpXdNk8df3XJjvw2b/F53B40paf5fr1XYw7p2h/tYlRfrj8wSa8jqzO3abJvX68Hw74NxAjrNTpOr7SLNcH4D5mjCrvkmiBnFx3gwTe85CtoKBsOeslJTbHiP6sPBhhRd10M2Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z1O2ldCu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GimU8GAg; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z1O2ldCu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GimU8GAg"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 749BA5C0101;
	Wed,  7 Feb 2024 02:20:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 07 Feb 2024 02:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707290438; x=1707376838; bh=fumMFYA5V2
	d8QHfwM8OALWV2CYju22FAw3TuIu5GBeU=; b=Z1O2ldCuGojyLH3Qh2pSY2YEuV
	M5r1ndWjF05UiJkdqA+9D7byKUMo+9DTo60dWjEhm3ACsrC05U6RjU6DOBnb+2Wx
	Qe/n8W4QbqDVx/75wI2R/i4AowpZFRi1Logq5xKH/ySF3FvXwKF3lM7hfmCuzIJl
	+wb5MjY0dHUoRxauBRc1gJHWrDDLwdTPaHMP/e2ppD1MQbhfJl2Uhh+FUp1guvPd
	iU2c1sXZOAa9A+WrkYU/WnS9R+hKte2r+5pB4V2PNDaw0H9AvxNX2azNRMWIQJZ+
	bNL5V3pqc8/UXXjslorL8NcSNU1q+6sV3/4Ao0gxPSVSUcsrFrZlRwDyRr1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707290438; x=1707376838; bh=fumMFYA5V2d8QHfwM8OALWV2CYju
	22FAw3TuIu5GBeU=; b=GimU8GAgIXsjAKJnIH6bBL9UNlaCrktYMTVLjec05kD4
	ePHczsMMTZACAD5EMxprolIqSTti2GVUZxhnUUpT3/ciNSjnhMgTcWPv50Mc+cPJ
	+XWFG1bRfdvJgjaKCZBfoZqzRcMI2H7yGUJ6jL9yEeOv6WjcJ+3mtd4ZMkWg1+Rc
	AE7FUZSeObEPnvP2vVDIpaYiLFpc4GzX4fJspkfzYtw+11b0u27Na5RVjxYU3Ajo
	c1ZMXHoY/KL6YuihUf1hZeN9dxBSub8WZ/IAK5qZ4E1y8B4meGt+Kbj60O8hJ6BU
	ZiTqnPfoyLFU2sAuAj88KX2NQXQmuv6a20I1NxT6TQ==
X-ME-Sender: <xms:Ri_DZY2NmkpX7l6wqrNzX-UDZIXzTamTLVnmzwxHOoDGuNS8tul6gg>
    <xme:Ri_DZTEP7artvg1TtNPlWwtCW1oD432Mop2HZaSTTgJO8w4NKyEb4gP55XwLSt1j1
    FFCzFXYHHoz75MA7g>
X-ME-Received: <xmr:Ri_DZQ7WITkFft5I2qh19QbzAS_CLtWkYbDEs62MNuAdKo7dKNonI4vLjaY-Z9a2LMlH6Ez-aM3DColaA5rSg2lOcZuXv_GHZFmY_q2kc7aw8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Ri_DZR0khHcDvnAsw0p8o18VYVKveS9tr0Ctus81VKT5IdOuG8A4cA>
    <xmx:Ri_DZbEytUjWe_6RYtFjBPmv0oPkJ9iEbYA6_7-0ssJnMxktDyYb2g>
    <xmx:Ri_DZa83xHoTCOicNOnXrlY9DK0x7tvTy5zny5RHbXl2_aSuG3CX1Q>
    <xmx:Ri_DZTBE1FRVyZ5-d-4i1LEMG2XSyy13d_K71g4a3F7yI8jyAYzXiw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 02:20:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e4eceff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Feb 2024 07:17:05 +0000 (UTC)
Date: Wed, 7 Feb 2024 08:20:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 2/2] ci: add jobs to test with the reftable backend
Message-ID: <30e5feb28c79154dba4e5f4b399eb929af9ca558.1707288261.git.ps@pks.im>
References: <cover.1706601199.git.ps@pks.im>
 <cover.1707288261.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZR4PKgpvJB+kvfXU"
Content-Disposition: inline
In-Reply-To: <cover.1707288261.git.ps@pks.im>


--ZR4PKgpvJB+kvfXU
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


--ZR4PKgpvJB+kvfXU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXDL0IACgkQVbJhu7ck
PpR4Gg//Y5h7ZFAYQBueDZIw7fofDBh6GRPMPlCpskkegWzxpu1kgn6DGqiYWXak
9tLC0XHE1NYOKADUr24rS/NKyJ28iSYtpo2WHDRWnDmL6sC8q9boxBYa1hGWnGPB
+n/QkSkCPf4cg18Aw5DDgCQO1aiDr7jFoDuvzl9XZswf9KsgZq6jWHQ5wRvoRxrm
/7tl/ky9JIsbN4cD3JX/faDRC/aMUV++2GYzLIZaNQeL9oTRvfwxTIDDapCDvpa/
K7VAHuJihdb7lpRWWlRiME1QLaV+KtmJBdDjwuZpmTEdvgFvbYHzj3Uhv17xUx+k
FG4nUXWg80ZGxYwMLoJ8EHDhp5SG6W6N+nILquAqcighYFxYszRlxdlwaGKhvyXf
r9hX90nzb7s2/zpC3Di8JB86L2UiRjJczz/u8NVaQOH8U63QqztU1zwvlJz/aje9
9mPuD7Qm2wknDYfus5ty3NFnuQpc4PjD4/DuJZ+0psahzAKfchS9Si/FngVXwAto
5hrkQJjCmuzKhBM2EBtLfaiBKZKzqBMMsQKttj9KePKJz5B1SbimRyDNpNH5zrHr
sD+svGKuJcjli5NJ3Z2ydY33g5wcfYsWiqqIolsiWLpIPc/MYLtQoCZc8s/WP49U
Z/El+r+sBDUh/WzRYp0EvLeIsb1Xdr6zxrUL6v6+FEySd/0THz0=
=Bfoa
-----END PGP SIGNATURE-----

--ZR4PKgpvJB+kvfXU--
