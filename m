Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7981083CC7
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793775; cv=none; b=BhZx9BthX4mLKaTliCRZb+XwuEto2RV/ii9sT+P6ZrHGuohg83aVqbs4KrKb+0uVoVE7REO+ldpETuUZlqZIjIn9Kmp5KCe7qpnz5g9LTpsUDWWvrKXfYsE38s6uSgitn6dZFtFAbOlyqkXthasUN1B+sLUx1qeyRokMNIS2Dj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793775; c=relaxed/simple;
	bh=Z3fKGZA5E8F3gc1BBkTdEmtxQ60iOsy78HbOADHs7D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHdEcl8mFB4Qw9GPlIU97nGJrEvmRu8uMtpFzJqGdV1H6QESg7hzaQNnErR0QVIrktk/HeQY+pmjLueCC+mxJlZ1nxZllL1xdJuP3JFa0QAq9F0wklUkzv7iSn4KjnCcWfwsnmuQGG4rzb4DDg8dpjg1D3PqxGOdRconHOPLoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e4QpYYBj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RMt9M3fE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e4QpYYBj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RMt9M3fE"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id B1E1A138AEDD;
	Fri, 16 Aug 2024 03:05:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 16 Aug 2024 03:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723791901; x=1723878301; bh=mnGnUMRcIq
	5VjbnuarpRbjeaFKUN7vS+1kG0AOBqqa8=; b=e4QpYYBjPXamjZpyCYjJggYfHE
	5OedHA+Cqla911C5NygYbLhnBh87R5b+gr01WE3/aFgTG6wk/6uh2k7TCOwMic6T
	y0jBwlblavMPnWeq49QsjNjZQFUFFyxKSBsgC2IQQYjaDGId4nhrWrfsOqZz7ep/
	qu3MZ/jMYtjkMiDpqvffRLE2DeAeWLuziFluQCEMZaBP468q7hMUptOXM1ArVXoC
	ghe9qheZ8ZJtAMJTALnFr7x2Thcco1A+tv9ckLVZZnjilmiaohUpXgmpedCJJafe
	W4xBU16FQDFwxBNPgvcd8RfTF9uLFjZ2NzTaZ4OXPcQv2KUgAz8iRETz8Brw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723791901; x=1723878301; bh=mnGnUMRcIq5VjbnuarpRbjeaFKUN
	7vS+1kG0AOBqqa8=; b=RMt9M3fErI3/uH0mW6+b4Bj5NRp00PYF+ZY1T/asR9ZA
	Yq4JjU5R82U/i/dK2jAZXBAylbMW04Gpaxv0u7rHqsmKHrd/1ghpmO5P4HJZPc3a
	JK1CR4UVh6JGDY9Frk0l68TJTxQ5EYC8bxtSZMS9pHOZ1OzuNHk33KUuy1s7LeA2
	z6C89699JvvSwCUAqOk8sxq6W2+/LkGQexd4WR3cBsncAj8/r6yr17ICqRg0j17l
	SOivT64QfV+7baDBL5UjfUk+2WUy57Lv6/XwTXvI6ESuT76WCRuicI0bAmCNKbEK
	Kk1tAjfqHmxFJvbBOVhWZW85a+6fK7NoCgA0rl2uPw==
X-ME-Sender: <xms:Hfq-ZnnX4lvo7MwTiaguI7yR2izhNQo0zwcRPFoN5JD4ew4OE5MC1A>
    <xme:Hfq-Zq2QrsaTqmwpNdn4_CgQnBcVpDdt1IAmJxtOo_ZdIbCOSjtE3ITT5NKuRVbSg
    uNsPtt7bL9usYT0zw>
X-ME-Received: <xmr:Hfq-ZtpfK8vVNMmpBztXRR42b3zELgMA_5GU4IfZBkl78xihLDEds_Cw1OheQw2VvBZyrDOezsxjD2HlgNMkWlOLazA2GA8lh2gl8prAWM6ojD8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghp
    thhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepsh
    htvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsphgvtghtrhgrlhes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthh
    homhhsohhnrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Hfq-ZvkXcSeDGpt4IvN-oKgSH-VJpY_rJEFAP_e05pP6Kn97Bd67aQ>
    <xmx:Hfq-Zl2vgKpIJGXB9EDJEnmKyZqVBtH42qcUNWV7nhiI0fkw6tfJ7w>
    <xmx:Hfq-ZuvU-gaasfYyD65LzE3znU4LGd38b1IQbr0XVMIm2otj9XmZAw>
    <xmx:Hfq-ZpVbWdlfSo1tVUp1E2Akhc___lbAV6qvvFHC_vd0NP2O2-bqow>
    <xmx:Hfq-ZuLyOVNLQuarLa8qsAXlWqnyGUpoFrkCSjzO7Kz1Kl5Ypv2xUyS->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 03:04:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3438ceb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 07:04:37 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:04:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v5 8/9] t/unit-tests: convert strvec tests to use clar
Message-ID: <8f56b4d6264b8e5a85ba73bc8ac541efa066c8a6.1723791831.git.ps@pks.im>
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

