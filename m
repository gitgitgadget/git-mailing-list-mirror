Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D97A820A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 19:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbeLJTFC (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 14:05:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36682 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJTFB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 14:05:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so5397838pgm.3
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 11:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KPr02WbjOBFPZFBhssdDLaKqyadrr9eB2fpV/MObaB0=;
        b=GPgXlT3O6EI3zHeCgzWQ8ky5VlXmvOuw4L12iAvk1fYCCIzhKr0wvwnd4qC2Hyns8g
         LsspiJfT4JgVp001FAAVTBbpIexS5Kp/5oYgqt8J/Ru6ZPjepESEWpRSlTKLh3hJSODZ
         grtCWlndj2MUHg2h0/rG2V2RNQcDlqrKFlGlK6v0si4vySCV9nscfCp1hPoE2ebJvbxB
         z7Vgluj4ObqwZMCVfHaoMRpHxWLW0+EFjwcBGyE8FZGv3GCnigVZodi9v3t2GaElMh3h
         9kzVouTqHtEpAz/XjVzjGBMunAKk4+O+uejQ17OBiWqUiJ4B5FnTToDchAPeMFoAkvu/
         55+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KPr02WbjOBFPZFBhssdDLaKqyadrr9eB2fpV/MObaB0=;
        b=jEchTg692E5u7X8S4VafxmPtNE/g/NiKSKJXhye2OjLSguWg55qhocak6OrSwbeSGU
         bonrhjjU+F4sXvIdD3wz4aEK1CrOID5Mztlk5EAVnSgfUgLnv68RNgU4XZ0EBpq0VUeu
         GCiUx4xXLvUOVeoDoFLjrs8JyCiRr99yDBgBmbCwwyGhd0fZtfgiF9n/EK8CZqJ8yGuF
         cy9H7ORbILMYpHIkM/wxuSf6HSbOr3Iikjug9tL9ZfntMEEBqsJd2UQ6zbOxYKdTup+B
         8W9HtwtiYYWr0g6M3O4NODWoIAemQOQmOwFRhaU+Zi7uqhwQgorEdxrf51lAurQJGs2Z
         O14w==
X-Gm-Message-State: AA+aEWaXu8BjVNT2eg9wySVEBVjaDCI+a+BlSS7vWQ0OK8pPqCt8VZ8L
        oBJKujncmlwFWKzWCX6izg4/0eUi
X-Google-Smtp-Source: AFSGD/UAMUHwlCTTGBPmR/NXrlRVpK0vhHUezvLEgt3KTipoQ9NboVPNVqDMAifweJsdU/VBs2qrgA==
X-Received: by 2002:a65:520a:: with SMTP id o10mr12224583pgp.276.1544468699254;
        Mon, 10 Dec 2018 11:04:59 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id a18sm16285899pgj.30.2018.12.10.11.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 11:04:58 -0800 (PST)
Date:   Mon, 10 Dec 2018 11:04:58 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 19:04:53 GMT
Message-Id: <05d8792d12e692eeefa0021e8686b7211a055593.1544468695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.90.git.gitgitgadget@gmail.com>
References: <pull.90.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] rebase: introduce --reschedule-failed-exec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A common use case for the `--exec` option is to verify that each commit
in a topic branch compiles cleanly, via `git rebase -x make <base>`.

However, when an `exec` in such a rebase fails, it is not re-scheduled,
which in this instance is not particularly helpful.

Let's offer a flag to reschedule failed `exec` commands.

Based on an idea by Paul Morelle.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt  |  5 +++++
 builtin/rebase--interactive.c |  2 ++
 builtin/rebase.c              | 16 +++++++++++++++-
 git-legacy-rebase.sh          | 16 +++++++++++++++-
 git-rebase--common.sh         |  1 +
 sequencer.c                   | 13 ++++++++++---
 sequencer.h                   |  1 +
 t/t3418-rebase-continue.sh    |  6 ++++++
 8 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 80793bad8d..9dd68f77f6 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -501,6 +501,11 @@ See also INCOMPATIBLE OPTIONS below.
 	with care: the final stash application after a successful
 	rebase might result in non-trivial conflicts.
 
