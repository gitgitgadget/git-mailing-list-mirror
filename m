Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DEF71F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeCXHpr (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:45:47 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36283 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeCXHpn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:43 -0400
Received: by mail-lf0-f67.google.com with SMTP id z143-v6so21407575lff.3
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMNafEw/W+1gY+ifOutsjwkaZZ8gSJ6x0JGbzBTXpcI=;
        b=ZTjb5GvtEZiCigh6cJAkwgSjx1Ki88m2C/q/u1taPAmDl2fvc0YuE6W4HjKstQyTFl
         rEoiYSMUVvD6v+qKTcg5WY8Jex9nmxO4RErAWzsoV91CnP7YPYZYGQphrlEzRT6ScWBv
         R/y7uP7ui4mZKNORZEDcK0UyM7lRInrsYOV/ZzEASI+IHHgBXwlruy2zingDBoR98fI+
         pIaYxRjcmWDMr3wXigyLQXJzbiSi3QoZtfnsieefFADUVOqPpZFs2KEFuWvJzPvnZF1f
         7z9C6Gy7nyVBLMyv4/CrtvEAn40nyMvAMx6OGIKFxWAPLIt8BAyqjMLArG7SeXBSe3D+
         2z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMNafEw/W+1gY+ifOutsjwkaZZ8gSJ6x0JGbzBTXpcI=;
        b=SARQ3AJtbu3jlcXfsqSoq1fEGTO0oEWrFelNaz9hbY8JEHeYA9+hSZw1hJko+nycyL
         VMKn6shC/XQ3Oxs70QJPmQ2N5XnepR1+KOUektbyq2/O8wLPrspwQrDhSkD220gL+QYK
         Ndu1pGZtB+b2llB3aBW1r/qLkJJscp4G9gudZPdFd84pRkeXNLon19Uy9rWwW9Kj/kku
         eeBuWuDgFeJBSNKmZTk7uLeePmprvibr3LK3V/e/JfwxL/KD4NrNXvWblRZ2x2wbgjd9
         OmjaaBEQxpeyaCi72baRR7mues4m+EZvwI87PGnVATwnmSE0Db0q/wNE3bWAwg7OkvqG
         6xrg==
X-Gm-Message-State: AElRT7HBylARQVcsfF5gTZ/roLCC32mljpkQHxCrRTi/Baiagg+ftP4P
        l3+fr5xIqGG77+D2D1/KqlY=
X-Google-Smtp-Source: AG47ELtijqCNQ1a5Tqc4cqCQPUS6bunSG8zxTm4gsiZN8bvFIDyZPzj8XpfXSWihLzopTzzLCmu7Dg==
X-Received: by 2002:a19:d015:: with SMTP id h21-v6mr15027579lfg.124.1521877541653;
        Sat, 24 Mar 2018 00:45:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/36] t/helper: merge test-drop-caches into test-tool
Date:   Sat, 24 Mar 2018 08:44:38 +0100
Message-Id: <20180324074505.19100-10-pclouds@gmail.com>
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
 Makefile                    |  2 +-
 t/helper/test-drop-caches.c |  3 ++-
 t/helper/test-tool.c        |  1 +
 t/helper/test-tool.h        |  1 +
 t/perf/p7519-fsmonitor.sh   | 12 ++++++------
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 327d63217a..edd9c43982 100644
--- a/Makefile
+++ b/Makefile
@@ -657,10 +657,10 @@ TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delta.o
+TEST_BUILTINS_OBJS += test-drop-caches.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
-TEST_PROGRAMS_NEED_X += test-drop-caches
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-split-index
diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
index bd1a857d52..838760898b 100644
--- a/t/helper/test-drop-caches.c
+++ b/t/helper/test-drop-caches.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "git-compat-util.h"
 
 #if defined(GIT_WINDOWS_NATIVE)
@@ -157,7 +158,7 @@ static int cmd_dropcaches(void)
 
 #endif
 
-int cmd_main(int argc, const char **argv)
+int cmd__drop_caches(int argc, const char **argv)
 {
 	cmd_sync();
 	return cmd_dropcaches();
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 6bef386842..b6f648d387 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -12,6 +12,7 @@ static struct test_cmd cmds[] = {
 	{ "ctype", cmd__ctype },
 	{ "date", cmd__date },
 	{ "delta", cmd__delta },
+	{ "drop-caches", cmd__drop_caches },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "sha1", cmd__sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 761705e110..f585b7776e 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -6,6 +6,7 @@ int cmd__config(int argc, const char **argv);
 int cmd__ctype(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
+int cmd__drop_caches(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 65e145c02d..def7ecdbc7 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -118,7 +118,7 @@ test_expect_success "setup for fsmonitor" '
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-drop-caches
+	test-tool drop-caches
 fi
 
 test_perf "status (fsmonitor=$INTEGRATION_SCRIPT)" '
@@ -126,7 +126,7 @@ test_perf "status (fsmonitor=$INTEGRATION_SCRIPT)" '
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-drop-caches
+	test-tool drop-caches
 fi
 
 test_perf "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
@@ -134,7 +134,7 @@ test_perf "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-drop-caches
+	test-tool drop-caches
 fi
 
 test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
@@ -148,7 +148,7 @@ test_expect_success "setup without fsmonitor" '
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-drop-caches
+	test-tool drop-caches
 fi
 
 test_perf "status (fsmonitor=$INTEGRATION_SCRIPT)" '
@@ -156,7 +156,7 @@ test_perf "status (fsmonitor=$INTEGRATION_SCRIPT)" '
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-drop-caches
+	test-tool drop-caches
 fi
 
 test_perf "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
@@ -164,7 +164,7 @@ test_perf "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-	test-drop-caches
+	test-tool drop-caches
 fi
 
 test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
-- 
2.17.0.rc0.348.gd5a49e0b6f

