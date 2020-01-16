Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373DAC33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E128D20728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIKNh460"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgAPGOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40484 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbgAPGOl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so17873886wrn.7
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PWZ/CYNG/3mJFH4foslX92rwjv7iLnaHxgDOAtNg8vU=;
        b=ZIKNh460qZBxoySwGBnuPpyXbfk9i+J5NqDL9uVuprhJ6IwvWM7IrsujRqhXMQT22W
         Jkgb343feCmPoPvUxs2A6h8PChosUIpo7vXIBfhKUi34HChIwnqA+3kr9IhaBNHc4Z3g
         TGYbR73Vmf4qimxQiBF5sybmkzvOQfv3vUuGRcwwmRcQIGWOcR6xvQ+OR/blHuGb5JhA
         A/797E5pB3rAVAGazHTLibp++OO0rApFpuGZtg7gkqtDr+sS3ErZyqC0KT2orgxbxWex
         fld8fWLXV74TZpGveAsBlfKxacosV2RziNGmiusJZVFcE7wxHp+NZd4JJi90lOGS9IJO
         Cthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PWZ/CYNG/3mJFH4foslX92rwjv7iLnaHxgDOAtNg8vU=;
        b=kskKIgqEmyPXaeSQTrnhGvYVP//pfhPK02WyRodlHmb6uuPDgKyWIJZdvL2RkMK9uZ
         JBMzFYuK3qRMDtn1V5Z6Kavc3NeVtrqEW8twndB0pUaJfQK+IcB9IfGj3cp2G1XD/6QW
         CSRWuj8wPHUxVWHPe8fPkUaHRXYVMGGXFeRJz8omn3GJ2w9uo81lqnGef2+nBjjAo/sw
         1BYVfT9+52BbxaMDa8zHykfP0vywaeWOGcNldt9064qzYmlQNEE+voXF8PNHVGS+yj6x
         G3lNaf7hLTk3HLSOr5GFTvJzBIFK22PFIyW3B1UyvbaXgubLbPytJvbGxgGkhxgTu6iN
         nfkQ==
X-Gm-Message-State: APjAAAX+RnuU+U41mz7qoLy1K+SRo5/68ADhaSxBymAwAicH5Oo1B9EW
        YltWcluQvOs2ocyeN5lc+itrz6js
X-Google-Smtp-Source: APXvYqxpRK90JjgK2U0MiJFDGsCqRnuwtX/R2S31zEganBS0euwN/aKRzzfOr9BxAu62hM7OV/haNQ==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr1281108wro.234.1579155277793;
        Wed, 15 Jan 2020 22:14:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q68sm3417115wme.14.2020.01.15.22.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:37 -0800 (PST)
Message-Id: <179f82ab83e669ca8da7ce999607cae584bc18df.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:17 +0000
Subject: [PATCH v4 03/19] rebase (interactive-backend): make --keep-empty the
 default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Different rebase backends have different treatment for commits which
start empty (i.e. have no changes relative to their parent), and the
--keep-empty option was added at some point to allow adjusting behavior
for the interactive backend.  The handling of commits which start empty
is actually quite similar to commit b00bf1c9a8dd (git-rebase: make
--allow-empty-message the default, 2018-06-27), which pointed out that
the behavior for various backends is often more happenstance than
design.  The specific change made in that commit is actually quite
relevant as well and much of the logic there directly applies here.

It makes a lot of sense in 'git commit' to error out on the creation of
empty commits, unless an override flag is provided.  However, once
someone determines that there is a rare case that merits using the
manual override to create such a commit, it is somewhere between
annoying and harmful to have to take extra steps to keep such
intentional commits around.  Granted, empty commits are quite rare,
which is why handling of them doesn't get considered much and folks tend
to defer to existing (accidental) behavior and assume there was a reason
for it, leading them to just add flags (--keep-empty in this case) that
allow them to override the bad defaults.  Fix the interactive backend so
that --keep-empty is the default, much like we did with
--allow-empty-message.  The am backend should also be fixed to have
--keep-empty semantics for commits that start empty, but that is not
included in this patch other than a testcase documenting the failure.

