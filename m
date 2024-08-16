Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4DF1C3F25
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830898; cv=none; b=Ll1+PNHmWkyZdMJT2jKruSgabbcma1E+X5oqTJe3s0Udnr2mFbMoxCNAyxm4a18w/+DC1zk6v9gmqVy6kwcdOZ18MN32CFabXRt76I/lpon716inNcyYg4zASIzdrc6y3SKNLG8jAZcs9p038G+amSoHonlAcvTUJamKgOEEXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830898; c=relaxed/simple;
	bh=agZnrMOtyNjNzuJqUc7XskvIpJQwL7dokPxm5FKsbaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhUbDC8eGSk+wgi/+EqA0JqeYW1O5HEmqeD2Hp5DTVvDu/M+4w5VS7OMjOJeb+Mufqs/AFH0sc3CLiR7TDtDhVCwyvcA58siOnul5AfVOhkWBeIoZNNfZQSlZCW+FnhLijaNZCISNxjeu0xfa8bCSX+IL2AKHF7lXkttEamfeeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mO7UH4Fu; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO7UH4Fu"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7b594936e9bso1562717a12.1
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723830895; x=1724435695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPViukUUlapprpV9Rr9pSwpDCDAk1R+nEMTnVCtTuyk=;
        b=mO7UH4FuXZzd2BQVXpT1KVyx24blX/YPTO7vd2oe+xC2CtYQCl7t/raTMIGMozT6W7
         riINcXAti42gej5BNBuCySdNJ4oKH1XYLchLZAmP5XiOHG8Jjok1d9KQJlAi+aU0BNbm
         KyAcw4lPQDTQ7obnG/kF3P+SmqMOj9jxB4/b975Ghwq66oTPaCzkv+9dqOAfuyzMKoCg
         U0EcZ5Zzu0dRa+pJNB2SB85GfsrKPpC6pNnzayXeU/pvEunbMDmbnJSNWq0k0mgSA6ww
         k2DGngXMpQ5h3roMVYGnrauQTfn6FpghGG+5IrkyzGoG50Xo6Q/QP0LmgK4LhJ2TFMcH
         2nEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830895; x=1724435695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPViukUUlapprpV9Rr9pSwpDCDAk1R+nEMTnVCtTuyk=;
        b=kFDVcbQyatFlI9nWhjJCd1RSCpftAuC7Svw9FUKIcHTT7mGLLXafD61q2eSbSVvnLC
         UtscnNBJpphaNqjTkyUR+fu4iFAd06UdjZVx0j+ApmBSgC7meR9xW4S3jzPQ1VG6OJt5
         jDX2jqdcsVJpO8j5Si8Cd31u5S/Uf9kIXsRi1lNBvRUlA7YfAsaZ+n+TIffYTX3sP4HC
         ZATyQzjeoXLyYOmPXqDQ5pg5R5vYy1QS7GNjD5q2yFbgcLW5kZYvCtk+xX2D3RZVLifS
         YjOZzcpY3j2yKS4OByLcLOZm6ie6E5H4zqEakHWi+f9/vcsC5j8zET7rcbAetwA+keLC
         bhtw==
X-Gm-Message-State: AOJu0YxkZPdX2qmo3r7x220h695DQe2caXrhwTM1Y5crE/YZgbnK+yQg
	mPZ5aVqGouP1HxfIPPDrfL22aB/LpeVEIlsUu+FyRqciV7U9Ulc0Wqfk5Q==
X-Google-Smtp-Source: AGHT+IGnmFnR0UPv8IY1+icuWOF8SeHRojsIXEDV+7YBWFFXvNIVqRjSkiGU39YJBXT5GyI/31GJhg==
X-Received: by 2002:a05:6a20:ac43:b0:1c0:e9dd:1197 with SMTP id adf61e73a8af0-1caa3625859mr467054637.22.1723830895295;
        Fri, 16 Aug 2024 10:54:55 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.209])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af1e907sm2985600b3a.173.2024.08.16.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:54:54 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 01/11] t: move reftable/block_test.c to the unit testing framework
Date: Fri, 16 Aug 2024 22:55:24 +0530
Message-ID: <20240816175414.5169-2-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240816175414.5169-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240816175414.5169-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable/block_test.c exercises the functions defined in
reftable/block.{c, h}. Migrate reftable/block_test.c to the unit
testing framework. Migration involves refactoring the tests
to use the unit testing framework instead of reftable's test
framework and renaming the tests to follow the unit-tests'
naming conventions.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 Makefile                                      |  2 +-
 reftable/reftable-tests.h                     |  1 -
 t/helper/test-reftable.c                      |  1 -
 .../unit-tests/t-reftable-block.c             | 45 +++++++++----------
 4 files changed, 22 insertions(+), 27 deletions(-)
 rename reftable/block_test.c => t/unit-tests/t-reftable-block.c (76%)

