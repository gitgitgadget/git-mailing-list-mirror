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
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C1E1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 19:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbfGRTGP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 15:06:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37991 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRTGO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 15:06:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so13045784pfn.5
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F6zYrFGc5IuTEnVQcHMJqKrDYHpZwqlcMZBsGvVEwqE=;
        b=iwkqHkXhb0oJE197RgptlurGDEGPzpQaTbJ0Sv6JA6wJaxKixURAKEJaOayL8ITrm+
         6vDMl+awv0R7Ch3S4E9369SQHc0sFBe4CtInydpnse4E9fQn7ftloDXVP520NXJX2DVe
         ccQHrMgzORpWvav/7wb7sYeqF0xELI3+gvQB+FQqa0SLBti2ywsgMnywFuXAsNqyuUE0
         dPO709QzmgEvNUoQw7O0VU9Y5RtZS9HeeyqF3oYGa2FJEoxHpA6/vZ4wEOoBmWbiir/S
         R9LkULyMsacY+O19mKeROg3hAlytJ6vupMU07Ncc1/8kzId/Pgss70N65gkHS/9+PPtc
         EmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6zYrFGc5IuTEnVQcHMJqKrDYHpZwqlcMZBsGvVEwqE=;
        b=cdvmr976VTiwm7huHD9hCsRsLL4ni7Uel69OM4ivA+xuRZnFEKKi2mHMMgl/5Ld5Jw
         zTs0LHRAmiQkTjfSF707Q+H/a63rYbyk1WP19fnf1L0YtL9rbtny6jhZE31si4pwIUon
         TMXYoB5nWrpUxq9qkto66t6u1kzgL7tFdzE+lK7js9/WByCoJ7HYW6lFsJnaVa2fmbGk
         +HPMojqp0nI4BTAxgm7ePL92O5cQVj9Q4hlMjKc/lQqETjt2O+tL6avm5WWlSp1/0+cb
         KOpOHWtcAE1jRK99CNl/rPZFmldaTsFFdjZ1OQI1MJBzUMgb+0zJwZllYlweG+U6oATU
         ZBXw==
X-Gm-Message-State: APjAAAXyr2TH2fEuqQCHN1oLOi1CMLh5iXuJDfjBXFxUVvE2qhBQyHvf
        3dVAr64L/Sdn19LXd8rKjy4=
X-Google-Smtp-Source: APXvYqy6pgD3UtH2ITSHD3NtS5CerQIrphBCIdkmv9ddWbtVjQSjs8rZHZOKk8aboP2WMe6hQC0G6A==
X-Received: by 2002:a63:9245:: with SMTP id s5mr50158337pgn.123.1563476773716;
        Thu, 18 Jul 2019 12:06:13 -0700 (PDT)
Received: from ar135.iitr.local ([27.63.78.254])
        by smtp.gmail.com with ESMTPSA id f88sm28237555pjg.5.2019.07.18.12.06.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 12:06:13 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     Rohit <rohit.ashiwal265@gmail.com>
Cc:     Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio <gitster@pobox.com>, Martin <martin.agren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>
Subject: [GSoC][PATCH v2 2/2] rebase -i: support --committer-date-is-author-date
Date:   Fri, 19 Jul 2019 00:33:14 +0530
Message-Id: <20190718190314.20549-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718190314.20549-1-rohit.ashiwal265@gmail.com>
References: <20190712185357.21211-1-rohit.ashiwal265@gmail.com>
 <20190718190314.20549-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rebase am already has this flag to "lie" about the committer date
by changing it to the author date. Let's add the same for
interactive machinery.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt            |  7 ++--
 builtin/rebase.c                        | 23 ++++++++++---
 sequencer.c                             | 46 ++++++++++++++++++++++++-
 sequencer.h                             |  1 +
 t/t3422-rebase-incompatible-options.sh  |  1 -
 t/t3431-rebase-options-compatibility.sh | 21 +++++++++++
 6 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index eda52ed824..ddd111de69 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -383,8 +383,12 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 See also INCOMPATIBLE OPTIONS below.
 
 --committer-date-is-author-date::
