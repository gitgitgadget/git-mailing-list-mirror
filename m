Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459BA3C0A
	for <git@vger.kernel.org>; Mon,  1 Jan 2024 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3DMElh9"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-33677fb38a3so8665252f8f.0
        for <git@vger.kernel.org>; Mon, 01 Jan 2024 02:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704105665; x=1704710465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqBc2Prgjt0hOc4wRLtS+l4JQq8hjVuxWNpVhjACzqQ=;
        b=Y3DMElh97V/MgrmE4535i6hyQt8ELbQVf+XK3En1O0vQt6MouLSR28KjABgVvTapED
         bS5gyzb0Rn3VEtD33FH8e3wdwFUwvaS8jnZN+v3EMqftx8k3x9i25cEpOvIX4wrJQ6lQ
         mXPM5H1Sp2GW/399nqh2R6o6sJLE22wr+j5PiiJm86nd8v6Pu+xNM7iMpnAf8faydPLi
         Qdzoq+M08vGQYLb1jUaMB0ZRKzyF9WEO0bg5lsPJD01BThV4m8PaIP18Bob4E1O4iQQ+
         BjnAGVPnMTmlgoNl7uFiMnplE8IR7WROCLVHTaYf5wCGFHQycoB8PTjDO1jfNRYhRCqA
         wgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704105665; x=1704710465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqBc2Prgjt0hOc4wRLtS+l4JQq8hjVuxWNpVhjACzqQ=;
        b=OEBwBEzIou/xew5nTxNyXkwo4dhw/8XTIi8uplTB/CWw2LwGZdmzltq8Ni7RrEGKsP
         lKGe+AAc/VhcVq7aP8HkVUzsjdRZ2QBYZFGu66QRuftUhiA1gXASnZ0hCdWPoU7eDEsv
         YBXITAG9J67kFAmpApmzlkS10ZQpIcJbmDu5P22tcf5BLh78kPidkLkxy5+TgS1BlE/J
         9lisYfBvKAQDVt5mzDBDBYKIfQiNuCBUYVC3BKwukW2n6TCg3rtVKpI9n29SRVTeUowj
         VW2dykrMt07RFZJ2NYGHzsska1nXbj3ymrLyDcpyuBR1j2AFLZ4xJwiiwHZZzLND5Y4l
         Wx7g==
X-Gm-Message-State: AOJu0Yw+C2JPMVG1hpqWVBMFbT8p2eML2C45L/7HOHEC3qTOLaWeixzJ
	p8czdv4fynKtnGgSy80rjJHK8ll2/CMWzg==
X-Google-Smtp-Source: AGHT+IE8Jm3NwoxovbliD+ryW73NvbhteMVgPU/xlLMFOSL2WJ3B9/w+OvmK8Imy4zd6GEpvaY/YnQ==
X-Received: by 2002:a05:6000:d87:b0:336:c831:817c with SMTP id dv7-20020a0560000d8700b00336c831817cmr6023290wrb.123.1704105664890;
        Mon, 01 Jan 2024 02:41:04 -0800 (PST)
Received: from localhost.localdomain ([41.202.207.146])
        by smtp.gmail.com with ESMTPSA id a6-20020adffb86000000b003372befd19bsm6751661wrr.104.2024.01.01.02.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 02:41:04 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	l.s.r@web.de,
	phillip.wood@dunelm.org.uk,
	steadmon@google.com,
	Achu Luma <ach.lumap@gmail.com>
