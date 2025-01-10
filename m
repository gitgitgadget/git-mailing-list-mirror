Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C4202F87
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508729; cv=none; b=Fu0CuBaQxBroQmHwQL2sXHgZpXfZgyoCMGdtVQhz2tdYgaYYDT2HoYDc4Zz+5G4WNhUdUQZ3B8NF5IMX3Uim0Nny3hk1Iz9+2m0oA23g8bk4TQNHooaQJS+FzaTdDAJgFHorURFjHtatJxlERvIJDV8GOdrPUAKcUaR3j62pdOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508729; c=relaxed/simple;
	bh=8rlLczoTTWoj4OfZLOSj78aId16pZAEk+oyhts/qWoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZiCqqHJ6GC1etEHBv5aYdGoIu76ZFA2FEdNPWjj23mLQT2BGbP+O71GHlwS5GBt6NFL8qX3hvRxxe4hqsCi+pDlZSb8C8Q6eEWoqGiTB54vpHA3A4jiKwtYleR7WjDiH3bUFsKCpXwDekhnUMaZR4+adFDmSjdC6DNpRBNQrOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ffpCGGGK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AXwqVhqm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ffpCGGGK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AXwqVhqm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B77001380C91;
	Fri, 10 Jan 2025 06:32:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jan 2025 06:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508726;
	 x=1736595126; bh=XnNqMIj+w8pabGILx1bK+vMV+1qRPCWkYC1QSOXaGUE=; b=
	ffpCGGGKf2x1GjvUBkAI73J3MKf21G9Pd/WTiri/mOSGfRos8bIOmuqot4UvRwE1
	RlZEeDk+10pcmW+8B4T9xjdAhuZGkDn6O24MMYpW4UZ16QMLFwUgoBgNoi3zO/Rj
	RA58ZQ0FPPlse6/G9JWg7KJrTk7QRVGDNG91xoAImHTkNFogNwcaCk9Fs3VMVjaN
	+YcmCFQ8GHzGISMh+MFBtFbzf3TLbnM1J0X1V/ITbGbILYG1WEJm9wPYjfcYCP+7
	pQsHChK/NycVHkB8a49IYt6dzLvy5zJKZhcQvTS4gJGGDzTiy79Tuj5kLDqk6aXz
	Nqdk30GUyOmcx8oSeUW3qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508726; x=
	1736595126; bh=XnNqMIj+w8pabGILx1bK+vMV+1qRPCWkYC1QSOXaGUE=; b=A
	XwqVhqmg5uB3bw1ATI2kVTWNXuvK2PoiUPPB6g+R34MTuf4wjKHjqmJb5yQAF8UV
	+CGAj/keNlJFXr9wSUrpqHIE7CsXtUKS0euCkQ7u8WDB8t0kZTDCTKiGRMhnsbv3
	0XssniakZ6uOByY7kNhO3cPjqtJyUvceJEGYMCVjpfkPyrhZkN4jQqWlzwUdq1Ka
	dTBNmUlsP4oXicsbYiW/6ZqNSFdCAXHOyVR2NhFM9RYobdmby3nl3ey8vgyg9s9b
	3WWrDjqOHU/qn0zJ8jvQjO9pbG5EN1zbU/8kEi/5dvQFaUcIhuPIYuW2P4WXz1it
	dOgSypuUfsGAVKDwm8mkg==
X-ME-Sender: <xms:NgWBZ3r47FihPmentKjG9eX_ZPpefaM00MFy9Jzud6DPEgVUOVkcGg>
    <xme:NgWBZxqEkei7wHyXQWpX2w-sLKI1t23YA_8SFmmk6Z7wfv-Ron6XiR1hQmePNQqfj
    cJ7koY4e2TWEQWRXA>
X-ME-Received: <xmr:NgWBZ0Pz_A0BnWM2BGNAdpymDkF3z_gHQqsafnGDkWX8hEf8zQIF6KH4urX2UJ7bvHTCq9H9V31NLJ8qtGGgi33SJqBIMbu-cbMAhCxfof50Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeggefglefgkeehvdegffelffekkeehudfffedvheeg
    ieegudehudekleeivedtgfenucffohhmrghinhepvhgvtghtohhrrdgttgenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:NgWBZ64x6ddCDwOvyyGziH2NJkBbNd4dHUQErRRnFaktqaaRJMYPSw>
    <xmx:NgWBZ24_mF0TUgoGs5rQwJHn96CbUqJ9PwJtTyHMLSefGIypdnGJJA>
    <xmx:NgWBZyhyHgGTCM-VQpLwMZvHazTZtcoWn5zhLBFCE_0hMgB9ZasYvA>
    <xmx:NgWBZ44cBDSWVbsr3PAuUvkbP1OyIekjkNn8bD7OAs62atHk7yd4_Q>
    <xmx:NgWBZx1vu-kbLlNWeKHTLf9rpoDvlkrd92hPjQT7j5Zg5vO2OCdA5XBd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:32:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 29654599 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:32:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 12:32:01 +0100
Subject: [PATCH v4 05/10] github: simplify computation of the job's distro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-ci-fixes-v4-5-6e4613446080@pks.im>
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
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
2.48.0.rc2.279.g1de40edade.dirty

