Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D672F1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeCXHqv (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:51 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43491 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCXHqB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:01 -0400
Received: by mail-lf0-f65.google.com with SMTP id v207-v6so21403854lfa.10
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZxTHaY7l7lv9u1S3TzEULCM+bDdAtwqbSfYQlpsKB8w=;
        b=SNZkgmXWubLx6BSMwemYLc5DENrOAC5Eo9GW+ZaEvO0eMa2hSuikYN7/+9TQVP9trR
         lBmCn/qKSwYTXOisOzMCLt1u85LDVt+uwi1di+6r38jz/15+al60jVVG+pHjZcubF9vE
         H1goixJj2nZMsPbteBiGMeGxOstoPL+0VZn9MnKsmMDHMa21wuw2zDGU2aptXmrW4Irh
         lsKurb3t8Nl1McMi5Ts2PR4nNnxjAnJfYyXeEQmi6/Hlpiv1n3DtdJZ565eTgAnWE6rm
         YMKtzlhdkQfnF6EleSRO4udwemYor+FdeFfyyPDeQLR42y0hRLQsigTjorU/kOuXs2xx
         FPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZxTHaY7l7lv9u1S3TzEULCM+bDdAtwqbSfYQlpsKB8w=;
        b=gJyW6PFLG6YL4bPHrit2q5Zjq8slgDnptAymed8ZIN2SGU3ZniK54s9Qrug8jrcWlL
         3s8TN5qnPkAGh3WYpKEU/GkooBIuQkDNwvqK/CRa1ZMHb/djJEA2EzRapaw1kjuE31/N
         +6RrVPgEWjTUiyr07Pc89BzuOlNTh0EwhrVHFba5YkZ0FgzvpCXnaS7ZI+Cm7UNmLodl
         4crIeA5BzY7Tk+iDGPOsaa3AwkyCoTiYbm3vY4KQA2a7Uxoe73dATLurS61c3QE5kHui
         mb2lQxS500YWpepPo71t5gZZU3T7xzy+BaJ91BTbW5U7m5XkDG7UtMwSlNQJeXCv4qqd
         tpNg==
X-Gm-Message-State: AElRT7Gk7ltwEz0aAokgPb/VIOMc5tLu0UaWTl3octLZkrFUHFhAJ4RM
        RxiSzAyhpv4I+Xb3r/GOl9w=
X-Google-Smtp-Source: AG47ELt5+WXfauI9C3wHtDBzsxzRRSMElVafELas+00cmy9+gP1wwWWsA35pEZlt4Gzl4aVXaBx5jg==
X-Received: by 2002:a19:8f13:: with SMTP id r19-v6mr21050234lfd.92.1521877559399;
        Sat, 24 Mar 2018 00:45:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 23/36] t/helper: merge test-ref-store into test-tool
Date:   Sat, 24 Mar 2018 08:44:52 +0100
Message-Id: <20180324074505.19100-24-pclouds@gmail.com>
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
 Makefile                       | 2 +-
 t/helper/test-ref-store.c      | 3 ++-
 t/helper/test-tool.c           | 1 +
 t/helper/test-tool.h           | 1 +
 t/t1405-main-ref-store.sh      | 2 +-
 t/t1406-submodule-ref-store.sh | 2 +-
 t/t1407-worktree-ref-store.sh  | 4 ++--
 7 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 393fb9aca4..20080fddb8 100644
--- a/Makefile
+++ b/Makefile
@@ -672,6 +672,7 @@ TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-read-cache.o
+TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -680,7 +681,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-ref-store
 TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 7120634b04..cdefb66a87 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "refs.h"
 #include "worktree.h"
@@ -274,7 +275,7 @@ static struct command commands[] = {
 	{ NULL, NULL }
 };
 
-int cmd_main(int argc, const char **argv)
+int cmd__ref_store(int argc, const char **argv)
 {
 	struct ref_store *refs;
 	const char *func;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f64355c25c..777150e4ad 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -27,6 +27,7 @@ static struct test_cmd cmds[] = {
 	{ "path-utils", cmd__path_utils },
 	{ "prio-queue", cmd__prio_queue },
 	{ "read-cache", cmd__read_cache },
+	{ "ref-store", cmd__ref_store },
 	{ "sha1", cmd__sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 4d51c17f5a..2b5cc6e117 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -21,6 +21,7 @@ int cmd__online_cpus(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
+int cmd__ref_store(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index e8115df5ba..a30a080b20 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -4,7 +4,7 @@ test_description='test main ref store api'
 
 . ./test-lib.sh
 
-RUN="test-ref-store main"
+RUN="test-tool ref-store main"
 
 test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
 	test_commit one &&
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index c32d4cc465..e093782cc3 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -4,7 +4,7 @@ test_description='test submodule ref store api'
 
 . ./test-lib.sh
 
-RUN="test-ref-store submodule:sub"
+RUN="test-tool ref-store submodule:sub"
 
 test_expect_success 'setup' '
 	git init sub &&
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 8842d0329f..2211f9831f 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -4,8 +4,8 @@ test_description='test worktree ref store api'
 
 . ./test-lib.sh
 
-RWT="test-ref-store worktree:wt"
-RMAIN="test-ref-store worktree:main"
+RWT="test-tool ref-store worktree:wt"
+RMAIN="test-tool ref-store worktree:main"
 
 test_expect_success 'setup' '
 	test_commit first &&
-- 
2.17.0.rc0.348.gd5a49e0b6f

