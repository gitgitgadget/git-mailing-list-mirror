Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0742283FE9
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546982; cv=none; b=W9f9I1Rcs7Lp2zqnCFwPp9U5lL0HkLYTggTVw66aE4F9PxFpAWdnUobT8sV41v7DDssTnVM26K3zHkWKaXihOPbJoeinDAp/PWh71KXDCcUDQQ7yg0uKiBH1BrJbCNkFUoKRduLEXcPS6Yw/QpqIEHXZ6GWCzCXKPqEFB2hpFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546982; c=relaxed/simple;
	bh=4Vt6S42FHj0UcX3w9WNlcQg7GMcYVNSr2lS4y39SDgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ou1to7zjiJE/NDTov+zpYJyRRSNfGt32JuWb5IjbPFBmmjPMlDrxb7qNFGyVBBYTD0RX+lERZsY64IaT+1CLKuLeyLRcbkOjnpVX4spgNkwCHo5JjJjx+C0Lhdx6XmUovBMbI/Fz/+K7KEmRRzQmIm3XJ4mRRv/ggBNhBCje7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sK6K1AcT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xi0hH2ux; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sK6K1AcT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xi0hH2ux"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC4537A01AD;
	Mon, 22 Sep 2025 09:16:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 22 Sep 2025 09:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1758546978; x=1758633378; bh=haMF65z7s2
	PB+XKTrmUUUb63QAW8XwRYqnCP3WgcwoE=; b=sK6K1AcT/zc0uUp32gZbpKCcF0
	9T+sfSIgR4tgaBJq/w3/XIaf0Cc3I7Y3iDAj+WgFqPO+20h55WSY0TF1SmjjIxxW
	8fWvG6HbnBy0wJAe4jU2dT28vpXd5joFeqCcKDzbHWSxspm0minKUsmLGFhdCwBV
	0lB7aAwBEGyxSFhhyLUW1wqdvw9glIZIKMet6Vpvym97t/5TxwIaG+rAO8GKrrCH
	iCykyqfx7LG8nPVifvrBOZoTwZF01c2mNRkRksduBMDVUehoihaJQdJD7NDl3pkP
	b0Rl/86cWdxum+ECGcGa1Q48MpQwY/3ycLop5PzMEKp+VHyFxEyP2cVNk1Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758546978; x=1758633378; bh=haMF65z7s2PB+XKTrmUUUb63QAW8
	XwRYqnCP3WgcwoE=; b=Xi0hH2uxn8CMj3sjpEkIIa5UP80d6sezUAClRnQTD9nL
	BLuTCO0byObq13zCafnxJEOiX8itsH4GroqQJebPgk2QGRgA/Hf854DvLe60vdHB
	VdG423ba8i22vV4gLf2NGfeTxCxxUFCjO8o8KrpJyDoxWbrVVnhKq804tiY/9IWl
	TLw7Smz+2XfLTE3l3kWhZXrjtXreo8MLukTzyD7Fy/tV3JIJOnm7SoMr5qAVGwO7
	EOWEYoykGuSLaZ7ha9LO7LyKcnq4TIUJNVnksFYErGNYItm7zZcawsrtHdG0kzBC
	Kj7+oxXoAVE/zqHWR5HL5zNEjs+23OvVOFMEUiWv8g==
X-ME-Sender: <xms:IkzRaPRuLb8fowEw8JugGCVOm2N76zOZVWcgZnlIj55rFjS_W1MRHw>
    <xme:IkzRaEB-dU220VAJEzQq3V3Wau140BGBUzMBwFe6G4Sh6RfMeFI4ZxzPp_Ooxoo5n
    DauEMqRVWeaUGEUdA>
X-ME-Received: <xmr:IkzRaOTEPlbKEQLacTJmWub0axcsWx8fFaH4hQbnOTcsq1tSGhZJRKrgDUkX51p-UvHe84pjFOfaDXOBkCvGb8QmUjZsLd6xcbxwnNtjYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekhfdutdeutdevveejudduueeltdegiefgjefhveeiueevvdevvdeuveeuueehnecuffho
    mhgrihhnpegvnhhvrdgttgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:IkzRaKooMMIgt6waETX_wCndHs9Fc3t_iIgmB-iLB8PA2TpkTls4Vw>
    <xmx:IkzRaIyNU-ZwhtoTbdZtI9jZqv357cHYmX9Ex2FGP2cvKNw5_bodww>
    <xmx:IkzRaHIWonWVFEpq05m8t5OIUqJTu4_5v7_NjJ4vaIdhj2gJFNRG4w>
    <xmx:IkzRaCK7dKaAbbntSS4Z_eIustbv_jHD1RpafIr08dAkTdoUk0TcWw>
    <xmx:IkzRaDU9GEIDgpfRk6Hw3eYAXSBQ3T3xjerF8FgyEHoORaew7qh-Fktg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 09:16:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d280835 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 13:16:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Sep 2025 15:16:11 +0200
Subject: [PATCH] t/unit-tests: update to 10e96bc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250922-pks-clar-update-v1-1-9154e7d1b7a1@pks.im>
X-B4-Tracking: v=1; b=H4sIABpM0WgC/x3MQQqAIBBA0avErBvQKNKuEi0spxoKE60IpLsnL
 d/i/wSRAlOErkgQ6ObIh8uQZQHTatxCyDYbKlE1QkuFfos47Sbg5a05CUctVK2sbq00kCsfaOb
 nP/bD+34AbLYSYQAAAA==
X-Change-ID: 20250918-pks-clar-update-b90848d97d1a
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

Update to 10e96bc (Merge pull request #127 from
pks-gitlab/pks-ci-improvements, 2025-09-22). This commit includes a
couple of changes:

  - The GitHub CI has been updated to include a 32 bit CI job.
    Furthermore, the jobs now compile with "-Werror" and more warnings
    enabled.

  - An issue was addressed where `uintptr_t` is not available on
    NonStop [1].

  - The clar selftests have been restructured so that it is now possible
    to add small test suites more readily. This was done to add tests
    for the above addressed issue, where we now use "%p" to print
    pointers in a platform dependent way.

  - An issue was addressed where the test output had a trailing
    whitespace with certain output formats, which caused whitespace
    issues in the test expectation files.

[1]: <01c101dc2842$38903640$a9b0a2c0$@nexbridge.com>

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
As reported in [1]. This is built on top of master at ca2559c1d6 (The
tenth batch, 2025-09-18) with e7f04f651a (t/unit-tests: update clar to
fcbed04, 2025-09-10) merged into it.

Thanks!

Patrick

