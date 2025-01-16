Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F858635B
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044189; cv=none; b=Qis2LK4uEt8wI7XAFCFzbENie+6R4E6COqSuPhXSznEojUqlUUafHmV/96NzgVQciFDXNjPnYyxAsjbKcKD2UFugTaIZ+XCSba/Cm1/fVyXLr/AwYInkv9y7i/44/7QHS187C9D5UJeKOFkHDJzko20tf8ewuHR6uFJ52tVLwFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044189; c=relaxed/simple;
	bh=0PfZZchRGvwEj9MKjZkX2TKoeQjjs9/nibor6yetpWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LweQWARwqPrrcYoo+Ndx42VvMf/qIm9bOTCKTmQ7qlSyhzhKouuSe+IsnbgvBfo2rBWTVrEkBbSaq3v09ytNBhkAWvAWnQkNuoycAVC40X+Ai250Dru0eeaDWHwUTtdlBpOz11ArHJT1xSiaS7pXRar1+fy2g+grnz/Ko1GTd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTF/8mmx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTF/8mmx"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso7458705e9.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 08:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737044186; x=1737648986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2D1ZQgyigSiR29ims/9YVQ82J01XGMI+3TgqZULvx0=;
        b=GTF/8mmx+wENRMu+ldiwMuYOpbmPCr3EDpBwSVQStgT8SJ5ToUlqk+z51K3BEX2ULL
         9FhYujStJm4+6DejxmBGHE8w/wGOkgaVi01vJFCGkHADmVPc9Bq5fu0xJpWc6NfRhmwc
         LPFnWZCGGWRU+cvINYPRX0tZvEieZWNjP2hEG9YY7ZP3jUQGN/gBIcFjiIanXG7+9v0W
         Usxnu2TTB1SrlKZvPR6LaVDcBx5qoMu6A4gkVLV3E42hf5EiNyYEAmeyF7iqtsxWAk0M
         Q393CPC9C49z7c6D1mWbZHFg3ZQBqw4WmHnwL9ksKIHikDs5m1f11EkWU6e86jS2cjnv
         8yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044186; x=1737648986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2D1ZQgyigSiR29ims/9YVQ82J01XGMI+3TgqZULvx0=;
        b=aNeuQUFg6D3oB1tlRHV6C847yBH6S5hczhcJWo72lxEuzGY38qXf9q/ePBcmvgmWKO
         SrnQFPZvgdAxaGZ2/y4nOHwYhCQjBJFtOhWVl027Qg+jJJjsP5GeZ3NIH4s362w5c7IZ
         txepshcZN5OyDKvFlnM4IpHLsq1ayRriFumkZARY4eBYm9oE+UyFgRKpITo9hXhnB6SQ
         mG9ZtXg9PWXIlZT7Ta+ktwFGU+GxD4IxQIX9HVSTdGR88ITFZAE0iROzlbtz3e/r97U0
         GtLLJJt5UW7jmtWpD5fDummnWZ0loPjmfeBuS5t/2Z7fYWGvJcYWTANtsBNeuBombNmT
         xlfQ==
X-Gm-Message-State: AOJu0Yzt5KVAqtNw6BbvCnbsT8eEjlaVhX5SME9Z9UHNRpmHgRBbapIr
	0xnA6nGWv9ZU5hTFrRLzRa656CuPe6V7ESGjXR6c1CT5oxBMO2jTFBpkxhJKgvFHfQ==
X-Gm-Gg: ASbGncvtfr5gqNz6d4Yy/zQ33ynr72Z9UEWclmS6PhVQrC5vF8bXzxW3pIaLL1H6QSJ
	l6T/g22/CgtoMUlc5NGw75/SgYf9EaTyeADR30qxuVzFGInvGZojiMfR5bavIiXMfXwRX2IM9JC
	8pLvSdtCSpbqKgbggmGeqRvNS7VxJNj/+Ol9oLw/2mp8uiWXCbYnfvC8AwqqZ/Tsibsis3wfcva
	Q8pPcOT6n/qroqrWKRCtIt76C4pMFb4Eg1nCVm5NIOczTgdmFbdomKZeCHTT2ZCxUQ9yg==
