Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B012F39DE
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763213783; cv=none; b=YtNlzjNfbjSTyglWLegkg/Ony4pBjrB94Pu+ApVgIUZud1TVARgf0hbQjsPmzJYnO1EmoI4P42M7kddlG+Aa/CcDDR4kG0+2FzIApo34c4wDQU+ocwGFRbhNm0h/VY24m1zXNp92KURkypCaky0iTLGzDE8p77uCnNlFyKj0RKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763213783; c=relaxed/simple;
	bh=ah3cIoudYhrQCF7v7NEVSmbhHophwUsfd2vlhtJjL6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOJXQQSGKTZP71pmzyu3SDJLLb9Mi5h4cOTfCq08n53EHFqaGE1aQcYveQjdfAuDR0Ogn6IU9IXPB3zToQIcWC08p1Xv/2gypM2XJ2gSAirPk3zDWR9pAam9ZWTA4vdcHMo17M0K+fAzJfOWx6rsCn73pO6T4i0j1001xU/Xwug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R73rconF; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R73rconF"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-787e84ceaf7so33397137b3.2
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 05:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763213780; x=1763818580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+a7OMZP0E9xtgLOPRUtDvTrWFc7QPAhF/EmHEUDp5Q=;
        b=R73rconFP2EROyldnIs0qEFFx9afRu09XzhAwI0NviNvHvrlepmAXarTjanES4Pc2R
         c9J2P2WiCgg5gL6SJ1Qi4fkjI/Y1IQoGwHeV228E4YOCkQUY0Od1zB5KILnKdjWXjCR/
         1QVAP8lWuMTrSuUFRE30kC2lTNZBT4mj6NZ6QQr3+07XaZPn60Aj9E8HhFK+YoJEGfoh
         NDLXQb59rlhuX4zHlwhtNM/qIArvKew+kBOmOKzivXPB9DhiG5M6nRixNohUsmJAhyz5
         sZHCCVQlmwSvbd3NCNj79uYRfGQviIHJP4hserv4hDBXiZlVDbOSwd7sFwh523eUW9dY
         BfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763213780; x=1763818580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c+a7OMZP0E9xtgLOPRUtDvTrWFc7QPAhF/EmHEUDp5Q=;
        b=TekVSahhcfFZBLJXrOLlJyrTpkiS37/PxaOz+qnKfP4odKKtGE+5zeodXbFUU0uPi1
         dLRoN5scKSBnwIKIYCfaDmDceCUkjeGki0pCtqNOb57hguQ9B2HoGp13BWH0rM81uFTt
         XXdLNJJsjSpA7uZ8wG6+koTWmZJ5SLF2Pf64UqWtOtrF/0HFovpUbiju2Flr0+dQgQkV
         +yeRSFPHUv4BbY+3NDKwmZ7G/gqnHGuFwg5qvdggOw3wJ+eEE+PHP1wNwyoaH7tjJZhQ
         UXE/xzDXIp96QUImFO9G72hPJ5G2Y+jD+JyG12J9ESf4F+evgM9dvXbUkrLFM1J5y1KW
         gFpA==
X-Forwarded-Encrypted: i=1; AJvYcCXBlgx7O44+3QnTquUWH3nubI+v4bv46GJr5L948TUzoe66acF8JhLP5A5tdnqkPOxCng8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/3JtDYcfjxsDUBzf9R4RlPkYr+9YiEt3vvmsuigm7fqL6Gsfr
	0bmtM7Fdw+jSt2PIXg+mr8grX3wCdD72DvEBkDApb4Y1saJrYn0Pzhgm
