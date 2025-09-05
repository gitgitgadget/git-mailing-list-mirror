Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6534A32A
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073088; cv=none; b=WnQBoO+vDWXpqsKc9AhkWkudsbnKK1mNOS56u0xz2J9SFB57hf/0VuN5qvqSzSfCBnSLNf3EDTEYQAVxHFsYsstJxmmhr7LHDlNaw2y0NT/9GSEJzHY9ZCCGHcqJ+HWDdTAhAqa8/sQ5qf6aqeLPR8h3/TLF/Zxh5p2Yold/LrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073088; c=relaxed/simple;
	bh=7LvqWzElHYFZ3eRzl3geJjgAHUQshTDmGwxi48yd5iQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mn+/B3QoM5csx4NEKLaa2oC43JccwAAV4ZEbxzu3yk6BzqP8gbronv8SjIiXosEVQ8LS4Ah+RGtPU+3j0qbGqFSl39C5cReQ0DyQwMHrEcNm27cJKepzzv9CLHrTHBIotK5ow4fPOFzs1zNYMlbs2A7WfhvmEX4CIGRhQoSGoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VYGTxXzT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m7kuj+9L; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VYGTxXzT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m7kuj+9L"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0330F1D00074;
	Fri,  5 Sep 2025 07:51:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 05 Sep 2025 07:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757073084;
	 x=1757159484; bh=hYrnrMhF8Zv4YSHZt0opOmNNPjHtddKfQ6OjLvxed8Y=; b=
	VYGTxXzTCYidWCMDyIMTIomgnkWJINaDzZd4zx4zQHr1FOufz0v/e4XbaZR6bRs5
	YOGfepUoupPFXsyYN7eBht7XFjxQbxyz266eV86TlgW6F03kyqwIgjeQrQbHZ8ne
	vSnVF929GSwuODxaXC0onn6eYXazakLu08VKMLlNdB+HLiB4A5ju3kZ1Q80CIVGu
	ANMklsdwHHr8fzy7hUYF/Aw6f6V12pIJ0cu4vde3mkmqMpIBtH9ImyODsDMybzLk
	xFHX9yuWTHl2cU9CxrGDe/HwfcYzDZLAiN83aIseFJYumB1c/4O4E98AzH+yNyvn
	/tLovoK3eHiRLmh6rWUsEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757073084; x=
	1757159484; bh=hYrnrMhF8Zv4YSHZt0opOmNNPjHtddKfQ6OjLvxed8Y=; b=m
	7kuj+9LfPZt2F6Hb+FbdrZy2paW4A5fs09mSoegEbS1UaB7IW0oJKE4P5j77FDP1
	pV/+M1CLGTZyR8goNA7GW7Yab6A+eH088P99AF/yRR2yfJ+q6yBncuQLGBLmYpux
	gPbyWtLDxN9nyupLtGo210nheWQxhQTE8ngNYiWLjq7D2+5BVohaJLuR1v2Bp6r4
	7eHocXr/Cqpo3pGQ1pPF9VrjqWxMlFWf3dE82gwxyPGCpqj2Fezde2kMOdWnezvF
	EIprevfEq4E7jDgSLtnWYhcrvG1U9eDeVUO3tjNqo9bfkOQVLb+f32lRAWtW7yrX
	lLzRv0mi+j+HXWt6eP3sg==
X-ME-Sender: <xms:vM66aLNssI5XKklKSCprcCEvUeTgYKBC79tnxBwPNx_LQCvP0vw2fQ>
    <xme:vM66aGGrhvQkAHhvJ7jjVFR1HsbAqHnhWKAp-VnZS3_UL6dTdsA_5TzgEU8T56m_f
    P94YeI8EYP62xb_7w>
X-ME-Received: <xmr:vM66aBsz8b0TB1bhWsKF007CvAxkoY59F2Zrx5FO72qBOvHa6e783CPZtu7n3zmTFZP3vfAnyAh1m4B7yjYHDHNcTpz0UznJD57aYLC-s6JY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegtoh
    hllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghr
    thiisehgvghnthhoohdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehn
    vgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:vM66aGSkR8dy4QICERK-SmT_gsl1bxKGjvyix19iupLqeoZ6AfwrQg>
    <xmx:vM66aLP6yZa_qBIMSQ2Njc3wZt01zmGDNYpGtt3gtDVKzPA0YiY5DQ>
    <xmx:vM66aE6Va5YuSR09Mh0rQuTW2aqQjEYi8c40cN-eYkqA9ZoJc5bR9w>
    <xmx:vM66aGUZhS-zJ0tnrYwuuNDgG3uBB9H0ceFNj-6KaPhRtCXDnXUsIw>
    <xmx:vM66aLzMryYbA_F0FfydFWhQ5fbGXGOrLxgfPftiipjPsVaCsjlTtwjE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 07:51:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2bd22ef7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 11:51:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Sep 2025 13:51:02 +0200
Subject: [PATCH RFC v2 6/7] ci: convert "pedantic" job into full build with
 breaking changes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-b4-pks-rust-breaking-change-v2-6-6939cbf4a0b8@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
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
 ci/install-dependencies.sh |  2 +-
 ci/run-build-and-tests.sh  | 29 ++++++++---------------------
 4 files changed, 13 insertions(+), 26 deletions(-)

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
index d061a47293..4eaf3514d6 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -31,7 +31,7 @@ alpine-*)
 	;;
 fedora-*|almalinux-*)
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	dnf -yq install shadow-utils sudo meson ninja pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
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

