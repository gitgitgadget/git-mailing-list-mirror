Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD31A8C1D
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416673; cv=none; b=DrxZcx+4GzGRTjxcPuQKiKaVnFb9s/XHGfvuhtXfVFMZM5tb8L4JUvqLzsLLD+hRkCgrkPH1LIVIZN8v9kfn4KGxoUdT4wM7K0r7f6sKn4gv6Hefqho/RWsk42ehguhe7JXwQ9FjrUSzsoD4N0aEW14cwDttzAxvFc0IY9krYXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416673; c=relaxed/simple;
	bh=JNv1kCO6kWb75WNGr7hnyGLfneh8dm6uNxYYYzD7mbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvUBHCDCn2eEEbTQP95QhVQ14sz7TjY0sauuvxmYJ7R6bkSJWa49+bii1S0ZPWnui0l3c2x4lnLdDZzv7MrPf45OKCHXC2niDDkf+g/3zNzdwED6QbAnHFIE5KwvPtHwGZn2Rcxw83VUoqgddGvWimn0TwIgEtV1D/9U1LmyOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CdicWRl1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=abwVc9DP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CdicWRl1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="abwVc9DP"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C947313821F9;
	Wed, 31 Jul 2024 05:04:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 31 Jul 2024 05:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722416669; x=1722503069; bh=k7CJiVlLN8
	FSk8kZ/6NpKanAKHJ28+YFGGg5fY85hsg=; b=CdicWRl1veqm4BgeCiVcfDfit8
	uTfxfUuHqHjaBWcxAbwFC4z9g/07U/ma6547J6Wk6Pik0iiZJGNRW06MGedHjDuX
	3FeWMUVIzGr35FCVDFC7zkWenVSF/LSIdn9sB/u3Vp/eT65Lwz2DKUCLvyGE01/z
	/wKf2AckgH7hREw+gt8juF/xWiAX3WWU05A6O8MsDPVbg1ExDMdyD5Zwha99DeGy
	OlsllgTWi3BgcctgYaePUEMls2jzU5p8EoZ1Yit4QbU/C/RgBdzPF44O5Qi0Jvi3
	ceGUKqlvlq9BsrfvHHJxwSywR01uAYYfcS3UmfpG86psmQy/WQWexWbN0tBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722416669; x=1722503069; bh=k7CJiVlLN8FSk8kZ/6NpKanAKHJ2
	8+YFGGg5fY85hsg=; b=abwVc9DPOks1eWsO1TjxlvB/+Cj4lUI3Oh+fD+P8g8cJ
	DosmmMOISCoGYB9QOdA4m12wH2us6ZDbJDcdvbHknUhlFwMyIz0z22Ok2ytLSILN
	Gql1rQCASLZFer3BQHBf9SbgUMpbYP95SoVTHCVo2ohxwOisLiKU+ca2kgfoWwtP
	4qwIq4fsNqsV9O5PPRmfKhYs3mOak5COoKeMFuHEY0q1j++Tu4J/ZjRa6CUletYO
	z9hHg6Jsfue5jgjYH2w4bM88BstHzy+RVIFkZ+1MdqRncgP7c4X6Chl1WJYt2K+F
	vt1MSfPnjjXT4EjAoaznRZvJFJs+nJiPUXNQfHAFaw==
X-ME-Sender: <xms:Hf6pZlGAr_Uzz1IuyZpDfKNilORoNNHlaCYlihRhXiSUcHTW2t8S-w>
    <xme:Hf6pZqWEpBmpD7QpaWgNRxsJz39shAKBJMNn9o617p81nm2ESMoaScoCT25C7iixy
    lfKQ4ol0VV-6ofhOQ>
