Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15199181BA8
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095523; cv=none; b=H/ubEziChiTO/yeHhLgzP3xwo7VGGqGxa3dhYmf6leGwzvBpoiL5mC7JYC+DufAwN31vUsqrUw/CgAlb7TmYVc2roTtYJdedRuHuruLnM0TMDMIVRbJJi/JizcYwqfOJCeLclqKw2PB93U2aq1otgFImmLXidfdQyom9r4WcRps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095523; c=relaxed/simple;
	bh=8TUuDufS1Lxa//7OpUqlIk7CT4452TlvsB6jmjSRh7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okowVckQTiM/wYfAN2nCvVf66mR6V3NCKjYYIfrodJx2WNHR+zLdpH3kkJmBjXosvyry2pyrROrN8NBEBULCrhQGtbzX9NC9OngH0CW3luE4/V4lBmMpkVGTjgc83EPJ7NjhfV2f7eD2UZIeF4IOUDyELroXM2vfylLQJlI1DDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M94jm72Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FmqkvDDj; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M94jm72Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FmqkvDDj"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 74690138FDEA;
	Thu,  8 Aug 2024 01:38:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 01:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723095520; x=1723181920; bh=WIWw+yQ1JF
	xkg6QiLNwoaXAC6MqsqtQd7V8v3Pyk3iw=; b=M94jm72Qd2eZy+JdNg9obD9JEs
	2KKdygkvOXtoRs0ARs3dTvHmwmn/CxhjZq1e/lZ3oDloQRJxabhYg9WchiQi3t67
	hN1d9VS4CULzHezPIHg92FFq1+iYuCN9mvXLxLdSKzCZhBskquFgMSNivBf0swgo
	IzUr9xCcM3uoSSojJ03NjN+4ESDMznTO1/GF/uhHPk85wztXJNsDFaJyvPmoyThO
	y7wPh0k17I2wxCsFpiqk2DZ/RghkMaJk82oEG1PZikTGN6/btxdG3QDmR+lsKCQg
	YlWbnb4FR3I0NpoumlFpaoaDy8ikaOECFoI85Ic7uFRdrIboUpJ1zgzvAQfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723095520; x=1723181920; bh=WIWw+yQ1JFxkg6QiLNwoaXAC6Mqs
	qtQd7V8v3Pyk3iw=; b=FmqkvDDjqNMdKsfeUTGjnOJdXHONJ60Ekzf+RaD/VEFx
	UnlhSnj5sAjhUJcyvHtOIUluzDK9H6kBmmPWDiR7PT8jfNbsQ34YDqA6e80/mlpy
	r+UM7b/4sQdGthpG0TD5Jt112jOcid95e/RI+48GzJmM8Ks/Ys3YqwRMEsP4XWak
	hVi+KWTd7vYC01ltKo7hGkMsQlA5EfGaW9iZQ06f+jyOi6DLHzwsnfdw947BG3jE
	3AzzpfINbBvjmUbP6lq3dIIH1pu6GFfS+RvuuLecepMd/QdbRBGc60fRPgubML/C
	X+JtqAPjIiYSo+w69b/3/22uVn0KeC2Q8lHnnbkAYA==
X-ME-Sender: <xms:4Fm0Zvhzbr-AO5Hi6Z3YGzJjxyA6ORDcVwlaSGSIx73cFoOlSjxOkw>
    <xme:4Fm0ZsBMzv6TW9EsvpyUyTnpyZAb64_bN2Xx3QJkj7e5unNDsCgSPcR3KePfr9uP-
    xiH-kR4rTf_z29a0A>
X-ME-Received: <xmr:4Fm0ZvGFKw-HAG-JqSpIgSgaa2Q8kIyqYtOqOj74hF9bN8yihxLFM3q1zhPZlSOI2NHPzE-tz05_lj46oXwM9DpsvTz0nThRdCdtzJh9xnjhEGhd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    oheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsphgvtghtrhgrlhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohep
    shhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:4Fm0ZsT57UwNE1dQ2-giF69pTSyE0cb3xZWs973gyf-8EspOPRj_Ag>
    <xmx:4Fm0Zsw0rQSxZdTkWyosNn-NbghnaqAKjmBO7U4CncDxpu1nmZQG7g>
    <xmx:4Fm0Zi5fJbC16QE8kO-LyBuoUCp7ffxVhlMl8m91wkUSN6QKK-Z7IQ>
    <xmx:4Fm0ZhxscqiceIY8t-9oaJLhSctmjF20xeK88gA409vTNejhb2aYIQ>
    <xmx:4Fm0ZrnM-3l5_nBKM52c2V4u9cMEhvql26L4MrhMI1YacqOoqGVtKQvh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:38:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e829290d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:38:32 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:38:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v3 6/7] t/unit-tests: convert strvec tests to use clar
