Received: from pfout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675A1A4E80
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354915; cv=none; b=ltFS3P4T5aEcoV3ubluIF+4mb55M+6dmxSbhG4qxnY9wMHfWeZTQJOkH/NLII8dYLgpBqZZLAgOV/lBD7EY/V59gCTElHxJlEDctIq7G0fie971cvlAaNWz3jIcyucxUP/uRfJj/N/XaE8RV0BNooj9dN2WFOTrFq+iAvVpFRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354915; c=relaxed/simple;
	bh=lNlgOPpzOgO/u4gCgguqjwoMja4/zM8s2KTFhTM+WIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvkgRzKFPyvbMYV1s61Q62oV0Q8/dfJITA4gcDO6Q/CaBuHNU0Mu4xVdqWNfWJ39TWdDPtdKAKicAjD2Fxk9ffrly5BHOLA9eHyUm6P8CYF8cpX0j9r7rXEpEPpb0Wekj/BPRa+N/gZM9oBuDLoOsH3Xux3qFJDDhXtSAvMiYcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p+CMYZu8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SOyROd3S; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p+CMYZu8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SOyROd3S"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FD731380409;
	Tue,  3 Sep 2024 05:15:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 03 Sep 2024 05:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354913; x=1725441313; bh=DqHh6f3TXV
	xvIVqbz3W52tttlLqyNi3TJ/82CGB8I+k=; b=p+CMYZu8xQzr2JEvDOkHL4w6ik
	ZDfUh3kJFuW7Zh8iLIZM/18F9x/DFu4U16ZpAd0ziDgWTTZ0JnpBE79Oo0sLjG5f
	6raEFxhYL0trMvjLROJ53+idTFdBPcEvRggvWyEoiWKxC05v/oF7ewsnMyxnVjPI
	qNcQMgr5pJyjjbZBrpyrY6XhfFHbnoxRAD/MjAlQscSNDyrxMJuiMCTkPImQ9yDn
	ea7GlXPWGfuUUYfxUDEAXRuINeoqPtYju0F9sQuNSEc4zbfCJNwEHCo5rlA+hXzj
	GzOjo/3q04Jk+BHKmm5UBu+I2lDRBRiUXdtYjvNR682EAq8pNkjW0E9KtutQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354913; x=1725441313; bh=DqHh6f3TXVxvIVqbz3W52tttlLqy
	Ni3TJ/82CGB8I+k=; b=SOyROd3StrwwsnxlWrO2vA6ArtabRAz1mCshcek2wi+o
	p+nQEXcd+5Rkz13HSjkhrAk/vahvx++BsWTpe3fqiQR2x2sfKWSzQma/MV2ggG0E
	9pUqg3bGmZgu9SctkP0T+ntElgFZQkKtd8AqrAelAK7Je4cr7kaWebmD4EnWxF8+
	8/eRL5vIE7dbwhJKns04gOyXAEk78UP97DAMYAcXPWOLpBjnMRqSSJh5HGdrmRD0
	X+p9mzxbLV5jlfxqQhbwLN+ncVfWPMVcmFJ58htOTyPNbTxXdkM9FEHsCyzJDqS1
	DKGwzc5A/peY5zNF1h5hqHsKwpyxcnlN/G7aKmQ+FQ==
X-ME-Sender: <xms:oNPWZr4cYIxSjQQv5JqjyHv38H78YBW5ApuLIelPx5MgPF0YXGT6Qg>
    <xme:oNPWZg4N3alTaa-jwWV2WQL3Qs7MF2AHJnQQE07cleyU9LOEJ4eyzD9o5UD8DfsX2
    U7ZOEbj82Mlu8XcvQ>
X-ME-Received: <xmr:oNPWZid7IREY3qU8r5CH7waKix7pLgJw9ItAzhZYKCuNp8a0R0jhE8idv_hKgn5dMyHIqPzPFqW2Q679Kmg__ko2JL1I02s55nZMd69nce_hZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoheprh
    hssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdr
    uhhkpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepvghthhhomhhsoh
    hnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:oNPWZsLlvf56YiCMG372jBh5huDzAxL43E5og3MLkEpHz2S8MF2IbA>
    <xmx:oNPWZvLjYlq3XiZ_r6ZVNozHkHDcH9G4IpJyZTvSZEkpwe_TXiEhAA>
    <xmx:oNPWZlwW5dToms9UGIHDJnkdWKfZQr-gKyNsnB2ATxyOR7wVdxsHuA>
    <xmx:oNPWZrK-Dk8XpgBGyV1B4kGuzS00umobzy4zBhRrPrmNELe039sMsw>
    <xmx:odPWZgX7_yKVG_4F0MtstDLFayqocNdjZAqcxsy8huzahCy4BfjKmf1K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:15:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 947220d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:15:04 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:15:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 12/14] t/unit-tests: convert strvec tests to use clar
