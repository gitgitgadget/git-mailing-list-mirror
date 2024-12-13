Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306521BE871
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086506; cv=none; b=BcTSkUlK2yFt6qoOdPgnGEHamRLXCkzwG2uo9eF+9CDJe3I+ltIo89+mtsOiauWKNzHcpWGckRJAJb6SveOMRuQp7iBa8CsAUgO9+LmYneRudPJ5k8uDkJQH1Tjo5vgtEPv7IBZjfgVfEv4yk6r4/bGQJoWNleJFJ3VY7D+zxg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086506; c=relaxed/simple;
	bh=jpfM8pNAc2OiSVHzl26aAgDdFoDK1N+B3sRHWkAqDBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3uHRfoEsyPtVnZDIXp2DF6+U+m1iJnHbs4wAEvJ80gl1TWfnVvvjc8SFamwE6tkrepsVefsA5sLUwBSgxBlGI8gT+vStCUe8D+zwc+gpcV/ojZ3H7ZwPql7MBTycSBesoVzUFUwkrRsKzI7URo9bp4jm2hztk/7NosPWYUiNko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FRPXB6wx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D1Yq5TiC; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FRPXB6wx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1Yq5TiC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4487F254012D;
	Fri, 13 Dec 2024 05:41:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 13 Dec 2024 05:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734086504;
	 x=1734172904; bh=u04CwWXfm3wp+XSyBW3F5Q5GOAZbkBK+ELESMDztEGk=; b=
	FRPXB6wx36de9oT0mm6m2c2TKHIB4EEPWv+tneuwwLX8QB/quYxukf2hzguq0xmQ
	f/vsB389Ml9BhyS9OC98MgQneR70cPfnuoHX6z2Z+b4FTseFnR5jI3e6G+JCSKvu
	aW71eHqN6J9Ws/DfIcqN98bgS5YWu9gEXKpflRtNy8nQDA0MfN5GZ5TcjxtCw0Em
	tQd5SPz4TJJslR0ETURR7rg+m7G1Zi1iJseoZyZpGWbmQGvElmueDuJvT+mv5L5C
	vLMgyNxXPkT9v9Vq8vIUydYcSGb+eR/8B6djku+Cxl97QLDtYx9O6GNJEuJF16OP
	/1ABzBo+MRrhdkt3cPeNGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734086504; x=
	1734172904; bh=u04CwWXfm3wp+XSyBW3F5Q5GOAZbkBK+ELESMDztEGk=; b=D
	1Yq5TiCtM0/xvlfVExb7ViLNDWhSEL1ILVF8hSug/FV0YF9c4jfSAFx9rEdjQg1H
	YaArLhHitpY14+0vpuyw5G45QjsOlcP0b/MaDEsOhgf2j4xkZZ/BQzdSYoetJe/r
	h1hAr9iza6b2fqxkN4SF6hlHIAxFpom0F/cGMWtm4sf8SWHMzDLlKk/SsMvbf5IU
	PXkWDYjplfu3JTRzQt+1dPgoyntBwYIOmPhS35yqS9SdKDfZbYcNPJuj8qyZh1Y5
	AvL8Gpq7DDaNZ2/7CIq6pZr3lbaP3CkilcL22jEyUsZmQlsZydI+axX+ACmS6Smt
	bPHlwBi+pSAOTi1luU4qw==
X-ME-Sender: <xms:Zw9cZ3G5CkGrkUcj3Pl4-IKbOzx2zYZgdOpH1a8eDJI1evK30O1CGw>
    <xme:Zw9cZ0WXTo59pr0N_zXNPkM1VwtkAaTl5R8LOipNlCdHrpAo3Z3vownzZbLsB8T86
    S7I2SWQPgddHnmVXg>
X-ME-Received: <xmr:Zw9cZ5K-WnR1Ux3DhnQmy3igrj5NtaZZLs3GSYxCO3dDOspMPDKgh4aSeIbZS-j5JfQ1NOo3VUYE1PldEtzLFLVMNRcGdytiswmoy-9G-qDXN7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgeeggfelgfekhedvgeffleffkeekheduffefvdehgeei
    geduhedukeelieevtdfgnecuffhomhgrihhnpehvvggtthhorhdrtggtnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:aA9cZ1G8VaFaSKYIG-_nbEKCLIT9xVUssg6oqqiOPT02aW7lGpIIeg>
    <xmx:aA9cZ9W4oc2kgfTmZMY6QyNgrg8O9hRltQVd9E7xqP0_Zo7MM-zoxA>
    <xmx:aA9cZwOtLXUIcL5ptLB5boYbMen8HMIBLbhPuwTYkhiCs4E9TJYbFw>
    <xmx:aA9cZ83tRHl3Nc-HMJGUJ-qw3EmiX8e2BdS3sa9CNWlGqMcOO12C-w>
    <xmx:aA9cZwSQbz0W6-SiF70C_GIJFo8AHaGkIOIzAx3M94PA7uWCjYPBQX_2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:41:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 15f5d946 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 10:39:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 11:41:23 +0100
Subject: [PATCH v2 8/8] ci: wire up Meson builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-pks-meson-ci-v2-8-634affccc694@pks.im>
References: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
In-Reply-To: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
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
 .gitlab-ci.yml             |  8 ++++++++
 ci/install-dependencies.sh |  7 +++++++
 ci/lib.sh                  |  2 +-
 ci/print-test-failures.sh  |  2 +-
 ci/run-build-and-tests.sh  | 31 ++++++++++++++++++++++++-------
 6 files changed, 48 insertions(+), 9 deletions(-)

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
index a1bc92893f27d6dd404133686b71c8061e55618c..3eec72ddc666f593521058b5f38eb6220f42ce0f 100644
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
@@ -67,6 +69,9 @@ test:linux:
         image: fedora:latest
       - jobname: linux-musl
         image: alpine:latest
+      - jobname: linux-meson
+        image: ubuntu:latest
+        CC: gcc
   artifacts:
     paths:
       - t/failed-test-artifacts
@@ -104,6 +109,9 @@ test:osx:
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
2.47.1.668.gf74b3f243a.dirty

