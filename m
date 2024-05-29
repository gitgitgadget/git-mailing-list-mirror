Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20415EFA7
	for <git@vger.kernel.org>; Wed, 29 May 2024 07:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966275; cv=none; b=PmZvGY3V091MKkdBufbXcxlBW5MZtylN+lXRxu2jWtD13ysGJ3q7atfJnzRzwQCFzneCfOoNduDY2e/04GXb8DNPBErvT5UBpP8KiDNfnOhtg/Yy0Hy0JIrvX3Yy0emserTOyhiK4gxpOtkADIZo/88+CX7+6AaNwmJ/r0OYeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966275; c=relaxed/simple;
	bh=/+aGEYVCOMt3BDaTUudEV0KrKN/9yegm/HoSNkEWai0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ4v85Q8vGgMNK9+r3movdMrRxac/HAVVuJBGaSOC3A3O/6Msz37rcxXGOwkc2PRSJpmWcfCUsTNNBCECypcwgTNEelN6m1GH2RCTclEQyuwurK66YRY50I5cBL6THTKj7GMKyIKukqZUkbvBrKgjfeHzazuoFrYhhl+lYYC1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzuWYNl7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzuWYNl7"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-701b0b0be38so1401584b3a.0
        for <git@vger.kernel.org>; Wed, 29 May 2024 00:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716966273; x=1717571073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjntirJwz5N0hilgEj+W5M3lOc4eyCJjtBTq8ybzxHc=;
        b=VzuWYNl7ASIW/ULGkhccka+o8awBw3ep3p0Aw7VIhGh+gzfzFBr6dlbEuBjF29VA2/
         /9MZ1PcbPKMO8bjaiCEvyq07uufs/1dtO5ZPhECbLSEBfeSBQE7ksPM62GocrACHL17j
         Qcjm/3LIrJnyR8DGLqe8aiaQFPBuIH09AehewBrvcUnH74xMwUK20xOI/iJbL5gaYyHM
         euxSmOTVGMxwPSTM5jD0P8wRFsoQ60hJ/tzYmSRCQBOzbclp4/XZLtKsqiPJXnXei/Eu
         hdks/1syrloTuXzJ2vxz4UhGLqO8SlcZpYaO/Qsm9aLyvfvff9XBCtu5Ecv4L7+yMP9Y
         5kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966273; x=1717571073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjntirJwz5N0hilgEj+W5M3lOc4eyCJjtBTq8ybzxHc=;
        b=aVBi7EDkQS6PTE1jzXPZTMay3KU5leIcFhiM0rmqKp9aOZiY5rEP/fhSkTJ5GlZ4+3
         Jl6HCmar1027ONhVcgQt20jd2U7BIoiyMy9G7UNxixVKiYEYGrNO963wx4bUssKAjhZG
         tnU2VJZa9T3DtRKPfwwG3VwsK32F5NsQzP5viHdmzQxCGSfUIWe4C/VjrxSkoBcPK6bc
         EckhHDlwhdk7GC1yg0fpLMkllMq17LqzZJE6ecaitDZDAyz1KTgTysjkzRtGLO3UL+Oo
         XRVVu88c+vk0Glhx/EEBMwx6lRGSgj/Bo1+jaGmv1GGeuThhNVwyLUsezLtK4XbIbCDf
         rUag==
X-Gm-Message-State: AOJu0YwxAvRfp52TugNjkgxjYnW9JYj5EWIJWeErh1NopuPlp1uxZ3Ci
	A7+xvknQHWGGFLFCjZexndI1V/sKA/8lzRU2mRN1KPBWZgESICXOfimZioxwYxY=
X-Google-Smtp-Source: AGHT+IG7J1RS6sEmSiviaT40PTh3sqH+Hd5jERVtOp8xlARzsKLmMDnBy6CHs4VEh9w/vPoP37FY4g==
X-Received: by 2002:a05:6a00:8c11:b0:6e7:4abe:85a0 with SMTP id d2e1a72fcca58-6f8f3916015mr14997185b3a.14.1716966273307;
        Wed, 29 May 2024 00:04:33 -0700 (PDT)
Received: from Ubuntu.. ([171.51.188.185])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ea03sm7473376b3a.39.2024.05.29.00.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:04:32 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v2 1/4] t: move reftable/basics_test.c to the unit testing framework
Date: Wed, 29 May 2024 12:25:09 +0530
Message-ID: <20240529070341.4248-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240529070341.4248-1-chandrapratap3519@gmail.com>
References: <--in-reply-to=20240528113856.8348-1-chandrapratap3519@gmail.com>
 <20240529070341.4248-1-chandrapratap3519@gmail.com>
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

