Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45751DC997
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162224; cv=none; b=KyCIoA7+2oGlRezxg4TiUzUitB6FpBXKBanZ8q4Kn9cDYZZTw6KHptDox8WsA1qSH2C3AJLZYMWtdFnXV77+Ur7zBXnZa12NF6aqcy39qK6etIZzXmx35lvLX+In/QAnsyAiDxfQY/u3ncPMYnZj3+O3x+qpd6qv2t2P6vHkCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162224; c=relaxed/simple;
	bh=dzeIst7pgTEPd5JlhKlh0EXtX39CUksm25M4q0qLNP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fs0bu7pT+S8vmAZULIInrLKE2Xil/Tj0CyvvBdsUuTYTjTgQ47IZrHT4mBG3PWDBeEJm6g8fz4xjj0lrL5+wUC+0arSf756j7xKsf4cQPleEcEJ1b2dqqPEsXqAxHLbVAXUVzL4PLuYJvfdGPxbIc2mcmajEK9minnvE4MHgUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GFGyU/jM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=elYDbmiI; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GFGyU/jM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="elYDbmiI"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 62EF51140143;
	Mon,  6 Jan 2025 06:16:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 06 Jan 2025 06:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736162217;
	 x=1736248617; bh=GulJbzb00DFN2pjl2QPk7DmclqJZT9603LbzW1fidDU=; b=
	GFGyU/jMU2h3+xfAM/5aHLwubpr5ewdC80gFuaS444HJHE/wFdKq44YkUrjloala
	ZjC3C7vwLsTPA+NQGGuSFackfchlj635mu84GXnnv3QiW02+qvRgtszNJ3+qcFf9
	3iOABJB4d2NH4btYzho/EwiS20oJrkNfDn41aFf8DqNbtHnUPVEh36TF075vpIsp
	TxaXyplCIj8i0dXLTEGgKTfax7gF7N1NnK2Hrt4pwUQTG35LOzc5Y1Q8CVNBJv3/
	baT9frST1qq6ao+ursvDndMbcDanI24arG+take3pXgU2+GmKZ9eVmtwZ3bLTNh2
	j47ZHnv85mUsfY7kAvPx6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736162217; x=
	1736248617; bh=GulJbzb00DFN2pjl2QPk7DmclqJZT9603LbzW1fidDU=; b=e
	lYDbmiI5gF9zIGHQZGUWOJJnGNHdhCIn0v7laSQFeYuwzxiZAS3ImLp6xQGuQ3oH
	sRgGzsGVidO8TNg3UBz7dG7YK1O7X67mlWUEWrXa/5wTPSH2cH17olzSP3L4YZH5
	kTbZaJ9g5Ffx6j9bX7nlzewAUAeYo8yIvnXCXUegANXUKlt4IDgUdDEa52KHAe82
	7xjf02DMC7Tx3V2oDCbOtUWrs7BTsaFm6i0bcsV7yIuKAI4rUEq7y/T7GEMP94bt
	CqxuoXKOCZDwMThQWEH5l9SaEqUW//owymNVUtKsUu17pzwp4PjWBE31mTl5V+sS
	IPp5jq4h6N4ZDCMSUrb2g==
X-ME-Sender: <xms:qbt7Z5URCVPrWn6T5OQoC1Fz6ejOu9GE2-yVMxreC3eEm6c75fnAXw>
    <xme:qbt7Z5l2-jNJe5DDnZqKu1hz_jzb2_sZooTAPZsg5Z9hmHP3quXcQwmnfA3FlULKK
    K1L0lWWHyLyNRrNYQ>
X-ME-Received: <xmr:qbt7Z1ZNniKMGroLjGA0UTnfV_DOAnO96oEwk938Hx4i3_2QIFe7rf4SOb3jgJUjTIRCGieEJ7PmDBbo1wKYmyij4wyzexmnhRQCA1b3GBmb0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgeeggfelgf
    ekhedvgeffleffkeekheduffefvdehgeeigeduhedukeelieevtdfgnecuffhomhgrihhn
    pehvvggtthhorhdrtggtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvth
X-ME-Proxy: <xmx:qbt7Z8WdDRtbdRb0yiutGsfZSIc8pZs6NUntYGFZlb7Hkv7WQ8cRPA>
    <xmx:qbt7ZznvakSCoB-_vaK7h6u3M3GCZpBbdIQkttbthmuzjTAOVfI6xA>
    <xmx:qbt7Z5et56s6rOxhG17KWIaZzHBqFi5nXZM3ttestU8jEBBo9kkKqg>
    <xmx:qbt7Z9EkbMNJ449GmvP5LtGxljDyGEukIFaq_zfbukdSUdS6OtRDwA>
    <xmx:qbt7ZxiPKdOnGz-qL_0Gf7F3iKhxIqSoiZwsjkJPpmIp8zjxhXSS_Oo6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:16:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 004b600a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:16:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 12:16:54 +0100
Subject: [PATCH v2 05/10] github: simplify computation of the job's distro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-ci-fixes-v2-5-06ae540771b7@pks.im>
References: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
In-Reply-To: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
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