Message-ID: <3c3b9eacdfb5c5410b1ce868869564bcd4256013.1725349234.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725349234.git.ps@pks.im>

Convert the strvec tests to use the new clar unit testing framework.
This is a first test balloon that demonstrates how the testing infra for
clar-based tests looks like.

The tests are part of the "t/unit-tests/bin/unit-tests" binary. When
running that binary with an injected error, it generates TAP output:

    # ./t/unit-tests/bin/unit-tests
    TAP version 13
    # start of suite 1: strvec
    ok 1 - strvec::init
    ok 2 - strvec::dynamic_init
    ok 3 - strvec::clear
    not ok 4 - strvec::push
        ---
        reason: |
          String mismatch: (&vec)->v[i] != expect[i]
          'foo' != 'fo' (at byte 2)
        at:
          file: 't/unit-tests/strvec.c'
          line: 48
          function: 'test_strvec__push'
        ---
    ok 5 - strvec::pushf
    ok 6 - strvec::pushl
    ok 7 - strvec::pushv
    ok 8 - strvec::replace_at_head
    ok 9 - strvec::replace_at_tail
    ok 10 - strvec::replace_in_between
    ok 11 - strvec::replace_with_substring
    ok 12 - strvec::remove_at_head
    ok 13 - strvec::remove_at_tail
    ok 14 - strvec::remove_in_between
    ok 15 - strvec::pop_empty_array
    ok 16 - strvec::pop_non_empty_array
    ok 17 - strvec::split_empty_string
    ok 18 - strvec::split_single_item
    ok 19 - strvec::split_multiple_items
    ok 20 - strvec::split_whitespace_only
    ok 21 - strvec::split_multiple_consecutive_whitespaces
    ok 22 - strvec::detach
    1..22

The binary also supports some parameters that allow us to run only a
subset of unit tests or alter the output:

    $ ./t/unit-tests/bin/unit-tests -h
    Usage: ./t/unit-tests/bin/unit-tests [options]

    Options:
      -sname        Run only the suite with `name` (can go to individual test name)
      -iname        Include the suite with `name`
      -xname        Exclude the suite with `name`
      -v            Increase verbosity (show suite names)
      -q            Only report tests that had an error
      -Q            Quit as soon as a test fails
      -t            Display results in tap format
      -l            Print suite names
      -r[filename]  Write summary file (to the optional filename)

Furthermore, running `make unit-tests` runs the binary along with all
the other unit tests we have.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                |   2 +-
 t/unit-tests/strvec.c   | 241 ++++++++++++++++++++++++++++++++++++++++
 t/unit-tests/t-strvec.c | 211 -----------------------------------
 3 files changed, 242 insertions(+), 212 deletions(-)
 create mode 100644 t/unit-tests/strvec.c
 delete mode 100644 t/unit-tests/t-strvec.c

diff --git a/Makefile b/Makefile
index e38146b5eb0..56ce6c00e44 100644
--- a/Makefile
+++ b/Makefile
@@ -1336,6 +1336,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
+UNIT_TESTS_SUITES += strvec
 UNIT_TESTS_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 UNIT_TESTS_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
 UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
@@ -1356,7 +1357,6 @@ UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-tree
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
-UNIT_TEST_PROGRAMS += t-strvec
 UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
