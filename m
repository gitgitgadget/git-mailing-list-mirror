Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF21C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D216139A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 12:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhGVMOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 08:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhGVMOh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 08:14:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8FCC061757
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m38-20020a05600c3b26b02902161fccabf1so1495678wms.2
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 05:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfXE2YPfrcya2S5gKxrerIGkt/VeI9ORrEjezAT9N/M=;
        b=pMwE4YVunOSoZ9Vh0Kbs7JVtAGYwJ8F8KA5LnfUfDTQ9L16dwfgZPn2oBnJ0tnoyUV
         mQGQ5WEcMqvDkuHVOXsBcbieY7xo/dd/sjkOQ+3OQx5Qrg7z64TQGt/s+dAzVPDw/QIy
         38WL1epxKVgoQPDyewgClVCn1Q6SgkklvCawjrHciDg1KgIiwBx1WXP/d8K9n9mJhJ18
         pxaUjr/c0c6ld9QLQGL5Q/xJJlFCAR272H6V7gBu+gYDd4MG5h1lBDol0rX8DVdFaJv2
         rRVZ1hqPXwuHZZ+qA/DO7PNAqgaOU49fy5YlUrpDGp2uGAskPt4Vp8R4lFP71oFCkOyl
         Ssjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfXE2YPfrcya2S5gKxrerIGkt/VeI9ORrEjezAT9N/M=;
        b=Ex0GRHt1K0gdL3K/ZPeYGTDdltVELNPjncQooW5OsJWW1m1RbUIPcHhnfUwoOY+NbJ
         DBFAzbx7YJvY2YwPlLTGeA5qULBA/2JEXUOQQNnikx7DunHxz0elc+f4PsMvBfPuMtY1
         H7GvbAwVuELKVNnod050gkybk2hxy5jP9OWDLz3GUzz3Zc9sGvPQUtYqCzUUNA0c0ZM/
         JSpawG0tX41CA6g1amZN5xhuAN2X7TR+LJ8UP+Dv21qAtV/o3fj0i8zXyJf+kFN7mOCn
         BpNgPwy6Gsl7I2hfcIE4jhcteEVh9zca0gTPHx7dTHUcn2shbRKuMp6U/F+x7WcVYmE0
         K4Aw==
X-Gm-Message-State: AOAM532lTGySshTZB23mRIYBj0tI3b9M9U6/YDZxmNP0a7Sx1U/Lzuux
        x7JsmKEfPjPX0FdwefO6cSHBBdPA/RfXfQ==
X-Google-Smtp-Source: ABdhPJzazK0/8qJhbraUky2QNLgFQ6nG1WeQ7Uh8MXxMYPkvltlGfizh5Bd9CqFvCkJn8lWJ+YgOzQ==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr41999144wme.107.1626958510365;
        Thu, 22 Jul 2021 05:55:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm29937483wru.95.2021.07.22.05.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:55:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/8] progress.c tests: make start/stop verbs on stdin
Date:   Thu, 22 Jul 2021 14:54:59 +0200
Message-Id: <patch-1.8-0a137d9af3-20210722T125012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.957.gd9e39d72fe6
In-Reply-To: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com> <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the usage of the "test-tool progress" introduced in
2bb74b53a49 (Test the progress display, 2019-09-16) to take command
like "start" and "stop" on stdin, instead of running them implicitly.

This makes for tests that are easier to read, since the recipe will
mirror the API usage, and allows for easily testing invalid usage that
would yield (or should yield) a BUG(), e.g. providing two "start"
calls in a row. A subsequent commit will add such stress tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-progress.c    | 43 +++++++++++++++++++--------
 t/t0500-progress-display.sh | 59 +++++++++++++++++++++++--------------
 2 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 5d05cbe789..685c0a7c49 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -3,6 +3,9 @@
  *
  * Reads instructions from standard input, one instruction per line:
  *
