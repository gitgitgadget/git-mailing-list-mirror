Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403D2F39DC
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763213782; cv=none; b=qJot+V7Wqa9CoFios7jdzB6hGXeHK0R9xOd4J/vOh8HaQavSDlE2cwoJ1qtdchgKRRKBxbozh+KvXPpei1ylcwIFkF0cBzh/Az5MrzaAeGJHbtI5ML2vBfSs9ONwsfqer6NQYnusH9WB+iVQWqNdvkW1iQg8KMPDzGX6NMyCN64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763213782; c=relaxed/simple;
	bh=xCb9USf2XdLJnZJaUeUPxqmfYoh4AzVaFEHWBPlsLmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYPtjx2s2czC+Gfk4pPoR5SaupwcYts0tPnkKrtwI/jyWy/lvxIul7E8OeK7irBwOB0g/SuYglhWE8ipbo9jT0cQfXh6ND0ugmIXWRKVpVJTywO8NhyHyipICoN7gFq3haXbf6VShX0MZ89P1khUgUttr41PcSaiTFZsobhviQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4nI6y3s; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4nI6y3s"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcab6fso26870617b3.0
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 05:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763213780; x=1763818580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXUk2DQaiid4m+5whTPatuu+FsxpktzCYk2L888DgVs=;
        b=P4nI6y3ss/wa9TbuEyEnpG99gLpQCCPOgZeWNnz+UGXV96b4ZqRiuLk8agFpPcvE/r
         ob6BIL1LHhDTdL8pxwncv5owDoiFvzpwRQWUm2JrCmp67rOMP3tG6exEBejvnpS1VPCf
         LLAuelTGHoG8CR5SgR35szvMlvr0IAz73iRhigY+bQUwdwVpfPlKGr9wKis3cc6ct8Sk
         n7TsGa91zsfCpElCn9wuiXpKDz7AttIpKDxhIejDLIntor9lYmdKe666bWYc4J254wFW
         LQ/q05/Fnr6qTCmUN90/T6tKeuNL97WDGIPs1af0tnVP3vmIWVgyjkjBFTaOC3h8zxx3
         U6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763213780; x=1763818580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MXUk2DQaiid4m+5whTPatuu+FsxpktzCYk2L888DgVs=;
        b=RZHslc/X+ypxalDqsTMi482TXBPvNmnnB+eC15mj3+yNDFF3jumSVSf0tJbWj6IKnY
         rubjjW1uKyAx76dTReTZ8I7S8p0uekydzJptV88a+JFg8EdYksI80bgDv+wwwFYVZCmq
         BaB/2m+/u8MNcWAJplfJ3+qFDkIXyfkjYqDPIjo7VxTes2hT9OOmMK5bVM30dfR/FDJh
         kF8wggeFikwGQM48Q3MXLG4DmJqcFsFZY3IQ5ryeEwjj5eirxGLQakr4WWbIrFT75OD8
         yKRrbRY69wswlFw3xjW7+zasByr0+0wTCnvOZQLTfIQ56a8pd5rxaGu9kBDY90PTuIzf
         mSJw==
X-Forwarded-Encrypted: i=1; AJvYcCU+XOaZmp3kwWBmW71Yt2VqygGN0GeFCZ5MEov9BkGKRA7tjjwIoJ5eGlYfdWg/8f0TELM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrTzUeSc+qglqt88Q2NMyrDUNRAieQpLnvo3Id3ZPJJHrNqXzw
	7YEJeDGbfRXTZJePekHJSaX6ThMIaFJJAjzdyDU7U9bdhf4NttnXdVh6
