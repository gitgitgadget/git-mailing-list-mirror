Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21821FF5FB
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088020; cv=none; b=KM74GhhczgGOinN3qTCHcC/AfkePKn+bSp3xB1/Q9GnptpelmV0TvPDWZoVdM8v2obVeAzm5wB+jSqB40GHxL0BdGxnJqlFcgb0uBuqd5t3rceh735FyFfKP1dX0vRLSdtm8vBXy0GQ/9C+jOZeA8oNst/gHyWw4vIf9wI8ELig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088020; c=relaxed/simple;
	bh=zwcwYZDfb93VSq1SgwZW/q7pt73jl5B/c8VCLWj7sAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kc8pH/yXmOdT7de/Gaj9fxVrbJ0JRr3gp3qhIbEP3cGSIaGT9hvcemY9AOGK/l1FJdmu2OiPh6ASm6pkad86wKZObSqypzyF3scbHRVw+c9kY8YYUA+j5OeZwEMofIsNoxsiTe2GoMCnkvOwxRpLUPT2bBjb5yJEL1xBFdXmZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BH/yUix+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH/yUix+"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so11669125e9.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 03:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741088016; x=1741692816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPczT27eegxQLo/VP1UXnYbtWNQlUcBUV+iHI6KWQms=;
        b=BH/yUix+eTB6xKLa8D4JhFg5spMgRrjSCLI+e9F0AC3XeFHBjLBKo8KA0OtseHX9PV
         RM16s8lcKRD23QGtquuI/Vpe72DTcDy9MMSKETAQIFOIt84NuKE9IdbEci2GGZSUFJy0
         AZdWE5hkZsErWENV6QR2Y4JBlbpxOezbGzoZzqEhj1aWcxrq1Bo5VVOwyQhxGhYIhK0U
         8a2fTTvcGeUOqShPW+L39qijPMxzggc67n7Yrekx9/Pdbr6V4xxV6l8+qQhsBZSFNm/m
         Zqxjsu2GeBgfd2s/h3ulsieE8mPkvmCIpGYiLOmEY/CRPTQNbHyk/M5yb7mMkpiCz/B5
         L2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741088016; x=1741692816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPczT27eegxQLo/VP1UXnYbtWNQlUcBUV+iHI6KWQms=;
        b=QQpOgYM2QbtmuNsj2SxnhkOhdnDlPmicWp9fmPVZkBRRnuMPVCHxzhGq1pS3M2nU5q
         DTGhONpIKBSUdakqxD0EIu8LvpqiXqHtyZwVUqzZRhkUunqi1pwtRJoRRP2DHh5tvIGA
         9XmHjUzyaSQscuhvp+CSdqmydIEFMRgwIWCZzpqZiRy2NqMfL6ZTpjR72YwZjHrFaY10
         uHleC8Qf0MViqw90IJ/PkebUlmSzQGnnoijWUOr8zjwuxo8rluUb7Xa34daxgi2UQ6eN
         4f0NMxCPXFR/cyPjvvFwb3mn35NAlhG4+09wX9ClyuvAHIu42N6UbGQ0f3x9jg8F3Ml1
         gZpA==
X-Gm-Message-State: AOJu0YwiPOvqOqtyc4eZO6GjWoR9U6dnUf73tH3GOqi6hMcdtNhYfF96
	o4HPz/CiOIcuKtCOfASSBZYB4SL9PcSdVQyLlVzHNtfpxplH+7isk0HNgYpkqVI=
X-Gm-Gg: ASbGncsy8L/CrVhbqLlfwvkryUCx0l/zARxJo0VHwE7hd5sM2GNNispCKF0CDZgAl70
	LnNNitxnh7pNwbTxPXWjxi2zzDqv8AHlC1IYLo5VFYX6d5qKioHzOjWHCRdod5IoeLG1im9Ygut
	dcS7IaOxD2FfQROXsc5gHCALdmlCYTmF8ldSrzRapOmV6Fi/f56onEF5rv3nZn6tEG3JDFe1LbK
	gndWSf0Z9bwMznnIQSCDVm7Jjo7nWXQ44y7g/kkQW6p4IQva3je/LdvuKBUfG4O9vtjIP3vubq7
	cpwo1FxC8QcxFkz153mGWcIzD4nCnd7RSBZqk695YoD2VgbKl0sK3xHuvRY=
