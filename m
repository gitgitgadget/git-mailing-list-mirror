Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 966C31F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeCXHqK (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:10 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38452 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeCXHqI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:08 -0400
Received: by mail-lf0-f67.google.com with SMTP id u3-v6so483915lff.5
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Si0DHrLzW0qBFNMTa0WoFOiwtJysiwMcbJK09poc53w=;
        b=nq14yH6Y1qaHnvs75zZj5CiVn2iQlFvRvgQJaTEnqEYvIqKxzZjlY6u8dQwbA1FBQ0
         hs/8ZTblWWKMiGLTXzTpFrd8dYktwbj6tIuFXT5IB1+jnQOoEgwivHaQqnvDdBaS7xVm
         LpLQbA/4f8RZ9EeUEigXPP4ihS1SIYEvEr1kzWg/3rGGhiH/RtFbsOHhTnwnhIzGHpK7
         TkLayNi8dhaD46ka9V7nUVxd2x75QrHl2nYWlZLUU5EQPOLHkyPpUnZsVxmDltlAAp44
         D0Hop6IBTp04wC6lxLKay3QP3n1v+WnxlvCsLJ+k1ZC5dB3wxivC98JTvxyB+YV8OwFn
         NPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Si0DHrLzW0qBFNMTa0WoFOiwtJysiwMcbJK09poc53w=;
        b=Nsw4GiUDHsPHFEyY7IgIEwYP8DLUrmn0gM8w+3NVoQmyMoV2H4so/pVLPh/dgVNDu/
         zsOgNWpO0TkY/VjCSegeApvkOdDogzATrF8MRH/mTsFApt/qioR7XSKkA/L62aRY2Gso
         Z8zIUp8ChKaTXft+YHuSXznQnAB2ACh9hQzz9uHcgmFmGZaS8GWIpT0hO4cPTJloEgBA
         nnMWKW4sLtKs5PB8qkYL9nkHe0HMTRFq8bwsBjUdOWnjM+yzv+yMAZYr+FM8xBzWrojQ
         vWEhtmjrkQDEHHznaKHkxybRv9SjsyIEkWb44wYODpC5joRZst8UsvlIBPPQVvN3oGN0
         4kaA==
X-Gm-Message-State: AElRT7HbnA0LATC5ZQv8zwym6xKrXyQejPl1w5CFhwAqVyBeLscVUuxv
        Rg259ZS61WZUb3i0OnncBeU=
X-Google-Smtp-Source: AG47ELswG9s5yJS4Q+LhHnxo9Fq0yBJxy9jkEvZPWQ7vzsSaLovyMM6aHWmklK+3DClFaXom874HSw==
X-Received: by 10.46.80.14 with SMTP id e14mr10709197ljb.101.1521877566902;
        Sat, 24 Mar 2018 00:46:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:46:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 28/36] t/helper: merge test-sha1-array into test-tool
Date:   Sat, 24 Mar 2018 08:44:57 +0100
Message-Id: <20180324074505.19100-29-pclouds@gmail.com>
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
 Makefile                   |  2 +-
 t/helper/test-sha1-array.c |  3 ++-
 t/helper/test-tool.c       |  1 +
 t/helper/test-tool.h       |  1 +
 t/t0064-sha1-array.sh      | 16 ++++++++--------
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index ba7c7d8a79..b50a0818a9 100644
--- a/Makefile
+++ b/Makefile
@@ -677,6 +677,7 @@ TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
 TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
+TEST_BUILTINS_OBJS += test-sha1-array.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -685,7 +686,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-sha1-array
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-strcmp-offset
 TEST_PROGRAMS_NEED_X += test-string-list
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index edfd52d82a..ad5e69f9d3 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "sha1-array.h"
 
@@ -7,7 +8,7 @@ static int print_oid(const struct object_id *oid, void *data)
 	return 0;
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__sha1_array(int argc, const char **argv)
 {
 	struct oid_array array = OID_ARRAY_INIT;
 	struct strbuf line = STRBUF_INIT;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 96d8df69d4..27f7b6ff75 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -32,6 +32,7 @@ static struct test_cmd cmds[] = {
 	{ "revision-walking", cmd__revision_walking },
 	{ "run-command", cmd__run_command },
 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
+	{ "sha1-array", cmd__sha1_array },
 	{ "sha1", cmd__sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 448119a44a..d8066e3f63 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -26,6 +26,7 @@ int cmd__regex(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
 int cmd__run_command(int argc, const char **argv);
 int cmd__scrap_cache_tree(int argc, const char **argv);
+int cmd__sha1_array(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
index 50b31ffe75..67484502a0 100755
--- a/t/t0064-sha1-array.sh
+++ b/t/t0064-sha1-array.sh
@@ -18,7 +18,7 @@ test_expect_success 'ordered enumeration' '
 	{
 		echo20 append 88 44 aa 55 &&
 		echo for_each_unique
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	test_cmp expect actual
 '
 
@@ -28,7 +28,7 @@ test_expect_success 'ordered enumeration with duplicate suppression' '
 		echo20 append 88 44 aa 55 &&
 		echo20 append 88 44 aa 55 &&
 		echo for_each_unique
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	test_cmp expect actual
 '
 
@@ -36,7 +36,7 @@ test_expect_success 'lookup' '
 	{
 		echo20 append 88 44 aa 55 &&
 		echo20 lookup 55
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -eq 1
 '
@@ -45,7 +45,7 @@ test_expect_success 'lookup non-existing entry' '
 	{
 		echo20 append 88 44 aa 55 &&
 		echo20 lookup 33
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -lt 0
 '
@@ -55,7 +55,7 @@ test_expect_success 'lookup with duplicates' '
 		echo20 append 88 44 aa 55 &&
 		echo20 append 88 44 aa 55 &&
 		echo20 lookup 55
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -ge 2 &&
 	test "$n" -le 3
@@ -66,7 +66,7 @@ test_expect_success 'lookup non-existing entry with duplicates' '
 		echo20 append 88 44 aa 55 &&
 		echo20 append 88 44 aa 55 &&
 		echo20 lookup 66
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -lt 0
 '
@@ -76,7 +76,7 @@ test_expect_success 'lookup with almost duplicate values' '
 		echo "append 5555555555555555555555555555555555555555" &&
 		echo "append 555555555555555555555555555555555555555f" &&
 		echo20 lookup 55
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -eq 0
 '
@@ -85,7 +85,7 @@ test_expect_success 'lookup with single duplicate value' '
 	{
 		echo20 append 55 55 &&
 		echo20 lookup 55
-	} | test-sha1-array >actual &&
+	} | test-tool sha1-array >actual &&
 	n=$(cat actual) &&
 	test "$n" -ge 0 &&
 	test "$n" -le 1
-- 
2.17.0.rc0.348.gd5a49e0b6f