X-Gm-Gg: ASbGncu4u93bnA9f6C7uGmVNMcmWes5myuHAEEIiJSHAHAsF7eXjeN47t1YbISkYUui
	B01WL0nlB2nejocJQGjrnb5GCQI/gawiEuhoYzg89sDhKn1t+Tr0DYeN9DYtXeK8IFKcjnsGymA
	ejhQ6N98gYcMqLSmoF4qXu2wAKVmFNWUh3MuHdjYaxAsWgh025BseRDGNh12AzvQh9wuG80EtQg
	H+DHqloj3BWOH3XPMXRKhsE97n7ZukkJlfc+uFX1rlGAHwsmuTB4h8PV3BtzlVxdmsFufepgjqf
	hkIqzErhGDE2uaNINkMn1FGrK34cOJF4LP53dwWKapE0J+rIqHzz37VbTGhzrHJ4BHq/lMovhI2
	vNQraOrSEY8ewRh6O0NdU3KHGuv1aaJdRKGmUyCBF4bGGv6dAochfCuZKRM8YM4mEG9A7lv+ofd
	4sfPVaCZVgfAQ5uiFogwW6n1+JRQu5zE19QprGU6Asn57BJFFWHUooU5uQwQ1pb+rP4Co9y4gYx
	4UwQyZjsAY=
X-Google-Smtp-Source: AGHT+IEQk3QT6/g2E4jZMJJXlD/zkcnP/IriXMguZOm9fPI9a0j2Ow7w8HO1uQR3Q14RwCDVtoNliw==
X-Received: by 2002:a05:690e:251c:10b0:641:f5bc:698f with SMTP id 956f58d0204a3-641f5bc739dmr1643290d50.75.1763213780536;
        Sat, 15 Nov 2025 05:36:20 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-788221281e4sm24449897b3.39.2025.11.15.05.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 05:36:20 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Justin Tobler <jltobler@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 1/2] t/unit-tests: add UTF-8 width tests for CJK chars
Date: Sat, 15 Nov 2025 08:36:10 -0500
Message-ID: <72e73484d26442e71eadc992076a9a804acd5582.1763213290.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1763213290.git.worldhello.net@gmail.com>
References: <cover.1763098804.git.worldhello.net@gmail.com> <cover.1763213290.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The file "builtin/repo.c" uses utf8_strwidth() to calculate the display
width of UTF-8 characters in a table, but the resulting output is still
misaligned. Add test cases for both utf8_strwidth and utf8_strnwidth to
verify that they correctly compute the display width for UTF-8
characters.

Also updated the build configuration in Makefile and meson.build to
include the new test suite in the build process.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Makefile                    |  1 +
 t/meson.build               |  1 +
 t/unit-tests/u-utf8-width.c | 97 +++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 t/unit-tests/u-utf8-width.c

diff --git a/Makefile b/Makefile
index 7e0f77e298..2a67546154 100644
--- a/Makefile
+++ b/Makefile
@@ -1525,6 +1525,7 @@ CLAR_TEST_SUITES += u-string-list
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_SUITES += u-trailer
 CLAR_TEST_SUITES += u-urlmatch-normalization
