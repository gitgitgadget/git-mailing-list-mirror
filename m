Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E41DED57
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745780102; cv=none; b=EpnXyINU/IX6sLpbW+xBOhmfI3Ng+PItItbOR+OjuPfWySuYD27/TiJCimefghvOePvZGPKHhQJBJ8Xdrrk7PfdKhysIhUUt18h2Lp7hVDQsjdXE4gPew+DhEAHjx6SlYW2rddn7XhzWsTrgCyuqdc25ZbwGny6uxJu/+qAmXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745780102; c=relaxed/simple;
	bh=TbOxqKrSumMrnrwyPC3NF8iwVluLdpLc3/OUuJ71a4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tazoRCJJ/fZbuHR/QllW6WJEC9CEsMdZrNe0cHnF25aAoq6WKtLBqGhDgjjcB81FMkDr7kVogJBM1GzrorgR9NLjP1LXMJQGzecIzt3MnvifnwulR1yyyrzLRqn5ZqcU1xMR0T40c49frTOjJ7A8HO7YzQqnLaF4RoyLaKUgGUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEB2vnQn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEB2vnQn"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39ee623fe64so3936598f8f.1
        for <git@vger.kernel.org>; Sun, 27 Apr 2025 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745780099; x=1746384899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmYqpYu3cc5LosX/d8TfQcpFFXs1s8BrZaMVw5pWiTU=;
        b=eEB2vnQnQdUKQW3ri0s7AlgCK6MuDP7Sfv4bhOOcG3+2QcfrtwhCANt+Zh10pGFrAg
         04CTmwyqq2su3IwDeIIEfuYUYdmLjvcNcu+jWtpW9750SZLgMeIVrhEBPAi8WujcGnQz
         5IkrwRHqTOHsQ1ZihXuYb1N7krfmmHoN0LR8ANLsqOH3BQO/GR1ClJALBq542AMsNG0e
         NJcafYp24qedzjmdZ5HWMAiy8HNIEGczIUpa7rE38faW8HSLnea8VxbKnLgKwFdzLk7G
         CQ+9LAiZM7m9mdqzd+IY+ww0QMggqdnxyE1UWYz80sDZVUp3pGXMxwSRMW0gufzOzkmv
         iSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745780099; x=1746384899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmYqpYu3cc5LosX/d8TfQcpFFXs1s8BrZaMVw5pWiTU=;
        b=pxoN00LbOpeW/2246+MBkboaRl3zui0Ta2/SSDWJxw10Xbhuc2CIVvkKTyaFWdJkqJ
         nxDzVfBZGb+94qoApNVMxDQ+3WLJITlNW0KYr1OsJQJI+wZZ1/zESyx01X2hjrYTnH3Y
         AWh88cVaixM9a2lEjyzuMiIGwpay6XalJTGSf6Ql0gdmdA/iDYbXxA3Kvaz3WEU9b9m6
         6cCBp+jqI0q9CgrfglMtm7Y/dxrNUJkDPjog9IL+kYyQQPDeeR4F2+GyXJeqAIJuAzpQ
         r0605Y/2eGPjjoEjv+/A2V7gzYaQWuKt4xz5nhCRKkDX34AYZ1duZfRVed0BZ6Xc6Now
         TWNA==
X-Gm-Message-State: AOJu0YytMlyUUwopPiTVd7ZvlCqfbPSE9RIOHqQhpjL7eHd2qhG97VP5
	TJLXvL1UlhWHsb846ppWYvCv0HlWpCYrVWVSeT53o5pyDGOjUsLGwL3Yxb+MnvRBaw==
X-Gm-Gg: ASbGncuU6/GrGMT3K5yj3KV2lp91wnogw7Su9EqjRXnJ8wyAhkjmxtjS0oEFVspkqu7
	K89ge3btrr1y8tAGQozmDsHcVQdvZo12uHUUGzkGHo1LkaiEm6ls1yVwO3Zte/lHpgkeCLtwddv
	2a5s7vCcoqiWJNC41a7+GkwKbm780Wu+SqhklysgiyQhWJ3zBKG9TqVzVtjKpKNWkRWybWS0dIX
	EdPKAA91u/RJ+QzpCe+haig26ivtpeT7j4UDvkHxq3teOgNs0cMum98c3RM3jveWjDbQaZCq94f
	dwEjx0AvIAV0SHYHfOslviEXy9HLo/IRnMM4JZh3ANpvWbU=