[1]: <01c101dc2842$38903640$a9b0a2c0$@nexbridge.com>
---
 t/unit-tests/clar/.github/workflows/ci.yml         |  21 ++-
 t/unit-tests/clar/clar.c                           |  11 +-
 t/unit-tests/clar/clar/print.h                     |  11 +-
 t/unit-tests/clar/generate.py                      |  28 +++-
 t/unit-tests/clar/test/CMakeLists.txt              |  11 +-
 t/unit-tests/clar/test/expected/help               |   2 +-
 t/unit-tests/clar/test/expected/quiet              |  25 ++-
 t/unit-tests/clar/test/expected/specific_test      |   4 +-
 t/unit-tests/clar/test/expected/stop_on_failure    |   4 +-
 t/unit-tests/clar/test/expected/suite_names        |   2 +-
 t/unit-tests/clar/test/expected/summary.xml        |   4 -
 .../clar/test/expected/summary_with_filename       |  29 ++--
 .../clar/test/expected/summary_without_filename    |  29 ++--
 t/unit-tests/clar/test/expected/tap                |  32 ++--
 t/unit-tests/clar/test/expected/without_arguments  |  29 ++--
 t/unit-tests/clar/test/main.c                      |   6 +-
 t/unit-tests/clar/test/selftest.c                  | 173 +++++++++++++++------
 t/unit-tests/clar/test/selftest.h                  |   2 +-
 .../clar/test/selftest_suite/CMakeLists.txt        |  40 -----
 t/unit-tests/clar/test/suites/CMakeLists.txt       |  53 +++++++
 .../selftest_suite.c => suites/combined.c}         |  27 ++--
 .../clar/test/{selftest_suite => suites}/main.c    |   0
 t/unit-tests/clar/test/suites/pointer.c            |  13 ++
 .../{selftest_suite => suites}/resources/test/file |   0
 24 files changed, 320 insertions(+), 236 deletions(-)

diff --git a/t/unit-tests/clar/.github/workflows/ci.yml b/t/unit-tests/clar/.github/workflows/ci.yml
index c41f55f6ff5..4d4724222c3 100644
--- a/t/unit-tests/clar/.github/workflows/ci.yml
+++ b/t/unit-tests/clar/.github/workflows/ci.yml
@@ -13,30 +13,47 @@ jobs:
         platform:
           - os: ubuntu-latest
             generator: Unix Makefiles
+            env:
+              CFLAGS: "-Werror -Wall -Wextra"
           - os: ubuntu-latest
             generator: Unix Makefiles
             env:
               CC: "clang"
-              CFLAGS: "-fsanitize=leak"
+              CFLAGS: "-Werror -Wall -Wextra -fsanitize=leak"
+          - os: ubuntu-latest
+            generator: Unix Makefiles
+            image: i386/debian:latest
+            env:
+              CFLAGS: "-Werror -Wall -Wextra"
           - os: macos-latest
             generator: Unix Makefiles
+            env:
+              CFLAGS: "-Werror -Wall -Wextra"
           - os: windows-latest
             generator: Visual Studio 17 2022
           - os: windows-latest
             generator: MSYS Makefiles
+            env:
+              CFLAGS: "-Werror -Wall -Wextra"
           - os: windows-latest
             generator: MinGW Makefiles
+            env:
+              CFLAGS: "-Werror -Wall -Wextra"
       fail-fast: false
 
     runs-on: ${{ matrix.platform.os }}
+    container: ${{matrix.platform.image}}
 
     env:
       CC: ${{matrix.platform.env.CC}}
       CFLAGS: ${{matrix.platform.env.CFLAGS}}
 
     steps:
+    - name: Prepare 32 bit container image
+      if: matrix.platform.image == 'i386/debian:latest'
+      run: apt -q update && apt -q -y install cmake gcc libc6-amd64 lib64stdc++6 make python3
     - name: Check out
-      uses: actions/checkout@v2
+      uses: actions/checkout@v4
     - name: Build
       shell: bash
       run: |
diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index 80c53594252..d6176e50b22 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -195,7 +195,7 @@ struct clar_suite {
 };
 
 /* From clar_print_*.c */
-static void clar_print_init(int test_count, int suite_count, const char *suite_names);
+static void clar_print_init(int test_count, int suite_count);
 static void clar_print_shutdown(int test_count, int suite_count, int error_count);
 static void clar_print_error(int num, const struct clar_report *report, const struct clar_error *error);
 static void clar_print_ontest(const char *suite_name, const char *test_name, int test_number, enum cl_test_status failed);
@@ -592,11 +592,7 @@ clar_test_init(int argc, char **argv)
 	if (argc > 1)
 		clar_parse_args(argc, argv);
 
-	clar_print_init(
-		(int)_clar_callback_count,
-		(int)_clar_suite_count,
-		""
-	);
+	clar_print_init((int)_clar_callback_count, (int)_clar_suite_count);
 
 	if (!_clar.summary_filename &&
 	    (summary_env = getenv("CLAR_SUMMARY")) != NULL) {
@@ -875,8 +871,7 @@ void clar__assert_equal(
 		void *p1 = va_arg(args, void *), *p2 = va_arg(args, void *);
 		is_equal = (p1 == p2);
 		if (!is_equal)
-			p_snprintf(buf, sizeof(buf), "0x%"PRIxPTR" != 0x%"PRIxPTR,
-				   (uintptr_t)p1, (uintptr_t)p2);
+			p_snprintf(buf, sizeof(buf), "%p != %p", p1, p2);
 	}
 	else {
 		int i1 = va_arg(args, int), i2 = va_arg(args, int);
diff --git a/t/unit-tests/clar/clar/print.h b/t/unit-tests/clar/clar/print.h
index 0282aaa1381..89b66591d75 100644
--- a/t/unit-tests/clar/clar/print.h
+++ b/t/unit-tests/clar/clar/print.h
@@ -1,13 +1,13 @@
 /* clap: clar protocol, the traditional clar output format */
 
-static void clar_print_clap_init(int test_count, int suite_count, const char *suite_names)
+static void clar_print_clap_init(int test_count, int suite_count)
 {
 	(void)test_count;
 
 	if (_clar.verbosity < 0)
 		return;
 
-	printf("Loaded %d suites: %s\n", (int)suite_count, suite_names);
+	printf("Loaded %d suites:\n", (int)suite_count);
 	printf("Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')\n");
 }
 
@@ -103,11 +103,10 @@ static void clar_print_clap_onabort(const char *fmt, va_list arg)
 
 /* tap: test anywhere protocol format */
 
-static void clar_print_tap_init(int test_count, int suite_count, const char *suite_names)
+static void clar_print_tap_init(int test_count, int suite_count)
 {
 	(void)test_count;
 	(void)suite_count;
-	(void)suite_names;
 	printf("TAP version 13\n");
 }
 
@@ -207,9 +206,9 @@ static void clar_print_tap_onabort(const char *fmt, va_list arg)
 		} \
 	} while (0)
 
