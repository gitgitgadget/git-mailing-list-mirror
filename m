Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A530CD88
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340825; cv=none; b=W9h+EloKDMUGqqVCawPVhYgEFE2IzT3ZWc37Y99ZRshUjF0Ncu0w6VUvNRVvCifxf7DeNnmhvb9svnK7oWvZLMXeReKO6ROkaDBOs1iJ7t+KItSum1Eyui3nB+kVLyweks4SCYb6qTk2gQOJoGaUg/XAYANb53POuaiCoUmJN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340825; c=relaxed/simple;
	bh=9Rguf8CR/Sj2t9U6XwjTqqY0B6LajwJgX0xno128q68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B59drOzgw5k+HF2JpBEwbfs1BvxZOouD+03nHt1B4PhgEDJLlvkIXCGBGAUyHKO196wlYZRP4/un9AcmlfVp9Nh715Sj9j0SHtGt8zKsXuA21LdSm7AhJhhkiCkGGtmBrfohuGZlBjASLnVSkckLQGNH+XgKwgJJ4aI0ROsb63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b/1H3bhB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I92G6PTw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b/1H3bhB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I92G6PTw"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3621AEC022D;
	Mon,  8 Sep 2025 10:13:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 10:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757340823;
	 x=1757427223; bh=TIbZO0jubD7pyVAHVqDpputnSovGWHP1oBouo7RMA1c=; b=
	b/1H3bhBqcp+wayApdf1ykceWx7+2wJXyuTFWG49pSipKp2GB3WR1EjC20QwOLfv
	ExfF7eTHp4+EmJQwQxqKBZvpbscHvZk+SsotrrcNMK4I2+SREJaeHfU2Ork9JfZK
	2+8fGLxf1pZ0LvN4d3dhOIjon1WuIdkpVGGRWdzjrZfiwluxYhePFSd2/WqiXeP/
	EJxFqNk2taW9Saw14kxpiAe4Jad8cuHgpM738oQJZqzI4VpTV4Y/b4tY9qOPJPIA
	zMA0sln+UJIZr+hGf1dvpPGuuNSPj5ub70L2Om8zfGglKRXq+Zyfk0IeqRfnkQt/
	zIVf0llCwje8cYU6HS52og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757340823; x=
	1757427223; bh=TIbZO0jubD7pyVAHVqDpputnSovGWHP1oBouo7RMA1c=; b=I
	92G6PTwG96xOxjE+VI+JclN/g9Vo8MOH4e+P/1lFNfSiY6N4xGLmshQd/87Frv3c
	5M0wup0ntahgaFpLS9hzO71sBOc7ZXVI34LYuW83pcaAmujd06Lv3M3/QC36H8vB
	cN+/3ywlRFJYhw+kGbwV8GwVpSzPNNIg6VdGVnqWqzMpJK0y6or409GanbxGIPXC
	UqST3vmBIy9v2+Uobh+Y1wXz4B+7qeH0T5MKDHhBqeN+gQxvffz3OYppnxcRNWFZ
	X2gMEpUP0gK8merEHrJRsFPs5PVnVyXPgYio++Uzz8rjGWS8fymt6HXkbh5D6x+O
	zXI+jUmLQ5fmOGmOayTtg==
X-ME-Sender: <xms:luS-aMJ0wGO99BQOm1zcI-Xpogyp4L9lom9hiFMqmLUaBEiQUCIS1w>
    <xme:luS-aMSTa4MoB-BNlLbDs0byivrFT1MicmhEyRTG-JFiq4V1h-bUqn3fhyy287gW-
    8eBZ-DlguWa2m504g>
X-ME-Received: <xmr:luS-aEIXdVPwC88PzxoZDxFqR5R78diBx_TV8SO4T30wY7bqOBJBNXpVdaeuH0yW7intv95MQoi1xG-RZ58dEamhhf1EFzoFs9jtLGKIn1s1DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghmse
    hgvghnthhoohdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtg
    hpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvgiivghkih
    gvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihht
    rdhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:luS-aP_SXhUJMYTkoM2AaWjDI0Wo8ENZwY7S0nxDUHfBnHZEC9yrRQ>
    <xmx:luS-aLIUbAt1zd7RGKnuj9wggnYrWRYzmxCR9fuxYz_qtxuI05BwbA>
    <xmx:luS-aOHA3_tYn_VKIbHIpNva3089b_qFaSPfBqrZTp4IUtqMNp4qHg>
    <xmx:luS-aPy4pWa6nih7kkXGEY8Hj5BCwAe3VHbdW1CHiHebsfR2wQYJTw>
    <xmx:l-S-aPen0rt332djGVHUWhKiEAo8sKmxiDbB4Fo6K-DiMJCbz7MbzME5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:13:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad51dc8c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 14:13:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Sep 2025 16:13:14 +0200