Note that there was one test in t3421 which appears to have been written
expecting --keep-empty to not be the default as correct behavior.  This
test was introduced in commit 00b8be5a4d38 ("add tests for rebasing of
empty commits", 2013-06-06), which was part of a series focusing on
rebase topology and which had an interesting original cover letter at
https://lore.kernel.org/git/1347949878-12578-1-git-send-email-martinvonz@gmail.com/
which noted
    Your input especially appreciated on whether you agree with the
    intent of the test cases.
and then went into a long example about how one of the many tests added
had several questions about whether it was correct.  As such, I believe
most the tests in that series were about testing rebase topology with as
many different flags as possible and were not trying to state in general
how those flags should behave otherwise.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt      | 24 ++++++-----
 builtin/rebase.c                  | 28 ++++++++----
 rebase-interactive.c              |  7 +--
 rebase-interactive.h              |  2 +-
 sequencer.c                       | 20 +++------
 sequencer.h                       |  2 +-
 t/t3421-rebase-topology-linear.sh | 16 +++----
 t/t3424-rebase-empty.sh           | 72 +++++++++++++++++++++++++++++++
 t/t3427-rebase-subtree.sh         | 12 +++---
 9 files changed, 128 insertions(+), 55 deletions(-)
 create mode 100755 t/t3424-rebase-empty.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c83be7ffc2..1d19542d79 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -259,10 +259,13 @@ See also INCOMPATIBLE OPTIONS below.
 	unchanged as a result.
 
 --keep-empty::
-	Keep the commits that do not change anything from its
-	parents in the result.
+	No-op.  Rebasing commits that started empty (had no change
+	relative to their parent) used to fail and this option would
+	override that behavior, allowing commits with empty changes to
+	be rebased.  Now commits with no changes do not cause rebasing
+	to halt.
 +
-See also INCOMPATIBLE OPTIONS below.
+See also BEHAVIORAL DIFFERENCES and INCOMPATIBLE OPTIONS below.
 
 --allow-empty-message::
 	No-op.  Rebasing commits with an empty message used to fail
@@ -577,15 +580,14 @@ There are some subtle differences how the backends behave.
 Empty commits
 ~~~~~~~~~~~~~
 
-The am backend drops any "empty" commits, regardless of whether the
-commit started empty (had no changes relative to its parent to
-start with) or ended empty (all changes were already applied
-upstream in other commits).
+The am backend unfortunately drops intentionally empty commits, i.e.
+commits that started empty, though these are rare in practice.  It
+also drops commits that become empty and has no option for controlling
+this behavior.
 
-The interactive backend drops commits by default that
-started empty and halts if it hits a commit that ended up empty.
-The `--keep-empty` option exists for the interactive backend to allow
-it to keep commits that started empty.
+The interactive backend keeps intentionally empty commits.
+Unfortunately, it always halts whenever it runs across a commit that
+becomes empty, even when the rebase is not explicitly interactive.
 
 Directory rename detection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/rebase.c b/builtin/rebase.c
index faa4e0d406..537b3241ce 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -77,7 +77,6 @@ struct rebase_options {
 	const char *action;
 	int signoff;
 	int allow_rerere_autoupdate;
-	int keep_empty;
 	int autosquash;
 	char *gpg_sign_opt;
 	int autostash;
@@ -375,7 +374,6 @@ static int run_rebase_interactive(struct rebase_options *opts,
 
 	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
 
-	flags |= opts->keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= opts->rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
 	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
@@ -439,6 +437,17 @@ static int run_rebase_interactive(struct rebase_options *opts,
 	return ret;
 }
 
+static int parse_opt_keep_empty(const struct option *opt, const char *arg,
+				int unset)
+{
+	struct rebase_options *opts = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+
+	opts->type = REBASE_INTERACTIVE;
+	return 0;
+}
+
 static const char * const builtin_rebase_interactive_usage[] = {
 	N_("git rebase--interactive [<options>]"),
 	NULL
@@ -452,7 +461,10 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
 			   REBASE_FORCE),
-		OPT_BOOL(0, "keep-empty", &opts.keep_empty, N_("keep empty commits")),
+		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
+			N_("(DEPRECATED) keep empty commits"),
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
+			parse_opt_keep_empty },
 		OPT_BOOL_F(0, "allow-empty-message", &opts.allow_empty_message,
 			   N_("allow commits with empty messages"),
 			   PARSE_OPT_HIDDEN),
@@ -1145,7 +1157,6 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 		opts->allow_rerere_autoupdate ?
 			opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE ?
 			"--rerere-autoupdate" : "--no-rerere-autoupdate" : "");
-	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
 	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
 	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
 	add_var(&script_snippet, "cmd", opts->cmd);
@@ -1483,8 +1494,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				 "ignoring them"),
 			      REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
