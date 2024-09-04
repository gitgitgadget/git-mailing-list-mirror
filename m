Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777721DA62D
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459448; cv=none; b=VKsNmq1Z8g9x+gNCtwQcLzyq/UqDOoFai2KmY/2M7zAtBLK80RwDeZDAZMPUW+Sv5Io3BqQo89yGJYvDaYFWMj24i0SzbNdxfpmJESkmMoW78Q58BY0Wxu3SwIjDR7NIpHNqd4SajasOElMETTOQ5/pXWamWwnb6tyjlfbwxFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459448; c=relaxed/simple;
	bh=pNCH32s8Ys/Svx62eYllyDZlIsS0b07dyypjgUXVjd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMTf0cNgfWeo2UMDqzKGeZ4BE86sd86wA/J1wFec3r5c0c5ZlD+CZox0LM7stiuSgeLCXmZw//bPXurGP8dwGxYUpJPOxVAq5m/G79N94sEuRvgydwkHU8hWeXJTwqwaZfKa1PZpwzdVXAp9sSKdeHL9Jl0Qco6Je8Qi8VgcHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JjpsO+LV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LPQZMExi; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JjpsO+LV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LPQZMExi"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CDC4C138026B;
	Wed,  4 Sep 2024 10:17:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 04 Sep 2024 10:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459445; x=1725545845; bh=5+yOetq6qz
	k+nX49PClL7JBxHc1KlRLYqbQht+9lx+k=; b=JjpsO+LVoL736SVF27X6mBvomD
	BOROwyJL6vdmjaNfK7xN7Lj2K1A7dLO/KX/gHMPkInvSZB4jFN0rt3JRGMqO6Gbd
	X5I7ekIsv2BW3yTqmCwp6n5MAv4ZgWzw9ztqvnzK1FgZa/5hXPnnNrXFc6osTH4E
	I2WGQcRoX8f1/oGnQLkT3DpSRYv9av0HWZvlSUNL2s5oX3/9WaYHB/m90mYKqblj
	tHFsMZmqo4MF8Eh7gh+O5LjA1YfQNt6gh44YT5m9GVihT2HZ93lslJtSxTIkOXbH
	kRAiYSIv8WpyHBHkOYkX/WkOe6n2NNNxSAtY1TAvBGUreMfPNRgWHQLJDnTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459445; x=1725545845; bh=5+yOetq6qzk+nX49PClL7JBxHc1K
	lRLYqbQht+9lx+k=; b=LPQZMExikHuDXRuStTmKkhAjqemEfe2t/H7eRI4Z271z
	xiow1FsTy66t/X5iRJeVkcY7U1o3Rhez+AuRjl/2LytPoCDF8hQu3csHGh0yO7Mb
	U2/UFEKkmn+IpqT5o4mcuqJFz1OqxwchUreTOQXfZ1lywWzBEjoMwB435gJJ4AR5
	XH0KpunWCy2O2pxowTjdF3W+KOLHhAnWL/HnfGxmNGwRMuUwD4rkIdpr+rUPnFx+
	1VVBnuk5+uXE2M/E4lqMqzwaoscUBe2bJ4mF2d8p/WgWzcNh7Ts/SCOVp9S0kqmY
	BnE6MIhqaZINQCPOmFhFssAUzPC+jvPPb25I713HDA==
X-ME-Sender: <xms:9WvYZqZ2naRXq0XqM75WJuaU6z2gXG4MjOy7vRIvyG-MDRq1AF2cVA>
    <xme:9WvYZtbEoiwg_A0S96IyrpclC6aITVZgtKcYU20MPAHt9qGxcg4F_6bz2LZdEjsoK
    xjE_8fcsqDeSkCEcQ>
X-ME-Received: <xmr:9WvYZk9rzj4dO6UiVRdo2GwVvpGrzcDAMFck5ua5hozn79KfCa4wmRznW8Np5Df1dRu04IyIP_-Te0FupRXK406BOQGdJbo6-u8oRWSiQ32hxBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepsh
    hpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtth
    hopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:9WvYZsoWBOb84aVHZWCeJWj1quIo6KrJA7wdun1XHyWJM43KGAEvSg>
    <xmx:9WvYZlr0sgYWWWReDONc1JyPI8WvHBBMn8KrFLsH8ayZay3l8XtFFA>
    <xmx:9WvYZqSCmXE649ctrMUFuiSG8UciWMO9Pk_LT7pwH1ySuWuMvdTw1A>
    <xmx:9WvYZlqJiWNigKoTyBfcmsXNSrO0QqFqwk5kcxBraxKe-ow46zXwfA>
    <xmx:9WvYZg1-1J_NMnuMahRaMWoAGg1GRhhMEeXwgs1JVcxwrY9SLIunufLZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:17:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0fa6904d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:17:15 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:17:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 13/14] t/unit-tests: convert ctype tests to use clar
Message-ID: <ba05b9f1eef8136e087846ee54a076558097a240.1725459142.git.ps@pks.im>
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
2.46.0.519.g2e7b89e038.dirty