Convert the strvec tests to use the new clar unit testing framework.
This is a first test balloon that demonstrates how the testing infra for
clar-based tests looks like.

The tests are part of the "t/unit-tests/bin/unit-tests" binary. When
running that binary, it generates TAP output:

    # ./t/unit-tests/bin/unit-tests
    TAP version 13
    # start of suite 1: strvec
    ok 1 - strvec::init
    ok 2 - strvec::dynamic_init
    ok 3 - strvec::clear
    ok 4 - strvec::push
    ok 5 - strvec::pushft_pushf
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
 Makefile                              |   2 +-
 t/unit-tests/{t-strvec.c => strvec.c} | 119 ++++++++++----------------
 t/unit-tests/unit-test.c              |   3 +-
 3 files changed, 45 insertions(+), 79 deletions(-)
 rename t/unit-tests/{t-strvec.c => strvec.c} (54%)

diff --git a/Makefile b/Makefile
index e6206ca8c7..b0c9a79c55 100644
--- a/Makefile
+++ b/Makefile
@@ -1336,6 +1336,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
+UNIT_TESTS_SUITES += strvec
 UNIT_TESTS_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 UNIT_TESTS_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
 UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
@@ -1353,7 +1354,6 @@ UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
-UNIT_TEST_PROGRAMS += t-strvec
 UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/strvec.c
similarity index 54%
rename from t/unit-tests/t-strvec.c
rename to t/unit-tests/strvec.c
index fa1a041469..d11ed0f28d 100644
--- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/strvec.c
@@ -1,52 +1,46 @@
-#include "test-lib.h"
+#include "unit-test.h"
 #include "strbuf.h"
 #include "strvec.h"
 
 #define check_strvec(vec, ...) \
 	do { \
 		const char *expect[] = { __VA_ARGS__ }; \
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
+		cl_assert(ARRAY_SIZE(expect) > 0); \
+		cl_assert_equal_p(expect[ARRAY_SIZE(expect) - 1], NULL); \
+		cl_assert_equal_i((vec)->nr, ARRAY_SIZE(expect) - 1); \
+		cl_assert((vec)->nr <= (vec)->alloc); \
+		for (size_t i = 0; i < ARRAY_SIZE(expect); i++) \
+			cl_assert_equal_s((vec)->v[i], expect[i]); \
 	} while (0)
 
-static void t_static_init(void)
+void test_strvec__init(void)
 {
 	struct strvec vec = STRVEC_INIT;
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, ==, 0);
-	check_uint(vec.alloc, ==, 0);
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert_equal_i(vec.nr, 0);
+	cl_assert_equal_i(vec.alloc, 0);
 }
 
-static void t_dynamic_init(void)
+void test_strvec__dynamic_init(void)
 {
 	struct strvec vec;
 	strvec_init(&vec);
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, ==, 0);
-	check_uint(vec.alloc, ==, 0);
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert_equal_i(vec.nr, 0);
+	cl_assert_equal_i(vec.alloc, 0);
 }
 
-static void t_clear(void)
+void test_strvec__clear(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_push(&vec, "foo");
 	strvec_clear(&vec);
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, ==, 0);
-	check_uint(vec.alloc, ==, 0);
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert_equal_i(vec.nr, 0);
+	cl_assert_equal_i(vec.alloc, 0);
 }
 
-static void t_push(void)
+void test_strvec__push(void)
 {
 	struct strvec vec = STRVEC_INIT;
 
@@ -59,7 +53,7 @@ static void t_push(void)
 	strvec_clear(&vec);
 }
 
-static void t_pushf(void)
+void test_strvec__pushf(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_pushf(&vec, "foo: %d", 1);
@@ -67,7 +61,7 @@ static void t_pushf(void)
 	strvec_clear(&vec);
 }
 
-static void t_pushl(void)
+void test_strvec__pushl(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -75,7 +69,7 @@ static void t_pushl(void)
 	strvec_clear(&vec);
 }
 
