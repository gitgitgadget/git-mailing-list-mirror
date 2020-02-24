Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B1DC35671
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 13:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64BE2080D
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 13:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWGGyarV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgBXNjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:39:12 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:44570 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgBXNjM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 08:39:12 -0500
Received: by mail-pf1-f178.google.com with SMTP id y5so5377598pfb.11
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 05:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iA+ZwYfrRjsK0Ck9VChyOXKJEUfiqsxlO3GrtnFyLrk=;
        b=MWGGyarVOv3DAv6Uhn0wrdhPZX7PxM68yB7AWtsk2lIj5/qdjHLMkJZmnr/qKRkPG0
         GUyjzSPmp02KokJ8o4Dk8rPovoqLZcFzw+4H+7jGvzWLU/iNy/znALJb1gPP6ykBVhPF
         bZY1jMx9QfZR4zBo55s3My2eOD2BCUwU0EE1aRbazb2KE8KiFcDQta1PgTy5SQfLygDc
         UwbjV8RPPbHMAvD8EqhiermWXcnM6DG2jXC1cFfQ/72WzS1VN7THwnn4wdCFKHL+W6ww
         yTQ++0mj3iDWZvZHGi1UNBz6aKosLeJFq5vsdBRLy+7irYpj+YQehNZHhB2HbsUc7lFW
         OcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iA+ZwYfrRjsK0Ck9VChyOXKJEUfiqsxlO3GrtnFyLrk=;
        b=gu+ZLoY4uNRGkC1snArPi03cCfRMTq66eHy8QvEIdzQhptYMlbr/yBj3RhhAQK7ypo
         zQBMVBgHz7igNVYYCyfaoJDxOr4f3YP8wzqFLONmHZ71pCtqTEKZFUmiGmXkL2uORA9S
         Y4kopx3qBPA64fLnIj8UeL1vKu5M8d0+8ios/OfHCyYMRUSs39bioid9UxDkSAjT97hx
         sYb2cBvtqafVlFPMTzYqEZJbszKWW1nvgamDrntX0DyZsCZClOLejj2kojpooEm/fq5A
         AAWWl9lqxZyN/GnKptX/3BxeAVoQNJVB7TfNz5hNLQjAAXtkx1c/GMUddrJjpsYoYwfc
         ggew==
X-Gm-Message-State: APjAAAWjzYGvf8MQwhNb86KUiVo7v7xtnpSb9poIt07zgVvOwHhyfIu2
        AZ/RCZv1Ip0+ku3rhuHbYPT/oBPjoHppIg==
X-Google-Smtp-Source: APXvYqwhWDhOXVZw1vlHhK0AN4rNNNglbeyO+iT6L+p0ILsV7ZyODfoWuntyt9WQEg+copkozlOpzQ==
X-Received: by 2002:a63:1044:: with SMTP id 4mr54832259pgq.412.1582551551351;
        Mon, 24 Feb 2020 05:39:11 -0800 (PST)
Received: from Abhishek-Arch.nitk.ac.in ([218.248.46.83])
        by smtp.gmail.com with ESMTPSA id o6sm12945774pgg.37.2020.02.24.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 05:39:10 -0800 (PST)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     abhishekkumar8222@gmail.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: [GSoC Patch v3 1/2] lib-log-graph: consolidate test_cmp_graph logic
Date:   Mon, 24 Feb 2020 19:08:13 +0530
Message-Id: <20200224133814.100150-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Log graph comparision logic is duplicated many times in:
- t3430-rebase-merges.sh
- t4202-log.sh
- t4214-log-graph-octopus.sh
- t4215-log-skewed-merges.sh

This patch consolidates comparision and sanitization logic in
lib-log-graph.

Replaces duplicated code with local and lib helpers - making test
scripts cleaner and more readable.

Closes gitgitgadget issue #471

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
Changes in v3:
- Elaborate on first commit message.
- Fix SP violations in lib-log-graph.

