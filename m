Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9831D0B91
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882161; cv=none; b=rnWhUvzj8VPiTtf4XURk55TrtUQDakNnFl0+ZFQmFuvi6fsj0U3JTAsvMmHvTimZWTClX3mGDe0F6lDuopKqYZJ4cHqvKTU1QrL6Fuv119yypmbq4fH1Bz8DS+ynbWL5u0I7FG1cUWZd31QhtwUHDd3ltTwGrfvcKDxfynpXFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882161; c=relaxed/simple;
	bh=T/zDBYhz5WlqQjrpWIYpkCovFzoC2pKTyNlXDWqNj2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK8xSl85+uAktB7m+5Fz73Aleo7mK4OM13nsTCiTcG8dNXN8ExVB2OkF7EwuHpROcaBJwcMfpNvGfoxqx8ttZLxDnd9hvbQPkcQfPshcM+yGOsP4NEZMdYr56Ccfq16zJCuZEV8p5/FLmwEtLiM214MNxNo1Dn7MeVxTgp7UWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dIk/PgL0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WlAux7aX; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dIk/PgL0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WlAux7aX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C7F3138017B;
	Wed,  2 Oct 2024 11:15:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 11:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882158; x=1727968558; bh=BvIKHNdagj
	WiHhgXFdZpuqsgOVmuSgyVY43RBmQMDKU=; b=dIk/PgL0YPjYgePnvdkCCgPOq+
	SvQBRGL5Z8QFkgxmIR5BxB5bi5/M/fWEtflTUJiqdfS+RH0nP1SCes+t4hSx4Fu2
	TPbI3Nj3PhzTw1Fd+ofTBfAQ0Qr/0qvAz7C4gZCQ5v5vjuoTB3KEyLb7J6Pi80/F
	1OZxR9CPg2KLfsP8V4suVJWY3dvgT1yRundgU0VCi7nvW+kZ/UXm747uSzErKB+5
	wtZlWiEWPuu2wjt4w74gmaoamgNHCPTyoC+jMtaG/W/d7y1cIWO3uW601s1oRlur
	By5z/AZYh6qWwEvevSNIeHLfKAyR76DC92Mn1UT8BimHiDfCHZSwfLeCUJwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882158; x=1727968558; bh=BvIKHNdagjWiHhgXFdZpuqsgOVmu
	SgyVY43RBmQMDKU=; b=WlAux7aXOOcm7vvRYnv/O+lQDYinNPPB0hST+WTbyDvS
	/m+e7rgd54IJfsBJKbCshEsJD3ZX3PEUiX9vf5hBXC3X6FlgCyXjiTJqp9cmW3EL
	Bo7dbLXM2BLKISB4IfRDBun1wl2bMJGjRDwFD9A8uOyshKmtO+U+1YnAnOhEi9Fg
	bNSsCTSvl/wgwdozw7v6iK8oecw+EQFtjEkRn+Pmg2o7ft1me6jaxzLGbQBwAZj3
	1kQEOF+lwOkvz3jqpuQeU6+ewGib6JmyDcFyYhFwK/PpZ7K+SEfMlK2GD8gG5YzN
	aMOMhL0fZC4mCDpClITo33t+oR9qp0Gwn6RUAPyZ1Q==
X-ME-Sender: <xms:rmP9ZrV6C8VNQbQsrDVyD3CiQJPD2oy14VKNgJgTzGFSKKLZp8EO8Q>
    <xme:rmP9Zjn585IxYfRReGEOKlw6WvpvyUFJVPXfaugh2uo-wxcaGIJJwwaASqUscExbA
    mIOkjaKlTVs_hYfnw>
X-ME-Received: <xmr:rmP9Znartuli-uCf-_ewSLty3iLJFekheUXmWiI58OC_kgNSyRZo-EbhjVqwnEpNSCseUBU7Imt9SWYj7mCbeZHNMV_opaPq9C1rnIsv2CpnE62D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:rmP9ZmVxfkojWDN98gTqT7Ql4jrtiHCYyFOZ4WQD-VdzgQtWNhrG_g>
    <xmx:rmP9ZlnKFq3CzD2wE66BGZoGbfBwGQwzhcrZMRg1XtzTii8DBsMViw>
    <xmx:rmP9Zje6cmVLB5_-6YldoJfT_bTox5jOrPCexv9s2ufL7ekHafmgYw>
    <xmx:rmP9ZvFEeBSruXX-_OuWzhJVcKGfZL6Lldt-D5SaGqROZg6ZYiz2TQ>
    <xmx:rmP9ZqxpRbpnaJB1w8I1oLXbWO8vk06lFYTx8sUpeUM3LMQHFIBmqKIC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:15:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 132c2b61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:15:06 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:15:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 06/21] t/unit-tests: update clar unit test framework