-static void t_pushv(void)
+void test_strvec__pushv(void)
 {
 	const char *strings[] = {
 		"foo", "bar", "baz", NULL,
@@ -88,7 +82,7 @@ static void t_pushv(void)
 	strvec_clear(&vec);
 }
 
-static void t_replace_at_head(void)
+void test_strvec__replace_at_head(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -97,7 +91,7 @@ static void t_replace_at_head(void)
 	strvec_clear(&vec);
 }
 
-static void t_replace_at_tail(void)
+void test_strvec__replace_at_tail(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -106,7 +100,7 @@ static void t_replace_at_tail(void)
 	strvec_clear(&vec);
 }
 
-static void t_replace_in_between(void)
+void test_strvec__replace_in_between(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -115,7 +109,7 @@ static void t_replace_in_between(void)
 	strvec_clear(&vec);
 }
 
-static void t_replace_with_substring(void)
+void test_strvec__replace_with_substring(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_pushl(&vec, "foo", NULL);
@@ -124,7 +118,7 @@ static void t_replace_with_substring(void)
 	strvec_clear(&vec);
 }
 
-static void t_remove_at_head(void)
+void test_strvec__remove_at_head(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -133,7 +127,7 @@ static void t_remove_at_head(void)
 	strvec_clear(&vec);
 }
 
-static void t_remove_at_tail(void)
+void test_strvec__remove_at_tail(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -142,7 +136,7 @@ static void t_remove_at_tail(void)
 	strvec_clear(&vec);
 }
 
-static void t_remove_in_between(void)
+void test_strvec__remove_in_between(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -151,7 +145,7 @@ static void t_remove_in_between(void)
 	strvec_clear(&vec);
 }
 
-static void t_pop_empty_array(void)
+void test_strvec__pop_empty_array(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_pop(&vec);
@@ -159,7 +153,7 @@ static void t_pop_empty_array(void)
 	strvec_clear(&vec);
 }
 
-static void t_pop_non_empty_array(void)
+void test_strvec__pop_non_empty_array(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -168,7 +162,7 @@ static void t_pop_non_empty_array(void)
 	strvec_clear(&vec);
 }
 
-static void t_split_empty_string(void)
+void test_strvec__split_empty_string(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_split(&vec, "");
@@ -176,7 +170,7 @@ static void t_split_empty_string(void)
 	strvec_clear(&vec);
 }
 
-static void t_split_single_item(void)
+void test_strvec__split_single_item(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_split(&vec, "foo");
@@ -184,7 +178,7 @@ static void t_split_single_item(void)
 	strvec_clear(&vec);
 }
 
-static void t_split_multiple_items(void)
+void test_strvec__split_multiple_items(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_split(&vec, "foo bar baz");
@@ -192,7 +186,7 @@ static void t_split_multiple_items(void)
 	strvec_clear(&vec);
 }
 
-static void t_split_whitespace_only(void)
+void test_strvec__split_whitespace_only(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_split(&vec, " \t\n");
@@ -200,7 +194,7 @@ static void t_split_whitespace_only(void)
 	strvec_clear(&vec);
 }
 
-static void t_split_multiple_consecutive_whitespaces(void)
+void test_strvec__split_multiple_consecutive_whitespaces(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	strvec_split(&vec, "foo\n\t bar");
@@ -208,7 +202,7 @@ static void t_split_multiple_consecutive_whitespaces(void)
 	strvec_clear(&vec);
 }
 
-static void t_detach(void)
+void test_strvec__detach(void)
 {
 	struct strvec vec = STRVEC_INIT;
 	const char **detached;
@@ -216,40 +210,13 @@ static void t_detach(void)
 	strvec_push(&vec, "foo");
 
 	detached = strvec_detach(&vec);
-	check_str(detached[0], "foo");
-	check_pointer_eq(detached[1], NULL);
+	cl_assert_equal_s(detached[0], "foo");
+	cl_assert_equal_p(detached[1], NULL);
 
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, ==, 0);
-	check_uint(vec.alloc, ==, 0);
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert_equal_i(vec.nr, 0);
+	cl_assert_equal_i(vec.alloc, 0);
 
 	free((char *) detached[0]);
 	free(detached);
 }
-
-int cmd_main(int argc, const char **argv)
-{
-	TEST(t_static_init(), "static initialization");
-	TEST(t_dynamic_init(), "dynamic initialization");
-	TEST(t_clear(), "clear");
-	TEST(t_push(), "push");
-	TEST(t_pushf(), "pushf");
-	TEST(t_pushl(), "pushl");
-	TEST(t_pushv(), "pushv");
-	TEST(t_replace_at_head(), "replace at head");
-	TEST(t_replace_in_between(), "replace in between");
-	TEST(t_replace_at_tail(), "replace at tail");
-	TEST(t_replace_with_substring(), "replace with substring");
-	TEST(t_remove_at_head(), "remove at head");
-	TEST(t_remove_in_between(), "remove in between");
-	TEST(t_remove_at_tail(), "remove at tail");
-	TEST(t_pop_empty_array(), "pop with empty array");
-	TEST(t_pop_non_empty_array(), "pop with non-empty array");
-	TEST(t_split_empty_string(), "split empty string");
-	TEST(t_split_single_item(), "split single item");
-	TEST(t_split_multiple_items(), "split multiple items");
-	TEST(t_split_whitespace_only(), "split whitespace only");
-	TEST(t_split_multiple_consecutive_whitespaces(), "split multiple consecutive whitespaces");
-	TEST(t_detach(), "detach");
-	return test_done();
-}
diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index 32a81299e9..82b7635e6a 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -6,10 +6,9 @@ int cmd_main(int argc, const char **argv)
 	int ret;
 
 	/* Append the "-t" flag such that the tests generate TAP output. */
-	ALLOC_ARRAY(argv_copy, argc + 2);
+	ALLOC_ARRAY(argv_copy, argc + 1);
 	COPY_ARRAY(argv_copy, argv, argc);
 	argv_copy[argc++] = "-t";
-	argv_copy[argc] = NULL;
 
 	ret = clar_test(argc, (char **) argv_copy);
 
-- 
2.46.0.46.g406f326d27.dirty