X-ME-Received: <xmr:Hf6pZnIQtQ_Vlxr8QAUJrHvMihAEsODMZyRSiN6k475i8KlpGmZcb4ip-hNTsyF2l0yefmo0Zpbl8oEvWfnbj8rekvcUpexloc59QU-NWXAql9UX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:Hf6pZrHY2aaAhnLDpxJY55Jji_QmL4XqN2ul_4cgEA2nskV4riyOWQ>
    <xmx:Hf6pZrUN4EDx2cicFFHIHu0BiGRTysO4gKrkqBCkwngVcWSK-blVqA>
    <xmx:Hf6pZmMQeQW24lv5sYego9n8t5lCTdu_1eos5FNqQ5g-4e66gp6RPA>
    <xmx:Hf6pZq19JoE53RL2VUhSpw7S8SilxM4WKpZe2tD6ffpkb5rN4FBCzg>
    <xmx:Hf6pZtKbsfBsumsBwn7aPggggiCKff6yFUbao2lv73EZlrCPiHwq4atp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 05:04:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7a47230c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 09:02:58 +0000 (UTC)
Date: Wed, 31 Jul 2024 11:04:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: [RFC PATCH 3/3] t/unit-tests: convert strvec tests to use clar
Message-ID: <faacf2a8467fbcc4c0fa0b508384e383486decb3.1722415748.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EKSq//cZ9afayZn6"
Content-Disposition: inline
In-Reply-To: <cover.1722415748.git.ps@pks.im>


--EKSq//cZ9afayZn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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
      -sname        Run only the suite with `name` (can go to individual te=
st name)
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
 t/unit-tests/{t-strvec.c =3D> strvec.c} | 124 ++++++++++----------------
 2 files changed, 46 insertions(+), 80 deletions(-)
 rename t/unit-tests/{t-strvec.c =3D> strvec.c} (54%)

diff --git a/Makefile b/Makefile
index 658acb4d48..8ebcbdc95a 100644
--- a/Makefile
+++ b/Makefile
@@ -1332,6 +1332,7 @@ THIRD_PARTY_SOURCES +=3D compat/regex/%
 THIRD_PARTY_SOURCES +=3D sha1collisiondetection/%
 THIRD_PARTY_SOURCES +=3D sha1dc/%
=20
+UNIT_TESTS_SUITES +=3D strvec
 UNIT_TESTS_PROG =3D $(UNIT_TEST_BIN)/unit-tests$(X)
 UNIT_TESTS_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
 UNIT_TESTS_OBJS +=3D $(UNIT_TEST_DIR)/clar/clar.o
@@ -1348,7 +1349,6 @@ UNIT_TEST_PROGRAMS +=3D t-reftable-basics
 UNIT_TEST_PROGRAMS +=3D t-reftable-record
 UNIT_TEST_PROGRAMS +=3D t-strbuf
 UNIT_TEST_PROGRAMS +=3D t-strcmp-offset
-UNIT_TEST_PROGRAMS +=3D t-strvec
 UNIT_TEST_PROGRAMS +=3D t-trailer
 UNIT_TEST_PROGS =3D $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS=
))
 UNIT_TEST_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/strvec.c
similarity index 54%
rename from t/unit-tests/t-strvec.c
rename to t/unit-tests/strvec.c
index d4615ab06d..5edb1ae326 100644
--- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/strvec.c
@@ -1,11 +1,11 @@
-#include "test-lib.h"
+#include "unit-test.h"
 #include "strbuf.h"
 #include "strvec.h"
=20
 #define check_strvec(vec, ...) \
-	check_strvec_loc(TEST_LOCATION(), vec, __VA_ARGS__)
+	check_strvec_loc(__FILE__, __func__, __LINE__, vec, __VA_ARGS__)
 LAST_ARG_MUST_BE_NULL