+ *   "start[ <total>[ <title>]]" - Call start_progress(title, total),
+ *                                 when "start" use a title of
+ *                                 "Working hard" with a total of 0.
  *   "progress <items>" - Call display_progress() with the given item count
  *                        as parameter.
  *   "throughput <bytes> <millis> - Call display_throughput() with the given
@@ -10,6 +13,7 @@
  *                                  specify the time elapsed since the
  *                                  start_progress() call.
  *   "update" - Set the 'progress_update' flag.
+ *   "stop" - Call stop_progress().
  *
  * See 't0500-progress-display.sh' for examples.
  */
@@ -22,31 +26,41 @@
 
 int cmd__progress(int argc, const char **argv)
 {
-	int total = 0;
-	const char *title;
+	const char *default_title = "Working hard";
+	char *detached_title = NULL;
 	struct strbuf line = STRBUF_INIT;
-	struct progress *progress;
+	struct progress *progress = NULL;
 
 	const char *usage[] = {
-		"test-tool progress [--total=<n>] <progress-title>",
+		"test-tool progress <stdin",
 		NULL
 	};
 	struct option options[] = {
-		OPT_INTEGER(0, "total", &total, "total number of items"),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, NULL, options, usage, 0);
-	if (argc != 1)
-		die("need a title for the progress output");
-	title = argv[0];
+	if (argc)
+		usage_with_options(usage, options);
 
 	progress_testing = 1;
-	progress = start_progress(title, total);
 	while (strbuf_getline(&line, stdin) != EOF) {
 		char *end;
 
-		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
+		if (!strcmp(line.buf, "start")) {
+			progress = start_progress(default_title, 0);
+		} else if (skip_prefix(line.buf, "start ", (const char **) &end)) {
+			uint64_t total = strtoull(end, &end, 10);
+			if (*end == '\0') {
+				progress = start_progress(default_title, total);
+			} else if (*end == ' ') {
+				free(detached_title);
+				detached_title = strbuf_detach(&line, NULL);
+				progress = start_progress(end + 1, total);
+			} else {
+				die("invalid input: '%s'\n", line.buf);
+			}
+		} else if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
 			uint64_t item_count = strtoull(end, &end, 10);
 			if (*end != '\0')
 				die("invalid input: '%s'\n", line.buf);
@@ -63,12 +77,15 @@ int cmd__progress(int argc, const char **argv)
 				die("invalid input: '%s'\n", line.buf);
 			progress_test_ns = test_ms * 1000 * 1000;
 			display_throughput(progress, byte_count);
-		} else if (!strcmp(line.buf, "update"))
+		} else if (!strcmp(line.buf, "update")) {
 			progress_test_force_update();
-		else
+		} else if (!strcmp(line.buf, "stop")) {
+			stop_progress(&progress);
+		} else {
 			die("invalid input: '%s'\n", line.buf);
+		}
 	}
-	stop_progress(&progress);
+	free(detached_title);
 
 	return 0;
 }
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 22058b503a..ca96ac1fa5 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -17,6 +17,7 @@ test_expect_success 'simple progress display' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 0
 	update
 	progress 1
 	update
@@ -25,8 +26,9 @@ test_expect_success 'simple progress display' '
 	progress 4
 	update
 	progress 5
+	stop
 	EOF
-	test-tool progress "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -41,11 +43,13 @@ test_expect_success 'progress display with total' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 3
 	progress 1
 	progress 2
 	progress 3
+	stop
 	EOF
-	test-tool progress --total=3 "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -62,14 +66,14 @@ Working hard.......2.........3.........4.........5.........6:
 EOF
 
 	cat >in <<-\EOF &&
+	start 100000 Working hard.......2.........3.........4.........5.........6
 	progress 100
 	progress 1000
 	progress 10000
 	progress 100000
+	stop
 	EOF
-	test-tool progress --total=100000 \
-		"Working hard.......2.........3.........4.........5.........6" \
-		<in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -88,16 +92,15 @@ Working hard.......2.........3.........4.........5.........6:
 EOF
 
 	cat >in <<-\EOF &&
