Received: from pfout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94351AD248
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354918; cv=none; b=vDPuw4gOX5WvBcsq3nSrVloia7bLkqwe02xFQ9T9teAiVFBlhqv5yThVARC2HddwU1ikktsV/V6Ejy0VsHBTRFPwjIxktTdXRftbRrz3T/OmEO9h7TSipqNZISbaTNnAegIZYRWkcG4V2mWeHUgalfMvdFfqlikFyva4ODuCYDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354918; c=relaxed/simple;
	bh=o8AvCYwdX4wfPRnqvqq7AeJ4cCZ4DL0EMdedHCki+WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHd7jdVGQaJ4qa1M7eEV76WpJsRnrHxEgjpXRYKVtwyQhXE86k9Ulda4/ikPLrtlxjmhZAZGOgnOOmyMh7hUr4dykJre5oNLGLkvIltLhBQ+EpimOLFw1lzKdLpPx//LUtbc5xQyjoY5IsvL9UQ0MSrWeoBS80eNQZHTXRS4I8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nA4fkj2i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BruDZLlp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nA4fkj2i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BruDZLlp"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DCE4C1380407;
	Tue,  3 Sep 2024 05:15:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Sep 2024 05:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354915; x=1725441315; bh=KAAxfKJS18
	jrKgJEhHgipsfQrRvdndevq+kMqC1nqCQ=; b=nA4fkj2iCmc1kDtA1G2KzE/mD6
	Nz8XeRtNnTbTTJ8+WW6emL4JUVU/5tT+JNBZaMzbM6nqDL1Bdi/Lg1E1D43NRCwb
	JkUZYvx14vz0SPkcQQtq5FIWUCddE2P60nmn08qDN+Vm7eTAiOYjQyI5eKGv+KtP
	lwg2ALIzZVmDYQAsB17xfvwclzwX63r6z61TLdTPS9RHxf3f7AzpvlXKMNOPGye5
	bi45YbbT22Sw14UaCJH5hzfqH9/eZvb6OAIQyJ//cVK2qqnSZMTaZ8kIIwkmx70c
	85vV+DvCUrXyVB9497gUKqYdzbGiUdp8CMeltCXD82oshqphAnJVGHmFchoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354915; x=1725441315; bh=KAAxfKJS18jrKgJEhHgipsfQrRvd
	ndevq+kMqC1nqCQ=; b=BruDZLlpBXDlIg8888hebP8HuCZ8450BabKHi1r1jNVj
	pRZD7AHfW+Lg5diofZn8x0jkm5lqgOFt7D0KQPYeiZzjU/41tg9UMG14UDDdrLSW
	La0JilM4QNwwqGh62RuqgLIKLiNRHLrA7eSCXBX4C01/5crTmdj0uXwyesQRcj/r
	X5PxzYAJYrA/clb62JM4Qa3SYKwzpZJHT9MpQmWwyQ6qa3TrYjsh7FchHe02iakT
	gxS0rbQjxI13nD6wvmwFsu4vsZbxgy1y/h6i08mgcPN3gHj4IoH+5oZPeHt/0qDN
	aWOFGQwxkTMZlbL5NOJZQ9mg1CoyMP0w7UkhdcVPFQ==
X-ME-Sender: <xms:o9PWZjat5Pjm3ESRrJGlv6_Xvf68lqO8OU0HoKD0th6urgAswMdfow>
    <xme:o9PWZiZgujYdsBy2OdW7FrV-9FljIEb2behZ1E83kNMXOUHtQbuKw1GDQmT2_vEpF
    koo9ouyB2lbAVidEA>
X-ME-Received: <xmr:o9PWZl9sJU6GgUXf6Z4It62B8bjj5pcSBhtjH4k0eK52oTjVa7JFloR6z4JC58S3rCU0Xq183J4KIIDotwP3uaMIEKOml4tRzWSMtXl_hjGZ-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:o9PWZprqw3PPRzvRLAulj2kuJ5qA94DjiEQsJam3uiuTtjGs5sxk5w>
    <xmx:o9PWZuoDbV1KZzp7yyx9iD_91JpMIDlz_SXVf5bP_KjM2qEnHnqQ4A>
    <xmx:o9PWZvSCjcF3LniI7rrJAeJ6bCaflyau-OpKM1ikqiFxT17KS4r-zQ>
    <xmx:o9PWZmqLdVCFLW8ZggA8orfElojOAPZABiF3fwEY4Z6K_6ZQK29N2g>
    <xmx:o9PWZt3lcBcr3uVzndtsf01fqqa0kImT9X1jMcEDF_nfE-46Ym5DWlt6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:15:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c660519 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:15:07 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:15:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 13/14] t/unit-tests: convert ctype tests to use clar
Message-ID: <c8360db2f86e4ef50a7e98a6ae103082c3e2c5d5.1725349234.git.ps@pks.im>
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

Convert the ctype tests to use the new clar unit testing framework.
Introduce a new function `cl_failf()` that allows us to print a
formatted error message, which we can use to point out which of the
characters was classified incorrectly. This results in output like this
on failure:

    # start of suite 1: ctype
    not ok 1 - ctype::isspace
        ---
        reason: |
          Test failed.
          0x0d is classified incorrectly: expected 0, got 1
        at:
          file: 't/unit-tests/ctype.c'
          line: 36
          function: 'test_ctype__isspace'
        ---
    ok 2 - ctype::isdigit
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
 t/unit-tests/{t-ctype.c => ctype.c} | 71 +++++++++++++++++++++++++----
 t/unit-tests/unit-test.h            |  7 +++
 3 files changed, 69 insertions(+), 11 deletions(-)
 rename t/unit-tests/{t-ctype.c => ctype.c} (68%)

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
similarity index 68%
rename from t/unit-tests/t-ctype.c
rename to t/unit-tests/ctype.c
index e28a7f50f9a..32e65867cdc 100644
--- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/ctype.c
@@ -1,16 +1,16 @@
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
+	for (int i = 0; i < 256; i++) { \
+		int actual = class(i), expect = !!memchr(string, i, len); \
+		if (actual != expect) \
+			cl_failf("0x%02x is classified incorrectly: expected %d, got %d", \
+				 i, expect, actual); \
 	} \
+	cl_assert(!class(EOF)); \
 } while (0)
 
 #define DIGIT "0123456789"
@@ -31,21 +31,72 @@
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
index 66ec2387cc6..85e5d6a948a 100644
--- a/t/unit-tests/unit-test.h
+++ b/t/unit-tests/unit-test.h
@@ -1,3 +1,10 @@
 #include "git-compat-util.h"
 #include "clar/clar.h"
 #include "clar-decls.h"
+#include "strbuf.h"
+
+#define cl_failf(fmt, ...) do { \
+	char desc[4096]; \
+	snprintf(desc, sizeof(desc), fmt, __VA_ARGS__); \
+	clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1); \
+} while (0)
-- 
2.46.0.421.g159f2d50e7.dirty