Subject: [Outreachy][PATCH v3] Port helper/test-ctype.c to unit-tests/t-ctype.c
Date: Mon,  1 Jan 2024 11:40:18 +0100
Message-ID: <20240101104017.9452-2-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20231230001102.9220-1-ach.lumap@gmail.com>
References: <20231230001102.9220-1-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update(8bf6fbd00d (Merge branch
'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
merged, providing a standardized approach for testing C code. Prior to
this update, some unit tests relied on the test helper mechanism,
lacking a dedicated unit testing framework. It's more natural to perform
these unit tests using the new unit test framework.

This commit migrates the unit tests for C character classification
functions (isdigit(), isspace(), etc) from the legacy approach
using the test-tool command `test-tool ctype` in t/helper/test-ctype.c
to the new unit testing framework (t/unit-tests/test-lib.h).

The migration involves refactoring the tests to utilize the testing
macros provided by the framework (TEST() and check_*()).

Signed-off-by: Achu Luma <ach.lumap@gmail.com>
---
 Sorry for the poor description of the changes, maybe the following is better:
 In the revised patch we added a call to test_msg() suggested by Phillip to 
 print the character code. This helps us pinpoint exactly the byte value that 
 is an issue as suggested by Junio. We keep using check_int() as it allows us 
 to still see the actual and expected return which might help us in case func() 
 returned a different non-zero value when we were expecting "1". It is useful 
 to have the return value printed on error in case we start returning "53" 
 instead of "1" for "true".

 Makefile               |  2 +-
 t/helper/test-ctype.c  | 70 --------------------------------------
 t/helper/test-tool.c   |  1 -
 t/helper/test-tool.h   |  1 -
 t/t0070-fundamental.sh |  4 ---
 t/unit-tests/t-ctype.c | 77 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 78 insertions(+), 77 deletions(-)
 delete mode 100644 t/helper/test-ctype.c
 create mode 100644 t/unit-tests/t-ctype.c

diff --git a/Makefile b/Makefile
index 88ba7a3c51..a4df48ba65 100644
--- a/Makefile
+++ b/Makefile
@@ -792,7 +792,6 @@ TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
 TEST_BUILTINS_OBJS += test-csprng.o
-TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delta.o
 TEST_BUILTINS_OBJS += test-dir-iterator.o
@@ -1341,6 +1340,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 
 UNIT_TEST_PROGRAMS += t-basic
 UNIT_TEST_PROGRAMS += t-strbuf
+UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
deleted file mode 100644
index e5659df40b..0000000000
--- a/t/helper/test-ctype.c
+++ /dev/null
@@ -1,70 +0,0 @@
-#include "test-tool.h"
-
-static int rc;
-
-static void report_error(const char *class, int ch)
-{
-	printf("%s classifies char %d (0x%02x) wrongly\n", class, ch, ch);
-	rc = 1;
-}
-
-static int is_in(const char *s, int ch)
-{
-	/*
-	 * We can't find NUL using strchr. Accept it as the first
-	 * character in the spec -- there are no empty classes.
-	 */
-	if (ch == '\0')
-		return ch == *s;
-	if (*s == '\0')
-		s++;
-	return !!strchr(s, ch);
-}
-
-#define TEST_CLASS(t,s) {			\
-	int i;					\
-	for (i = 0; i < 256; i++) {		\
-		if (is_in(s, i) != t(i))	\
-			report_error(#t, i);	\
-	}					\
-	if (t(EOF))				\
-		report_error(#t, EOF);		\
-}
-
-#define DIGIT "0123456789"
-#define LOWER "abcdefghijklmnopqrstuvwxyz"
-#define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
-#define PUNCT "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
-#define ASCII \
-	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
-	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
-	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
-	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
-	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
-	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
-	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
-	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
-#define CNTRL \
-	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
-	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
-	"\x7f"
-
-int cmd__ctype(int argc UNUSED, const char **argv UNUSED)
-{
-	TEST_CLASS(isdigit, DIGIT);
-	TEST_CLASS(isspace, " \n\r\t");
-	TEST_CLASS(isalpha, LOWER UPPER);
-	TEST_CLASS(isalnum, LOWER UPPER DIGIT);
-	TEST_CLASS(is_glob_special, "*?[\\");
-	TEST_CLASS(is_regex_special, "$()*+.?[\\^{|");
-	TEST_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=>@_`~");
-	TEST_CLASS(isascii, ASCII);
-	TEST_CLASS(islower, LOWER);
-	TEST_CLASS(isupper, UPPER);
-	TEST_CLASS(iscntrl, CNTRL);
-	TEST_CLASS(ispunct, PUNCT);
-	TEST_CLASS(isxdigit, DIGIT "abcdefABCDEF");
-	TEST_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
-
-	return rc;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 37ba996539..33b9501c21 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -19,7 +19,6 @@ static struct test_cmd cmds[] = {
 	{ "config", cmd__config },
 	{ "crontab", cmd__crontab },
 	{ "csprng", cmd__csprng },
-	{ "ctype", cmd__ctype },
 	{ "date", cmd__date },
 	{ "delta", cmd__delta },
 	{ "dir-iterator", cmd__dir_iterator },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 8a1a7c63da..b72f07ded9 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -12,7 +12,6 @@ int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__crontab(int argc, const char **argv);
 int cmd__csprng(int argc, const char **argv);
-int cmd__ctype(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
 int cmd__dir_iterator(int argc, const char **argv);
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 487bc8d905..a4756fbab9 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -9,10 +9,6 @@ Verify wrappers and compatibility functions.
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-test_expect_success 'character classes (isspace, isalpha etc.)' '
-	test-tool ctype
-'
-
 test_expect_success 'mktemp to nonexistent directory prints filename' '
 	test_must_fail test-tool mktemp doesnotexist/testXXXXXX 2>err &&
 	grep "doesnotexist/test" err
diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
new file mode 100644
index 0000000000..8a215d387a
--- /dev/null
+++ b/t/unit-tests/t-ctype.c
@@ -0,0 +1,77 @@
+#include "test-lib.h"
+
+static int is_in(const char *s, int ch)
+{
+	/*
+	 * We can't find NUL using strchr. Accept it as the first
+	 * character in the spec -- there are no empty classes.
+	 */
+	if (ch == '\0')
+		return ch == *s;
+	if (*s == '\0')
+		s++;
+	return !!strchr(s, ch);
+}
+
+/* Macro to test a character type */
+#define TEST_CTYPE_FUNC(func, string)				\
+static void test_ctype_##func(void)				\
+{								\
+	for (int i = 0; i < 256; i++) {				\
+        	if (!check_int(func(i), ==, is_in(string, i))) 	\
+        		test_msg("       i: %02x", i);		\
+        } 							\
+}
+
+#define DIGIT "0123456789"
+#define LOWER "abcdefghijklmnopqrstuvwxyz"
+#define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+#define PUNCT "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
+#define ASCII \
+	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
+	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
+	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
+	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
+	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
+	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
+	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
+	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+#define CNTRL \
+	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
+	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
+	"\x7f"
+
+TEST_CTYPE_FUNC(isdigit, DIGIT)
+TEST_CTYPE_FUNC(isspace, " \n\r\t")
+TEST_CTYPE_FUNC(isalpha, LOWER UPPER)
+TEST_CTYPE_FUNC(isalnum, LOWER UPPER DIGIT)
+TEST_CTYPE_FUNC(is_glob_special, "*?[\\")
+TEST_CTYPE_FUNC(is_regex_special, "$()*+.?[\\^{|")
+TEST_CTYPE_FUNC(is_pathspec_magic, "!\"#%&',-/:;<=>@_`~")
+TEST_CTYPE_FUNC(isascii, ASCII)
+TEST_CTYPE_FUNC(islower, LOWER)
+TEST_CTYPE_FUNC(isupper, UPPER)
+TEST_CTYPE_FUNC(iscntrl, CNTRL)
+TEST_CTYPE_FUNC(ispunct, PUNCT)
+TEST_CTYPE_FUNC(isxdigit, DIGIT "abcdefABCDEF")
+TEST_CTYPE_FUNC(isprint, LOWER UPPER DIGIT PUNCT " ")
+
+int cmd_main(int argc, const char **argv) {
+	/* Run all character type tests */
+	TEST(test_ctype_isspace(), "isspace() works as we expect");
+	TEST(test_ctype_isdigit(), "isdigit() works as we expect");
+	TEST(test_ctype_isalpha(), "isalpha() works as we expect");
+	TEST(test_ctype_isalnum(), "isalnum() works as we expect");
+	TEST(test_ctype_is_glob_special(), "is_glob_special() works as we expect");
+	TEST(test_ctype_is_regex_special(), "is_regex_special() works as we expect");
+	TEST(test_ctype_is_pathspec_magic(), "is_pathspec_magic() works as we expect");
+	TEST(test_ctype_isascii(), "isascii() works as we expect");
+	TEST(test_ctype_islower(), "islower() works as we expect");
+	TEST(test_ctype_isupper(), "isupper() works as we expect");
+	TEST(test_ctype_iscntrl(), "iscntrl() works as we expect");
+	TEST(test_ctype_ispunct(), "ispunct() works as we expect");
+	TEST(test_ctype_isxdigit(), "isxdigit() works as we expect");
+	TEST(test_ctype_isprint(), "isprint() works as we expect");
+
+	return test_done();
+}
-- 
2.42.0.windows.2

