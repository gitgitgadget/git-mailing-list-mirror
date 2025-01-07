Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64BB1EF092
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253058; cv=none; b=FZ++K9U0GML2AG+dRrQLy3P9KDX8CjeAAmfP86LQl4qhhSryx6biJcRDjoAdPQF6OElDuK6/Qs6Ot4HvYwYhuzdU3zR5J8zlAXYd6BBns366qfZdNKKzddLKK0m3uVA3pTeTAt0TkpLMK5iYvebpOudxBr45Onk5T3jlrNRKqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253058; c=relaxed/simple;
	bh=dzeIst7pgTEPd5JlhKlh0EXtX39CUksm25M4q0qLNP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZoP+xoDhPcSeHlYQmUROqtg7Ko/B+PqvNIU3SXO3bXumBfNmBfag1afOXiW9N/xLTFi3KbC5u76Ta3ETRW74el/zo0PWXYKo3S6b+1fGBX32PguFoC38cfNHI91HHB1jJpj15iWYUinYU0tlzJbVFZYJSdp1tKowKPckprS/g2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rv7+L8Vy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hCsm1n6Z; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rv7+L8Vy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hCsm1n6Z"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5A361140169;
	Tue,  7 Jan 2025 07:30:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jan 2025 07:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736253051;
	 x=1736339451; bh=GulJbzb00DFN2pjl2QPk7DmclqJZT9603LbzW1fidDU=; b=
	Rv7+L8VyYXbrr6DNFZ6/c/RR/F4DbOAqXrzHDrultlKpjSvRgRl0qNlSF3g5dAL2
	iB+4PmNjsL3uSs9JXfDXX4inJ2ZhqFUQK3Xbu88WMmviKcBjJ+LMTCKrOXZrC+Gl
	gpyIBnT+7ph6pLZBgtgmYlgKBnz8x2u1yhKCgLK0f3tmnKNGotMPBuemtC57GVEy
	kosSsLZIMxIU8GhvbwmasTL1McbCqkUATjcCsl/ZydSRB5qy3DX2zgemEYD3Q5ea
	uNQZhTZBz0c/2eJagB7dTB71YLXtQ96IG4e2L15BocYs15Wk/FtFQcZl952wxgCP
	lxVTNHn9bPtdBJNxCVDvfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736253051; x=
	1736339451; bh=GulJbzb00DFN2pjl2QPk7DmclqJZT9603LbzW1fidDU=; b=h
	Csm1n6Z3FCpO0SB4vQtgKHEmiVJ0C6Rr0VcMRX2SSuMNgmiDwvokhSDAh6w92U2U
	lAwZXjuNyzcrS4P7/b4WGTNPmEtWTeWvxgWjb90sn3gPTWF3IBpa2D1aBF+GQYmf
	ceZ/K/OQNT3eZkva4UhA9kiaVCj5nDQjy4w0j91lw+Hfu9rRNnhkMxhZqOr9igIQ
	2FH0NcZIouJspz5Ty9b/j18reX4Sl90+uRpJSp9VNvo6/y6CKoooVg5hP6uHoacP
	lZVJhynhLoce5NmqMC6b6kxf04RZrgq8dSOaX+vez0EJlLaGvqFNmPJJRQNfl6Wv
	oRwaMM9CXktTOJBUVT/Sg==
X-ME-Sender: <xms:ex59Zw3at4CPNNidpDWqpgeYxDvw0yqu98A0lbWOPBB32WtDzJf5vA>
    <xme:ex59Z7GhIY5FqNyugoklXA4AyIIxqSlGPPEGdBZlQ4yJSMXTxTlX8CnWrLBdb7VLa
    kYGVh5tb2R9WUxjSA>
X-ME-Received: <xmr:ex59Z442I0BZuYknQFFZ7EKGD6CayOdQkLTvD1A6ze-MKhdsldPUG9npf6Ue_K1WLIvRE6-GYie3jeJ-SeebxujM53UvVwk9LcOCRfWs-YIJ7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeggefglefgkeehvdegffelffekkeehudfffedvheeg
    ieegudehudekleeivedtgfenucffohhmrghinhepvhgvtghtohhrrdgttgenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrd
    hukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ex59Z506zaXPThJ1IDMZtxkWyHzJfs1dhRIKDti7N30D6imf8CfG6A>
    <xmx:ex59ZzHHCmbRZ_Ir7fD1O1tWxrpxGWUsI9m6Q8BOY967I-6ny7EfNw>
    <xmx:ex59Zy9yn8Hn92EPgnhjMKn_eKSfg5QVHbtsxHp-Tosp8dnjHD0w2Q>
    <xmx:ex59Z4lpaymB1qV7U2EMK7QUBoIax96yM2pNJ5mVPx9UIs2tQKD5fg>
    <xmx:ex59Z3hAI7pMSSUHdQCsSWCFsZ3OK7cdJ_eSK4m6hrxrqgbJpDJ1kSWL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:30:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2645850 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:30:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jan 2025 13:30:47 +0100