-		OPT_BOOL('k', "keep-empty", &options.keep_empty,
-			 N_("preserve empty commits during rebase")),
+		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
+			N_("(DEPRECATED) keep empty commits"),
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
+			parse_opt_keep_empty },
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
@@ -1747,9 +1760,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (!(options.flags & REBASE_NO_QUIET))
 		argv_array_push(&options.git_am_opts, "-q");
 
-	if (options.keep_empty)
-		imply_interactive(&options, "--keep-empty");
-
 	if (gpg_sign) {
 		free(options.gpg_sign_opt);
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index aa18ae82b7..7e7b4061bf 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -28,7 +28,7 @@ static enum missing_commit_check_level get_missing_commit_check_level(void)
 	return MISSING_COMMIT_CHECK_IGNORE;
 }
 
-void append_todo_help(unsigned keep_empty, int command_count,
+void append_todo_help(int command_count,
 		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf)
 {
@@ -80,11 +80,6 @@ void append_todo_help(unsigned keep_empty, int command_count,
 			"the rebase will be aborted.\n\n");
 
 	strbuf_add_commented_lines(buf, msg, strlen(msg));
-
-	if (!keep_empty) {
-		msg = _("Note that empty commits are commented out");
-		strbuf_add_commented_lines(buf, msg, strlen(msg));
-	}
 }
 
 int edit_todo_list(struct repository *r, struct todo_list *todo_list,
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 44dbb06311..05354ca341 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -5,7 +5,7 @@ struct strbuf;
 struct repository;
 struct todo_list;
 
-void append_todo_help(unsigned keep_empty, int command_count,
+void append_todo_help(int command_count,
 		      const char *shortrevisions, const char *shortonto,
 		      struct strbuf *buf);
 int edit_todo_list(struct repository *r, struct todo_list *todo_list,
diff --git a/sequencer.c b/sequencer.c
index b9dbf1adb0..c21fc202b1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1489,7 +1489,7 @@ static int allow_empty(struct repository *r,
 		       struct replay_opts *opts,
 		       struct commit *commit)
 {
-	int index_unchanged, empty_commit;
+	int index_unchanged, originally_empty;
 
 	/*
 	 * Three cases:
@@ -1513,10 +1513,10 @@ static int allow_empty(struct repository *r,
 	if (opts->keep_redundant_commits)
 		return 1;
 
-	empty_commit = is_original_commit_empty(commit);
-	if (empty_commit < 0)
-		return empty_commit;
-	if (!empty_commit)
+	originally_empty = is_original_commit_empty(commit);
+	if (originally_empty < 0)
+		return originally_empty;
+	if (!originally_empty)
 		return 0;
 	else
 		return 1;
@@ -4566,7 +4566,6 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				   struct rev_info *revs, struct strbuf *out,
 				   unsigned flags)
 {
-	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
 	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
@@ -4629,8 +4628,6 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		if (!to_merge) {
 			/* non-merge commit: easy case */
 			strbuf_reset(&buf);
-			if (!keep_empty && is_empty)
-				strbuf_addf(&buf, "%c ", comment_line_char);
 			strbuf_addf(&buf, "%s %s %s", cmd_pick,
 				    oid_to_hex(&commit->object.oid),
 				    oneline.buf);
@@ -4797,7 +4794,6 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	struct pretty_print_context pp = {0};
 	struct rev_info revs;
 	struct commit *commit;
-	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
 
@@ -4833,12 +4829,10 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 		return make_script_with_merges(&pp, &revs, out, flags);
 
 	while ((commit = get_revision(&revs))) {
-		int is_empty  = is_original_commit_empty(commit);
+		int is_empty = is_original_commit_empty(commit);
 
 		if (!is_empty && (commit->object.flags & PATCHSAME))
 			continue;
-		if (!keep_empty && is_empty)
-			strbuf_addf(out, "%c ", comment_line_char);
 		strbuf_addf(out, "%s %s ", insn,
 			    oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&pp, commit, out);
@@ -4975,7 +4969,7 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 
 	todo_list_to_strbuf(r, todo_list, &buf, num, flags);
 	if (flags & TODO_LIST_APPEND_TODO_HELP)
-		append_todo_help(flags & TODO_LIST_KEEP_EMPTY, count_commands(todo_list),
+		append_todo_help(count_commands(todo_list),
 				 shortrevisions, shortonto, &buf);
 
 	res = write_message(buf.buf, buf.len, file, 0);
diff --git a/sequencer.h b/sequencer.h
index 9f9ae291e3..c165e0ff25 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -132,7 +132,7 @@ int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
 int sequencer_skip(struct repository *repo, struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
-#define TODO_LIST_KEEP_EMPTY (1U << 0)
+/* #define TODO_LIST_KEEP_EMPTY (1U << 0) */ /* No longer used */
 #define TODO_LIST_SHORTEN_IDS (1U << 1)
 #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
 #define TODO_LIST_REBASE_MERGES (1U << 3)
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 325072b0a3..57334dca7e 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -205,17 +205,17 @@ test_expect_success 'setup of linear history for empty commit tests' '
 test_run_rebase () {
 	result=$1
 	shift
-	test_expect_$result "rebase $* drops empty commit" "
+	test_expect_$result "rebase $* keeps begin-empty commits" "
 		reset_rebase &&
-		git rebase $* c l &&
-		test_cmp_rev c HEAD~2 &&
-		test_linear_range 'd l' c..
+		git rebase $* j l &&
+		test_cmp_rev c HEAD~4 &&
+		test_linear_range 'j d k l' c..
 	"
 }
-test_run_rebase success ''
+test_run_rebase failure ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase success -p
+test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -230,7 +230,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -245,7 +245,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_have_prereq !REBASE_P || test_run_rebase failure -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 test_run_rebase success --rebase-merges
 
 #       m
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
new file mode 100755
index 0000000000..22d97e143b
--- /dev/null
+++ b/t/t3424-rebase-empty.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='git rebase of commits that start or become empty'
+
+. ./test-lib.sh
+
+test_expect_success 'setup test repository' '
+	test_write_lines 1 2 3 4 5 6 7 8 9 10 >numbers &&
+	test_write_lines A B C D E F G H I J >letters &&
+	git add numbers letters &&
+	git commit -m A &&
+
+	git branch upstream &&
+	git branch localmods &&
+
+	git checkout upstream &&
+	test_write_lines A B C D E >letters &&
+	git add letters &&
+	git commit -m B &&
+
+	test_write_lines 1 2 3 4 five 6 7 8 9 ten >numbers &&
+	git add numbers &&
+	git commit -m C &&
+
+	git checkout localmods &&
+	test_write_lines 1 2 3 4 five 6 7 8 9 10 >numbers &&
+	git add numbers &&
+	git commit -m C2 &&
+
+	git commit --allow-empty -m D &&
+
+	test_write_lines A B C D E >letters &&
+	git add letters &&
+	git commit -m "Five letters ought to be enough for anybody"
+'
+
+test_expect_failure 'rebase (am-backend) with a variety of empty commits' '
+	test_when_finished "git rebase --abort" &&
+	git checkout -B testing localmods &&
+	# rebase (--am) should not drop commits that start empty
+	git rebase upstream &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'rebase --merge with a variety of empty commits' '
+	test_when_finished "git rebase --abort" &&
+	git checkout -B testing localmods &&
+	# rebase --merge should not halt on the commit that becomes empty
+	git rebase --merge upstream &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
+
+test_expect_success 'rebase --interactive with a variety of empty commits' '
+	git checkout -B testing localmods &&
+	test_must_fail git rebase --interactive upstream &&
+
+	git rebase --skip &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index bec48e6a1f..8dceef61cf 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -85,23 +85,23 @@ test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
 
-test_expect_success 'Rebase -Xsubtree --keep-empty --onto commit' '
+test_expect_success 'Rebase -Xsubtree --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-onto to-rebase &&
-	test_must_fail git rebase -Xsubtree=files_subtree --keep-empty --onto files-master master &&
+	test_must_fail git rebase -Xsubtree=files_subtree --onto files-master master &&
 	: first pick results in no changes &&
-	git rebase --continue &&
+	git rebase --skip &&
 	verbose test "$(commit_message HEAD~2)" = "master4" &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
 
-test_expect_success 'Rebase -Xsubtree --keep-empty --rebase-merges --onto commit' '
+test_expect_success 'Rebase -Xsubtree --rebase-merges --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-merges-onto to-rebase &&
-	test_must_fail git rebase -Xsubtree=files_subtree --keep-empty --rebase-merges --onto files-master --root &&
+	test_must_fail git rebase -Xsubtree=files_subtree --rebase-merges --onto files-master --root &&
 	: first pick results in no changes &&
-	git rebase --continue &&
+	git rebase --skip &&
 	verbose test "$(commit_message HEAD~2)" = "master4" &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
-- 
gitgitgadget