X-Google-Smtp-Source: AGHT+IGPn6lkM6LnMk5ZpKxk/bJbme+hFecR/juT8PGtAAfDyOOQ8UPAj34tQv6ZzdpD0aT9XiBIug==
X-Received: by 2002:a05:6000:2d07:b0:38a:8ed1:c5c7 with SMTP id ffacd0b85a97d-390eca4a038mr11219129f8f.46.1741088015692;
        Tue, 04 Mar 2025 03:33:35 -0800 (PST)
Received: from localhost.localdomain ([154.118.41.125])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390e47b7d12sm17764128f8f.58.2025.03.04.03.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:33:35 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 1/2] t/unit-tests: convert trailer test to use clar
Date: Tue,  4 Mar 2025 12:33:22 +0100
Message-ID: <20250304113323.10564-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250304113323.10564-1-kuforiji98@gmail.com>
References: <20250304113323.10564-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt trailer test file to use clar testing framework by using clar
assertions where necessary. Split test into individual test functions
for clarity and maintainability. Each test case now has its own
function, making it easier to isolate failures and improve test
readability.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                 |   2 +-
 t/meson.build            |   2 +-
 t/unit-tests/t-trailer.c | 317 --------------------------------------
 t/unit-tests/u-trailer.c | 320 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 322 insertions(+), 319 deletions(-)
 delete mode 100644 t/unit-tests/t-trailer.c
 create mode 100644 t/unit-tests/u-trailer.c

diff --git a/Makefile b/Makefile
index a9b2de0692..9cb68aaa61 100644
--- a/Makefile
+++ b/Makefile
@@ -1361,6 +1361,7 @@ CLAR_TEST_SUITES += u-reftable-tree
 CLAR_TEST_SUITES += u-strbuf
 CLAR_TEST_SUITES += u-strcmp-offset
 CLAR_TEST_SUITES += u-strvec
