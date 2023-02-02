Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3E9C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 19:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjBBTQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjBBTQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 14:16:52 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775576BBFF
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 11:16:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso4449451wms.5
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 11:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DscD0vNrHwXGGO2NPT+pY8OATdw4I91lPB/NfZ5+U00=;
        b=nXk6wC+OlldzbBPkB9Ep/79qRQkf5a8g6c6Gcv4urINIh2f/vfv331jtJbT0JIjbRf
         6UbzmZSWLTIYb5zbqEoPTqwgxD93PMyJRrfwdvzuGVM/JaUsAW//5pNtAVv47wje4rHt
         hgL56dqhsYmuXYYnK4TnRo0OcdT93xj2wKYW0UpAYlzobnvGNjjSb4mKZKeXIlo+yRMg
         BMdYihMYXlhsEYgO653xC3tNRJAeYkwIfe6UIqnpsTgDY8xoeF9SCnbJ76Phj3frVdqZ
         D9SQaewf0Q9f4Sjn77T3VMY5NujeZlWHxUK5BOGUEUuIqCj52Z4f2eUYOIywni6Q74q5
         14cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DscD0vNrHwXGGO2NPT+pY8OATdw4I91lPB/NfZ5+U00=;
        b=cy8vCL0cdAtIqPBbeJ3fykPsg16TLjCMFnBBA62Eohl5e2+PcPITC+EJRENGGj1p4b
         TMSC+o5F7P/3e8NBgkhmzH4yRGzB/VmFW1amPB5jRgAb/H6Dei6MAM8XE1urVGfJZiGR
         Ouw0lGaMWs6hwCg5U3KBCB9vtvVoBWuWbz4kWrZLBIJXEtXJVnPlYqB1xuDuF3FRHw4W
         vc8aTe7oa5yh/fNdH2nIwC51LUMPWOF7k7XUZhEmpEkf0G2TlJFXPILAZ8pQz6EIbOby
         27+HIG2QHGfiS23DXKF8cTaOit18j3TijQ6kmCjNREPki5Rl5uKeXpPhkgXkl/Q9gj7t
         4zjA==
X-Gm-Message-State: AO0yUKUrSD6shWNsJxPN9JnLGpJMF3H4kw2P63zLiQ3n/AGef558kWBF
        Uc99eTg/wsv2E8bzq7KQm+b0IY6MxuE=
X-Google-Smtp-Source: AK7set+KFnoZZuP7BEgiKK9de3T1RBWqTm+g9IFD+9CBiKm7ZhCi8RKKNqBTWTAXR0x1Fjd1e6PlPg==
X-Received: by 2002:a05:600c:1da8:b0:3df:9858:c037 with SMTP id p40-20020a05600c1da800b003df9858c037mr2595231wms.12.1675365408685;
        Thu, 02 Feb 2023 11:16:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c228e00b003dd9232f036sm2714369wmf.23.2023.02.02.11.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:16:48 -0800 (PST)
Message-Id: <01112de2b6ab7188e9fa9ef00aa06948ead74172.1675365406.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1449.git.git.1675365406.gitgitgadget@gmail.com>
References: <pull.1449.git.git.1675365406.gitgitgadget@gmail.com>
From:   "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Feb 2023 19:16:44 +0000
Subject: [PATCH 1/3] blame: add test for --color-lines + --color-by-age
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Estelle <robertestelle@gmail.com>

This adds a test verifying `git blame`'s output when run with both
`--color-lines` and `--color-by-age`. Those flags are not mutually
exclusive and both affect the output format. They were previously only
tested independently.

Signed-off-by: Robert Estelle <robertestelle@gmail.com>
---
 t/t8012-blame-colors.sh | 63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index c3a5f6d01ff..820f86c3aed 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -49,4 +49,67 @@ test_expect_success 'blame color by age: new code is different' '
 	grep qfunc colored
 '
 
+# shellcheck disable=SC2317
+re_normalize_color_decoded_blame() {
+	# Construct the regex used by `normalize_color_decoded_blame`.
+	# This is simply for documentation: line comments aren't permitted in
+	# backslash-continuation lines, and POSIX sh does't support 'x+=' syntax.
+	printf '%s' '\(<[^>]*>\)'     # 1: capture the "<YELLOW>" etc
+	printf '%s' ' *'              # -- discard any spaces
+	printf '%s' '[0-9a-f]\{1,\}'  # -- discard the commit ID
+	printf '%s' ' *'              # -- discard any spaces
+	printf '%s' '('               # -- left paren
+	printf '%s' '\(.\)'           # 2: capture the single-char A/F/G/etc
+	printf '%s' '[^\)]*'          # -- discard author and timestamp stuff
+	printf '%s' '\([0-9]\)\{1,\}' # 3: capture the line number
+	printf '%s' ')'               # -- right paren
+	printf '%s' ' *'              # -- discard leading spaces
+	printf '%s' '\(.*$\)'         # 4: capture the remainder
+}
+
+# shellcheck disable=SC2317
+normalize_color_decoded_blame() {
+	# Reads from stdin and writes to stdout.
+	# Removes the commit ID and author/timestamp from blame output after
+	# "test_decode_color" has run.
+	#
+	# This is simply to make expected  outputs easier to describe
+	# and compare without having to refer to magic line counts.
+	re="$(re_normalize_color_decoded_blame)" || return $?
+	sed -e 's/^'"${re}"'/\1 (\2 \3) \4/'
+}
+
+test_expect_success 'blame color by age and lines' '
+	git \
+		-c color.blame.repeatedLines=blue \
+		-c color.blame.highlightRecent="yellow,1 month ago, cyan" \
+		blame \
+		--color-lines \
+		--color-by-age \
+		hello.c \
+		>actual.raw &&
+
+	test_decode_color <actual.raw >actual &&
+	normalize_color_decoded_blame <actual >actual.norm &&
+
+	normalize_color_decoded_blame >expected.norm <<-EOF &&
+		<YELLOW>11111111 (H ... 1)  <RESET>#include <stdio.h>
+		<YELLOW>22222222 (F ... 2)  <RESET>int main(int argc, const char *argv[])
+		<BLUE>  22222222 (F ... 3)  <RESET>{
+		<BLUE>  22222222 (F ... 4)  <RESET>	puts("hello");
+		<YELLOW>33333333 (G ... 5)  <RESET>	puts("goodbye");
+		<YELLOW>22222222 (F ... 6)  <RESET>}
+		<YELLOW>11111111 (H ... 7)  <RESET>void mail()
+		<BLUE>  11111111 (H ... 8)  <RESET>{
+		<BLUE>  11111111 (H ... 9)  <RESET>	puts("mail");
+		<BLUE>  11111111 (H ... 10) <RESET>}
+		<CYAN>  44444444 (A ... 11) <RESET>void qfunc();
+		EOF
+
+	test_cmp actual.norm expected.norm &&
+
+	grep "<YELLOW>" <actual.norm >sanity-check &&
+	test_line_count = 5 sanity-check
+'
+
 test_done
-- 
gitgitgadget