diff --git a/t/unit-tests/strvec.c b/t/unit-tests/strvec.c
new file mode 100644
index 00000000000..bf4c0cb172e
--- /dev/null
+++ b/t/unit-tests/strvec.c
@@ -0,0 +1,241 @@
+#include "unit-test.h"
+#include "strbuf.h"
+#include "strvec.h"
+
+#define check_strvec(vec, ...) \
+	do { \
+		const char *expect[] = { __VA_ARGS__ }; \
+		size_t expect_len = ARRAY_SIZE(expect); \
+		cl_assert(expect_len > 0); \
+		cl_assert_equal_p(expect[expect_len - 1], NULL); \
+		cl_assert_equal_i((vec)->nr, expect_len - 1); \
+		cl_assert((vec)->nr <= (vec)->alloc); \
+		for (size_t i = 0; i < expect_len; i++) \
+			cl_assert_equal_s((vec)->v[i], expect[i]); \
+	} while (0)
+
+void test_strvec__init(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert_equal_i(vec.nr, 0);
+	cl_assert_equal_i(vec.alloc, 0);
+}
+
+void test_strvec__dynamic_init(void)
+{
+	struct strvec vec;
+
+	strvec_init(&vec);
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert_equal_i(vec.nr, 0);
+	cl_assert_equal_i(vec.alloc, 0);
+}
+
+void test_strvec__clear(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_push(&vec, "foo");
+	strvec_clear(&vec);
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert_equal_i(vec.nr, 0);
+	cl_assert_equal_i(vec.alloc, 0);
+}
+
+void test_strvec__push(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_push(&vec, "foo");
+	check_strvec(&vec, "foo", NULL);
+
+	strvec_push(&vec, "bar");
+	check_strvec(&vec, "foo", "bar", NULL);
+
+	strvec_clear(&vec);
+}
+
+void test_strvec__pushf(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_pushf(&vec, "foo: %d", 1);
+	check_strvec(&vec, "foo: 1", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__pushl(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	check_strvec(&vec, "foo", "bar", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__pushv(void)
+{
+	const char *strings[] = {
+		"foo", "bar", "baz", NULL,
+	};
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_pushv(&vec, strings);
+	check_strvec(&vec, "foo", "bar", "baz", NULL);
+
+	strvec_clear(&vec);
+}
+
+void test_strvec__replace_at_head(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_replace(&vec, 0, "replaced");
+	check_strvec(&vec, "replaced", "bar", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__replace_at_tail(void)
+{
+	struct strvec vec = STRVEC_INIT;
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_replace(&vec, 2, "replaced");
+	check_strvec(&vec, "foo", "bar", "replaced", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__replace_in_between(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_replace(&vec, 1, "replaced");
+	check_strvec(&vec, "foo", "replaced", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__replace_with_substring(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_pushl(&vec, "foo", NULL);
+	strvec_replace(&vec, 0, vec.v[0] + 1);
+	check_strvec(&vec, "oo", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__remove_at_head(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_remove(&vec, 0);
+	check_strvec(&vec, "bar", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__remove_at_tail(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_remove(&vec, 2);
+	check_strvec(&vec, "foo", "bar", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__remove_in_between(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_remove(&vec, 1);
+	check_strvec(&vec, "foo", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__pop_empty_array(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_pop(&vec);
+	check_strvec(&vec, NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__pop_non_empty_array(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
+	strvec_pop(&vec);
+	check_strvec(&vec, "foo", "bar", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__split_empty_string(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_split(&vec, "");
+	check_strvec(&vec, NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__split_single_item(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_split(&vec, "foo");
+	check_strvec(&vec, "foo", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__split_multiple_items(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_split(&vec, "foo bar baz");
+	check_strvec(&vec, "foo", "bar", "baz", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__split_whitespace_only(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_split(&vec, " \t\n");
+	check_strvec(&vec, NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__split_multiple_consecutive_whitespaces(void)
+{
+	struct strvec vec = STRVEC_INIT;
+
+	strvec_split(&vec, "foo\n\t bar");
+	check_strvec(&vec, "foo", "bar", NULL);
+	strvec_clear(&vec);
+}
+
+void test_strvec__detach(void)
+{
+	struct strvec vec = STRVEC_INIT;
+	const char **detached;
+
+	strvec_push(&vec, "foo");
+
+	detached = strvec_detach(&vec);
+	cl_assert_equal_s(detached[0], "foo");
+	cl_assert_equal_p(detached[1], NULL);
+
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert_equal_i(vec.nr, 0);
+	cl_assert_equal_i(vec.alloc, 0);
+
+	free((char *) detached[0]);
+	free(detached);
+}
diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
deleted file mode 100644
index c4bac8fc91b..00000000000
--- a/t/unit-tests/t-strvec.c
+++ /dev/null
@@ -1,211 +0,0 @@
-#include "test-lib.h"
-#include "strbuf.h"
-#include "strvec.h"
-
-#define check_strvec(vec, ...) \
-	do { \
-		const char *expect[] = { __VA_ARGS__ }; \
-		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
-		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
-		    check_uint((vec)->nr, ==, ARRAY_SIZE(expect) - 1) && \
-		    check_uint((vec)->nr, <=, (vec)->alloc)) { \
-			for (size_t i = 0; i < ARRAY_SIZE(expect); i++) { \
-				if (!check_str((vec)->v[i], expect[i])) { \
-					test_msg("      i: %"PRIuMAX, \
-						 (uintmax_t)i); \
-					break; \
-				} \
-			} \
-		} \
-	} while (0)
-
-int cmd_main(int argc, const char **argv)
-{
-	if_test ("static initialization") {
-		struct strvec vec = STRVEC_INIT;
-		check_pointer_eq(vec.v, empty_strvec);
-		check_uint(vec.nr, ==, 0);
-		check_uint(vec.alloc, ==, 0);
-	}
-
-	if_test ("dynamic initialization") {
-		struct strvec vec;
-		strvec_init(&vec);
-		check_pointer_eq(vec.v, empty_strvec);
-		check_uint(vec.nr, ==, 0);
-		check_uint(vec.alloc, ==, 0);
-	}
-
-	if_test ("clear") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_push(&vec, "foo");
-		strvec_clear(&vec);
-		check_pointer_eq(vec.v, empty_strvec);
-		check_uint(vec.nr, ==, 0);
-		check_uint(vec.alloc, ==, 0);
-	}
-
-	if_test ("push") {
-		struct strvec vec = STRVEC_INIT;
-
-		strvec_push(&vec, "foo");
-		check_strvec(&vec, "foo", NULL);
-
-		strvec_push(&vec, "bar");
-		check_strvec(&vec, "foo", "bar", NULL);
-
-		strvec_clear(&vec);
-	}
-
-	if_test ("pushf") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_pushf(&vec, "foo: %d", 1);
-		check_strvec(&vec, "foo: 1", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("pushl") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-		check_strvec(&vec, "foo", "bar", "baz", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("pushv") {
-		const char *strings[] = {
-			"foo", "bar", "baz", NULL,
-		};
-		struct strvec vec = STRVEC_INIT;
-
-		strvec_pushv(&vec, strings);
-		check_strvec(&vec, "foo", "bar", "baz", NULL);
-
-		strvec_clear(&vec);
-	}
-
-	if_test ("replace at head") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-		strvec_replace(&vec, 0, "replaced");
-		check_strvec(&vec, "replaced", "bar", "baz", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("replace at tail") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-		strvec_replace(&vec, 2, "replaced");
-		check_strvec(&vec, "foo", "bar", "replaced", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("replace in between") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-		strvec_replace(&vec, 1, "replaced");
-		check_strvec(&vec, "foo", "replaced", "baz", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("replace with substring") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_pushl(&vec, "foo", NULL);
-		strvec_replace(&vec, 0, vec.v[0] + 1);
-		check_strvec(&vec, "oo", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("remove at head") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-		strvec_remove(&vec, 0);
-		check_strvec(&vec, "bar", "baz", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("remove at tail") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-		strvec_remove(&vec, 2);
-		check_strvec(&vec, "foo", "bar", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("remove in between") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-		strvec_remove(&vec, 1);
-		check_strvec(&vec, "foo", "baz", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("pop with empty array") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_pop(&vec);
-		check_strvec(&vec, NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("pop with non-empty array") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_pushl(&vec, "foo", "bar", "baz", NULL);
-		strvec_pop(&vec);
-		check_strvec(&vec, "foo", "bar", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("split empty string") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_split(&vec, "");
-		check_strvec(&vec, NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("split single item") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_split(&vec, "foo");
-		check_strvec(&vec, "foo", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("split multiple items") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_split(&vec, "foo bar baz");
-		check_strvec(&vec, "foo", "bar", "baz", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("split whitespace only") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_split(&vec, " \t\n");
-		check_strvec(&vec, NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("split multiple consecutive whitespaces") {
-		struct strvec vec = STRVEC_INIT;
-		strvec_split(&vec, "foo\n\t bar");
-		check_strvec(&vec, "foo", "bar", NULL);
-		strvec_clear(&vec);
-	}
-
-	if_test ("detach") {
-		struct strvec vec = STRVEC_INIT;
-		const char **detached;
-
-		strvec_push(&vec, "foo");
-
-		detached = strvec_detach(&vec);
-		check_str(detached[0], "foo");
-		check_pointer_eq(detached[1], NULL);
-
-		check_pointer_eq(vec.v, empty_strvec);
-		check_uint(vec.nr, ==, 0);
-		check_uint(vec.alloc, ==, 0);
-
-		free((char *) detached[0]);
-		free(detached);
-	}
-
-	return test_done();
-}
-- 
2.46.0.421.g159f2d50e7.dirty

