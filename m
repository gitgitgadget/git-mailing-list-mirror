Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10EED1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeCXHqU (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:20 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37361 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeCXHqS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:18 -0400
Received: by mail-lf0-f66.google.com with SMTP id m16-v6so17663131lfc.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pxuz6BLhtah62urDXJz/GuJYlvDYzY9n3bqHRC/VaZ8=;
        b=goPvlCvy60Q/XOPg6nmnDbtbGqqCLGxBIWhzxNhpOQ5hr3ip87FWT2BVcyxOnGhB8j
         F0XHZpc0HGAJrI/ONJ1pGxcSfnqq2nHnAv6kk/lXLNSdL6INDHUx9dvHmUZ+UoC49sHf
         6TXRtzwnHtbQ4+83Thbp5VSmzyfzn4auf+KUoJypVyckxLQaPu2VlPeDCb5NUMKrPr/a
         dginofEj375UoWcWeLtco8i3I9q9RbHtDLLVEUBFBTUQcwPdQhDFpwrmApkkTP9e/f50
         g6j1nsnJP+pqQfMA4WdBF5V0+NQN9P36cub8jH7foEQFjFwFDYbiKy2SOBSfLfzN8RAI
         IDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pxuz6BLhtah62urDXJz/GuJYlvDYzY9n3bqHRC/VaZ8=;
        b=lOcGoWUxncrR1hOnGXwd1NcnN88ITH3IULynm9fdujt9W+QZ5Ua5hHMcKf+XYa6e6M
         e8MKu1qZbhMj5jsJflehBbBGJ2qi2bS5HHMs3LjsDrglEBo6OyQ26stNFzS5f7pcg/P/
         DUI4n8x2o50XONeiBuKS9Es1c5sT/BDHE4U+H3KKZhNSlXY3XopZZVDVjo6Cq6viUhws
         IofEfAOs68pz4rrcM5iHtr7vmaWYAmuRujNjWTKMs1Ld+IWdfsb2q8dHVRoT8LCKy3Ww
         uDVv966/R13XPkp6w8Yi4dGnWjSZ82D/JkhYJF6WPKd8KWsxYar3isbDS2Zrl3+KXxzH
         1aGg==
X-Gm-Message-State: AElRT7H0FQ+1ITze31kPd0EwHJ5BhD/A2wL9IYu3GDQ+VEAZRqLbD33l
        YdISfTR5aNTxakawvd1vjb0=
X-Google-Smtp-Source: AIpwx49eDgK/iune0lPWMRHMOGAO5m8i3RHl/15GDKX2FRU/Z3BLJX+S6mNHIjSFRy1e70PV9QhWGQ==
X-Received: by 10.46.158.19 with SMTP id e19mr960992ljk.47.1521877576803;
        Sat, 24 Mar 2018 00:46:16 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:46:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 35/36] t/helper: merge test-wildmatch into test-tool
Date:   Sat, 24 Mar 2018 08:45:04 +0100
Message-Id: <20180324074505.19100-36-pclouds@gmail.com>
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
 Makefile                  |  2 +-
 t/helper/test-tool.c      |  1 +
 t/helper/test-tool.h      |  1 +
 t/helper/test-wildmatch.c |  3 ++-
 t/t3070-wildmatch.sh      | 14 +++++++-------
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 7923ec3747..2ab76c6838 100644
--- a/Makefile
+++ b/Makefile
@@ -685,6 +685,7 @@ TEST_BUILTINS_OBJS += test-string-list.o
 TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
+TEST_BUILTINS_OBJS += test-wildmatch.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
@@ -694,7 +695,6 @@ TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-tool
-TEST_PROGRAMS_NEED_X += test-wildmatch
 
 TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
 
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b3d84fdac9..a804e64048 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -40,6 +40,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-config", cmd__submodule_config },
 	{ "subprocess", cmd__subprocess },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
+	{ "wildmatch", cmd__wildmatch },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index fa53c82659..84c583e68f 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -34,5 +34,6 @@ int cmd__string_list(int argc, const char **argv);
 int cmd__submodule_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
+int cmd__wildmatch(int argc, const char **argv);
 
 #endif
diff --git a/t/helper/test-wildmatch.c b/t/helper/test-wildmatch.c
index 66d33dfcfd..2c103d1824 100644
--- a/t/helper/test-wildmatch.c
+++ b/t/helper/test-wildmatch.c
@@ -1,6 +1,7 @@
+#include "test-tool.h"
 #include "cache.h"
 
-int cmd_main(int argc, const char **argv)
+int cmd__wildmatch(int argc, const char **argv)
 {
 	int i;
 	for (i = 2; i < argc; i++) {
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index c1fc6ca730..dce102130f 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -79,12 +79,12 @@ match_with_function() {
 	if test "$match_expect" = 1
 	then
 		test_expect_success "$match_function: match '$text' '$pattern'" "
-			test-wildmatch $match_function '$text' '$pattern'
+			test-tool wildmatch $match_function '$text' '$pattern'
 		"
 	elif test "$match_expect" = 0
 	then
 		test_expect_success "$match_function: no match '$text' '$pattern'" "
-			test_must_fail test-wildmatch $match_function '$text' '$pattern'
+			test_must_fail test-tool wildmatch $match_function '$text' '$pattern'
 		"
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $match_expect" 'false'
@@ -148,7 +148,7 @@ match_with_ls_files() {
 match() {
 	if test "$#" = 6
 	then
-		# When test-wildmatch and git ls-files produce the same
+		# When test-tool wildmatch and git ls-files produce the same
 		# result.
 		match_glob=$1
 		match_file_glob=$match_glob
@@ -204,19 +204,19 @@ match() {
 		fi
 	'
 
-	# $1: Case sensitive glob match: test-wildmatch & ls-files
+	# $1: Case sensitive glob match: test-tool wildmatch & ls-files
 	match_with_function "$text" "$pattern" $match_glob "wildmatch"
 	match_with_ls_files "$text" "$pattern" $match_file_glob "wildmatch" " --glob-pathspecs"
 
-	# $2: Case insensitive glob match: test-wildmatch & ls-files
+	# $2: Case insensitive glob match: test-tool wildmatch & ls-files
 	match_with_function "$text" "$pattern" $match_iglob "iwildmatch"
 	match_with_ls_files "$text" "$pattern" $match_file_iglob "iwildmatch" " --glob-pathspecs --icase-pathspecs"
 
-	# $3: Case sensitive path match: test-wildmatch & ls-files
+	# $3: Case sensitive path match: test-tool wildmatch & ls-files
 	match_with_function "$text" "$pattern" $match_pathmatch "pathmatch"
 	match_with_ls_files "$text" "$pattern" $match_file_pathmatch "pathmatch" ""
 
-	# $4: Case insensitive path match: test-wildmatch & ls-files
+	# $4: Case insensitive path match: test-tool wildmatch & ls-files
 	match_with_function "$text" "$pattern" $match_pathmatchi "ipathmatch"
 	match_with_ls_files "$text" "$pattern" $match_file_pathmatchi "ipathmatch" " --icase-pathspecs"
 }
-- 
2.17.0.rc0.348.gd5a49e0b6f

