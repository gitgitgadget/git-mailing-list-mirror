Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999F01F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeCQH4D (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:56:03 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41854 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752445AbeCQH4B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:56:01 -0400
Received: by mail-lf0-f65.google.com with SMTP id m69-v6so18494645lfe.8
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGEOogsIdUNIH7UU1UnZf8+YfmTM0H7PqiwK2AxCFHs=;
        b=SCeybjBGFar5X8GEB8s862IhpgnCpn86MG8YQn078FyKIwtUEwlv7u0BWuoiLv8Csp
         mSN8JZIJC/fY1h92G/KLop+KMzUVolbr7vQYxdTW+7y51D51G3hq9fXg9EqA+2lgNjMZ
         lhKf4FCdkWWMpgasA+j52CCzHfZvb1s2A4oKcN3mYhSotPRQClotZ3rk4U/LH2LWVYGY
         MxAdqycG7WpmBfWhJXrpc+LyQ7weArSVBB5r27l7+gMwhmhO451QhOzvmeWc591MnmuM
         jDAjJeFulig8Vvtftv4fO1jzu7YGIIKxet1NE6iY/iY5hUm/nTjZ0BdiShsqJIy8eDWe
         R0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGEOogsIdUNIH7UU1UnZf8+YfmTM0H7PqiwK2AxCFHs=;
        b=lbiDCit6KBJeXrpLFtojTFG99oz1xUIrZGGw7C+qfUZEgOZctj0HaaJlWk1f5BByKD
         NnxjqCkyVwqBsOMLFiVh7j4IopX4u0sxoHt9odJLJyG6PY0R4s9quRq9OHP1vcBv1EuL
         lERv5Wd3FHBQM9nLnoJsjFg+v7nl8BmZ8GnTMn6gG0fmDNfYziJ3NRKE9z2tu8y9Bu9+
         xhwnw1+62QUoiWqxJrEgSM0vqHt+faBgDHBVmbufnpKnVGWL2AGTYLTQ5wZ55GTMKPG/
         kOM3MLZr5FBytLPEy+XHnjqw1AO8OzVyVYFIJUL2JhJNH/zQ5VPc8m8qTXkp7A4gQhAM
         zxxA==
X-Gm-Message-State: AElRT7F1JsC0XPj3c8abIygCVUrtjf44bX9s7SOTjdciw4r8UUEslxPi
        zGGzGik3cgCy9la/C6Pi+yDF1g==
X-Google-Smtp-Source: AG47ELumG1MshelyV8OaMBVNGQVL2ehZA3vaXa2q3+XLoBwKKYeEoDjTuzh+8G8JSO6WdFZH5fA6ig==
X-Received: by 10.46.157.136 with SMTP id c8mr3458783ljj.85.1521273359443;
        Sat, 17 Mar 2018 00:55:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 26/36] t/helper: merge test-run-command into test-tool
Date:   Sat, 17 Mar 2018 08:54:11 +0100
Message-Id: <20180317075421.22032-27-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180317075421.22032-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
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
 t/helper/test-run-command.c |  3 ++-
 t/helper/test-tool.c        |  1 +
 t/helper/test-tool.h        |  1 +
 t/t0061-run-command.sh      | 24 ++++++++++++------------
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 3ed461cd55..adece67b8e 100644
--- a/Makefile
+++ b/Makefile
@@ -675,6 +675,7 @@ TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-regex.o
 TEST_BUILTINS_OBJS += test-revision-walking.o
+TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -683,7 +684,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1-array
 TEST_PROGRAMS_NEED_X += test-sigchain
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 153342e44d..3aa49c3fbb 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#include "test-tool.h"
 #include "git-compat-util.h"
 #include "run-command.h"
 #include "argv-array.h"
@@ -49,7 +50,7 @@ static int task_finished(int result,
 	return 1;
 }
 
