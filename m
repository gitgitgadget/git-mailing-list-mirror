Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7242E85626
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793778; cv=none; b=VtvWiNLANNYnMogcnZKygEhsq6/oK7UQjgxXJAzEJyE+X76+AIM6OyhdBrVNmcQnOmQUjjYFXE10mh6bd8LSfVE7+H3gFoipphijBp9Rllaoy8ywUNV/xj1/Y6F/XZla8SmwSfLlRymHxsr9qU9Aj76iGFuxF6oolS7KNjdEm+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793778; c=relaxed/simple;
	bh=xE8DKZ0rCWBZxJVTXhjks5exztiInI1tyV0+VlyVAEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PygEj7ywD+XN+DCzV/ybbBuD/m7KD+JEbKpz69TJ09dH5+74+J7PC6TGCKTmd90HzQlLQQd8tDsakhUs4VldyTc0yengBgJrd9vJ40zpbjIUoA5pA82lAAI0Tu2+wr7jSq9hJDlM+Or0M0legGqLCQTfHF9UJrJ/RaPYb6mvuuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KDebtWcR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f+cUnksF; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KDebtWcR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f+cUnksF"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id CB1C0138CC97;
	Fri, 16 Aug 2024 03:04:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 16 Aug 2024 03:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723791898; x=1723878298; bh=jvJlG3IuzY
	YeMXFqQlMQFbflHQ76Batl6fhr85e9yw0=; b=KDebtWcRlN21cOIZYe58dECqbG
	IyWpKOJTxLU0QC/fGqLWpm8yYEsQStupOOUgbukbL9RbmceUkksZrMizNTdgiadb
	PvuLeCHbYPNb0V4YoWkK++rgjyVomWW40+ksWBLF6kEkAsvGk3vXgewLqVYTar99
	bZIUG/ZqtEK1nb3LFCodG07RiU34Za55nsR82KYSdO+dnsmuxOsmx2UqRpneKDRZ
	n4Qq4/l4h1Rz/ZAv9/TBni76V3lpl4IhYTfNb8Nd8n3UsNgJTkvuGkYl/bOG5FEF
	Bzk7l4t7brrUv7MVk16mkYTdOI385LTvLLpKsmAHyEnOwUeNM/79mNGisB5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723791898; x=1723878298; bh=jvJlG3IuzYYeMXFqQlMQFbflHQ76
	Batl6fhr85e9yw0=; b=f+cUnksFzZen0voLEgBAiQe+q7CKx1+igLrs81Ax47f4
	RGde1JFHIBZWvbagiH+FWMyrrHOsKvwW2pMS5jtOd5UgR7mC1W1QnN5vhTeX3b+Y
	hTiQqtesxCymcLo0AUFq2P8x+JzePydrgGGmbbx2LZGGyJdie4rZWTidY9GreMcJ
	86opu9/ncy1SqZzWtaf9llv1blynjBi7fSYzhYaceb5WIyHQP/Crn6GsbcvgfCHv
	cXjeeRS2Jlo3kjI6wcYG/Ye9US/8yWLpwJS+emxiPUhdvXhNIBUvvifePZJrmOw4
	ro72tpE2IjVfxlu2IYMK5kzejluXMmNRxaDJo6bLhg==
X-ME-Sender: <xms:Gvq-ZuQf2YqoKR80vi8CThz8cBRwRqWYSDEPO0mwhItgrklCuOvk3g>
    <xme:Gvq-ZjyIP5ex85_KdwmRz-xNjPdNGfsTFEPZNoDDzn5KjvsW1Sq8wWnQugmkv5_3f
    Pbke-FZrHVObGSXTA>
X-ME-Received: <xmr:Gvq-Zr1BIxHl3u50VZMjgSB4z38Utqufz15lyVg0DMKTL4X9ZMWfic5YTF1EgMAXrJWsgjTmFAzw3P5yfKxylrNVVJV5YKoIR3d0BSv9YEi3hPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:Gvq-ZqA3Mr4MKHCnau_Me1HdMmPeupVZXslPhOkQpdaz6qeASM376Q>
    <xmx:Gvq-ZngzH13r1kYrKGgjBcPjFB606UtxAWmDgetDyZ4Hku2ARxGtBA>
    <xmx:Gvq-ZmpWDbIUZ9MWeoyuLTtIVAnVTSVe1lQ49vJ8C-czXZc28RAX_g>
    <xmx:Gvq-ZqiYptObgALnair4is4niEgh7R7UrgXzDAmAKnkaLpSNFvZuEg>
    <xmx:Gvq-ZoUTyoElV89aX-yqsLe8Hwu80qLOjcfOV7smNYfGGLkGiq9TtX2_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 03:04:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 80744330 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 07:04:34 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:04:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v5 7/9] Makefile: wire up the clar unit testing framework
Message-ID: <05bcb5bef6c519f6955d046240ae729eeaae1726.1723791831.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723791831.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723791831.git.ps@pks.im>

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
 Makefile                       | 36 +++++++++++++++++++++---
 t/Makefile                     |  1 +
 t/unit-tests/.gitignore        |  2 ++
 t/unit-tests/clar-generate.awk | 50 ++++++++++++++++++++++++++++++++++
 t/unit-tests/unit-test.c       | 18 ++++++++++++
 t/unit-tests/unit-test.h       |  3 ++
 7 files changed, 107 insertions(+), 4 deletions(-)
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
index 377ea7e144..e6206ca8c7 100644
--- a/Makefile
+++ b/Makefile
@@ -914,6 +914,8 @@ REFTABLE_TEST_LIB = reftable/libreftable_test.a
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
 GENERATED_H += hook-list.h
+GENERATED_H += $(UNIT_TEST_DIR)/clar-decls.h
+GENERATED_H += $(UNIT_TEST_DIR)/clar.suite
 
 .PHONY: generated-hdrs
 generated-hdrs: $(GENERATED_H)
@@ -1334,6 +1336,11 @@ THIRD_PARTY_SOURCES += sha1dc/%
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
@@ -2713,6 +2720,7 @@ OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
+OBJECTS += $(UNIT_TESTS_OBJS)
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3215,7 +3223,7 @@ endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
-all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS)
+all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
@@ -3647,7 +3655,7 @@ endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
-		$(UNIT_TEST_PROGS) $(MOFILES)
+		$(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG) $(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 	test -n "$(ARTIFACTS_DIRECTORY)"
@@ -3703,6 +3711,7 @@ cocciclean:
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build $(UNIT_TEST_BIN)
+	$(RM) GIT-TEST-SUITES
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
@@ -3862,7 +3871,26 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
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