+CLAR_TEST_SUITES += u-utf8-width
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
diff --git a/t/meson.build b/t/meson.build
index a5531df415..dc43d69636 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -24,6 +24,7 @@ clar_test_suites = [
   'unit-tests/u-strvec.c',
   'unit-tests/u-trailer.c',
   'unit-tests/u-urlmatch-normalization.c',
+  'unit-tests/u-utf8-width.c',
 ]
 
 clar_sources = [
diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
new file mode 100644
index 0000000000..3766f19726
--- /dev/null
+++ b/t/unit-tests/u-utf8-width.c
@@ -0,0 +1,97 @@
+#include "unit-test.h"
+#include "utf8.h"
+#include "strbuf.h"
+
+/*
+ * Test utf8_strnwidth with various Chinese strings
+ * Chinese characters typically have a width of 2 columns when displayed
+ */
+void test_utf8_width__strnwidth_chinese(void)
+{
+	const char *str;
+
+	/* Test basic ASCII - each character should have width 1 */
+	cl_assert_equal_i(5, utf8_strnwidth("Hello", 5, 0));
+	/* skip_ansi = 1 */
+	cl_assert_equal_i(5, utf8_strnwidth("Hello", 5, 1));
+
+	/* Test simple Chinese characters - each should have width 2 */
+	/* "你好" is 6 bytes (3 bytes per char in UTF-8), 4 display columns */
+	cl_assert_equal_i(4, utf8_strnwidth("你好", 6, 0));
+
+	/* Test mixed ASCII and Chinese - ASCII = 1 column, Chinese = 2 columns */
+	/* "h"(1) + "i"(1) + "你"(2) + "好"(2) = 6 */
+	cl_assert_equal_i(6, utf8_strnwidth("Hi你好", 8, 0));
+
+	/* Test longer Chinese string */
+	/* 5 Chinese chars = 10 display columns */
+	cl_assert_equal_i(10, utf8_strnwidth("你好世界！", 15, 0));
+
+	/* Test individual Chinese character width */
+	cl_assert_equal_i(2, utf8_strnwidth("中", 3, 0));
+
+	/* Test empty string */
+	cl_assert_equal_i(0, utf8_strnwidth("", 0, 0));
+
+	/* Test length limiting */
+	str = "你好世界";
+	/* Only first char "你"(2 columns) within 3 bytes */
+	cl_assert_equal_i(2, utf8_strnwidth(str, 3, 0));
+	/* First two chars "你好"(4 columns) in 6 bytes */
+	cl_assert_equal_i(4, utf8_strnwidth(str, 6, 0));
+}
+
+/*
+ * Tests for utf8_strwidth (simpler version without length limit)
+ */
+void test_utf8_width__strwidth_chinese(void)
+{
+	/* Test basic ASCII */
+	cl_assert_equal_i(5, utf8_strwidth("Hello"));
+
+	/* Test Chinese characters */
+	/* 2 Chinese chars = 4 display columns */
+	cl_assert_equal_i(4, utf8_strwidth("你好"));
+
+	/* Test longer Chinese string */
+	/* 5 Chinese chars = 10 display columns */
+	cl_assert_equal_i(10, utf8_strwidth("你好世界！"));
+
+	/* Test mixed ASCII and Chinese */
+	/* 5 ASCII (5 cols) + 2 Chinese (4 cols) = 9 */
+	cl_assert_equal_i(9, utf8_strwidth("Hello世界"));
+	/* 2 ASCII (2 cols) + 2 Chinese (4 cols) + 1 ASCII (1 col) = 7 */
+	cl_assert_equal_i(7, utf8_strwidth("Hi世界!"));
+}
+
+/*
+ * Additional tests with other East Asian characters
+ */
+void test_utf8_width__strnwidth_japanese_korean(void)
+{
+	/* Japanese characters (should also be 2 columns each) */
+	/* 5 Japanese chars x 2 cols each = 10 display columns */
+	cl_assert_equal_i(10, utf8_strnwidth("こんにちは", 15, 0));
+
+	/* Korean characters (should also be 2 columns each) */
+	/* 5 Korean chars x 2 cols each = 10 display columns */
+	cl_assert_equal_i(10, utf8_strnwidth("안녕하세요", 15, 0));
+}
+
+/*
+ * Test utf8_strnwidth with CJK strings and ANSI sequences
+ */
+void test_utf8_width__strnwidth_cjk_with_ansi(void)
+{
+	/* Test CJK with ANSI sequences */
+	const char *ansi_test = "\033[1m你好\033[0m";
+	int width = utf8_strnwidth(ansi_test, strlen(ansi_test), 1);
+	/* Should skip ANSI sequences and count "你好" as 4 columns */
+	cl_assert_equal_i(4, width);
+
+	/* Test mixed ASCII, CJK, and ANSI */
+	ansi_test = "Hello\033[32m世界\033[0m!";
+	width = utf8_strnwidth(ansi_test, strlen(ansi_test), 1);
+	/* "Hello"(5) + "世界"(4) + "!"(1) = 10 */
+	cl_assert_equal_i(10, width);
+}
-- 
2.52.0.rc2.5.g4c20a63325.dirty

