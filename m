Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E21AC88A
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720876; cv=none; b=deZLHb5AkwbNb8TpQzd2xSCn3IeQdF909C6iIohqNzY9eRuHTMWKXQmbm44Qu8NEco45kzgB/67W+i6+EjZolirpkyc4YyBgc7eYqZ0PxDHAt/xyfDH5Ak470TTVYzrDSvvnZzFVStp9kRTI5zZvWQtwLFpcOCzOBVjucis5Fk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720876; c=relaxed/simple;
	bh=ZzhbslpDA3ay1xlmyGJPc7PXyQVcEwhjaRKWWwdHw+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE2LsBrAbSJ1nW+I2Tx8BQqWMGH9hB44X4dsfYw9YSZjnAlfsVWB+IvB8zGXGAEungFphTCq30b8BaLyOgCoho33JyPN+md5qxU9tvulbobRDjYf71jT+NZFOXlNnSDx6iV1PwYazp3JZ0ztPKCFG9ew8YUKMii4vv1jKEeiBnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aBMnQKw8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O1VmQd4t; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aBMnQKw8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1VmQd4t"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id C7439138FC5C;
	Thu, 15 Aug 2024 05:47:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Aug 2024 05:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723715278; x=1723801678; bh=r2U0q8rD3X
	X0gfq53d3hPXE2q50pqImTHF5I5tU7l1k=; b=aBMnQKw8G4YFOQMXhL72JDnNbp
	8XonA+5iVb5+cZUjP3ozSKhxuuVVixYu/MS8xuxereTGeo3tuKuQJhANEl707PVd
	5i5lYvt+Aj2QVDaXDoP8GO9tNKVlE2nwt1STigmDy99H1GzpVlu6FgO8e9xNDnCp
	Wa+ZHEfPO/5EjexXNPmOYH7EUxrGZB4kWBpf23fVcUZwikwmafbZvJyQ3bs18oGh
	j3esL5H35OzLFqCgJQMChPFGSHZczHeEceT9Cvh4glGo0AGgvNhT0GUufxzEb0Av
	wBOaxnj0XWcEfxdp++yWPml+J7a9ewmQebUPBloRrwn2c++pQ4PLHXF+z+yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723715278; x=1723801678; bh=r2U0q8rD3XX0gfq53d3hPXE2q50p
	qImTHF5I5tU7l1k=; b=O1VmQd4tE6Y4g/IHEMzIymyDiXrjH3aINNDrC5Y/NFKv
	7Odhk8yuhw9seNH9LIbXNSAymHvUqt0FuWxjLdr6WnzGok3DChGQoOdYHIG4WxaO
	B27fiJRsLXBHRTPytAb8WPgA5aPv1I1sgmYz1WEZBkMdr3xFTZ40OIZ3TB+a2OlD
	LztKoOinGpCc7X5ncW4NsR8GA+iwd8SOvopU4dtsO9/TWp7Yhfi135FrwqGz1YIM
	I39qSnExS5PMNNFe7w8PJ8zDuYmv07A1eGl6klHHCUcIBywrNJOx1b9XfTnqKf0x
	CP/pZc+aOwvPlf0Bk4ffEm90LyrT5g29BE8c+Q+DpA==
X-ME-Sender: <xms:zs69Zqm8Uu5wN6zjYNOGpBSyr60WQyxQgvY6UFFt1haYgcE4JKcw8Q>
    <xme:zs69Zh1GfJCtcnMI4k7CjWP9hxSdNRYaLRWlK4xXJDZvtHiLSsCMM8hiys8P1dbet
    QZQydrQCLrp-_JH9g>
X-ME-Received: <xmr:zs69ZopABOywRU834INh5_9_6c47rcyPgCmYFe3KPh5BFGZH_LEtmu_ftNUUfzka4o4uGTn9FQoENezxvU2aQQnHbxv9jJoNd0j4aEudRNmgLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheprhhs
    sggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:zs69Zuni5r_uLm-1gjxqBbHsLJ3NVgT4Rc76zGlMzT3SKhYIJn5MdA>
    <xmx:zs69Zo23O57K4MolpMF0lZ4_g9buLb46e2Sm-MzSGpenHYEZrNLNgA>
    <xmx:zs69ZltxOAMrvEzLoc0C7EaCDab40sXy5Wz4Sdx1FIUO3escJCgewQ>
    <xmx:zs69ZkWXYfE7wHc_uNckzAe2HgLGkOL3Aj5zzwNzeZUjCqqcx2FZQw>
    <xmx:zs69ZpJfzCvPnihLeEkVjmHnMz_MVcUxjh1-bRIRzt9Z7-VnAUaEfZ_x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:47:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e77f1f0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:47:36 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:47:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v4 7/7] t/unit-tests: convert ctype tests to use clar
Message-ID: <0a7fe8775a5e879c724c2b2b338fe0e26fc00234.1723712012.git.ps@pks.im>
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

Convert the ctype tests to use the new clar unit testing framework.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  2 +-
 t/unit-tests/{t-ctype.c => ctype.c} | 71 +++++++++++++++++++++++------
 2 files changed, 59 insertions(+), 14 deletions(-)
 rename t/unit-tests/{t-ctype.c => ctype.c} (71%)

diff --git a/Makefile b/Makefile
index ebc12b2bf1..d28faabbf4 100644
--- a/Makefile
+++ b/Makefile
@@ -1334,13 +1334,13 @@ THIRD_PARTY_SOURCES += sha1dc/%
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