X-Gm-Gg: ASbGncuY+LMG1q/T/x/GTlm1tZcriyodvUgjex66uOyF6WfyKVoAl9/LS0fEgmreTpx
	UDIallwKxsPCJWBb+vJKaV13dUiLbD7oXyqtxEzdh37PIcFNebS1bpRPouykGKB6v9proGRzaRg
	XvGfNpONjQDG6MRsbuAgcmbq9YVgH9DYqHzxix7JPR6xZFoX+1g6biGnDT9R1dQ+8whgNs2ZFuv
	pXaCIzwbPRzqitrGumEPaR5OFIVTYQgmFsY6236GiVBfg4G+o4NbPEQjNEOXBiWfsHixWVf/nUR
	AeRrWmUVS9bbZd20sVZrq/7lovDYbTZYz/ixl4L6m8cHuOHPIi4KGYiRlattoILvvIVekbxFQRx
	1V4W4CU3zR+eoP9MV5ehh02QKfukU75yk9HQOpabe1QbepX/r9a0fq/ZtGQ49wF0DGjSVgV7UrC
	qgeN9FzEziqmkbuYi1QXJsWntYC+roE3p1iIf92noCRyGBtElxWvCoEWGUTdxzx7ZMPvST7t6T
X-Google-Smtp-Source: AGHT+IFzMlbGl0dHwpQ5LWaSMO+18jENmQFd/N94IwmJYOlZMMcR4qlOFpDdHMJiX/qhzI9SbAX+dA==
X-Received: by 2002:a05:690c:6701:b0:786:78ab:72d0 with SMTP id 00721157ae682-78929e42aafmr65961557b3.7.1763213779612;
        Sat, 15 Nov 2025 05:36:19 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-788221281e4sm24449897b3.39.2025.11.15.05.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 05:36:19 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Justin Tobler <jltobler@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 0/2] Fix misaligned output of git repo structure
Date: Sat, 15 Nov 2025 08:36:09 -0500
Message-ID: <cover.1763213290.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1763098804.git.worldhello.net@gmail.com>
References: <cover.1763098804.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While localizing Git 2.52.0, I noticed that the output table from git
repo structure becomes misaligned when displaying UTF-8 characters. For
example:

    | 仓库结构   | 值  |
    | -------------- | ---- |

The previous implementation used simple width formatting with printf()
which didn't properly handle multi-byte UTF-8 characters, causing
misaligned table columns when displaying repository structure
information.

This change modifies the stats_table_print_structure function to use
strbuf_utf8_align() instead of basic printf width specifiers. This
ensures proper column alignment regardless of the character encoding of
the content being displayed.

Jiang Xin (2):
  t/unit-tests: add UTF-8 width tests for CJK chars
  builtin/repo: fix table alignment for UTF-8 characters

 Makefile                    |   1 +
 builtin/repo.c              |  21 ++++--
 t/meson.build               |   1 +
 t/unit-tests/u-utf8-width.c | 134 ++++++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 4 deletions(-)
 create mode 100644 t/unit-tests/u-utf8-width.c


## Range-diff vs v1:

1:  53c1e5219b ! 1:  72e73484d2 t/unit-tests: add UTF-8 width tests for CJK chars
    @@ Metadata
      ## Commit message ##
         t/unit-tests: add UTF-8 width tests for CJK chars
     
    -    This commit adds a new test suite (u-utf8-width.c) to test the UTF-8
    -    width functions in Git, particularly focusing on multi-byte characters
    -    from East Asian languages like Chinese, Japanese, and Korean that
    -    typically require 2 display columns per character.
    -
    -    The test suite includes:
    -    - Tests for utf8_strnwidth with Chinese strings
    -    - Tests for utf8_strwidth with Chinese strings
    -    - Tests for Japanese and Korean characters
    -    - Edge case tests with invalid UTF-8 sequences
    -    - Proper test function naming following the Clar framework convention
    +    The file "builtin/repo.c" uses utf8_strwidth() to calculate the display
    +    width of UTF-8 characters in a table, but the resulting output is still
    +    misaligned. Add test cases for both utf8_strwidth and utf8_strnwidth to
    +    verify that they correctly compute the display width for UTF-8
    +    characters.
     
         Also updated the build configuration in Makefile and meson.build to
         include the new test suite in the build process.
     
    -    Co-developed-by: Claude <noreply@anthropic.com>
         Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
     
      ## Makefile ##
    @@ t/unit-tests/u-utf8-width.c (new)
     + */
     +void test_utf8_width__strnwidth_chinese(void)
     +{
    -+	const char *ansi_test;
     +	const char *str;
     +
     +	/* Test basic ASCII - each character should have width 1 */
    -+	cl_assert_equal_i(5, utf8_strnwidth("hello", 5, 0));
    -+	cl_assert_equal_i(5, utf8_strnwidth("hello", 5, 1));  /* skip_ansi = 1 */
    ++	cl_assert_equal_i(5, utf8_strnwidth("Hello", 5, 0));
    ++	/* skip_ansi = 1 */
    ++	cl_assert_equal_i(5, utf8_strnwidth("Hello", 5, 1));
     +
     +	/* Test simple Chinese characters - each should have width 2 */
    -+	cl_assert_equal_i(4, utf8_strnwidth("你好", 6, 0));  /* "你好" is 6 bytes (3 bytes per char in UTF-8), 4 display columns */
    ++	/* "你好" is 6 bytes (3 bytes per char in UTF-8), 4 display columns */
    ++	cl_assert_equal_i(4, utf8_strnwidth("你好", 6, 0));
     +
     +	/* Test mixed ASCII and Chinese - ASCII = 1 column, Chinese = 2 columns */
    -+	cl_assert_equal_i(6, utf8_strnwidth("hi你好", 8, 0));  /* "h"(1) + "i"(1) + "你"(2) + "好"(2) = 6 */
    ++	/* "h"(1) + "i"(1) + "你"(2) + "好"(2) = 6 */
    ++	cl_assert_equal_i(6, utf8_strnwidth("Hi你好", 8, 0));
     +
     +	/* Test longer Chinese string */
    -+	cl_assert_equal_i(10, utf8_strnwidth("你好世界！", 15, 0));  /* 5 Chinese chars = 10 display columns */
    -+
    -+	/* Test with skip_ansi = 1 to make sure it works with escape sequences */
    -+	ansi_test = "\033[31m你好\033[0m";
    -+	cl_assert_equal_i(4, utf8_strnwidth(ansi_test, strlen(ansi_test), 1));  /* Skip escape sequences, just count "你好" which should be 4 columns */
    ++	/* 5 Chinese chars = 10 display columns */
    ++	cl_assert_equal_i(10, utf8_strnwidth("你好世界！", 15, 0));
     +
     +	/* Test individual Chinese character width */
    -+	cl_assert_equal_i(2, utf8_strnwidth("中", 3, 0));  /* Single Chinese char should be 2 columns */
    ++	cl_assert_equal_i(2, utf8_strnwidth("中", 3, 0));
     +
     +	/* Test empty string */
     +	cl_assert_equal_i(0, utf8_strnwidth("", 0, 0));
     +
     +	/* Test length limiting */
     +	str = "你好世界";
    -+	cl_assert_equal_i(2, utf8_strnwidth(str, 3, 0));  /* Only first char "你"(2 columns) within 3 bytes */
    -+	cl_assert_equal_i(4, utf8_strnwidth(str, 6, 0));  /* First two chars "你好"(4 columns) in 6 bytes */
    ++	/* Only first char "你"(2 columns) within 3 bytes */
    ++	cl_assert_equal_i(2, utf8_strnwidth(str, 3, 0));
    ++	/* First two chars "你好"(4 columns) in 6 bytes */
    ++	cl_assert_equal_i(4, utf8_strnwidth(str, 6, 0));
     +}
     +
     +/*
    @@ t/unit-tests/u-utf8-width.c (new)
     +void test_utf8_width__strwidth_chinese(void)
     +{
     +	/* Test basic ASCII */
    -+	cl_assert_equal_i(5, utf8_strwidth("hello"));
    ++	cl_assert_equal_i(5, utf8_strwidth("Hello"));
     +
     +	/* Test Chinese characters */
    -+	cl_assert_equal_i(4, utf8_strwidth("你好"));  /* 2 Chinese chars = 4 display columns */
    ++	/* 2 Chinese chars = 4 display columns */
    ++	cl_assert_equal_i(4, utf8_strwidth("你好"));
    ++
    ++	/* Test longer Chinese string */
    ++	/* 5 Chinese chars = 10 display columns */
    ++	cl_assert_equal_i(10, utf8_strwidth("你好世界！"));
     +
     +	/* Test mixed ASCII and Chinese */
    -+	cl_assert_equal_i(9, utf8_strwidth("hello世界"));  /* 5 ASCII (5 cols) + 2 Chinese (4 cols) = 9 */
    -+	cl_assert_equal_i(7, utf8_strwidth("hi世界!"));   /* 2 ASCII (2 cols) + 2 Chinese (4 cols) + 1 ASCII (1 col) = 7 */
    ++	/* 5 ASCII (5 cols) + 2 Chinese (4 cols) = 9 */
    ++	cl_assert_equal_i(9, utf8_strwidth("Hello世界"));
    ++	/* 2 ASCII (2 cols) + 2 Chinese (4 cols) + 1 ASCII (1 col) = 7 */
    ++	cl_assert_equal_i(7, utf8_strwidth("Hi世界!"));
     +}
     +
     +/*
    @@ t/unit-tests/u-utf8-width.c (new)
     +void test_utf8_width__strnwidth_japanese_korean(void)
     +{
     +	/* Japanese characters (should also be 2 columns each) */
    -+	cl_assert_equal_i(10, utf8_strnwidth("こんにちは", 15, 0));  /* 5 Japanese chars @ 2 cols each = 10 display columns */
    ++	/* 5 Japanese chars x 2 cols each = 10 display columns */
    ++	cl_assert_equal_i(10, utf8_strnwidth("こんにちは", 15, 0));
     +
     +	/* Korean characters (should also be 2 columns each) */
    -+	cl_assert_equal_i(10, utf8_strnwidth("안녕하세요", 15, 0));  /* 5 Korean chars @ 2 cols each = 10 display columns */
    ++	/* 5 Korean chars x 2 cols each = 10 display columns */
    ++	cl_assert_equal_i(10, utf8_strnwidth("안녕하세요", 15, 0));
     +}
     +
     +/*
    -+ * Test edge cases with partial UTF-8 sequences
    ++ * Test utf8_strnwidth with CJK strings and ANSI sequences
     + */
    -+void test_utf8_width__strnwidth_edge_cases(void)
    ++void test_utf8_width__strnwidth_cjk_with_ansi(void)
     +{
    -+	const char *invalid;
    -+	unsigned char truncated_bytes[] = {0xe4, 0xbd, 0x00};  /* First 2 bytes of "中" + null */
    -+
    -+	/* Test invalid UTF-8 - should fall back to byte count */
    -+	invalid = "\xff\xfe";  /* Invalid UTF-8 sequence */
    -+	cl_assert_equal_i(2, utf8_strnwidth(invalid, 2, 0));  /* Should return length if invalid UTF-8 */
    -+
    -+	/* Test partial UTF-8 character (truncated) */
    -+	cl_assert_equal_i(2, utf8_strnwidth((const char*)truncated_bytes, 2, 0));  /* Invalid UTF-8, returns byte count */
    ++	/* Test CJK with ANSI sequences */
    ++	const char *ansi_test = "\033[1m你好\033[0m";
    ++	int width = utf8_strnwidth(ansi_test, strlen(ansi_test), 1);
    ++	/* Should skip ANSI sequences and count "你好" as 4 columns */
    ++	cl_assert_equal_i(4, width);
    ++
    ++	/* Test mixed ASCII, CJK, and ANSI */
    ++	ansi_test = "Hello\033[32m世界\033[0m!";
    ++	width = utf8_strnwidth(ansi_test, strlen(ansi_test), 1);
    ++	/* "Hello"(5) + "世界"(4) + "!"(1) = 10 */
    ++	cl_assert_equal_i(10, width);
     +}
