Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A6D1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeCXHqo (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:44 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40553 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeCXHqC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:02 -0400
Received: by mail-lf0-f66.google.com with SMTP id e5-v6so21420436lfb.7
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJlBrTmgAetewb4oHCG+rrwHI8IGrCBIBQs1gWBqat0=;
        b=oaoW3kBhrq6NJ1Nd+XELiv+OEms7WfReoFmICHjsV0pQfA/hzdnaWW6azjf2oCDWDM
         3hZrI4+EuOOyU08Rs81mHYf/cy5CaezJXlRB8Rgw+Fp3Pkn45qvjN4i1qBlfA+zIAjH2
         Y1wdSaTeZCUiPq62cKy/guk9gzy72pSvdpL8Yenf/WELg2NXW4V48CV6+xG0ALX7VPuR
         msivJFKOMHHnkjduyUmdAhVDs6IVflw8yvtvZY4l7vHiurdnIcH/qIL3K8gTrG9sPPY0
         d4NLRHyPfJJh0ZcxI+7C48itNhJD05yT2zzNapyrr0hcaHEjIWHKkuzPRzsr/cBw7ZM2
         cPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJlBrTmgAetewb4oHCG+rrwHI8IGrCBIBQs1gWBqat0=;
        b=Bu9wMs3LGvsfR6T4M17QreOWM3xTQrCxOz8rLU33BoYUwxRNLtGDUiof4S90hXKs5n
         r7Kmypudu3kr8CozF7aBCEaB5wISIOQxtAPnLTPxNQr3+dPr5JESnRSeNNNlBRTPRDti
         IqM7Kaa8zJSLT7oSe7uiyHP2zzxosxdFIH3sXF0coG8rV38Te9aywE6nO0Q7ic8UhKLq
         FiOCbKRcJ3kZxN/B+WySph1t7Er5+qlN0aqGzZPp9bOBCwWwID/FEZabJDAHy/HAv4ch
         R4ooN1axP6qpGgJNP+sd/RmTIGoHXpOjqt+SlnxCGgXACjoHpICuphsv56GZDucYL0yr
         T2sA==
X-Gm-Message-State: AElRT7H11ID2wXDPkhDyEnWV3qcdXbSHdA2QgL7BgAgvidtIxp79bIW3
        NdL3NgLdym95vBAANXWFoIY=
X-Google-Smtp-Source: AIpwx4+V7nn7vn9dWQkSSZPq4kNity0ahorlqbySpWbzxALg2tz0J6svhEYxitFrFojX1uR4gkrjnw==
X-Received: by 2002:a19:13de:: with SMTP id 91-v6mr7597766lft.114.1521877560507;
        Sat, 24 Mar 2018 00:46:00 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 24/36] t/helper: merge test-regex into test-tool
Date:   Sat, 24 Mar 2018 08:44:53 +0100
Message-Id: <20180324074505.19100-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074505.19100-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074505.19100-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                        | 2 +-
 t/helper/test-regex.c           | 7 ++++---
 t/helper/test-tool.c            | 1 +
 t/helper/test-tool.h            | 1 +
 t/t0070-fundamental.sh          | 2 +-
 t/t7812-grep-icase-non-ascii.sh | 2 +-
 6 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 20080fddb8..7444c00bbb 100644
--- a/Makefile
+++ b/Makefile
@@ -673,6 +673,7 @@ TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-ref-store.o
+TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -681,7 +682,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index b5ea8a97c5..10284cc56f 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "git-compat-util.h"
 #include "gettext.h"
 
@@ -36,7 +37,7 @@ static int test_regex_bug(void)
 	return 0;
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__regex(int argc, const char **argv)
 {
 	const char *pat;
 	const char *str;
@@ -47,8 +48,8 @@ int cmd_main(int argc, const char **argv)
 	if (argc == 2 && !strcmp(argv[1], "--bug"))
 		return test_regex_bug();
 	else if (argc < 3)
-		usage("test-regex --bug\n"
-		      "test-regex <pattern> <string> [<options>]");
+		usage("test-tool regex --bug\n"
+		      "test-tool regex <pattern> <string> [<options>]");
 
 	argv++;
 	pat = *argv++;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 777150e4ad..0dd3b879ad 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -28,6 +28,7 @@ static struct test_cmd cmds[] = {
 	{ "prio-queue", cmd__prio_queue },
 	{ "read-cache", cmd__read_cache },
 	{ "ref-store", cmd__ref_store },
+	{ "regex", cmd__regex },
 	{ "sha1", cmd__sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 2b5cc6e117..5f73c83ac0 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -22,6 +22,7 @@ int cmd__path_utils(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
+int cmd__regex(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index ac007938ee..23fbe6434a 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -31,7 +31,7 @@ test_expect_success 'git_mkstemps_mode does not fail if fd 0 is not open' '
 
 test_expect_success 'check for a bug in the regex routines' '
 	# if this test fails, re-build git with NO_REGEX=1
-	test-regex --bug
+	test-tool regex --bug
 '
 
 test_done
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 0059a1f837..0c685d3598 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -12,7 +12,7 @@ test_expect_success GETTEXT_LOCALE 'setup' '
 '
 
 test_have_prereq GETTEXT_LOCALE &&
-test-regex "HALLÓ" "Halló" ICASE &&
+test-tool regex "HALLÓ" "Halló" ICASE &&
 test_set_prereq REGEX_LOCALE
 
 test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
-- 
2.17.0.rc0.348.gd5a49e0b6f

