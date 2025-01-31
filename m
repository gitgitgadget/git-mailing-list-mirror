Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FF1F428A
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738361684; cv=none; b=txc6d9C4A0cwr1UW3pQmI4M5W1a/gFlIhpU+Zx+o3h0HZ/prjX/zmJcl2iLDs7lrrkbrDpENXIYferYk3rPytS6pH9mXcw+mxoK/6MBk1MwxWFaIjpKEJGDI9TjJZcqmQABWzVobvTAa83BhhlG4t0c7ACZkb7XvBnq5oGoK9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738361684; c=relaxed/simple;
	bh=pnaZI3AYjZdwYsLcGZfAj0vZF4dU5BZDi84EVS12oOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xi+VtehkOxQhd5fRJY9KOpf6+/viSws5MlwGOxfunmIWxK/C8R+kOR17xBdm39LH6bT/2DVM7vsYxqlav7zC7phaBHtUQOEJgbNbB0bu0AOeTqSeSMv9WfK1kTgYbSAW2Igp2vmTPz7UrLQWiJ+sxx+AGF7LnaizBXTpMZS+euw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqYlXAPL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqYlXAPL"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so3849403a12.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 14:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738361681; x=1738966481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTz+u+xh5ejnDHgZnUTHlZu9tLo7KlskV/grW18aj5I=;
        b=GqYlXAPLFsEP8U5OWnAX7zCu1JEkk8dKE/yWg+FmqP56/otOHTkehcdb18ehY72ZfG
         Pp8pNLLmAVS9USolMHCXKv9y4BswONsISpShXT6uCE+JhPilNLEISZfXegl0KTGyEUG7
         pbrSvYVeuoATQ/XSzgOTi7VTsoIx09SN3u6mfxBRuQaH6DT1U7LvvKWARNVsnGoGbkDC
         GWCZqMYHaZ8PZVhbywnV/lLytzIVFlzV5GXn8raWhpzo2dzOb1qWm/Q0viCy3Wo2c+ts
         Xl867JJNA/igVAOfrKxxvnZvHZ7awTPmtaaRPBfOGtHwjMKBiTy7L2mw32Jam6LBTT37
         WzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738361681; x=1738966481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTz+u+xh5ejnDHgZnUTHlZu9tLo7KlskV/grW18aj5I=;
        b=NjfgVofY/ohRLq+zb9qb1RiGwjvfVyfaLUZIoswKPIs9MAraqEMo+387QtQOO29ehy
         SmRq9anoKE6yOq26b0MTK416zd/cuWcVTlJqcqEX6kmbhGdO0Aq3RKohS/pGjjXsS7AF
         E4jvhPB+vk7eClHcOqapnOhduQZm4iOMrRbT024B7FrlevrFWAYYBPZLDN2dPuqHvQ5m
         AL46iVS7+FXEOkA77tOqPY5qIpYOPhmNybxLzYP4zPzgEyt2JgexzDY5pAPCN88VFeJc
         AmIKO9nPsBBBZ66DNc7igXGBCNoQnYR2Cfup4UZwoxABKV/89kFt+C3SNh6Kg8MueNEd
         6ehA==
X-Gm-Message-State: AOJu0Yyamd0aA/v3w+/EqKPli4F4MmpZt3HCMpZt6M1tBYQHc4eB6tIM
	2dReXC9sVhVkJ2SOWo3zd81JXrwgYz7HMWKlpE5asoevY6yU4u6phbsNOevPYShlDw==
X-Gm-Gg: ASbGncuNYsfbh0W0N3Yze88incdxbeU/vkDa0Cq4Aohq2xnGb89+/B9tBpqtFlszBHD
	WFY+tpkm4pX5wOUtz8Ee90rUTFd7K9mid+HN6W2ymUtvg98wHFmBC3MHaZ0NqTIBxKLUJprRDkI
	BXcycNskABKruYiXbnzQz175QbwWRBkTef1t3dqXjQj7w02BTWpqvL717o7mjYDntSdf2M3KBt6
	3viCC6dmSPPFauY5WkjR06kU7G2GJPrrvgYy6nwKXr5IwJOsMnGgDFrIKkMUjPPdmOW7U+kveN1
	4fQ+LKJru7FNCud9PG/Pg1ifSyJ7UUQ=
X-Google-Smtp-Source: AGHT+IGF4sy9IVgd4oOCCoU4akjjeq7cSV4tq8WmmZO8bNZXEPaUqvRYsN7PVXhsTH1FXsnXKGrdwg==
X-Received: by 2002:a05:6402:4309:b0:5d0:fb56:3f with SMTP id 4fb4d7f45d1cf-5dc5efbf5d8mr31753142a12.12.1738361680958;
        Fri, 31 Jan 2025 14:14:40 -0800 (PST)
