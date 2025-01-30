Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F51B4228
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228442; cv=none; b=E1L247OxehOc/47jrHGauaqHmipXCEK/680xZSdeAYIARaci/hT2zs4CLrGTuNdjPpSJZgUa0HSYfMIej0eHvOp5VXY/M6hXOW1kPLnndu6WtGdgtXtn+13j6zEdSuTFhBvQ2JptKBesdv0g13BubgayvBuBM6972VNVJt27eaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228442; c=relaxed/simple;
	bh=kxiWGlfHVqJJc7kjiFJ752FOiU6AHsrviRaskebe9eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezZKWq3XNXtvaKhIFwA5JgZ1izqJsDyQvRQxUSdbRoMmoT3JSWJC+4liEYOGjC+GBT4bnFnibsna8eekttRy16gh0e1VdT/biGlvIcLMrdufI/P6D8txVPIoNelQag0nhXrLYOn/rb+uP3eOSf/MCxr0fW2xFPU7B1e+YmyxwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXu0vq0k; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXu0vq0k"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so689916a12.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 01:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738228438; x=1738833238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0SxbEBeNdokXNPpE6tqi9lrmzHFgZuRVqqdScJgHcU=;
        b=EXu0vq0kqEhZlvb3DIV0UTvwABAvkIlT0OAdjd20B/10ik/v9W76tFsC66E2lm9iTV
         KUICRof3dg1uA271qasVbSVBwabOFxlwAZWQDPoFmnEWpn1+0/LoBxP5RLOdKn78lfhA
         0tb2l/hVha4r8zGRO7Mdb+KZk+c9hPDCu7pPmnYDVzqIF0ImgZCMj9JNk6dqdxBXFxba
         +rO0baCUEttLD3zW9Uh2zkFAYPwzoc58Pa/9T7tCqZnNWKaQocjTT39AzhTwNk94shOw
         Xd7OgB/38mezc4BLT4XqEwhSnzMvZp3to7Poc+LhYxOnf+CVcMWf0RCj56DlpPJ10E2V
         6fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738228438; x=1738833238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0SxbEBeNdokXNPpE6tqi9lrmzHFgZuRVqqdScJgHcU=;
        b=tQSoGEXiyyPX4xO1VvLP0jF90BC+RSvDR3YhF249286Vqo2uKX6sdAYzq7kZF2jA/+
         Quq9FKwm0bP59nCa1qVgHDiM50i5SWF9/yMtPTzif8Jh5Ms/LvytCT5+X4y7O0zN/hXh
         0DdY5nDqUK6zxOvl/GbE2hzQXKc17hGvGaZGV/HvzZYj8KGS9RuVotObpwO1lOyHzi6N
         wDa7VVBc59Cb+86XZKRhwXGoMD+qN9zvd4CaS/LPa/zUkvJW1fCQyldMHkBOLjVYkhh3
         mKpl62P0aAYYLj4rfPU5T/J/If+z0rql08ooxxqGt2eCd3PabLbBiSwOySVI0BDgwTY+
         RyYA==
X-Gm-Message-State: AOJu0YwXSiQx+iJfHSgmBoEEOaGFGZS/AyV4ZRwWpaEA2/NcYWQJF1sh
	G+mW8LQO4s4yHYtspR7cZA5vfrW80CDp9USftjqH6G6bEiQimqOgqq8XL7Bk+P0JQQ==
X-Gm-Gg: ASbGnctquZoUaBE6+fmZBjylvUEzU+9onWjAfjJnyUNqSfVxr2Z81OXXtz/G0SqreCp
	xPwKe4w00JLE+P5MyEOgXKMOmd+g2xKaH5u77oEKbE9wihzDs16fUJ7oqUXIe59D9DsilfDWgoG
	kgAUzA/BqIRhlHJeupWUSsm4TuRcOxDmWUBm2TVFJlLIHijXOnEx66jr0DIpwNXJx1mkQagFOs1
	CaZtgo3w1vTWW4cJrznErWLgqdkbjHokNbJm+wV/KzpifwLxjFkafFWppZccAxmVgnVroDRAEpL
	uUuUzQmHT9BS0785HXzGlfzBLCOHOA==
X-Google-Smtp-Source: AGHT+IE3rClwh0ScdmXvpxbO2FVk6Uu9d5A6tZJ1iYj+i8wxo6Et7uNH0cU9O7ry8+I71f9yGgIfcw==
X-Received: by 2002:a05:6402:358e:b0:5da:1219:c81 with SMTP id 4fb4d7f45d1cf-5dc5efc5d27mr14484094a12.16.1738228437832;
        Thu, 30 Jan 2025 01:13:57 -0800 (PST)
Received: from localhost.localdomain ([154.120.90.178])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723e9ee4sm742249a12.25.2025.01.30.01.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 01:13:57 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 3/4] t/unit-tests: convert strbuf test to clar framework
Date: Thu, 30 Jan 2025 10:13:33 +0100
Message-ID: <20250130091334.39922-4-kuforiji98@gmail.com>
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