Message-ID: <a0eff39583998d6298acd9c70e5057d4b7a89db4.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

Update clar unit test framework to 67e689a (Merge pull request #103 from
pks-t/pks-editorconfig, 2024-09-20).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/.editorconfig            |  13 +++
 t/unit-tests/clar/.github/workflows/ci.yml |  20 +++-
 t/unit-tests/clar/.gitignore               |   1 +
 t/unit-tests/clar/CMakeLists.txt           |  28 ++++++
 t/unit-tests/clar/clar.c                   | 102 +++++++++++----------
 t/unit-tests/clar/clar/print.h             |  11 ++-
 t/unit-tests/clar/clar/sandbox.h           |  17 ++--
 t/unit-tests/clar/clar/summary.h           |  14 +--
 t/unit-tests/clar/test/.gitignore          |   4 -
 t/unit-tests/clar/test/CMakeLists.txt      |  41 +++++++++
 t/unit-tests/clar/test/Makefile            |  39 --------
 11 files changed, 172 insertions(+), 118 deletions(-)
 create mode 100644 t/unit-tests/clar/.editorconfig
 create mode 100644 t/unit-tests/clar/.gitignore
 create mode 100644 t/unit-tests/clar/CMakeLists.txt
 delete mode 100644 t/unit-tests/clar/test/.gitignore
 create mode 100644 t/unit-tests/clar/test/CMakeLists.txt
 delete mode 100644 t/unit-tests/clar/test/Makefile

diff --git a/t/unit-tests/clar/.editorconfig b/t/unit-tests/clar/.editorconfig
new file mode 100644
index 0000000000..aa343a4288
--- /dev/null
+++ b/t/unit-tests/clar/.editorconfig
@@ -0,0 +1,13 @@
+root = true
+
+[*]
+charset = utf-8
+insert_final_newline = true
+
+[*.{c,h}]
+indent_style = tab
+tab_width = 8
+
+[CMakeLists.txt]
+indent_style = tab
+tab_width = 8
diff --git a/t/unit-tests/clar/.github/workflows/ci.yml b/t/unit-tests/clar/.github/workflows/ci.yml
index b1ac2de460..0065843d17 100644
--- a/t/unit-tests/clar/.github/workflows/ci.yml
+++ b/t/unit-tests/clar/.github/workflows/ci.yml
@@ -10,14 +10,26 @@ jobs:
   build:
     strategy:
       matrix:
-        os: [ ubuntu-latest, macos-latest ]
+        platform:
+          - os: ubuntu-latest
+            generator: Unix Makefiles
+          - os: macos-latest
+            generator: Unix Makefiles
+          - os: windows-latest
+            generator: Visual Studio 17 2022
+          - os: windows-latest
+            generator: MSYS Makefiles
+          - os: windows-latest
+            generator: MinGW Makefiles
 
-    runs-on: ${{ matrix.os }}
+    runs-on: ${{ matrix.platform.os }}
 
     steps:
     - name: Check out
       uses: actions/checkout@v2
     - name: Build
       run: |
-        cd test
-        make
+        mkdir build
+        cd build
+        cmake .. -G "${{matrix.platform.generator}}"
+        cmake --build .
diff --git a/t/unit-tests/clar/.gitignore b/t/unit-tests/clar/.gitignore
new file mode 100644
index 0000000000..84c048a73c
--- /dev/null
+++ b/t/unit-tests/clar/.gitignore
@@ -0,0 +1 @@
+/build/
diff --git a/t/unit-tests/clar/CMakeLists.txt b/t/unit-tests/clar/CMakeLists.txt
new file mode 100644
index 0000000000..12d4af114f
--- /dev/null
+++ b/t/unit-tests/clar/CMakeLists.txt
@@ -0,0 +1,28 @@
+cmake_minimum_required(VERSION 3.16..3.29)
+
+project(clar LANGUAGES C)
+
+option(BUILD_TESTS "Build test executable" ON)
+
+add_library(clar INTERFACE)
+target_sources(clar INTERFACE
+	clar.c
+	clar.h
+	clar/fixtures.h
+	clar/fs.h
+	clar/print.h
+	clar/sandbox.h
+	clar/summary.h
+)
+set_target_properties(clar PROPERTIES
+	C_STANDARD 90
+	C_STANDARD_REQUIRED ON
+	C_EXTENSIONS OFF
+)
+
+if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
+	include(CTest)
+	if(BUILD_TESTING)
+		add_subdirectory(test)
+	endif()
+endif()
diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index cef0f023c2..f463ee823a 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -4,7 +4,8 @@
  * This file is part of clar, distributed under the ISC license.
  * For full terms see the included COPYING file.
  */
