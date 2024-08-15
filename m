Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC41714D2
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720928; cv=none; b=c5AQOeeKLX3B0JXG0EVFJ1wvQUxLH3UmZBvWoGA2viTLMAd5PEWDAM23jn0bgomBCy1xGHuaWklxFhpF8ridAg/UvLtscwZh+sQB0ruJa+c0tl8M0WEzsI9d+clPPKAeFFtjw4oRR9wtGEPtfj6qP2XjlxyGNYONrz3ptBtKitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720928; c=relaxed/simple;
	bh=D3EU7QdOmvRo8RXDCBCpoAQ/EN5WGZ8Z7BFFJgRFLS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3vjkPLqFFjX1PUqucNx4Z3SKvZdkCMo6qVZjPnesHS7AyxqvQuQDeX/nHZmV4tyER19bwIa8RyXMR+sbkGZ6m3pOquLpbaYqI6LMVqeun07/R3PWW4RKJueYFMR421BjPxSNFxiCwErWW3qJV7r4uXk9Maa4ahu9WFQISckbNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NiEMGuIb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HJibPanV; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NiEMGuIb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJibPanV"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 020071151BC5;
	Thu, 15 Aug 2024 05:47:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Aug 2024 05:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723715273; x=1723801673; bh=Y46A0dtUB+
	Sx+PgT6Y21JQrzzuKWqM+2CGGlVmIJbQ8=; b=NiEMGuIbZbXWsBZfhgCrzBrP+P
	mZ1QqftGA8DZtmZtagQPPFEaZjE0dfC2bWcJeMk4mQ66J2aXqgYEpELi1pntDIaw
	J5+U4QmuwRgg57rbAZLo9IZAQTmkyjUBxI/Fkf6gXJSe0AwB0MSawxUDlo7MQ54z
	9RvF5/cqXPd42fY+Oxsn+5gTNXcQp7A7vRdBzC6erRHIcz4Y1+vyG6vnbEbO/vEs
	kRMSAxvRGtsIRHQi7p2V7p8b22HrXd7uMDJJGFNxYGqPPfn49RUX2l/vzvjOOpfo
	JHMgczq7g6nDtSIn6zYOFxrWaG+I03cmxB9FHIN7V04sMIkbS+cOWnW8dUUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723715273; x=1723801673; bh=Y46A0dtUB+Sx+PgT6Y21JQrzzuKW
	qM+2CGGlVmIJbQ8=; b=HJibPanV4OsAB1CxYn6KdEa87K5SEpsyOBt0f9advFLh
	RmKZ96rvw7MAnnfh3l/Z1JJ7z3Zeo0iGJMa39tXYC4OMsZzrYFbGtLvKeRwn20Rj
	uPk4t5rctPe8IrNjH4BhXMAbtTIvQmiLWHf8Va4T4ULQKuVsJX1s0HEi8CF5XQZv
	AF/0S+w/FVii3V0BL29NQBvVu3rM3b7WPbzWx8Wslk5xTFPBJXRg0W0tv4rBvnTb
	w3NnnsZYjDxEEisrXVt33zRew4objhT+gSTg6MYVJYSPraLxsDxz+MzxadoKrRoW
	AzHDCASDLpEqRSLh07MdqfMmMzPE13GKCe1GAGZogQ==
X-ME-Sender: <xms:yc69ZgGEfHduIL3jxf7qcPCgPSFHJgZ1RuWVgJFX4lUEycOXBAeRwQ>
    <xme:yc69ZpU2f5WA2iEwT7NBx_KE1K_dbQXgvOinGwFadetD7BHQbPptaj9Upc57ztxbX
    Qqdl6DzAcDUGr3t5g>
X-ME-Received: <xmr:yc69ZqJz8HCZ42RSy4-e-bG-ZY_2zVlj7p3nimtDiQ7AVyOlSi_WPD6EmXKCATAkh3FdQt5quuhExSvfYONNXZX4vfTrgsT7a5hPj4jMyLk03g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprh
    gtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthho
    pehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:yc69ZiE0gHjVrypv1JtervilKTlYLSbmDdT7N_p7PlUiPpFHa1ERmw>
    <xmx:yc69ZmWcG2YIH92WWy7a3NHRbBCCFJf1cDQHbq-n0ad3pwAl8QHVJQ>
    <xmx:yc69ZlPxRowMZmpJe9caObE0lJlrLhrCr-ToBd-WXrB9OXAXk5H8Hg>
    <xmx:yc69Zt3jJlxK9hbXIDZt8Mmp5v1ISVXAdalwQHbKMLom-QA4hmITUQ>
    <xmx:yc69ZqqIC-tDpdWLZ_TzQyFG5_B-ANs9066iJJ8Gjs3iiW2jAuduW4ZY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:47:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 451b4a24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:47:31 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:47:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v4 5/7] Makefile: wire up the clar unit testing framework