-static void clar_print_init(int test_count, int suite_count, const char *suite_names)
+static void clar_print_init(int test_count, int suite_count)
 {
-	PRINT(init, test_count, suite_count, suite_names);
+	PRINT(init, test_count, suite_count);
 }
 
 static void clar_print_shutdown(int test_count, int suite_count, int error_count)
diff --git a/t/unit-tests/clar/generate.py b/t/unit-tests/clar/generate.py
index 80996ac3e71..fd2f0ee83b5 100755
--- a/t/unit-tests/clar/generate.py
+++ b/t/unit-tests/clar/generate.py
@@ -158,17 +158,24 @@ def should_generate(self, path):
 
     def find_modules(self):
         modules = []
-        for root, _, files in os.walk(self.path):
-            module_root = root[len(self.path):]
-            module_root = [c for c in module_root.split(os.sep) if c]
 
-            tests_in_module = fnmatch.filter(files, "*.c")
+        if os.path.isfile(self.path):
+            full_path = os.path.abspath(self.path)
+            module_name = os.path.basename(self.path)
+            module_name = os.path.splitext(module_name)[0]
+            modules.append((full_path, module_name))
+        else:
+            for root, _, files in os.walk(self.path):
+                module_root = root[len(self.path):]
+                module_root = [c for c in module_root.split(os.sep) if c]
 
-            for test_file in tests_in_module:
-                full_path = os.path.join(root, test_file)
-                module_name = "_".join(module_root + [test_file[:-2]]).replace("-", "_")
+                tests_in_module = fnmatch.filter(files, "*.c")
 
-                modules.append((full_path, module_name))
+                for test_file in tests_in_module:
+                    full_path = os.path.join(root, test_file)
+                    module_name = "_".join(module_root + [test_file[:-2]]).replace("-", "_")
+
+                    modules.append((full_path, module_name))
 
         return modules
 
@@ -217,6 +224,7 @@ def callback_count(self):
 
     def write(self):
         output = os.path.join(self.output, 'clar.suite')
+        os.makedirs(self.output, exist_ok=True)
 
         if not self.should_generate(output):
             return False
@@ -258,7 +266,11 @@ def write(self):
         sys.exit(1)
 
     path = args.pop() if args else '.'
+    if os.path.isfile(path) and not options.output:
+        print("Must provide --output when specifying a file")
+        sys.exit(1)
     output = options.output or path
+
     suite = TestSuite(path, output)
     suite.load(options.force)
     suite.disable(options.excluded)
diff --git a/t/unit-tests/clar/test/CMakeLists.txt b/t/unit-tests/clar/test/CMakeLists.txt
index 96abd6ed931..f2401664397 100644
--- a/t/unit-tests/clar/test/CMakeLists.txt
+++ b/t/unit-tests/clar/test/CMakeLists.txt
@@ -1,5 +1,3 @@
-add_subdirectory(selftest_suite)
-
 find_package(Python COMPONENTS Interpreter REQUIRED)
 
 add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
@@ -40,15 +38,12 @@ target_include_directories(selftest PRIVATE
 )
 target_link_libraries(selftest clar)
 
-add_test(NAME build_selftest_suite
-	COMMAND "${CMAKE_COMMAND}" --build "${CMAKE_BINARY_DIR}" --config "$<CONFIG>" --target selftest_suite
-)
-set_tests_properties(build_selftest_suite PROPERTIES FIXTURES_SETUP clar_test_fixture)
-
 add_test(NAME build_selftest
 	COMMAND "${CMAKE_COMMAND}" --build "${CMAKE_BINARY_DIR}" --config "$<CONFIG>" --target selftest
 )
 set_tests_properties(build_selftest PROPERTIES FIXTURES_SETUP clar_test_fixture)
 
-add_test(NAME selftest COMMAND "${CMAKE_CURRENT_BINARY_DIR}/selftest" "$<TARGET_FILE:selftest_suite>")
+add_subdirectory(suites)
+
+add_test(NAME selftest COMMAND "${CMAKE_CURRENT_BINARY_DIR}/selftest" $<TARGET_FILE_DIR:combined_suite>)
 set_tests_properties(selftest PROPERTIES FIXTURES_REQUIRED clar_test_fixture)
diff --git a/t/unit-tests/clar/test/expected/help b/t/unit-tests/clar/test/expected/help
index 4b2be69f973..9428def2d71 100644
--- a/t/unit-tests/clar/test/expected/help
+++ b/t/unit-tests/clar/test/expected/help
@@ -1,4 +1,4 @@
-Usage: selftest [options]
+Usage: combined [options]
 
 Options:
   -sname        Run only the suite with `name` (can go to individual test name)
diff --git a/t/unit-tests/clar/test/expected/quiet b/t/unit-tests/clar/test/expected/quiet
index 975164147ff..280c99d8ad5 100644
--- a/t/unit-tests/clar/test/expected/quiet
+++ b/t/unit-tests/clar/test/expected/quiet
@@ -1,49 +1,44 @@
   1) Failure:
-selftest::suite::1 [file:42]
+combined::1 [file:42]
   Function call failed: -1
 
   2) Failure:
-selftest::suite::2 [file:42]
+combined::2 [file:42]
   Expression is not true: 100 == 101
 
   3) Failure:
-selftest::suite::strings [file:42]
+combined::strings [file:42]
   String mismatch: "mismatched" != actual ("this one fails")
   'mismatched' != 'expected' (at byte 0)
 
   4) Failure:
-selftest::suite::strings_with_length [file:42]
+combined::strings_with_length [file:42]
   String mismatch: "exactly" != actual ("this one fails")
   'exa' != 'exp' (at byte 2)
 
   5) Failure:
-selftest::suite::int [file:42]
+combined::int [file:42]
   101 != value ("extra note on failing test")
   101 != 100
 
   6) Failure:
-selftest::suite::int_fmt [file:42]
+combined::int_fmt [file:42]
   022 != value
   0022 != 0144
 
   7) Failure:
-selftest::suite::bool [file:42]
+combined::bool [file:42]
   0 != value
   0 != 1
 
   8) Failure:
-selftest::suite::ptr [file:42]
-  Pointer mismatch: p1 != p2
-  0x1 != 0x2
-
-  9) Failure:
-selftest::suite::multiline_description [file:42]
+combined::multiline_description [file:42]
   Function call failed: -1
   description line 1
   description line 2
 
-  10) Failure:
-selftest::suite::null_string [file:42]
+  9) Failure:
+combined::null_string [file:42]
   String mismatch: "expected" != actual ("this one fails")
   'expected' != NULL
 
