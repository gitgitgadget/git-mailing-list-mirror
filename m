Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5BEC83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475782073E
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2nIesxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgD2K0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgD2K0r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 06:26:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B197C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 03:26:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so1865952wrq.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=7jikg6kcfQDMm1pKvjxqLMkW7J0NyIpZlOhIaI+F4hs=;
        b=O2nIesxjXQWQt4oV27So8PozmXKKV0nnFMAPqa8ngpT0BoOS1BX6v7ZwnONKKKMxT2
         uX0QXDE53rOlNFMBfhTnUgKm/zFBlEVYELpGP9OPU5o2yRRdKr/bixy9mp/tarZkyJHs
         n3MpabiqrsFO2L6eLXLqK4ifNCDzqsd8+fxnUB6U0hvaVyPkhEEvmK/Uc3N8zgmTC5e/
         Hi4P1DVcv4hJ0BIeF1JnhTA5Mr9Onc7v35ECuMypgXsePMGzlvI91G+Z1WcGHdA+T/rn
         23j3+XHFQ4K0pKAot6fTAgJRb7lTQ8R7z5r+/M++YP4GqIewDdOBjVULUTV8+JJ+au1z
         FBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=7jikg6kcfQDMm1pKvjxqLMkW7J0NyIpZlOhIaI+F4hs=;
        b=YvD/ewF4I6ez5OX2X0csRLAGFucOryst545IqTNlRVy1wAVRwHtXdwianQ3wvhrWmV
         vUZdJaYaU6ec+Cdl/CJudnxns6/UzEItWVVs33j2ymhzAcym7qEe8c6M6q/dT0Aq5PNp
         uOQZJdimMQ+vjurXMSHIlqUb+tdGVxeJgxu1Q4ivsFdyuxGFcQ51Y+ATuFgHFwxzqcsM
         lL9sEFibnQmT+h1ekp43DeF1LLkcQxovS1UoTzv0IxXkj5NgcAHH/fF+rV2bV8bWNjYj
         LkZfbywTknorKueoRx3ahdGb+y69nODfiG7W3k3UDkuk9tllSs3wosz8cbZ0VSYc58hd
         VPTQ==
X-Gm-Message-State: AGi0Pua2R/dPeG8PgCUXB0YL8Ct59sWcjOrrSVcac24zKzqmztiMet8L
        YLAyv/0fyQyELN5dt1yOAv8=
X-Google-Smtp-Source: APiQypJz1FzVv4h9Vx1mqwQOOztq9K46E4SsLdh55o02Xnntq+e/7+x9PWTO/ZIvzWYGA7sMXUKY+A==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr39178847wrp.275.1588156005926;
        Wed, 29 Apr 2020 03:26:45 -0700 (PDT)
Received: from localhost.localdomain (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.gmail.com with ESMTPSA id c1sm30718196wrc.4.2020.04.29.03.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:26:45 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/5] rebase -i: add --ignore-whitespace flag
Date:   Wed, 29 Apr 2020 11:25:17 +0100
Message-Id: <20200429102521.47995-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429102521.47995-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200429102521.47995-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

Rebase is implemented with two different backends - 'apply' and 'merge'
each of which support a different set of options. In particuar the apply
backend supports a number of options implemented by 'git am' that are
not available to the merge backend. As part of an on going effort to
remove the apply backend this patch adds support for the
--ignore-whitespace option to the merge backend. This option treats
lines with only whitespace changes as unchanged and is implemented in
the merge backend by translating it to -Xignore-space-change.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt           | 12 +++-
 builtin/rebase.c                       | 19 ++++--
 t/t3422-rebase-incompatible-options.sh |  1 -
 t/t3436-rebase-more-options.sh         | 86 ++++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 7 deletions(-)
 create mode 100755 t/t3436-rebase-more-options.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607..d060c143e6 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -422,8 +422,16 @@ your branch contains commits which were dropped, this option can be used
 with `--keep-base` in order to drop those commits from your branch.
 
 --ignore-whitespace::
+	Behaves differently depending on which backend is selected.
++
+apply backend: When applying a patch, ignore changes in whitespace in
+context lines.
++
+merge backend: Treat lines with only whitespace changes as unchanged
+when merging.
+
 --whitespace=<option>::
-	These flags are passed to the 'git apply' program
+	This flag is passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
 	Implies --apply.
 +
@@ -572,7 +580,6 @@ The following options:
  * --apply
  * --committer-date-is-author-date
  * --ignore-date
- * --ignore-whitespace
  * --whitespace
  * -C
 
