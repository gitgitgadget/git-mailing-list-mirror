Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002B01F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeCXHrc (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:47:32 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42226 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbeCXHpz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:55 -0400
Received: by mail-lf0-f66.google.com with SMTP id a22-v6so21386631lfg.9
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PSMb0si9cwxMZKVRDqPXHRrNPm25iOVGZHBZl1bDoc=;
        b=P3jfdcB0Bgs0LhfbL+biidRmALes/pJ8fD3djFx+OeYvvyLo51ofDUF+G05KlDX6rL
         /VidlPnRnutHQkc7B+jnAo8DCVz/oFbeKMVb+Ctyq14BkUfWKeEaaTNeU9TymaWWe1Jz
         mVspVKvsd51omovDYtiCndT6+XzGWrhGQU5uYwkI9qJy7UWjI69oUNpvlqgm4ulWNJKq
         08ncbbRclu/L0pAo3F8L+GhKhYgERF5OvA5gSYckqyB0Ewz+gqCQPGNRWdiFA2bFTr/2
         AuyXxNlZ9a1d5OSTPdP0S1+8Oz2Qxgx4l/UJ49xXyqbV4pAeJBORvNnROYq4zTnWuIgF
         NV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PSMb0si9cwxMZKVRDqPXHRrNPm25iOVGZHBZl1bDoc=;
        b=ExkgIfRJ/Qq+1KQCDoDatKvX1KYsdVdNG/VPt5h+CgygoYGDiiinW+B0I286bSe47+
         Z6RG7VugWHA1c+5Lg6+fP3yY0JNS090ou0Qz2AhKNI/Oiwf5S3Y/JxUqUS7wKcCuP8R0
         yaK2iRY6qgJmO7f06Utlz387kaeTLWZDugpZVR7GWxA24p4mZ2idx7Y4owMCnSvrsgN/
         +vkZlff+7y0z4WVPa1vgO9VReR1okgi6uA9z+qsNJRMQ0Hol/CpWKMlUCmykN7l6NRUO
         Mkttp1Ejb3sIsvtGcANh3pVlgi4iociC9Fsx6gjkZm4KBeCt3UaK6+fZKci03uomCuoF
         x4pg==
X-Gm-Message-State: AElRT7FTK9UkrD3RgX4msLIUg6cezwV3w9fXyKpWS0yzAxGi7dI/jL6S
        6n+iU0Ny1u0V+wmsE1GFjkk9NA==
X-Google-Smtp-Source: AG47ELs4DEgxTxiPCK+gyw/TC12PQNJsk6HsMuUG42UfrISqg80y0UzGiUtxf+0yesN4TiziHCJ/qg==
X-Received: by 2002:a19:12e9:: with SMTP id 102-v6mr22408727lfs.21.1521877553728;
        Sat, 24 Mar 2018 00:45:53 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:52 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 19/36] t/helper: merge test-online-cpus into test-tool
Date:   Sat, 24 Mar 2018 08:44:48 +0100
Message-Id: <20180324074505.19100-20-pclouds@gmail.com>
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
 Makefile                                | 2 +-
 t/helper/test-online-cpus.c             | 3 ++-
 t/helper/test-tool.c                    | 1 +
 t/helper/test-tool.h                    | 1 +
 t/t3008-ls-files-lazy-init-name-hash.sh | 2 +-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 3145a9b1b2..91af906d08 100644
--- a/Makefile
+++ b/Makefile
@@ -668,13 +668,13 @@ TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
+TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
-TEST_PROGRAMS_NEED_X += test-online-cpus
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-prio-queue
diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
index 06c09c6b88..8cb0d53840 100644
--- a/t/helper/test-online-cpus.c
+++ b/t/helper/test-online-cpus.c
@@ -1,7 +1,8 @@
+#include "test-tool.h"
 #include "git-compat-util.h"
 #include "thread-utils.h"
 
-int cmd_main(int argc, const char **argv)
+int cmd__online_cpus(int argc, const char **argv)
 {
 	printf("%d\n", online_cpus());
 	return 0;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index fd3bf560d4..8f78d61b68 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -23,6 +23,7 @@ static struct test_cmd cmds[] = {
 	{ "match-trees", cmd__match_trees },
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
+	{ "online-cpus", cmd__online_cpus },
 	{ "sha1", cmd__sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index cf2598798a..aeabc9740f 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -17,6 +17,7 @@ int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
+int cmd__online_cpus(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 8df4aa7c99..08af596ba6 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -4,7 +4,7 @@ test_description='Test the lazy init name hash with various folder structures'
 
 . ./test-lib.sh
 
-if test 1 -eq $($GIT_BUILD_DIR/t/helper/test-online-cpus)
+if test 1 -eq $($GIT_BUILD_DIR/t/helper/test-tool online-cpus)
 then
 	skip_all='skipping lazy-init tests, single cpu'
 	test_done
-- 
2.17.0.rc0.348.gd5a49e0b6f