Message-ID: <5b8a64ae792c96be87ef65b26413ad5d150e0f0d.1723712012.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723712012.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723712012.git.ps@pks.im>

Wire up the clar unit testing framework by introducing a new
"unit-tests" executable. In contrast to the existing framework, this
will result in a single executable for all test suites. The ability to
pick specific tests to execute is retained via functionality built into
the clar itself.

Note that we need to be a bit careful about how we need to invalidate
our Makefile rules. While we obviously have to regenerate the clar suite
when our test suites change, we also have to invalidate it in case any
of the test suites gets removed. We do so by using our typical pattern
of creating a `GIT-TEST-SUITES` file that gets updated whenever the set
of test suites changes, so that we can easily depend on that file.

Another specialty is that we generate a "clar-decls.h" file. The test
functions are neither static, nor do they have external declarations.
This is because they are getting parsed via "generate.py", which then
creates the external generations that get populated into an array. These
declarations are only seen by the main function though.

The consequence is that we will get a bunch of "missing prototypes"
errors from our compiler for each of these test functions. To fix those
errors, we extract the `extern` declarations from "clar.suite" and put
them into a standalone header that then gets included by each of our
unit tests. This gets rid of compiler warnings for every function which
has been extracted by "generate.py". More importantly though, it does
_not_ get rid of warnings in case a function really isn't being used by
anything. Thus, it would cause a compiler error if a function name was
mistyped and thus not picked up by "generate.py".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                     |  1 +
 Makefile                       | 35 +++++++++++++++++++++---
 t/Makefile                     |  1 +
 t/unit-tests/.gitignore        |  2 ++
 t/unit-tests/clar-generate.awk | 50 ++++++++++++++++++++++++++++++++++
 t/unit-tests/unit-test.c       | 18 ++++++++++++
 t/unit-tests/unit-test.h       |  3 ++
 7 files changed, 106 insertions(+), 4 deletions(-)
 create mode 100644 t/unit-tests/clar-generate.awk
 create mode 100644 t/unit-tests/unit-test.c
 create mode 100644 t/unit-tests/unit-test.h

diff --git a/.gitignore b/.gitignore
index 8caf3700c2..6687bd6db4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,6 +9,7 @@
 /GIT-PYTHON-VARS
 /GIT-SCRIPT-DEFINES
 /GIT-SPATCH-DEFINES
+/GIT-TEST-SUITES
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
 /bin-wrappers/
diff --git a/Makefile b/Makefile
index 674b0ac4e1..1311bbbbed 100644
--- a/Makefile
+++ b/Makefile
@@ -1334,6 +1334,11 @@ THIRD_PARTY_SOURCES += sha1dc/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
+UNIT_TESTS_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
+UNIT_TESTS_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
+UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
+UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/unit-test.o
+
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-hash
@@ -2713,6 +2718,7 @@ OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
+OBJECTS += $(UNIT_TESTS_OBJS)
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3215,7 +3221,7 @@ endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
-all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS)
+all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
@@ -3279,6 +3285,7 @@ CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(LIB_H))
 HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
 HCC = $(HCO:hco=hcc)
 
+$(UNIT_TEST_DIR)/unit-test.hcc: $(UNIT_TEST_DIR)/unit-test.h $(UNIT_TEST_DIR)/clar-decls.h
 %.hcc: %.h
 	@echo '#include "git-compat-util.h"' >$@
 	@echo '#include "$<"' >>$@