-static void check_strvec_loc(const char *loc, struct strvec *vec, ...)
+static void check_strvec_loc(const char *file, const char *func, size_t li=
ne, struct strvec *vec, ...)
 {
 	va_list ap;
 	size_t nr =3D 0;
@@ -16,54 +16,47 @@ static void check_strvec_loc(const char *loc, struct st=
rvec *vec, ...)
 		if (!str)
 			break;
=20
-		if (!check_uint(vec->nr, >, nr) ||
-		    !check_uint(vec->alloc, >, nr) ||
-		    !check_str(vec->v[nr], str)) {
-			struct strbuf msg =3D STRBUF_INIT;
-			strbuf_addf(&msg, "strvec index %"PRIuMAX, (uintmax_t) nr);
-			test_assert(loc, msg.buf, 0);
-			strbuf_release(&msg);
-			va_end(ap);
-			return;
-		}
+		clar__assert(vec->nr > nr, file, func, line, "Vector size too small", NU=
LL, 1);
+		clar__assert(vec->alloc > nr, file, func, line, "Vector allocation too s=
mall", NULL, 1);
+		cl_assert_equal_s(vec->v[nr], str);
=20
 		nr++;
 	}
 	va_end(ap);
=20
-	check_uint(vec->nr, =3D=3D, nr);
-	check_uint(vec->alloc, >=3D, nr);
-	check_pointer_eq(vec->v[nr], NULL);
+	cl_assert(vec->nr =3D=3D nr);
+	cl_assert(vec->alloc >=3D nr);
+	cl_assert_equal_p(vec->v[nr], NULL);
 }
=20
-static void t_static_init(void)
+void test_strvec__init(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert(vec.nr =3D=3D 0);
+	cl_assert(vec.alloc =3D=3D 0);
 }
=20
-static void t_dynamic_init(void)
+void test_strvec__dynamic_init(void)
 {
 	struct strvec vec;
 	strvec_init(&vec);
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert(vec.nr =3D=3D 0);
+	cl_assert(vec.alloc =3D=3D 0);
 }
=20
-static void t_clear(void)
+void test_strvec__clear(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_push(&vec, "foo");
 	strvec_clear(&vec);
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert(vec.nr =3D=3D 0);
+	cl_assert(vec.alloc =3D=3D 0);
 }
=20
-static void t_push(void)
+void test_strvec__push(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
=20
@@ -76,7 +69,7 @@ static void t_push(void)
 	strvec_clear(&vec);
 }
=20
-static void t_pushf(void)
+void test_strvec__pushft_pushf(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushf(&vec, "foo: %d", 1);
@@ -84,7 +77,7 @@ static void t_pushf(void)
 	strvec_clear(&vec);
 }
=20
-static void t_pushl(void)
+void test_strvec__pushl(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -92,7 +85,7 @@ static void t_pushl(void)
 	strvec_clear(&vec);
 }