-int cmd_main(int argc, const char **argv)
+int test_run_command(int argc, const char **argv)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int jobs;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 4586ae9440..a8a92b6a10 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -30,6 +30,7 @@ static struct test_cmd cmds[] = {
 	{ "ref-store", test_ref_store },
 	{ "regex", test_regex },
 	{ "revision-walking", test_revision_walking },
+	{ "run-command", test_run_command },
 	{ "sha1", test_sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 9bbdb05848..23f63ee357 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -24,6 +24,7 @@ int test_read_cache(int argc, const char **argv);
 int test_ref_store(int argc, const char **argv);
 int test_regex(int argc, const char **argv);
 int test_revision_walking(int argc, const char **argv);
+int test_run_command(int argc, const char **argv);
 int test_sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 24c92b6cd7..d03149be9f 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -14,13 +14,13 @@ EOF
 >empty
 
 test_expect_success 'start_command reports ENOENT' '
-	test-run-command start-command-ENOENT ./does-not-exist
+	test-tool run-command start-command-ENOENT ./does-not-exist
 '
 
 test_expect_success 'run_command can run a command' '
 	cat hello-script >hello.sh &&
 	chmod +x hello.sh &&
-	test-run-command run-command ./hello.sh >actual 2>err &&
+	test-tool run-command run-command ./hello.sh >actual 2>err &&
 
 	test_cmp hello-script actual &&
 	test_cmp empty err
@@ -31,7 +31,7 @@ test_expect_success !MINGW 'run_command can run a script without a #! line' '
 	cat hello-script
 	EOF
 	chmod +x hello &&
-	test-run-command run-command ./hello >actual 2>err &&
+	test-tool run-command run-command ./hello >actual 2>err &&
 
 	test_cmp hello-script actual &&
 	test_cmp empty err
@@ -45,7 +45,7 @@ test_expect_success 'run_command does not try to execute a directory' '
 	EOF
 
 	PATH=$PWD/bin1:$PWD/bin2:$PATH \
-		test-run-command run-command greet >actual 2>err &&
+		test-tool run-command run-command greet >actual 2>err &&
 	test_cmp bin2/greet actual &&
 	test_cmp empty err
 '
@@ -62,7 +62,7 @@ test_expect_success POSIXPERM 'run_command passes over non-executable file' '
 	EOF
 
 	PATH=$PWD/bin1:$PWD/bin2:$PATH \
-		test-run-command run-command greet >actual 2>err &&
+		test-tool run-command run-command greet >actual 2>err &&
 	test_cmp bin2/greet actual &&
 	test_cmp empty err
 '
@@ -70,7 +70,7 @@ test_expect_success POSIXPERM 'run_command passes over non-executable file' '
 test_expect_success POSIXPERM 'run_command reports EACCES' '
 	cat hello-script >hello.sh &&
 	chmod -x hello.sh &&
-	test_must_fail test-run-command run-command ./hello.sh 2>err &&
+	test_must_fail test-tool run-command run-command ./hello.sh 2>err &&
 
 	grep "fatal: cannot exec.*hello.sh" err
 '
@@ -104,17 +104,17 @@ World
 EOF
 
 test_expect_success 'run_command runs in parallel with more jobs available than tasks' '
-	test-run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-parallel 5 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'run_command runs in parallel with as many jobs as tasks' '
-	test-run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-parallel 4 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'run_command runs in parallel with more tasks than jobs available' '
-	test-run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-parallel 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
 	test_cmp expect actual
 '
 
@@ -128,7 +128,7 @@ asking for a quick stop
 EOF
 
 test_expect_success 'run_command is asked to abort gracefully' '
-	test-run-command run-command-abort 3 false 2>actual &&
+	test-tool run-command run-command-abort 3 false 2>actual &&
 	test_cmp expect actual
 '
 
@@ -137,14 +137,14 @@ no further jobs available
 EOF
 
 test_expect_success 'run_command outputs ' '
-	test-run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test-tool run-command run-command-no-jobs 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
 	test_cmp expect actual
 '
 
 test_trace () {
 	expect="$1"
 	shift
-	GIT_TRACE=1 test-run-command "$@" run-command true 2>&1 >/dev/null | \
+	GIT_TRACE=1 test-tool run-command "$@" run-command true 2>&1 >/dev/null | \
 		sed 's/.* run_command: //' >actual &&
 	echo "$expect true" >expect &&
 	test_cmp expect actual
-- 
2.16.2.903.gd04caf5039

