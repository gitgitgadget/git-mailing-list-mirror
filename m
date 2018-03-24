Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CCFD1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeCXHrq (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:47:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33385 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeCXHpi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:38 -0400
Received: by mail-lf0-f67.google.com with SMTP id x205-v6so21413944lfa.0
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HdI3jKe1wGJQKP8oBOsgYwyjQC9O+TNJU4iwJVPFysQ=;
        b=IPdNTj+ejeta07mEZU7StVmed6SvptoN7wsVOv+63yql6eMPgwO9F3I+l37IQwkarp
         nspxT1+KsV/uEx1xaPl7Qc1bwEzsjldsoGubhN0qQQi0CDid8DfJGqURMWckd+dzxdnV
         TSWfdV1T/PLdA1/ozn71SR/weyzRdBWE6s+h6wlHIp9QuMw/by3OjoqhVY2MLFprx2ZU
         +p2UOYUgx1r5hMQC5peVM79omcc7xeNvf9GLqwEy/fzn/xKL3PyTjlhADDiLa7XzL1KO
         r3r96eu95MsDo34AtSpBR923+zI7Ga+Yi6iFN4lKc/BIENnfJmNJCs2ITcATgtduyxjO
         RulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HdI3jKe1wGJQKP8oBOsgYwyjQC9O+TNJU4iwJVPFysQ=;
        b=VJH5hsd94p2fJHpHdo+2IyHxS2bAIDtQByCT1xqJxWJ3sD19SefTHJzj23Es5Q8h95
         xR2CDvobcKKtiObCweWtfcRLYVyLMVy95NsDnrU9BEM+ZHrzl23f8cHpVH8fq+l4wkLN
         x2L5BBJGCMH0lfSjw9rVSwFbXaJgkgsRLY2qsaT2KppDdeSNLD2Pg8vU1G8qhTZh/M+6
         oe7X5/YE46DVJ4uydcFWrsFTO8HnrLhMHGmG4gGMW40L7EKzHRP0YKQs+n0irMTHL5JP
         hFn0LCaSHAZmZcLrEjk5yclNMVQq+i26d/jIW2k1wdNDchuNlNnSWyVUbtK5QokZ6c5Q
         Arrw==
X-Gm-Message-State: AElRT7HZYV1hwOac143tIkeKIM8fURH/Kc3mpHdmkXm/lrAZ+U7VwUeb
        oGBK8OTVECowSq4Dd/mbz8g=
X-Google-Smtp-Source: AG47ELte6dLWd0nnY4vS9PXB6+QtJkMd+Gn4fzRBziIvzqk8z2bp2feyPZUkcc/AxZVavKM89Y4Lwg==
X-Received: by 10.46.153.86 with SMTP id r22mr1990398ljj.104.1521877536944;
        Sat, 24 Mar 2018 00:45:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/36] t/helper: merge test-config into test-tool
Date:   Sat, 24 Mar 2018 08:44:34 +0100
Message-Id: <20180324074505.19100-6-pclouds@gmail.com>
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
 t/helper/test-config.c    |  5 +++--
 t/helper/test-tool.c      |  1 +
 t/helper/test-tool.h      |  1 +
 t/t1305-config-include.sh |  2 +-
 t/t1308-config-set.sh     | 22 +++++++++++-----------
 t/t1309-early-config.sh   | 12 ++++++------
 7 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index 31287cedf2..227f16ad17 100644
--- a/Makefile
+++ b/Makefile
@@ -653,11 +653,11 @@ X =
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_BUILTINS_OBJS += test-chmtime.o
+TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-ctype
-TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-drop-caches
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 1a7b8bd3d6..214003d5b2 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "config.h"
 #include "string-list.h"
@@ -32,7 +33,7 @@
  * Examples:
  *
  * To print the value with highest priority for key "foo.bAr Baz.rock":
- * 	test-config get_value "foo.bAr Baz.rock"
+ * 	test-tool config get_value "foo.bAr Baz.rock"
  *
  */
 
