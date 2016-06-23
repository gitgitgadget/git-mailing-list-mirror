Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBF3B1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 16:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbcFWQ3b (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:29:31 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36428 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbcFWQ3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:29:30 -0400
Received: by mail-lf0-f66.google.com with SMTP id a2so18847943lfe.3
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:29:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oE5EXTZyDtG+9yUd2pVjVk6QQPRwz2cPz1RYEIZnIi8=;
        b=J/HHDTLp2NVfO9jK1RNn+gJbA8B9cY1dyuienuADZm2sz0kRG0BQrogK6bviTwqQqw
         coHkiRHFmiPwwddg9NXeZcmaPuHVdeXAbuEip9DBz3FmnV1L5KYag3F5OFYTN1rhZV71
         knXonaic2Aw9NBFGQ81fyq6vR2u+OlEk1sPU0nXeSGBJScG9jidFj1x+t4701vf0kd8T
         7SAKjpPxx9V8EI/x7Syip4JCU6SUbLDraCA5RkodYkiM2TSpBtgN+F5IfNLc6++x3892
         xauBGTd9GzJZbWjKs0dhfHkiS9cX+VpomTT9k/ic9Tbm1TbkIZruQYh4v5VJ5qz1OkZs
         qS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oE5EXTZyDtG+9yUd2pVjVk6QQPRwz2cPz1RYEIZnIi8=;
        b=MBzQ6OhMf/a4TiOQEGCIwPACZcUockt8qJjqx7ztRTg5DqvP6McvbfxaHDHDaA7eDq
         vz9A5qNegIgXrBzBJzdzq/w3CjBlVsZsVdV7HxGoKG4fwAdP57n0jJnpmBCEk/sIDF/q
         BLR5INiY8tH05SNVwIllctsQqIlQPp9pfIkn1rvdhxLBpTJtJx7QQDrW21DIoAv7qF46
         Q9iPtPtqtWr8TQwCykv1eAWT3qHwXkF1ZGdXgVCEF2kc4BZeRspsBsSY/erfGplsyciq
         zLSxLfIrfPzCR+jDaE1WhCl061NS4ZNft98O6g2AnmGED5s21bXJ949L83KqGeD3tzM3
         orFQ==
X-Gm-Message-State: ALyK8tL5sEuaVNmT3YJrrmvdoGZmcdnQI1tEduIf1xmFOtP6HCu/LRL+j5uWtTJ5VJSAhw==
X-Received: by 10.25.150.75 with SMTP id y72mr12810395lfd.92.1466699368419;
        Thu, 23 Jun 2016 09:29:28 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u21sm157948lja.16.2016.06.23.09.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 09:29:27 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/11] nd/icase updates
Date:	Thu, 23 Jun 2016 18:28:56 +0200
Message-Id: <20160623162907.23295-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This update drops 1/12, which is an unnecessary change, and changes a
couple of echo/printf to test_write_lines. One of those echo uses
backlashes and causes problems with Debian dash.

Interdiff therefore is not really interesting

diff --git a/builtin/grep.c b/builtin/grep.c
index 46c5ba1..8c516a9 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -809,7 +809,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (!opt.pattern_list)
 		die(_("no pattern given."));
-	if (opt.ignore_case)
+	if (!opt.fixed && opt.ignore_case)
 		opt.regflags |= REG_ICASE;
 
 	compile_grep_patterns(&opt);
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 4176625..169fd8d 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -5,7 +5,7 @@ test_description='grep icase on non-English locales'
 . ./lib-gettext.sh
 
 test_expect_success GETTEXT_LOCALE 'setup' '
-	printf "TILRAUN: Halló Heimur!" >file &&
+	test_write_lines "TILRAUN: Halló Heimur!" >file &&
 	git add file &&
 	LC_ALL="$is_IS_locale" &&
 	export LC_ALL
@@ -27,7 +27,7 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 icase' '
 '
 
 test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 string with "+"' '
