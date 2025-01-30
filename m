Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDD61AF0BA
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228446; cv=none; b=EVy7JsMDBfcH/EwgUZvpJFsnibW5IE0204iNTTBVY99J4+6Z9LL47nPD9FeMEo5eUb/ZK5DL5kCumMkuUIB1dtb4dv57i1jA7E/yuqYgYfaMmZ5QlCtY85yQQAT1ckYA3vD8QZWfhUjXOICWYrhKuQ1sNyfHRwwMaQPKTRRRlEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228446; c=relaxed/simple;
	bh=702jeXmUPylhU+WEiB3HlXCL2hZl27qbN/CM3OT7SSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdLvPj1kBcA4YUyLxuv5ART36kU0uAmoqEKwoVtgBlYQKq7cno3vzyvEQXMFJlx2w+Sa801F+rv4wiiLzrZbCFn8JBXj2RNi4yo2kd8xKHtLB2QZba1KlSD2U2k6DntcTG3oe3AbUr/PbUu+GCajN1+l/bweR1QvExfKmIqS09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMNfFU1q; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMNfFU1q"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaedd529ba1so84368866b.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 01:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738228443; x=1738833243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oCyTA0uGOjzFWATG+1/OHeBJHmQkYy6F9RxFloHXTs=;
        b=SMNfFU1q336fqS7BsYu1FEKacc+mA6lf2gOqmNLqLpeLvlQqUqtgVveISZKq9Efn7M
         gEe3L1NB31cTx0DZdM7Siqq8AWpMoyMndrjjvQdGHY9O8Y9sk/txnXlpwQE3fFHQ7kJ5
         UXIQdXPuilEJlqNhZ4/A+doW5gl94Dkrfqc+5dd6fwsHfpgldhov/TNqtQuRGZtDx0TC
         A1vhGFhXphFVayPManG6f0pQU/gBALm6HzpcQNGWa7oZNJj+Z9aZuTGJhPxdkhGx05mY
         npX1Opn5unkuNTquL7zrgwvDxbJyRpL2E9qy9f4JiAg4yjL5PyhuOGDBe8G0fpzXr8sF
         bDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738228443; x=1738833243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oCyTA0uGOjzFWATG+1/OHeBJHmQkYy6F9RxFloHXTs=;
        b=fnl7/bFB0pwSGT4JdQasU8Xn4W4LdRPlhJP4zk9p86zNl7UQmx7EBC5NzcxLnsYb59
         vioVrdKHswpUffHsWqcH6ypyr/4eGLwYCNJZDSEvLAsGIipBSbuf5BokW03h6q98BSrQ
         sgDCEtwQ4/oOggnLVNHOFnHezCW+PIRhhwqpR/iLK9ehFHJeZedLHTiSV6DQgJNUA1yt
         tj/c9047hVxHXHkfJX6CxHNtuu+Lorkz7eJ9WaCE1z/WVAzsWToX1ar/cD5H1guHeB1s
         mFaKBhz5m38WV+8FQNNmRVvBIJl7Jw39SrdYhTCh2Q87J9jEbx1pKLi/OevkkoT/8ggm
         jT6g==
X-Gm-Message-State: AOJu0YxcqjBbn7xAx5MQws2UaZtgBs4MXytv8uiiNMcxCQG0mO8sON0n
	lGF514sZj3rz0lMh6HTNX3haikJfAidFWxo1svGBE+cq+EF5+vwPIfzo06Er+9kG0g==
X-Gm-Gg: ASbGncsohpVtZdC7Mbso3Zz1Np9K8D2Gtgp8paND/pm+QzipgjFR9p5Y/xseotuxT9J
	Nq0RlabtlbG4SPWoAnMPaogvwevaTfcb3uFzsNI3FLzFIXRRsjBWN/1gF5PN1EEXQ3mZIfVAlhc
	2EJWGd13J09jPzq5fyV6xFCeOSKsO9DXu6ZcDkCwDENBaIifrt0nd+ciu+mQ/12F/RYAGjVak5R
	csc0nyK2JfS+ZO/dkC4Y8Zm/3U8QruePfYh5QFpfcAuxYYn7g3VQYXG7FPt/HkEfroZi8HA+zqd
	izhi8deNGf7DJfj70EDTJ5XyPvehLg==
