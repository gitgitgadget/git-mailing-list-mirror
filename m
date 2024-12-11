Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA37208984
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914399; cv=none; b=elJ4FnLgzYuMLPip1o84x4mb2T1vpOtFh21JhRMumadb251gOrq9PFO/V5f1SCZRy6m/WOJ/TAkLSbA+NlAO2S+Wxr32h423yW59EPuWbcILNfzIZXRZlC4pQU+/DUdS60wkS6liPllKmOrvD3ZHb0KudY4l1ShabTCuUGKQ11c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914399; c=relaxed/simple;
	bh=jvJKmqhtVzsJFRfZkkm0mpyp12nTCfCNrfO+1CY4OqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QemmfxoSsbEQa/1re5z0QGYYzaxm7pXg7DaTIuo4xr7f9UT4wJC6v0izoNeTVRtqmimATEuZJnZUmJ+Yg5dbAxhSkRCw5yQ3K3SEPjfT6/nISNP/K5jRxc2p19ZJ79AV70G0cFBz718Imy7x7xraQm4AJPzmK4OF93FGvo3O7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zw5z8D9Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V0WRc7qV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zw5z8D9Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V0WRc7qV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 587EE114026F
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 11 Dec 2024 05:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914395;
	 x=1734000795; bh=6VPTb2hDuLONgTcQXQmdfS9gVHP09H05lKeiEzRER2Y=; b=
	Zw5z8D9QAagIH7LeLlTTpF6TO4h4kEkaTVussID3eUDQw+OiSFafXdC1MBg32tAN
	8FxPtvcRSsQdOo8MAudwHhtVnRUwUGsVCWmM5MTh9AQGGVxzP3GtdUf9yJJZcFHB
	DH/4a4lyRkA1audYCsutWQcS7CoNcyK1JXb1WVaTfbl8dtVHHzi/RHGdCO0a7Aor
	RCSXw7+GNGSmyyWFZHD2NDn4etsMDdpPzXakhR3FgaNk+8PrKlXybcPWZDLTxBg3
	C4/WXgHc6lScTP8s8SOliqK0UJcz7VKutsGd6IzGH0CiV6KaKZs2RcGZzCv7v6AA
	bLz0u6/U4XHiniVlhN9TOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914395; x=
	1734000795; bh=6VPTb2hDuLONgTcQXQmdfS9gVHP09H05lKeiEzRER2Y=; b=V
	0WRc7qV5jTgt4/UYiIXAzysalzpL0ZlmZW3iyK7lI8O9ecmJ9eYRV4+gyS5ZJUud
	PRu9YuYD0V2+8zdAKnr+67p3/63jOMNZegNdYsAVZAwioIZeuZCyBAk93xjbRFGX
	/pwpgbl+1zVP5XXz1bG6g5L+2uMAXUwMZFn6Qya29H1tVZtEJLZIe+fVJPFgqf3C
	UyUAvtM3vM9AX/Aqe5boVIf+22b8ADOCldqQXBi26v+MZ9KpbWkL1xDqQdv4uti6
	WozVWSyYMeT5GrLfy+yEpPQeJm53hVs1EoGJQklu67Yi9PKnL45fBKcRixMtoBqY
	YXX+dwZDkoWtjvJg3ti+g==
X-ME-Sender: <xms:G29ZZ2N8lV9JZTCpHrSPAYCxjNX9oYm4ER37Sdh_aUSItUWWpS9kVQ>
    <xme:G29ZZ08Eoc2RML8nxRX0a-A1AQr6nFubl3bxU0DwTdOL5BHo1ThlXaINRt48Yx6jG
    oh7jXn7kY6Pe9VGdQ>
X-ME-Received: <xmr:G29ZZ9QnoqmeSCvwOaBGBK7DaZuXEp74V_MGTN7FwK3COINRcwUfrXnFp1G2WfG58RmbsI4jYXrQAB-Z5-tbujA81TutWc4-Cv7MHXG3xkhUaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqd
    etfeejfedqtdegucdlhedtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredt
    redtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkh
    hsrdhimheqnecuggftrfgrthhtvghrnhepgeeggfelgfekhedvgeffleffkeekheduffef
    vdehgeeigeduhedukeelieevtdfgnecuffhomhgrihhnpehvvggtthhorhdrtggtnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:G29ZZ2vZJr5jnEkErkuHKphBN6CPdH2_gOrMzSALdVYh_oM7M48y4g>
    <xmx:G29ZZ-d4yFKfVAejPHz9RHNPOwR8eutY4-oLQnNqiWu0As4O-5V_Dg>
    <xmx:G29ZZ62g1aNvMcVyxMBjC4tCptqi8-oKjNWjSSLhfGLvz7bFVLQo8w>
    <xmx:G29ZZy9pakh_6llNG5j6fp-cpHtRrV6YM9nHDuj2x3yxSD1oNFIf7w>
    <xmx:G29ZZyGH2aCiHmrpzLXyIdtyeBJ9ox-RXV5PDeCd6n5J5ofIx7EFeuoh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 89e31e0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:51:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:52:39 +0100
Subject: [PATCH 8/8] ci: wire up Meson builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-pks-meson-ci-v1-8-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
In-Reply-To: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Wire up CI builds for both GitLab and GitHub that use the Meson build
system.

