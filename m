Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2C187335
	for <git@vger.kernel.org>; Wed, 29 May 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002954; cv=none; b=Fmbf6MSpqYcaqqyROoAxy7/JeSsR7o0HXZEGcMZeUJB2YyuApoRd/FmOoVopMAyWYAs0nEr47Fc26jIAihlWFwGdgB8c2BJAmUzY7J89enODw4ccZZ/85AnOiyUGpQwGLkw6t03ur6NASjOkEOpmHeRdiOidxMhX1rOiWgqjhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002954; c=relaxed/simple;
	bh=/+aGEYVCOMt3BDaTUudEV0KrKN/9yegm/HoSNkEWai0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7vQNx2N3vBvjnExxoQMFRSjbl2rG0ZOr/pPwHkPBK/P6y0DkqVdyK3rjkixoHVW85Ou6/3PI5Z/Br3QLF5A7e3yjFS1dxI2AXsX9k3CTBfrClk9nvdopZL18LvvwiIIJ87LS/6f3RiJ3rsgXlIDzvJq88HCvWJPvXdLVTUGFpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcOVMsMM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcOVMsMM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f4a52b94c3so20665595ad.3
        for <git@vger.kernel.org>; Wed, 29 May 2024 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717002949; x=1717607749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjntirJwz5N0hilgEj+W5M3lOc4eyCJjtBTq8ybzxHc=;
        b=kcOVMsMMfsORcsW2dfNEWCEN/S/Xof3VXVDa5UCijqH606+TOEYRNW/PGhGF7BB61g
         LZUoddfboUIqIshkyknh8esW+6lkcfht3DJSnTZ79kDmh/Z131sDUSC6h7DcyVOws+fW
         qr71E91oNqeByw4YZIJP9dRGqRSYgKAHsdL+1JuXLW3M+hSvxdSfGeEQbznn9weuVsaz
         j2LyLkbHf9dIfnGK16YsDjKWoCeAsTktJHB8NvFHvZSFEceFmQVKVw8Xh3Uet+09RF7r
         0H0ghf+HmCIZGm7fleDcLlkS5sWuqgjzUkr8zVhrmZUedLyy/HokdPLtr/CiBfAZOOb6
         Qqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717002949; x=1717607749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjntirJwz5N0hilgEj+W5M3lOc4eyCJjtBTq8ybzxHc=;
        b=AjBzG2ufetqz8hKK5bJ++HhefYcLr7BzNE83DBjbzKV90L5ZRJhCoBgcfWZJOuGIFK
         8u7NjhM93XxeVi3Ga6xdyTim6Ea/mxBcmqQ/6Pb6s9/Ghgg0tYTt+aaqsrV9kzuCJxPg
         Lq8jroOCXEmkkPyYCWSG6jr2tFAyzwXcxb5mucAftt8oUBjAhg1p+l4QTv8aXLCWczIB
         4FkG5spR8bRiw10MLM5niVOMG/XGF+4sgGiqWIaGb2p4MuWxnHPm2XgIAYe0TOBStDuR
         IIWkbYwcxmKBmCIUSprcuwWsAL9KZyZkSbgV05lXK/qkwLxyHm9QQGuydwoyWKx+pBpg
         9L3Q==
X-Gm-Message-State: AOJu0YwJaPAxPyFtJCezONNbHofQOUexID7b7vjhzwe2U9Q2oBrabrKh
	NHRs/nx4ofyDTOLSlRvRpxgkJKNrwf7wwg1dA5xj1mGCv2Kbp70lMMXY2A9jk5s=
X-Google-Smtp-Source: AGHT+IFMQyaeSmzHLovP2UoysRYK3U00MZb8SivXkmEMsYlaiE6nlYbpNJmnPuyhscYC6F64adnQFw==
X-Received: by 2002:a17:902:f54c:b0:1f4:a008:29d3 with SMTP id d9443c01a7336-1f4a0082e01mr98008195ad.15.1717002948636;
        Wed, 29 May 2024 10:15:48 -0700 (PDT)
Received: from Ubuntu.. ([171.51.169.75])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f4757734b6sm79720225ad.234.2024.05.29.10.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 10:15:48 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v3 1/5] t: move reftable/basics_test.c to the unit testing framework
Date: Wed, 29 May 2024 22:29:27 +0530
Message-ID: <20240529171439.18271-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240529171439.18271-1-chandrapratap3519@gmail.com>
References: <20240529070341.4248-1-chandrapratap3519@gmail.com>
 <20240529171439.18271-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/basics_test.c exercise the functions defined in