Subject: [PATCH v3 05/10] github: simplify computation of the job's distro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-pks-ci-fixes-v3-5-546a0ebc8481@pks.im>
References: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
In-Reply-To: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

We explicitly list the distro of Linux-based jobs, but it is equivalent
to the name of the image in almost all cases, except that colons are
replaced with dashes. Drop the redundant information and massage it in
our CI scripts, which is equivalent to how we do it in GitLab CI.

There are a couple of exceptions:

  - The "linux32" job, whose distro name is different than the image
    name. This is handled by adapting all sites to use the new name.

  - The "alpine" and "fedora" jobs, neither of which specify a tag for
    their image. This is handled by adding the "latest" tag.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 22 ++++------------------
 ci/install-dependencies.sh |  4 ++--
 ci/lib.sh                  |  2 ++
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 8e5847da4fab009ad699c18e1a5a336a8b45c3ed..b54da639a650682495994e3c7b137eab4e6cb3bf 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -275,7 +275,7 @@ jobs:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
       jobname: ${{matrix.vector.jobname}}
-      distro: ${{matrix.vector.pool}}
+      CI_JOB_IMAGE: ${{matrix.vector.pool}}
       TEST_OUTPUT_DIRECTORY: ${{github.workspace}}/t
     runs-on: ${{matrix.vector.pool}}
     steps:
@@ -316,63 +316,49 @@ jobs:
         - jobname: linux-sha256
           image: ubuntu:latest
           cc: clang
-          distro: ubuntu-latest
         - jobname: linux-reftable
           image: ubuntu:latest
           cc: clang
-          distro: ubuntu-latest
         - jobname: linux-gcc
           image: ubuntu:20.04
           cc: gcc
           cc_package: gcc-8
-          distro: ubuntu-20.04
         - jobname: linux-TEST-vars
           image: ubuntu:20.04
           cc: gcc
           cc_package: gcc-8
-          distro: ubuntu-20.04
         - jobname: linux-gcc-default
           image: ubuntu:latest
           cc: gcc
-          distro: ubuntu-latest
         - jobname: linux-leaks
           image: ubuntu:latest
           cc: gcc
-          distro: ubuntu-latest
         - jobname: linux-reftable-leaks
           image: ubuntu:latest
           cc: gcc
-          distro: ubuntu-latest
         - jobname: linux-asan-ubsan
           image: ubuntu:latest
           cc: clang
-          distro: ubuntu-latest
         - jobname: linux-meson
           image: ubuntu:latest
           cc: gcc
-          distro: ubuntu-latest
         - jobname: linux-musl
-          image: alpine
-          distro: alpine-latest
+          image: alpine:latest
         # Supported until 2025-04-02.
         - jobname: linux32
           image: i386/ubuntu:focal
-          distro: ubuntu32-20.04
         - jobname: pedantic
-          image: fedora
-          distro: fedora-latest
+          image: fedora:latest
         # A RHEL 8 compatible distro.  Supported until 2029-05-31.
         - jobname: almalinux-8
           image: almalinux:8
-          distro: almalinux-8
         # Supported until 2026-08-31.
         - jobname: debian-11
           image: debian:11
-          distro: debian-11
     env:
       jobname: ${{matrix.vector.jobname}}
-      distro: ${{matrix.vector.distro}}
       CC: ${{matrix.vector.cc}}
+      CI_JOB_IMAGE: ${{matrix.vector.image}}
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index ecb5b9d36c20d3e7e96148ac628a96c62642c308..d5a959e25ff3236656ff3416b81732ec5c2107c1 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -33,7 +33,7 @@ fedora-*|almalinux-*)
 	dnf -yq update >/dev/null &&
 	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
 	;;
-ubuntu-*|ubuntu32-*|debian-*)
+ubuntu-*|i386/ubuntu-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
 	export DEBIAN_FRONTEND=noninteractive
 
@@ -42,7 +42,7 @@ ubuntu-*|ubuntu32-*|debian-*)
 		SVN='libsvn-perl subversion'
 		LANGUAGES='language-pack-is'
 		;;
-	ubuntu32-*)
+	i386/ubuntu-*)
 		SVN=
 		LANGUAGES='language-pack-is'
 		;;
diff --git a/ci/lib.sh b/ci/lib.sh
index 8885ee3c3f86c62e8783d27756b8779bd491e7e6..f8b68ab8a6546802756fd516ca15a2c97223da5f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -246,6 +246,8 @@ then
 
 	GIT_TEST_OPTS="--github-workflow-markup"
 	JOBS=10
+
+	distro=$(echo "$CI_JOB_IMAGE" | tr : -)
 elif test true = "$GITLAB_CI"
 then
 	CI_TYPE=gitlab-ci

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