diff --git a/t/unit-tests/clar/test/expected/specific_test b/t/unit-tests/clar/test/expected/specific_test
index afa21509804..6c22e9f507d 100644
--- a/t/unit-tests/clar/test/expected/specific_test
+++ b/t/unit-tests/clar/test/expected/specific_test
@@ -1,9 +1,9 @@
-Loaded 1 suites: 
+Loaded 1 suites:
 Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
 F
 
   1) Failure:
-selftest::suite::bool [file:42]
+combined::bool [file:42]
   0 != value
   0 != 1
 
diff --git a/t/unit-tests/clar/test/expected/stop_on_failure b/t/unit-tests/clar/test/expected/stop_on_failure
index 1156ade0f92..c23610754f8 100644
--- a/t/unit-tests/clar/test/expected/stop_on_failure
+++ b/t/unit-tests/clar/test/expected/stop_on_failure
@@ -1,8 +1,8 @@
-Loaded 1 suites: 
+Loaded 1 suites:
 Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
 F
 
   1) Failure:
-selftest::suite::1 [file:42]
+combined::1 [file:42]
   Function call failed: -1
 
diff --git a/t/unit-tests/clar/test/expected/suite_names b/t/unit-tests/clar/test/expected/suite_names
index 1b0f6397eb3..10d1538427e 100644
--- a/t/unit-tests/clar/test/expected/suite_names
+++ b/t/unit-tests/clar/test/expected/suite_names
@@ -1,2 +1,2 @@
 Test suites (use -s<name> to run just one):
-   0: selftest::suite
+   0: combined
diff --git a/t/unit-tests/clar/test/expected/summary.xml b/t/unit-tests/clar/test/expected/summary.xml
index 9034a03d1fa..9a89d43a593 100644
--- a/t/unit-tests/clar/test/expected/summary.xml
+++ b/t/unit-tests/clar/test/expected/summary.xml
@@ -27,10 +27,6 @@
 		<testcase name="bool" classname="selftest" time="0.00">
 			<failure type="assert"><![CDATA[0 != value
 0 != 1]]></failure>
-		</testcase>
-		<testcase name="ptr" classname="selftest" time="0.00">
-			<failure type="assert"><![CDATA[Pointer mismatch: p1 != p2
-0x1 != 0x2]]></failure>
 		</testcase>
 		<testcase name="multiline_description" classname="selftest" time="0.00">
 			<failure type="assert"><![CDATA[Function call failed: −1
diff --git a/t/unit-tests/clar/test/expected/summary_with_filename b/t/unit-tests/clar/test/expected/summary_with_filename
index a5f4d405370..460160791d1 100644
--- a/t/unit-tests/clar/test/expected/summary_with_filename
+++ b/t/unit-tests/clar/test/expected/summary_with_filename
@@ -1,53 +1,48 @@
-Loaded 1 suites: 
+Loaded 1 suites:
 Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
-FFFFFFFFFF
+FFFFFFFFF
 
   1) Failure:
-selftest::suite::1 [file:42]
+combined::1 [file:42]
   Function call failed: -1
 
   2) Failure:
-selftest::suite::2 [file:42]
+combined::2 [file:42]
   Expression is not true: 100 == 101
 
   3) Failure:
-selftest::suite::strings [file:42]
+combined::strings [file:42]
   String mismatch: "mismatched" != actual ("this one fails")
   'mismatched' != 'expected' (at byte 0)
 
   4) Failure:
-selftest::suite::strings_with_length [file:42]
+combined::strings_with_length [file:42]
   String mismatch: "exactly" != actual ("this one fails")
   'exa' != 'exp' (at byte 2)
 
   5) Failure:
-selftest::suite::int [file:42]
+combined::int [file:42]
   101 != value ("extra note on failing test")
   101 != 100
 
   6) Failure:
-selftest::suite::int_fmt [file:42]
+combined::int_fmt [file:42]
   022 != value
   0022 != 0144
 
   7) Failure:
-selftest::suite::bool [file:42]
+combined::bool [file:42]
   0 != value
   0 != 1
 
   8) Failure:
-selftest::suite::ptr [file:42]
-  Pointer mismatch: p1 != p2
-  0x1 != 0x2
-
-  9) Failure:
-selftest::suite::multiline_description [file:42]
+combined::multiline_description [file:42]
   Function call failed: -1
   description line 1
   description line 2
 
-  10) Failure:
-selftest::suite::null_string [file:42]
+  9) Failure:
+combined::null_string [file:42]
   String mismatch: "expected" != actual ("this one fails")
   'expected' != NULL
 
diff --git a/t/unit-tests/clar/test/expected/summary_without_filename b/t/unit-tests/clar/test/expected/summary_without_filename
index 5984502773e..7874c1d98bc 100644
--- a/t/unit-tests/clar/test/expected/summary_without_filename
+++ b/t/unit-tests/clar/test/expected/summary_without_filename
@@ -1,53 +1,48 @@
-Loaded 1 suites: 
+Loaded 1 suites:
 Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
-FFFFFFFFFF
+FFFFFFFFF
 
   1) Failure:
-selftest::suite::1 [file:42]
+combined::1 [file:42]
   Function call failed: -1
 
   2) Failure:
-selftest::suite::2 [file:42]
+combined::2 [file:42]
   Expression is not true: 100 == 101
 
   3) Failure:
-selftest::suite::strings [file:42]
+combined::strings [file:42]
   String mismatch: "mismatched" != actual ("this one fails")
   'mismatched' != 'expected' (at byte 0)
 
   4) Failure:
-selftest::suite::strings_with_length [file:42]
+combined::strings_with_length [file:42]
   String mismatch: "exactly" != actual ("this one fails")
   'exa' != 'exp' (at byte 2)
 
   5) Failure:
-selftest::suite::int [file:42]
+combined::int [file:42]
   101 != value ("extra note on failing test")
   101 != 100
 
   6) Failure:
-selftest::suite::int_fmt [file:42]
+combined::int_fmt [file:42]
   022 != value
   0022 != 0144
 
   7) Failure:
-selftest::suite::bool [file:42]
+combined::bool [file:42]
   0 != value
   0 != 1
 
   8) Failure:
-selftest::suite::ptr [file:42]
-  Pointer mismatch: p1 != p2
-  0x1 != 0x2
-
-  9) Failure:
-selftest::suite::multiline_description [file:42]
+combined::multiline_description [file:42]
   Function call failed: -1
   description line 1
   description line 2
 
-  10) Failure:
-selftest::suite::null_string [file:42]
+  9) Failure:
+combined::null_string [file:42]
   String mismatch: "expected" != actual ("this one fails")
   'expected' != NULL
 