Adapt strbuf test script to clar framework by using clar assertions
where necessary. Test functions are created as standalone to test
different test cases.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                |   2 +-
 t/meson.build           |   2 +-
 t/unit-tests/t-strbuf.c | 122 ----------------------------------------
 t/unit-tests/u-strbuf.c | 121 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 124 deletions(-)
 delete mode 100644 t/unit-tests/t-strbuf.c
 create mode 100644 t/unit-tests/u-strbuf.c

diff --git a/Makefile b/Makefile
index 732d765f1c..358193597f 100644
--- a/Makefile
+++ b/Makefile
@@ -1344,6 +1344,7 @@ CLAR_TEST_SUITES += u-hashmap
 CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-tree
+CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
@@ -1361,7 +1362,6 @@ UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
-UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGRAMS += t-strcmp-offset
 UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGRAMS += t-urlmatch-normalization
diff --git a/t/meson.build b/t/meson.build
index c7e08eca6f..6cb72842b1 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -6,6 +6,7 @@ clar_test_suites = [
   'unit-tests/u-mem-pool.c',
   'unit-tests/u-prio-queue.c',
   'unit-tests/u-reftable-tree.c',
+  'unit-tests/u-strbuf.c',
   'unit-tests/u-strvec.c',
 ]
 
@@ -57,7 +58,6 @@ unit_test_programs = [
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
-  'unit-tests/t-strbuf.c',
   'unit-tests/t-strcmp-offset.c',
   'unit-tests/t-trailer.c',
   'unit-tests/t-urlmatch-normalization.c',
diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
deleted file mode 100644
index 3f4044d697..0000000000
--- a/t/unit-tests/t-strbuf.c
+++ /dev/null
@@ -1,122 +0,0 @@
-#include "test-lib.h"
-#include "strbuf.h"
-
-/* wrapper that supplies tests with an empty, initialized strbuf */
-static void setup(void (*f)(struct strbuf*, const void*),
-		  const void *data)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	f(&buf, data);
-	strbuf_release(&buf);
-	check_uint(buf.len, ==, 0);
-	check_uint(buf.alloc, ==, 0);
-}
-
-/* wrapper that supplies tests with a populated, initialized strbuf */
-static void setup_populated(void (*f)(struct strbuf*, const void*),
-			    const char *init_str, const void *data)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	strbuf_addstr(&buf, init_str);
-	check_uint(buf.len, ==, strlen(init_str));
-	f(&buf, data);
-	strbuf_release(&buf);
-	check_uint(buf.len, ==, 0);
-	check_uint(buf.alloc, ==, 0);
-}
-
-static int assert_sane_strbuf(struct strbuf *buf)
-{
-	/* Initialized strbufs should always have a non-NULL buffer */
-	if (!check(!!buf->buf))
-		return 0;
-	/* Buffers should always be NUL-terminated */
-	if (!check_char(buf->buf[buf->len], ==, '\0'))
-		return 0;
-	/*
-	 * Freshly-initialized strbufs may not have a dynamically allocated
-	 * buffer
-	 */
-	if (buf->len == 0 && buf->alloc == 0)
-		return 1;
-	/* alloc must be at least one byte larger than len */
-	return check_uint(buf->len, <, buf->alloc);
-}
-
-static void t_static_init(void)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	check_uint(buf.len, ==, 0);
-	check_uint(buf.alloc, ==, 0);
-	check_char(buf.buf[0], ==, '\0');
-}
-
-static void t_dynamic_init(void)
-{
-	struct strbuf buf;
-
-	strbuf_init(&buf, 1024);
-	check(assert_sane_strbuf(&buf));
-	check_uint(buf.len, ==, 0);
-	check_uint(buf.alloc, >=, 1024);
-	check_char(buf.buf[0], ==, '\0');
-	strbuf_release(&buf);
-}
-
-static void t_addch(struct strbuf *buf, const void *data)
-{
-	const char *p_ch = data;
-	const char ch = *p_ch;
-	size_t orig_alloc = buf->alloc;
-	size_t orig_len = buf->len;
-
-	if (!check(assert_sane_strbuf(buf)))
-		return;
-	strbuf_addch(buf, ch);
-	if (!check(assert_sane_strbuf(buf)))
-		return;
-	if (!(check_uint(buf->len, ==, orig_len + 1) &&
-	      check_uint(buf->alloc, >=, orig_alloc)))
-		return; /* avoid de-referencing buf->buf */
-	check_char(buf->buf[buf->len - 1], ==, ch);
-	check_char(buf->buf[buf->len], ==, '\0');
-}
-
-static void t_addstr(struct strbuf *buf, const void *data)
-{
-	const char *text = data;
-	size_t len = strlen(text);
-	size_t orig_alloc = buf->alloc;
-	size_t orig_len = buf->len;
-
-	if (!check(assert_sane_strbuf(buf)))
-		return;
-	strbuf_addstr(buf, text);
-	if (!check(assert_sane_strbuf(buf)))
-		return;
-	if (!(check_uint(buf->len, ==, orig_len + len) &&
-	      check_uint(buf->alloc, >=, orig_alloc) &&
-	      check_uint(buf->alloc, >, orig_len + len) &&
-	      check_char(buf->buf[orig_len + len], ==, '\0')))
-	    return;
-	check_str(buf->buf + orig_len, text);
-}
-
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
-{
-	if (!TEST(t_static_init(), "static initialization works"))
-		test_skip_all("STRBUF_INIT is broken");
-	TEST(t_dynamic_init(), "dynamic initialization works");
-	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
-	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
-	TEST(setup_populated(t_addch, "initial value", "a"),
-	     "strbuf_addch appends to initial value");
-	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
-	TEST(setup_populated(t_addstr, "initial value", "hello there"),
-	     "strbuf_addstr appends string to initial value");
-
-	return test_done();
-}
diff --git a/t/unit-tests/u-strbuf.c b/t/unit-tests/u-strbuf.c
new file mode 100644
index 0000000000..fec3c768d2
--- /dev/null
+++ b/t/unit-tests/u-strbuf.c
@@ -0,0 +1,121 @@
+#include "unit-test.h"
+#include "strbuf.h"
+
+/* wrapper that supplies tests with an empty, initialized strbuf */
+static void setup(void (*f)(struct strbuf*, const void*),
+		  const void *data)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	f(&buf, data);
+	strbuf_release(&buf);
+	cl_assert_equal_i(buf.len, 0);
+	cl_assert_equal_i(buf.alloc, 0);
+}
+
+/* wrapper that supplies tests with a populated, initialized strbuf */
+static void setup_populated(void (*f)(struct strbuf*, const void*),
+			    const char *init_str, const void *data)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addstr(&buf, init_str);
+	cl_assert_equal_i(buf.len, strlen(init_str));
+	f(&buf, data);
+	strbuf_release(&buf);
+	cl_assert_equal_i(buf.len, 0);
+	cl_assert_equal_i(buf.alloc, 0);
+}
+
+static void assert_sane_strbuf(struct strbuf *buf)
+{
+	/* Initialized strbufs should always have a non-NULL buffer */
+	cl_assert(buf->buf != NULL);
+	/* Buffers should always be NUL-terminated */
+	cl_assert(buf->buf[buf->len] == '\0');
+	/*
+	 * Freshly-initialized strbufs may not have a dynamically allocated
+	 * buffer
+	 */
+	if (buf->len == 0 && buf->alloc == 0)
+		return;
+	/* alloc must be at least one byte larger than len */
+	cl_assert(buf->len < buf->alloc);
+}
+
+void test_strbuf__static_init(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	cl_assert_equal_i(buf.len, 0);
+	cl_assert_equal_i(buf.alloc, 0);
+	cl_assert(buf.buf[0] == '\0');
+}
+
+void test_strbuf__dynamic_init(void)
+{
+	struct strbuf buf;
+
+	strbuf_init(&buf, 1024);
+	assert_sane_strbuf(&buf);
+	cl_assert_equal_i(buf.len, 0);
+	cl_assert(buf.alloc >= 1024);
+	cl_assert(buf.buf[0] == '\0');
+	strbuf_release(&buf);
+}
+
+static void t_addch(struct strbuf *buf, const void *data)
+{
+	const char *p_ch = data;
+	const char ch = *p_ch;
+	size_t orig_alloc = buf->alloc;
+	size_t orig_len = buf->len;
+
+	assert_sane_strbuf(buf);
+	strbuf_addch(buf, ch);
+	assert_sane_strbuf(buf);
+	cl_assert_equal_i(buf->len, orig_len + 1);
+	cl_assert(buf->alloc >= orig_alloc);
+	cl_assert(buf->buf[buf->len] == '\0');
+}
+
+static void t_addstr(struct strbuf *buf, const void *data)
+{
+	const char *text = data;
+	size_t len = strlen(text);
+	size_t orig_alloc = buf->alloc;
+	size_t orig_len = buf->len;
+
+	assert_sane_strbuf(buf);
+	strbuf_addstr(buf, text);
+	assert_sane_strbuf(buf);
+	cl_assert_equal_i(buf->len, orig_len + len);
+	cl_assert(buf->alloc >= orig_alloc);
+	cl_assert(buf->buf[buf->len] == '\0');
+	cl_assert_equal_s(buf->buf + orig_len, text);
+}
+
+void test_strbuf__add_single_char(void)
+{
+	setup(t_addch, "a");
+}
+
+void test_strbuf__add_empty_char(void)
+{
+	setup(t_addch, "");
+}
+
+void test_strbuf__add_multi_char(void)
+{
+	setup_populated(t_addch, "initial value", "a");
+}
+
+void test_strbuf__add_single_str(void)
+{
+	setup(t_addstr, "hello there");
+}
+
+void test_strbuf__add_multi_str(void)
+{
+	setup_populated(t_addstr, "initial value", "hello there");
+}
-- 
2.47.0.86.g15030f9556