2:  65efad527f ! 2:  d0975427c9 builtin/repo: fix table alignment for UTF-8 characters
    @@ Commit message
             | -------------- | ---- |
             | * 引用       |      |
             |   * 计数     |   67 |
    -        |     * 分支   |    6 |
    -        |     * 标签   |   30 |
    -        |     * 远程   |   19 |
    -        |     * 其它   |   12 |
    -        |                |      |
    -        | * 可达对象 |      |
    -        |   * 计数     | 2217 |
    -        |     * 提交   |  279 |
    -        |     * 树      |  740 |
    -        |     * 数据对象 | 1168 |
    -        |     * 标签   |   30 |
     
         The previous implementation used simple width formatting with printf()
         which didn't properly handle multi-byte UTF-8 characters, causing
    @@ Commit message
         ensures proper column alignment regardless of the character encoding of
         the content being displayed.
     
    -    Co-developed-by: Gemini <noreply@developers.google.com>
    +    Also add test cases for strbuf_utf8_align(), a function newly introduced
    +    in "builtin/repo.c".
    +
         Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
     
      ## builtin/repo.c ##
    @@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table
     +	strbuf_utf8_align(&buf, ALIGN_LEFT, value_col_width, value_col_title);
     +	strbuf_addstr(&buf, " |");
     +	printf("%s\n", buf.buf);
    -+	strbuf_reset(&buf);
     +
      	printf("| ");
      	for (int i = 0; i < name_col_width; i++)
    @@ builtin/repo.c: static void stats_table_print_structure(const struct stats_table
      }
      
      static void stats_table_clear(struct stats_table *table)
    +
    + ## t/unit-tests/u-utf8-width.c ##
    +@@ t/unit-tests/u-utf8-width.c: void test_utf8_width__strnwidth_cjk_with_ansi(void)
    + 	/* "Hello"(5) + "世界"(4) + "!"(1) = 10 */
    + 	cl_assert_equal_i(10, width);
    + }
    ++
    ++/*
    ++ * Test the strbuf_utf8_align function with CJK characters
    ++ */
    ++void test_utf8_width__strbuf_utf8_align(void)
    ++{
    ++	struct strbuf buf = STRBUF_INIT;
    ++
    ++	/* Test left alignment with CJK */
    ++	strbuf_utf8_align(&buf, ALIGN_LEFT, 10, "你好");
    ++	/* Since "你好" is 4 display columns, we need 6 more spaces to reach 10 */
    ++	cl_assert_equal_s("你好      ", buf.buf);
    ++	strbuf_reset(&buf);
    ++
    ++	/* Test right alignment with CJK */
    ++	strbuf_utf8_align(&buf, ALIGN_RIGHT, 8, "世界");
    ++	/* "世界" is 4 display columns, so we need 4 leading spaces */
    ++	cl_assert_equal_s("    世界", buf.buf);
    ++	strbuf_reset(&buf);
    ++
    ++	/* Test center alignment with CJK */
    ++	strbuf_utf8_align(&buf, ALIGN_MIDDLE, 10, "中");
    ++	/* "中" is 2 display columns, so (10-2)/2 = 4 spaces on left, 4 on right */
    ++	cl_assert_equal_s("    中    ", buf.buf);
    ++	strbuf_reset(&buf);
    ++
    ++	strbuf_utf8_align(&buf, ALIGN_MIDDLE, 5, "中");
    ++	/* "中" is 2 display columns, so (5-2)/2 = 1 spaces on left, 2 on right */
    ++	cl_assert_equal_s(" 中  ", buf.buf);
    ++	strbuf_reset(&buf);
    ++
    ++	/* Test alignment that is smaller than string width */
    ++	strbuf_utf8_align(&buf, ALIGN_LEFT, 2, "你好");
    ++	/* Since "你好" is 4 display columns, it should not be truncated */
    ++	cl_assert_equal_s("你好", buf.buf);
    ++	strbuf_release(&buf);
    ++}

--
Jiang Xin