Changes in v2:
- Arrange patches by functions changed instead of files changed.
- Rename library functions by prepending 'lib_'.
- Drop outdated sanitization calls to sed.
- Create specialized helpers to reduce code noise.
- Fix style violations.

 t/lib-log-graph.sh           | 22 +++++++++++++++
 t/t3430-rebase-merges.sh     |  5 ++--
 t/t4202-log.sh               | 53 ++++++++++--------------------------
 t/t4214-log-graph-octopus.sh | 46 ++++++++++---------------------
 t/t4215-log-skewed-merges.sh |  5 ++--
 5 files changed, 54 insertions(+), 77 deletions(-)
 create mode 100755 t/lib-log-graph.sh

diff --git a/t/lib-log-graph.sh b/t/lib-log-graph.sh
new file mode 100755
index 0000000000..f9c6526eff
--- /dev/null
+++ b/t/lib-log-graph.sh
@@ -0,0 +1,22 @@
+# Helps shared by the test scripts for comparing log graphs.
+
+sanitize_log_output () {
+	sed -e 's/ *$//' \
+	    -e 's/commit [0-9a-f]*$/commit COMMIT_OBJECT_NAME/' \
+	    -e 's/Merge: [ 0-9a-f]*$/Merge: MERGE_PARENTS/' \
+	    -e 's/Merge tag.*/Merge HEADS DESCRIPTION/' \
+	    -e 's/Merge commit.*/Merge HEADS DESCRIPTION/' \
+	    -e 's/index [0-9a-f]*\.\.[0-9a-f]*/index BEFORE..AFTER/'
+}
+
+lib_test_cmp_graph () {
+	git log --graph "$@" >output &&
+	sed 's/ *$//' >output.sanitized <output &&
+	test_i18ncmp expect output.sanitized
+}
+
+lib_test_cmp_short_graph () {
+	git log --graph --pretty=short "$@" >output &&
+	sanitize_log_output >output.sanitized <output &&
+	test_i18ncmp expect output.sanitized
+}
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index e72ca348ea..a1bc3e2001 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -20,12 +20,11 @@ Initial setup:
 '
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
+. "$TEST_DIRECTORY"/lib-log-graph.sh
 
 test_cmp_graph () {
 	cat >expect &&
-	git log --graph --boundary --format=%s "$@" >output &&
-	sed "s/ *$//" <output >output.trimmed &&
-	test_cmp expect output.trimmed
+	lib_test_cmp_graph --boundary --format=%s "$@"
 }
 
 test_expect_success 'setup' '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 192347a3e1..e025a9cfc2 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -5,6 +5,11 @@ test_description='git log'
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 . "$TEST_DIRECTORY/lib-terminal.sh"
+. "$TEST_DIRECTORY/lib-log-graph.sh"
+
+test_cmp_graph () {
+	lib_test_cmp_graph --format=%s "$@"
+}
 
 test_expect_success setup '
 
@@ -452,8 +457,7 @@ cat > expect <<EOF
 EOF
 
 test_expect_success 'simple log --graph' '
-	git log --graph --pretty=tformat:%s >actual &&
-	test_cmp expect actual
+	test_cmp_graph
 '
 
 cat > expect <<EOF
@@ -467,8 +471,7 @@ cat > expect <<EOF
 EOF
 
 test_expect_success 'simple log --graph --line-prefix="123 "' '
-	git log --graph --line-prefix="123 " --pretty=tformat:%s >actual &&
-	test_cmp expect actual
+	test_cmp_graph --line-prefix="123 "
 '
 
 test_expect_success 'set up merge history' '
@@ -495,9 +498,7 @@ cat > expect <<\EOF
 EOF
 
 test_expect_success 'log --graph with merge' '
-	git log --graph --date-order --pretty=tformat:%s |
-		sed "s/ *\$//" >actual &&
-	test_cmp expect actual
+	test_cmp_graph --date-order
 '
 
 cat > expect <<\EOF
@@ -516,9 +517,7 @@ cat > expect <<\EOF
 EOF
 
 test_expect_success 'log --graph --line-prefix="| | | " with merge' '
-	git log --line-prefix="| | | " --graph --date-order --pretty=tformat:%s |
-		sed "s/ *\$//" >actual &&
-	test_cmp expect actual
+	test_cmp_graph --line-prefix="| | | " --date-order
 '
 
 cat > expect.colors <<\EOF
