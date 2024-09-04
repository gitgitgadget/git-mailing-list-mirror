Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9E1DC737
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459438; cv=none; b=tYvdef5sI7QSlCLtH6+Ij4jSLVAdhj4ch+zlbq/xrso4NSxBcLFpVRMGxGcKaUEzqWLOLqGo3acqzvkbo0MK7Au8n8ppsZ+rWmRSYCsleLfPTS9k2M+Q66MLCKVCzHP3t6qENOOkivvMJy+GYdYDAbyRd0N3v9RyCJpU538vzbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459438; c=relaxed/simple;
	bh=mLQ9lo5yJ2TxaEEUNOg20Iu43NFWtIQoE878zyo1HOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvWCP55aB6m3EfEMU/fUhb7Ur5Nl/wCjlmC0xG80gDRe2asX/lftnwKmFIHatXWqpOCSyy83hYrsEMvgdafjcBkFcwhbf9WMBkdJNSQWg/jEykVpEbW/KlPZbYH5txKgDnRnBSpkKnEqg0ZksD1m7DlDgQyORNyE45fBO4obe/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NJc4xHSY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hporbqUf; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NJc4xHSY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hporbqUf"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04B101140192;
	Wed,  4 Sep 2024 10:17:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 04 Sep 2024 10:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459435; x=1725545835; bh=Z5GC0Ekq3O
	6ieeChrH/VWUCoLTDNUySKbxFdjtEDlGg=; b=NJc4xHSYzdM7KYltYpXwoywD3g
	T64C6E1RMeUTJZVOMQwGCtyBn1jw3E04Y6rF9Z9Tfjr9uKswC5+MNO6tehYfR2rQ
	Avs4ERjoKyDwvEKGkiqbmqVGSdA8hV4CxsfkU0ha23JHEMm62hSjjZW4qBu59/+w
	EKJAupkY9oXukI9d08cbKhWjHUnE6gW/nBkXtUaCO5GmSL0KoC5yKCEE2Xs2PHtH
	AkHzphhAncP/DwfX1ZegsnMWCa4j7QEzuVYXV/zDon3+2pMpDtkT97UhxLO86E4A
	CsBiD5c5GxPQHQqIs5NtLFTrh6o7rNjEXb7OpZINYL2J5U5b2/VMwXn+ihmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459435; x=1725545835; bh=Z5GC0Ekq3O6ieeChrH/VWUCoLTDN
	UySKbxFdjtEDlGg=; b=hporbqUfmU02afFgD6KwQ71nzEInORiuhxdc7W1Wdoxb
	EBAfPv+LIeGsvIEEK0eFKSzN0Ma30vqAnv65PBWLQcEXmOLYImGWz7bi+8q71Icy
	yqlZPeqbD11/zp2qxUQCyeodcMKTtqWTwvu/v+KUiH9lrwk97UhLgzuFFLszUQqg
	zjnTwxSEGuuz4b9NKpGhMg4cxucl5SntOgZd13bQrQgDv57WKVlYOOKpJBoRGsAV
	dUe8NrErek029VxSIx4J1Z/WLZAvfFj0hpu4pKH4WqAfvAGuWA0lr/qrK9Kj4ndY
	+xm4fvEPt4CJVlf8WQU/aUQt52FityuSfZYB1ul3HA==
X-ME-Sender: <xms:62vYZjRm2X_r927QawtKmoK0zx1CDylGbNtnRdJqQ6sQmFVhj74h0g>
    <xme:62vYZkxYSVlPEo_YosoXN8oBMX3E4R0_cGlLfZ3Eue3aLuCqUp7q3hBvCboFRQxXI
    L7wUL6YGdfRabH_ag>
X-ME-Received: <xmr:62vYZo04_y5xriEFDQxxPN-S4gzQEwULX1s6gbHZ4uIuVQ2kNKTIk9WrE_VuLs8lhtoo8JQ13XBPOgKNG2H-CyVGYBbhumbUU_4Eovc3rtgK7zc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvggrughmoh
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgt
    phhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhssg
    gvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:62vYZjAuWfzqCTFH7GvIaDvwLIfvAYOAx5I1ilIxFWMomL_ZW77SfQ>
    <xmx:62vYZsiO-wFidOuo8edUvPBny-mAG269rRSaIU9qiZ2q4vMklNPIJw>
    <xmx:62vYZnoXqmucJBjU-tDPRz52v03LjmE0_W5lBccB6R5dxi1JGM5Smg>
    <xmx:62vYZngsmYuWEwAnyRXt1e1eMnx9KZRa9Ebt5gJG0oiKkM9rwl2tBg>
    <xmx:62vYZvM61s_kbsBgS6MNqsqJTfJfo3LDjR5GxSnjqq2fynSSpk1WiseU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:17:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 80df3ba0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:17:04 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:17:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 10/14] Makefile: wire up the clar unit testing framework
Message-ID: <9c74c5ae01989659c0347d2742f820d2161d274b.1725459142.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725459142.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725459142.git.ps@pks.im>

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

The test driver "unit-test.c" is an empty stub for now. It will get
implemented in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                     |  1 +
 Makefile                       | 36 +++++++++++++++++++++---
 t/Makefile                     |  1 +
 t/unit-tests/.gitignore        |  2 ++
 t/unit-tests/clar-generate.awk | 50 ++++++++++++++++++++++++++++++++++
 t/unit-tests/unit-test.c       |  6 ++++
 t/unit-tests/unit-test.h       |  3 ++
 7 files changed, 95 insertions(+), 4 deletions(-)
 create mode 100644 t/unit-tests/clar-generate.awk
 create mode 100644 t/unit-tests/unit-test.c
 create mode 100644 t/unit-tests/unit-test.h

diff --git a/.gitignore b/.gitignore
index 8caf3700c23..6687bd6db4c 100644
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
index 81a47b61327..e38146b5eb0 100644
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
@@ -2714,6 +2721,7 @@ OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
+OBJECTS += $(UNIT_TESTS_OBJS)
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3216,7 +3224,7 @@ endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
-all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS)
+all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
@@ -3648,7 +3656,7 @@ endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
-		$(UNIT_TEST_PROGS) $(MOFILES)
+		$(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG) $(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 	test -n "$(ARTIFACTS_DIRECTORY)"
@@ -3704,6 +3712,7 @@ cocciclean:
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build $(UNIT_TEST_BIN)
+	$(RM) GIT-TEST-SUITES
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
@@ -3863,7 +3872,26 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
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
index d2212de0b78..131ffd778fe 100644
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
index 5e56e040ec0..d0632ec7f9e 100644
--- a/t/unit-tests/.gitignore
+++ b/t/unit-tests/.gitignore
@@ -1 +1,3 @@
 /bin
+/clar.suite
+/clar-decls.h
diff --git a/t/unit-tests/clar-generate.awk b/t/unit-tests/clar-generate.awk
new file mode 100644
index 00000000000..ab71ce6c9fc
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
index 00000000000..3d12cde6dae
--- /dev/null
+++ b/t/unit-tests/unit-test.c
@@ -0,0 +1,6 @@
+#include "unit-test.h"
+
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
+{
+	return 0;
+}
diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
new file mode 100644
index 00000000000..66ec2387cc6
--- /dev/null
+++ b/t/unit-tests/unit-test.h
@@ -0,0 +1,3 @@
+#include "git-compat-util.h"
+#include "clar/clar.h"
+#include "clar-decls.h"
-- 
2.46.0.519.g2e7b89e038.dirty

