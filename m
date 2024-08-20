Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C921922F4
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162573; cv=none; b=Jrtgov98JjapfsZJHuyS+Hhk+vLpSFW1lv6+SI3216BEYdrp+EZb6PlgZyg7EG0ybKeB0Cf644E/lluvmwJmGdciSWt/934Zf6/eywjZnkDFUI30rKfBAo62GVA8kMJcmPfImzqHe+cMxYjI+mZK8WMCLzRM+3Ju8+C+20hKR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162573; c=relaxed/simple;
	bh=lIwCPo6pHkXZpXvXPkco/gphU+MSWPYx4vnCBJYE7vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkw+TjQ4AUiI6k25tVXJObPZZz/eEfGpG/GUR3Qyp6NmSfUoCqms3R72JIveDRK/zpTQ9pfIdPItWV3/OQLHfVv/Ya0Hvcyint9WmTgwE+sEdKAfA4b8Bw1vqdxFkXXQwWLB0ot5wXZWibEfgxeLf9sk++80IWmRiQZ7IM/17YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QKddtqdH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zb0YSOwz; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QKddtqdH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zb0YSOwz"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6451E1151738;
	Tue, 20 Aug 2024 10:02:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162570; x=1724248970; bh=etHvL8dPLo
	KxNnvkA6/73WE8EJOPV5Nu5puLsRFFIck=; b=QKddtqdHnMkPHdOcavqQlNyMMR
	8Yh5u4fkHV2hEU3U6z57OuGOx6cKhLKqOiodofw9x+iQOGpmj9YC9BUGguba1Njg
	9JzO3trIt4EK79LA510WABda4Eu1yzbIhz6tUmOZYKvvJN+H+zojAwi4gKhLXU+g
	2LlSiKaPqHWgXwidnluKM8QSv7NVKJmG9luF/YZtVvWh5c9F9VFDgtvfQsqeyCEe
	vXbRbR2kQJ+U6CSKnxmGVNzE+zOzXVotPFELUKuF39XxedssZCZP/Vyf5CE+j1gr
	gWJM7WptWezyrvM43UjW0X7tivlE/suxokYFLo0Up8InsrtlTl83AmdOR2XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162570; x=1724248970; bh=etHvL8dPLoKxNnvkA6/73WE8EJOP
	V5Nu5puLsRFFIck=; b=Zb0YSOwzLprK/xYXOBj5gN/HsuEEdDuJ0DqELBus3Wfq
	ELpCzTH3461K1tkG7sQJbkEeU6gNIg9ZFrX6citQbYzOZO2YrG7AjWJzXSi40pRp
	fEeYgKN1TAytPdhfUsFDQRNQPuvVm5uh9tOctWKF19Lx1203jgFsnQSVeAbYje7d
	BfscerohmcrzK1IQ5nywIMKg6nqi0gYH8P9hfu+QqxGQJjinXR9GNuxu8784b7nY
	WaY5TdjSSXu0QPJ3H+t60ETlWsFlFQIup5680hHqHlbNZnX2aPvSM70PR7LGa5iK
	wCSxdlHZ/DFu5vuH0OnbuW1EaaXCbT7sTpta/z3V4w==
X-ME-Sender: <xms:CqLEZhtTTo36gLvwsM5xtlLM5OS2H0nTj0ZufVj0WasZXN3EJCINYw>
    <xme:CqLEZqfA3dcGZ5nIAx_0wo3rTVXwO0_vanQ2h6fVK5ULAE8kSRrFE_FRTDd6dcr8p
    1qo13egggxPi5hXKg>
X-ME-Received: <xmr:CqLEZkxp1Yfz348iV4cL_zMePx7vXHCjjqkUoNEINp_u2EPBLpnrCshCQA7oAsSARJyca8xb4faXRZxezlAfVrhNFAHcluMkhff92WUgI80_4V0GvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhn
    rdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehsphgvtg
    htrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:CqLEZoOJa9FxkSWLNIxl5ZpJCtyghKKZPCnk1nEhszSW3qxaEPJUsw>
    <xmx:CqLEZh8DXWO42YPjVd9g2lToDV5Kk7HOrqYeb7Jn2IoPMJyRBe0VLg>
    <xmx:CqLEZoXK4iIywINtV44DZgDc5JSepPPlTl1MIK6KU83GErNjlv1qHA>
    <xmx:CqLEZidKvRc0fwB2bFHUebv2NQEmaTaOTT_O18-496X_bOA1Jldgxg>
    <xmx:CqLEZgYR0o-Imwp1nCGYVIFCplH4gEpAdkBpCLqHIJPnSpAHMuthNeXU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 10:02:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a7abec23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 14:02:17 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:02:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 12/13] t/unit-tests: convert ctype tests to use clar
Message-ID: <1ac2e48a7f2d41d60ff56890d8d87125f30c2f76.1724159966.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159966.git.ps@pks.im>

