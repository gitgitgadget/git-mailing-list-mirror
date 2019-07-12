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
	by dcvr.yhbt.net (Postfix) with ESMTP id A384F1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 18:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfGLSxD (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 14:53:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40963 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfGLSxD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 14:53:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id q4so4916230pgj.8
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgZoNjXT2jLiYsDLKbJ8uK6VzGSVPA2Dc4G8M7zu75M=;
        b=dkHie4N7VaIogjnn4rI1E8Ckezmxz9kKIknqogl+7i+i4CKEdlOBzpNUj5fhF/CXNb
         LROI4niHUW6KUCo+iV0VEFo0w3YqPZuXC7L4opSI3dTKSF8ZrYxVkseVQG3RCXG8OJc/
         8FF6fMm9DVx5XhxiOOn73sbPiPB5KzMsIHb465ulwZb+YFEHp2weJD3Ezum2HwdeImQc
         o6/GxS01qcyoWFM5OyIufSEA+zQvNE5ELIJpb5VZf5l0qMuJZtSId5i+7PgGPh4sMs5q
         XXeeBjSrI5LAfYzBF/j+gkR6Tm58KuE4Plgy5ZsZNJpzlogh45vgGb7X1a3IwZSwKXVi
         kWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgZoNjXT2jLiYsDLKbJ8uK6VzGSVPA2Dc4G8M7zu75M=;
        b=Ec9o6+FtZGfz3bwtbAtn/ZuvOZls6lmzwOhVOsfucB1RnYAfjIt2yHNZ5GwYdOPVtp
         TCdg+yWbRriN0RVQVn+zau7oBbujGVxu9JJva+DZkiDl+iRkm0w7GJdXEStgZj8D4kFX
         0p0wSYb6Z4VAe0sm8OlthArWaLNLeB1b9MBbSQjIaYmCTyH7wyttInsKCCpXgONN09HN
         6ZbNLLm9bymvpgPSNSyiPO+FcRgp3h02pXStDmvS1OX3k9q2IYBAEVYJAiQToD4siLUG
         8DZ3bMIRPOuApQr4/2I7dG5mz6BHlR3Eo3WlXCj15h99JdwCgBwb68a2Wqc93OP75N79
         Gq1Q==
X-Gm-Message-State: APjAAAUSbZY9HNG9yyyc/sC/nNb1/fs/bInMfR7ktxCIeD/t0IHL1wh3
        GpxE0iddnntyN8hEzjjlrytraxxKXw0=
X-Google-Smtp-Source: APXvYqyKxPzQwwOXhvRWuxHQIobU77GBT+bVq5rh7vM+a9vaHdhPmOR9DJrpAbHL+QuyH/TjY+eL1g==
X-Received: by 2002:a63:194f:: with SMTP id 15mr12923423pgz.382.1562957581803;
        Fri, 12 Jul 2019 11:53:01 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.218])
        by smtp.gmail.com with ESMTPSA id v4sm8475244pgf.20.2019.07.12.11.52.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 11:53:01 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     phillip.wood123@gmail.com, martin.agren@gmail.com,
        Johannes.Schindelin@gmx.de,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: [GSoC][PATCH 1/1] rebase -i: add --ignore-whitespace flag
Date:   Sat, 13 Jul 2019 00:20:15 +0530
Message-Id: <20190712185015.20585-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
References: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
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
 Documentation/git-rebase.txt            |  9 +++-
 builtin/rebase.c                        | 24 +++++++--
 sequencer.h                             |  1 +
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3431-rebase-options-compatibility.sh | 66 +++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 6 deletions(-)
 create mode 100755 t/t3431-rebase-options-compatibility.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5e4e92764..eda52ed82 100644
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
@@ -543,6 +547,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --interactive
  * --preserve-merges and --signoff
  * --preserve-merges and --rebase-merges
+ * --rebase-merges and --ignore-whitespace
  * --rebase-merges and --strategy
  * --rebase-merges and --strategy-option
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index db6ca9bd7..c55957c31 100644
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
@@ -376,6 +377,17 @@ static int run_rebase_interactive(struct rebase_options *opts,
 	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
 	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
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
+
 	switch (command) {
 	case ACTION_NONE: {
 		if (!opts->onto && !opts->upstream)
@@ -489,6 +501,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign_opt, N_("key-id"),
 			N_("GPG-sign commits"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_BOOL(0, "ignore-whitespace", &opts.ignore_whitespace,
+			 N_("ignore changes in whitespace")),
 		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
 			   N_("rebase strategy")),
 		OPT_STRING(0, "strategy-opts", &opts.strategy_opts, N_("strategy-opts"),
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
diff --git a/sequencer.h b/sequencer.h
index 0c494b83d..303047a13 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -43,6 +43,7 @@ struct replay_opts {
 	int verbose;
 	int quiet;
 	int reschedule_failed_exec;
+	int ignore_whitespace;
 
 	int mainline;
 
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index a5868ea15..4342f79ee 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -61,7 +61,6 @@ test_rebase_am_only () {
 }
 
 test_rebase_am_only --whitespace=fix
-test_rebase_am_only --ignore-whitespace
 test_rebase_am_only --committer-date-is-author-date
 test_rebase_am_only -C4
 
diff --git a/t/t3431-rebase-options-compatibility.sh b/t/t3431-rebase-options-compatibility.sh
new file mode 100755
index 000000000..f38ae6f5f
--- /dev/null
+++ b/t/t3431-rebase-options-compatibility.sh
@@ -0,0 +1,66 @@
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
+# provide the same outputs. It was done intentionally because
+# --ignore-whitespace both the backends fall short of optimal
+# behaviour.
+test_expect_success 'setup' '
+	git checkout -b topic &&
+	q_to_tab >file <<-EOF &&
+	line 1
+	Qline 2
+	line 3
+	EOF
+	git add file &&
+	git commit -m "add file" &&
+	q_to_tab >file <<-EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	git commit -am "update file" &&
+	git tag side &&
+
+	git checkout --orphan master &&
+	q_to_tab >file <<-EOF &&
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