+CLAR_TEST_SUITES += u-trailer
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
@@ -1377,7 +1378,6 @@ UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
-UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGRAMS += t-urlmatch-normalization
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/meson.build b/t/meson.build
index 25ce072707..560aa9a1f1 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -9,6 +9,7 @@ clar_test_suites = [
   'unit-tests/u-strbuf.c',
   'unit-tests/u-strcmp-offset.c',
   'unit-tests/u-strvec.c',
+  'unit-tests/u-trailer.c',
 ]
 
 clar_sources = [
@@ -59,7 +60,6 @@ unit_test_programs = [
   'unit-tests/t-reftable-readwrite.c',
   'unit-tests/t-reftable-record.c',
   'unit-tests/t-reftable-stack.c',
-  'unit-tests/t-trailer.c',
   'unit-tests/t-urlmatch-normalization.c',
 ]
 
diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
deleted file mode 100644
index 184593e73d..0000000000
--- a/t/unit-tests/t-trailer.c
+++ /dev/null
@@ -1,317 +0,0 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
-#include "test-lib.h"
-#include "trailer.h"
-
-struct contents {
-	const char *raw;
-	const char *key;
-	const char *val;
-};
-
-static void t_trailer_iterator(const char *msg, size_t num_expected,
-			       struct contents *contents)
-{
-	struct trailer_iterator iter;
-	size_t i = 0;
-
-	trailer_iterator_init(&iter, msg);
-	while (trailer_iterator_advance(&iter)) {
-		if (num_expected) {
-			check_str(iter.raw, contents[i].raw);
-			check_str(iter.key.buf, contents[i].key);
-			check_str(iter.val.buf, contents[i].val);
-		}
-		i++;
-	}
-	trailer_iterator_release(&iter);
-
-	check_uint(i, ==, num_expected);
-}
-
-static void run_t_trailer_iterator(void)
-{
-
-	static struct test_cases {
-		const char *name;
-		const char *msg;
-		size_t num_expected;
-		struct contents contents[10];
-	} tc[] = {
-		{
-			"empty input",
-			"",
-			0,
-			{{0}},
-		},
-		{
-			"no newline at beginning",
-			"Fixes: x\n"
-			"Acked-by: x\n"
-			"Reviewed-by: x\n",
-			0,
-			{{0}},
-		},
-		{
-			"newline at beginning",
-			"\n"
-			"Fixes: x\n"
-			"Acked-by: x\n"
-			"Reviewed-by: x\n",
-			3,
-			{
-				{
-					.raw = "Fixes: x\n",
-					.key = "Fixes",
-					.val = "x",
-				},
-				{
-					.raw = "Acked-by: x\n",
-					.key = "Acked-by",
-					.val = "x",
-				},
-				{
-					.raw = "Reviewed-by: x\n",
-					.key = "Reviewed-by",
-					.val = "x",
-				},
-				{
-					0
-				},
-			},
-		},
-		{
-			"without body text",
-			"subject: foo bar\n"
-			"\n"
-			"Fixes: x\n"
-			"Acked-by: x\n"
-			"Reviewed-by: x\n",
-			3,
-			{
-				{
-					.raw = "Fixes: x\n",
-					.key = "Fixes",
-					.val = "x",
-				},
-				{
-					.raw = "Acked-by: x\n",
-					.key = "Acked-by",
-					.val = "x",
-				},
-				{
-					.raw = "Reviewed-by: x\n",
-					.key = "Reviewed-by",
-					.val = "x",
-				},
-				{
-					0
-				},
-			},
-		},
-		{
-			"with body text, without divider",
-			"my subject\n"
-			"\n"
-			"my body which is long\n"
-			"and contains some special\n"
-			"chars like : = ? !\n"
-			"hello\n"
-			"\n"
-			"Fixes: x\n"
-			"Acked-by: x\n"
-			"Reviewed-by: x\n"
-			"Signed-off-by: x\n",
-			4,
-			{
-				{
-					.raw = "Fixes: x\n",
-					.key = "Fixes",
-					.val = "x",
-				},
-				{
-					.raw = "Acked-by: x\n",
-					.key = "Acked-by",
-					.val = "x",
-				},
-				{
-					.raw = "Reviewed-by: x\n",
-					.key = "Reviewed-by",
-					.val = "x",
-				},
-				{
-					.raw = "Signed-off-by: x\n",
-					.key = "Signed-off-by",
-					.val = "x",
-				},
-				{
-					0
-				},
-			},
-		},
-		{
-			"with body text, without divider (second trailer block)",
-			"my subject\n"
-			"\n"
-			"my body which is long\n"
-			"and contains some special\n"
-			"chars like : = ? !\n"
-			"hello\n"
-			"\n"
-			"Fixes: x\n"
-			"Acked-by: x\n"
-			"Reviewed-by: x\n"
-			"Signed-off-by: x\n"
-			"\n"
-			/*
-			 * Because this is the last trailer block, it takes
-			 * precedence over the first one encountered above.
-			 */
-			"Helped-by: x\n"
-			"Signed-off-by: x\n",
-			2,
-			{
-				{
-					.raw = "Helped-by: x\n",
-					.key = "Helped-by",
-					.val = "x",
-				},
-				{
-					.raw = "Signed-off-by: x\n",
-					.key = "Signed-off-by",
-					.val = "x",
-				},
-				{
-					0
-				},
-			},
-		},
-		{
-			"with body text, with divider",
-			"my subject\n"
-			"\n"
-			"my body which is long\n"
-			"and contains some special\n"
-			"chars like : = ? !\n"
-			"hello\n"
-			"\n"
-			"---\n"
-			"\n"
-			/*
-			 * This trailer still counts because the iterator
-			 * always ignores the divider.
-			 */
-			"Signed-off-by: x\n",
-			1,
-			{
-				{
-					.raw = "Signed-off-by: x\n",
-					.key = "Signed-off-by",
-					.val = "x",
-				},
-				{
-					0
-				},
-			},
-		},
-		{
-			"with non-trailer lines in trailer block",
-			"subject: foo bar\n"
-			"\n"
-			/*
-			 * Even though this trailer block has a non-trailer line
-			 * in it, it's still a valid trailer block because it's
-			 * at least 25% trailers and is Git-generated (see
-			 * git_generated_prefixes[] in trailer.c).
-			 */
-			"not a trailer line\n"
-			"not a trailer line\n"
-			"not a trailer line\n"
-			"Signed-off-by: x\n",
-			/*
-			 * Even though there is only really 1 real "trailer"
-			 * (Signed-off-by), we still have 4 trailer objects
-			 * because we still want to iterate through the entire
-			 * block.
-			 */
-			4,
-			{
-				{
-					.raw = "not a trailer line\n",
-					.key = "not a trailer line",
-					.val = "",
-				},
-				{
-					.raw = "not a trailer line\n",
-					.key = "not a trailer line",
-					.val = "",
-				},
-				{
-					.raw = "not a trailer line\n",
-					.key = "not a trailer line",
-					.val = "",
-				},
-				{
-					.raw = "Signed-off-by: x\n",
-					.key = "Signed-off-by",
-					.val = "x",
-				},
-				{
-					0
-				},
-			},
-		},
-		{
-			"with non-trailer lines (one too many) in trailer block",
-			"subject: foo bar\n"
-			"\n"
-			/*
-			 * This block has only 20% trailers, so it's below the
-			 * 25% threshold.
-			 */
-			"not a trailer line\n"
-			"not a trailer line\n"
-			"not a trailer line\n"
-			"not a trailer line\n"
-			"Signed-off-by: x\n",
-			0,
-			{{0}},
-		},
-		{
-			"with non-trailer lines (only 1) in trailer block, but no Git-generated trailers",
-			"subject: foo bar\n"
-			"\n"
-			/*
-			 * This block has only 1 non-trailer out of 10 (IOW, 90%
-			 * trailers) but is not considered a trailer block
-			 * because the 25% threshold only applies to cases where
-			 * there was a Git-generated trailer.
-			 */
-			"Reviewed-by: x\n"
-			"Reviewed-by: x\n"
-			"Reviewed-by: x\n"
-			"Helped-by: x\n"
-			"Helped-by: x\n"
-			"Helped-by: x\n"
-			"Acked-by: x\n"
-			"Acked-by: x\n"
-			"Acked-by: x\n"
-			"not a trailer line\n",
-			0,
-			{{0}},
-		},
-	};
-
-	for (int i = 0; i < sizeof(tc) / sizeof(tc[0]); i++) {
-		TEST(t_trailer_iterator(tc[i].msg,
-					tc[i].num_expected,
-					tc[i].contents),
-		     "%s", tc[i].name);
-	}
-}
-
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
-{
-	run_t_trailer_iterator();
-	return test_done();
-}
diff --git a/t/unit-tests/u-trailer.c b/t/unit-tests/u-trailer.c
new file mode 100644
index 0000000000..3d60ea1603
--- /dev/null
+++ b/t/unit-tests/u-trailer.c
@@ -0,0 +1,320 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
+#include "unit-test.h"
+#include "trailer.h"
+
+struct contents {
+	const char *raw;
+	const char *key;
+	const char *val;
+};
+
+static void t_trailer_iterator(const char *msg, size_t num_expected,
+			       struct contents *contents)
+{
+	struct trailer_iterator iter;
+	size_t i = 0;
+
+	trailer_iterator_init(&iter, msg);
+	while (trailer_iterator_advance(&iter)) {
+		if (num_expected) {
+			cl_assert_equal_s(iter.raw, contents[i].raw);
+			cl_assert_equal_s(iter.key.buf, contents[i].key);
+			cl_assert_equal_s(iter.val.buf, contents[i].val);
+		}
+		i++;
+	}
+	trailer_iterator_release(&iter);
+
+	cl_assert_equal_i(i, num_expected);
+}
+
+void test_trailer__empty_input(void)
+{
+	struct contents expected_contents[] = { 0 };
+	t_trailer_iterator("", 0, expected_contents);
+}
+
+void test_trailer__no_newline_start(void)
+{
+	struct contents expected_contents[] = { 0 };
+
+	t_trailer_iterator("Fixes: x\n"
+			   "Acked-by: x\n"
+			   "Reviewed-by: x\n",
+			   0,
+			   expected_contents);
+}
+
+void test_trailer__newline_start(void)
+{
+	struct contents expected_contents[] = {
+		{
+			.raw = "Fixes: x\n",
+			.key = "Fixes",
+			.val = "x",
+		},
+		{
+			.raw = "Acked-by: x\n",
+			.key = "Acked-by",
+			.val = "x",
+		},
+		{
+			.raw = "Reviewed-by: x\n",
+			.key = "Reviewed-by",
+			.val = "x",
+		},
+		{
+			0
+		},
+	};
+
+	t_trailer_iterator("\n"
+			   "Fixes: x\n"
+			   "Acked-by: x\n"
+			   "Reviewed-by: x\n",
+			   3,
+			   expected_contents);
+}
+
+void test_trailer__no_body_text(void)
+{
+	struct contents expected_contents[] = {
+
+		{
+			.raw = "Fixes: x\n",
+			.key = "Fixes",
+			.val = "x",
+		},
+		{
+			.raw = "Acked-by: x\n",
+			.key = "Acked-by",
+			.val = "x",
+		},
+		{
+			.raw = "Reviewed-by: x\n",
+			.key = "Reviewed-by",
+			.val = "x",
+		},
+		{
+			0
+		},
+	};
+
+	t_trailer_iterator("subject: foo bar\n"
+			   "\n"
+			   "Fixes: x\n"
+			   "Acked-by: x\n"
+			   "Reviewed-by: x\n",
+			   3,
+			   expected_contents);
+}
+
+void test_trailer__body_text_no_divider(void)
+{
+	struct contents expected_contents[] = {
+		{
+			.raw = "Fixes: x\n",
+			.key = "Fixes",
+			.val = "x",
+		},
+		{
+			.raw = "Acked-by: x\n",
+			.key = "Acked-by",
+			.val = "x",
+		},
+		{
+			.raw = "Reviewed-by: x\n",
+			.key = "Reviewed-by",
+			.val = "x",
+		},
+		{
+			.raw = "Signed-off-by: x\n",
+			.key = "Signed-off-by",
+			.val = "x",
+		},
+		{
+			0
+		},
+	};
+
+	t_trailer_iterator("my subject\n"
+			   "\n"
+			   "my body which is long\n"
+			   "and contains some special\n"
+			   "chars like : = ? !\n"
+			   "hello\n"
+			   "\n"
+			   "Fixes: x\n"
+			   "Acked-by: x\n"
+			   "Reviewed-by: x\n"
+			   "Signed-off-by: x\n",
+			   4,
+			   expected_contents);
+}
+
+void test_trailer__body_no_divider_2nd_block(void)
+{
+	struct contents expected_contents[] = {
+			{
+				.raw = "Helped-by: x\n",
+				.key = "Helped-by",
+				.val = "x",
+			},
+			{
+				.raw = "Signed-off-by: x\n",
+				.key = "Signed-off-by",
+				.val = "x",
+			},
+			{
+				0
+			},
+	};
+
+	t_trailer_iterator("my subject\n"
+			   "\n"
+			   "my body which is long\n"
+			   "and contains some special\n"
+			   "chars like : = ? !\n"
+			   "hello\n"
+			   "\n"
+			   "Fixes: x\n"
+			   "Acked-by: x\n"
+			   "Reviewed-by: x\n"
+			   "Signed-off-by: x\n"
+			   "\n"
+			   /*
+			   * Because this is the last trailer block, it takes
+			   * precedence over the first one encountered above.
+			   */
+			   "Helped-by: x\n"
+			   "Signed-off-by: x\n",
+			   2,
+			   expected_contents);
+}
+
+void test_trailer__body_and_divider(void)
+{
+	struct contents expected_contents[] = {
+			{
+				.raw = "Signed-off-by: x\n",
+				.key = "Signed-off-by",
+				.val = "x",
+			},
+			{
+				0
+			},
+	};
+
+	t_trailer_iterator("my subject\n"
+			   "\n"
+			   "my body which is long\n"
+			   "and contains some special\n"
+			   "chars like : = ? !\n"
+			   "hello\n"
+			   "\n"
+			   "---\n"
+			   "\n"
+			   /*
+			   * This trailer still counts because the iterator
+			   * always ignores the divider.
+			   */
+			   "Signed-off-by: x\n",
+			   1,
+			   expected_contents);
+}
+
+void test_trailer__non_trailer_in_block(void)
+{
+	struct contents expected_contents[] = {
+		{
+			.raw = "not a trailer line\n",
+			.key = "not a trailer line",
+			.val = "",
+		},
+		{
+			.raw = "not a trailer line\n",
+			.key = "not a trailer line",
+			.val = "",
+		},
+		{
+			.raw = "not a trailer line\n",
+			.key = "not a trailer line",
+			.val = "",
+		},
+		{
+			.raw = "Signed-off-by: x\n",
+			.key = "Signed-off-by",
+			.val = "x",
+		},
+		{
+			0
+		},
+	};
+
+	t_trailer_iterator("subject: foo bar\n"
+			   "\n"
+			   /*
+			   * Even though this trailer block has a non-trailer line
+			   * in it, it's still a valid trailer block because it's
+			   * at least 25% trailers and is Git-generated (see
+			   * git_generated_prefixes[] in trailer.c).
+			   */
+			   "not a trailer line\n"
+			   "not a trailer line\n"
+			   "not a trailer line\n"
+			   "Signed-off-by: x\n",
+			   /*
+			   * Even though there is only really 1 real "trailer"
+			   * (Signed-off-by), we still have 4 trailer objects
+			   * because we still want to iterate through the entire
+			   * block.
+			   */
+			   4,
+			   expected_contents);
+}
+
+void test_trailer__too_many_non_trailers(void)
+{
+	struct contents expected_contents[] = { 0 };
+
+	t_trailer_iterator("subject: foo bar\n"
+			   "\n"
+			   /*
+			   * This block has only 20% trailers, so it's below the
+			   * 25% threshold.
+			   */
+			   "not a trailer line\n"
+			   "not a trailer line\n"
+			   "not a trailer line\n"
+			   "not a trailer line\n"
+			   "Signed-off-by: x\n",
+			   0,
+			   expected_contents);
+}
+
+void test_trailer__one_non_trailer_no_git_trailers(void)
+{
+	struct contents expected_contents[] = { 0 };
+
+	t_trailer_iterator("subject: foo bar\n"
+			   "\n"
+			   /*
+			   * This block has only 1 non-trailer out of 10 (IOW, 90%
+			   * trailers) but is not considered a trailer block
+			   * because the 25% threshold only applies to cases where
+			   * there was a Git-generated trailer.
+			   */
+			   "Reviewed-by: x\n"
+			   "Reviewed-by: x\n"
+			   "Reviewed-by: x\n"
+			   "Helped-by: x\n"
+			   "Helped-by: x\n"
+			   "Helped-by: x\n"
+			   "Acked-by: x\n"
+			   "Acked-by: x\n"
+			   "Acked-by: x\n"
+			   "not a trailer line\n",
+			   0,
+			   expected_contents);
+}
-- 
2.47.0.86.g15030f9556

