Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C016D326
	for <git@vger.kernel.org>; Tue, 28 May 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896382; cv=none; b=azoNWuSmPGrj5ZPFqevuZ7cysgbCf1d5d/GPxkE5lFm/SZopZVMzIFotDP7oir4+mMax5UkvW+ZDiG7/VPf1StwvpZHoKF4y7Z2xYIKTe52sm5lOvPGClVFlq3kEWGMnKFgHhkO7KhMH/FJc7EH4NhGVIy+Y5DawKCiLOHl2oP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896382; c=relaxed/simple;
	bh=vxsK+2uyQzjW1EVbTKODZpIVjeQ6GXebIUmpHjqLrvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzObnArpUB+fU1DFF2f2ONz2spmFy0pWDNXwTkefEWIpLO6PaPtx0xCDPmNjXw5niyKeRQ/pMQ+ls4rBXFY3MwFWDwD+Y87aG+5WSnJdef1uVPaVUPW2WEWLCg6pjOB9zTMhCmTa6EHIS3fJ8f9G/K5DJ3tAVsVwnEOE5ze7IVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLXwNYzg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLXwNYzg"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f8eba8f25eso576486b3a.3
        for <git@vger.kernel.org>; Tue, 28 May 2024 04:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716896379; x=1717501179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NolA71rf6NuOT6VvUN590BofJiv3briOqAkr6oQv4L0=;
        b=KLXwNYzgw4JjlqzkLGu/GHdwPo/MPmHRmhkM59679E84Z504VhjP7H9o3NBFh8idk6
         S+bTlCW2eEL+9NhQFBK6RrJtea5txoMloM4NPpmPnJWdHdyjOB2bjXVi5iggyUeAJSt1
         ll/2AGzzvnzWg4luwDWS0NsaY4rdDpAiNnTLDCNtWSrJsxtdif27fH7J3V1nTU7plz9m
         DnAXcq6IEIM/p8AKbRv0I4c7ds4WX87Kbz+AfK7H5QO8QYauvnBID4UpID3wgNpSDVOF
         clh9qiF+DZiCe/5iVlaHIRfe66j0aq4nylpBXkD8nWT7OPfe8oizK2PniNW5h503pfsE
         rXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896379; x=1717501179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NolA71rf6NuOT6VvUN590BofJiv3briOqAkr6oQv4L0=;
        b=vr8iMJFqsyNegTK/IuQC57Ykx7IaSMF1IeinWYrTJBTsODE28w2DDGxjj+xjnK9xlK
         lLaG79nddmR2BzGXVrHrAKeLyUbvuZE96pePIx5fY2U/s5EjvFTjm6tVJ2diWCsudgvJ
         dpscgminIzf0w1F029NAnyfRh3dYTBSz3mvZtz/96yWhutVEp+0sZppLyRJzE4xGFDB6
         BFPSYHA/JwgkI6Oo5jbVOU80D9rXLateJpHeDKZobjD1aYEYR2QQ9EnuvPkDLQOmGl5I
         xH3vAaYwR7QprdRHh6UYxVRfONE/nv4FWCfFFPl8hn8Tcu6/mQ697gLa87jw9pVQrwYO
         QvWw==
X-Gm-Message-State: AOJu0YwkXrRjjgBCxKYVPylHZLGtyQWqS1UWT6go8eZSnsLLWDr9QKtU
	QncTg/SF99TJhY8Z6+j3fm5pZjZtKn6q6DOyjNdXdAEUJxNDPSTwqzpvd2kw
X-Google-Smtp-Source: AGHT+IEwvv7HujlGoDrhgbIJJiDo+RfaZUGbAhH6uH98Dyj2Np9+Hsf8bnq+h6D0+gaD5eTECQ1ZWQ==
X-Received: by 2002:a05:6a00:4c82:b0:6f4:714d:fb43 with SMTP id d2e1a72fcca58-6f8f4197622mr13021706b3a.29.1716896379056;
        Tue, 28 May 2024 04:39:39 -0700 (PDT)
Received: from Ubuntu.. ([171.51.165.3])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-682229ddfe5sm7375738a12.53.2024.05.28.04.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 04:39:38 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] t: move reftable/basics_test.c to the unit testing framework
Date: Tue, 28 May 2024 17:00:02 +0530
Message-ID: <20240528113856.8348-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240528113856.8348-1-chandrapratap3519@gmail.com>
References: <20240528113856.8348-1-chandrapratap3519@gmail.com>
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
 .../unit-tests/t-reftable-basics.c            | 50 ++++++++-----------
 3 files changed, 21 insertions(+), 32 deletions(-)
 rename reftable/basics_test.c => t/unit-tests/t-reftable-basics.c (60%)

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
similarity index 60%
rename from reftable/basics_test.c
rename to t/unit-tests/t-reftable-basics.c
index 997c4d9e01..b6088e1ddd 100644
--- a/reftable/basics_test.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -1,16 +1,6 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "system.h"
-
-#include "basics.h"
-#include "test_framework.h"
-#include "reftable-tests.h"
+#include "test-lib.h"
+#include "reftable/system.h"
+#include "reftable/basics.h"
 
 struct integer_needle_lesseq_args {
 	int needle;
@@ -42,9 +32,8 @@ static void test_binsearch(void)
 		{11, 5},
 		{9000, 5},
 	};
-	size_t i = 0;
 
-	for (i = 0; i < ARRAY_SIZE(testcases); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(testcases); i++) {
 		struct integer_needle_lesseq_args args = {
 			.haystack = haystack,
 			.needle = testcases[i].needle,
@@ -52,14 +41,14 @@ static void test_binsearch(void)
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
@@ -67,9 +56,9 @@ static void test_parse_names_normal(void)
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
 
@@ -78,8 +67,8 @@ static void test_parse_names_drop_empty(void)
 	char in[] = "a\n\n";
 	char **out = NULL;
 	parse_names(in, strlen(in), &out);
-	EXPECT(!strcmp(out[0], "a"));
-	EXPECT(!out[1]);
+	check_str(out[0], "a");
+	check(!out[1]);
 	free_names(out);
 }
 
@@ -89,17 +78,18 @@ static void test_common_prefix(void)
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