@@ -676,9 +675,7 @@ cat > expect <<\EOF
 EOF
 
 test_expect_success 'log --graph with merge' '
-	git log --graph --date-order --pretty=tformat:%s |
-		sed "s/ *\$//" >actual &&
-	test_cmp expect actual
+	test_cmp_graph --date-order
 '
 
 test_expect_success 'log.decorate configuration' '
@@ -1213,24 +1210,8 @@ cat >expect <<\EOF
   +one
 EOF
 
-sanitize_output () {
-	sed -e 's/ *$//' \
-	    -e 's/commit [0-9a-f]*$/commit COMMIT_OBJECT_NAME/' \
-	    -e 's/Merge: [ 0-9a-f]*$/Merge: MERGE_PARENTS/' \
-	    -e 's/Merge tag.*/Merge HEADS DESCRIPTION/' \
-	    -e 's/Merge commit.*/Merge HEADS DESCRIPTION/' \
-	    -e 's/, 0 deletions(-)//' \
-	    -e 's/, 0 insertions(+)//' \
-	    -e 's/ 1 files changed, / 1 file changed, /' \
-	    -e 's/, 1 deletions(-)/, 1 deletion(-)/' \
-	    -e 's/, 1 insertions(+)/, 1 insertion(+)/' \
-	    -e 's/index [0-9a-f]*\.\.[0-9a-f]*/index BEFORE..AFTER/'
-}
-
 test_expect_success 'log --graph with diff and stats' '
-	git log --no-renames --graph --pretty=short --stat -p >actual &&
-	sanitize_output >actual.sanitized <actual &&
-	test_i18ncmp expect actual.sanitized
+	lib_test_cmp_short_graph --no-renames --stat -p
 '
 
 cat >expect <<\EOF
@@ -1505,9 +1486,7 @@ cat >expect <<\EOF
 EOF
 
 test_expect_success 'log --line-prefix="*** " --graph with diff and stats' '
-	git log --line-prefix="*** " --no-renames --graph --pretty=short --stat -p >actual &&
-	sanitize_output >actual.sanitized <actual &&
-	test_i18ncmp expect actual.sanitized
+	lib_test_cmp_short_graph --line-prefix="*** " --no-renames --stat -p
 '
 
 cat >expect <<-\EOF
@@ -1529,9 +1508,7 @@ cat >expect <<-\EOF
 EOF
 
 test_expect_success 'log --graph with --name-status' '
-	git log --graph --format=%s --name-status tangle..reach >actual &&
-	sanitize_output <actual >actual.sanitized &&
-	test_cmp expect actual.sanitized
+	test_cmp_graph --name-status tangle..reach
 '
 
 cat >expect <<-\EOF
@@ -1553,9 +1530,7 @@ cat >expect <<-\EOF
 EOF
 
 test_expect_success 'log --graph with --name-only' '
-	git log --graph --format=%s --name-only tangle..reach >actual &&
-	sanitize_output <actual >actual.sanitized &&
-	test_cmp expect actual.sanitized
+	test_cmp_graph --name-only tangle..reach
 '
 
 test_expect_success 'dotdot is a parent directory' '
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 40d27db674..dedb72ace6 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -3,6 +3,12 @@
 test_description='git log --graph of skewed left octopus merge.'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-log-graph.sh
+
+test_cmp_graph () {
+	cat >expect &&
+	lib_test_cmp_graph --color=never --date-order --format=%s "$@"
+}
 
 test_expect_success 'set up merge history' '
 	test_commit initial &&
@@ -24,7 +30,7 @@ test_expect_success 'set up merge history' '
 '
 
 test_expect_success 'log --graph with tricky octopus merge, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph left octopus-merge <<-\EOF
 	* left
 	| *-.   octopus-merge
 	|/|\ \
@@ -37,9 +43,6 @@ test_expect_success 'log --graph with tricky octopus merge, no color' '
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s left octopus-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with tricky octopus merge with colors' '
@@ -66,7 +69,7 @@ test_expect_success 'log --graph with tricky octopus merge with colors' '
 # without the first parent skewing to the "left" branch column).
 
 test_expect_success 'log --graph with normal octopus merge, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph octopus-merge <<-\EOF
 	*---.   octopus-merge
 	|\ \ \
 	| | | * 4
