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
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D311F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 19:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfHLTqP (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 15:46:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43783 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLTqO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 15:46:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id r26so14058860pgl.10
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zEZoiYNssHr8JsFHWLRmMGFlZ0z9OpkYg9WntMWCXRs=;
        b=IdFswqEzH9ZLEwUaKlQPgg9VW+CarkEJBFpEsSDbdHkb+Ums5oS+e3E6WjmLk4DgAp
         i23l46HmHhY8CKIuMhOMKc2F6dHx7WqRwPLM7UwPTU1pTSGkbZVK9+Qy5b79zs1OwXGG
         fkPZ+iiAXH524KsjCJkYWHhPYR0DvYh5PDMb8jkAaSLaM41F0Y2uZ+lkxO8oND9i2mF9
         X0cOMk1L88cGIt73zyM5tu9EADZyKEhFG3xLYuKz/5E5rfrVUANgaIoK7JQB5OHUMYEi
         6o0D5x4JvunGWOOWPm7wVVdBNbOiyZqhpE2Ki4Um9AYPIMZ6awa4pjLRJ53fImj+okcL
         CQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zEZoiYNssHr8JsFHWLRmMGFlZ0z9OpkYg9WntMWCXRs=;
        b=mrz6g7sZzTM9910IzFUMIO4M731gUgDofPRIGtdocy9P+BoX6by1Vfr7yD4hsDgxMz
         MDRSCjX3dbj/EeKinsV3zvZ6JAtL7GdiRlfoPnskBIHQaXZ2UJNEYcngGvVmrkdEFZTU
         5Bd4Vp+Ebn2Wo/u4qO8DRH3RPsIdPT/mykNZ/6z3q7TTdi5bytccMSTj7095OqAr5owx
         nIOA01wcsb48MP4KVRZ97EYk0RBJmaUrI/YWDpgHJDxAzjmBX+2xKXXY0+z4uLzjmiqz
         RD1xd3WDzly6hf44gHG1pTlkiG/TI/vilqycKq75ZKJ37zoCSxUwSK6o4b5sr00sRNlT
         gW4Q==
X-Gm-Message-State: APjAAAWSDLn+phX0d0v+OlD7x5/jeGoiCY+cZNnTsFCU+Qq7gSrXtgOS
        A6Sr/lFQVtcEZtyqQEix3x05B5kRj98=
X-Google-Smtp-Source: APXvYqyAh2n/ypsjANR9v2xY72Fp5XAbpTUtgrmb7NV+MQWgyjDPJ8brYa5GKtLj9Nnb4T+NHY9rDg==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr31357092pgd.241.1565639173563;
        Mon, 12 Aug 2019 12:46:13 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.228])
        by smtp.gmail.com with ESMTPSA id j187sm13275947pfg.178.2019.08.12.12.46.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:46:12 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v2 1/6] rebase -i: add --ignore-whitespace flag
Date:   Tue, 13 Aug 2019 01:12:55 +0530
Message-Id: <20190812194301.5655-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
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
 builtin/rebase.c                        | 29 +++++++++--
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3433-rebase-options-compatibility.sh | 65 +++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 8 deletions(-)
 create mode 100755 t/t3433-rebase-options-compatibility.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6156609cf7..28e5e08a83 100644
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
index 670096c065..ab1bbb78ee 100644
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
@@ -99,6 +100,7 @@ struct rebase_options {
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 {
+	char *strategy_opts = opts->strategy_opts;
 	struct replay_opts replay = REPLAY_OPTS_INIT;
 
 	replay.action = REPLAY_INTERACTIVE_REBASE;
@@ -114,8 +116,19 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
-	if (opts->strategy_opts)
-		parse_strategy_opts(&replay, opts->strategy_opts);
+
+	if (opts->ignore_whitespace) {
+		struct strbuf buf = STRBUF_INIT;
+
+		if (strategy_opts)
+			strbuf_addstr(&buf, strategy_opts);
+
+		strbuf_addstr(&buf, " --ignore-space-change");
+		free(strategy_opts);
+		strategy_opts = strbuf_detach(&buf, NULL);
+	}
+	if (strategy_opts)
+		parse_strategy_opts(&replay, strategy_opts);
 
 	return replay;
 }
@@ -511,6 +524,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
 
+	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
+
 	if (!is_null_oid(&squash_onto))
 		opts.squash_onto = &squash_onto;
 
@@ -964,6 +979,8 @@ static int run_am(struct rebase_options *opts)
 	am.git_cmd = 1;
 	argv_array_push(&am.args, "am");
 
+	if (opts->ignore_whitespace)
+		argv_array_push(&am.args, "--ignore-whitespace");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1407,9 +1424,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
-		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
-				  NULL, N_("passed to 'git am'"),
-				  PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
 				  &options.git_am_opts, NULL,
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
@@ -1417,6 +1431,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
+		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
+			 N_("ignore changes in whitespace")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
 				  N_("action"), N_("passed to 'git apply'"), 0),
 		OPT_BIT('f', "force-rebase", &options.flags,
@@ -1834,6 +1850,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
index 0000000000..2e16e00a9d
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
+test_expect_success '--ignore-whitespace works with am backend' '
+	cat >expect <<-\EOF &&
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
+test_done
-- 
2.21.0