Message-ID: <4a0888380e4f13bde852eec40926ff5c71ea3a37.1723095269.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723095269.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eeirfQ2VbHUqfues"
Content-Disposition: inline
In-Reply-To: <cover.1723095269.git.ps@pks.im>


--eeirfQ2VbHUqfues
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
 t/unit-tests/{t-strvec.c =3D> strvec.c} | 119 ++++++++++----------------
 t/unit-tests/unit-test.c              |   3 +-
 3 files changed, 45 insertions(+), 79 deletions(-)
 rename t/unit-tests/{t-strvec.c =3D> strvec.c} (54%)

diff --git a/Makefile b/Makefile
index d343703215..ec90b8ac35 100644
--- a/Makefile
+++ b/Makefile
@@ -1334,6 +1334,7 @@ THIRD_PARTY_SOURCES +=3D sha1dc/%
 THIRD_PARTY_SOURCES +=3D $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES +=3D $(UNIT_TEST_DIR)/clar/clar/%
=20
+UNIT_TESTS_SUITES +=3D strvec
 UNIT_TESTS_PROG =3D $(UNIT_TEST_BIN)/unit-tests$(X)
 UNIT_TESTS_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
 UNIT_TESTS_OBJS +=3D $(UNIT_TEST_DIR)/clar/clar.o
@@ -1351,7 +1352,6 @@ UNIT_TEST_PROGRAMS +=3D t-reftable-merged
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
index fa1a041469..d11ed0f28d 100644
--- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/strvec.c
@@ -1,52 +1,46 @@
-#include "test-lib.h"
+#include "unit-test.h"
 #include "strbuf.h"
 #include "strvec.h"
