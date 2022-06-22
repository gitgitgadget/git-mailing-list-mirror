Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8115CCA47F
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 19:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiFVTro (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 15:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359444AbiFVTrh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 15:47:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9890D40900
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 12:47:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m1so17117209wrb.2
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 12:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Vi+i48eMxnvRJaNNo4BQ8di+4GMF6oow0RJg4IpzH9A=;
        b=YnaPmikm7+5kglILTeehvVIiiNa6dXmj7Qge8xITjkaJOH2/hYM+UQkC6eCU8NhPvP
         paDwfvwI99wuztWYKSNnaxLqyJ9yOXMnfx9ia+CgkqczsQccpYjiZOcF/4aeZJd8g2ei
         YqMqsEU3bFf20z39ms5mhZz8h8AjmGrPbQB+MN3y0R5sKbiOI519uq14D1g8Hg3o1Rji
         tvdhd9Vn6mWc2oJbbRinh5ITMKRdgWCFddanxW6axav6nifVN48vj096/Yr0mqAOgQ05
         i7X2BNCZoUloUMq4WmkTSvq63WQHfIVhC6bmYphgjM2ll/UnvZFdB5K8ZxLP1bZkAkiL
         7lBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Vi+i48eMxnvRJaNNo4BQ8di+4GMF6oow0RJg4IpzH9A=;
        b=agF+srwQUI0ta3gn3smbUwE5APARWFZF/Kjoh4EYGBqQUBYtAI6wEj8/BXRa8bG3Zs
         ySO44zRsnDbOeoE8XQSD45MWcIZ3n9tpEbkjmSpJIs+IUqluz/C52t3A2a/x6KVwj1LP
         /YGnoKXEGyF8gVHpHkPVauM+ROV/5CH2VpKxdvBs+4TXRQz0cShcnDtpzBBeCImkbi4J
         ee4N2doU+WqpOtLMxCVVsdn1f8rCXpqPdcPynWTpamQaOIUyladxMIZmQoaK5nJXvhyv
         zUBmqjB2MrDFscZZfucGVUElpBa2BC4/0iCtu69kK2IfUYwhDe76wc8t0AoWp31/uCv+
         Qa4g==
X-Gm-Message-State: AJIora/Swpv8fpWjpPs8dy3M7/AwKoVrWuJMn4hAiUmngPnHSKv9vERl
        Dp7M/RQhVwtHNG/iCFOuFZ9DgbHGVxKg3Q==
X-Google-Smtp-Source: AGRyM1vzR+oE4fFLW/oXEL7fGJeRIAKzD6fGpaeoczJcqdQZU5KCwizs0KcL157M74lqfMLX2s+aXQ==
X-Received: by 2002:adf:f74e:0:b0:21b:8a04:7bce with SMTP id z14-20020adff74e000000b0021b8a047bcemr5049910wrp.0.1655927254630;
        Wed, 22 Jun 2022 12:47:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12-20020a05600c34cc00b0039c63f4bce0sm436071wmq.12.2022.06.22.12.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 12:47:33 -0700 (PDT)
Message-Id: <pull.1278.v4.git.git.1655927252899.gitgitgadget@gmail.com>
In-Reply-To: <pull.1278.v3.git.git.1655917628.gitgitgadget@gmail.com>
References: <pull.1278.v3.git.git.1655917628.gitgitgadget@gmail.com>
From:   "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Jun 2022 19:47:32 +0000
Subject: [PATCH v4] grep: add --max-count command line option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Martin =?UTF-8?Q?=C3=85gren?= [ ]" <martin.agren@gmail.com>,
        "Paul Eggert [ ]" <eggert@cs.ucla.edu>,
        "Carlos L." <00xc@protonmail.com>,
        =?UTF-8?q?Carlos=20L=C3=B3pez?= <00xc@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <00xc@protonmail.com>

This patch adds a command line option analogous to that of GNU
grep(1)'s -m / --max-count, which users might already be used to.
This makes it possible to limit the amount of matches shown in the
output while keeping the functionality of other options such as -C
(show code context) or -p (show containing function), which would be
difficult to do with a shell pipeline (e.g. head(1)).

Signed-off-by: Carlos López 00xc@protonmail.com
---
    grep: add --max-count command line option
    
    This patch adds a command line option analogous to that of GNU grep(1)'s
    -m / --max-count, which users might already be used to. This makes it
    possible to limit the amount of matches shown in the output while
    keeping the functionality of other options such as -C (show code
    context) or -p (show containing function), which would be difficult to
    do with a shell pipeline (e.g. head(1)).
    
    Signed-off-by: Carlos López 00xc@protonmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1278%2F00xc%2Fmaster-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1278/00xc/master-v4
Pull-Request: https://github.com/git/git/pull/1278

Range-diff vs v3:

 1:  5bf7244437e ! 1:  89c0151c164 grep: add --max-count command line option
     @@ grep.h: struct grep_opt {
       	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
       	.colors = { \
       		[GREP_COLOR_CONTEXT] = "", \
     +
     + ## t/t7810-grep.sh ##
     +@@ t/t7810-grep.sh: test_expect_success setup '
     + 	# Say hello.
     + 	function hello() {
     + 	  echo "Hello world."
     ++	  echo "Hello again."
     + 	} # hello
     + 
     + 	# Still a no-op.
     +@@ t/t7810-grep.sh: test_expect_success 'grep --files-without-match --quiet' '
     + 	test_must_be_empty actual
     + '
     + 
     ++test_expect_success 'grep --max-count 0 (must exit with non-zero)' '
     ++	test_must_fail git grep --max-count 0 foo >actual &&
     ++	test_must_be_empty actual
     ++'
     ++
     ++test_expect_success 'grep --max-count 3' '
     ++	cat >expected <<-EOF &&
     ++	file:foo mmap bar
     ++	file:foo_mmap bar
     ++	file:foo_mmap bar mmap
     ++	EOF
     ++	git grep --max-count 3 foo >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'grep --max-count -1 (no limit)' '
     ++	cat >expected <<-EOF &&
     ++	file:foo mmap bar
     ++	file:foo_mmap bar
     ++	file:foo_mmap bar mmap
     ++	file:foo mmap bar_mmap
     ++	file:foo_mmap bar mmap baz
     ++	EOF
     ++	git grep --max-count -1 foo >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'grep --max-count 1 --context 2' '
     ++	cat >expected <<-EOF &&
     ++	file-foo mmap bar
     ++	file:foo_mmap bar
     ++	file-foo_mmap bar mmap
     ++	EOF
     ++	git grep --max-count 1 --context 1 foo_mmap >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'grep --max-count 1 --show-function' '
     ++	cat >expected <<-EOF &&
     ++	hello.ps1=function hello() {
     ++	hello.ps1:  echo "Hello world."
     ++	EOF
     ++	git grep --max-count 1 --show-function Hello hello.ps1 >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'grep --max-count 2 --show-function' '
     ++	cat >expected <<-EOF &&
     ++	hello.ps1=function hello() {
     ++	hello.ps1:  echo "Hello world."
     ++	hello.ps1:  echo "Hello again."
     ++	EOF
     ++	git grep --max-count 2 --show-function Hello hello.ps1 >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'grep --max-count 1 --count' '
     ++	cat >expected <<-EOF &&
     ++	hello.ps1:1
     ++	EOF
     ++	git grep --max-count 1 --count Hello hello.ps1 >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'grep --max-count 1 (multiple files)' '
     ++	cat >expected <<-EOF &&
     ++	hello.c:#include <stdio.h>
     ++	hello.ps1:# No-op.
     ++	EOF
     ++	git grep --max-count 1 -e o -- hello.\* >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'grep --max-count 1 --context 1 (multiple files)' '
     ++	cat >expected <<-EOF &&
     ++	hello.c-#include <assert.h>
     ++	hello.c:#include <stdio.h>
     ++	hello.c-
     ++	--
     ++	hello.ps1:# No-op.
     ++	hello.ps1-function dummy() {}
     ++	EOF
     ++	git grep --max-count 1 --context 1 -e o -- hello.\* >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     + cat >expected <<EOF
     + file:foo mmap bar_mmap
     + EOF
 2:  525958af877 < -:  ----------- tests: add tests for grep --max-count


 Documentation/git-grep.txt |  9 ++++
 builtin/grep.c             |  9 ++++
 grep.c                     |  2 +-
 grep.h                     |  2 +
 t/t7810-grep.sh            | 87 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3d393fbac1b..58d944bd578 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -23,6 +23,7 @@ SYNOPSIS
 	   [--break] [--heading] [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-W | --function-context]
+	   [(-m | --max-count) <num>]
 	   [--threads <num>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
@@ -238,6 +239,14 @@ providing this option will cause it to die.
 	`git diff` works out patch hunk headers (see 'Defining a
 	custom hunk-header' in linkgit:gitattributes[5]).
 
+-m <num>::
+--max-count <num>::
+	Limit the amount of matches per file. When using the `-v` or
+	`--invert-match` option, the search stops after the specified
+	number of non-matches. A value of -1 will return unlimited
+	results (the default). A value of 0 will exit immediately with
+	a non-zero status.
+
 --threads <num>::
 	Number of grep worker threads to use.
 	See `grep.threads` in 'CONFIGURATION' for more information.
diff --git a/builtin/grep.c b/builtin/grep.c
index bcb07ea7f75..e6bcdf860cc 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -961,6 +961,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "ext-grep", &external_grep_allowed__ignored,
 			   N_("allow calling of grep(1) (ignored by this build)"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_INTEGER('m', "max-count", &opt.max_count,
+			N_("maximum number of results per file")),
 		OPT_END()
 	};
 	grep_prefix = prefix;
@@ -1101,6 +1103,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (recurse_submodules && untracked)
 		die(_("--untracked not supported with --recurse-submodules"));
 
+	/*
+	 * Optimize out the case where the amount of matches is limited to zero.
+	 * We do this to keep results consistent with GNU grep(1).
+	 */
+	if (opt.max_count == 0)
+		return 1;
+
 	if (show_in_pager) {
 		if (num_threads > 1)
 			warning(_("invalid option combination, ignoring --threads"));
diff --git a/grep.c b/grep.c
index 82eb7da1022..52a894c9890 100644
--- a/grep.c
+++ b/grep.c
@@ -1615,7 +1615,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 				return 0;
 			goto next_line;
 		}
-		if (hit) {
+		if (hit && (opt->max_count < 0 || count < opt->max_count)) {
 			count++;
 			if (opt->status_only)
 				return 1;
diff --git a/grep.h b/grep.h
index c722d25ed9d..bdcadce61b8 100644
--- a/grep.h
+++ b/grep.h
@@ -171,6 +171,7 @@ struct grep_opt {
 	int show_hunk_mark;
 	int file_break;
 	int heading;
+	int max_count;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
@@ -181,6 +182,7 @@ struct grep_opt {
 	.relative = 1, \
 	.pathname = 1, \
 	.max_depth = -1, \
+	.max_count = -1, \
 	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
 	.colors = { \
 		[GREP_COLOR_CONTEXT] = "", \
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 69356011713..0f937990a06 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -77,6 +77,7 @@ test_expect_success setup '
 	# Say hello.
 	function hello() {
 	  echo "Hello world."
+	  echo "Hello again."
 	} # hello
 
 	# Still a no-op.
@@ -595,6 +596,92 @@ test_expect_success 'grep --files-without-match --quiet' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'grep --max-count 0 (must exit with non-zero)' '
+	test_must_fail git grep --max-count 0 foo >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'grep --max-count 3' '
+	cat >expected <<-EOF &&
+	file:foo mmap bar
+	file:foo_mmap bar
+	file:foo_mmap bar mmap
+	EOF
+	git grep --max-count 3 foo >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --max-count -1 (no limit)' '
+	cat >expected <<-EOF &&
+	file:foo mmap bar
+	file:foo_mmap bar
+	file:foo_mmap bar mmap
+	file:foo mmap bar_mmap
+	file:foo_mmap bar mmap baz
+	EOF
+	git grep --max-count -1 foo >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --max-count 1 --context 2' '
+	cat >expected <<-EOF &&
+	file-foo mmap bar
+	file:foo_mmap bar
+	file-foo_mmap bar mmap
+	EOF
+	git grep --max-count 1 --context 1 foo_mmap >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --max-count 1 --show-function' '
+	cat >expected <<-EOF &&
+	hello.ps1=function hello() {
+	hello.ps1:  echo "Hello world."
+	EOF
+	git grep --max-count 1 --show-function Hello hello.ps1 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --max-count 2 --show-function' '
+	cat >expected <<-EOF &&
+	hello.ps1=function hello() {
+	hello.ps1:  echo "Hello world."
+	hello.ps1:  echo "Hello again."
+	EOF
+	git grep --max-count 2 --show-function Hello hello.ps1 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --max-count 1 --count' '
+	cat >expected <<-EOF &&
+	hello.ps1:1
+	EOF
+	git grep --max-count 1 --count Hello hello.ps1 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --max-count 1 (multiple files)' '
+	cat >expected <<-EOF &&
+	hello.c:#include <stdio.h>
+	hello.ps1:# No-op.
+	EOF
+	git grep --max-count 1 -e o -- hello.\* >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --max-count 1 --context 1 (multiple files)' '
+	cat >expected <<-EOF &&
+	hello.c-#include <assert.h>
+	hello.c:#include <stdio.h>
+	hello.c-
+	--
+	hello.ps1:# No-op.
+	hello.ps1-function dummy() {}
+	EOF
+	git grep --max-count 1 --context 1 -e o -- hello.\* >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 file:foo mmap bar_mmap
 EOF

base-commit: 5b71c59bc3b9365075e2a175aa7b6f2b0c84ce44
-- 
gitgitgadget