+--reschedule-failed-exec::
+--no-reschedule-failed-exec::
+	Automatically reschedule `exec` commands that failed. This only makes
+	sense in interactive mode (or when an `--exec` option was provided).
+
 INCOMPATIBLE OPTIONS
 --------------------
 
diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index a2ab68ed06..a9ab009fdb 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -192,6 +192,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto-name", &onto_name, N_("onto-name"), N_("onto name")),
 		OPT_STRING(0, "cmd", &cmd, N_("cmd"), N_("the command to run")),
 		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_auto),
+		OPT_BOOL(0, "reschedule-failed-exec", &opts.reschedule_failed_exec,
+			 N_("automatically re-schedule any `exec` that fails")),
 		OPT_END()
 	};
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b3e5baec8..6d556fc6c8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -104,6 +104,7 @@ struct rebase_options {
 	int rebase_merges, rebase_cousins;
 	char *strategy, *strategy_opts;
 	struct strbuf git_format_patch_opt;
+	int reschedule_failed_exec;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -415,6 +416,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 			argv_array_push(&child.args, opts->gpg_sign_opt);
 		if (opts->signoff)
 			argv_array_push(&child.args, "--signoff");
+		if (opts->reschedule_failed_exec)
+			argv_array_push(&child.args, "--reschedule-failed-exec");
 
 		status = run_command(&child);
 		goto finished_rebase;
@@ -903,6 +906,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				   "strategy")),
 		OPT_BOOL(0, "root", &options.root,
 			 N_("rebase all reachable commits up to the root(s)")),
+		OPT_BOOL(0, "reschedule-failed-exec",
+			 &options.reschedule_failed_exec,
+			 N_("automatically re-schedule any `exec` that fails")),
 		OPT_END(),
 	};
 	int i;
@@ -1195,6 +1201,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
+	if (options.reschedule_failed_exec && !is_interactive(&options))
+		die(_("--reschedule-failed-exec requires an interactive rebase"));
+
 	if (options.git_am_opts.argc) {
 		/* all am options except -q are compatible only with --am */
 		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
@@ -1220,7 +1229,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.flags |= REBASE_FORCE;
 	}
 
