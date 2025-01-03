Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361981FAC3D
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915632; cv=none; b=KcmwoYwUS13sZmINm945m/kdF3+d9n1ETIlNl+hLPDul/Ejs7Uxnb0IcAl9CcJLwzkjn/OQRIpnrmU2o7+HOKJAdgMsOuTdv7uCaRB4hRSr5S68N0hWJtB5I28LDMnM2i+UpS5wAKKMBlaGvuMJ21DFVsk4ONqszNJ2pVZI6Z8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915632; c=relaxed/simple;
	bh=zexPLNT3h6Ys4tPdyqD5I4vRjDDd3aNFUUmdR8I6FLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5wpk5pp2b7hNeMljjy1PKlil2fFgw1bLuMogZ8r5HON3NLwUXMYeLhxApSgj0AjK9dpm2esing8cX49Ui7CKn+tvMvqy03J9sHh3VOkUqpBa9p3jTCClEv8128MY45hJwz+f1ltUqtndHZk71T98B+b7k4umGWJQbyXTdVdtO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kKWesVxi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=amoahWyp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kKWesVxi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="amoahWyp"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E977114015E
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 09:47:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 03 Jan 2025 09:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735915629;
	 x=1736002029; bh=sn+TIcCrlFSiTm+D9WefCan97PWIUoOwwisrZzF7BtM=; b=
	kKWesVxildkIt7OY0F01lZu/Mhsj/J7NKwmZrtiswPSFpi0mDG367v3MCFssLSRA
	AF6WzdTWeJtA5eQS/Oedz4ztdUDM7ztaGfX2HYgu0qF9j5mw4Xg+mgIEERlGsXtm
	BWbFbjwm99j6u962+KN2Il9sSYzZ5r+lZX8wQibHX3RhJ1MyLnDh49JRZVw9eTA9
	EmoKTW9YtANE+1evxI9XF6v8rS7Z7trcULnZSv1gjApwQJ6jRr1bQ07I8rJEffcP
	f2qlbN9mGci73iG0L54m+fjQJEQ96qIUynmB1Yr86HLX2JOwxVQkHmZQNUr3L1iu
	VMc6byhEWGJp+lxbDQY5JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735915629; x=
	1736002029; bh=sn+TIcCrlFSiTm+D9WefCan97PWIUoOwwisrZzF7BtM=; b=a
	moahWyp1ztnX27wqbKQB64YetJodLiqMQYgr8j3FM9FRiTlSKtqGTSt27Jjzl3Yf
	aoopSFDgh6lHmzfCcMd8eAO7CZ+OnQKoiSKnvEwUToWpYaaGv3wrBL7r2sfie4TI
	aPImr4Tz/mM3Wht7y8+qzcoCRZK5h4ymaYMZQpHLFu34+CBZOXtxJVSZrOkSCkux
	1WZG752YsdISAha47T2jkM0o78VrKK8wkVp6FBA7aiILBCkTxExy6vcE84qbnG8e
	fHj5ZLm2KBf/yYXtSvXgkSYeNZe9tknpLMflJNgQ/HH9vqtDvyqMNVpnov2HH/zq
	KqktyAeTllxYSscjo0Wng==
X-ME-Sender: <xms:bPh3Z8TdZWqg4UHawtJFXFlQ47jDTKu6qO1Rc_KI_Fwl5tQV7R1yYw>
    <xme:bPh3Z5ygQ4NEly2It7yrnRYsG2smZpMi2qY8Aj-YDaD023DHExq6dNnzFwzbmvxaQ
    z8Covdds0wOyGHP6A>
X-ME-Received: <xmr:bPh3Z53iR_U0rUFmabFfL5G_-UTvkaUfpCUUpZ59sxBz4zki6383f4NiPMRT3lm6s6PnC7AD3gyqrWv86tc5vF3m0PapD6Y7nluua-owzA_BK_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqd
    dqteefjeefqddtgeculdehtddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeer
    tdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesph
    hkshdrihhmqeenucggtffrrghtthgvrhhnpeeggefglefgkeehvdegffelffekkeehudff
    fedvheegieegudehudekleeivedtgfenucffohhmrghinhepvhgvtghtohhrrdgttgenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bPh3ZwD301jW64sezxD6yf7NG93Njamv0MY4tkxH7vW7qdOdxbIczw>
    <xmx:bPh3Z1jvbTJkwsmKcNz3Ksn6S8jTOVDmXDCLdpwexpd5C-0t0q_DYg>
    <xmx:bPh3Z8qU3rOJFkbmeE7t5X-NisimHlj2y2ETYswesQCmamRbO4MxlQ>
    <xmx:bPh3Z4hnSFhvHCJby9cjl8nqGgCW5pa_C65qZ0m8Hi9TnohRRRCxSg>
    <xmx:bfh3Z1biEuh_mLhP4hQ6Ejc0ERZGjjRY0zBJw0_oDf0cSR89Il98z88C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Jan 2025 09:47:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 31f84a3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Jan 2025 14:47:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jan 2025 15:46:42 +0100
Subject: [PATCH 05/10] github: simplify computation of the job's distro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-b4-pks-ci-fixes-v1-5-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We explicitly list the distro of Linux-based jobs, but it is equivalent
to the name of the image in almost all cases, except that colons are
replaced with dashes. Drop the redundant information and massage it in
our CI scripts, which is equivalent to how we do it in GitLab CI.

There are a couple of exceptions:

  - The "linux32" job, w whose distro name is different than the image
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
2.48.0.rc1.241.g6c04ab211c.dirty

