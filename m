Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B217F1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 17:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbfHFRj4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 13:39:56 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:41088 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbfHFRjy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 13:39:54 -0400
Received: by mail-pf1-f182.google.com with SMTP id m30so41898640pff.8
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kr0MdD6Zs3+jJJUAu2M4/+X1WrNjUKQ/YhX4r5l1nzo=;
        b=al+h6zLsftZIDYC4EmbCLWq21XM7rzK4kO6rsRYZ1kb9G2PI9JmrMcSSN8ZdQ4Iz2n
         iGS9lC1+QXx2kftnYYTrDO61cGp565ZvgHOJhKiDQop7300lipfHrb5US4xmJPSKADw5
         robni4T35I5PQBrNynXk1NTA69wo39saBezYV3AH7B0oN7ZmFb+klJX8TYDYTgHPK8e0
         6YLRu8RkHpw2M8KzlZw+D+thDuHfDfooZn6/XyUjEn90HBxI6//KzulD2y2cVKrRsCha
         dNBpjnXPzBGSArSuIwyRLmp4eNAelXDBEqiA5aexJBtnrJ7ieaXRfdWscDVzcbNPhmqZ
         IZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kr0MdD6Zs3+jJJUAu2M4/+X1WrNjUKQ/YhX4r5l1nzo=;
        b=Dm/AoCLoEGomyLGZJZ31S3nTJVgryB41lU02pRw+gytKpuokP+xNb/9njZw1sD7aDF
         LHg121zpGS7+HlsOyk7csILmeGYXqfhbMCJJPuNFoSwYPp0vfA5GjzbMltKaqMBa+7eM
         qZ6N0yAgyCI0HtvQPBrXD3OTK2j5mEJANLUs6TFIShZVFj0mVWiKmDI6IkF8ea+eGr5Y
         3jrfmOjC97YgP4Vs4iDSWucQcosARyk4vtKLgqtzeFf9UlJzdoYQ2BWobdvs8tkedlda
         2cmV+OHrzb72FH4JGKbvcZvJZvuY7J7cTxsnDAl0gN33V7TTZ33oogVA/uGTrWnxue/w
         3byw==
X-Gm-Message-State: APjAAAUJLwuAE8bkXxKVZbO3Eiz7jxNL3VeEKEIOojYMsSZbgwqYcoeU
        wh+8pw4LUxjOSYPafTJ8zmM=
X-Google-Smtp-Source: APXvYqzFvA/5U2HbBzh8asqcXmSpzAKROGqDUvCti+n3tdRvx7BtI22FAUKG+/55EHXbw5+rzx5IOA==
X-Received: by 2002:a17:90a:601:: with SMTP id j1mr4291301pjj.96.1565113192873;
        Tue, 06 Aug 2019 10:39:52 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.217])
        by smtp.gmail.com with ESMTPSA id z20sm139757104pfk.72.2019.08.06.10.39.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:39:52 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>
Cc:     Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCHl 1/6] rebase -i: add --ignore-whitespace flag
Date:   Tue,  6 Aug 2019 23:06:33 +0530
Message-Id: <20190806173638.17510-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two backends available for rebasing, viz, the am and the
interactive. Naturally, there shall be some features that are
implemented in one but not in the other. One such flag is
--ignore-whitespace which indicates merge mechanism to treat lines
with only whitespace changes as unchanged. Wire the interactive
rebase to also understand the --ignore-whitespace flag by
translating it to -Xignore-space-change.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt            | 10 +++-
 builtin/rebase.c                        | 26 ++++++++--
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3433-rebase-options-compatibility.sh | 65 +++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 7 deletions(-)
 create mode 100755 t/t3433-rebase-options-compatibility.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5e4e927647..85404fea52 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -371,8 +371,13 @@ If either <upstream> or --root is given on the command line, then the
 default is `--no-fork-point`, otherwise the default is `--fork-point`.
 
 --ignore-whitespace::
+	This flag is either passed to the 'git apply' program
+	(see linkgit:git-apply[1]), or to 'git merge' program
+	(see linkgit:git-merge[1]) as `-Xignore-space-change`,
+	depending on which backend is selected by other options.
+
 --whitespace=<option>::
-	These flag are passed to the 'git apply' program
+	This flag is passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
 +
 See also INCOMPATIBLE OPTIONS below.
@@ -520,7 +525,6 @@ The following options:
  * --committer-date-is-author-date
  * --ignore-date
  * --whitespace