Subject: [PATCH RFC v3 7/8] ci: convert "pedantic" job into full build with
 breaking changes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-b4-pks-rust-breaking-change-v3-7-1cd7189fed3b@pks.im>
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
In-Reply-To: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

The "pedantic" CI job is building on Fedora with `DEVOPTS=pedantic`.
This build flag doesn't do anything anymore starting with 6a8cbc41ba
(developer: enable pedantic by default, 2021-09-03), where we have
flipped the default so that developers have to opt-out of pedantic
builds via the "no-pedantic" option. As such, all this job really does
is to do a normal build on Fedora, which isn't all that interesting.

Convert that job into a full build-and-test job that uses Meson with
breaking changes enabled. This plugs two gaps:

  - We now test on another distro that we didn't run tests on
    beforehand.

  - We verify that breaking changes work as expected with Meson.

Furthermore, in a subsequent commit we'll modify both jobs that use
breaking changes to also enable Rust. By converting the Fedora job to
use Meson, we ensure that we test our Rust build infrastructure for both
build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml |  4 ++--
 .gitlab-ci.yml             |  4 ++--
 ci/install-dependencies.sh |  6 +++++-
 ci/run-build-and-tests.sh  | 29 ++++++++---------------------
 4 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index d122e79415..393ea4d1cc 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -379,6 +379,8 @@ jobs:
         - jobname: linux-breaking-changes
           cc: gcc
           image: ubuntu:rolling
+        - jobname: fedora-breaking-changes-meson
+          image: fedora:latest
         - jobname: linux-leaks
           image: ubuntu:rolling
           cc: gcc
@@ -396,8 +398,6 @@ jobs:
         # Supported until 2025-04-02.
         - jobname: linux32
           image: i386/ubuntu:focal
-        - jobname: pedantic
-          image: fedora:latest
         # A RHEL 8 compatible distro.  Supported until 2029-05-31.
         - jobname: almalinux-8
           image: almalinux:8
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index af10ebb59a..4248506909 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -45,6 +45,8 @@ test:linux:
       - jobname: linux-breaking-changes
         image: ubuntu:20.04
         CC: gcc
+      - jobname: fedora-breaking-changes-meson
+        image: fedora:latest
       - jobname: linux-TEST-vars
         image: ubuntu:20.04
         CC: gcc
@@ -58,8 +60,6 @@ test:linux:
       - jobname: linux-asan-ubsan
         image: ubuntu:rolling
         CC: clang
-      - jobname: pedantic
-        image: fedora:latest
       - jobname: linux-musl-meson
         image: alpine:latest
       - jobname: linux32
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d061a47293..35bd05b85b 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -30,8 +30,12 @@ alpine-*)
 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
 	;;
 fedora-*|almalinux-*)
+	case "$jobname" in
+	*-meson)
+		MESON_DEPS="meson ninja";;
+	esac
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS >/dev/null
 	;;
 ubuntu-*|i386/ubuntu-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 01823fd0f1..3680446649 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,12 +5,11 @@
 
 . ${0%/*}/lib.sh
 
-run_tests=t
-
 case "$jobname" in
-linux-breaking-changes)
+fedora-breaking-changes-musl|linux-breaking-changes)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export WITH_BREAKING_CHANGES=YesPlease
+	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
 	;;
 linux-TEST-vars)
 	export OPENSSL_SHA1_UNSAFE=YesPlease
@@ -36,12 +35,6 @@ linux-sha256)
 linux-reftable|linux-reftable-leaks|osx-reftable)
 	export GIT_TEST_DEFAULT_REF_FORMAT=reftable
 	;;
-pedantic)
-	# Don't run the tests; we only care about whether Git can be
-	# built.
-	export DEVOPTS=pedantic
-	run_tests=
-	;;
 esac
 
 case "$jobname" in
@@ -54,21 +47,15 @@ case "$jobname" in
 		-Dtest_output_directory="${TEST_OUTPUT_DIRECTORY:-$(pwd)/t}" \
 		$MESONFLAGS
 	group "Build" meson compile -C build --
-	if test -n "$run_tests"
-	then
-		group "Run tests" meson test -C build --print-errorlogs --test-args="$GIT_TEST_OPTS" || (
-			./t/aggregate-results.sh "${TEST_OUTPUT_DIRECTORY:-t}/test-results"
-			handle_failed_tests
-		)
-	fi
+	group "Run tests" meson test -C build --print-errorlogs --test-args="$GIT_TEST_OPTS" || (
+		./t/aggregate-results.sh "${TEST_OUTPUT_DIRECTORY:-t}/test-results"
+		handle_failed_tests
+	)
 	;;
 *)
 	group Build make
-	if test -n "$run_tests"
-	then
-		group "Run tests" make test ||
-		handle_failed_tests
-	fi
+	group "Run tests" make test ||
+	handle_failed_tests
 	;;
 esac
 

-- 
2.51.0.417.g1ba7204a04.dirty