-	if (options.type == REBASE_PRESERVE_MERGES)
+	if (options.type == REBASE_PRESERVE_MERGES) {
 		/*
 		 * Note: incompatibility with --signoff handled in signoff block above
 		 * Note: incompatibility with --interactive is just a strong warning;
@@ -1230,6 +1239,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("error: cannot combine '--preserve-merges' with "
 			      "'--rebase-merges'"));
 
+		if (options.reschedule_failed_exec)
+			die(_("error: cannot combine '--preserve-merges' with "
+			      "'--reschedule-failed-exec'"));
+	}
+
 	if (options.rebase_merges) {
 		if (strategy_options.nr)
 			die(_("error: cannot combine '--rebase-merges' with "
diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index b97ffdc9dd..5f0f0c5ab8 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -48,6 +48,7 @@ skip!              skip current patch and continue
 edit-todo!         edit the todo list during an interactive rebase
 quit!              abort but keep HEAD where it is
 show-current-patch! show the patch file being applied or merged
+reschedule-failed-exec automatically reschedule failed exec commands
 "
 . git-sh-setup
 set_reflog_action rebase
@@ -92,6 +93,7 @@ autosquash=
 keep_empty=
 allow_empty_message=--allow-empty-message
 signoff=
+reschedule_failed_exec=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
 case "$(git config --bool commit.gpgsign)" in
 true)	gpg_sign_opt=-S ;;
@@ -126,6 +128,8 @@ read_basic_state () {
 		signoff="$(cat "$state_dir"/signoff)"
 		force_rebase=t
 	}
+	test -f "$state_dir"/reschedule-failed-exec &&
+		reschedule_failed_exec=t
 }
 
 finish_rebase () {
@@ -163,7 +167,8 @@ run_interactive () {
 		"$allow_empty_message" "$autosquash" "$verbose" \
 		"$force_rebase" "$onto_name" "$head_name" "$strategy" \
 		"$strategy_opts" "$cmd" "$switch_to" \
-		"$allow_rerere_autoupdate" "$gpg_sign_opt" "$signoff"
+		"$allow_rerere_autoupdate" "$gpg_sign_opt" "$signoff" \
+		"$reschedule_failed_exec"
 }
 
 run_specific_rebase () {
@@ -378,6 +383,12 @@ do
 	--gpg-sign=*)
 		gpg_sign_opt="-S${1#--gpg-sign=}"
 		;;
+	--reschedule-failed-exec)
+		reschedule_failed_exec=--reschedule-failed-exec
+		;;
+	--no-reschedule-failed-exec)
+		reschedule_failed_exec=
+		;;
 	--)
 		shift
 		break
@@ -534,6 +545,9 @@ then
 	#       git-rebase.txt caveats with "unless you know what you are doing"
 	test -n "$rebase_merges" &&
 		die "$(gettext "error: cannot combine '--preserve-merges' with '--rebase-merges'")"
+
+	test -n "$reschedule_failed_exec" &&
+		die "$(gettext "error: cannot combine '--preserve-merges' with '--reschedule-failed-exec'")"
 fi
 
 if test -n "$rebase_merges"
diff --git a/git-rebase--common.sh b/git-rebase--common.sh
index 7e39d22871..a8a44608e0 100644
--- a/git-rebase--common.sh
+++ b/git-rebase--common.sh
@@ -19,6 +19,7 @@ write_basic_state () {
 		"$state_dir"/allow_rerere_autoupdate
 	test -n "$gpg_sign_opt" && echo "$gpg_sign_opt" > "$state_dir"/gpg_sign_opt
 	test -n "$signoff" && echo "$signoff" >"$state_dir"/signoff
+	test -n "$reschedule_failed_exec" && : > "$state_dir"/reschedule-failed-exec
 }
 
 apply_autostash () {
diff --git a/sequencer.c b/sequencer.c
index e1a4dd15f1..69bee63e11 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -158,6 +158,7 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
 static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
 static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
+static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
 
 static int git_sequencer_config(const char *k, const char *v, void *cb)
 {
@@ -2362,6 +2363,9 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->signoff = 1;
 		}
 
+		if (file_exists(rebase_path_reschedule_failed_exec()))
+			opts->reschedule_failed_exec = 1;
+
 		read_strategy_opts(opts, &buf);
 		strbuf_release(&buf);
 
@@ -2443,6 +2447,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
 	if (opts->signoff)
 		write_file(rebase_path_signoff(), "--signoff\n");
+	if (opts->reschedule_failed_exec)
+		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
 	return 0;
 }
@@ -3586,9 +3592,10 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			*end_of_arg = saved;
 
 			/* Reread the todo file if it has changed. */
-			if (res)
-				; /* fall through */
-			else if (stat(get_todo_path(opts), &st))
+			if (res) {
+				if (opts->reschedule_failed_exec)
+					reschedule = 1;
+			} else if (stat(get_todo_path(opts), &st))
 				res = error_errno(_("could not stat '%s'"),
 						  get_todo_path(opts));
 			else if (match_stat_data(&todo_list->stat, &st)) {
diff --git a/sequencer.h b/sequencer.h
index 5071a73563..1f865dae26 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -39,6 +39,7 @@ struct replay_opts {
 	int allow_empty_message;
 	int keep_redundant_commits;
 	int verbose;
+	int reschedule_failed_exec;
 
 	int mainline;
 
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 0210b2ac6f..54b26a9284 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -254,4 +254,10 @@ test_expect_success 'the todo command "break" works' '
 	test_path_is_file execed
 '
 
+test_expect_success '--reschedule-failed-exec' '
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -x false --reschedule-failed-exec HEAD^ &&
+	grep "^exec false" .git/rebase-merge/git-rebase-todo
+'
+
 test_done
-- 
gitgitgadget