-#include <assert.h>
+
+#include <errno.h>
 #include <setjmp.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -13,6 +14,7 @@
 #include <stdarg.h>
 #include <wchar.h>
 #include <time.h>
+#include <inttypes.h>
 
 /* required for sandboxing */
 #include <sys/types.h>
@@ -61,13 +63,6 @@
 #		define p_snprintf snprintf
 #	endif
 
-#	ifndef PRIuZ
-#		define PRIuZ "Iu"
-#	endif
-#	ifndef PRIxZ
-#		define PRIxZ "Ix"
-#	endif
-
 #	if defined(_MSC_VER) || (defined(__MINGW32__) && !defined(__MINGW64_VERSION_MAJOR))
 	typedef struct stat STAT_T;
 #	else
@@ -78,12 +73,6 @@
 #	include <unistd.h>
 #	define _MAIN_CC
 #	define p_snprintf snprintf
-#	ifndef PRIuZ
-#		define PRIuZ "zu"
-#	endif
-#	ifndef PRIxZ
-#		define PRIxZ "zx"
-#	endif
 	typedef struct stat STAT_T;
 #endif
 
@@ -102,7 +91,7 @@ fixture_path(const char *base, const char *fixture_name);
 struct clar_error {
 	const char *file;
 	const char *function;
-	size_t line_number;
+	uintmax_t line_number;
 	const char *error_msg;
 	char *description;
 
@@ -195,11 +184,12 @@ static void clar_print_shutdown(int test_count, int suite_count, int error_count
 static void clar_print_error(int num, const struct clar_report *report, const struct clar_error *error);
 static void clar_print_ontest(const char *suite_name, const char *test_name, int test_number, enum cl_test_status failed);
 static void clar_print_onsuite(const char *suite_name, int suite_index);
+static void clar_print_onabortv(const char *msg, va_list argp);
 static void clar_print_onabort(const char *msg, ...);
 
 /* From clar_sandbox.c */
 static void clar_unsandbox(void);
-static int clar_sandbox(void);
+static void clar_sandbox(void);
 
 /* From summary.h */
 static struct clar_summary *clar_summary_init(const char *filename);
@@ -218,6 +208,15 @@ static int clar_summary_shutdown(struct clar_summary *fp);
 							   _clar.trace_payload);					\
 	} while (0)
 
+static void clar_abort(const char *msg, ...)
+{
+	va_list argp;
+	va_start(argp, msg);
+	clar_print_onabortv(msg, argp);
+	va_end(argp);
+	exit(-1);
+}
+
 void cl_trace_register(cl_trace_cb *cb, void *payload)
 {
 	_clar.pfn_trace_cb = cb;
@@ -271,9 +270,7 @@ static double clar_time_diff(clar_time *start, clar_time *end)
 
 static void clar_time_now(clar_time *out)
 {
-	struct timezone tz;
-
-	gettimeofday(out, &tz);
+	gettimeofday(out, NULL);
 }
 
 static double clar_time_diff(clar_time *start, clar_time *end)
@@ -386,7 +383,8 @@ clar_run_suite(const struct clar_suite *suite, const char *filter)
 
 		_clar.active_test = test[i].name;
 
-		report = calloc(1, sizeof(struct clar_report));
+		if ((report = calloc(1, sizeof(*report))) == NULL)
+			clar_abort("Failed to allocate report.\n");
 		report->suite = _clar.active_suite;
 		report->test = _clar.active_test;
 		report->test_number = _clar.tests_ran;
@@ -479,9 +477,10 @@ clar_parse_args(int argc, char **argv)
 
 					switch (action) {
 					case 's': {
-						struct clar_explicit *explicit =
-							calloc(1, sizeof(struct clar_explicit));
-						assert(explicit);
+						struct clar_explicit *explicit;
+
+						if ((explicit = calloc(1, sizeof(*explicit))) == NULL)
+							clar_abort("Failed to allocate explicit test.\n");
 
 						explicit->suite_idx = j;
 						explicit->filter = argument;
@@ -505,10 +504,8 @@ clar_parse_args(int argc, char **argv)
 				}
 			}
 
-			if (!found) {
-				clar_print_onabort("No suite matching '%s' found.\n", argument);
-				exit(-1);
-			}
+			if (!found)
+				clar_abort("No suite matching '%s' found.\n", argument);
 			break;
 		}
 