+	Instead of recording the time the rebased commits are
+	created as the committer date, reuse the author date
+	as the committer date. This implies --force-rebase.
+
 --ignore-date::
-	These flags are passed to 'git am' to easily change the dates
+	This flag is passed to 'git am' to change the author date
 	of the rebased commits (see linkgit:git-am[1]).
 +
 See also INCOMPATIBLE OPTIONS below.
@@ -522,7 +526,6 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
- * --committer-date-is-author-date
  * --ignore-date
  * --whitespace
  * -C
diff --git a/builtin/rebase.c b/builtin/rebase.c
index afe376c3fe..c317fbe53c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -82,6 +82,7 @@ struct rebase_options {
 	int ignore_whitespace;
 	char *gpg_sign_opt;
 	int autostash;
+	int committer_date_is_author_date;
 	char *cmd;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
@@ -113,6 +114,8 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.allow_empty_message = opts->allow_empty_message;
 	replay.verbose = opts->flags & REBASE_VERBOSE;
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
+	replay.committer_date_is_author_date =
+					opts->committer_date_is_author_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
 	if (opts->strategy_opts)
@@ -467,6 +470,9 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "autosquash", &opts.autosquash,
 			 N_("move commits that begin with squash!/fixup!")),
 		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
+		OPT_BOOL(0, "committer-date-is-author-date",
+			 &opts.committer_date_is_author_date,
+			 N_("make committer date match author date")),
 		OPT_BIT('v', "verbose", &opts.flags,
 			N_("display a diffstat of what changed upstream"),
 			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
@@ -534,6 +540,9 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
+	if (opts.committer_date_is_author_date)
+		opts.flags |= REBASE_FORCE;
+
 	return !!run_rebase_interactive(&opts, command);
 }
 
@@ -972,6 +981,8 @@ static int run_am(struct rebase_options *opts)
 
 	if (opts->ignore_whitespace)
 		argv_array_push(&am.args, "--ignore-whitespace");
+	if (opts->committer_date_is_author_date)
+		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1419,9 +1430,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
-		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
-				  &options.git_am_opts, NULL,
-				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
+		OPT_BOOL(0, "committer-date-is-author-date",
+			 &options.committer_date_is_author_date,
+			 N_("make committer date match author date")),
 		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
@@ -1688,10 +1699,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		    state_dir_base, cmd_live_rebase, buf.buf);
 	}
 