- * --ignore-whitespace
  * -C
 
 are incompatible with the following options:
@@ -543,6 +547,8 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --interactive
  * --preserve-merges and --signoff
  * --preserve-merges and --rebase-merges
+ * --preserve-merges and --ignore-whitespace
+ * --rebase-merges and --ignore-whitespace
  * --rebase-merges and --strategy
  * --rebase-merges and --strategy-option
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index db6ca9bd7d..3c195ddc73 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -79,6 +79,7 @@ struct rebase_options {
 	int allow_rerere_autoupdate;
 	int keep_empty;
 	int autosquash;
+	int ignore_whitespace;
 	char *gpg_sign_opt;
 	int autostash;
 	char *cmd;
@@ -97,7 +98,7 @@ struct rebase_options {
 		.git_format_patch_opt = STRBUF_INIT	\
 	}
 
-static struct replay_opts get_replay_opts(const struct rebase_options *opts)
+static struct replay_opts get_replay_opts(struct rebase_options *opts)
 {
 	struct replay_opts replay = REPLAY_OPTS_INIT;
 
@@ -114,6 +115,17 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
+
+	if (opts->ignore_whitespace) {
+		struct strbuf buf = STRBUF_INIT;
+
+		if (opts->strategy_opts)
+			strbuf_addstr(&buf, opts->strategy_opts);
+
+		strbuf_addstr(&buf, " --ignore-space-change");
+		free(opts->strategy_opts);
+		opts->strategy_opts = strbuf_detach(&buf, NULL);
+	}
 	if (opts->strategy_opts)
 		parse_strategy_opts(&replay, opts->strategy_opts);
 
@@ -511,6 +523,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, NULL, options,
 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
 
+	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
+
 	if (!is_null_oid(&squash_onto))
 		opts.squash_onto = &squash_onto;
 
@@ -954,6 +968,8 @@ static int run_am(struct rebase_options *opts)
 	am.git_cmd = 1;
 	argv_array_push(&am.args, "am");
 
+	if (opts->ignore_whitespace)
+		argv_array_push(&am.args, "--ignore-whitespace");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1401,9 +1417,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
-		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
-				  NULL, N_("passed to 'git am'"),
-				  PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
 				  &options.git_am_opts, NULL,
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
@@ -1411,6 +1424,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
+		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
+			 N_("ignore changes in whitespace")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
 				  N_("action"), N_("passed to 'git apply'"), 0),
 		OPT_BIT('f', "force-rebase", &options.flags,
@@ -1821,6 +1836,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (options.rebase_merges) {
+		if (options.ignore_whitespace)
+			die(_("cannot combine '--rebase-merges' with "
+			      "'--ignore-whitespace'"));
 		if (strategy_options.nr)
 			die(_("cannot combine '--rebase-merges' with "
 			      "'--strategy-option'"));
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index a5868ea152..4342f79eea 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -61,7 +61,6 @@ test_rebase_am_only () {
 }
 
 test_rebase_am_only --whitespace=fix
-test_rebase_am_only --ignore-whitespace
 test_rebase_am_only --committer-date-is-author-date
 test_rebase_am_only -C4
 
diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
new file mode 100755
index 0000000000..e617d3150e
--- /dev/null
+++ b/t/t3433-rebase-options-compatibility.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Rohit Ashiwal
+#
+
+test_description='tests to ensure compatibility between am and interactive backends'
+
+. ./test-lib.sh
+
+# This is a special case in which both am and interactive backends
+# provide the same output. It was done intentionally because
+# both the backends fall short of optimal behaviour.
+test_expect_success 'setup' '
+	git checkout -b topic &&
+	q_to_tab >file <<-EOF &&
+	line 1
+	Qline 2
+	line 3
+	EOF
+	git add file &&
+	git commit -m "add file" &&
+	cat >file <<-EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	git commit -am "update file" &&
+	git tag side &&
+
+	git checkout --orphan master &&
+	cat >file <<-EOF &&
+	line 1
+	        line 2
+	line 3
+	EOF
+	git add file &&
+	git commit -m "add file" &&
+	git tag main
+'
+
+test_expect_success '--ignore-whitespace works with am backend' '
+	cat >expect <<-EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	test_must_fail git rebase main side &&
+	git rebase --abort &&
+	git rebase --ignore-whitespace main side &&
+	test_cmp expect file
+'
+
+test_expect_success '--ignore-whitespace works with interactive backend' '
+	cat >expect <<-EOF &&
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
+test_done
-- 
2.21.0