X-Google-Smtp-Source: AGHT+IFOhLQs4g4IFaLqodhecsp0vg11iUX5Ojn4RfKk8XYMxqVGPRoRD2Rb+ryTiK33pBYYYYgRVw==
X-Received: by 2002:a05:6402:358e:b0:5da:1219:c81 with SMTP id 4fb4d7f45d1cf-5dc5efc5d27mr14484703a12.16.1738228442381;
        Thu, 30 Jan 2025 01:14:02 -0800 (PST)
Received: from localhost.localdomain ([154.120.90.178])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723e9ee4sm742249a12.25.2025.01.30.01.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 01:14:01 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 4/4] t/unit-tests: convert strcmp-offset test to clar framework
Date: Thu, 30 Jan 2025 10:13:34 +0100
Message-ID: <20250130091334.39922-5-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250130091334.39922-1-kuforiji98@gmail.com>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt strcmp-offset test script to clar framework by using clar
assertions where necessary. Test functions are created as standalone to
test different test cases.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                       |  2 +-
 t/meson.build                  |  2 +-
 t/unit-tests/t-strcmp-offset.c | 35 --------------------------
 t/unit-tests/u-strcmp-offset.c | 45 ++++++++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 37 deletions(-)
 delete mode 100644 t/unit-tests/t-strcmp-offset.c
 create mode 100644 t/unit-tests/u-strcmp-offset.c

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
diff --git a/t/unit-tests/t-strcmp-offset.c b/t/unit-tests/t-strcmp-offset.c
deleted file mode 100644
index 6880f21161..0000000000
--- a/t/unit-tests/t-strcmp-offset.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include "test-lib.h"
-#include "read-cache-ll.h"
-
-static void check_strcmp_offset(const char *string1, const char *string2,
-				int expect_result, uintmax_t expect_offset)
-{
-	size_t offset;
-	int result = strcmp_offset(string1, string2, &offset);
-
-	/*
-	 * Because different CRTs behave differently, only rely on signs of the
-	 * result values.
-	 */
-	result = (result < 0 ? -1 :
-			result > 0 ? 1 :
-			0);
-
-	check_int(result, ==, expect_result);
-	check_uint((uintmax_t)offset, ==, expect_offset);
-}
-
-#define TEST_STRCMP_OFFSET(string1, string2, expect_result, expect_offset) \
-	TEST(check_strcmp_offset(string1, string2, expect_result,          \
-				 expect_offset),                           \
-	     "strcmp_offset(%s, %s) works", #string1, #string2)
-
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
-{
-	TEST_STRCMP_OFFSET("abc", "abc", 0, 3);
-	TEST_STRCMP_OFFSET("abc", "def", -1, 0);
-	TEST_STRCMP_OFFSET("abc", "abz", -1, 2);
-	TEST_STRCMP_OFFSET("abc", "abcdef", -1, 3);
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-strcmp-offset.c b/t/unit-tests/u-strcmp-offset.c
new file mode 100644
index 0000000000..7e8e9acf3c
--- /dev/null
+++ b/t/unit-tests/u-strcmp-offset.c
@@ -0,0 +1,45 @@
+#include "unit-test.h"
+#include "read-cache-ll.h"
+
+static void check_strcmp_offset(const char *string1, const char *string2,
+				int expect_result, uintmax_t expect_offset)
+{
+	size_t offset;
+	int result = strcmp_offset(string1, string2, &offset);
+
+	/*
+	 * Because different CRTs behave differently, only rely on signs of the
+	 * result values.
+	 */
+	result = (result < 0 ? -1 :
+			result > 0 ? 1 :
+			0);
+
+	cl_assert_equal_i(result, expect_result);
+	cl_assert_equal_i((uintmax_t)offset, expect_offset);
+}
+
+void test_strcmp_offset__empty(void)
+{
+	check_strcmp_offset("", "", 0, 0);
+}
+
+void test_strcmp_offset__equal(void)
+{
+	check_strcmp_offset("abc", "abc", 0, 3);
+}
+
+void test_strcmp_offset__different(void)
+{
+	check_strcmp_offset("abc", "def", -1, 0);
+}
+
+void test_strcmp_offset__mismatch(void)
+{
+	check_strcmp_offset("abc", "abz", -1, 2);
+}
+
+void test_strcmp_offset__different_length(void)
+{
+	check_strcmp_offset("abc", "abcdef", -1, 3);
+}
-- 
2.47.0.86.g15030f9556