diff --git a/Makefile b/Makefile
index 13890710f8..a30cd636f8 100644
--- a/Makefile
+++ b/Makefile
@@ -1340,6 +1340,7 @@ UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
+UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-pq
 UNIT_TEST_PROGRAMS += t-reftable-record
@@ -2681,7 +2682,6 @@ REFTABLE_OBJS += reftable/stack.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 
-REFTABLE_TEST_OBJS += reftable/block_test.o
 REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/readwrite_test.o
 REFTABLE_TEST_OBJS += reftable/stack_test.o
diff --git a/reftable/reftable-tests.h b/reftable/reftable-tests.h
index 4b666810af..3d9118b91b 100644
--- a/reftable/reftable-tests.h
+++ b/reftable/reftable-tests.h
@@ -10,7 +10,6 @@ license that can be found in the LICENSE file or at
 #define REFTABLE_TESTS_H
 
 int basics_test_main(int argc, const char **argv);
-int block_test_main(int argc, const char **argv);
 int record_test_main(int argc, const char **argv);
 int readwrite_test_main(int argc, const char **argv);
 int stack_test_main(int argc, const char **argv);
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 623cf3f0f5..7bdd18430b 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -5,7 +5,6 @@
 int cmd__reftable(int argc, const char **argv)
 {
 	/* test from simple to complex. */
-	block_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
 	stack_test_main(argc, argv);
 	return 0;
diff --git a/reftable/block_test.c b/t/unit-tests/t-reftable-block.c
similarity index 76%
rename from reftable/block_test.c
rename to t/unit-tests/t-reftable-block.c
index 90aecd5a7c..f2b9a8a6f4 100644
--- a/reftable/block_test.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -6,17 +6,13 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
-#include "block.h"
+#include "test-lib.h"
+#include "reftable/block.h"
+#include "reftable/blocksource.h"
+#include "reftable/constants.h"
+#include "reftable/reftable-error.h"
 
-#include "system.h"
-#include "blocksource.h"
-#include "basics.h"
-#include "constants.h"
-#include "record.h"
-#include "test_framework.h"
-#include "reftable-tests.h"
-
-static void test_block_read_write(void)
+static void t_block_read_write(void)
 {
 	const int header_off = 21; /* random */
 	char *names[30];
@@ -45,7 +41,7 @@ static void test_block_read_write(void)
 	rec.u.ref.refname = (char *) "";
 	rec.u.ref.value_type = REFTABLE_REF_DELETION;
 	n = block_writer_add(&bw, &rec);
-	EXPECT(n == REFTABLE_API_ERROR);
+	check_int(n, ==, REFTABLE_API_ERROR);
 
 	for (i = 0; i < N; i++) {
 		char name[100];
@@ -59,11 +55,11 @@ static void test_block_read_write(void)
 		n = block_writer_add(&bw, &rec);
 		rec.u.ref.refname = NULL;
 		rec.u.ref.value_type = REFTABLE_REF_DELETION;
-		EXPECT(n == 0);
+		check_int(n, ==, 0);
 	}
 
 	n = block_writer_finish(&bw);
-	EXPECT(n > 0);
+	check_int(n, >, 0);
 
 	block_writer_release(&bw);
 
@@ -73,11 +69,11 @@ static void test_block_read_write(void)
 
 	while (1) {
 		int r = block_iter_next(&it, &rec);
-		EXPECT(r >= 0);
+		check_int(r, >=, 0);
 		if (r > 0) {
 			break;
 		}
-		EXPECT_STREQ(names[j], rec.u.ref.refname);
+		check_str(names[j], rec.u.ref.refname);
 		j++;
 	}
 
@@ -90,20 +86,20 @@ static void test_block_read_write(void)
 		strbuf_addstr(&want, names[i]);
 
 		n = block_iter_seek_key(&it, &br, &want);
-		EXPECT(n == 0);
+		check_int(n, ==, 0);
 
 		n = block_iter_next(&it, &rec);
-		EXPECT(n == 0);
+		check_int(n, ==, 0);
 
-		EXPECT_STREQ(names[i], rec.u.ref.refname);
+		check_str(names[i], rec.u.ref.refname);
 
 		want.len--;
 		n = block_iter_seek_key(&it, &br, &want);
-		EXPECT(n == 0);
+		check_int(n, ==, 0);
 
 		n = block_iter_next(&it, &rec);
-		EXPECT(n == 0);
-		EXPECT_STREQ(names[10 * (i / 10)], rec.u.ref.refname);
+		check_int(n, ==, 0);
+		check_str(names[10 * (i / 10)], rec.u.ref.refname);
 
 		block_iter_close(&it);
 	}
@@ -116,8 +112,9 @@ static void test_block_read_write(void)
 	}
 }
 
-int block_test_main(int argc, const char *argv[])
+int cmd_main(int argc, const char *argv[])
 {
-	RUN_TEST(test_block_read_write);
-	return 0;
+	TEST(t_block_read_write(), "read-write operations on blocks work");
+
+	return test_done();
 }
-- 
2.45.GIT

