Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58712136347
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509813; cv=none; b=Z4sm/g9BbWMMmvw7lfb1pYdpQnIUFYT60YRI5Om12Sq3Fs3+ZCiVpV02ypdBQlsUSFY+m/JkYWoxoS5exTvnhrY8b3C3NM3KcEmvIBTcn6izQkUKIZ4VPPDCReGpElIG6PK3F2/6p82X4ggGs+Lmy2TEsml/VGgi5MjCxC4ZJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509813; c=relaxed/simple;
	bh=HOYDcRdITPbRiJVgmpa5wuXfRrhM8k1nNsl24srUrwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JCeuVfNhMSPM3xH5mNFG9YGoRFE98E5h3V2W+bxjZVQV++P+KYqs0ajt3KrszW8L1aeiD0Z7TOl3kSAZlizhKh91BI/3lfZQ+2aFwPmmA+dWT6YKMLmvUElg0pmzSLxOCzZBBrM0IJXl5xFOmNRMdX3AEJ/DjmnjrSpisAdgqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QryGsJDu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SJ0SVDdv; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QryGsJDu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SJ0SVDdv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 77BBE140039A;
	Wed, 10 Sep 2025 09:10:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Sep 2025 09:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1757509807; x=1757596207; bh=ZRlnV/R/ei
	gAPWeGoV8j7ZwS0Q3m9fFlCAE/ZDU947Q=; b=QryGsJDu9NcCdY1gj3mV53UjUC
	pxr3isKn/r3b/IOjkNO/YUijgM1GF9wjUSpSQZIzRuVARiAeYtBCicl0dU40kTVD
	YXxO1TG3RMBWXLgDcg3ZUKN20Kx2Qx6v/ONanovsLEG2jPVt7p4ukAZz0AwyUc9E
	mBqkeUkxY6gXJn877GD3zLHjr4dUwnMxIhYV6uVeTkoqoLyB9uGpx9KQEkggVnSK
	5xRH6DBhkFzyCL2DC+tSShSgOTvJ6iK47Eu+pm5HT06tHLfjQImikIkT0CYo9Fkt
	qA+P5pUINRKZS57ZXujF600GpaHynhVlSlAdRIh+P9WN0XBBXxxVngvWUX1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757509807; x=1757596207; bh=ZRlnV/R/eigAPWeGoV8j7ZwS0Q3m
	9fFlCAE/ZDU947Q=; b=SJ0SVDdv73luKVR7ZtkE0uH97z7zEF4QitnEPf9Vfvhw
	I/6JMy/cGqUfin0q5h0MASDyrNMH9NIfwTGpf+cU+KFcnF+JX7Lywe4AElPLiqH8
	A4/Jhk2bgEoK3RnonbwDOd7hhkCi+7C8k9BORSS/4xvyIx8mdx+GYhaaIbsT/Gcc
	fyZ8T+iMApIqQ4Vo4XBF5bKaIzLWc9/WBCxPc1n6Lllfc+LTl6l0bSsd9qToUF4+
	CCVq3WoWFBHtFkHXlmIZn24EPL65xjmz/O2vfi7Y+X/Av0OPxQYQII/ELh2sgg7T
	wRQoN8eWNf2uUy7JUI2V5j3Ug2yWZImjTt2PuxD1yg==
X-ME-Sender: <xms:r3jBaEL0c7FMFeOmOkM7JrEIkmbdeEGU7vW5vYMM8pREERWHIob30w>
    <xme:r3jBaOtZlJIoaQ9tLUOfsw4vLH5Awj_Isj65I-PBvzrQPPTbRswnt63SBQfWCdi4v
    qM440SfG0mkXIcE-w>
X-ME-Received: <xmr:r3jBaBR5tzmGzR2_mdIgBAtt175_3QGqwAYLwY3AL7x-Lj6K_JejL6W9HmKv7AnDx6vxvVQDekKSnhXluQKQcmgwKvVhw0LoXYjMlNhrHQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnheple
    elleevleehgeefieegueelieeuudetgfduueejuefgkefhfefghfehheeigeejnecuffho
    mhgrihhnpegvnhhvrdgttgdpghhithhhuhgsrdgtohhmpdhtfihithhtvghrrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhitghhrggvlhdrohhsihhpohhvsehinhhnohhmohhtihgtshdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:r3jBaEO7lw1uwLT1wk7WtuTH-OGUrtvi_P5Tth9WcrzyN36FSaGGDw>
    <xmx:r3jBaGY7MyaFa6X5bSEQhoqBk6lLIK4udmMIhOmkwAMIJdseHkhs7A>
    <xmx:r3jBaOwBIQk8_kmpYgoh6BJ6wdZCY3M2MCUeO2AFDSVXhfuFnUVH_g>
    <xmx:r3jBaBLAhBNJPn1y96fCuNj3o-AsXaZXyRDx6q3AR3J20FPtJ4dl2w>
    <xmx:r3jBaOV260uDqp8gSj7TyV4ZtHcWwv_oZxnoBAZxrUWBiSkjgTw9VPw6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 09:10:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 211e3360 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 13:10:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Sep 2025 15:09:58 +0200
Subject: [PATCH] t/unit-tests: update clar to fcbed04
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-b4-pks-clar-update-v1-1-26a196237e0a@pks.im>
X-B4-Tracking: v=1; b=H4sIAKV4wWgC/x3MQQqAIBBA0avIrBsws8CuEi0spxoKE60IorsnL
 d/i/wcSRaYErXgg0sWJd59RFgLGxfqZkF02KKlqaaTBQWNYE46bjXgGZw9C7UylSdmmMhJyGCJ
 NfP/Trn/fD1UFajlkAAAA
X-Change-ID: 20250909-b4-pks-clar-update-4d934e2a6390
To: git@vger.kernel.org
Cc: Michael Osipov <michael.osipov@innomotics.com>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Update clar to fcbed04 (Merge pull request #123 from
pks-gitlab/pks-sandbox-ubsan, 2025-09-10). The most significant changes
since the last version include:

  - Fixed platform support for HP-UX.

  - Fixes for how clar handles the `-q` flag.

  - A couple of leak fixes for reported clar errors.

  - A new `cl_invoke()` function that retains line information.

  - New infrastructure to create temporary directories.

  - Improved printing of error messages so that all lines are now
    properly indented.

  - Proper selftests for the clar.