@@ -3646,7 +3653,7 @@ endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
-		$(UNIT_TEST_PROGS) $(MOFILES)
+		$(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG) $(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 	test -n "$(ARTIFACTS_DIRECTORY)"
@@ -3702,6 +3709,7 @@ cocciclean:
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build $(UNIT_TEST_BIN)
+	$(RM) GIT-TEST-SUITES $(UNIT_TEST_DIR)/clar.suite $(UNIT_TEST_DIR)/clar-decls.h
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
@@ -3861,7 +3869,26 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
+GIT-TEST-SUITES: FORCE
+	@FLAGS='$(UNIT_TESTS_SUITES)'; \
+	    if test x"$$FLAGS" != x"`cat GIT-TEST-SUITES 2>/dev/null`" ; then \
+		echo >&2 "    * new test suites"; \
+		echo "$$FLAGS" >GIT-TEST-SUITES; \
+            fi
+
+$(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(UNIT_TESTS_SUITES)) GIT-TEST-SUITES
+	$(QUIET_GEN)for suite in $(UNIT_TESTS_SUITES); do \
+		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
+	done >$@
+$(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
+	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
+$(UNIT_TESTS_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
+$(UNIT_TESTS_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
+$(UNIT_TESTS_PROG): $(UNIT_TEST_DIR)/clar.suite $(UNIT_TESTS_OBJS) $(GITLIBS) GIT-LDFLAGS
+	$(call mkdir_p_parent_template)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+
 .PHONY: build-unit-tests unit-tests
-build-unit-tests: $(UNIT_TEST_PROGS)
-unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
+build-unit-tests: $(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG)
+unit-tests: $(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
diff --git a/t/Makefile b/t/Makefile
index d2212de0b7..131ffd778f 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -48,6 +48,7 @@ CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.tes
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
 UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
 UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
+UNIT_TEST_PROGRAMS += unit-tests/bin/unit-tests$(X)
 UNIT_TESTS = $(sort $(UNIT_TEST_PROGRAMS))
 UNIT_TESTS_NO_DIR = $(notdir $(UNIT_TESTS))
 
diff --git a/t/unit-tests/.gitignore b/t/unit-tests/.gitignore
index 5e56e040ec..d0632ec7f9 100644
--- a/t/unit-tests/.gitignore
+++ b/t/unit-tests/.gitignore
@@ -1 +1,3 @@
 /bin
+/clar.suite
+/clar-decls.h
diff --git a/t/unit-tests/clar-generate.awk b/t/unit-tests/clar-generate.awk
new file mode 100644
index 0000000000..ab71ce6c9f
--- /dev/null
+++ b/t/unit-tests/clar-generate.awk
@@ -0,0 +1,50 @@
+function add_suite(suite, initialize, cleanup, count) {
+       if (!suite) return
+       suite_count++
+       callback_count += count
+       suites = suites "    {\n"
+       suites = suites "        \"" suite "\",\n"
+       suites = suites "        " initialize ",\n"
+       suites = suites "        " cleanup ",\n"
+       suites = suites "        _clar_cb_" suite ", " count ", 1\n"
+       suites = suites "    },\n"
+}
+
+BEGIN {
+       suites = "static struct clar_suite _clar_suites[] = {\n"
+}
+
+{
+       print
+       name = $3; sub(/\(.*$/, "", name)
+       suite = name; sub(/^test_/, "", suite); sub(/__.*$/, "", suite)
+       short_name = name; sub(/^.*__/, "", short_name)
+       cb = "{ \"" short_name "\", &" name " }"
+       if (suite != prev_suite) {
+               add_suite(prev_suite, initialize, cleanup, count)
+               if (callbacks) callbacks = callbacks "};\n"
+               callbacks = callbacks "static const struct clar_func _clar_cb_" suite "[] = {\n"
+               initialize = "{ NULL, NULL }"
+               cleanup = "{ NULL, NULL }"
+               count = 0
+               prev_suite = suite
+       }
+       if (short_name == "initialize") {
+               initialize = cb
+       } else if (short_name == "cleanup") {
+               cleanup = cb
+       } else {
+               callbacks = callbacks "    " cb ",\n"
+               count++
+       }
+}
+
+END {
+       add_suite(suite, initialize, cleanup, count)
+       suites = suites "};"
+       if (callbacks) callbacks = callbacks "};"
+       print callbacks
+       print suites
+       print "static const size_t _clar_suite_count = " suite_count ";"
+       print "static const size_t _clar_callback_count = " callback_count ";"
+}
diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
new file mode 100644
index 0000000000..32a81299e9
--- /dev/null
+++ b/t/unit-tests/unit-test.c
@@ -0,0 +1,18 @@
+#include "unit-test.h"
+
+int cmd_main(int argc, const char **argv)
+{
+	const char **argv_copy;
+	int ret;
+
+	/* Append the "-t" flag such that the tests generate TAP output. */
+	ALLOC_ARRAY(argv_copy, argc + 2);
+	COPY_ARRAY(argv_copy, argv, argc);
+	argv_copy[argc++] = "-t";
+	argv_copy[argc] = NULL;
+
+	ret = clar_test(argc, (char **) argv_copy);
+
+	free(argv_copy);
+	return ret;
+}
diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
new file mode 100644
index 0000000000..66ec2387cc
--- /dev/null
+++ b/t/unit-tests/unit-test.h
@@ -0,0 +1,3 @@
+#include "git-compat-util.h"
+#include "clar/clar.h"
+#include "clar-decls.h"
-- 
2.46.0.46.g406f326d27.dirty

