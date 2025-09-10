Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71803320A29
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518587; cv=none; b=u9IL2OEUoWryEbE3cSo8esvOw/5buaAatFtO2Ba5mD8pCS/Iri4jwZ4loztiZSmHHrrc/3jouo920I11oRdhUOb21loXTB3rdK4E5O97FTB4IBRe8zx6YuMR5DZSpCjn7ritY6KzZ6fk2UcMs1xjh6xqI0lvRtrXIhnYFEGJ6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518587; c=relaxed/simple;
	bh=auOL+cx2FEjMMUWJveGPoYHWBO7wAR0edcrdeLzdfok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RCHht57kZgjmTYtDk2Bgnj9T1zoYypZvce1Qa8t2Gl/sKH3GYTyZHB7KUWi2NETH7YWzLnaqldKbz6bYsUOeQizGvBtJ5S/6jq1hz1Fk1IZsLcrvOj3Zgk9//SnQ2s5/BqhFpDIQZ5GUx8gDiHEKEFYk5v5To9xEtJhqHyxCV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rLfShG+c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ephgIEsM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rLfShG+c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ephgIEsM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 83221EC03C5;
	Wed, 10 Sep 2025 11:36:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 11:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757518584;
	 x=1757604984; bh=Ea4lKYxy2KpwvUewEiYJIo9DQxm32+W81Z7P4uF2EEk=; b=
	rLfShG+c2bcXO6LB91arB15DNBCeVG5fM8Rg7CqR7JxfyTkJTBDG5BSJwTepIAN7
	3A8p1Z+Zx7lplSqM9CmXN7yu5yMo17eZsRUE/ddYZJVTFRRnkZgkuZdkZX0x8P/Q
	TDpwFrAcUDIiVACXs0HQb2i/ctRiBaYVf7Q/nVANKD60XnviNu9YfJ2GIHUGH55W
	4mlJToxoxejnxNUOaNM7d4AufQO8d82tvae5ldzlFnodlSZP6Ikv4rTFmWgUc6Qh
	XlpJ/GVXZ+kZ9ucHJpHyAgBi4KEHrTYhFYiOajycpZKB7Nhx+HdgfzEa7l/vlPWS
	jGQKDagO3u1oEytFqlbbmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757518584; x=
	1757604984; bh=Ea4lKYxy2KpwvUewEiYJIo9DQxm32+W81Z7P4uF2EEk=; b=e
	phgIEsMl5nJgw+skRboE5bSG7lMksAdYo9FiyqQ2j/2956FUVEcD5KqpnHiy32zO
	rDhusTwmC1mxsNYHfuyFL9J0wIOMcQ0JiElskfEKxEg8ua1jIxAR2aFsHMg5dQ7x
	vKmV5ZJ1q1w5VDXoo7nY69nZmE8w7wnt5pFHpkRaCQj2fI3+Ay4EU/7AdOGQj9ce
	wJJTP1LadcBK2h/n8RWcZHScE+1k0GXWliZhiyaEBVlgFor9UXHLmAMbjPz+gtU7
	uCUhluc9QPU841E2Cupnu52IxQzc17FItseoaPXuhJgd9LGYAObHSFeV4K31M1X6
	aYJtJNPJq33KDSS+ozI2w==
X-ME-Sender: <xms:-JrBaDZv0nE2H3S_0o9xQkSSXY_pKPee_hFBUhHIftL8uQsB18aVEA>
    <xme:-JrBaChvByMroR_ZcslDm_wNB3D4M_wuo7Z5CU5d9o23A_YNxccIm3dNSc9NS9IUX
    YdJYdWlehF7qh_lrg>
X-ME-Received: <xmr:-JrBaNZYHUi-NJ92FOHpbNXAssSa51gkkojOzjYixEvH8QJ9OIciNsxtztDXL9_gqzmGs4oJ4tuiPysqbNYPEuaqFQ3N9RiylUDR5rqKAnI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpihgvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtg
    homhdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopegvshgt
    hhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghonhhtrggttheshhgrtghk
    thhivhhishdrmhgvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegviigvkhhivg
    hlnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:-JrBaAO3XTjhVKqKWuKRK1jsfRmXWAm12hcjzlvy38HZtgyU-PlKog>
    <xmx:-JrBaGbCfp4BbAIdCxuTgqn1whjvf6HeXStxP0E64olWu6dpCTRUVQ>
    <xmx:-JrBaIVu05w2-_TgCZ1mYjUU0rMt3Ye65UYEe7E3h1Ncg_XxMs9JGg>
    <xmx:-JrBaND_lycBovGcS9t_RT4WUuZxBMe6KBUxVR2wqFG567z1ZeeNeA>
    <xmx:-JrBaHsLp2H25r5p6YFfCD643gRPOANGy10lk1K4d0eRvcYkIJjv8BEN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:36:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 03ff4df3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 15:36:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Sep 2025 17:35:54 +0200
Subject: [PATCH RFC v4 8/9] ci: convert "pedantic" job into full build with
 breaking changes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-b4-pks-rust-breaking-change-v4-8-4a63fc69278d@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
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
2.51.0.450.g87641ccf93.dirty