-	update
+	start 100000 Working hard.......2.........3.........4.........5.........6
 	progress 1
 	update
 	progress 2
 	progress 10000
 	progress 100000
+	stop
 	EOF
-	test-tool progress --total=100000 \
-		"Working hard.......2.........3.........4.........5.........6" \
-		<in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -116,14 +119,14 @@ Working hard.......2.........3.........4.........5.........6:
 EOF
 
 	cat >in <<-\EOF &&
+	start 100000 Working hard.......2.........3.........4.........5.........6
 	progress 25000
 	progress 50000
 	progress 75000
 	progress 100000
+	stop
 	EOF
-	test-tool progress --total=100000 \
-		"Working hard.......2.........3.........4.........5.........6" \
-		<in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -140,14 +143,14 @@ Working hard.......2.........3.........4.........5.........6.........7.........:
 EOF
 
 	cat >in <<-\EOF &&
+	start 100000 Working hard.......2.........3.........4.........5.........6.........7.........
 	progress 25000
 	progress 50000
 	progress 75000
 	progress 100000
+	stop
 	EOF
-	test-tool progress --total=100000 \
-		"Working hard.......2.........3.........4.........5.........6.........7........." \
-		<in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -164,12 +167,14 @@ test_expect_success 'progress shortens - crazy caller' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 1000
 	progress 100
 	progress 200
 	progress 1
 	progress 1000
+	stop
 	EOF
-	test-tool progress --total=1000 "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -185,6 +190,7 @@ test_expect_success 'progress display with throughput' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start
 	throughput 102400 1000
 	update
 	progress 10
@@ -197,8 +203,9 @@ test_expect_success 'progress display with throughput' '
 	throughput 409600 4000
 	update
 	progress 40
+	stop
 	EOF
-	test-tool progress "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -214,6 +221,7 @@ test_expect_success 'progress display with throughput and total' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start 40
 	throughput 102400 1000
 	progress 10
 	throughput 204800 2000
@@ -222,8 +230,9 @@ test_expect_success 'progress display with throughput and total' '
 	progress 30
 	throughput 409600 4000
 	progress 40
+	stop
 	EOF
-	test-tool progress --total=40 "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -239,6 +248,7 @@ test_expect_success 'cover up after throughput shortens' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start
 	throughput 409600 1000
 	update
 	progress 1
@@ -251,8 +261,9 @@ test_expect_success 'cover up after throughput shortens' '
 	throughput 1638400 4000
 	update
 	progress 4
+	stop
 	EOF
-	test-tool progress "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -267,6 +278,7 @@ test_expect_success 'cover up after throughput shortens a lot' '
 	EOF
 
 	cat >in <<-\EOF &&
+	start
 	throughput 1 1000
 	update
 	progress 1
@@ -276,8 +288,9 @@ test_expect_success 'cover up after throughput shortens a lot' '
 	throughput 3145728 3000
 	update
 	progress 3
+	stop
 	EOF
-	test-tool progress "Working hard" <in 2>stderr &&
+	test-tool progress <in 2>stderr &&
 
 	show_cr <stderr >out &&
 	test_cmp expect out
@@ -285,6 +298,7 @@ test_expect_success 'cover up after throughput shortens a lot' '
 
 test_expect_success 'progress generates traces' '
 	cat >in <<-\EOF &&
+	start 40
 	throughput 102400 1000
 	update
 	progress 10
@@ -297,10 +311,11 @@ test_expect_success 'progress generates traces' '
 	throughput 409600 4000
 	update
 	progress 40
+	stop
 	EOF
 
-	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool progress --total=40 \
-		"Working hard" <in 2>stderr &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool progress \
+		<in 2>stderr &&
 
 	# t0212/parse_events.perl intentionally omits regions and data.
 	test_region progress "Working hard" trace.event &&
-- 
2.32.0.957.gd9e39d72fe6