=20
 #define check_strvec(vec, ...) \
 	do { \
 		const char *expect[] =3D { __VA_ARGS__ }; \
-		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
-		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
-		    check_uint((vec)->nr, =3D=3D, ARRAY_SIZE(expect) - 1) && \
-		    check_uint((vec)->nr, <=3D, (vec)->alloc)) { \
-			for (size_t i =3D 0; i < ARRAY_SIZE(expect); i++) { \
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
+		cl_assert((vec)->nr <=3D (vec)->alloc); \
+		for (size_t i =3D 0; i < ARRAY_SIZE(expect); i++) \
+			cl_assert_equal_s((vec)->v[i], expect[i]); \
 	} while (0)
=20
-static void t_static_init(void)
+void test_strvec__init(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
-	check_pointer_eq(vec.v, empty_strvec);
-	check_uint(vec.nr, =3D=3D, 0);
-	check_uint(vec.alloc, =3D=3D, 0);
+	cl_assert_equal_p(vec.v, empty_strvec);
+	cl_assert_equal_i(vec.nr, 0);
+	cl_assert_equal_i(vec.alloc, 0);
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
+	cl_assert_equal_i(vec.nr, 0);
+	cl_assert_equal_i(vec.alloc, 0);
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
+	cl_assert_equal_i(vec.nr, 0);
+	cl_assert_equal_i(vec.alloc, 0);
 }
=20
-static void t_push(void)
+void test_strvec__push(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
=20
@@ -59,7 +53,7 @@ static void t_push(void)
 	strvec_clear(&vec);
 }
=20
-static void t_pushf(void)
+void test_strvec__pushf(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushf(&vec, "foo: %d", 1);
@@ -67,7 +61,7 @@ static void t_pushf(void)
 	strvec_clear(&vec);
 }
=20
-static void t_pushl(void)
+void test_strvec__pushl(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -75,7 +69,7 @@ static void t_pushl(void)
 	strvec_clear(&vec);
 }
=20
-static void t_pushv(void)
+void test_strvec__pushv(void)
 {
 	const char *strings[] =3D {
 		"foo", "bar", "baz", NULL,
@@ -88,7 +82,7 @@ static void t_pushv(void)
 	strvec_clear(&vec);
 }
=20
-static void t_replace_at_head(void)
+void test_strvec__replace_at_head(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -97,7 +91,7 @@ static void t_replace_at_head(void)
 	strvec_clear(&vec);
 }
=20
-static void t_replace_at_tail(void)
+void test_strvec__replace_at_tail(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -106,7 +100,7 @@ static void t_replace_at_tail(void)
 	strvec_clear(&vec);
 }
=20
-static void t_replace_in_between(void)
+void test_strvec__replace_in_between(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -115,7 +109,7 @@ static void t_replace_in_between(void)
 	strvec_clear(&vec);
 }
=20
-static void t_replace_with_substring(void)
+void test_strvec__replace_with_substring(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", NULL);
@@ -124,7 +118,7 @@ static void t_replace_with_substring(void)
 	strvec_clear(&vec);
 }
=20
-static void t_remove_at_head(void)
+void test_strvec__remove_at_head(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -133,7 +127,7 @@ static void t_remove_at_head(void)
 	strvec_clear(&vec);
 }
=20
-static void t_remove_at_tail(void)
+void test_strvec__remove_at_tail(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -142,7 +136,7 @@ static void t_remove_at_tail(void)
 	strvec_clear(&vec);
 }
=20
-static void t_remove_in_between(void)
+void test_strvec__remove_in_between(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -151,7 +145,7 @@ static void t_remove_in_between(void)
 	strvec_clear(&vec);
 }
=20
-static void t_pop_empty_array(void)
+void test_strvec__pop_empty_array(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pop(&vec);
@@ -159,7 +153,7 @@ static void t_pop_empty_array(void)
 	strvec_clear(&vec);
 }
=20
-static void t_pop_non_empty_array(void)
+void test_strvec__pop_non_empty_array(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
@@ -168,7 +162,7 @@ static void t_pop_non_empty_array(void)
 	strvec_clear(&vec);
 }
=20
-static void t_split_empty_string(void)
+void test_strvec__split_empty_string(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_split(&vec, "");
@@ -176,7 +170,7 @@ static void t_split_empty_string(void)
 	strvec_clear(&vec);
 }
=20
-static void t_split_single_item(void)
+void test_strvec__split_single_item(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_split(&vec, "foo");
@@ -184,7 +178,7 @@ static void t_split_single_item(void)
 	strvec_clear(&vec);
 }
=20
-static void t_split_multiple_items(void)
+void test_strvec__split_multiple_items(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_split(&vec, "foo bar baz");
@@ -192,7 +186,7 @@ static void t_split_multiple_items(void)
 	strvec_clear(&vec);
 }
=20
-static void t_split_whitespace_only(void)
+void test_strvec__split_whitespace_only(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_split(&vec, " \t\n");
@@ -200,7 +194,7 @@ static void t_split_whitespace_only(void)
 	strvec_clear(&vec);
 }
=20
-static void t_split_multiple_consecutive_whitespaces(void)
+void test_strvec__split_multiple_consecutive_whitespaces(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	strvec_split(&vec, "foo\n\t bar");
@@ -208,7 +202,7 @@ static void t_split_multiple_consecutive_whitespaces(vo=
id)
 	strvec_clear(&vec);
 }
=20
-static void t_detach(void)
+void test_strvec__detach(void)
 {
 	struct strvec vec =3D STRVEC_INIT;
 	const char **detached;
@@ -216,40 +210,13 @@ static void t_detach(void)
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
+	cl_assert_equal_i(vec.nr, 0);
+	cl_assert_equal_i(vec.alloc, 0);
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
diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index 32a81299e9..82b7635e6a 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -6,10 +6,9 @@ int cmd_main(int argc, const char **argv)
 	int ret;
=20
 	/* Append the "-t" flag such that the tests generate TAP output. */
-	ALLOC_ARRAY(argv_copy, argc + 2);
+	ALLOC_ARRAY(argv_copy, argc + 1);
 	COPY_ARRAY(argv_copy, argv, argc);
 	argv_copy[argc++] =3D "-t";
-	argv_copy[argc] =3D NULL;
=20
 	ret =3D clar_test(argc, (char **) argv_copy);
=20
--=20
2.46.0.dirty


--eeirfQ2VbHUqfues
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0WdwACgkQVbJhu7ck
PpTrfhAAnc5mnUXF0VVDKwtZXDlwAa28FWIBN5mfnW7Gnv2xypSJvaMRTJA7JkKG
XwEorLyVPxW6XmCia5+d/2E5cREuA4DAM2rs1imHVA7dCiC75LtXfEq0HnUZYhm3
zBz5AusKUyTqogbqAxkRNzyboAwc490ms3pMp2m9EJDC4loEmCAW3kYRYuUJJPFC
2JOPD86KXxn+cYfYFPsYNhKCxfxOHkYtRw4tfVrELo3Un2IUG802ul/LivhZoTZj
zlE8OnJwF6o73eFbSSBQyXTI93Eg1AeXsbf/6xsKJip3smmxG/ihrQZXrmLCYqjq
wpwFadd6SY7HU2Fx5TyIhZI+YbyqS3tCdkcT41DWtIQhHx0KLYsAcqMNLUh/fqoT
/xi8P+joaaPqUbT7yd42SiBXCoKaKEc+PpVk+xc54k7i8mqLfvzJojqCIfkBwetb
qQmBD8Z75kulR+1uOasKDuHhxzu+o4FMjeS7dRRWi3GWkzVIA4Qv987Op5JzpEue
OjxOSHgqESVdqCIiP1d7WECIXa5Op5ikYBPKyV8jOY5xLEtKmD96gY5KynM0nKpd
bL3yIzILPd2cOZOxBiuo8Ul5NGJ0PVxv0JBtdW4UxVGrgI7cikPEM46VHg3d3vbp
r00r0SReROuyV1evLg2RuEF2JR5EArxSXwHG7uNCXaFhA5CC6O8=
=9FyD
-----END PGP SIGNATURE-----

--eeirfQ2VbHUqfues--