-	printf "TILRAUN: Hallóó Heimur!" >file2 &&
+	test_write_lines "TILRAUN: Hallóó Heimur!" >file2 &&
 	git add file2 &&
 	git grep -l --perl-regexp "TILRAUN: H.lló+ Heimur!" >actual &&
 	echo file >expected &&
@@ -38,26 +38,26 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 string with "+"' '
 test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
 	git grep --debug -i -F "TILRAUN: Halló Heimur!"  2>&1 >/dev/null |
 		 grep fixed >debug1 &&
-	echo "fixed TILRAUN: Halló Heimur!" >expect1 &&
+	test_write_lines "fixed TILRAUN: Halló Heimur!" >expect1 &&
 	test_cmp expect1 debug1 &&
 
 	git grep --debug -i -F "TILRAUN: HALLÓ HEIMUR!"  2>&1 >/dev/null |
 		 grep fixed >debug2 &&
-	echo "fixed TILRAUN: HALLÓ HEIMUR!" >expect2 &&
+	test_write_lines "fixed TILRAUN: HALLÓ HEIMUR!" >expect2 &&
 	test_cmp expect2 debug2
 '
 
 test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
-	printf "^*TILR^AUN:.* \\Halló \$He[]imur!\$" >file &&
+	test_write_lines "^*TILR^AUN:.* \\Halló \$He[]imur!\$" >file &&
 
 	git grep --debug -i -F "^*TILR^AUN:.* \\Halló \$He[]imur!\$" 2>&1 >/dev/null |
 		 grep fixed >debug1 &&
-	echo "fixed \\^*TILR^AUN:\\.\\* \\\\Halló \$He\\[]imur!\\\$" >expect1 &&
+	test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\Halló \$He\\[]imur!\\\$" >expect1 &&
 	test_cmp expect1 debug1 &&
 
 	git grep --debug -i -F "^*TILR^AUN:.* \\HALLÓ \$HE[]IMUR!\$"  2>&1 >/dev/null |
 		 grep fixed >debug2 &&
-	echo "fixed \\^*TILR^AUN:\\.\\* \\\\HALLÓ \$HE\\[]IMUR!\\\$" >expect2 &&
+	test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\HALLÓ \$HE\\[]IMUR!\\\$" >expect2 &&
 	test_cmp expect2 debug2
 '
 

Nguyễn Thái Ngọc Duy (11):
  grep: break down an "if" stmt in preparation for next changes
  test-regex: isolate the bug test code
  test-regex: expose full regcomp() to the command line
  grep/icase: avoid kwsset on literal non-ascii strings
  grep/icase: avoid kwsset when -F is specified
  grep/pcre: prepare locale-dependent tables for icase matching
  gettext: add is_utf8_locale()
  grep/pcre: support utf-8
  diffcore-pickaxe: "share" regex error handling code
  diffcore-pickaxe: support case insensitive match on non-ascii
  grep.c: reuse "icase" variable

 diffcore-pickaxe.c                       | 27 ++++++++----
 gettext.c                                | 24 ++++++++++-
 gettext.h                                |  1 +
 grep.c                                   | 47 +++++++++++++++++----
 grep.h                                   |  1 +
 quote.c                                  | 37 +++++++++++++++++
 quote.h                                  |  1 +
 t/t0070-fundamental.sh                   |  2 +-
 t/t7812-grep-icase-non-ascii.sh (new +x) | 71 ++++++++++++++++++++++++++++++++
 t/t7813-grep-icase-iso.sh (new +x)       | 19 +++++++++
 test-regex.c                             | 59 +++++++++++++++++++++++++-
 11 files changed, 269 insertions(+), 20 deletions(-)
 create mode 100755 t/t7812-grep-icase-non-ascii.sh
 create mode 100755 t/t7813-grep-icase-iso.sh

-- 
2.8.2.526.g02eed6d

