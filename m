Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5742F617A
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781847; cv=none; b=P3hIu3xuloac4SsVJVUjk+66XzRSHHA4kV9LiTUDj8KGHXLdFw7uYH+HrkzuqyY5JMuATkO5tEfMb/fC6FqepKO1oyfP3dLmwh23bC2wvKdyyQc+32gy0B1OrxKsN8Z0jM1U5yhFv6SLv609tphSb1GXazY64Y6t2gGZmjg6xJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781847; c=relaxed/simple;
	bh=ogwayu2OgM/zoBPC/vaAGWeGd+gSbtdarvjA+3JCXdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3xQWbZcnPpoU47ZN+S035I6/uq0ja8CoH1/VumHck/+fysyNgIpmb06Q0URNWoGVCqZoBMpJoaIfdMLrRm0gfYZLqi/5XDrhqevFXS+tn7o1l+9MZDwcZvQtMsfyDLVXudfKgEnW4+djVGbGnZaw+sD08NTo3PLWEg6zun1244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tmB04Mdh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oZ34UKZq; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tmB04Mdh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oZ34UKZq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E64D1D001A0;
	Thu, 25 Sep 2025 02:30:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 25 Sep 2025 02:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758781844;
	 x=1758868244; bh=3lRinMBohEL0TwUTyQb3VtQIqMOXqLqFAniM4ssPcTo=; b=
	tmB04MdheEq5VHNZ6sYuNq1r15BB5eczf7jKm6M252qrzODT5b4R6x1Fe3HV85aj
	oMhiG6PNvZN30oDx62d/rI/Jqf48uNDrkhw07dTMspdyg/1qJ1jTEl/LjA6gS28s
	r6czZ/UCOa36bGtDcGWaSLdA5XJD7EJ2blfzxgYmhjkjkgvwH4RYYHJjkuvH3+xj
	hdEvxuDSHa1n4Rpd+0zE9EeoTApmsEOQOQyCYzfjloWtQUt30GzcXwMISetXdwCp
	q2zf/GMAHEFQ09iq6YQPVmDfci4nMtY7Yiv1IV7oY3s2zjQcAxVWFr2C7dohb+KV
	scizi/8VjIi1QROna3HY4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758781844; x=
	1758868244; bh=3lRinMBohEL0TwUTyQb3VtQIqMOXqLqFAniM4ssPcTo=; b=o
	Z34UKZqlihMPGMGA/VRz7AEFb240k+rpdFwop64YZVDekoy8TyQvxuzNywqRdAme
	hKGLurvPDBZJkWLaEwNN0ds/esYqMGIAZp+fa8dIY+acTvTgJtrFXv97ANi8o+He
	0+G3d8Lu2guiGiFTyFiiOXYTAjAwpbMqO5+Wo7fwAAEzmE4KmduADpMQz3yCfr9Y
	daygEz8cRKWd+DlAvz4kxEsMRLeB4diwbJs/wMby2vlnX6BqKjaWEqLY5nKKtNz8
	ESQmPqUvqMuFLsnlGvDP9tLRTzX6H8Svlz8jMxNAoPOc3AoxX7bErpafBnxFTf7J
	N68gaRjlLKeqOX+5v08Tg==
X-ME-Sender: <xms:k-HUaGNYacO4jq-DtSC8iaw_goZCcMHGZHs4Lup5dYXSotP40-yMiA>
    <xme:k-HUaFYHMmJ3nPqph6p5cgGtjqf7NFjTMc-x_gdRzVb0-CP_ve6SIwslU27Cz8qV9
    C2cXF019PCn3kzgUX1mNCFPxFfXIVeUvWXN08kfpU3p2DzIbyH9-w>
X-ME-Received: <xmr:k-HUaNDTD3qpD0U7vpKa2T_BcRAVobsdbhQPTHHViuvn14iZT1lXnB_P-Hd2zL70Au3Jfpg8f149Hjd3dfZEwueBEqNIsSDjyc8b9OGzjyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggssedvheeisghithdroh
    hrghdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtph
    htthhopehsrghmsehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:lOHUaDHfWys_GPQd3mKcfqOEr9oRx_Cm-DVJmt1aGYxSLq7nnfqG1Q>
    <xmx:lOHUaIMYe1qqT7OwRkN_JDN7-s_5lgj74bizDP1dKlwPjvZZv0WJcQ>
    <xmx:lOHUaEiB5gRKSzK8E_oQXR1HhiANDeJVfKLGSpcne914WlNgN3-LNQ>
    <xmx:lOHUaI1D_eAByev7ZfpsVoTQ8ht-vjqCNzUhNwoc4QQUFD6Xli6-lA>
    <xmx:lOHUaPEKNuQ93wYdh3F_GJ2A2epzyuOiueu4xHiamCIzjBZaBGsA9B6i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:30:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1f58cd5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:30:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Sep 2025 08:30:10 +0200
Subject: [PATCH v7 8/9] ci: convert "pedantic" job into full build with
 breaking changes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-b4-pks-rust-breaking-change-v7-8-4e49dcb904d5@pks.im>
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
In-Reply-To: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
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
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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
2.51.0.618.g983fd99d29.dirty

