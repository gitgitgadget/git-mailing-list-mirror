Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D37DA7D
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720876; cv=none; b=WEi4wv2pyKH2xffy0cQauSDuMhGxje2vw3W4qr4l3OlbW04QR8vmAJtApuJxH8MBxAZ2KnJoAovhig78vePbCYFU5TcP9OFF82MleNYI593fOUGMxwJMN29UmCS0ONcIOzGtEiy08bZYdL9udg1ILIBI/UeELWzOtd1pCHWuNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720876; c=relaxed/simple;
	bh=zwl/RogHJWyQbCg4RiCui9oXjK3otKsYE+Za0CgzqHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1sb7zovZGpULArVxTsemUVcxqhKxXEpjTNE2iQYsO4RNSZket42LPq8/vIX/Tl48RbDVu4MlVhbOJWfLE+EQyTPw7BvWSZ1TFbPxhQ9GNggIyqlgphERFRVpn/t1I+5Ym5F6g1L5UuQqZN8rsUt6Zoj3RCHynKOuBPv6pwVomo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JtX1YC2q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KgJqrYE9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JtX1YC2q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KgJqrYE9"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id E3A6E138FC73;
	Thu, 15 Aug 2024 05:47:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Aug 2024 05:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723715276; x=1723801676; bh=HhD9FJx2nb
	2qn6mST6lz7y/mkXA5eAtTBj/DpPeSeOU=; b=JtX1YC2qeyLvQeLIgdUoFpUgw2
	ttEeMIp9FB2HQXhpFZ+QPXeE9BlEE5nBYujZd08GrigPvbjsXKyy52FrEoLELcNG
	f4g1TSqtiZJXw4h9jBmCAwFdl2PbU5DZcYc3+wBflNcxF5mOKJoDxZCirBwGJJvL
	P+Qr0Z72K3T1jJKBJ2/QXVGdWHx3ey5ys419C4ssfYEMimMMC8WLy/FC1B98aQr9
	CUj2Vxqtjk5gUiPWdeUdoT+19gHflRpNmDo3gPD8Bg4ciyX/UlS0qnGVoJOT/OvL
	N85BhhAtYBPF7hWz18/w/XOYE2mi9iE9Te1NgyTacZZEDIoT6U90aQlPaOjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723715276; x=1723801676; bh=HhD9FJx2nb2qn6mST6lz7y/mkXA5
	eAtTBj/DpPeSeOU=; b=KgJqrYE9lZH0j/D8gREu7knkeWf+v0du7nWXQgabJ8NL
	A7UAH1Zkd5EZmNllYO+LDZaCQVwSyGYrK6IVAzQH3rFR/FqUoMbJ+GRZOtK5DvfK
	zgFgmom9MBA1bTEFafT+IXjpdr0pFHX7PyIaRR7BtKCY3FHM8tM9weid1hsLFmZi
	4B9B9jDxYdDQeLfBTkchcpKSaaSI7CQ1XzcQOKy//BxG9TtrXR8/Dfmduj4VMcTF
	BZlXSaBwzHSJgEz1Cm4qO0hgHrf+n0OMrYN1jaqBy8llndjSUN0AXfQh/rY0t0Jr
	d9Mrwia3lhQh58ysQr/njE5evqbDVYvOlmpquFLxyA==
X-ME-Sender: <xms:zM69ZvKzWJv4ErOT4vXOrRnf-BwXBumNPCWvIuAIdZ2KjwqQRSISjg>
    <xme:zM69ZjImft3yxoMA2dxOQ99PJJ7k9SvfrnIp8cg7JJX1m5oKi1lMXE48gqfGlRSrU
    z3nOMznnyzyF8MEtA>
X-ME-Received: <xmr:zM69ZnuHfy6MEsMTNX0XTkQi_JVOZcsmaTsTfHx5E0BuDZLZbuTQ7wyjjLrOKy_hSPVmoL7tDP971oHUG4pIqq6PocPVkHOC5b1iKJe_Dxx_WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepshhtvg
    grughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgv
    gigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepvghthhhomhhs
    ohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:zM69ZoadTDTjbmGlpqP5SNoQ6DbrkOptjmD_gklDnGi6rFuLChrFbg>
    <xmx:zM69ZmY68cGRbAuz69jzgtrf30Phek_B3c0ZeXJaeHj23qzEUPweWA>
    <xmx:zM69ZsAdHBmA55Azb8bRMz2mKoQT1ydtky7MnRWN3ApgemojJLDg_A>
    <xmx:zM69Zka8UFPKGzOZiNYxglK2tKvpuRwxytb71xE8VH39NU77ZK0VCA>
    <xmx:zM69ZsNE24g72nTJQVQhn13CDxhINnvjDXIqdDNeSfpuObVw7zVcgSC_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:47:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 42f66eb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:47:33 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:47:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v4 6/7] t/unit-tests: convert strvec tests to use clar
Message-ID: <bc4e23d666d23cc0cf74d9ede4a2e446185eec1e.1723712012.git.ps@pks.im>
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
index 1311bbbbed..ebc12b2bf1 100644
--- a/Makefile
+++ b/Makefile
@@ -1334,6 +1334,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
+UNIT_TESTS_SUITES += strvec
 UNIT_TESTS_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 UNIT_TESTS_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
 UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
@@ -1351,7 +1352,6 @@ UNIT_TEST_PROGRAMS += t-reftable-merged
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