+	if (options.committer_date_is_author_date)
+		options.flags |= REBASE_FORCE;
+
 	for (i = 0; i < options.git_am_opts.argc; i++) {
 		const char *option = options.git_am_opts.argv[i], *p;
-		if (!strcmp(option, "--committer-date-is-author-date") ||
-		    !strcmp(option, "--ignore-date") ||
+		if (!strcmp(option, "--ignore-date") ||
 		    !strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
 			options.flags |= REBASE_FORCE;
diff --git a/sequencer.c b/sequencer.c
index a2d7b0925e..a65f01a422 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -147,6 +147,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
  * command-line.
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
+static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
@@ -876,6 +877,18 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
+/* Returns a "date" string that needs to be free()'d by the caller */
+static char *read_author_date_or_die(void)
+{
+	char *date;
+
+	if (read_author_script(rebase_path_author_script(),
+			       NULL, NULL, &date, 0))
+		die(_("failed to read author date"));
+
+	return date;
+}
+
 /* Read author-script and return an ident line (author <email> timestamp) */
 static const char *read_author_ident(struct strbuf *buf)
 {
@@ -986,10 +999,17 @@ static int run_git_commit(struct repository *r,
 
 		if (res <= 0)
 			res = error_errno(_("could not read '%s'"), defmsg);
-		else
+		else {
+			if (opts->committer_date_is_author_date) {
+				char *date = read_author_date_or_die();
+				setenv("GIT_COMMITTER_DATE", date, 1);
+				free(date);
+			}
+
 			res = commit_tree(msg.buf, msg.len, cache_tree_oid,
 					  NULL, &root_commit, author,
 					  opts->gpg_sign);
+		}
 
 		strbuf_release(&msg);
 		strbuf_release(&script);
@@ -1019,6 +1039,11 @@ static int run_git_commit(struct repository *r,
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
+	if (opts->committer_date_is_author_date) {
+		char *date = read_author_date_or_die();
+		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s", date);
+		free(date);
+	}
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	else if (!(flags & EDIT_MSG))
@@ -1467,6 +1492,12 @@ static int try_to_commit(struct repository *r,
 
 	reset_ident_date();
 
+	if (opts->committer_date_is_author_date) {
+		char *date = read_author_date_or_die();
+		setenv("GIT_COMMITTER_DATE", date, 1);
+		free(date);
+	}
+
 	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
 				 oid, author, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
@@ -2538,6 +2569,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->signoff = 1;
 		}
 
+		if (file_exists(rebase_path_cdate_is_adate())) {
+			opts->allow_ff = 0;
+			opts->committer_date_is_author_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2620,6 +2656,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
 	if (opts->signoff)
 		write_file(rebase_path_signoff(), "--signoff\n");
+	if (opts->committer_date_is_author_date)
+		write_file(rebase_path_cdate_is_adate(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3437,6 +3475,12 @@ static int do_merge(struct repository *r,
 		argv_array_push(&cmd.args, git_path_merge_msg(r));
 		if (opts->gpg_sign)
 			argv_array_push(&cmd.args, opts->gpg_sign);
+		if (opts->committer_date_is_author_date) {
+			char *date = read_author_date_or_die();
+			argv_array_pushf(&cmd.env_array,
+					 "GIT_COMMITTER_DATE=%s", date);
+			free(date);
+		}
 
 		/* Add the tips to be merged */
 		for (j = to_merge; j; j = j->next)
diff --git a/sequencer.h b/sequencer.h
index 303047a133..0cfe184fc2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -44,6 +44,7 @@ struct replay_opts {
 	int quiet;
 	int reschedule_failed_exec;
 	int ignore_whitespace;
+	int committer_date_is_author_date;
 
 	int mainline;
 
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 4342f79eea..7402f7e3da 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -61,7 +61,6 @@ test_rebase_am_only () {
 }
 
 test_rebase_am_only --whitespace=fix
-test_rebase_am_only --committer-date-is-author-date
 test_rebase_am_only -C4
 
 test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
diff --git a/t/t3431-rebase-options-compatibility.sh b/t/t3431-rebase-options-compatibility.sh
index f38ae6f5fc..c3f7f6d5d0 100755
--- a/t/t3431-rebase-options-compatibility.sh
+++ b/t/t3431-rebase-options-compatibility.sh
@@ -7,6 +7,9 @@ test_description='tests to ensure compatibility between am and interactive backe
 
 . ./test-lib.sh
 
+GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
+export GIT_AUTHOR_DATE
+
 # This is a special case in which both am and interactive backends
 # provide the same outputs. It was done intentionally because
 # --ignore-whitespace both the backends fall short of optimal
@@ -63,4 +66,22 @@ test_expect_success '--ignore-whitespace works with interactive backend' '
 	test_cmp expect file
 '
 
+test_expect_success '--committer-date-is-author-date works with am backend' '
+	git rebase -f HEAD^ &&
+	git rebase --committer-date-is-author-date HEAD^ &&
+	git cat-file commit HEAD | sed -e "/^\$/q" >head &&
+	sed -ne "/^author /s/.*> //p" head >authortime &&
+	sed -ne "/^committer /s/.*> //p" head >committertime &&
+	test_cmp authortime committertime
+'
+
+test_expect_success '--committer-date-is-author-date works with interactive backend' '
+	git rebase -f HEAD^ &&
+	git rebase -i --committer-date-is-author-date HEAD^ &&
+	git cat-file commit HEAD | sed -e "/^\$/q" >head &&
+	sed -ne "/^author /s/.*> //p" head >authortime &&
+	sed -ne "/^committer /s/.*> //p" head >committertime &&
+	test_cmp authortime committertime
+'
+
 test_done
-- 
2.21.0