diff --git a/t/unit-tests/clar/test/expected/tap b/t/unit-tests/clar/test/expected/tap
index 3dc4973dfa1..bddbd5dfe98 100644
--- a/t/unit-tests/clar/test/expected/tap
+++ b/t/unit-tests/clar/test/expected/tap
@@ -1,6 +1,6 @@
 TAP version 13
-# start of suite 1: selftest::suite
-not ok 1 - selftest::suite::1
+# start of suite 1: combined
+not ok 1 - combined::1
     ---
     reason: |
       Function call failed: -1
@@ -9,7 +9,7 @@ not ok 1 - selftest::suite::1
       line: 42
       function: 'func'
     ---
-not ok 2 - selftest::suite::2
+not ok 2 - combined::2
     ---
     reason: |
       Expression is not true: 100 == 101
@@ -18,7 +18,7 @@ not ok 2 - selftest::suite::2
       line: 42
       function: 'func'
     ---
-not ok 3 - selftest::suite::strings
+not ok 3 - combined::strings
     ---
     reason: |
       String mismatch: "mismatched" != actual ("this one fails")
@@ -28,7 +28,7 @@ not ok 3 - selftest::suite::strings
       line: 42
       function: 'func'
     ---
-not ok 4 - selftest::suite::strings_with_length
+not ok 4 - combined::strings_with_length
     ---
     reason: |
       String mismatch: "exactly" != actual ("this one fails")
@@ -38,7 +38,7 @@ not ok 4 - selftest::suite::strings_with_length
       line: 42
       function: 'func'
     ---
-not ok 5 - selftest::suite::int
+not ok 5 - combined::int
     ---
     reason: |
       101 != value ("extra note on failing test")
@@ -48,7 +48,7 @@ not ok 5 - selftest::suite::int
       line: 42
       function: 'func'
     ---
-not ok 6 - selftest::suite::int_fmt
+not ok 6 - combined::int_fmt
     ---
     reason: |
       022 != value
@@ -58,7 +58,7 @@ not ok 6 - selftest::suite::int_fmt
       line: 42
       function: 'func'
     ---
-not ok 7 - selftest::suite::bool
+not ok 7 - combined::bool
     ---
     reason: |
       0 != value
@@ -68,17 +68,7 @@ not ok 7 - selftest::suite::bool
       line: 42
       function: 'func'
     ---
-not ok 8 - selftest::suite::ptr
-    ---
-    reason: |
-      Pointer mismatch: p1 != p2
-      0x1 != 0x2
-    at:
-      file: 'file'
-      line: 42
-      function: 'func'
-    ---
-not ok 9 - selftest::suite::multiline_description
+not ok 8 - combined::multiline_description
     ---
     reason: |
       Function call failed: -1
@@ -89,7 +79,7 @@ not ok 9 - selftest::suite::multiline_description
       line: 42
       function: 'func'
     ---
-not ok 10 - selftest::suite::null_string
+not ok 9 - combined::null_string
     ---
     reason: |
       String mismatch: "expected" != actual ("this one fails")
@@ -99,4 +89,4 @@ not ok 10 - selftest::suite::null_string
       line: 42
       function: 'func'
     ---
-1..10
+1..9
diff --git a/t/unit-tests/clar/test/expected/without_arguments b/t/unit-tests/clar/test/expected/without_arguments
index 08b67b874cb..1111d418a06 100644
--- a/t/unit-tests/clar/test/expected/without_arguments
+++ b/t/unit-tests/clar/test/expected/without_arguments
@@ -1,53 +1,48 @@
-Loaded 1 suites: 
+Loaded 1 suites:
 Started (test status codes: OK='.' FAILURE='F' SKIPPED='S')
-FFFFFFFFFF
+FFFFFFFFF
 
   1) Failure:
-selftest::suite::1 [file:42]
+combined::1 [file:42]
   Function call failed: -1
 
   2) Failure:
-selftest::suite::2 [file:42]
+combined::2 [file:42]
   Expression is not true: 100 == 101
 
   3) Failure:
-selftest::suite::strings [file:42]
+combined::strings [file:42]
   String mismatch: "mismatched" != actual ("this one fails")
   'mismatched' != 'expected' (at byte 0)
 
   4) Failure:
-selftest::suite::strings_with_length [file:42]
+combined::strings_with_length [file:42]
   String mismatch: "exactly" != actual ("this one fails")
   'exa' != 'exp' (at byte 2)
 
   5) Failure:
-selftest::suite::int [file:42]
+combined::int [file:42]
   101 != value ("extra note on failing test")
   101 != 100
 
   6) Failure:
-selftest::suite::int_fmt [file:42]
+combined::int_fmt [file:42]
   022 != value
   0022 != 0144
 
   7) Failure:
-selftest::suite::bool [file:42]
+combined::bool [file:42]
   0 != value
   0 != 1
 
   8) Failure:
-selftest::suite::ptr [file:42]
-  Pointer mismatch: p1 != p2
-  0x1 != 0x2
-
-  9) Failure:
-selftest::suite::multiline_description [file:42]
+combined::multiline_description [file:42]
   Function call failed: -1
   description line 1
   description line 2
 
-  10) Failure:
-selftest::suite::null_string [file:42]
+  9) Failure:
+combined::null_string [file:42]
   String mismatch: "expected" != actual ("this one fails")
   'expected' != NULL
 
diff --git a/t/unit-tests/clar/test/main.c b/t/unit-tests/clar/test/main.c
index b1ba2996f13..94af4406437 100644
--- a/t/unit-tests/clar/test/main.c
+++ b/t/unit-tests/clar/test/main.c
@@ -3,7 +3,7 @@
 
 #include "selftest.h"
 
-const char *selftest_binary_path;
+const char *selftest_suite_directory;
 
 #ifdef _WIN32
 int __cdecl main(int argc, char *argv[])