@@ -540,11 +537,17 @@ clar_parse_args(int argc, char **argv)
 		case 'r':
 			_clar.write_summary = 1;
 			free(_clar.summary_filename);
-			_clar.summary_filename = *(argument + 2) ? strdup(argument + 2) : NULL;
+			if (*(argument + 2)) {
+				if ((_clar.summary_filename = strdup(argument + 2)) == NULL)
+					clar_abort("Failed to allocate summary filename.\n");
+			} else {
+				_clar.summary_filename = NULL;
+			}
 			break;
 
 		default:
-			assert(!"Unexpected commandline argument!");
+			clar_abort("Unexpected commandline argument '%s'.\n",
+				   argument[1]);
 		}
 	}
 }
@@ -566,22 +569,18 @@ clar_test_init(int argc, char **argv)
 	if (!_clar.summary_filename &&
 	    (summary_env = getenv("CLAR_SUMMARY")) != NULL) {
 		_clar.write_summary = 1;
-		_clar.summary_filename = strdup(summary_env);
+		if ((_clar.summary_filename = strdup(summary_env)) == NULL)
+			clar_abort("Failed to allocate summary filename.\n");
 	}
 
 	if (_clar.write_summary && !_clar.summary_filename)
-		_clar.summary_filename = strdup("summary.xml");
+		if ((_clar.summary_filename = strdup("summary.xml")) == NULL)
+			clar_abort("Failed to allocate summary filename.\n");
 
-	if (_clar.write_summary &&
-	    !(_clar.summary = clar_summary_init(_clar.summary_filename))) {
-		clar_print_onabort("Failed to open the summary file\n");
-		exit(-1);
-	}
+	if (_clar.write_summary)
+	    _clar.summary = clar_summary_init(_clar.summary_filename);
 
-	if (clar_sandbox() < 0) {
-		clar_print_onabort("Failed to sandbox the test runner.\n");
-		exit(-1);
-	}
+	clar_sandbox();
 }
 
 int
@@ -615,10 +614,9 @@ clar_test_shutdown(void)
 
 	clar_unsandbox();
 