X-Google-Smtp-Source: AGHT+IFiCDJUySSs8Bf6AL+vUQWxXvxImeplISB9CfVvUY571wlC4BMEnLAanIB3B9ifnGZqiJw0wA==
X-Received: by 2002:a05:600c:1e09:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-437c6a89cc3mr64688895e9.0.1737044185549;
        Thu, 16 Jan 2025 08:16:25 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-437c752935csm63177025e9.26.2025.01.16.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:16:25 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 3/4] t/unit-tests: adapt priority queue test to use clar test framework
Date: Thu, 16 Jan 2025 17:15:58 +0100
Message-ID: <20250116161559.91038-4-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250116161559.91038-1-kuforiji98@gmail.com>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
 <20250116161559.91038-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the prio-queue test script to clar framework by using clar
assertions where necessary. Test functions are created as a standalone
to test different cases.

update the type of the variable `j` from int to `size_t`, this ensures
compatibility with the type used for result_size, which is also size_t,
preventing a potential warning or error caused by comparisons between
signed and unsigned integers.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                    |  2 +-
 t/meson.build               |  2 +-
 t/unit-tests/t-prio-queue.c | 91 -----------------------------------
 t/unit-tests/u-prio-queue.c | 94 +++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 93 deletions(-)
 delete mode 100644 t/unit-tests/t-prio-queue.c
 create mode 100644 t/unit-tests/u-prio-queue.c

diff --git a/Makefile b/Makefile
index 49ada4169d..049f857512 100644
--- a/Makefile
+++ b/Makefile
@@ -1339,6 +1339,7 @@ THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
 CLAR_TEST_SUITES += u-ctype
 CLAR_TEST_SUITES += u-mem-pool
+CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
@@ -1351,7 +1352,6 @@ UNIT_TEST_PROGRAMS += t-hashmap
 UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
-UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
diff --git a/t/meson.build b/t/meson.build
index ffe951f9be..09232967cd 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1,6 +1,7 @@
 clar_test_suites = [
   'unit-tests/u-ctype.c',
   'unit-tests/u-mem-pool.c',
+  'unit-tests/u-prio-queue.c',
   'unit-tests/u-strvec.c',
 ]
 