While the setup is mostly trivial, one gotcha is the test output
directory used to be in "t/", but now it is contained in the build
directory. To unify the logic across Makefile- and Meson-based builds we
explicitly set up the `TEST_OUTPUT_DIRECTORY` variable so that it is the
same for both build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml |  7 +++++++
 .gitlab-ci.yml             |  9 +++++++++
 ci/install-dependencies.sh |  7 +++++++
 ci/lib.sh                  |  2 +-
 ci/print-test-failures.sh  |  2 +-
 ci/run-build-and-tests.sh  | 31 ++++++++++++++++++++++++-------
 6 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 808ddc19b8a799abc414c6d6ba078a6e5be6bdfb..c231419abc670fb0bd096c2dce63fd1b66ab14b7 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -286,6 +286,9 @@ jobs:
           - jobname: osx-gcc
             cc: gcc-13
             pool: macos-13
+          - jobname: osx-meson
+            cc: clang
+            pool: macos-13
           - jobname: linux-gcc-default
             cc: gcc
             pool: ubuntu-latest
@@ -298,11 +301,15 @@ jobs:
           - jobname: linux-asan-ubsan
             cc: clang
             pool: ubuntu-latest
+          - jobname: linux-meson
+            cc: gcc
+            pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
       jobname: ${{matrix.vector.jobname}}
       distro: ${{matrix.vector.pool}}
+      TEST_OUTPUT_DIRECTORY: ${{github.workspace}}/t
     runs-on: ${{matrix.vector.pool}}
     steps:
     - uses: actions/checkout@v4
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a1bc92893f27d6dd404133686b71c8061e55618c..8163aacc8c8715d09f19bd1cc7199532fb5141e2 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,6 +20,7 @@ test:linux:
     - saas-linux-medium-amd64
   variables:
     CUSTOM_PATH: "/custom"
+    TEST_OUTPUT_DIRECTORY: "/tmp/test-output"
   before_script:
     - ./ci/install-dependencies.sh
   script:
@@ -31,6 +32,7 @@ test:linux:
       if test "$CI_JOB_STATUS" != 'success'
       then
         sudo --preserve-env --set-home --user=builder ./ci/print-test-failures.sh
+        mv "$TEST_OUTPUT_DIRECTORY"/failed-test-artifacts t/
       fi
   parallel:
     matrix:
@@ -67,6 +69,10 @@ test:linux:
         image: fedora:latest
       - jobname: linux-musl
         image: alpine:latest
+      - jobname: linux-meson
+        image: ubuntu:latest
+        CC: gcc
+        CC_PACKAGE: gcc
   artifacts:
     paths:
       - t/failed-test-artifacts
@@ -104,6 +110,9 @@ test:osx:
       - jobname: osx-reftable
         image: macos-13-xcode-14
         CC: clang
+      - jobname: osx-meson
+        image: macos-14-xcode-15
+        CC: clang
   artifacts:
     paths:
       - t/failed-test-artifacts
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d020cb7aa5ef64e8cb9e4c580064a84f4b3d1bfb..d1cb9fa8785388b3674fcea4dd682abc0725c968 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -58,6 +58,7 @@ ubuntu-*|ubuntu32-*|debian-*)
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
+		libpcre2-dev meson ninja-build pkg-config \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
 
 	case "$distro" in
@@ -90,6 +91,12 @@ macos-*)
 	sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PATH/p4d" 2>/dev/null || true
 	rm helix-core-server.tgz
 
+	case "$jobname" in
+	osx-meson)
+		brew install meson ninja pcre2
+		;;
+	esac
+
 	if test -n "$CC_PACKAGE"
 	then
 		BREW_PACKAGE=${CC_PACKAGE/-/@}
diff --git a/ci/lib.sh b/ci/lib.sh
index 2e7a5f0540b66f24bd0f5744311c2c48b472d63d..b436f855414226df7f27a1b5ce95702f227d0c53 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -236,7 +236,7 @@ then
 	CC="${CC_PACKAGE:-${CC:-gcc}}"
 	DONT_SKIP_TAGS=t
 	handle_failed_tests () {
-		echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
+		echo "FAILED_TEST_ARTIFACTS=${TEST_OUTPUT_DIRECTORY:-t}/failed-test-artifacts" >>$GITHUB_ENV
 		create_failed_test_artifacts
 		return 1
 	}
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index b1f80aeac345dd70746b02b6ca1b5282a0c2a4aa..655687dd827e5b3e4d4879803b0d4499e7751380 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -46,7 +46,7 @@ do
 			;;
 		github-actions)
 			mkdir -p failed-test-artifacts
-			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
+			echo "FAILED_TEST_ARTIFACTS=${TEST_OUTPUT_DIRECTORY:t}/failed-test-artifacts" >>$GITHUB_ENV
 			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
 			continue
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2e28d02b20f2469afddc4e04fdbd18465babb1ef..c4a41bba0b84df57f6e60aeac2de29dbc0e27dc1 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -48,12 +48,29 @@ pedantic)
 	;;
 esac
 
-group Build make
-if test -n "$run_tests"
-then
-	group "Run tests" make test ||
-	handle_failed_tests
-fi
-check_unignored_build_artifacts
+case "$jobname" in
+*-meson)
+	group "Configure" meson setup build . \
+		--warnlevel 2 --werror \
+		--wrap-mode nofallback
+	group "Build" meson compile -C build --
+	if test -n "$run_tests"
+	then
+		group "Run tests" meson test -C build --print-errorlogs --test-args="$GIT_TEST_OPTS" || (
+			./t/aggregate-results.sh "${TEST_OUTPUT_DIRECTORY:-t}/test-results"
+			handle_failed_tests
+		)
+	fi
+	;;
+*)
+	group Build make
+	if test -n "$run_tests"
+	then
+		group "Run tests" make test ||
+		handle_failed_tests
+	fi
+	;;
+esac
 
+check_unignored_build_artifacts
 save_good_tree

-- 
2.47.1.447.ga7e8429e30.dirty