@@ -78,9 +81,6 @@ test_expect_success 'log --graph with normal octopus merge, no color' '
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s octopus-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with normal octopus merge with colors' '
@@ -103,7 +103,7 @@ test_expect_success 'log --graph with normal octopus merge with colors' '
 '
 
 test_expect_success 'log --graph with normal octopus merge and child, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph after-merge <<-\EOF
 	* after-merge
 	*---.   octopus-merge
 	|\ \ \
@@ -116,9 +116,6 @@ test_expect_success 'log --graph with normal octopus merge and child, no color'
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s after-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with normal octopus and child merge with colors' '
@@ -142,7 +139,7 @@ test_expect_success 'log --graph with normal octopus and child merge with colors
 '
 
 test_expect_success 'log --graph with tricky octopus merge and its child, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph left after-merge <<-\EOF
 	* left
 	| * after-merge
 	| *-.   octopus-merge
@@ -156,9 +153,6 @@ test_expect_success 'log --graph with tricky octopus merge and its child, no col
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s left after-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with tricky octopus merge and its child with colors' '
@@ -183,7 +177,7 @@ test_expect_success 'log --graph with tricky octopus merge and its child with co
 '
 
 test_expect_success 'log --graph with crossover in octopus merge, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph after-4 octopus-merge <<-\EOF
 	* after-4
 	| *---.   octopus-merge
 	| |\ \ \
@@ -200,9 +194,6 @@ test_expect_success 'log --graph with crossover in octopus merge, no color' '
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s after-4 octopus-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with crossover in octopus merge with colors' '
@@ -230,7 +221,7 @@ test_expect_success 'log --graph with crossover in octopus merge with colors' '
 '
 
 test_expect_success 'log --graph with crossover in octopus merge and its child, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph after-4 after-merge <<-\EOF
 	* after-4
 	| * after-merge
 	| *---.   octopus-merge
@@ -248,9 +239,6 @@ test_expect_success 'log --graph with crossover in octopus merge and its child,
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s after-4 after-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with crossover in octopus merge and its child with colors' '
@@ -279,7 +267,7 @@ test_expect_success 'log --graph with crossover in octopus merge and its child w
 '
 
 test_expect_success 'log --graph with unrelated commit and octopus tip, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph after-initial octopus-merge <<-\EOF
 	* after-initial
 	| *---.   octopus-merge
 	| |\ \ \
@@ -296,9 +284,6 @@ test_expect_success 'log --graph with unrelated commit and octopus tip, no color
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s after-initial octopus-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with unrelated commit and octopus tip with colors' '
@@ -326,7 +311,7 @@ test_expect_success 'log --graph with unrelated commit and octopus tip with colo
 '
 
 test_expect_success 'log --graph with unrelated commit and octopus child, no color' '
-	cat >expect.uncolored <<-\EOF &&
+	test_cmp_graph after-initial after-merge <<-\EOF
 	* after-initial
 	| * after-merge
 	| *---.   octopus-merge
@@ -344,9 +329,6 @@ test_expect_success 'log --graph with unrelated commit and octopus child, no col
 	|/
 	* initial
 	EOF
-	git log --color=never --graph --date-order --pretty=tformat:%s after-initial after-merge >actual.raw &&
-	sed "s/ *\$//" actual.raw >actual &&
-	test_cmp expect.uncolored actual
 '
 
 test_expect_success 'log --graph with unrelated commit and octopus child with colors' '
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 1d0d3240ff..e1e94176da 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -3,12 +3,11 @@
 test_description='git log --graph of skewed merges'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-log-graph.sh
 
 check_graph () {
 	cat >expect &&
-	git log --graph --pretty=tformat:%s "$@" >actual.raw &&
-	sed "s/ *$//" actual.raw >actual &&
-	test_cmp expect actual
+	lib_test_cmp_graph --format=%s "$@"
 }
 
 test_expect_success 'log --graph with merge fusing with its left and right neighbors' '
-- 
2.25.1