@@ -598,6 +605,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --signoff
  * --preserve-merges and --rebase-merges
  * --preserve-merges and --empty=
+ * --preserve-merges and --ignore-whitespace
  * --keep-base and --onto
  * --keep-base and --root
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 27a07d4e78..5d8e117276 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -86,6 +86,7 @@ struct rebase_options {
 	int signoff;
 	int allow_rerere_autoupdate;
 	int autosquash;
+	int ignore_whitespace;
 	char *gpg_sign_opt;
 	int autostash;
 	char *cmd;
@@ -108,6 +109,7 @@ struct rebase_options {
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 {
+	struct strbuf strategy_buf = STRBUF_INIT;
 	struct replay_opts replay = REPLAY_OPTS_INIT;
 
 	replay.action = REPLAY_INTERACTIVE_REBASE;
@@ -126,14 +128,20 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
+
 	if (opts->strategy_opts)
-		parse_strategy_opts(&replay, opts->strategy_opts);
+		strbuf_addstr(&strategy_buf, opts->strategy_opts);
+	if (opts->ignore_whitespace)
+		strbuf_addstr(&strategy_buf, " --ignore-space-change");
+	if (strategy_buf.len)
+		parse_strategy_opts(&replay, strategy_buf.buf);
 
 	if (opts->squash_onto) {
 		oidcpy(&replay.squash_onto, opts->squash_onto);
 		replay.have_squash_onto = 1;
 	}
 
+	strbuf_release(&strategy_buf);
 	return replay;
 }
 
@@ -539,6 +547,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
 
+	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
+
 	if (!is_null_oid(&squash_onto))
 		opts.squash_onto = &squash_onto;
 
@@ -991,6 +1001,8 @@ static int run_am(struct rebase_options *opts)
 	am.git_cmd = 1;
 	argv_array_push(&am.args, "am");
 
+	if (opts->ignore_whitespace)
+		argv_array_push(&am.args, "--ignore-whitespace");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1495,16 +1507,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
-		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
-				  NULL, N_("passed to 'git am'"),
-				  PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
 				  &options.git_am_opts, NULL,
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
+		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
+			 N_("ignore changes in whitespace")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
 				  N_("action"), N_("passed to 'git apply'"), 0),
 		OPT_BIT('f', "force-rebase", &options.flags,
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 50e7960702..55ca46786d 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -61,7 +61,6 @@ test_rebase_am_only () {
 }
 
 test_rebase_am_only --whitespace=fix
-test_rebase_am_only --ignore-whitespace
 test_rebase_am_only --committer-date-is-author-date
 test_rebase_am_only -C4
 
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
new file mode 100755
index 0000000000..fb5e747e86
--- /dev/null
+++ b/t/t3436-rebase-more-options.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Rohit Ashiwal
+#
+
+test_description='tests to ensure compatibility between am and interactive backends'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+# This is a special case in which both am and interactive backends
+# provide the same output. It was done intentionally because
+# both the backends fall short of optimal behaviour.
+test_expect_success 'setup' '
+	git checkout -b topic &&
+	q_to_tab >file <<-\EOF &&
+	line 1
+	Qline 2
+	line 3
+	EOF
+	git add file &&
+	git commit -m "add file" &&
+	cat >file <<-\EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	git commit -am "update file" &&
+	git tag side &&
+
+	git checkout --orphan master &&
+	sed -e "s/^|//" >file <<-\EOF &&
+	|line 1
+	|        line 2
+	|line 3
+	EOF
+	git add file &&
+	git commit -m "add file" &&
+	git tag main
+'
+
+test_expect_success '--ignore-whitespace works with apply backend' '
+	cat >expect <<-\EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	test_must_fail git rebase --apply main side &&
+	git rebase --abort &&
+	git rebase --apply --ignore-whitespace main side &&
+	test_cmp expect file
+'
+
+test_expect_success '--ignore-whitespace works with merge backend' '
+	cat >expect <<-\EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	test_must_fail git rebase --merge main side &&
+	git rebase --abort &&
+	git rebase --merge --ignore-whitespace main side &&
+	test_cmp expect file
+'
+
+test_expect_success '--ignore-whitespace is remembered when continuing' '
+	cat >expect <<-\EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_LINES="break 1" git rebase -i --ignore-whitespace main side
+	) &&
+	git rebase --continue &&
+	test_cmp expect file
+'
+
+# This must be the last test in this file
+test_expect_success '$EDITOR and friends are unchanged' '
+	test_editor_unchanged
+'
+
+test_done
-- 
2.26.2