@@ -77,7 +78,7 @@ static int early_config_cb(const char *var, const char *value, void *vdata)
 	return 0;
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__config(int argc, const char **argv)
 {
 	int i, val;
 	const char *v;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index afc7a518d6..e8d6c6b9eb 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -8,6 +8,7 @@ struct test_cmd {
 
 static struct test_cmd cmds[] = {
 	{ "chmtime", cmd__chmtime },
+	{ "config", cmd__config },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "sha1", cmd__sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 1dc4673c3a..3084f458a0 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -2,6 +2,7 @@
 #define __TEST_TOOL_H__
 
 int cmd__chmtime(int argc, const char **argv);
+int cmd__config(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index d9d2f545a4..f035ee40a3 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -224,7 +224,7 @@ test_expect_success 'conditional include, early config reading' '
 		echo "[includeIf \"gitdir:foo/\"]path=bar6" >>.git/config &&
 		echo "[test]six=6" >.git/bar6 &&
 		echo 6 >expect &&
-		test-config read_early_config test.six >actual &&
+		test-tool config read_early_config test.six >actual &&
 		test_cmp expect actual
 	)
 '
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index bafed5c9b8..3e00d1af01 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -18,7 +18,7 @@ check_config () {
 	then
 		printf "%s\n" "$@"
 	fi >expect &&
-	test_expect_code $expect_code test-config "$op" "$key" >actual &&
+	test_expect_code $expect_code test-tool config "$op" "$key" >actual &&
 	test_cmp expect actual
 }
 
@@ -125,7 +125,7 @@ test_expect_success 'find string value for a key' '
 '
 
 test_expect_success 'check line error when NULL string is queried' '
-	test_expect_code 128 test-config get_string case.foo 2>result &&
+	test_expect_code 128 test-tool config get_string case.foo 2>result &&
 	test_i18ngrep "fatal: .*case\.foo.*\.git/config.*line 7" result
 '
 
@@ -155,13 +155,13 @@ test_expect_success 'find value from a configset' '
 		baz = ball
 	EOF
 	echo silk >expect &&
-	test-config configset_get_value my.new config2 .git/config >actual &&
+	test-tool config configset_get_value my.new config2 .git/config >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'find value with highest priority from a configset' '
 	echo hask >expect &&
-	test-config configset_get_value case.baz config2 .git/config >actual &&
+	test-tool config configset_get_value case.baz config2 .git/config >actual &&
 	test_cmp expect actual
 '
 
@@ -173,20 +173,20 @@ test_expect_success 'find value_list for a key from a configset' '
 	lama
 	ball
 	EOF
-	test-config configset_get_value case.baz config2 .git/config >actual &&
+	test-tool config configset_get_value case.baz config2 .git/config >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'proper error on non-existent files' '
 	echo "Error (-1) reading configuration file non-existent-file." >expect &&
-	test_expect_code 2 test-config configset_get_value foo.bar non-existent-file 2>actual &&
+	test_expect_code 2 test-tool config configset_get_value foo.bar non-existent-file 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'proper error on directory "files"' '
 	echo "Error (-1) reading configuration file a-directory." >expect &&
 	mkdir a-directory &&
-	test_expect_code 2 test-config configset_get_value foo.bar a-directory 2>output &&
+	test_expect_code 2 test-tool config configset_get_value foo.bar a-directory 2>output &&
 	grep "^warning:" output &&
 	grep "^Error" output >actual &&
 	test_cmp expect actual
@@ -196,7 +196,7 @@ test_expect_success POSIXPERM,SANITY 'proper error on non-accessible files' '
 	chmod -r .git/config &&
 	test_when_finished "chmod +r .git/config" &&
 	echo "Error (-1) reading configuration file .git/config." >expect &&
-	test_expect_code 2 test-config configset_get_value foo.bar .git/config 2>output &&
+	test_expect_code 2 test-tool config configset_get_value foo.bar .git/config 2>output &&
 	grep "^warning:" output &&
 	grep "^Error" output >actual &&
 	test_cmp expect actual
@@ -207,14 +207,14 @@ test_expect_success 'proper error on error in default config files' '
 	test_when_finished "mv .git/config.old .git/config" &&
 	echo "[" >>.git/config &&
 	echo "fatal: bad config line 34 in file .git/config" >expect &&
-	test_expect_code 128 test-config get_value foo.bar 2>actual &&
+	test_expect_code 128 test-tool config get_value foo.bar 2>actual &&
 	test_i18ncmp expect actual
 '
 
 test_expect_success 'proper error on error in custom config files' '
 	echo "[" >>syntax-error &&
 	echo "fatal: bad config line 1 in file syntax-error" >expect &&
-	test_expect_code 128 test-config configset_get_value foo.bar syntax-error 2>actual &&
+	test_expect_code 128 test-tool config configset_get_value foo.bar syntax-error 2>actual &&
 	test_i18ncmp expect actual
 '
 
@@ -267,7 +267,7 @@ test_expect_success 'iteration shows correct origins' '
 	name=
 	scope=cmdline
 	EOF
-	GIT_CONFIG_PARAMETERS=$cmdline_config test-config iterate >actual &&
+	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 3dda215e8e..413642aa56 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -6,7 +6,7 @@ test_description='Test read_early_config()'
 
 test_expect_success 'read early config' '
 	test_config early.config correct &&
-	test-config read_early_config early.config >output &&
+	test-tool config read_early_config early.config >output &&
 	test correct = "$(cat output)"
 '
 
@@ -15,7 +15,7 @@ test_expect_success 'in a sub-directory' '
 	mkdir -p sub &&
 	(
 		cd sub &&
-		test-config read_early_config early.config
+		test-tool config read_early_config early.config
 	) >output &&
 	test sub = "$(cat output)"
 '
@@ -27,7 +27,7 @@ test_expect_success 'ceiling' '
 		GIT_CEILING_DIRECTORIES="$PWD" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd sub &&
-		test-config read_early_config early.config
+		test-tool config read_early_config early.config
 	) >output &&
 	test -z "$(cat output)"
 '
@@ -42,7 +42,7 @@ test_expect_success 'ceiling #2' '
 		GIT_CEILING_DIRECTORIES="$PWD" &&
 		export GIT_CEILING_DIRECTORIES XDG_CONFIG_HOME &&
 		cd sub &&
-		test-config read_early_config early.config
+		test-tool config read_early_config early.config
 	) >output &&
 	test xdg = "$(cat output)"
 '
@@ -54,7 +54,7 @@ test_expect_success 'read config file in right order' '
 	(
 		cd foo &&
 		echo "[test]source = repo" >>.git/config &&
-		GIT_CONFIG_PARAMETERS=$cmdline_config test-config \
+		GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config \
 			read_early_config test.source >actual &&
 		cat >expected <<-\EOF &&
 		home
@@ -71,7 +71,7 @@ test_with_config () {
 	(
 		cd throwaway &&
 		echo "$*" >.git/config &&
-		test-config read_early_config early.config
+		test-tool config read_early_config early.config
 	)
 }
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