Most of these changes are somewhat irrelevant to us, but neither do we
have to adjust to any of these changes, either. What _is_ interesting to
us though is especially the fixed support for HP-UX, and eventually we
may also want to use `cl_invoke()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this updates us to the latest version of clar. Most of the changes are
somewhat uninteresting to us, but this contains the fixes for HP-UX.

Junio, I was wondering whether we also want to do this similarly to how
you handle the gitk/git-gui pull requests. I ultimately don't mind it
much though, so I'm also happy to do this with "normal" patch series.

Thanks!

Patrick
---
 t/unit-tests/clar/.github/workflows/ci.yml         |  18 +-
 t/unit-tests/clar/CMakeLists.txt                   |  13 +-
 t/unit-tests/clar/README.md                        |  37 +--
 t/unit-tests/clar/clar.c                           | 149 ++++++++---
 t/unit-tests/clar/clar.h                           |  83 ++++--
 t/unit-tests/clar/clar/fixtures.h                  |   6 +-
 t/unit-tests/clar/clar/fs.h                        |  29 +--
 t/unit-tests/clar/clar/print.h                     |  60 +++--
 t/unit-tests/clar/clar/sandbox.h                   | 226 ++++++++++++----
 t/unit-tests/clar/clar/summary.h                   |   5 +-
 t/unit-tests/clar/example/CMakeLists.txt           |  28 ++
 t/unit-tests/clar/example/example.c                |   6 +
 .../clar/{test/main.c.sample => example/main.c}    |   2 +-
 t/unit-tests/clar/test/CMakeLists.txt              |  39 ++-
 t/unit-tests/clar/test/clar_test.h                 |  16 --
 t/unit-tests/clar/test/expected/help               |  12 +
 t/unit-tests/clar/test/expected/quiet              |  49 ++++
 t/unit-tests/clar/test/expected/specific_test      |   9 +
 t/unit-tests/clar/test/expected/stop_on_failure    |   8 +
 t/unit-tests/clar/test/expected/suite_names        |   2 +
 t/unit-tests/clar/test/expected/summary.xml        |  45 ++++
 .../clar/test/expected/summary_with_filename       |  54 ++++
 .../clar/test/expected/summary_without_filename    |  54 ++++
 t/unit-tests/clar/test/expected/tap                | 102 ++++++++
 t/unit-tests/clar/test/expected/without_arguments  |  53 ++++
 t/unit-tests/clar/test/main.c                      |  41 +--
 t/unit-tests/clar/test/selftest.c                  | 289 +++++++++++++++++++++
 t/unit-tests/clar/test/selftest.h                  |   3 +
 .../clar/test/selftest_suite/CMakeLists.txt        |  40 +++
 t/unit-tests/clar/test/selftest_suite/main.c       |  27 ++
 .../test/{ => selftest_suite}/resources/test/file  |   0
 .../{sample.c => selftest_suite/selftest_suite.c}  |  44 ++--
 32 files changed, 1311 insertions(+), 238 deletions(-)

diff --git a/t/unit-tests/clar/.github/workflows/ci.yml b/t/unit-tests/clar/.github/workflows/ci.yml
index 0065843d17a..c41f55f6ff5 100644
--- a/t/unit-tests/clar/.github/workflows/ci.yml
+++ b/t/unit-tests/clar/.github/workflows/ci.yml
@@ -13,6 +13,11 @@ jobs:
         platform:
           - os: ubuntu-latest
             generator: Unix Makefiles
+          - os: ubuntu-latest
+            generator: Unix Makefiles
+            env:
+              CC: "clang"
+              CFLAGS: "-fsanitize=leak"
           - os: macos-latest
             generator: Unix Makefiles
           - os: windows-latest
@@ -21,15 +26,26 @@ jobs:
             generator: MSYS Makefiles
           - os: windows-latest
             generator: MinGW Makefiles
+      fail-fast: false
 
     runs-on: ${{ matrix.platform.os }}
 
+    env:
+      CC: ${{matrix.platform.env.CC}}
+      CFLAGS: ${{matrix.platform.env.CFLAGS}}
+
     steps:
     - name: Check out
       uses: actions/checkout@v2
     - name: Build
+      shell: bash
       run: |
         mkdir build
         cd build
         cmake .. -G "${{matrix.platform.generator}}"
-        cmake --build .
+        cmake --build . --verbose
+    - name: Test
+      shell: bash
+      run: |
+        cd build
+        CTEST_OUTPUT_ON_FAILURE=1 ctest --build-config Debug
diff --git a/t/unit-tests/clar/CMakeLists.txt b/t/unit-tests/clar/CMakeLists.txt
index 12d4af114fe..125db05bc10 100644
--- a/t/unit-tests/clar/CMakeLists.txt
+++ b/t/unit-tests/clar/CMakeLists.txt
@@ -1,8 +1,15 @@
+include(CheckFunctionExists)
+
 cmake_minimum_required(VERSION 3.16..3.29)
 
 project(clar LANGUAGES C)
 
-option(BUILD_TESTS "Build test executable" ON)
+option(BUILD_EXAMPLE "Build the example." ON)
+
+check_function_exists(realpath CLAR_HAS_REALPATH)
+if(CLAR_HAS_REALPATH)
+	add_compile_definitions(-DCLAR_HAS_REALPATH)
+endif()
 
 add_library(clar INTERFACE)
 target_sources(clar INTERFACE
@@ -25,4 +32,8 @@ if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
 	if(BUILD_TESTING)
 		add_subdirectory(test)
 	endif()
+
+	if(BUILD_EXAMPLE)
+		add_subdirectory(example)
+	endif()
 endif()
diff --git a/t/unit-tests/clar/README.md b/t/unit-tests/clar/README.md
index a8961c5f10f..41595989ca6 100644
--- a/t/unit-tests/clar/README.md
+++ b/t/unit-tests/clar/README.md
@@ -26,8 +26,7 @@ Can you count to funk?
     ~~~~ sh
     $ mkdir tests
     $ cp -r $CLAR_ROOT/clar* tests
-    $ cp $CLAR_ROOT/test/clar_test.h tests
-    $ cp $CLAR_ROOT/test/main.c.sample tests/main.c
+    $ cp $CLAR_ROOT/example/*.c tests
     ~~~~
 
 - **One: Write some tests**
@@ -147,7 +146,7 @@ To use Clar:
 
 1. copy the Clar boilerplate to your test directory
 2. copy (and probably modify) the sample `main.c` (from
-   `$CLAR_PATH/test/main.c.sample`)
+   `$CLAR_PATH/example/main.c`)
 3. run the Clar mixer (a.k.a. `generate.py`) to scan your test directory and
    write out the test suite metadata.
 4. compile your test files and the Clar boilerplate into a single test
@@ -159,7 +158,7 @@ The Clar boilerplate gives you a set of useful test assertions and features
 the `clar.c` and `clar.h` files, plus the code in the `clar/` subdirectory.
 You should not need to edit these files.
 
-The sample `main.c` (i.e. `$CLAR_PATH/test/main.c.sample`) file invokes
+The sample `main.c` (i.e. `$CLAR_PATH/example/main.c`) file invokes
 `clar_test(argc, argv)` to run the tests.  Usually, you will edit this file
 to perform any framework specific initialization and teardown that you need.
 
@@ -251,11 +250,16 @@ suite.
 
 -   `cl_fixture(const char *)`: Gets the full path to a fixture file.
 
-Please do note that these methods are *always* available whilst running a
-test, even when calling auxiliary/static functions inside the same file.
+### Auxiliary / helper functions
 
-It's strongly encouraged to perform test assertions in auxiliary methods,
-instead of returning error values. This is considered good Clar style.
+The clar API is always available while running a test, even when calling
+"auxiliary" (helper) functions.
+
+You're encouraged to perform test assertions in those auxiliary
+methods, instead of returning error values. This is considered good
+Clar style. _However_, when you do this, you need to call `cl_invoke`
+to preserve the current state; this ensures that failures are reported
+as coming from the actual test, instead of the auxiliary method.
 
 Style Example:
 
@@ -310,20 +314,19 @@ static void check_string(const char *str)
 
 void test_example__a_test_with_auxiliary_methods(void)
 {
-    check_string("foo");
-    check_string("bar");
+    cl_invoke(check_string("foo"));
+    cl_invoke(check_string("bar"));
 }
 ~~~~
 
 About Clar
 ==========
 
-Clar has been written from scratch by [Vicent Martí](https://github.com/vmg),
-to replace the old testing framework in [libgit2][libgit2].
-
-Do you know what languages are *in* on the SF startup scene? Node.js *and*
-Latin.  Follow [@vmg](https://www.twitter.com/vmg) on Twitter to
-receive more lessons on word etymology. You can be hip too.
-
+Clar was originally written by [Vicent Martí](https://github.com/vmg),
+to replace the old testing framework in [libgit2][libgit2]. It is
+currently maintained by [Edward Thomson](https://github.com/ethomson),
+and used by the [libgit2][libgit2] and [git][git] projects, amongst
+others.
 
 [libgit2]: https://github.com/libgit2/libgit2
+[git]: https://github.com/git/git
diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index 03a3aa8e873..80c53594252 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -79,6 +79,8 @@
 #	else
 #		define p_snprintf snprintf
 #	endif
+
+#	define localtime_r(timer, buf) (localtime_s(buf, timer) == 0 ? buf : NULL)
 #else
 #	include <sys/wait.h> /* waitpid(2) */
 #	include <unistd.h>
@@ -150,7 +152,6 @@ static struct {
 
 	enum cl_output_format output_format;
 
-	int report_errors_only;
 	int exit_on_error;
 	int verbosity;
 
@@ -164,6 +165,10 @@ static struct {
 	struct clar_report *reports;
 	struct clar_report *last_report;
 
+	const char *invoke_file;
+	const char *invoke_func;
+	size_t invoke_line;
+
 	void (*local_cleanup)(void *);
 	void *local_cleanup_payload;
 
@@ -199,8 +204,10 @@ static void clar_print_onabortv(const char *msg, va_list argp);
 static void clar_print_onabort(const char *msg, ...);
 
 /* From clar_sandbox.c */
-static void clar_unsandbox(void);
-static void clar_sandbox(void);
+static void clar_tempdir_init(void);
+static void clar_tempdir_shutdown(void);
+static int clar_sandbox_create(const char *suite_name, const char *test_name);
+static int clar_sandbox_cleanup(void);
 
 /* From summary.h */
 static struct clar_summary *clar_summary_init(const char *filename);
@@ -304,6 +311,8 @@ clar_run_test(
 
 	CL_TRACE(CL_TRACE__TEST__BEGIN);
 
+	clar_sandbox_create(suite->name, test->name);
+
 	_clar.last_report->start = time(NULL);
 	clar_time_now(&start);
 
@@ -328,9 +337,13 @@ clar_run_test(
 	if (_clar.local_cleanup != NULL)
 		_clar.local_cleanup(_clar.local_cleanup_payload);
 
+	clar__clear_invokepoint();
+
 	if (cleanup->ptr != NULL)
 		cleanup->ptr();
 
+	clar_sandbox_cleanup();
+
 	CL_TRACE(CL_TRACE__TEST__END);
 
 	_clar.tests_ran++;
@@ -339,11 +352,7 @@ clar_run_test(
 	_clar.local_cleanup = NULL;
 	_clar.local_cleanup_payload = NULL;
 
-	if (_clar.report_errors_only) {
-		clar_report_errors(_clar.last_report);
-	} else {
-		clar_print_ontest(suite->name, test->name, _clar.tests_ran, _clar.last_report->status);
-	}
+	clar_print_ontest(suite->name, test->name, _clar.tests_ran, _clar.last_report->status);
 }
 
 static void
@@ -360,8 +369,7 @@ clar_run_suite(const struct clar_suite *suite, const char *filter)
 	if (_clar.exit_on_error && _clar.total_errors)
 		return;
 
-	if (!_clar.report_errors_only)
-		clar_print_onsuite(suite->name, ++_clar.suites_ran);
+	clar_print_onsuite(suite->name, ++_clar.suites_ran);
 
 	_clar.active_suite = suite->name;
 	_clar.active_test = NULL;
@@ -428,12 +436,12 @@ clar_usage(const char *arg)
 	printf("  -iname        Include the suite with `name`\n");
 	printf("  -xname        Exclude the suite with `name`\n");
 	printf("  -v            Increase verbosity (show suite names)\n");
-	printf("  -q            Only report tests that had an error\n");
+	printf("  -q            Decrease verbosity, inverse to -v\n");
 	printf("  -Q            Quit as soon as a test fails\n");
 	printf("  -t            Display results in tap format\n");
 	printf("  -l            Print suite names\n");
 	printf("  -r[filename]  Write summary file (to the optional filename)\n");
-	exit(-1);
+	exit(1);
 }
 
 static void
@@ -441,18 +449,11 @@ clar_parse_args(int argc, char **argv)
 {
 	int i;
 
-	/* Verify options before execute */
 	for (i = 1; i < argc; ++i) {
 		char *argument = argv[i];
 
-		if (argument[0] != '-' || argument[1] == '\0'
-		    || strchr("sixvqQtlr", argument[1]) == NULL) {
+		if (argument[0] != '-' || argument[1] == '\0')
 			clar_usage(argv[0]);
-		}
-	}
-
-	for (i = 1; i < argc; ++i) {
-		char *argument = argv[i];
 
 		switch (argument[1]) {
 		case 's':
@@ -465,8 +466,13 @@ clar_parse_args(int argc, char **argv)
 			argument += offset;
 			arglen = strlen(argument);
 
-			if (arglen == 0)
-				clar_usage(argv[0]);
+			if (arglen == 0) {
+				if (i + 1 == argc)
+					clar_usage(argv[0]);
+
+				argument = argv[++i];
+				arglen = strlen(argument);
+			}
 
 			for (j = 0; j < _clar_suite_count; ++j) {
 				suitelen = strlen(_clar_suites[j].name);
@@ -483,9 +489,6 @@ clar_parse_args(int argc, char **argv)
 
 					++found;
 
-					if (!exact)
-						_clar.verbosity = MAX(_clar.verbosity, 1);
-
 					switch (action) {
 					case 's': {
 						struct clar_explicit *explicit;
@@ -517,23 +520,37 @@ clar_parse_args(int argc, char **argv)
 
 			if (!found)
 				clar_abort("No suite matching '%s' found.\n", argument);
+
 			break;
 		}
 
 		case 'q':
-			_clar.report_errors_only = 1;
+			if (argument[2] != '\0')
+				clar_usage(argv[0]);
+
+			_clar.verbosity--;
 			break;
 
 		case 'Q':
+			if (argument[2] != '\0')
+				clar_usage(argv[0]);
+
 			_clar.exit_on_error = 1;
 			break;
 
 		case 't':
+			if (argument[2] != '\0')
+				clar_usage(argv[0]);
+
 			_clar.output_format = CL_OUTPUT_TAP;
 			break;
 
 		case 'l': {
 			size_t j;
+
+			if (argument[2] != '\0')
+				clar_usage(argv[0]);
+
 			printf("Test suites (use -s<name> to run just one):\n");
 			for (j = 0; j < _clar_suite_count; ++j)
 				printf(" %3d: %s\n", (int)j, _clar_suites[j].name);
@@ -542,23 +559,27 @@ clar_parse_args(int argc, char **argv)
 		}
 
 		case 'v':
+			if (argument[2] != '\0')
+				clar_usage(argv[0]);
+
 			_clar.verbosity++;
 			break;
 
 		case 'r':
 			_clar.write_summary = 1;
 			free(_clar.summary_filename);
+
 			if (*(argument + 2)) {
 				if ((_clar.summary_filename = strdup(argument + 2)) == NULL)
 					clar_abort("Failed to allocate summary filename.\n");
 			} else {
 				_clar.summary_filename = NULL;
 			}
+
 			break;
 
 		default:
-			clar_abort("Unexpected commandline argument '%s'.\n",
-				   argument[1]);
+			clar_usage(argv[0]);
 		}
 	}
 }
@@ -591,7 +612,7 @@ clar_test_init(int argc, char **argv)
 	if (_clar.write_summary)
 	    _clar.summary = clar_summary_init(_clar.summary_filename);
 
-	clar_sandbox();
+	clar_tempdir_init();
 }
 
 int
@@ -623,7 +644,7 @@ clar_test_shutdown(void)
 		_clar.total_errors
 	);
 
-	clar_unsandbox();
+	clar_tempdir_shutdown();
 
 	if (_clar.write_summary && clar_summary_shutdown(_clar.summary) < 0)
 		clar_abort("Failed to write the summary file '%s: %s.\n",
@@ -635,6 +656,14 @@ clar_test_shutdown(void)
 	}
 
 	for (report = _clar.reports; report; report = report_next) {
+		struct clar_error *error, *error_next;
+
+		for (error = report->errors; error; error = error_next) {
+			free(error->description);
+			error_next = error->next;
+			free(error);
+		}
+
 		report_next = report->next;
 		free(report);
 	}
@@ -660,7 +689,7 @@ static void abort_test(void)
 		clar_print_onabort(
 				"Fatal error: a cleanup method raised an exception.\n");
 		clar_report_errors(_clar.last_report);
-		exit(-1);
+		exit(1);
 	}
 
 	CL_TRACE(CL_TRACE__TEST__LONGJMP);
@@ -695,9 +724,9 @@ void clar__fail(
 
 	_clar.last_report->last_error = error;
 
-	error->file = file;
-	error->function = function;
-	error->line_number = line;
+	error->file = _clar.invoke_file ? _clar.invoke_file : file;
+	error->function = _clar.invoke_func ? _clar.invoke_func : function;
+	error->line_number = _clar.invoke_line ? _clar.invoke_line : line;
 	error->error_msg = error_msg;
 
 	if (description != NULL &&
@@ -754,7 +783,12 @@ void clar__assert_equal(
 				p_snprintf(buf, sizeof(buf), "'%s' != '%s' (at byte %d)",
 					s1, s2, pos);
 			} else {
-				p_snprintf(buf, sizeof(buf), "'%s' != '%s'", s1, s2);
+				const char *q1 = s1 ? "'" : "";
+				const char *q2 = s2 ? "'" : "";
+				s1 = s1 ? s1 : "NULL";
+				s2 = s2 ? s2 : "NULL";
+				p_snprintf(buf, sizeof(buf), "%s%s%s != %s%s%s",
+					   q1, s1, q1, q2, s2, q2);
 			}
 		}
 	}
@@ -767,12 +801,17 @@ void clar__assert_equal(
 		if (!is_equal) {
 			if (s1 && s2) {
 				int pos;
-				for (pos = 0; s1[pos] == s2[pos] && pos < len; ++pos)
+				for (pos = 0; pos < len && s1[pos] == s2[pos]; ++pos)
 					/* find differing byte offset */;
 				p_snprintf(buf, sizeof(buf), "'%.*s' != '%.*s' (at byte %d)",
 					len, s1, len, s2, pos);
 			} else {
-				p_snprintf(buf, sizeof(buf), "'%.*s' != '%.*s'", len, s1, len, s2);
+				const char *q1 = s1 ? "'" : "";
+				const char *q2 = s2 ? "'" : "";
+				s1 = s1 ? s1 : "NULL";
+				s2 = s2 ? s2 : "NULL";
+				p_snprintf(buf, sizeof(buf), "%s%.*s%s != %s%.*s%s",
+					   q1, len, s1, q1, q2, len, s2, q2);
 			}
 		}
 	}
@@ -790,7 +829,12 @@ void clar__assert_equal(
 				p_snprintf(buf, sizeof(buf), "'%ls' != '%ls' (at byte %d)",
 					wcs1, wcs2, pos);
 			} else {
-				p_snprintf(buf, sizeof(buf), "'%ls' != '%ls'", wcs1, wcs2);
+				const char *q1 = wcs1 ? "'" : "";
+				const char *q2 = wcs2 ? "'" : "";
+				wcs1 = wcs1 ? wcs1 : L"NULL";
+				wcs2 = wcs2 ? wcs2 : L"NULL";
+				p_snprintf(buf, sizeof(buf), "%s%ls%s != %s%ls%s",
+					   q1, wcs1, q1, q2, wcs2, q2);
 			}
 		}
 	}
@@ -803,12 +847,17 @@ void clar__assert_equal(
 		if (!is_equal) {
 			if (wcs1 && wcs2) {
 				int pos;
-				for (pos = 0; wcs1[pos] == wcs2[pos] && pos < len; ++pos)
+				for (pos = 0; pos < len && wcs1[pos] == wcs2[pos]; ++pos)
 					/* find differing byte offset */;
 				p_snprintf(buf, sizeof(buf), "'%.*ls' != '%.*ls' (at byte %d)",
 					len, wcs1, len, wcs2, pos);
 			} else {
-				p_snprintf(buf, sizeof(buf), "'%.*ls' != '%.*ls'", len, wcs1, len, wcs2);
+				const char *q1 = wcs1 ? "'" : "";
+				const char *q2 = wcs2 ? "'" : "";
+				wcs1 = wcs1 ? wcs1 : L"NULL";
+				wcs2 = wcs2 ? wcs2 : L"NULL";
+				p_snprintf(buf, sizeof(buf), "%s%.*ls%s != %s%.*ls%s",
+					   q1, len, wcs1, q1, q2, len, wcs2, q2);
 			}
 		}
 	}
@@ -826,7 +875,8 @@ void clar__assert_equal(
 		void *p1 = va_arg(args, void *), *p2 = va_arg(args, void *);
 		is_equal = (p1 == p2);
 		if (!is_equal)
-			p_snprintf(buf, sizeof(buf), "%p != %p", p1, p2);
+			p_snprintf(buf, sizeof(buf), "0x%"PRIxPTR" != 0x%"PRIxPTR,
+				   (uintptr_t)p1, (uintptr_t)p2);
 	}
 	else {
 		int i1 = va_arg(args, int), i2 = va_arg(args, int);
@@ -850,6 +900,23 @@ void cl_set_cleanup(void (*cleanup)(void *), void *opaque)
 	_clar.local_cleanup_payload = opaque;
 }
 
+void clar__set_invokepoint(
+	const char *file,
+	const char *func,
+	size_t line)
+{
+	_clar.invoke_file = file;
+	_clar.invoke_func = func;
+	_clar.invoke_line = line;
+}
+
+void clar__clear_invokepoint(void)
+{
+	_clar.invoke_file = NULL;
+	_clar.invoke_func = NULL;
+	_clar.invoke_line = 0;
+}
+
 #include "clar/sandbox.h"
 #include "clar/fixtures.h"
 #include "clar/fs.h"
diff --git a/t/unit-tests/clar/clar.h b/t/unit-tests/clar/clar.h
index 8c22382bd56..ca72292ae91 100644
--- a/t/unit-tests/clar/clar.h
+++ b/t/unit-tests/clar/clar.h
@@ -8,6 +8,25 @@
 #define __CLAR_TEST_H__
 
 #include <stdlib.h>
+#include <limits.h>
+
+#if defined(_WIN32) && defined(CLAR_WIN32_LONGPATHS)
+# define CLAR_MAX_PATH 4096
+#elif defined(_WIN32)
+# define CLAR_MAX_PATH MAX_PATH
+#else
+# define CLAR_MAX_PATH PATH_MAX
+#endif
+
+#ifndef CLAR_SELFTEST
+# define CLAR_CURRENT_FILE __FILE__
+# define CLAR_CURRENT_LINE __LINE__
+# define CLAR_CURRENT_FUNC __func__
+#else
+# define CLAR_CURRENT_FILE "file"
+# define CLAR_CURRENT_LINE 42
+# define CLAR_CURRENT_FUNC "func"
+#endif
 
 enum cl_test_status {
 	CL_TEST_OK,
@@ -30,6 +49,7 @@ void clar_test_shutdown(void);
 int clar_test(int argc, char *argv[]);
 
 const char *clar_sandbox_path(void);
+const char *clar_tempdir_path(void);
 
 void cl_set_cleanup(void (*cleanup)(void *), void *opaque);
 void cl_fs_cleanup(void);
@@ -83,19 +103,33 @@ void cl_fixture_cleanup(const char *fixture_name);
 const char *cl_fixture_basename(const char *fixture_name);
 #endif
 
+/**
+ * Invoke a helper function, which itself will use `cl_assert`
+ * constructs. This will preserve the stack information of the
+ * current call point, so that function name and line number
+ * information is shown from the line of the test, instead of
+ * the helper function.
+ */
+#define cl_invoke(expr) \
+	do { \
+		clar__set_invokepoint(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE); \
+		expr; \
+		clar__clear_invokepoint(); \
+	} while(0)
+
 /**
  * Assertion macros with explicit error message
  */
-#define cl_must_pass_(expr, desc) clar__assert((expr) >= 0, __FILE__, __func__, __LINE__, "Function call failed: " #expr, desc, 1)
-#define cl_must_fail_(expr, desc) clar__assert((expr) < 0, __FILE__, __func__, __LINE__, "Expected function call to fail: " #expr, desc, 1)
-#define cl_assert_(expr, desc) clar__assert((expr) != 0, __FILE__, __func__, __LINE__, "Expression is not true: " #expr, desc, 1)
+#define cl_must_pass_(expr, desc) clar__assert((expr) >= 0, CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Function call failed: " #expr, desc, 1)
+#define cl_must_fail_(expr, desc) clar__assert((expr) < 0, CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Expected function call to fail: " #expr, desc, 1)
+#define cl_assert_(expr, desc) clar__assert((expr) != 0, CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Expression is not true: " #expr, desc, 1)
 
 /**
  * Check macros with explicit error message
  */
-#define cl_check_pass_(expr, desc) clar__assert((expr) >= 0, __FILE__, __func__, __LINE__, "Function call failed: " #expr, desc, 0)
-#define cl_check_fail_(expr, desc) clar__assert((expr) < 0, __FILE__, __func__, __LINE__, "Expected function call to fail: " #expr, desc, 0)
-#define cl_check_(expr, desc) clar__assert((expr) != 0, __FILE__, __func__, __LINE__, "Expression is not true: " #expr, desc, 0)
+#define cl_check_pass_(expr, desc) clar__assert((expr) >= 0, CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Function call failed: " #expr, desc, 0)
+#define cl_check_fail_(expr, desc) clar__assert((expr) < 0, CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Expected function call to fail: " #expr, desc, 0)
+#define cl_check_(expr, desc) clar__assert((expr) != 0, CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Expression is not true: " #expr, desc, 0)
 
 /**
  * Assertion macros with no error message
@@ -114,33 +148,33 @@ const char *cl_fixture_basename(const char *fixture_name);
 /**
  * Forced failure/warning
  */
-#define cl_fail(desc) clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1)
-#define cl_warning(desc) clar__fail(__FILE__, __func__, __LINE__, "Warning during test execution:", desc, 0)
+#define cl_fail(desc) clar__fail(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Test failed.", desc, 1)
+#define cl_warning(desc) clar__fail(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Warning during test execution:", desc, 0)
 
 #define cl_skip() clar__skip()
 
 /**
  * Typed assertion macros
  */
-#define cl_assert_equal_s(s1,s2) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #s1 " != " #s2, 1, "%s", (s1), (s2))
-#define cl_assert_equal_s_(s1,s2,note) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #s1 " != " #s2 " (" #note ")", 1, "%s", (s1), (s2))
+#define cl_assert_equal_s(s1,s2) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"String mismatch: " #s1 " != " #s2, 1, "%s", (s1), (s2))
+#define cl_assert_equal_s_(s1,s2,note) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"String mismatch: " #s1 " != " #s2 " (" #note ")", 1, "%s", (s1), (s2))
 
-#define cl_assert_equal_wcs(wcs1,wcs2) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #wcs1 " != " #wcs2, 1, "%ls", (wcs1), (wcs2))
-#define cl_assert_equal_wcs_(wcs1,wcs2,note) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #wcs1 " != " #wcs2 " (" #note ")", 1, "%ls", (wcs1), (wcs2))
+#define cl_assert_equal_wcs(wcs1,wcs2) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"String mismatch: " #wcs1 " != " #wcs2, 1, "%ls", (wcs1), (wcs2))
+#define cl_assert_equal_wcs_(wcs1,wcs2,note) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"String mismatch: " #wcs1 " != " #wcs2 " (" #note ")", 1, "%ls", (wcs1), (wcs2))
 
-#define cl_assert_equal_strn(s1,s2,len) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #s1 " != " #s2, 1, "%.*s", (s1), (s2), (int)(len))
-#define cl_assert_equal_strn_(s1,s2,len,note) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #s1 " != " #s2 " (" #note ")", 1, "%.*s", (s1), (s2), (int)(len))
+#define cl_assert_equal_strn(s1,s2,len) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"String mismatch: " #s1 " != " #s2, 1, "%.*s", (s1), (s2), (int)(len))
+#define cl_assert_equal_strn_(s1,s2,len,note) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"String mismatch: " #s1 " != " #s2 " (" #note ")", 1, "%.*s", (s1), (s2), (int)(len))
 
-#define cl_assert_equal_wcsn(wcs1,wcs2,len) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #wcs1 " != " #wcs2, 1, "%.*ls", (wcs1), (wcs2), (int)(len))
-#define cl_assert_equal_wcsn_(wcs1,wcs2,len,note) clar__assert_equal(__FILE__,__func__,__LINE__,"String mismatch: " #wcs1 " != " #wcs2 " (" #note ")", 1, "%.*ls", (wcs1), (wcs2), (int)(len))
+#define cl_assert_equal_wcsn(wcs1,wcs2,len) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"String mismatch: " #wcs1 " != " #wcs2, 1, "%.*ls", (wcs1), (wcs2), (int)(len))
+#define cl_assert_equal_wcsn_(wcs1,wcs2,len,note) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"String mismatch: " #wcs1 " != " #wcs2 " (" #note ")", 1, "%.*ls", (wcs1), (wcs2), (int)(len))
 
-#define cl_assert_equal_i(i1,i2) clar__assert_equal(__FILE__,__func__,__LINE__,#i1 " != " #i2, 1, "%d", (int)(i1), (int)(i2))
-#define cl_assert_equal_i_(i1,i2,note) clar__assert_equal(__FILE__,__func__,__LINE__,#i1 " != " #i2 " (" #note ")", 1, "%d", (i1), (i2))
-#define cl_assert_equal_i_fmt(i1,i2,fmt) clar__assert_equal(__FILE__,__func__,__LINE__,#i1 " != " #i2, 1, (fmt), (int)(i1), (int)(i2))
+#define cl_assert_equal_i(i1,i2) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#i1 " != " #i2, 1, "%d", (int)(i1), (int)(i2))
+#define cl_assert_equal_i_(i1,i2,note) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#i1 " != " #i2 " (" #note ")", 1, "%d", (i1), (i2))
+#define cl_assert_equal_i_fmt(i1,i2,fmt) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#i1 " != " #i2, 1, (fmt), (int)(i1), (int)(i2))
 
-#define cl_assert_equal_b(b1,b2) clar__assert_equal(__FILE__,__func__,__LINE__,#b1 " != " #b2, 1, "%d", (int)((b1) != 0),(int)((b2) != 0))
+#define cl_assert_equal_b(b1,b2) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,#b1 " != " #b2, 1, "%d", (int)((b1) != 0),(int)((b2) != 0))
 
-#define cl_assert_equal_p(p1,p2) clar__assert_equal(__FILE__,__func__,__LINE__,"Pointer mismatch: " #p1 " != " #p2, 1, "%p", (p1), (p2))
+#define cl_assert_equal_p(p1,p2) clar__assert_equal(CLAR_CURRENT_FILE,CLAR_CURRENT_FUNC,CLAR_CURRENT_LINE,"Pointer mismatch: " #p1 " != " #p2, 1, "%p", (p1), (p2))
 
 void clar__skip(void);
 
@@ -170,4 +204,11 @@ void clar__assert_equal(
 	const char *fmt,
 	...);
 
+void clar__set_invokepoint(
+	const char *file,
+	const char *func,
+	size_t line);
+
+void clar__clear_invokepoint(void);
+
 #endif
diff --git a/t/unit-tests/clar/clar/fixtures.h b/t/unit-tests/clar/clar/fixtures.h
index 6ec6423484d..9f1023df594 100644
--- a/t/unit-tests/clar/clar/fixtures.h
+++ b/t/unit-tests/clar/clar/fixtures.h
@@ -2,7 +2,7 @@
 static const char *
 fixture_path(const char *base, const char *fixture_name)
 {
-	static char _path[4096];
+	static char _path[CLAR_MAX_PATH];
 	size_t root_len;
 
 	root_len = strlen(base);
@@ -28,7 +28,7 @@ const char *cl_fixture(const char *fixture_name)
 
 void cl_fixture_sandbox(const char *fixture_name)
 {
-	fs_copy(cl_fixture(fixture_name), _clar_path);
+	fs_copy(cl_fixture(fixture_name), clar_sandbox_path());
 }
 
 const char *cl_fixture_basename(const char *fixture_name)
@@ -45,6 +45,6 @@ const char *cl_fixture_basename(const char *fixture_name)
 
 void cl_fixture_cleanup(const char *fixture_name)
 {
-	fs_rm(fixture_path(_clar_path, cl_fixture_basename(fixture_name)));
+	fs_rm(fixture_path(clar_sandbox_path(), cl_fixture_basename(fixture_name)));
 }
 #endif
diff --git a/t/unit-tests/clar/clar/fs.h b/t/unit-tests/clar/clar/fs.h
index 2203743fb48..f1311d91e85 100644
--- a/t/unit-tests/clar/clar/fs.h
+++ b/t/unit-tests/clar/clar/fs.h
@@ -8,12 +8,6 @@
 
 #ifdef _WIN32
 
-#ifdef CLAR_WIN32_LONGPATHS
-# define CLAR_MAX_PATH 4096
-#else
-# define CLAR_MAX_PATH MAX_PATH
-#endif
-
 #define RM_RETRY_COUNT	5
 #define RM_RETRY_DELAY	10
 
@@ -296,7 +290,7 @@ void
 cl_fs_cleanup(void)
 {
 #ifdef CLAR_FIXTURE_PATH
-	fs_rm(fixture_path(_clar_path, "*"));
+	fs_rm(fixture_path(clar_tempdir_path(), "*"));
 #else
 	((void)fs_copy); /* unused */
 #endif
@@ -371,17 +365,19 @@ static void
 fs_copydir_helper(const char *source, const char *dest, int dest_mode)
 {
 	DIR *source_dir;
-	struct dirent *d;
 
 	mkdir(dest, dest_mode);
 
 	cl_assert_(source_dir = opendir(source), "Could not open source dir");
-	for (;;) {
+	while (1) {
+		struct dirent *d;
 		char *child;
 
 		errno = 0;
-		if ((d = readdir(source_dir)) == NULL)
+		d = readdir(source_dir);
+		if (!d)
 			break;
+
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
@@ -479,15 +475,18 @@ static void
 fs_rmdir_helper(const char *path)
 {
 	DIR *dir;
-	struct dirent *d;
 
 	cl_assert_(dir = opendir(path), "Could not open dir");
-	for (;;) {
+
+	while (1) {
+		struct dirent *d;
 		char *child;
 
 		errno = 0;
-		if ((d = readdir(dir)) == NULL)
+		d = readdir(dir);
+		if (!d)
 			break;
+
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
@@ -524,7 +523,7 @@ fs_rm(const char *path)
 void
 cl_fs_cleanup(void)
 {
-	clar_unsandbox();
-	clar_sandbox();
+	clar_tempdir_shutdown();
+	clar_tempdir_init();
 }
 #endif
diff --git a/t/unit-tests/clar/clar/print.h b/t/unit-tests/clar/clar/print.h
index 69d0ee967e7..0282aaa1381 100644
--- a/t/unit-tests/clar/clar/print.h
+++ b/t/unit-tests/clar/clar/print.h
@@ -3,6 +3,10 @@
 static void clar_print_clap_init(int test_count, int suite_count, const char *suite_names)
 {
 	(void)test_count;
+
+	if (_clar.verbosity < 0)
+		return;
+
 	printf("Loaded %d suites: %s\n", (int)suite_count, suite_names);
 	printf("Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')\n");
 }
@@ -13,10 +17,27 @@ static void clar_print_clap_shutdown(int test_count, int suite_count, int error_
 	(void)suite_count;
 	(void)error_count;
 
-	printf("\n\n");
+	if (_clar.verbosity >= 0)
+		printf("\n\n");
 	clar_report_all();
 }
 
+
+static void clar_print_indented(const char *str, int indent)
+{
+	const char *bol, *eol;
+
+	for (bol = str; *bol; bol = eol) {
+		eol = strchr(bol, '\n');
+		if (eol)
+			eol++;
+		else
+			eol = bol + strlen(bol);
+		printf("%*s%.*s", indent, "", (int)(eol - bol), bol);
+	}
+	putc('\n', stdout);
+}
+
 static void clar_print_clap_error(int num, const struct clar_report *report, const struct clar_error *error)
 {
 	printf("  %d) Failure:\n", num);
@@ -27,10 +48,10 @@ static void clar_print_clap_error(int num, const struct clar_report *report, con
 		error->file,
 		error->line_number);
 
-	printf("  %s\n", error->error_msg);
+	clar_print_indented(error->error_msg, 2);
 
 	if (error->description != NULL)
-		printf("  %s\n", error->description);
+		clar_print_indented(error->description, 2);
 
 	printf("\n");
 	fflush(stdout);
@@ -41,14 +62,17 @@ static void clar_print_clap_ontest(const char *suite_name, const char *test_name
 	(void)test_name;
 	(void)test_number;
 
+	if (_clar.verbosity < 0)
+		return;
+
 	if (_clar.verbosity > 1) {
 		printf("%s::%s: ", suite_name, test_name);
 
 		switch (status) {
 		case CL_TEST_OK: printf("ok\n"); break;
 		case CL_TEST_FAILURE: printf("fail\n"); break;
-		case CL_TEST_SKIP: printf("skipped"); break;
-		case CL_TEST_NOTRUN: printf("notrun"); break;
+		case CL_TEST_SKIP: printf("skipped\n"); break;
+		case CL_TEST_NOTRUN: printf("notrun\n"); break;
 		}
 	} else {
 		switch (status) {
@@ -64,6 +88,8 @@ static void clar_print_clap_ontest(const char *suite_name, const char *test_name
 
 static void clar_print_clap_onsuite(const char *suite_name, int suite_index)
 {
+	if (_clar.verbosity < 0)
+		return;
 	if (_clar.verbosity == 1)
 		printf("\n%s", suite_name);
 
@@ -127,18 +153,20 @@ static void clar_print_tap_ontest(const char *suite_name, const char *test_name,
 	case CL_TEST_FAILURE:
 		printf("not ok %d - %s::%s\n", test_number, suite_name, test_name);
 
-		printf("    ---\n");
-		printf("    reason: |\n");
-		printf("      %s\n", error->error_msg);
+		if (_clar.verbosity >= 0) {
+			printf("    ---\n");
+			printf("    reason: |\n");
+			clar_print_indented(error->error_msg, 6);
 
-		if (error->description)
-			printf("      %s\n", error->description);
+			if (error->description)
+				clar_print_indented(error->description, 6);
 
-		printf("    at:\n");
-		printf("      file: '"); print_escaped(error->file); printf("'\n");
-		printf("      line: %" PRIuMAX "\n", error->line_number);
-		printf("      function: '%s'\n", error->function);
-		printf("    ---\n");
+			printf("    at:\n");
+			printf("      file: '"); print_escaped(error->file); printf("'\n");
+			printf("      line: %" PRIuMAX "\n", error->line_number);
+			printf("      function: '%s'\n", error->function);
+			printf("    ---\n");
+		}
 
 		break;
 	case CL_TEST_SKIP:
@@ -152,6 +180,8 @@ static void clar_print_tap_ontest(const char *suite_name, const char *test_name,
 
 static void clar_print_tap_onsuite(const char *suite_name, int suite_index)
 {
+	if (_clar.verbosity < 0)
+		return;
 	printf("# start of suite %d: %s\n", suite_index, suite_name);
 }
 
diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sandbox.h
index bc960f50e0f..52add8aceba 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -2,7 +2,17 @@
 #include <sys/syslimits.h>
 #endif
 
-static char _clar_path[4096 + 1];
+/*
+ * The tempdir is the temporary directory for the entirety of the clar
+ * process execution. The sandbox is an individual temporary directory
+ * for the execution of an individual test. Sandboxes are deleted
+ * entirely after test execution to avoid pollution across tests.
+ */
+
+static char _clar_tempdir[CLAR_MAX_PATH];
+static size_t _clar_tempdir_len;
+
+static char _clar_sandbox[CLAR_MAX_PATH];
 
 static int
 is_valid_tmp_path(const char *path)
@@ -15,7 +25,10 @@ is_valid_tmp_path(const char *path)
 	if (!S_ISDIR(st.st_mode))
 		return 0;
 
-	return (access(path, W_OK) == 0);
+	if (access(path, W_OK) != 0)
+		return 0;
+
+	return (strlen(path) < CLAR_MAX_PATH);
 }
 
 static int
@@ -31,14 +44,11 @@ find_tmp_path(char *buffer, size_t length)
 
 	for (i = 0; i < var_count; ++i) {
 		const char *env = getenv(env_vars[i]);
+
 		if (!env)
 			continue;
 
 		if (is_valid_tmp_path(env)) {
-#ifdef __APPLE__
-			if (length >= PATH_MAX && realpath(env, buffer) != NULL)
-				return 0;
-#endif
 			strncpy(buffer, env, length - 1);
 			buffer[length - 1] = '\0';
 			return 0;
@@ -47,21 +57,18 @@ find_tmp_path(char *buffer, size_t length)
 
 	/* If the environment doesn't say anything, try to use /tmp */
 	if (is_valid_tmp_path("/tmp")) {
-#ifdef __APPLE__
-		if (length >= PATH_MAX && realpath("/tmp", buffer) != NULL)
-			return 0;
-#endif
 		strncpy(buffer, "/tmp", length - 1);
 		buffer[length - 1] = '\0';
 		return 0;
 	}
 
 #else
-	DWORD env_len = GetEnvironmentVariable("CLAR_TMP", buffer, (DWORD)length);
-	if (env_len > 0 && env_len < (DWORD)length)
+	DWORD len = GetEnvironmentVariable("CLAR_TMP", buffer, (DWORD)length);
+	if (len > 0 && len < (DWORD)length)
 		return 0;
 
-	if (GetTempPath((DWORD)length, buffer))
+	len = GetTempPath((DWORD)length, buffer);
+	if (len > 0 && len < (DWORD)length)
 		return 0;
 #endif
 
@@ -75,17 +82,53 @@ find_tmp_path(char *buffer, size_t length)
 	return -1;
 }
 
-static void clar_unsandbox(void)
+static int canonicalize_tmp_path(char *buffer)
+{
+#ifdef _WIN32
+	char tmp[CLAR_MAX_PATH], *p;
+	DWORD ret;
+
+	ret = GetFullPathName(buffer, CLAR_MAX_PATH, tmp, NULL);
+
+	if (ret == 0 || ret > CLAR_MAX_PATH)
+		return -1;
+
+	ret = GetLongPathName(tmp, buffer, CLAR_MAX_PATH);
+
+	if (ret == 0 || ret > CLAR_MAX_PATH)
+		return -1;
+
+	/* normalize path to POSIX forward slashes */
+	for (p = buffer; *p; p++)
+		if (*p == '\\')
+			*p = '/';
+
+	return 0;
+#elif defined(CLAR_HAS_REALPATH)
+	char tmp[CLAR_MAX_PATH];
+
+	if (realpath(buffer, tmp) == NULL)
+		return -1;
+
+	strcpy(buffer, tmp);
+	return 0;
+#else
+	(void)buffer;
+	return 0;
+#endif
+}
+
+static void clar_tempdir_shutdown(void)
 {
-	if (_clar_path[0] == '\0')
+	if (_clar_tempdir[0] == '\0')
 		return;
 
 	cl_must_pass(chdir(".."));
 
-	fs_rm(_clar_path);
+	fs_rm(_clar_tempdir);
 }
 
-static int build_sandbox_path(void)
+static int build_tempdir_path(void)
 {
 #ifdef CLAR_TMPDIR
 	const char path_tail[] = CLAR_TMPDIR "_XXXXXX";
@@ -95,64 +138,153 @@ static int build_sandbox_path(void)
 
 	size_t len;
 
-	if (find_tmp_path(_clar_path, sizeof(_clar_path)) < 0)
+	if (find_tmp_path(_clar_tempdir, sizeof(_clar_tempdir)) < 0 ||
+	    canonicalize_tmp_path(_clar_tempdir) < 0)
 		return -1;
 
-	len = strlen(_clar_path);
+	len = strlen(_clar_tempdir);
 
-#ifdef _WIN32
-	{ /* normalize path to POSIX forward slashes */
-		size_t i;
-		for (i = 0; i < len; ++i) {
-			if (_clar_path[i] == '\\')
-				_clar_path[i] = '/';
-		}
-	}
-#endif
+	if (len + strlen(path_tail) + 2 > CLAR_MAX_PATH)
+		return -1;
 
-	if (_clar_path[len - 1] != '/') {
-		_clar_path[len++] = '/';
-	}
+	if (_clar_tempdir[len - 1] != '/')
+		_clar_tempdir[len++] = '/';
 
-	strncpy(_clar_path + len, path_tail, sizeof(_clar_path) - len);
+	strncpy(_clar_tempdir + len, path_tail, sizeof(_clar_tempdir) - len);
 
 #if defined(__MINGW32__)
-	if (_mktemp(_clar_path) == NULL)
+	if (_mktemp(_clar_tempdir) == NULL)
 		return -1;
 
-	if (mkdir(_clar_path, 0700) != 0)
+	if (mkdir(_clar_tempdir, 0700) != 0)
 		return -1;
 #elif defined(_WIN32)
-	if (_mktemp_s(_clar_path, sizeof(_clar_path)) != 0)
+	if (_mktemp_s(_clar_tempdir, sizeof(_clar_tempdir)) != 0)
 		return -1;
 
-	if (mkdir(_clar_path, 0700) != 0)
+	if (mkdir(_clar_tempdir, 0700) != 0)
 		return -1;
-#elif defined(__sun) || defined(__TANDEM)
-	if (mktemp(_clar_path) == NULL)
+#elif defined(__sun) || defined(__TANDEM) || defined(__hpux)
+	if (mktemp(_clar_tempdir) == NULL)
 		return -1;
 
-	if (mkdir(_clar_path, 0700) != 0)
+	if (mkdir(_clar_tempdir, 0700) != 0)
 		return -1;
 #else
-	if (mkdtemp(_clar_path) == NULL)
+	if (mkdtemp(_clar_tempdir) == NULL)
 		return -1;
 #endif
 
+	_clar_tempdir_len = strlen(_clar_tempdir);
 	return 0;
 }
 
-static void clar_sandbox(void)
+static void clar_tempdir_init(void)
 {
-	if (_clar_path[0] == '\0' && build_sandbox_path() < 0)
-		clar_abort("Failed to build sandbox path.\n");
+	if (_clar_tempdir[0] == '\0' && build_tempdir_path() < 0)
+		clar_abort("Failed to build tempdir path.\n");
 
-	if (chdir(_clar_path) != 0)
-		clar_abort("Failed to change into sandbox directory '%s': %s.\n",
-			   _clar_path, strerror(errno));
+	if (chdir(_clar_tempdir) != 0)
+		clar_abort("Failed to change into tempdir '%s': %s.\n",
+			   _clar_tempdir, strerror(errno));
+
+#if !defined(CLAR_SANDBOX_TEST_NAMES) && defined(_WIN32)
+	srand(clock() ^ (unsigned int)time(NULL) ^ GetCurrentProcessId() ^ GetCurrentThreadId());
+#elif !defined(CLAR_SANDBOX_TEST_NAMES)
+	srand(clock() ^ time(NULL) ^ ((unsigned)getpid() << 16));
+#endif
+}
+
+static void append(char *dst, const char *src)
+{
+	char *d;
+	const char *s;
+
+	for (d = dst; *d; d++)
+		;
+
+	for (s = src; *s; d++, s++)
+		if (*s == ':')
+			*d = '_';
+		else
+			*d = *s;
+
+	*d = '\0';
+}
+
+static int clar_sandbox_create(const char *suite_name, const char *test_name)
+{
+#ifndef CLAR_SANDBOX_TEST_NAMES
+	char alpha[] = "0123456789abcdef";
+	int num = rand();
+#endif
+
+	cl_assert(_clar_sandbox[0] == '\0');
+
+	/*
+	 * We may want to use test names as sandbox directory names for
+	 * readability, _however_ on platforms with restrictions for short
+	 * file / folder names (eg, Windows), this may be too long.
+	 */
+#ifdef CLAR_SANDBOX_TEST_NAMES
+	cl_assert(strlen(_clar_tempdir) + strlen(suite_name) + strlen(test_name) + 3 < CLAR_MAX_PATH);
+
+	strcpy(_clar_sandbox, _clar_tempdir);
+	_clar_sandbox[_clar_tempdir_len] = '/';
+	_clar_sandbox[_clar_tempdir_len + 1] = '\0';
+
+	append(_clar_sandbox, suite_name);
+	append(_clar_sandbox, "__");
+	append(_clar_sandbox, test_name);
+#else
+	((void)suite_name);
+	((void)test_name);
+	((void)append);
+
+	cl_assert(strlen(_clar_tempdir) + 9 < CLAR_MAX_PATH);
+
+	strcpy(_clar_sandbox, _clar_tempdir);
+	_clar_sandbox[_clar_tempdir_len] = '/';
+
+	_clar_sandbox[_clar_tempdir_len + 1] = alpha[(num & 0xf0000000) >> 28];
+	_clar_sandbox[_clar_tempdir_len + 2] = alpha[(num & 0x0f000000) >> 24];
+	_clar_sandbox[_clar_tempdir_len + 3] = alpha[(num & 0x00f00000) >> 20];
+	_clar_sandbox[_clar_tempdir_len + 4] = alpha[(num & 0x000f0000) >> 16];
+	_clar_sandbox[_clar_tempdir_len + 5] = alpha[(num & 0x0000f000) >> 12];
+	_clar_sandbox[_clar_tempdir_len + 6] = alpha[(num & 0x00000f00) >> 8];
+	_clar_sandbox[_clar_tempdir_len + 7] = alpha[(num & 0x000000f0) >> 4];
+	_clar_sandbox[_clar_tempdir_len + 8] = alpha[(num & 0x0000000f) >> 0];
+	_clar_sandbox[_clar_tempdir_len + 9] = '\0';
+#endif
+
+	if (mkdir(_clar_sandbox, 0700) != 0)
+		return -1;
+
+	if (chdir(_clar_sandbox) != 0)
+		return -1;
+
+	return 0;
+}
+
+static int clar_sandbox_cleanup(void)
+{
+	cl_assert(_clar_sandbox[0] != '\0');
+
+	if (chdir(_clar_tempdir) != 0)
+		return -1;
+
+	fs_rm(_clar_sandbox);
+	_clar_sandbox[0] = '\0';
+
+	return 0;
+}
+
+const char *clar_tempdir_path(void)
+{
+	return _clar_tempdir;
 }
 
 const char *clar_sandbox_path(void)
 {
-	return _clar_path;
+	return _clar_sandbox;
 }
diff --git a/t/unit-tests/clar/clar/summary.h b/t/unit-tests/clar/clar/summary.h
index 0d0b646fe75..7b85f162d8e 100644
--- a/t/unit-tests/clar/clar/summary.h
+++ b/t/unit-tests/clar/clar/summary.h
@@ -23,10 +23,11 @@ static int clar_summary_testsuite(struct clar_summary *summary,
     int idn, const char *name, time_t timestamp,
     int test_count, int fail_count, int error_count)
 {
-	struct tm *tm = localtime(&timestamp);
+	struct tm tm;
 	char iso_dt[20];
 
-	if (strftime(iso_dt, sizeof(iso_dt), "%Y-%m-%dT%H:%M:%S", tm) == 0)
+	localtime_r(&timestamp, &tm);
+	if (strftime(iso_dt, sizeof(iso_dt), "%Y-%m-%dT%H:%M:%S", &tm) == 0)
 		return -1;
 
 	return fprintf(summary->fp, "\t<testsuite"
diff --git a/t/unit-tests/clar/example/CMakeLists.txt b/t/unit-tests/clar/example/CMakeLists.txt
new file mode 100644
index 00000000000..b72f1875236
--- /dev/null
+++ b/t/unit-tests/clar/example/CMakeLists.txt
@@ -0,0 +1,28 @@
+find_package(Python COMPONENTS Interpreter REQUIRED)
+
+add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
+	COMMAND "${Python_EXECUTABLE}" "${CMAKE_SOURCE_DIR}/generate.py" --output "${CMAKE_CURRENT_BINARY_DIR}"
+	DEPENDS main.c example.c
+	WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
+)
+
+add_executable(example)
+set_target_properties(example PROPERTIES
+	C_STANDARD 90
+	C_STANDARD_REQUIRED ON
+	C_EXTENSIONS OFF
+)
+target_sources(example PRIVATE
+	main.c
+	example.c
+	"${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
+)
+target_compile_definitions(example PRIVATE)
+target_compile_options(example PRIVATE
+	$<IF:$<CXX_COMPILER_ID:MSVC>,/W4,-Wall>
+)
+target_include_directories(example PRIVATE
+	"${CMAKE_SOURCE_DIR}"
+	"${CMAKE_CURRENT_BINARY_DIR}"
+)
+target_link_libraries(example clar)
diff --git a/t/unit-tests/clar/example/example.c b/t/unit-tests/clar/example/example.c
new file mode 100644
index 00000000000..c07d6bf68e8
--- /dev/null
+++ b/t/unit-tests/clar/example/example.c
@@ -0,0 +1,6 @@
+#include "clar.h"
+
+void test_example__simple_assert(void)
+{
+	cl_assert_equal_i(1, 1);
+}
diff --git a/t/unit-tests/clar/test/main.c.sample b/t/unit-tests/clar/example/main.c
similarity index 96%
rename from t/unit-tests/clar/test/main.c.sample
rename to t/unit-tests/clar/example/main.c
index a4d91b72fa8..f8def7fa6ed 100644
--- a/t/unit-tests/clar/test/main.c.sample
+++ b/t/unit-tests/clar/example/main.c
@@ -5,7 +5,7 @@
  * For full terms see the included COPYING file.
  */
 
-#include "clar_test.h"
+#include "clar.h"
 
 /*
  * Minimal main() for clar tests.
diff --git a/t/unit-tests/clar/test/CMakeLists.txt b/t/unit-tests/clar/test/CMakeLists.txt
index 7f2c1dc17a9..96abd6ed931 100644
--- a/t/unit-tests/clar/test/CMakeLists.txt
+++ b/t/unit-tests/clar/test/CMakeLists.txt
@@ -1,13 +1,15 @@
+add_subdirectory(selftest_suite)
+
 find_package(Python COMPONENTS Interpreter REQUIRED)
 
 add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
 	COMMAND "${Python_EXECUTABLE}" "${CMAKE_SOURCE_DIR}/generate.py" --output "${CMAKE_CURRENT_BINARY_DIR}"
-	DEPENDS main.c sample.c clar_test.h
+	DEPENDS main.c selftest.c
 	WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
 )
 
-add_executable(clar_test)
-set_target_properties(clar_test PROPERTIES
+add_executable(selftest)
+set_target_properties(selftest PROPERTIES
 	C_STANDARD 90
 	C_STANDARD_REQUIRED ON
 	C_EXTENSIONS OFF
@@ -15,25 +17,38 @@ set_target_properties(clar_test PROPERTIES
 
 # MSVC generates all kinds of warnings. We may want to fix these in the future
 # and then unconditionally treat warnings as errors.
-if(NOT MSVC)
-	set_target_properties(clar_test PROPERTIES
+if (NOT MSVC)
+	set_target_properties(selftest PROPERTIES
 		COMPILE_WARNING_AS_ERROR ON
 	)
 endif()
 
-target_sources(clar_test PRIVATE
+target_sources(selftest PRIVATE
 	main.c
-	sample.c
+	selftest.c
 	"${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
 )
-target_compile_definitions(clar_test PRIVATE
-	CLAR_FIXTURE_PATH="${CMAKE_CURRENT_SOURCE_DIR}/resources/"
+target_compile_definitions(selftest PRIVATE
+	CLAR_FIXTURE_PATH="${CMAKE_CURRENT_SOURCE_DIR}/expected/"
 )
-target_compile_options(clar_test PRIVATE
+target_compile_options(selftest PRIVATE
 	$<IF:$<CXX_COMPILER_ID:MSVC>,/W4,-Wall>
 )
-target_include_directories(clar_test PRIVATE
+target_include_directories(selftest PRIVATE
 	"${CMAKE_SOURCE_DIR}"
 	"${CMAKE_CURRENT_BINARY_DIR}"
 )
-target_link_libraries(clar_test clar)
+target_link_libraries(selftest clar)
+
+add_test(NAME build_selftest_suite
+	COMMAND "${CMAKE_COMMAND}" --build "${CMAKE_BINARY_DIR}" --config "$<CONFIG>" --target selftest_suite
+)
+set_tests_properties(build_selftest_suite PROPERTIES FIXTURES_SETUP clar_test_fixture)
+
+add_test(NAME build_selftest
+	COMMAND "${CMAKE_COMMAND}" --build "${CMAKE_BINARY_DIR}" --config "$<CONFIG>" --target selftest
+)
+set_tests_properties(build_selftest PROPERTIES FIXTURES_SETUP clar_test_fixture)
+
+add_test(NAME selftest COMMAND "${CMAKE_CURRENT_BINARY_DIR}/selftest" "$<TARGET_FILE:selftest_suite>")
+set_tests_properties(selftest PROPERTIES FIXTURES_REQUIRED clar_test_fixture)
diff --git a/t/unit-tests/clar/test/clar_test.h b/t/unit-tests/clar/test/clar_test.h
deleted file mode 100644
index 0fcaa639aa8..00000000000
--- a/t/unit-tests/clar/test/clar_test.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Copyright (c) Vicent Marti. All rights reserved.
- *
- * This file is part of clar, distributed under the ISC license.
- * For full terms see the included COPYING file.
- */
-#ifndef __CLAR_TEST__
-#define __CLAR_TEST__
-
-/* Import the standard clar helper functions */
-#include "clar.h"
-
-/* Your custom shared includes / defines here */
-extern int global_test_counter;
-
-#endif
diff --git a/t/unit-tests/clar/test/expected/help b/t/unit-tests/clar/test/expected/help
new file mode 100644
index 00000000000..4b2be69f973
--- /dev/null
+++ b/t/unit-tests/clar/test/expected/help
@@ -0,0 +1,12 @@
+Usage: selftest [options]
+
+Options:
+  -sname        Run only the suite with `name` (can go to individual test name)
+  -iname        Include the suite with `name`
+  -xname        Exclude the suite with `name`
+  -v            Increase verbosity (show suite names)
+  -q            Decrease verbosity, inverse to -v
+  -Q            Quit as soon as a test fails
+  -t            Display results in tap format
+  -l            Print suite names
+  -r[filename]  Write summary file (to the optional filename)
diff --git a/t/unit-tests/clar/test/expected/quiet b/t/unit-tests/clar/test/expected/quiet
new file mode 100644
index 00000000000..975164147ff
--- /dev/null
+++ b/t/unit-tests/clar/test/expected/quiet
@@ -0,0 +1,49 @@
+  1) Failure:
+selftest::suite::1 [file:42]
+  Function call failed: -1
+
+  2) Failure:
+selftest::suite::2 [file:42]
+  Expression is not true: 100 == 101
+
+  3) Failure:
+selftest::suite::strings [file:42]
+  String mismatch: "mismatched" != actual ("this one fails")
+  'mismatched' != 'expected' (at byte 0)
+
+  4) Failure:
+selftest::suite::strings_with_length [file:42]
+  String mismatch: "exactly" != actual ("this one fails")
+  'exa' != 'exp' (at byte 2)
+
+  5) Failure:
+selftest::suite::int [file:42]
+  101 != value ("extra note on failing test")
+  101 != 100
+
+  6) Failure:
+selftest::suite::int_fmt [file:42]
+  022 != value
+  0022 != 0144
+
+  7) Failure:
+selftest::suite::bool [file:42]
+  0 != value
+  0 != 1
+
+  8) Failure:
+selftest::suite::ptr [file:42]
+  Pointer mismatch: p1 != p2
+  0x1 != 0x2
+
+  9) Failure:
+selftest::suite::multiline_description [file:42]
+  Function call failed: -1
+  description line 1
+  description line 2
+
+  10) Failure:
+selftest::suite::null_string [file:42]
+  String mismatch: "expected" != actual ("this one fails")
+  'expected' != NULL
+
diff --git a/t/unit-tests/clar/test/expected/specific_test b/t/unit-tests/clar/test/expected/specific_test
new file mode 100644
index 00000000000..afa21509804
--- /dev/null
+++ b/t/unit-tests/clar/test/expected/specific_test
@@ -0,0 +1,9 @@
+Loaded 1 suites: 
+Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
+F
+
+  1) Failure:
+selftest::suite::bool [file:42]
+  0 != value
+  0 != 1
+
diff --git a/t/unit-tests/clar/test/expected/stop_on_failure b/t/unit-tests/clar/test/expected/stop_on_failure
new file mode 100644
index 00000000000..1156ade0f92
--- /dev/null
+++ b/t/unit-tests/clar/test/expected/stop_on_failure
@@ -0,0 +1,8 @@
+Loaded 1 suites: 
+Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
+F
+
+  1) Failure:
+selftest::suite::1 [file:42]
+  Function call failed: -1
+
diff --git a/t/unit-tests/clar/test/expected/suite_names b/t/unit-tests/clar/test/expected/suite_names
new file mode 100644
index 00000000000..1b0f6397eb3
--- /dev/null
+++ b/t/unit-tests/clar/test/expected/suite_names
@@ -0,0 +1,2 @@
+Test suites (use -s<name> to run just one):
+   0: selftest::suite
diff --git a/t/unit-tests/clar/test/expected/summary.xml b/t/unit-tests/clar/test/expected/summary.xml
new file mode 100644
index 00000000000..9034a03d1fa
--- /dev/null
+++ b/t/unit-tests/clar/test/expected/summary.xml
@@ -0,0 +1,45 @@
+<testsuites>
+	<testsuite id="0" name="selftest" hostname="localhost" timestamp="2024-09-06T10:04:08" tests="8" failures="8" errors="0">
+		<testcase name="1" classname="selftest" time="0.00">
+			<failure type="assert"><![CDATA[Function call failed: -1
+(null)]]></failure>
+		</testcase>
+		<testcase name="2" classname="selftest" time="0.00">
+			<failure type="assert"><![CDATA[Expression is not true: 100 == 101
+(null)]]></failure>
+		</testcase>
+		<testcase name="strings" classname="selftest" time="0.00">
+			<failure type="assert"><![CDATA[String mismatch: "mismatched" != actual ("this one fails")
+'mismatched' != 'expected' (at byte 0)]]></failure>
+		</testcase>
+		<testcase name="strings_with_length" classname="selftest" time="0.00">
+			<failure type="assert"><![CDATA[String mismatch: "exactly" != actual ("this one fails")
+'exa' != 'exp' (at byte 2)]]></failure>
+		</testcase>
+		<testcase name="int" classname="selftest" time="0.00">
+			<failure type="assert"><![CDATA[101 != value ("extra note on failing test")
+101 != 100]]></failure>
+		</testcase>
+		<testcase name="int_fmt" classname="selftest" time="0.00">
+			<failure type="assert"><![CDATA[022 != value
+0022 != 0144]]></failure>
+		</testcase>
+		<testcase name="bool" classname="selftest" time="0.00">
+			<failure type="assert"><![CDATA[0 != value
+0 != 1]]></failure>
+		</testcase>
+		<testcase name="ptr" classname="selftest" time="0.00">
+			<failure type="assert"><![CDATA[Pointer mismatch: p1 != p2
+0x1 != 0x2]]></failure>
+		</testcase>
+		<testcase name="multiline_description" classname="selftest" time="0.00">
+			<failure type="assert"><![CDATA[Function call failed: −1
+description line 1
+description line 2]]></failure>
+		</testcase>
+		<testcase name="null_string" classname="selftest" time="0.00">
+			<failure type="assert"><![CDATA[String mismatch: "expected" != actual ("this one fails")
+'expected' != NULL]]></failure>
+		</testcase>
+	</testsuite>
+</testsuites>
diff --git a/t/unit-tests/clar/test/expected/summary_with_filename b/t/unit-tests/clar/test/expected/summary_with_filename
new file mode 100644
index 00000000000..a5f4d405370
--- /dev/null
+++ b/t/unit-tests/clar/test/expected/summary_with_filename
@@ -0,0 +1,54 @@
+Loaded 1 suites: 
+Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
+FFFFFFFFFF
+
+  1) Failure:
+selftest::suite::1 [file:42]
+  Function call failed: -1
+
+  2) Failure:
+selftest::suite::2 [file:42]
+  Expression is not true: 100 == 101
+
+  3) Failure:
+selftest::suite::strings [file:42]
+  String mismatch: "mismatched" != actual ("this one fails")
+  'mismatched' != 'expected' (at byte 0)
+
+  4) Failure:
+selftest::suite::strings_with_length [file:42]
+  String mismatch: "exactly" != actual ("this one fails")
+  'exa' != 'exp' (at byte 2)
+
+  5) Failure:
+selftest::suite::int [file:42]
+  101 != value ("extra note on failing test")
+  101 != 100
+
+  6) Failure:
+selftest::suite::int_fmt [file:42]
+  022 != value
+  0022 != 0144
+
+  7) Failure:
+selftest::suite::bool [file:42]
+  0 != value
+  0 != 1
+
+  8) Failure:
+selftest::suite::ptr [file:42]
+  Pointer mismatch: p1 != p2
+  0x1 != 0x2
+
+  9) Failure:
+selftest::suite::multiline_description [file:42]
+  Function call failed: -1
+  description line 1
+  description line 2
+
+  10) Failure:
+selftest::suite::null_string [file:42]
+  String mismatch: "expected" != actual ("this one fails")
+  'expected' != NULL
+
+written summary file to different.xml
diff --git a/t/unit-tests/clar/test/expected/summary_without_filename b/t/unit-tests/clar/test/expected/summary_without_filename
new file mode 100644
index 00000000000..5984502773e
--- /dev/null
+++ b/t/unit-tests/clar/test/expected/summary_without_filename
@@ -0,0 +1,54 @@
+Loaded 1 suites: 
+Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
+FFFFFFFFFF
+
+  1) Failure:
+selftest::suite::1 [file:42]
+  Function call failed: -1
+
+  2) Failure:
+selftest::suite::2 [file:42]
+  Expression is not true: 100 == 101
+
+  3) Failure:
+selftest::suite::strings [file:42]
+  String mismatch: "mismatched" != actual ("this one fails")
+  'mismatched' != 'expected' (at byte 0)
+
+  4) Failure:
+selftest::suite::strings_with_length [file:42]
+  String mismatch: "exactly" != actual ("this one fails")
+  'exa' != 'exp' (at byte 2)
+
+  5) Failure:
+selftest::suite::int [file:42]
+  101 != value ("extra note on failing test")
+  101 != 100
+
+  6) Failure:
+selftest::suite::int_fmt [file:42]
+  022 != value
+  0022 != 0144
+
+  7) Failure:
+selftest::suite::bool [file:42]
+  0 != value
+  0 != 1
+
+  8) Failure:
+selftest::suite::ptr [file:42]
+  Pointer mismatch: p1 != p2
+  0x1 != 0x2
+
+  9) Failure:
+selftest::suite::multiline_description [file:42]
+  Function call failed: -1
+  description line 1
+  description line 2
+
+  10) Failure:
+selftest::suite::null_string [file:42]
+  String mismatch: "expected" != actual ("this one fails")
+  'expected' != NULL
+
+written summary file to summary.xml
diff --git a/t/unit-tests/clar/test/expected/tap b/t/unit-tests/clar/test/expected/tap
new file mode 100644
index 00000000000..3dc4973dfa1
--- /dev/null
+++ b/t/unit-tests/clar/test/expected/tap
@@ -0,0 +1,102 @@
+TAP version 13
+# start of suite 1: selftest::suite
+not ok 1 - selftest::suite::1
+    ---
+    reason: |
+      Function call failed: -1
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ---
+not ok 2 - selftest::suite::2
+    ---
+    reason: |
+      Expression is not true: 100 == 101
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ---
+not ok 3 - selftest::suite::strings
+    ---
+    reason: |
+      String mismatch: "mismatched" != actual ("this one fails")
+      'mismatched' != 'expected' (at byte 0)
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ---
+not ok 4 - selftest::suite::strings_with_length
+    ---
+    reason: |
+      String mismatch: "exactly" != actual ("this one fails")
+      'exa' != 'exp' (at byte 2)
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ---
+not ok 5 - selftest::suite::int
+    ---
+    reason: |
+      101 != value ("extra note on failing test")
+      101 != 100
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ---
+not ok 6 - selftest::suite::int_fmt
+    ---
+    reason: |
+      022 != value
+      0022 != 0144
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ---
+not ok 7 - selftest::suite::bool
+    ---
+    reason: |
+      0 != value
+      0 != 1
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ---
+not ok 8 - selftest::suite::ptr
+    ---
+    reason: |
+      Pointer mismatch: p1 != p2
+      0x1 != 0x2
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ---
+not ok 9 - selftest::suite::multiline_description
+    ---
+    reason: |
+      Function call failed: -1
+      description line 1
+      description line 2
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ---
+not ok 10 - selftest::suite::null_string
+    ---
+    reason: |
+      String mismatch: "expected" != actual ("this one fails")
+      'expected' != NULL
+    at:
+      file: 'file'
+      line: 42
+      function: 'func'
+    ---
+1..10
diff --git a/t/unit-tests/clar/test/expected/without_arguments b/t/unit-tests/clar/test/expected/without_arguments
new file mode 100644
index 00000000000..08b67b874cb
--- /dev/null
+++ b/t/unit-tests/clar/test/expected/without_arguments
@@ -0,0 +1,53 @@
+Loaded 1 suites: 
+Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
+FFFFFFFFFF
+
+  1) Failure:
+selftest::suite::1 [file:42]
+  Function call failed: -1
+
+  2) Failure:
+selftest::suite::2 [file:42]
+  Expression is not true: 100 == 101
+
+  3) Failure:
+selftest::suite::strings [file:42]
+  String mismatch: "mismatched" != actual ("this one fails")
+  'mismatched' != 'expected' (at byte 0)
+
+  4) Failure:
+selftest::suite::strings_with_length [file:42]
+  String mismatch: "exactly" != actual ("this one fails")
+  'exa' != 'exp' (at byte 2)
+
+  5) Failure:
+selftest::suite::int [file:42]
+  101 != value ("extra note on failing test")
+  101 != 100
+
+  6) Failure:
+selftest::suite::int_fmt [file:42]
+  022 != value
+  0022 != 0144
+
+  7) Failure:
+selftest::suite::bool [file:42]
+  0 != value
+  0 != 1
+
+  8) Failure:
+selftest::suite::ptr [file:42]
+  Pointer mismatch: p1 != p2
+  0x1 != 0x2
+
+  9) Failure:
+selftest::suite::multiline_description [file:42]
+  Function call failed: -1
+  description line 1
+  description line 2
+
+  10) Failure:
+selftest::suite::null_string [file:42]
+  String mismatch: "expected" != actual ("this one fails")
+  'expected' != NULL
+
diff --git a/t/unit-tests/clar/test/main.c b/t/unit-tests/clar/test/main.c
index 59e56ad255b..b1ba2996f13 100644
--- a/t/unit-tests/clar/test/main.c
+++ b/t/unit-tests/clar/test/main.c
@@ -1,23 +1,9 @@
-/*
- * Copyright (c) Vicent Marti. All rights reserved.
- *
- * This file is part of clar, distributed under the ISC license.
- * For full terms see the included COPYING file.
- */
+#include <stdio.h>
+#include <string.h>
 
-#include "clar_test.h"
+#include "selftest.h"
 
-/*
- * Sample main() for clar tests.
- *
- * You should write your own main routine for clar tests that does specific
- * setup and teardown as necessary for your application.  The only required
- * line is the call to `clar_test(argc, argv)`, which will execute the test
- * suite.  If you want to check the return value of the test application,
- * your main() should return the same value returned by clar_test().
- */
-
-int global_test_counter = 0;
+const char *selftest_binary_path;
 
 #ifdef _WIN32
 int __cdecl main(int argc, char *argv[])
@@ -25,16 +11,15 @@ int __cdecl main(int argc, char *argv[])
 int main(int argc, char *argv[])
 #endif
 {
-	int ret;
-
-	/* Your custom initialization here */
-	global_test_counter = 0;
-
-	/* Run the test suite */
-	ret = clar_test(argc, argv);
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s <selftest-suite-executable> <options>\n",
+			argv[0]);
+		exit(1);
+	}
 
-	/* Your custom cleanup here */
-	cl_assert_equal_i(8, global_test_counter);
+	selftest_binary_path = argv[1];
+	memmove(argv + 1, argv + 2, argc - 1);
+	argc -= 1;
 
-	return ret;
+	return clar_test(argc, argv);
 }
diff --git a/t/unit-tests/clar/test/selftest.c b/t/unit-tests/clar/test/selftest.c
new file mode 100644
index 00000000000..abd585f4e4a
--- /dev/null
+++ b/t/unit-tests/clar/test/selftest.c
@@ -0,0 +1,289 @@
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+
+#include "selftest.h"
+
+#ifdef _WIN32
+# define WIN32_LEAN_AND_MEAN
+# include <windows.h>
+
+static char *read_full(HANDLE h, int is_pipe)
+{
+	char *data = NULL;
+	size_t data_size = 0;
+
+	while (1) {
+		CHAR buf[4096];
+		DWORD bytes_read;
+
+		if (!ReadFile(h, buf, sizeof(buf), &bytes_read, NULL)) {
+			if (!is_pipe)
+				cl_fail("Failed reading file handle.");
+			cl_assert_equal_i(GetLastError(), ERROR_BROKEN_PIPE);
+			break;
+		}
+		if (!bytes_read)
+			break;
+
+		data = realloc(data, data_size + bytes_read);
+		cl_assert(data);
+		memcpy(data + data_size, buf, bytes_read);
+		data_size += bytes_read;
+	}
+
+	data = realloc(data, data_size + 1);
+	cl_assert(data);
+	data[data_size] = '\0';
+
+	while (strstr(data, "\r\n")) {
+		char *ptr = strstr(data, "\r\n");
+		memmove(ptr, ptr + 1, strlen(ptr));
+	}
+
+	return data;
+}
+
+static char *read_file(const char *path)
+{
+	char *content;
+	HANDLE file;
+
+	file = CreateFile(path, GENERIC_READ, FILE_SHARE_READ, NULL,
+			  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
+	cl_assert(file != INVALID_HANDLE_VALUE);
+	content = read_full(file, 0);
+	cl_assert_equal_b(1, CloseHandle(file));
+
+	return content;
+}
+
+static void run(const char *expected_output_file, int expected_error_code, ...)
+{
+	SECURITY_ATTRIBUTES security_attributes = { 0 };
+	PROCESS_INFORMATION process_info = { 0 };
+	STARTUPINFO startup_info = { 0 };
+	char cmdline[4096] = { 0 };
+	char *expected_output = NULL;
+	char *output = NULL;
+	HANDLE stdout_write;
+	HANDLE stdout_read;
+	DWORD exit_code;
+	va_list ap;
+
+	/*
+	 * Assemble command line arguments. In theory we'd have to properly
+	 * quote them. In practice none of our tests actually care.
+	 */
+	va_start(ap, expected_error_code);
+	snprintf(cmdline, sizeof(cmdline), "selftest");
+	while (1) {
+		size_t cmdline_len = strlen(cmdline);
+		const char *arg;
+
+		arg = va_arg(ap, const char *);
+		if (!arg)
+			break;
+
+		cl_assert(cmdline_len + strlen(arg) < sizeof(cmdline));
+		snprintf(cmdline + cmdline_len, sizeof(cmdline) - cmdline_len,
+			 " %s", arg);
+	}
+	va_end(ap);
+
+	/*
+	 * Create a pipe that we will use to read data from the child process.
+	 * The writing side needs to be inheritable such that the child can use
+	 * it as stdout and stderr. The reading side should only be used by the
+	 * parent.
+	 */
+	security_attributes.nLength = sizeof(security_attributes);
+	security_attributes.bInheritHandle = TRUE;
+	cl_assert_equal_b(1, CreatePipe(&stdout_read, &stdout_write, &security_attributes, 0));
+	cl_assert_equal_b(1, SetHandleInformation(stdout_read, HANDLE_FLAG_INHERIT, 0));
+
+	/*
+	 * Create the child process with our pipe.
+	 */
+	startup_info.cb = sizeof(startup_info);
+	startup_info.hStdError = stdout_write;
+	startup_info.hStdOutput = stdout_write;
+	startup_info.dwFlags |= STARTF_USESTDHANDLES;
+	cl_assert_equal_b(1, CreateProcess(selftest_binary_path, cmdline, NULL, NULL, TRUE,
+					   0, NULL, NULL, &startup_info, &process_info));
+	cl_assert_equal_b(1, CloseHandle(stdout_write));
+
+	output = read_full(stdout_read, 1);
+	cl_assert_equal_b(1, CloseHandle(stdout_read));
+	cl_assert_equal_b(1, GetExitCodeProcess(process_info.hProcess, &exit_code));
+
+	expected_output = read_file(cl_fixture(expected_output_file));
+	cl_assert_equal_s(output, expected_output);
+	cl_assert_equal_i(exit_code, expected_error_code);
+
+	free(expected_output);
+	free(output);
+}
+
+#else
+# include <errno.h>
+# include <fcntl.h>
+# include <limits.h>
+# include <unistd.h>
+# include <sys/wait.h>
+
+static char *read_full(int fd)
+{
+	size_t data_bytes = 0;
+	char *data = NULL;
+
+	while (1) {
+		char buf[4096];
+		ssize_t n;
+
+		n = read(fd, buf, sizeof(buf));
+		if (n < 0) {
+			if (errno == EAGAIN || errno == EINTR)
+				continue;
+			cl_fail("Failed reading from child process.");
+		}
+		if (!n)
+			break;
+
+		data = realloc(data, data_bytes + n);
+		cl_assert(data);
+
+		memcpy(data + data_bytes, buf, n);
+		data_bytes += n;
+	}
+
+	data = realloc(data, data_bytes + 1);
+	cl_assert(data);
+	data[data_bytes] = '\0';
+
+	return data;
+}
+
+static char *read_file(const char *path)
+{
+	char *data;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		cl_fail("Failed reading expected file.");
+
+	data = read_full(fd);
+	cl_must_pass(close(fd));
+
+	return data;
+}
+
+static void run(const char *expected_output_file, int expected_error_code, ...)
+{
+	const char *argv[16];
+	int pipe_fds[2];
+	va_list ap;
+	pid_t pid;
+	int i;
+
+	va_start(ap, expected_error_code);
+	argv[0] = "selftest";
+	for (i = 1; ; i++) {
+		cl_assert(i < sizeof(argv) / sizeof(*argv));
+
+		argv[i] = va_arg(ap, const char *);
+		if (!argv[i])
+			break;
+	}
+	va_end(ap);
+
+	cl_must_pass(pipe(pipe_fds));
+
+	pid = fork();
+	if (!pid) {
+		if (dup2(pipe_fds[1], STDOUT_FILENO) < 0 ||
+		    dup2(pipe_fds[1], STDERR_FILENO) < 0 ||
+		    close(0) < 0 ||
+		    close(pipe_fds[0]) < 0 ||
+		    close(pipe_fds[1]) < 0)
+			exit(1);
+
+		execv(selftest_binary_path, (char **) argv);
+		exit(1);
+	} else if (pid > 0) {
+		pid_t waited_pid;
+		char *expected_output, *output;
+		int stat;
+
+		cl_must_pass(close(pipe_fds[1]));
+
+		output = read_full(pipe_fds[0]);
+
+		waited_pid = waitpid(pid, &stat, 0);
+		cl_assert_equal_i(pid, waited_pid);
+		cl_assert(WIFEXITED(stat));
+		cl_assert_equal_i(WEXITSTATUS(stat), expected_error_code);
+
+		expected_output = read_file(cl_fixture(expected_output_file));
+		cl_assert_equal_s(output, expected_output);
+
+		free(expected_output);
+		free(output);
+	} else {
+		cl_fail("Fork failed.");
+	}
+}
+#endif
+
+void test_selftest__help(void)
+{
+	cl_invoke(run("help", 1, "-h", NULL));
+}
+
+void test_selftest__without_arguments(void)
+{
+	cl_invoke(run("without_arguments", 10, NULL));
+}
+
+void test_selftest__specific_test(void)
+{
+	cl_invoke(run("specific_test", 1, "-sselftest::suite::bool", NULL));
+}
+
+void test_selftest__stop_on_failure(void)
+{
+	cl_invoke(run("stop_on_failure", 1, "-Q", NULL));
+}
+
+void test_selftest__quiet(void)
+{
+	cl_invoke(run("quiet", 10, "-q", NULL));
+}
+
+void test_selftest__tap(void)
+{
+	cl_invoke(run("tap", 10, "-t", NULL));
+}
+
+void test_selftest__suite_names(void)
+{
+	cl_invoke(run("suite_names", 0, "-l", NULL));
+}
+
+void test_selftest__summary_without_filename(void)
+{
+	struct stat st;
+	cl_invoke(run("summary_without_filename", 10, "-r", NULL));
+	/* The summary contains timestamps, so we cannot verify its contents. */
+	cl_must_pass(stat("summary.xml", &st));
+}
+
+void test_selftest__summary_with_filename(void)
+{
+	struct stat st;
+	cl_invoke(run("summary_with_filename", 10, "-rdifferent.xml", NULL));
+	/* The summary contains timestamps, so we cannot verify its contents. */
+	cl_must_pass(stat("different.xml", &st));
+}
diff --git a/t/unit-tests/clar/test/selftest.h b/t/unit-tests/clar/test/selftest.h
new file mode 100644
index 00000000000..220a350c504
--- /dev/null
+++ b/t/unit-tests/clar/test/selftest.h
@@ -0,0 +1,3 @@
+#include "clar.h"
+
+extern const char *selftest_binary_path;
diff --git a/t/unit-tests/clar/test/selftest_suite/CMakeLists.txt b/t/unit-tests/clar/test/selftest_suite/CMakeLists.txt
new file mode 100644
index 00000000000..9597d6711a7
--- /dev/null
+++ b/t/unit-tests/clar/test/selftest_suite/CMakeLists.txt
@@ -0,0 +1,40 @@
+find_package(Python COMPONENTS Interpreter REQUIRED)
+
+add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
+	COMMAND "${Python_EXECUTABLE}" "${CMAKE_SOURCE_DIR}/generate.py" --output "${CMAKE_CURRENT_BINARY_DIR}"
+	DEPENDS main.c selftest_suite.c
+	WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
+)
+
+add_executable(selftest_suite)
+set_target_properties(selftest_suite PROPERTIES
+	C_STANDARD 90
+	C_STANDARD_REQUIRED ON
+	C_EXTENSIONS OFF
+)
+
+# MSVC generates all kinds of warnings. We may want to fix these in the future
+# and then unconditionally treat warnings as errors.
+if(NOT MSVC)
+	set_target_properties(selftest_suite PROPERTIES
+		COMPILE_WARNING_AS_ERROR ON
+	)
+endif()
+
+target_sources(selftest_suite PRIVATE
+	main.c
+	selftest_suite.c
+	"${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
+)
+target_compile_definitions(selftest_suite PRIVATE
+	CLAR_FIXTURE_PATH="${CMAKE_CURRENT_SOURCE_DIR}/resources/"
+	CLAR_SELFTEST
+)
+target_compile_options(selftest_suite PRIVATE
+	$<IF:$<CXX_COMPILER_ID:MSVC>,/W4,-Wall>
+)
+target_include_directories(selftest_suite PRIVATE
+	"${CMAKE_SOURCE_DIR}"
+	"${CMAKE_CURRENT_BINARY_DIR}"
+)
+target_link_libraries(selftest_suite clar)
diff --git a/t/unit-tests/clar/test/selftest_suite/main.c b/t/unit-tests/clar/test/selftest_suite/main.c
new file mode 100644
index 00000000000..3ab581d3903
--- /dev/null
+++ b/t/unit-tests/clar/test/selftest_suite/main.c
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) Vicent Marti. All rights reserved.
+ *
+ * This file is part of clar, distributed under the ISC license.
+ * For full terms see the included COPYING file.
+ */
+
+#include "clar.h"
+
+/*
+ * Selftest main() for clar tests.
+ *
+ * You should write your own main routine for clar tests that does specific
+ * setup and teardown as necessary for your application.  The only required
+ * line is the call to `clar_test(argc, argv)`, which will execute the test
+ * suite.  If you want to check the return value of the test application,
+ * your main() should return the same value returned by clar_test().
+ */
+
+#ifdef _WIN32
+int __cdecl main(int argc, char *argv[])
+#else
+int main(int argc, char *argv[])
+#endif
+{
+	return clar_test(argc, argv);
+}
diff --git a/t/unit-tests/clar/test/resources/test/file b/t/unit-tests/clar/test/selftest_suite/resources/test/file
similarity index 100%
rename from t/unit-tests/clar/test/resources/test/file
rename to t/unit-tests/clar/test/selftest_suite/resources/test/file
diff --git a/t/unit-tests/clar/test/sample.c b/t/unit-tests/clar/test/selftest_suite/selftest_suite.c
similarity index 62%
rename from t/unit-tests/clar/test/sample.c
rename to t/unit-tests/clar/test/selftest_suite/selftest_suite.c
index faa1209262f..77f872128c7 100644
--- a/t/unit-tests/clar/test/sample.c
+++ b/t/unit-tests/clar/test/selftest_suite/selftest_suite.c
@@ -1,6 +1,7 @@
-#include "clar_test.h"
 #include <sys/stat.h>
 
+#include "clar.h"
+
 static int file_size(const char *filename)
 {
 	struct stat st;
@@ -10,19 +11,14 @@ static int file_size(const char *filename)
 	return -1;
 }
 
-void test_sample__initialize(void)
-{
-	global_test_counter++;
-}
-
-void test_sample__cleanup(void)
+void test_selftest_suite__cleanup(void)
 {
 	cl_fixture_cleanup("test");
 
 	cl_assert(file_size("test/file") == -1);
 }
 
-void test_sample__1(void)
+void test_selftest_suite__1(void)
 {
 	cl_assert(1);
 	cl_must_pass(0);  /* 0 == success */
@@ -30,7 +26,7 @@ void test_sample__1(void)
 	cl_must_pass(-1); /* demonstrate a failing call */
 }
 
-void test_sample__2(void)
+void test_selftest_suite__2(void)
 {
 	cl_fixture_sandbox("test");
 
@@ -39,7 +35,7 @@ void test_sample__2(void)
 	cl_assert(100 == 101);
 }
 
-void test_sample__strings(void)
+void test_selftest_suite__strings(void)
 {
 	const char *actual = "expected";
 	cl_assert_equal_s("expected", actual);
@@ -47,7 +43,7 @@ void test_sample__strings(void)
 	cl_assert_equal_s_("mismatched", actual, "this one fails");
 }
 
-void test_sample__strings_with_length(void)
+void test_selftest_suite__strings_with_length(void)
 {
 	const char *actual = "expected";
 	cl_assert_equal_strn("expected_", actual, 8);
@@ -56,29 +52,41 @@ void test_sample__strings_with_length(void)
 	cl_assert_equal_strn_("exactly", actual, 3, "this one fails");
 }
 
-void test_sample__int(void)
+void test_selftest_suite__int(void)
 {
 	int value = 100;
 	cl_assert_equal_i(100, value);
 	cl_assert_equal_i_(101, value, "extra note on failing test");
 }
 
-void test_sample__int_fmt(void)
+void test_selftest_suite__int_fmt(void)
 {
 	int value = 100;
 	cl_assert_equal_i_fmt(022, value, "%04o");
 }
 
-void test_sample__bool(void)
+void test_selftest_suite__bool(void)
 {
 	int value = 100;
 	cl_assert_equal_b(1, value);       /* test equality as booleans */
 	cl_assert_equal_b(0, value);
 }
 
-void test_sample__ptr(void)
+void test_selftest_suite__ptr(void)
 {
-	const char *actual = "expected";
-	cl_assert_equal_p(actual, actual); /* pointers to same object */
-	cl_assert_equal_p(&actual, actual);
+	void *p1 = (void *)0x1, *p2 = (void *)0x2;
+	cl_assert_equal_p(p1, p1); /* pointers to same object */
+	cl_assert_equal_p(p1, p2);
+}
+
+void test_selftest_suite__multiline_description(void)
+{
+	cl_must_pass_(-1, "description line 1\ndescription line 2");
+}
+
+void test_selftest_suite__null_string(void)
+{
+	const char *actual = NULL;
+	cl_assert_equal_s(actual, actual);
+	cl_assert_equal_s_("expected", actual, "this one fails");
 }

---
base-commit: 4975ec3473b4bc61bc8a3df1ef29d0b7e7959e87
change-id: 20250909-b4-pks-clar-update-4d934e2a6390