@@ -12,12 +12,12 @@ int main(int argc, char *argv[])
 #endif
 {
 	if (argc < 2) {
-		fprintf(stderr, "usage: %s <selftest-suite-executable> <options>\n",
+		fprintf(stderr, "usage: %s <selftest-suite-directory> <options>\n",
 			argv[0]);
 		exit(1);
 	}
 
-	selftest_binary_path = argv[1];
+	selftest_suite_directory = argv[1];
 	memmove(argv + 1, argv + 2, argc - 1);
 	argc -= 1;
 
diff --git a/t/unit-tests/clar/test/selftest.c b/t/unit-tests/clar/test/selftest.c
index abd585f4e4a..eed83e45120 100644
--- a/t/unit-tests/clar/test/selftest.c
+++ b/t/unit-tests/clar/test/selftest.c
@@ -59,38 +59,34 @@ static char *read_file(const char *path)
 	return content;
 }
 
-static void run(const char *expected_output_file, int expected_error_code, ...)
+static char *execute(const char *suite, int expected_error_code, const char **args, size_t nargs)
 {
 	SECURITY_ATTRIBUTES security_attributes = { 0 };
 	PROCESS_INFORMATION process_info = { 0 };
 	STARTUPINFO startup_info = { 0 };
+	char binary_path[4096] = { 0 };
 	char cmdline[4096] = { 0 };
-	char *expected_output = NULL;
 	char *output = NULL;
 	HANDLE stdout_write;
 	HANDLE stdout_read;
 	DWORD exit_code;
-	va_list ap;
+	size_t i;
+
+	snprintf(binary_path, sizeof(binary_path), "%s/%s_suite.exe",
+		 selftest_suite_directory, suite);
 
 	/*
 	 * Assemble command line arguments. In theory we'd have to properly
 	 * quote them. In practice none of our tests actually care.
 	 */
-	va_start(ap, expected_error_code);
-	snprintf(cmdline, sizeof(cmdline), "selftest");
-	while (1) {
+	snprintf(cmdline, sizeof(cmdline), suite);
+	for (i = 0; i < nargs; i++) {
 		size_t cmdline_len = strlen(cmdline);
-		const char *arg;
-
-		arg = va_arg(ap, const char *);
-		if (!arg)
-			break;
-
+		const char *arg = args[i];
 		cl_assert(cmdline_len + strlen(arg) < sizeof(cmdline));
 		snprintf(cmdline + cmdline_len, sizeof(cmdline) - cmdline_len,
 			 " %s", arg);
 	}
-	va_end(ap);
 
 	/*
 	 * Create a pipe that we will use to read data from the child process.
@@ -110,17 +106,39 @@ static void run(const char *expected_output_file, int expected_error_code, ...)
 	startup_info.hStdError = stdout_write;
 	startup_info.hStdOutput = stdout_write;
 	startup_info.dwFlags |= STARTF_USESTDHANDLES;
-	cl_assert_equal_b(1, CreateProcess(selftest_binary_path, cmdline, NULL, NULL, TRUE,
+	cl_assert_equal_b(1, CreateProcess(binary_path, cmdline, NULL, NULL, TRUE,
 					   0, NULL, NULL, &startup_info, &process_info));
 	cl_assert_equal_b(1, CloseHandle(stdout_write));
 
 	output = read_full(stdout_read, 1);
 	cl_assert_equal_b(1, CloseHandle(stdout_read));
 	cl_assert_equal_b(1, GetExitCodeProcess(process_info.hProcess, &exit_code));
+	cl_assert_equal_i(exit_code, expected_error_code);
+
+	return output;
+}
+
+static void assert_output(const char *suite, const char *expected_output_file, int expected_error_code, ...)
+{
+	char *expected_output = NULL;
+	char *output = NULL;
+	const char *args[16];
+	va_list ap;
+	size_t i;
+
+	va_start(ap, expected_error_code);
+	for (i = 0; ; i++) {
+		const char *arg = va_arg(ap, const char *);
+		if (!arg)
+			break;
+		cl_assert(i < sizeof(args) / sizeof(*args));
+		args[i] = arg;
+	}
+	va_end(ap);
 
+	output = execute(suite, expected_error_code, args, i);
 	expected_output = read_file(cl_fixture(expected_output_file));
 	cl_assert_equal_s(output, expected_output);
-	cl_assert_equal_i(exit_code, expected_error_code);
 
 	free(expected_output);
 	free(output);
@@ -180,29 +198,25 @@ static char *read_file(const char *path)
 	return data;
 }
 
-static void run(const char *expected_output_file, int expected_error_code, ...)
+static char *execute(const char *suite, int expected_error_code, const char **args, size_t nargs)
 {
-	const char *argv[16];
 	int pipe_fds[2];
-	va_list ap;
 	pid_t pid;
-	int i;
-
-	va_start(ap, expected_error_code);
-	argv[0] = "selftest";
-	for (i = 1; ; i++) {
-		cl_assert(i < sizeof(argv) / sizeof(*argv));
-
-		argv[i] = va_arg(ap, const char *);
-		if (!argv[i])
-			break;
-	}
-	va_end(ap);
 
 	cl_must_pass(pipe(pipe_fds));
 
 	pid = fork();
 	if (!pid) {
+		const char *final_args[17] = { NULL };
+		char binary_path[4096];
+		size_t len = 0;
+		size_t i;
+
+		cl_assert(nargs < sizeof(final_args) / sizeof(*final_args));
+		final_args[0] = suite;
+		for (i = 0; i < nargs; i++)
+			final_args[i + 1] = args[i];
+
 		if (dup2(pipe_fds[1], STDOUT_FILENO) < 0 ||
 		    dup2(pipe_fds[1], STDERR_FILENO) < 0 ||
 		    close(0) < 0 ||
@@ -210,11 +224,29 @@ static void run(const char *expected_output_file, int expected_error_code, ...)
 		    close(pipe_fds[1]) < 0)
 			exit(1);
 
-		execv(selftest_binary_path, (char **) argv);
+		cl_assert(len + strlen(selftest_suite_directory) < sizeof(binary_path));
+		strcpy(binary_path, selftest_suite_directory);
+		len += strlen(selftest_suite_directory);
+
+		cl_assert(len + 1 < sizeof(binary_path));
+		binary_path[len] = '/';
+		len += 1;
+
+		cl_assert(len + strlen(suite) < sizeof(binary_path));
+		strcpy(binary_path + len, suite);
+		len += strlen(suite);
+
+		cl_assert(len + strlen("_suite") < sizeof(binary_path));
+		strcpy(binary_path + len, "_suite");
+		len += strlen("_suite");
+
+		binary_path[len] = '\0';
+
+		execv(binary_path, (char **) final_args);
 		exit(1);
 	} else if (pid > 0) {
 		pid_t waited_pid;
-		char *expected_output, *output;
+		char *output;
 		int stat;
 
 		cl_must_pass(close(pipe_fds[1]));
@@ -226,56 +258,78 @@ static void run(const char *expected_output_file, int expected_error_code, ...)
 		cl_assert(WIFEXITED(stat));
 		cl_assert_equal_i(WEXITSTATUS(stat), expected_error_code);
 
-		expected_output = read_file(cl_fixture(expected_output_file));
-		cl_assert_equal_s(output, expected_output);
-
-		free(expected_output);
-		free(output);
+		return output;
 	} else {
 		cl_fail("Fork failed.");
 	}
+
+	return NULL;
+}
+
+static void assert_output(const char *suite, const char *expected_output_file, int expected_error_code, ...)
+{
+	char *expected_output, *output;
+	const char *args[16];
+	va_list ap;
+	size_t i;
+
+	va_start(ap, expected_error_code);
+	for (i = 0; ; i++) {
+		cl_assert(i < sizeof(args) / sizeof(*args));
+		args[i] = va_arg(ap, const char *);
+		if (!args[i])
+			break;
+	}
+	va_end(ap);
+
+	output = execute(suite, expected_error_code, args, i);
+	expected_output = read_file(cl_fixture(expected_output_file));
+	cl_assert_equal_s(output, expected_output);
+
+	free(expected_output);
+	free(output);
 }
 #endif
 
 void test_selftest__help(void)
 {
-	cl_invoke(run("help", 1, "-h", NULL));
+	cl_invoke(assert_output("combined", "help", 1, "-h", NULL));
 }
 
 void test_selftest__without_arguments(void)
 {
-	cl_invoke(run("without_arguments", 10, NULL));
+	cl_invoke(assert_output("combined", "without_arguments", 9, NULL));
 }
 
 void test_selftest__specific_test(void)
 {
-	cl_invoke(run("specific_test", 1, "-sselftest::suite::bool", NULL));
+	cl_invoke(assert_output("combined", "specific_test", 1, "-scombined::bool", NULL));
 }
 
 void test_selftest__stop_on_failure(void)
 {
-	cl_invoke(run("stop_on_failure", 1, "-Q", NULL));
+	cl_invoke(assert_output("combined", "stop_on_failure", 1, "-Q", NULL));
 }
 
 void test_selftest__quiet(void)
 {
-	cl_invoke(run("quiet", 10, "-q", NULL));
+	cl_invoke(assert_output("combined", "quiet", 9, "-q", NULL));
 }
 
 void test_selftest__tap(void)
 {
-	cl_invoke(run("tap", 10, "-t", NULL));
+	cl_invoke(assert_output("combined", "tap", 9, "-t", NULL));
 }
 
 void test_selftest__suite_names(void)
 {
-	cl_invoke(run("suite_names", 0, "-l", NULL));
+	cl_invoke(assert_output("combined", "suite_names", 0, "-l", NULL));
 }
 
 void test_selftest__summary_without_filename(void)
 {
 	struct stat st;
-	cl_invoke(run("summary_without_filename", 10, "-r", NULL));
+	cl_invoke(assert_output("combined", "summary_without_filename", 9, "-r", NULL));
 	/* The summary contains timestamps, so we cannot verify its contents. */
 	cl_must_pass(stat("summary.xml", &st));
 }
@@ -283,7 +337,34 @@ void test_selftest__summary_without_filename(void)
 void test_selftest__summary_with_filename(void)
 {
 	struct stat st;
-	cl_invoke(run("summary_with_filename", 10, "-rdifferent.xml", NULL));
+	cl_invoke(assert_output("combined", "summary_with_filename", 9, "-rdifferent.xml", NULL));
 	/* The summary contains timestamps, so we cannot verify its contents. */
 	cl_must_pass(stat("different.xml", &st));
 }
+
+void test_selftest__pointer_equal(void)
+{
+	const char *args[] = {
+		"-spointer::equal",
+		"-t"
+	};
+	char *output = execute("pointer", 0, args, 2);
+	cl_assert_equal_s(output,
+		   "TAP version 13\n"
+		   "# start of suite 1: pointer\n"
+		   "ok 1 - pointer::equal\n"
+		   "1..1\n"
+	);
+	free(output);
+}
+
+void test_selftest__pointer_unequal(void)
+{
+	const char *args[] = {
+		"-spointer::unequal",
+	};
+	char *output = execute("pointer", 1, args, 1);
+	cl_assert(output);
+	cl_assert(strstr(output, "Pointer mismatch: "));
+	free(output);
+}
diff --git a/t/unit-tests/clar/test/selftest.h b/t/unit-tests/clar/test/selftest.h
index 220a350c504..c24e0c5af41 100644
--- a/t/unit-tests/clar/test/selftest.h
+++ b/t/unit-tests/clar/test/selftest.h
@@ -1,3 +1,3 @@
 #include "clar.h"
 
-extern const char *selftest_binary_path;
+extern const char *selftest_suite_directory;
diff --git a/t/unit-tests/clar/test/selftest_suite/CMakeLists.txt b/t/unit-tests/clar/test/selftest_suite/CMakeLists.txt
deleted file mode 100644
index 9597d6711a7..00000000000
--- a/t/unit-tests/clar/test/selftest_suite/CMakeLists.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-find_package(Python COMPONENTS Interpreter REQUIRED)
-
-add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
-	COMMAND "${Python_EXECUTABLE}" "${CMAKE_SOURCE_DIR}/generate.py" --output "${CMAKE_CURRENT_BINARY_DIR}"
-	DEPENDS main.c selftest_suite.c
-	WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
-)
-
-add_executable(selftest_suite)
-set_target_properties(selftest_suite PROPERTIES
-	C_STANDARD 90
-	C_STANDARD_REQUIRED ON
-	C_EXTENSIONS OFF
-)
-
-# MSVC generates all kinds of warnings. We may want to fix these in the future
-# and then unconditionally treat warnings as errors.
-if(NOT MSVC)
-	set_target_properties(selftest_suite PROPERTIES
-		COMPILE_WARNING_AS_ERROR ON
-	)
-endif()
-
-target_sources(selftest_suite PRIVATE
-	main.c
-	selftest_suite.c
-	"${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
-)
-target_compile_definitions(selftest_suite PRIVATE
-	CLAR_FIXTURE_PATH="${CMAKE_CURRENT_SOURCE_DIR}/resources/"
-	CLAR_SELFTEST
-)
-target_compile_options(selftest_suite PRIVATE
-	$<IF:$<CXX_COMPILER_ID:MSVC>,/W4,-Wall>
-)
-target_include_directories(selftest_suite PRIVATE
-	"${CMAKE_SOURCE_DIR}"
-	"${CMAKE_CURRENT_BINARY_DIR}"
-)
-target_link_libraries(selftest_suite clar)
diff --git a/t/unit-tests/clar/test/suites/CMakeLists.txt b/t/unit-tests/clar/test/suites/CMakeLists.txt
new file mode 100644
index 00000000000..fa8ab9416a8
--- /dev/null
+++ b/t/unit-tests/clar/test/suites/CMakeLists.txt
@@ -0,0 +1,53 @@
+list(APPEND suites
+	"combined"
+	"pointer"
+)
+
+foreach(suite IN LISTS suites)
+	add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${suite}/clar.suite"
+		COMMAND "${Python_EXECUTABLE}"
+			"${CMAKE_SOURCE_DIR}/generate.py"
+			"${CMAKE_CURRENT_SOURCE_DIR}/${suite}.c"
+			--output "${CMAKE_CURRENT_BINARY_DIR}/${suite}"
+		DEPENDS ${suite}.c
+		WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
+	)
+
+	add_executable(${suite}_suite)
+	set_target_properties(${suite}_suite PROPERTIES
+		C_STANDARD 90
+		C_STANDARD_REQUIRED ON
+		C_EXTENSIONS OFF
+	)
+
+	# MSVC generates all kinds of warnings. We may want to fix these in the future
+	# and then unconditionally treat warnings as errors.
+	if(NOT MSVC)
+		set_target_properties(${suite}_suite PROPERTIES
+			COMPILE_WARNING_AS_ERROR ON
+		)
+	endif()
+
+	target_sources(${suite}_suite PRIVATE
+		main.c
+		${suite}.c
+		"${CMAKE_CURRENT_BINARY_DIR}/${suite}/clar.suite"
+	)
+	target_compile_definitions(${suite}_suite PRIVATE
+		CLAR_FIXTURE_PATH="${CMAKE_CURRENT_SOURCE_DIR}/resources/"
+		CLAR_SELFTEST
+	)
+	target_compile_options(${suite}_suite PRIVATE
+		$<IF:$<CXX_COMPILER_ID:MSVC>,/W4,-Wall>
+	)
+	target_include_directories(${suite}_suite PRIVATE
+		"${CMAKE_SOURCE_DIR}"
+		"${CMAKE_CURRENT_BINARY_DIR}/${suite}"
+	)
+	target_link_libraries(${suite}_suite clar)
+
+	add_test(NAME build_${suite}_suite
+		COMMAND "${CMAKE_COMMAND}" --build "${CMAKE_BINARY_DIR}" --config "$<CONFIG>" --target selftest
+	)
+	set_tests_properties(build_${suite}_suite PROPERTIES FIXTURES_SETUP clar_test_fixture)
+endforeach()
diff --git a/t/unit-tests/clar/test/selftest_suite/selftest_suite.c b/t/unit-tests/clar/test/suites/combined.c
similarity index 72%
rename from t/unit-tests/clar/test/selftest_suite/selftest_suite.c
rename to t/unit-tests/clar/test/suites/combined.c
index 77f872128c7..e8b41c98c37 100644
--- a/t/unit-tests/clar/test/selftest_suite/selftest_suite.c
+++ b/t/unit-tests/clar/test/suites/combined.c
@@ -11,14 +11,14 @@ static int file_size(const char *filename)
 	return -1;
 }
 