=20
-static void t_pushv(void)
+void test_strvec__pushv(void)
 {
 	const char *strings[] =3D {
 		"foo", "bar", "baz", NULL,
@@ -105,7 +98,7 @@ static void t_pushv(void)
 	strvec_clear(&vec);
 }
=20
-static void t_replace_at_head(void)
+void test_strvec__replace_at_head(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -114,7 +107,7 @@ static void t_replace_at_head(void)
 	strvec_clear(&vec);
 }
=20
-static void t_replace_at_tail(void)
+void test_strvec__replace_at_tail(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -123,7 +116,7 @@ static void t_replace_at_tail(void)
 	strvec_clear(&vec);
 }
=20
-static void t_replace_in_between(void)
+void test_strvec__replace_in_between(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -132,7 +125,7 @@ static void t_replace_in_between(void)
 	strvec_clear(&vec);
 }
=20
-static void t_replace_with_substring(void)
+void test_strvec__replace_with_substring(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", NULL);
@@ -141,7 +134,7 @@ static void t_replace_with_substring(void)
 	strvec_clear(&vec);
 }
=20
-static void t_remove_at_head(void)
+void test_strvec__remove_at_head(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -150,7 +143,7 @@ static void t_remove_at_head(void)
 	strvec_clear(&vec);
 }
=20
-static void t_remove_at_tail(void)
+void test_strvec__remove_at_tail(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -159,7 +152,7 @@ static void t_remove_at_tail(void)
 	strvec_clear(&vec);
 }
=20
-static void t_remove_in_between(void)
+void test_strvec__remove_in_between(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -168,7 +161,7 @@ static void t_remove_in_between(void)
 	strvec_clear(&vec);
 }
=20
-static void t_pop_empty_array(void)
+void test_strvec__pop_empty_array(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pop(&vec);
@@ -176,7 +169,7 @@ static void t_pop_empty_array(void)
 	strvec_clear(&vec);
 }
=20
-static void t_pop_non_empty_array(void)
+void test_strvec__pop_non_empty_array(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -185,7 +178,7 @@ static void t_pop_non_empty_array(void)
 	strvec_clear(&vec);
 }
=20
-static void t_split_empty_string(void)
+void test_strvec__split_empty_string(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_split(&vec, "");
@@ -193,7 +186,7 @@ static void t_split_empty_string(void)
 	strvec_clear(&vec);
 }
=20
-static void t_split_single_item(void)
+void test_strvec__split_single_item(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_split(&vec, "foo");
@@ -201,7 +194,7 @@ static void t_split_single_item(void)
 	strvec_clear(&vec);
 }
=20
-static void t_split_multiple_items(void)
+void test_strvec__split_multiple_items(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_split(&vec, "foo bar baz");
@@ -209,7 +202,7 @@ static void t_split_multiple_items(void)
 	strvec_clear(&vec);
 }
=20
-static void t_split_whitespace_only(void)
+void test_strvec__split_whitespace_only(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_split(&vec, " \t\n");
@@ -217,7 +210,7 @@ static void t_split_whitespace_only(void)
 	strvec_clear(&vec);
 }
=20
-static void t_split_multiple_consecutive_whitespaces(void)
+void test_strvec__split_multiple_consecutive_whitespaces(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_split(&vec, "foo\n\t bar");
@@ -225,7 +218,7 @@ static void t_split_multiple_consecutive_whitespaces(vo=
id)
 	strvec_clear(&vec);
 }
=20
-static void t_detach(void)
+void test_strvec__detach(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	const char **detached;
@@ -233,40 +226,13 @@ static void t_detach(void)
 	strvec_push(&vec, "foo");
=20
 	detached =3D strvec_detach(&vec);
-	check_str(detached[0], "foo");
-	check_pointer_eq(detached[1], NULL);
+	cl_assert_equal_s(detached[0], "foo");
+	cl_assert_equal_p(detached[1], NULL);
=20
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert(vec.nr =3D=3D 0);
+	cl_assert(vec.alloc =3D=3D 0);
=20
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
-	TEST(t_split_multiple_consecutive_whitespaces(), "split multiple consecut=
ive whitespaces");
-	TEST(t_detach(), "detach");
-	return test_done();
-}
--=20
2.46.0.dirty


--EKSq//cZ9afayZn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmap/hgACgkQVbJhu7ck
PpRq2A//YQO2y6kD66noDRdDpfllD2ZX0TLW0xfG4XjR+99xYqk9kBAvbhqYlVHF
UGK40xjtJNVQgZOVdU21RvUChNHpJm5gCt1u42SoHa81x/cU8RY/KaI7AOGmNER5
rrgdK5h9xscLNMFvTVWjhViIGtNVMov5PS2jyBJ8xpyPIxiVF8CiOF3rxxBP0fqV
KocXTNTRue3irMzkprtZm2arL9ESudswR/fpELwxsBHSMtGuBH1V6bX+UqQEBA2c
cZqEM5h58uYVvS3p23TI+dKO3GboXzCI7Ud2gnNagq5c6P36hgS2/v6ZdKUKzJo3
GAIRsDHctjoXmp1tcKFYzsGMFPNtcTLOmQrHLXIxx1Mtr5NkHRDUEiPcGi1rZMj1
zjV+AdD6AEj3msbAM8XNYIY/IgoDK8JepXQ1Am981ehRoA/Hd358SHYse3V93DBs
pJvjJdqK8jpM4EL/u0c2Uz1eW0OlYS2XXmfHVZ51DboIkitbQfPYaHJZPGcgYR4i
M4YTKif6KXjqbfY5jTrlLXmPpg/4v3gWW/65CWNpYYeE9PQVF1tRv/IW49tEsJY4
rgEhLjO/6BGLqEHb4QtHphhP7GucxTWs396Gg6HIP2mJa2TDowaGTMZtXcJfBZ/Z
hd40clAuAHJKE6U3A5Lk0K8SeibLitX1Ub3Kj86UI8rP+YB7CjQ=
=Bsoi
-----END PGP SIGNATURE-----

--EKSq//cZ9afayZn6--