@@ -47,7 +48,6 @@ unit_test_programs = [
   'unit-tests/t-oid-array.c',
   'unit-tests/t-oidmap.c',
   'unit-tests/t-oidtree.c',
-  'unit-tests/t-prio-queue.c',
   'unit-tests/t-reftable-basics.c',
   'unit-tests/t-reftable-block.c',
   'unit-tests/t-reftable-merged.c',
diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
deleted file mode 100644
index a053635000..0000000000
--- a/t/unit-tests/t-prio-queue.c
+++ /dev/null
@@ -1,91 +0,0 @@
-#include "test-lib.h"
-#include "prio-queue.h"
-
-static int intcmp(const void *va, const void *vb, void *data UNUSED)
-{
-	const int *a = va, *b = vb;
-	return *a - *b;
-}
-
-
-#define MISSING  -1
-#define DUMP	 -2
-#define STACK	 -3
-#define GET	 -4
-#define REVERSE  -5
-
-static int show(int *v)
-{
-	return v ? *v : MISSING;
-}
-
-static void test_prio_queue(int *input, size_t input_size,
-			    int *result, size_t result_size)
-{
-	struct prio_queue pq = { intcmp };
-	int j = 0;
-
-	for (size_t i = 0; i < input_size; i++) {
-		void *peek, *get;
-		switch(input[i]) {
-		case GET:
-			peek = prio_queue_peek(&pq);
-			get = prio_queue_get(&pq);
-			if (!check(peek == get))
-				return;
-			if (!check_uint(j, <, result_size))
-				break;
-			if (!check_int(result[j], ==, show(get)))
-				test_msg("      j: %d", j);
-			j++;
-			break;
-		case DUMP:
-			while ((peek = prio_queue_peek(&pq))) {
-				get = prio_queue_get(&pq);
-				if (!check(peek == get))
-					return;
-				if (!check_uint(j, <, result_size))
-					break;
-				if (!check_int(result[j], ==, show(get)))
-					test_msg("      j: %d", j);
-				j++;
-			}
-			break;
-		case STACK:
-			pq.compare = NULL;
-			break;
-		case REVERSE:
-			prio_queue_reverse(&pq);
-			break;
-		default:
-			prio_queue_put(&pq, &input[i]);
-			break;
-		}
-	}
-	check_uint(j, ==, result_size);
-	clear_prio_queue(&pq);
-}
-
-#define TEST_INPUT(input, result) \
-	test_prio_queue(input, ARRAY_SIZE(input), result, ARRAY_SIZE(result))
-
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
-{
-	TEST(TEST_INPUT(((int []){ 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP }),
-			((int []){ 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10 })),
-	     "prio-queue works for basic input");
-	TEST(TEST_INPUT(((int []){ 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP }),
-			((int []){ 2, 3, 4, 1, 5, 6 })),
-	     "prio-queue works for mixed put & get commands");
-	TEST(TEST_INPUT(((int []){ 1, 2, GET, GET, GET, 1, 2, GET, GET, GET }),
-			((int []){ 1, 2, MISSING, 1, 2, MISSING })),
-	     "prio-queue works when queue is empty");
-	TEST(TEST_INPUT(((int []){ STACK, 8, 1, 5, 4, 6, 2, 3, DUMP }),
-			((int []){ 3, 2, 6, 4, 5, 1, 8 })),
-	     "prio-queue works when used as a LIFO stack");
-	TEST(TEST_INPUT(((int []){ STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP }),
-			((int []){ 1, 2, 3, 4, 5, 6 })),
-	     "prio-queue works when LIFO stack is reversed");
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-prio-queue.c b/t/unit-tests/u-prio-queue.c
new file mode 100644
index 0000000000..145e689c9c
--- /dev/null
+++ b/t/unit-tests/u-prio-queue.c
@@ -0,0 +1,94 @@
+#include "unit-test.h"
+#include "prio-queue.h"
+
+static int intcmp(const void *va, const void *vb, void *data UNUSED)
+{
+	const int *a = va, *b = vb;
+	return *a - *b;
+}
+
+
+#define MISSING  -1
+#define DUMP	 -2
+#define STACK	 -3
+#define GET	 -4
+#define REVERSE  -5
+
+static int show(int *v)
+{
+	return v ? *v : MISSING;
+}
+
+static void test_prio_queue(int *input, size_t input_size,
+			    int *result, size_t result_size)
+{
+	struct prio_queue pq = { intcmp };
+	size_t j = 0;
+
+	for (size_t i = 0; i < input_size; i++) {
+		void *peek, *get;
+		switch(input[i]) {
+		case GET:
+			peek = prio_queue_peek(&pq);
+			get = prio_queue_get(&pq);
+			cl_assert(peek == get);
+			cl_assert(j < result_size);
+			cl_assert_equal_i(result[j], show(get));
+			j++;
+			break;
+		case DUMP:
+			while ((peek = prio_queue_peek(&pq))) {
+				get = prio_queue_get(&pq);
+				cl_assert(peek == get);
+				cl_assert(j < result_size);
+				cl_assert_equal_i(result[j], show(get));
+				j++;
+			}
+			break;
+		case STACK:
+			pq.compare = NULL;
+			break;
+		case REVERSE:
+			prio_queue_reverse(&pq);
+			break;
+		default:
+			prio_queue_put(&pq, &input[i]);
+			break;
+		}
+	}
+	cl_assert_equal_i(j, result_size);
+	clear_prio_queue(&pq);
+}
+
+#define TEST_INPUT(input, result) \
+	test_prio_queue(input, ARRAY_SIZE(input), result, ARRAY_SIZE(result))
+
+void test_prio_queue__basic(void)
+{
+	TEST_INPUT(((int []){ 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP }),
+		   ((int []){ 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10 }));
+}
+
+void test_prio_queue__mixed(void)
+{
+	TEST_INPUT(((int []){ 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP }),
+		   ((int []){ 2, 3, 4, 1, 5, 6 }));
+}
+
+void test_prio_queue__empty(void)
+{
+	TEST_INPUT(((int []){ 1, 2, GET, GET, GET, 1, 2, GET, GET, GET }),
+		   ((int []){ 1, 2, MISSING, 1, 2, MISSING }));
+}
+
+void test_prio_queue__stack(void)
+{
+	TEST_INPUT(((int []){ STACK, 8, 1, 5, 4, 6, 2, 3, DUMP }),
+		   ((int []){ 3, 2, 6, 4, 5, 1, 8 }));
+}
+
+void test_prio_queue__reverse_stack(void)
+{
+	TEST_INPUT(((int []){ STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP }),
+		   ((int []){ 1, 2, 3, 4, 5, 6 }));
+}
-- 
2.34.1