-void test_selftest_suite__cleanup(void)
+void test_combined__cleanup(void)
 {
 	cl_fixture_cleanup("test");
 
 	cl_assert(file_size("test/file") == -1);
 }
 
-void test_selftest_suite__1(void)
+void test_combined__1(void)
 {
 	cl_assert(1);
 	cl_must_pass(0);  /* 0 == success */
@@ -26,7 +26,7 @@ void test_selftest_suite__1(void)
 	cl_must_pass(-1); /* demonstrate a failing call */
 }
 
-void test_selftest_suite__2(void)
+void test_combined__2(void)
 {
 	cl_fixture_sandbox("test");
 
@@ -35,7 +35,7 @@ void test_selftest_suite__2(void)
 	cl_assert(100 == 101);
 }
 
-void test_selftest_suite__strings(void)
+void test_combined__strings(void)
 {
 	const char *actual = "expected";
 	cl_assert_equal_s("expected", actual);
@@ -43,7 +43,7 @@ void test_selftest_suite__strings(void)
 	cl_assert_equal_s_("mismatched", actual, "this one fails");
 }
 
-void test_selftest_suite__strings_with_length(void)
+void test_combined__strings_with_length(void)
 {
 	const char *actual = "expected";
 	cl_assert_equal_strn("expected_", actual, 8);
@@ -52,39 +52,32 @@ void test_selftest_suite__strings_with_length(void)
 	cl_assert_equal_strn_("exactly", actual, 3, "this one fails");
 }
 
