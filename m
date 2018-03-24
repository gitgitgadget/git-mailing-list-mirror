Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C32B1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeCXHpv (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:45:51 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46365 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCXHpt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:49 -0400
Received: by mail-lf0-f68.google.com with SMTP id j68-v6so21388157lfg.13
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b45eEJnT5GgB4BRUpWXZGeEdSHWZV8bz77DtxOz9Hio=;
        b=aQElbntAIMb3Pp5usp4+2leUcKBHQU15WmWfez1/sWnrOlS4k0fK3pe9UzuVk81zg4
         MjlgQCbpOeT8n830xFkssS4ha1+BLlNAXOolIUvctIxQKS5Kfv/qSlb1Li9YK+clTY8s
         gmwvHXMtTM24RpHqXMKFYvedV9jfylsuBF1btb/Mtb36uAPK/7lrjPKNEmrAANyz4hTF
         K5bGSaz5lOMdEV+ghH2tSxAT03wn/gHj5dz1R4L2vY2BEp1X2oF4WKJpL+eZTRXzi8TE
         XgAUhdpLKnNvKdl5DXuNYGAu+DBsvNTrwaOs+0sr25HatN8zETcJ4U7sF/GNa3yhPwv6
         EdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b45eEJnT5GgB4BRUpWXZGeEdSHWZV8bz77DtxOz9Hio=;
        b=qAZiqq2ERTwCcAgVThZLQLFp7cwkEqIbRHMQoeYipeB9QpySPIsQ0P6qZRSWJR0c17
         PjhXbX916MvfZN9do/On1E9zPgtpbc6ieK0sUbQec4dAh40qu09b715lS6LV8vGSjhXw
         o0CPNCx8zsYlOrMcS4/gQgFSf2yMX7WeuymzGmAiwktkYuvLOtLICI3eUPCUy0em5VJS
         rPDCrCKRRdtHS70xqAiYLr5c4v9vmIk20ZE+l1VsY5NQpBQ6av2hn0jzfOoy4LHR+H3T
         EQq+qGHtcvp+fWd3VkJ+Epk1FDwZ6jRQQzBX0nGEaa//zYedGtrVFE7N+AXC/t/QzW9r
         qs4Q==
X-Gm-Message-State: AElRT7H7JeqaF8rMsQnGESn1DJ895Lect6M/Cls5wHhpyPYS274IzFXY
        D/2I59RHFJf/aCuqyo4dqgY=
X-Google-Smtp-Source: AIpwx4+4/U5Ui4JfwuVzR9d3yoZu3Vk7jlimU4d09oos0Pz8AIMYpEjyLmiFRBkXizrOVIM5OHtQUg==
X-Received: by 10.46.156.13 with SMTP id s13mr420392lji.29.1521877547844;
        Sat, 24 Mar 2018 00:45:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/36] t/helper: merge test-hashmap into test-tool
Date:   Sat, 24 Mar 2018 08:44:43 +0100
Message-Id: <20180324074505.19100-15-pclouds@gmail.com>
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
 Makefile                | 2 +-
 t/helper/test-hashmap.c | 5 +++--
 t/helper/test-tool.c    | 1 +
 t/helper/test-tool.h    | 1 +
 t/t0011-hashmap.sh      | 4 ++--
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index d0bc6cfecf..f6c3ddc703 100644
--- a/Makefile
+++ b/Makefile
@@ -662,13 +662,13 @@ TEST_BUILTINS_OBJS += test-dump-cache-tree.o
 TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
+TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
-TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 9ae9281c07..23d2b172fe 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "git-compat-util.h"
 #include "hashmap.h"
 #include "strbuf.h"
@@ -77,7 +78,7 @@ static unsigned int hash(unsigned int method, unsigned int i, const char *key)
 
 /*
  * Test performance of hashmap.[ch]
- * Usage: time echo "perfhashmap method rounds" | test-hashmap
+ * Usage: time echo "perfhashmap method rounds" | test-tool hashmap
  */
 static void perf_hashmap(unsigned int method, unsigned int rounds)
 {
@@ -144,7 +145,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
  *
  * perfhashmap method rounds -> test hashmap.[ch] performance
  */
-int cmd_main(int argc, const char **argv)
+int cmd__hashmap(int argc, const char **argv)
 {
 	struct strbuf line = STRBUF_INIT;
 	struct hashmap map;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index eb20b7d8fe..b9a6e7cbaa 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -17,6 +17,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-split-index", cmd__dump_split_index },
 	{ "example-decorate", cmd__example_decorate },
 	{ "genrandom", cmd__genrandom },
+	{ "hashmap", cmd__hashmap },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "sha1", cmd__sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f7ec6ae0c3..fba4bd80b9 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -11,6 +11,7 @@ int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
+int cmd__hashmap(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index 9c217d948c..3f1f505e89 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -4,7 +4,7 @@ test_description='test hashmap and string hash functions'
 . ./test-lib.sh
 
 test_hashmap() {
-	echo "$1" | test-hashmap $3 > actual &&
+	echo "$1" | test-tool hashmap $3 > actual &&
 	echo "$2" > expect &&
 	test_cmp expect actual
 }
@@ -232,7 +232,7 @@ test_expect_success 'grow / shrink' '
 	echo value40 >> expect &&
 	echo size >> in &&
 	echo 64 39 >> expect &&
-	cat in | test-hashmap > out &&
+	cat in | test-tool hashmap > out &&
 	test_cmp expect out
 
 '
-- 
2.17.0.rc0.348.gd5a49e0b6f

