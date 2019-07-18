Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1571D1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 18:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfGRS62 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 14:58:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40228 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfGRS62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 14:58:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so14308198pla.7
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=guaafy32XvnL1S2/s+ft0Da25cmSkm/DyrtCotKMUSE=;
        b=r6kCjXqM3tu0fg37bbEDFJhsA4pbtgbZCmWALyppUQzymB4upqJNa+Qq2BqoQeen9K
         htsr3dYu6ASEumeoSQj17tWFN5HiLrwlQjmZ7dp9Z9pfjokmvXj3VL5IED8v9gw+PcNM
         7y3CnlzGmNXTUvuJE4mxBczHvGYr9wyHvg9lBlB6aXjsM+rV9EL+QoFrcmuMcsLFQbYz
         NCiIT1FPeMzj29b40Qge//HEKU2VFlRInE4hPW3t5HzQJAxRiAgo3RVC3PytUM0bhmZg
         qeUaJ4dpPSs7ivd0txfU7z1bV6hTUzh9HS1EGUgSDRD7x7ytlgD5TFjc2daGk9P4diON
         88gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=guaafy32XvnL1S2/s+ft0Da25cmSkm/DyrtCotKMUSE=;
        b=d71bhR47+R55VCWexvbKNKV+SzvsWARuibFkzvChY8rztrXMgCWvWpg2RqUlX4u++Y
         Q3P/4JsZL62ZND4Z7k0B25gAHjaPkpXdGtSilqI3Ne3/NiGejy08FZEsn5L0YeM5ORNS
         G4pAYn1wtU+22reUoQmNN+S6drnEYoXLHreLbBZYVRz0IWcqUDduIunEV+QCxxYCH+W6
         hSclKvQofZSTAo5mPDHmTMB2KcQdq9uKa21S+xfv8TTjU1NMOdLT40xuWiMraYjFGAD8
         uI3JcBLAj+2paLv2zAoeY2HMXhIhJZU+4QanQaCVlpgKVpgOuY9ykyK5WtDdtNVdpPtL
         6XBg==
X-Gm-Message-State: APjAAAUBZ7wcMWbxIsdPbugkaSa9l/6RpbUrGsZrU2k+BT20S9fDFN3R
        iXkuzEwgLwV/TwujmwkPNgE=
X-Google-Smtp-Source: APXvYqxGd32x7/y8gHjupZ5xsR9g6EuM3z+WZ6eI/1IFhon6UYU321ZuCdIHEXllhxVx8wAHqxuYHQ==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr50543720plp.71.1563476306882;
        Thu, 18 Jul 2019 11:58:26 -0700 (PDT)
Received: from ar135.iitr.local ([27.63.78.254])
        by smtp.gmail.com with ESMTPSA id f3sm45861671pfg.165.2019.07.18.11.58.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 11:58:26 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Rohit <rohit.ashiwal265@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio <gitster@pobox.com>, Martin <martin.agren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>
Subject: [GSoC][PATCH v2 1/1] rebase -i: add --ignore-whitespace flag
Date:   Fri, 19 Jul 2019 00:25:14 +0530
Message-Id: <20190718185514.20108-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718185514.20108-1-rohit.ashiwal265@gmail.com>
References: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
 <20190718185514.20108-1-rohit.ashiwal265@gmail.com>
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
 builtin/rebase.c                        | 26 ++++++++--
 sequencer.h                             |  1 +
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3431-rebase-options-compatibility.sh | 66 +++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 6 deletions(-)
 create mode 100755 t/t3431-rebase-options-compatibility.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5e4e927647..eda52ed824 100644
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
index db6ca9bd7d..afe376c3fe 100644
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
@@ -511,6 +525,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, NULL, options,
 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
 
+	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
+
 	if (!is_null_oid(&squash_onto))
 		opts.squash_onto = &squash_onto;
 
@@ -954,6 +970,8 @@ static int run_am(struct rebase_options *opts)
 	am.git_cmd = 1;
 	argv_array_push(&am.args, "am");
 
+	if (opts->ignore_whitespace)
+		argv_array_push(&am.args, "--ignore-whitespace");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1401,9 +1419,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
-		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
-				  NULL, N_("passed to 'git am'"),
-				  PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
 				  &options.git_am_opts, NULL,
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
@@ -1411,6 +1426,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
+		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
+			 N_("ignore changes in whitespace")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
 				  N_("action"), N_("passed to 'git apply'"), 0),
 		OPT_BIT('f', "force-rebase", &options.flags,
@@ -1821,6 +1838,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (options.rebase_merges) {
+		if (options.ignore_whitespace)
+			die(_("cannot combine '--rebase-merges' with "
+			      "'--ignore-whitespace'"));
 		if (strategy_options.nr)
 			die(_("cannot combine '--rebase-merges' with "
 			      "'--strategy-option'"));
diff --git a/sequencer.h b/sequencer.h
index 0c494b83d4..303047a133 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -43,6 +43,7 @@ struct replay_opts {
 	int verbose;
 	int quiet;
 	int reschedule_failed_exec;
+	int ignore_whitespace;
 
 	int mainline;
 
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
 
diff --git a/t/t3431-rebase-options-compatibility.sh b/t/t3431-rebase-options-compatibility.sh
new file mode 100755
index 0000000000..f38ae6f5fc
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