Convert the ctype tests to use the new clar unit testing framework.
Introduce a new function `cl_failf()` that allows us to print a
formatted error message, which we can use to point out which of the
characters was classified incorrectly. This results in output like this
on failure:

    # start of suite 1: ctype
    ok 1 - ctype::isspace
    not ok 2 - ctype::isdigit
        ---
        reason: |
          Test failed.
          0x61 is classified incorrectly
        at:
          file: 't/unit-tests/ctype.c'
          line: 38
          function: 'test_ctype__isdigit'
        ---
    ok 3 - ctype::isalpha
    ok 4 - ctype::isalnum
    ok 5 - ctype::is_glob_special
    ok 6 - ctype::is_regex_special
    ok 7 - ctype::is_pathspec_magic
    ok 8 - ctype::isascii
    ok 9 - ctype::islower
    ok 10 - ctype::isupper
    ok 11 - ctype::iscntrl
    ok 12 - ctype::ispunct
    ok 13 - ctype::isxdigit
    ok 14 - ctype::isprint

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  2 +-
 t/unit-tests/{t-ctype.c => ctype.c} | 70 ++++++++++++++++++++++++-----
 t/unit-tests/unit-test.h            |  7 +++
 3 files changed, 67 insertions(+), 12 deletions(-)
 rename t/unit-tests/{t-ctype.c => ctype.c} (70%)

diff --git a/Makefile b/Makefile
index 56ce6c00e44..c841cf70063 100644
--- a/Makefile
+++ b/Makefile
@@ -1336,13 +1336,13 @@ THIRD_PARTY_SOURCES += sha1dc/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
+UNIT_TESTS_SUITES += ctype
 UNIT_TESTS_SUITES += strvec
 UNIT_TESTS_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 UNIT_TESTS_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
 UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
-UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGRAMS += t-hashmap
diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/ctype.c
similarity index 70%
rename from t/unit-tests/t-ctype.c
rename to t/unit-tests/ctype.c
index e28a7f50f9a..5026378bfbc 100644
--- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/ctype.c
@@ -1,16 +1,13 @@
-#include "test-lib.h"
+#include "unit-test.h"
 
 #define TEST_CHAR_CLASS(class, string) do { \
 	size_t len = ARRAY_SIZE(string) - 1 + \
 		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
 		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) == sizeof(char)); \
-	if_test (#class " works") { \
-		for (int i = 0; i < 256; i++) { \
-			if (!check_int(class(i), ==, !!memchr(string, i, len)))\
-				test_msg("      i: 0x%02x", i); \
-		} \
-		check(!class(EOF)); \
-	} \
+	for (int i = 0; i < 256; i++) \
+		if (class(i) != !!memchr(string, i, len)) \
+			cl_failf("0x%02x is classified incorrectly", i); \
+	cl_assert(!class(EOF)); \
 } while (0)
 
 #define DIGIT "0123456789"
@@ -31,21 +28,72 @@
 	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
 	"\x7f"
 
-int cmd_main(int argc, const char **argv) {
+void test_ctype__isspace(void)
+{
 	TEST_CHAR_CLASS(isspace, " \n\r\t");
+}
+
+void test_ctype__isdigit(void)
+{
 	TEST_CHAR_CLASS(isdigit, DIGIT);
+}
+
+void test_ctype__isalpha(void)
+{
 	TEST_CHAR_CLASS(isalpha, LOWER UPPER);
+}
+
+void test_ctype__isalnum(void)
+{
 	TEST_CHAR_CLASS(isalnum, LOWER UPPER DIGIT);
+}
+
+void test_ctype__is_glob_special(void)
+{
 	TEST_CHAR_CLASS(is_glob_special, "*?[\\");
+}
+
+void test_ctype__is_regex_special(void)
+{
 	TEST_CHAR_CLASS(is_regex_special, "$()*+.?[\\^{|");
+}
+
+void test_ctype__is_pathspec_magic(void)
+{
 	TEST_CHAR_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=>@_`~");
+}
+
+void test_ctype__isascii(void)
+{
 	TEST_CHAR_CLASS(isascii, ASCII);
+}
+
+void test_ctype__islower(void)
+{
 	TEST_CHAR_CLASS(islower, LOWER);
+}
+
+void test_ctype__isupper(void)
+{
 	TEST_CHAR_CLASS(isupper, UPPER);
+}
+
+void test_ctype__iscntrl(void)
+{
 	TEST_CHAR_CLASS(iscntrl, CNTRL);
+}
+
+void test_ctype__ispunct(void)
+{
 	TEST_CHAR_CLASS(ispunct, PUNCT);
+}
+
+void test_ctype__isxdigit(void)
+{
 	TEST_CHAR_CLASS(isxdigit, DIGIT "abcdefABCDEF");
-	TEST_CHAR_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
+}
 
-	return test_done();
+void test_ctype__isprint(void)
+{
+	TEST_CHAR_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
 }
diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
index 66ec2387cc6..4c461defe16 100644
--- a/t/unit-tests/unit-test.h
+++ b/t/unit-tests/unit-test.h
@@ -1,3 +1,10 @@
 #include "git-compat-util.h"
 #include "clar/clar.h"
 #include "clar-decls.h"
+#include "strbuf.h"
+
+#define cl_failf(fmt, ...) do { \
+	char *desc = xstrfmt(fmt, __VA_ARGS__); \
+	clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1); \
+	free(desc); \
+} while (0)
-- 
2.46.0.164.g477ce5ccd6.dirty