reftable/basics.{c, h}. Migrate reftable/basics_test.c to the
unit testing framework. Migration involves refactoring the tests
to use the unit testing framework instead of reftable's test
framework.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |  2 +-
 t/helper/test-reftable.c                      |  1 -
 .../unit-tests/t-reftable-basics.c            | 41 +++++++++----------
 3 files changed, 20 insertions(+), 24 deletions(-)
 rename reftable/basics_test.c => t/unit-tests/t-reftable-basics.c (65%)

diff --git a/Makefile b/Makefile
index 8f4432ae57..36188ca256 100644
--- a/Makefile
+++ b/Makefile
@@ -1337,6 +1337,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-prio-queue
+UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
@@ -2671,7 +2672,6 @@ REFTABLE_OBJS += reftable/stack.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 
-REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/merged_test.o
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index bae731669c..9160bc5da6 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -5,7 +5,6 @@
 int cmd__reftable(int argc, const char **argv)
 {
 	/* test from simple to complex. */
-	basics_test_main(argc, argv);
 	record_test_main(argc, argv);
 	block_test_main(argc, argv);
 	tree_test_main(argc, argv);
diff --git a/reftable/basics_test.c b/t/unit-tests/t-reftable-basics.c
similarity index 65%
rename from reftable/basics_test.c
rename to t/unit-tests/t-reftable-basics.c
index 997c4d9e01..99e6c89120 100644
--- a/reftable/basics_test.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -6,11 +6,8 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "system.h"
-
-#include "basics.h"
-#include "test_framework.h"
-#include "reftable-tests.h"
+#include "test-lib.h"
+#include "reftable/basics.h"
 
 struct integer_needle_lesseq_args {
 	int needle;
@@ -42,9 +39,8 @@ static void test_binsearch(void)
 		{11, 5},
 		{9000, 5},
 	};
-	size_t i = 0;
 
-	for (i = 0; i < ARRAY_SIZE(testcases); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(testcases); i++) {
 		struct integer_needle_lesseq_args args = {
 			.haystack = haystack,
 			.needle = testcases[i].needle,
@@ -52,14 +48,14 @@ static void test_binsearch(void)
 		size_t idx;
 
 		idx = binsearch(ARRAY_SIZE(haystack), &integer_needle_lesseq, &args);
-		EXPECT(idx == testcases[i].expected_idx);
+		check_int(idx, ==, testcases[i].expected_idx);
 	}
 }
 
 static void test_names_length(void)
 {
 	char *a[] = { "a", "b", NULL };
-	EXPECT(names_length(a) == 2);
+	check_int(names_length(a), ==, 2);
 }
 
 static void test_parse_names_normal(void)
@@ -67,9 +63,9 @@ static void test_parse_names_normal(void)
 	char in[] = "a\nb\n";
 	char **out = NULL;
 	parse_names(in, strlen(in), &out);
-	EXPECT(!strcmp(out[0], "a"));
-	EXPECT(!strcmp(out[1], "b"));
-	EXPECT(!out[2]);
+	check_str(out[0], "a");
+	check_str(out[1], "b");
+	check(!out[2]);
 	free_names(out);
 }
 
@@ -78,8 +74,8 @@ static void test_parse_names_drop_empty(void)
 	char in[] = "a\n\n";
 	char **out = NULL;
 	parse_names(in, strlen(in), &out);
-	EXPECT(!strcmp(out[0], "a"));
-	EXPECT(!out[1]);
+	check_str(out[0], "a");
+	check(!out[1]);
 	free_names(out);
 }
 
@@ -89,17 +85,18 @@ static void test_common_prefix(void)
 	struct strbuf s2 = STRBUF_INIT;
 	strbuf_addstr(&s1, "abcdef");
 	strbuf_addstr(&s2, "abc");
-	EXPECT(common_prefix_size(&s1, &s2) == 3);
+	check_int(common_prefix_size(&s1, &s2), ==, 3);
 	strbuf_release(&s1);
 	strbuf_release(&s2);
 }
 
-int basics_test_main(int argc, const char *argv[])
+int cmd_main(int argc, const char *argv[])
 {
-	RUN_TEST(test_common_prefix);
-	RUN_TEST(test_parse_names_normal);
-	RUN_TEST(test_parse_names_drop_empty);
-	RUN_TEST(test_binsearch);
-	RUN_TEST(test_names_length);
-	return 0;
+	TEST(test_common_prefix(), "common_prefix_size works");
+	TEST(test_parse_names_normal(), "parse_names works for basic input");
+	TEST(test_parse_names_drop_empty(), "parse_names drops empty string");
+	TEST(test_binsearch(), "binary search with binsearch works");
+	TEST(test_names_length(), "names_length retuns size of a NULL-terminated string array");
+
+	return test_done();
 }
-- 
2.45.GIT

