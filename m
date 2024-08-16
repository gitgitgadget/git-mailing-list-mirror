Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ACE81AB6
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793776; cv=none; b=Cwtzf9Ql6fyRFN7Nx60wJ91tsBV8tpBA4C9fpNV5eGvn0BtRW8GkYdML5Inm2C56OVZgHwaRSWPxeUOM5MLpY6t+gKl6QiCJqFBM7qZYX/QhxWnfgetLCGvi7aazOnf0Urb2YySrINjQwmm0NFhbGrLueejS6XVMjc3zBe5ChKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793776; c=relaxed/simple;
	bh=yDp+7Dji7BkUw4pJx/5dNrHcT6hEp0ItMygr97ACtXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7nzUclsEEqfPtPQ+FCzH1ru7Eh12IiKftTlv8H+gYfbrKPFvHZ5eRFZASYSvJsqE9ttHuHZsnBvnzFnPNmHwu0QclxIBnA24aV/NGEnnVgz2oPsSY3H1UNr8BX10JQBC91pCbjnoguKK/z6LmV6lCl14zQ/8p55CeyH6ExlKXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oWEFypEl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q4iLS+fn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oWEFypEl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q4iLS+fn"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 96DBA138CC6A;
	Fri, 16 Aug 2024 03:05:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 Aug 2024 03:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723791904; x=1723878304; bh=/pv5Xuja+e
	Is3/nRsJBKezDu+4S19TIbTFSODgMM3mc=; b=oWEFypElpU4KcrM1CzB5EDXOuM
	nCeDqyQB/vCkX1sAhy98XqjfIc9CFPN7ahk9EBMeyB5rQW8GBh1BTIJO63SeaEzT
	eoNZ2XvIHRzDLQxQvaWzXF67xchRNqa/w7wjUkFNjiZwJE7HGkUesWOQrHbfR/2i
	q2lYFpsSFG/OhIHfrjWD8N9/Jz8nw8QL8Du09pxihSPdVB6vjmPbjY5P7G+fMMbB
	6QWwVSJJTx8vPWRcdWHx10mbgriqvpQebYVi26CjvA6Frh40k74tdDmC95YS8Tl9
	DNX+vQXdPiVwpdq8KF3QvMqR7NUdupNM/14utA4LZcsq871jpXROvZ+kseEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723791904; x=1723878304; bh=/pv5Xuja+eIs3/nRsJBKezDu+4S1
	9TIbTFSODgMM3mc=; b=Q4iLS+fnQrI2zjV6ETDg71nZ+qtXsmZJqGE1OwHFrw8W
	rEe80kP8qjiC3rRArCvngipc1JM0w28aHcTGEXgH66YCgPLGfma3YWoPt9THRB95
	4XaYd/cnkzOaWD9MRqRgwC2ShqbW68ucZy/z2Jr/OEdk5QSVn8Ocjg5a8c2nDzTu
	xWKa7iXc+usdhMBNP33NjZfuabr566RlmsLZeTjmDzT+vNN/Bi6mfUqb+INDsMWH
	kjW1XC2PUX9puhxohuJ5oM9/NLVHJnXmvGDc9RtGAMoH9yRUEcqaisnpdC9Xk7rN
	F/VULWphFYMJ3q5HYOzbQKXeo3J+z1VGJVamoxXzYg==
X-ME-Sender: <xms:IPq-Zq5AWBXHNHD85Q6gLlUSkXmR_4DgmB9JgndVYfy7g42tGVuJCw>
    <xme:IPq-Zj76DS3iae76Rg-ddFNqoxk-CqUQdfjmhOFnhHxoxjfMZCRKeCVADRhmnMTdM
    n_523m6TZdeKht8LA>
X-ME-Received: <xmr:IPq-ZpeYTypd9J3keOFclWUfymfNlU8DO2mJbbr7fxHvQsXtpvGDVgSL53FcIQ7-epZYvirTNSNzqmCle_6ltvDU87t-U_SnQyUbzLu1wR1hNyc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepvghthhhomhhsohhnsegvugif
    rghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtgho
    mhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:IPq-ZnIOE2klOWZi2u9nHedaNIXZDUU2MKN35Jyy8dDGr8nGn3ghnA>
    <xmx:IPq-ZuJWc0WxzqM5T15PTU7wY5CTqpaNg_1Wzjklya1C0BChOwjvng>
    <xmx:IPq-ZoymacduUIb9ZgYxJKGAxOtVMQItaFbMmzNnQQXU4HrqycWJhw>
    <xmx:IPq-ZiJDSzdspExOCNVvZ9SWoyEp8u9diLBSP4ANV4CBkHMt70o8jQ>
    <xmx:IPq-Zt_UgVm8dxkNoVy6THfRzswtR5kctVk7pMXGdj1V2HYKFVdFDgcS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 03:05:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f9e9bd28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 07:04:40 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:05:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v5 9/9] t/unit-tests: convert ctype tests to use clar
Message-ID: <ca09d19fd51cd4b3072b339f483b6b6d6e467b56.1723791831.git.ps@pks.im>
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

Convert the ctype tests to use the new clar unit testing framework.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  2 +-
 t/unit-tests/{t-ctype.c => ctype.c} | 71 +++++++++++++++++++++++------
 2 files changed, 59 insertions(+), 14 deletions(-)
 rename t/unit-tests/{t-ctype.c => ctype.c} (71%)

diff --git a/Makefile b/Makefile
index b0c9a79c55..000eca9f86 100644
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
 UNIT_TEST_PROGRAMS += t-mem-pool
diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/ctype.c
similarity index 71%
rename from t/unit-tests/t-ctype.c
rename to t/unit-tests/ctype.c
index d6ac1fe678..311df3a539 100644
--- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/ctype.c
@@ -1,18 +1,12 @@
-#include "test-lib.h"
+#include "unit-test.h"
 
 #define TEST_CHAR_CLASS(class, string) do { \
 	size_t len = ARRAY_SIZE(string) - 1 + \
 		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
 		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) == sizeof(char)); \
-	int skip = test__run_begin(); \
-	if (!skip) { \
-		for (int i = 0; i < 256; i++) { \
-			if (!check_int(class(i), ==, !!memchr(string, i, len)))\
-				test_msg("      i: 0x%02x", i); \
-		} \
-		check(!class(EOF)); \
-	} \
-	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
+	for (int i = 0; i < 256; i++) \
+		cl_assert_equal_i(class(i), !!memchr(string, i, len)); \
+	cl_assert(!class(EOF)); \
 } while (0)
 
 #define DIGIT "0123456789"
@@ -33,21 +27,72 @@
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
-- 
2.46.0.46.g406f326d27.dirty