X-Google-Smtp-Source: AGHT+IEPyRugPktBmXIpR4YyLcmSG3BRDZmK7NrLcZRWbSbCdTHJzyJnUYeJS6GFs3IpQT2y9XrNZg==
X-Received: by 2002:a5d:5888:0:b0:38f:4d20:4a17 with SMTP id ffacd0b85a97d-3a074e1d7eemr7736612f8f.13.1745780098582;
        Sun, 27 Apr 2025 11:54:58 -0700 (PDT)
Received: from localhost.localdomain ([105.113.116.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cc74sm9150175f8f.11.2025.04.27.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 11:54:58 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 6/9] t/unit-tests: convert reftable reader test to use clar
Date: Sun, 27 Apr 2025 19:53:48 +0100
Message-ID: <20250427185351.82520-7-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250427185351.82520-1-kuforiji98@gmail.com>
References: <20250427185351.82520-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt reftable reader test file to use clar by using clar assertions
where necessary.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                         |  2 +-
 t/meson.build                    |  2 +-
 t/unit-tests/t-reftable-reader.c | 96 --------------------------------
 t/unit-tests/u-reftable-reader.c | 78 ++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 98 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-reader.c
 create mode 100644 t/unit-tests/u-reftable-reader.c

diff --git a/Makefile b/Makefile
index 060d89df7f..948eff1c5c 100644
--- a/Makefile
+++ b/Makefile
@@ -1366,6 +1366,7 @@ CLAR_TEST_SUITES += u-reftable-basics
 CLAR_TEST_SUITES += u-reftable-block
 CLAR_TEST_SUITES += u-reftable-merged
 CLAR_TEST_SUITES += u-reftable-pq
+CLAR_TEST_SUITES += u-reftable-reader
 CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
@@ -1379,7 +1380,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
-UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
diff --git a/t/meson.build b/t/meson.build
index 1e12bd1b96..43d52c4753 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -12,6 +12,7 @@ clar_test_suites = [
   'unit-tests/u-reftable-block.c',
   'unit-tests/u-reftable-merged.c',
   'unit-tests/u-reftable-pq.c',
+  'unit-tests/u-reftable-reader.c',
   'unit-tests/u-reftable-tree.c',
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
@@ -59,7 +60,6 @@ clar_unit_tests = executable('unit-tests',
 test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
-  'unit-tests/t-reftable-reader.c',
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
diff --git a/t/unit-tests/t-reftable-reader.c b/t/unit-tests/t-reftable-reader.c
deleted file mode 100644
index 546df6005e..0000000000
--- a/t/unit-tests/t-reftable-reader.c
+++ /dev/null
@@ -1,96 +0,0 @@
-#include "test-lib.h"
-#include "lib-reftable.h"
-#include "reftable/blocksource.h"
-#include "reftable/reader.h"
-
-static int t_reader_seek_once(void)
-{
-	struct reftable_ref_record records[] = {
-		{
-			.refname = (char *) "refs/heads/main",
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 42 },
-		},
-	};
-	struct reftable_block_source source = { 0 };
-	struct reftable_ref_record ref = { 0 };
-	struct reftable_iterator it = { 0 };
-	struct reftable_reader *reader;
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	int ret;
-
-	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
-	block_source_from_buf(&source, &buf);
-
-	ret = reftable_reader_new(&reader, &source, "name");
-	check(!ret);
-
-	reftable_reader_init_ref_iterator(reader, &it);
-	ret = reftable_iterator_seek_ref(&it, "");
-	check(!ret);
-	ret = reftable_iterator_next_ref(&it, &ref);
-	check(!ret);
-
-	ret = reftable_ref_record_equal(&ref, &records[0], REFTABLE_HASH_SIZE_SHA1);
-	check_int(ret, ==, 1);
-
-	ret = reftable_iterator_next_ref(&it, &ref);
-	check_int(ret, ==, 1);
-
-	reftable_ref_record_release(&ref);
-	reftable_iterator_destroy(&it);
-	reftable_reader_decref(reader);
-	reftable_buf_release(&buf);
-	return 0;
-}
-
-static int t_reader_reseek(void)
-{
-	struct reftable_ref_record records[] = {
-		{
-			.refname = (char *) "refs/heads/main",
-			.value_type = REFTABLE_REF_VAL1,
-			.value.val1 = { 42 },
-		},
-	};
-	struct reftable_block_source source = { 0 };
-	struct reftable_ref_record ref = { 0 };
-	struct reftable_iterator it = { 0 };
-	struct reftable_reader *reader;
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
-	int ret;
-
-	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
-	block_source_from_buf(&source, &buf);
-
-	ret = reftable_reader_new(&reader, &source, "name");
-	check(!ret);
-
-	reftable_reader_init_ref_iterator(reader, &it);
-
-	for (size_t i = 0; i < 5; i++) {
-		ret = reftable_iterator_seek_ref(&it, "");
-		check(!ret);
-		ret = reftable_iterator_next_ref(&it, &ref);
-		check(!ret);
-
-		ret = reftable_ref_record_equal(&ref, &records[0], REFTABLE_HASH_SIZE_SHA1);
-		check_int(ret, ==, 1);
-
-		ret = reftable_iterator_next_ref(&it, &ref);
-		check_int(ret, ==, 1);
-	}
-
-	reftable_ref_record_release(&ref);
-	reftable_iterator_destroy(&it);
-	reftable_reader_decref(reader);
-	reftable_buf_release(&buf);
-	return 0;
-}
-
-int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
-{
-	TEST(t_reader_seek_once(), "reader can seek once");
-	TEST(t_reader_reseek(), "reader can reseek multiple times");
-	return test_done();
-}
diff --git a/t/unit-tests/u-reftable-reader.c b/t/unit-tests/u-reftable-reader.c
new file mode 100644
index 0000000000..6c35063105
--- /dev/null
+++ b/t/unit-tests/u-reftable-reader.c
@@ -0,0 +1,78 @@
+#include "unit-test.h"
+#include "lib-reftable.h"
+#include "reftable/blocksource.h"
+#include "reftable/reader.h"
+
+void test_reftable_reader__seek_once(void)
+{
+	struct reftable_ref_record records[] = {
+		{
+			.refname = (char *) "refs/heads/main",
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 42 },
+		},
+	};
+	struct reftable_block_source source = { 0 };
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_reader *reader;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+
+	cl_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
+	block_source_from_buf(&source, &buf);
+
+	cl_assert(reftable_reader_new(&reader, &source, "name") == 0);
+
+
+	reftable_reader_init_ref_iterator(reader, &it);
+	cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
+	cl_assert(reftable_iterator_next_ref(&it, &ref) == 0);
+
+	cl_assert_equal_i(reftable_ref_record_equal(&ref, &records[0],
+												REFTABLE_HASH_SIZE_SHA1), 1);
+
+	cl_assert_equal_i(reftable_iterator_next_ref(&it, &ref), 1);
+
+	reftable_ref_record_release(&ref);
+	reftable_iterator_destroy(&it);
+	reftable_reader_decref(reader);
+	reftable_buf_release(&buf);
+}
+
+void test_reftable_reader__reseek(void)
+{
+	struct reftable_ref_record records[] = {
+		{
+			.refname = (char *) "refs/heads/main",
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 42 },
+		},
+	};
+	struct reftable_block_source source = { 0 };
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_reader *reader;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+
+	cl_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
+	block_source_from_buf(&source, &buf);
+
+	cl_assert(reftable_reader_new(&reader, &source, "name") == 0);
+
+	reftable_reader_init_ref_iterator(reader, &it);
+
+	for (size_t i = 0; i < 5; i++) {
+		cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
+		cl_assert(reftable_iterator_next_ref(&it, &ref) == 0);
+
+		cl_assert_equal_i(reftable_ref_record_equal(&ref, &records[0],
+													REFTABLE_HASH_SIZE_SHA1), 1);
+
+		cl_assert_equal_i(reftable_iterator_next_ref(&it, &ref), 1);
+	}
+
+	reftable_ref_record_release(&ref);
+	reftable_iterator_destroy(&it);
+	reftable_reader_decref(reader);
+	reftable_buf_release(&buf);
+}
-- 
2.43.0