Received: from localhost.localdomain ([154.120.111.177])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab6e49ff77fsm359288966b.108.2025.01.31.14.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 14:14:39 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 4/4] t/unit-tests: convert strcmp-offset test to use clar test framework
Date: Fri, 31 Jan 2025 23:14:20 +0100
Message-ID: <20250131221420.38161-5-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250131221420.38161-1-kuforiji98@gmail.com>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
 <20250131221420.38161-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt strcmp-offset test script to clar framework by using clar
assertions where necessary. Introduce `test_strcmp_offset__empty()` to
verify `check_strcmp_offset()` behavior when both input strings are
empty. This ensures the function correctly handles edge cases and
returns expected values.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                      |  2 +-
 t/meson.build                                 |  2 +-
 .../{t-strcmp-offset.c => u-strcmp-offset.c}  | 36 ++++++++++++-------
 3 files changed, 25 insertions(+), 15 deletions(-)
 rename t/unit-tests/{t-strcmp-offset.c => u-strcmp-offset.c} (39%)

diff --git a/Makefile b/Makefile
index 358193597f..76b5de4fdd 100644
--- a/Makefile
+++ b/Makefile
@@ -1345,6 +1345,7 @@ CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
+CLAR_TEST_SUITES += u-strcmp-offset
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
@@ -1362,7 +1363,6 @@ UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
-UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGRAMS += t-urlmatch-normalization
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
diff --git a/t/meson.build b/t/meson.build
index 6cb72842b1..3935782bbb 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -7,6 +7,7 @@ clar_test_suites = [
   'unit-tests/u-prio-queue.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
+  'unit-tests/u-strcmp-offset.c',
   'unit-tests/u-strvec.c',
 ]
 
@@ -58,7 +59,6 @@ unit_test_programs = [
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
-  'unit-tests/t-strcmp-offset.c',
   'unit-tests/t-trailer.c',
   'unit-tests/t-urlmatch-normalization.c',
 ]
diff --git a/t/unit-tests/t-strcmp-offset.c b/t/unit-tests/u-strcmp-offset.c
similarity index 39%
rename from t/unit-tests/t-strcmp-offset.c
rename to t/unit-tests/u-strcmp-offset.c
index 6880f21161..7e8e9acf3c 100644
--- a/t/unit-tests/t-strcmp-offset.c
+++ b/t/unit-tests/u-strcmp-offset.c
@@ -1,4 +1,4 @@
-#include "test-lib.h"
+#include "unit-test.h"
 #include "read-cache-ll.h"
 
 static void check_strcmp_offset(const char *string1, const char *string2,
@@ -15,21 +15,31 @@ static void check_strcmp_offset(const char *string1, const char *string2,
 			result > 0 ? 1 :
 			0);
 
-	check_int(result, ==, expect_result);
-	check_uint((uintmax_t)offset, ==, expect_offset);
+	cl_assert_equal_i(result, expect_result);
+	cl_assert_equal_i((uintmax_t)offset, expect_offset);
 }
 
-#define TEST_STRCMP_OFFSET(string1, string2, expect_result, expect_offset) \
-	TEST(check_strcmp_offset(string1, string2, expect_result,          \
-				 expect_offset),                           \
-	     "strcmp_offset(%s, %s) works", #string1, #string2)
+void test_strcmp_offset__empty(void)
+{
+	check_strcmp_offset("", "", 0, 0);
+}
+
+void test_strcmp_offset__equal(void)
+{
+	check_strcmp_offset("abc", "abc", 0, 3);
+}
 
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
+void test_strcmp_offset__different(void)
 {
-	TEST_STRCMP_OFFSET("abc", "abc", 0, 3);
-	TEST_STRCMP_OFFSET("abc", "def", -1, 0);
-	TEST_STRCMP_OFFSET("abc", "abz", -1, 2);
-	TEST_STRCMP_OFFSET("abc", "abcdef", -1, 3);
+	check_strcmp_offset("abc", "def", -1, 0);
+}
 
-	return test_done();
+void test_strcmp_offset__mismatch(void)
+{
+	check_strcmp_offset("abc", "abz", -1, 2);
+}
+
+void test_strcmp_offset__different_length(void)
+{
+	check_strcmp_offset("abc", "abcdef", -1, 3);
 }
-- 
2.47.0.86.g15030f9556

