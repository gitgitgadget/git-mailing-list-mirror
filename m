Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964912FD7A3
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935415; cv=none; b=u/wrUdWof5wHA3wmZgxN4ljiu49sTEIGplW6z/Fobgj0MocJIsk/JvDjYdTxsI5Ugw89CyJGoHzRba6hvCxvy5XQvCMYAINGJZLMGUfY6WphkDMZl4g8ceOEaGT+z9r3jM5ulnXRT6MM5uJA5kLoaKBkx+CfQaroPkmyucG6Fts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935415; c=relaxed/simple;
	bh=auOL+cx2FEjMMUWJveGPoYHWBO7wAR0edcrdeLzdfok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUXKQJ137HljQkJL30lKUEF+jipPlDstRXHvFymWSf5nAh7tJhBkNOb3fjonnvDR7iFci0/vtQK2ptaJ7J/5ri4e2iSznMWsXG29++/f5D/SmwdW5yKyF3os1Ii/ZOqT/Vt7zqgPNsFP0vkKloZ9pTyv/QnncgYB5cYMKvIIalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qfkpGtbB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OgRd0Gc+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qfkpGtbB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OgRd0Gc+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DC979EC02D4;
	Mon, 15 Sep 2025 07:23:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 07:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757935411;
	 x=1758021811; bh=Ea4lKYxy2KpwvUewEiYJIo9DQxm32+W81Z7P4uF2EEk=; b=
	qfkpGtbBRnAhmsrNMIKjqjdeRWoxVPo08wdCeQHnvcNJcOlU/BAb1/4ZCtbZHNJb
	L17MSVbwOskju/N2FjTox2NKUMFJDm0ZsNtDruF9c6vYtZyQ4mckapi2gENW+16l
	HpS2Dc5PQJ4SbWYuUB50ua5W9NF9HTozU588cWBqAT/nFYW7OU0RHLhj+Afq47Qy
	xpw7W9gDR6dsQspJZJWhmRf3iE79mN8I4nFG0DGHiLCL2p89QSltaqJe/F0hCNOg
	8kBaJpGws8BtydHfDwxFcPeP1of46RD8SROHB59rb+8SP0y/BjRjEAiJTZ8ehZkt
	B2SjdRvIuP5aBPUCouheqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757935411; x=
	1758021811; bh=Ea4lKYxy2KpwvUewEiYJIo9DQxm32+W81Z7P4uF2EEk=; b=O
	gRd0Gc+QLMASAHxBUArMWeipbRXNRolneKxI4slH+5HfRP5t4zUcwztBZOgXTnom
	s2kiFlvkexQLdLXVVCWFgxwniEAh5r+CseaYTrnRu69naakZ7aNEIzSEadIaIrfS
	6+KEjxKbCqj6E4o9TCECGQqM6uU6eLUqgoyv6hFMIuTHjNmNbTrPC3QnG+kw/wXa
	Z4PhO5ZHil1D8dQGB51DwD/NSwYFvjK/jv8f5O9N1IFqVQ4nrIG/5voahxSwZSEp
	wWPhWJSjhyUi2mst3pus43ls2XMaL63KS+8A+ckK3wXmfNcIUObg1F1EtCaCiHOk
	KT5OPcWNOnWteSfvVtS7g==
X-ME-Sender: <xms:M_fHaP6n3rPV2CDJIZSRNhap6vocw4XM_qbaLITC5o3_5bG9Pq2_uQ>
    <xme:M_fHaFgrxyOgCsYvllF1a5lnKHgBY0gC_cf3d_IG9KfCaaQqCNwU1jJ1d3WCtbzR1
    HbwMFhZikrx7mh6QA>
X-ME-Received: <xmr:M_fHaBlUcMiZrVT6Pl27iXt9Nn_P54pLx7HGru_oRRy785d2VeLqSHj-ieDlvKMhlSoT99Gk8Jl43QQBKTUrz-qg5IpOPf9f5b-739lsEY8FPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpihgvrhhrvgdqvg
    hmmhgrnhhuvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgtphhtthhopehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthi
    htohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhord
    horhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:M_fHaEtPGZNL5hy456SP_o2GXbLT3rRHbIEQv_p4Kgln_0e0_ZNI_g>
    <xmx:M_fHaHCE2zVLq-DU3PUVLHbYYWApRwuuqRrqmYbaAvGihit9jLKpnA>
    <xmx:M_fHaJWLBXP8Yuea4BWI0qxHSZMouBW7CaYn3GqwGYfaJfNG0VBm6w>
    <xmx:M_fHaIGKpreKL7toe6bHlrOpsI0jgQxKpRrJIC8WOPQf_uZhbkoP_g>
    <xmx:M_fHaLrcec4bcXCWBREU28TL-Ph3kswUqSs0DQ40NAJ7WMOK1EGZdqNI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 07:23:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19170fb9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 11:23:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 13:22:55 +0200
Subject: [PATCH v5 8/9] ci: convert "pedantic" job into full build with
 breaking changes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-rust-breaking-change-v5-8-dc3a32fbb216@pks.im>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
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
2.51.0.450.g87641ccf93.dirty