-void test_selftest_suite__int(void)
+void test_combined__int(void)
 {
 	int value = 100;
 	cl_assert_equal_i(100, value);
 	cl_assert_equal_i_(101, value, "extra note on failing test");
 }
 
-void test_selftest_suite__int_fmt(void)
+void test_combined__int_fmt(void)
 {
 	int value = 100;
 	cl_assert_equal_i_fmt(022, value, "%04o");
 }
 
-void test_selftest_suite__bool(void)
+void test_combined__bool(void)
 {
 	int value = 100;
 	cl_assert_equal_b(1, value);       /* test equality as booleans */
 	cl_assert_equal_b(0, value);
 }
 
-void test_selftest_suite__ptr(void)
-{
-	void *p1 = (void *)0x1, *p2 = (void *)0x2;
-	cl_assert_equal_p(p1, p1); /* pointers to same object */
-	cl_assert_equal_p(p1, p2);
-}
-
-void test_selftest_suite__multiline_description(void)
+void test_combined__multiline_description(void)
 {
 	cl_must_pass_(-1, "description line 1\ndescription line 2");
 }
 
-void test_selftest_suite__null_string(void)
+void test_combined__null_string(void)
 {
 	const char *actual = NULL;
 	cl_assert_equal_s(actual, actual);
diff --git a/t/unit-tests/clar/test/selftest_suite/main.c b/t/unit-tests/clar/test/suites/main.c
similarity index 100%
rename from t/unit-tests/clar/test/selftest_suite/main.c
rename to t/unit-tests/clar/test/suites/main.c
diff --git a/t/unit-tests/clar/test/suites/pointer.c b/t/unit-tests/clar/test/suites/pointer.c
new file mode 100644
index 00000000000..20535b159e0
--- /dev/null
+++ b/t/unit-tests/clar/test/suites/pointer.c
@@ -0,0 +1,13 @@
+#include "clar.h"
+
+void test_pointer__equal(void)
+{
+	void *p1 = (void *)0x1;
+	cl_assert_equal_p(p1, p1);
+}
+
+void test_pointer__unequal(void)
+{
+	void *p1 = (void *)0x1, *p2 = (void *)0x2;
+	cl_assert_equal_p(p1, p2);
+}
diff --git a/t/unit-tests/clar/test/selftest_suite/resources/test/file b/t/unit-tests/clar/test/suites/resources/test/file
similarity index 100%
rename from t/unit-tests/clar/test/selftest_suite/resources/test/file
rename to t/unit-tests/clar/test/suites/resources/test/file

---
base-commit: 0e5211b3ff1912409264bc2ec5e5563157fa6f9a
change-id: 20250918-pks-clar-update-b90848d97d1a