-	if (_clar.write_summary && clar_summary_shutdown(_clar.summary) < 0) {
-		clar_print_onabort("Failed to write the summary file\n");
-		exit(-1);
-	}
+	if (_clar.write_summary && clar_summary_shutdown(_clar.summary) < 0)
+		clar_abort("Failed to write the summary file '%s: %s.\n",
+			   _clar.summary_filename, strerror(errno));
 
 	for (explicit = _clar.explicit; explicit; explicit = explicit_next) {
 		explicit_next = explicit->next;
@@ -649,7 +647,7 @@ static void abort_test(void)
 {
 	if (!_clar.trampoline_enabled) {
 		clar_print_onabort(
-				"Fatal error: a cleanup method raised an exception.");
+				"Fatal error: a cleanup method raised an exception.\n");
 		clar_report_errors(_clar.last_report);
 		exit(-1);
 	}
@@ -673,7 +671,10 @@ void clar__fail(
 	const char *description,
 	int should_abort)
 {
-	struct clar_error *error = calloc(1, sizeof(struct clar_error));
+	struct clar_error *error;
+
+	if ((error = calloc(1, sizeof(*error))) == NULL)
+		clar_abort("Failed to allocate error.\n");
 
 	if (_clar.last_report->errors == NULL)
 		_clar.last_report->errors = error;
@@ -688,8 +689,9 @@ void clar__fail(
 	error->line_number = line;
 	error->error_msg = error_msg;
 
-	if (description != NULL)
-		error->description = strdup(description);
+	if (description != NULL &&
+	    (error->description = strdup(description)) == NULL)
+		clar_abort("Failed to allocate description.\n");
 
 	_clar.total_errors++;
 	_clar.last_report->status = CL_TEST_FAILURE;
@@ -798,8 +800,8 @@ void clar__assert_equal(
 			}
 		}
 	}
-	else if (!strcmp("%"PRIuZ, fmt) || !strcmp("%"PRIxZ, fmt)) {
-		size_t sz1 = va_arg(args, size_t), sz2 = va_arg(args, size_t);
+	else if (!strcmp("%"PRIuMAX, fmt) || !strcmp("%"PRIxMAX, fmt)) {
+		uintmax_t sz1 = va_arg(args, uintmax_t), sz2 = va_arg(args, uintmax_t);
 		is_equal = (sz1 == sz2);
 		if (!is_equal) {
 			int offset = p_snprintf(buf, sizeof(buf), fmt, sz1);
diff --git a/t/unit-tests/clar/clar/print.h b/t/unit-tests/clar/clar/print.h
index c17e2f693b..69d0ee967e 100644
--- a/t/unit-tests/clar/clar/print.h
+++ b/t/unit-tests/clar/clar/print.h
@@ -21,7 +21,7 @@ static void clar_print_clap_error(int num, const struct clar_report *report, con
 {
 	printf("  %d) Failure:\n", num);
 
-	printf("%s::%s [%s:%"PRIuZ"]\n",
+	printf("%s::%s [%s:%"PRIuMAX"]\n",
 		report->suite,
 		report->test,
 		error->file,
@@ -136,7 +136,7 @@ static void clar_print_tap_ontest(const char *suite_name, const char *test_name,
 
 		printf("    at:\n");
 		printf("      file: '"); print_escaped(error->file); printf("'\n");
-		printf("      line: %" PRIuZ "\n", error->line_number);
+		printf("      line: %" PRIuMAX "\n", error->line_number);
 		printf("      function: '%s'\n", error->function);
 		printf("    ---\n");
 
@@ -202,10 +202,15 @@ static void clar_print_onsuite(const char *suite_name, int suite_index)
 	PRINT(onsuite, suite_name, suite_index);
 }
 
+static void clar_print_onabortv(const char *msg, va_list argp)
+{
+	PRINT(onabort, msg, argp);
+}
+
 static void clar_print_onabort(const char *msg, ...)
 {
 	va_list argp;
 	va_start(argp, msg);
-	PRINT(onabort, msg, argp);
+	clar_print_onabortv(msg, argp);
 	va_end(argp);
 }
diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sandbox.h
index e25057b7c4..681a1f80f1 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -122,14 +122,14 @@ static int build_sandbox_path(void)
 
 	if (mkdir(_clar_path, 0700) != 0)
 		return -1;
-#elif defined(__TANDEM)
-	if (mktemp(_clar_path) == NULL)
+#elif defined(_WIN32)
+	if (_mktemp_s(_clar_path, sizeof(_clar_path)) != 0)
 		return -1;
 
 	if (mkdir(_clar_path, 0700) != 0)
 		return -1;
-#elif defined(_WIN32)
-	if (_mktemp_s(_clar_path, sizeof(_clar_path)) != 0)
+#elif defined(__TANDEM)
+	if (mktemp(_clar_path) == NULL)
 		return -1;
 
 	if (mkdir(_clar_path, 0700) != 0)
@@ -142,15 +142,14 @@ static int build_sandbox_path(void)
 	return 0;
 }
 
-static int clar_sandbox(void)
+static void clar_sandbox(void)
 {
 	if (_clar_path[0] == '\0' && build_sandbox_path() < 0)
-		return -1;
+		clar_abort("Failed to build sandbox path.\n");
 
 	if (chdir(_clar_path) != 0)
-		return -1;
-
-	return 0;
+		clar_abort("Failed to change into sandbox directory '%s': %s.\n",
+			   _clar_path, strerror(errno));
 }
 
 const char *clar_sandbox_path(void)
diff --git a/t/unit-tests/clar/clar/summary.h b/t/unit-tests/clar/clar/summary.h
index 4dd352e28b..0d0b646fe7 100644
--- a/t/unit-tests/clar/clar/summary.h
+++ b/t/unit-tests/clar/clar/summary.h
@@ -66,16 +66,12 @@ struct clar_summary *clar_summary_init(const char *filename)
 	struct clar_summary *summary;
 	FILE *fp;
 
-	if ((fp = fopen(filename, "w")) == NULL) {
-		perror("fopen");
-		return NULL;
-	}
+	if ((fp = fopen(filename, "w")) == NULL)
+		clar_abort("Failed to open the summary file '%s': %s.\n",
+			   filename, strerror(errno));
 
-	if ((summary = malloc(sizeof(struct clar_summary))) == NULL) {
-		perror("malloc");
-		fclose(fp);
-		return NULL;
-	}
+	if ((summary = malloc(sizeof(struct clar_summary))) == NULL)
+		clar_abort("Failed to allocate summary.\n");
 
 	summary->filename = filename;
 	summary->fp = fp;
diff --git a/t/unit-tests/clar/test/.gitignore b/t/unit-tests/clar/test/.gitignore
deleted file mode 100644
index a477d0c40c..0000000000
--- a/t/unit-tests/clar/test/.gitignore
+++ /dev/null
@@ -1,4 +0,0 @@
-clar.suite
-.clarcache
-clar_test
-*.o
diff --git a/t/unit-tests/clar/test/CMakeLists.txt b/t/unit-tests/clar/test/CMakeLists.txt
new file mode 100644
index 0000000000..4c9012d061
--- /dev/null
+++ b/t/unit-tests/clar/test/CMakeLists.txt
@@ -0,0 +1,41 @@
+find_package(Python COMPONENTS Interpreter REQUIRED)
+
+add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
+	COMMAND "${Python_EXECUTABLE}" "${CMAKE_SOURCE_DIR}/generate.py" --output "${CMAKE_CURRENT_BINARY_DIR}"
+	DEPENDS main.c sample.c clar_test.h
+	WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
+)
+
+add_executable(clar_test)
+set_target_properties(clar_test PROPERTIES
+	C_STANDARD 90
+	C_STANDARD_REQUIRED ON
+	C_EXTENSIONS OFF
+)
+
+# MSVC generates all kinds of warnings. We may want to fix these in the future
+# and then unconditionally treat warnings as errors.
+if(NOT MSVC)
+	set_target_properties(clar_test PROPERTIES
+		COMPILE_WARNING_AS_ERROR ON
+	)
+endif()
+
+target_sources(clar_test PRIVATE
+	main.c
+	sample.c
+	"${CMAKE_CURRENT_BINARY_DIR}/clar.suite"
+)
+target_compile_definitions(clar_test PRIVATE
+	CLAR_FIXTURE_PATH="${CMAKE_CURRENT_SOURCE_DIR}/resources/"
+	_DARWIN_C_SOURCE
+	_POSIX_C_SOURCE=200809L
+)
+target_compile_options(clar_test PRIVATE
+	$<IF:$<CXX_COMPILER_ID:MSVC>,/W4,-Wall>
+)
+target_include_directories(clar_test PRIVATE
+	"${CMAKE_SOURCE_DIR}"
+	"${CMAKE_CURRENT_BINARY_DIR}"
+)
+target_link_libraries(clar_test clar)
diff --git a/t/unit-tests/clar/test/Makefile b/t/unit-tests/clar/test/Makefile
deleted file mode 100644
index 93c6b2ad32..0000000000
--- a/t/unit-tests/clar/test/Makefile
+++ /dev/null
@@ -1,39 +0,0 @@
-#
-# Copyright (c) Vicent Marti. All rights reserved.
-#
-# This file is part of clar, distributed under the ISC license.
-# For full terms see the included COPYING file.
-#
-
-#
-# Set up the path to the clar sources and to the fixtures directory
-#
-# The fixture path needs to be an absolute path so it can be used
-# even after we have chdir'ed into the test directory while testing.
-#
-CURRENT_MAKEFILE  := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
-TEST_DIRECTORY    := $(abspath $(dir $(CURRENT_MAKEFILE)))
-CLAR_PATH         := $(dir $(TEST_DIRECTORY))
-CLAR_FIXTURE_PATH := $(TEST_DIRECTORY)/resources/
-
-CFLAGS=-g -I.. -I. -Wall -DCLAR_FIXTURE_PATH=\"$(CLAR_FIXTURE_PATH)\"
-
-.PHONY: clean
-
-# list the objects that go into our test
-objects = main.o sample.o
-
-# build the test executable itself
-clar_test: $(objects) clar_test.h clar.suite $(CLAR_PATH)clar.c
-	$(CC) $(CFLAGS) -o $@ "$(CLAR_PATH)clar.c" $(objects)
-
-# test object files depend on clar macros
-$(objects) : $(CLAR_PATH)clar.h
-
-# build the clar.suite file of test metadata
-clar.suite:
-	python "$(CLAR_PATH)generate.py" .
-
-# remove all generated files
-clean:
-	$(RM) -rf *.o clar.suite .clarcache clar_test clar_test.dSYM
-- 
2.47.0.rc0.dirty

