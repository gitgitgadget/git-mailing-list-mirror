Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5792EC33CB3
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1083A20728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="momUdnWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgAPGOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37849 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgAPGOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so17909185wru.4
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5IZETqUu4Ig++yHqlEwm7ORe0PUOta2a0IwHt9N4ZXU=;
        b=momUdnWtR6vln2Toi01UZNLLcnlqFrGjObgHC+2W7Z+J1rHJ1tpf3fxzwFuwkScrzs
         K4kyzjm8nqUcGSHp7uZSRXkAnbaPr+C8MUmh9CR8U0BcJ9/vIbGJidS0xGymGuhf5sD1
         IPY3Adk/PkwOkXNLaBNQm7IzggDWMIbBVb7MoawvGHMUYYik1MBh7To9s8jkaJ+6FqRz
         4PS57LeUB9Zu9sSsIuUQOKd63+LcqkTPTqAHVq2WK7nbjC8tZJcXGZyVVWutquwzPcTl
         3dkvE+l+AaoA7qJ3BDoWYDGPPfYK8nKsucybdvWaA9ec31bq3+l9CiPJ9ShroSBnyB0j
         kOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5IZETqUu4Ig++yHqlEwm7ORe0PUOta2a0IwHt9N4ZXU=;
        b=HA7Id6wy3OjjUOqunBpHBvdph/zWZT0xY0GK56I/6WqkNXMpjip5hjQgbLfJUqTzhz
         SKl0Dx3qMI1kHtVrPBEYLhZL/zp0sZG68oWvQDp7VifQFQp+RR3V9qeckhOpfGXoyssz
         Cx2XkFy95Ds7uk+UXyhoaoLtjFQWqdlRFkLNO+pkdqtdlx9Q2QNt/YrSwlhNnaIQb6Ch
         G1UfzE2L+Jxo+K8M9KWVQ8cmre93L4SchA62z9mdywc0sMxWThUdBzs2G316PCKY6/R8
         a2HNpgzhWM3Si8BZYQceavh1rW3QJcCdjF8yvDb99togw4d7UDmjvRM1/Qi+5U+Bz1Ol
         M6Og==
X-Gm-Message-State: APjAAAVvMGWOgEw/p3DJlhoGW5SADtRXHdfu9GZYSQgYJSHSE96T8eKP
        anzzdB3xXZe+IzfFLZIfP0HAnZfK
X-Google-Smtp-Source: APXvYqz0UJguFqPKTrFva4snEwv3DQs0+mgMPyzWRP4QfePI2VZslKQpetSay1kIGmgMHv2qpOwPlA==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr1310320wrn.280.1579155278641;
        Wed, 15 Jan 2020 22:14:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm27491887wrw.97.2020.01.15.22.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:38 -0800 (PST)
Message-Id: <c9542a2abe0da284c28f1c71566db8fc5c47c1a5.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:18 +0000
Subject: [PATCH v4 04/19] rebase (interactive-backend): fix handling of
 commits that become empty
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

As established in the previous commit and commit b00bf1c9a8dd
(git-rebase: make --allow-empty-message the default, 2018-06-27), the
behavior for rebase with different backends in various edge or corner
cases is often more happenstance than design.  This commit addresses
another such corner case: commits which "become empty".

A careful reader may note that there are two types of commits which would
become empty due to a rebase:

  * [clean cherry-pick] Commits which are clean cherry-picks of upstream
    commits, as determined by `git log --cherry-mark ...`.  Re-applying
    these commits would result in an empty set of changes and a
    duplicative commit message; i.e. these are commits that have
    "already been applied" upstream.

  * [become empty] Commits which are not empty to start, are not clean
    cherry-picks of upstream commits, but which still become empty after
    being rebased.  This happens e.g. when a commit has changes which
    are a strict subset of the changes in an upstream commit, or when
    the changes of a commit can be found spread across or among several
    upstream commits.

Clearly, in both cases the changes in the commit in question are found
upstream already, but the commit message may not be in the latter case.

When cherry-mark can determine a commit is already upstream, then
because of how cherry-mark works this means the upstream commit message
was about the *exact* same set of changes.  Thus, the commit messages
can be assumed to be fully interchangeable (and are in fact likely to be
completely identical).  As such, the clean cherry-pick case represents a
case when there is no information to be gained by keeping the extra
commit around.  All rebase types have always dropped these commits, and
no one to my knowledge has ever requested that we do otherwise.

For many of the become empty cases (and likely even most), we will also
be able to drop the commit without loss of information -- but this isn't
quite always the case.  Since these commits represent cases that were
not clean cherry-picks, there is no upstream commit message explaining
the same set of changes.  Projects with good commit message hygiene will
likely have the explanation from our commit message contained within or
spread among the relevant upstream commits, but not all projects run
that way.  As such, the commit message of the commit being rebased may
have reasoning that suggests additional changes that should be made to
adapt to the new base, or it may have information that someone wants to
add as a note to another commit, or perhaps someone even wants to create
an empty commit with the commit message as-is.

Junio commented on the "become-empty" types of commits as follows[1]:

    WRT a change that ends up being empty (as opposed to a change that
    is empty from the beginning), I'd think that the current behaviour
    is desireable one.  "am" based rebase is solely to transplant an
    existing history and want to stop much less than "interactive" one
    whose purpose is to polish a series before making it publishable,
    and asking for confirmation ("this has become empty--do you want to
    drop it?") is more appropriate from the workflow point of view.

[1] https://lore.kernel.org/git/xmqqfu1fswdh.fsf@gitster-ct.c.googlers.com/

I would simply add that his arguments for "am"-based rebases actually
apply to all non-explicitly-interactive rebases.  Also, since we are
stating that different cases should have different defaults, it may be
worth providing a flag to allow users to select which behavior they want
for these commits.

Introduce a new command line flag for selecting the desired behavior:
    --empty={drop,keep,ask}
with the definitions:
    drop: drop commits which become empty
    keep: keep commits which become empty
    ask:  provide the user a chance to interact and pick what to do with
          commits which become empty on a case-by-case basis

In line with Junio's suggestion, if the --empty flag is not specified,
pick defaults as follows:
    explicitly interactive: ask
    otherwise: drop

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 27 ++++++++++++++++---
 builtin/rebase.c             | 52 ++++++++++++++++++++++++++++++++++++
 sequencer.c                  | 48 +++++++++++++++++++++++++--------
 sequencer.h                  |  1 +
 t/t3424-rebase-empty.sh      | 50 +++++++++++++++++++++++++++++-----
 t/t3427-rebase-subtree.sh    |  8 +++---
 6 files changed, 161 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 1d19542d79..551a91d764 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -258,6 +258,22 @@ See also INCOMPATIBLE OPTIONS below.
 	original branch. The index and working tree are also left
 	unchanged as a result.
 
+--empty={drop,keep,ask}::
+	How to handle commits that are not empty to start and are not
+	clean cherry-picks of any upstream commit, but which become
+	empty after rebasing (because they contain a subset of already
+	upstream changes).  With drop (the default), commits that
+	become empty are dropped.  With keep, such commits are kept.
+	With ask (implied by --interactive), the rebase will halt when
+	an empty commit is applied allowing you to choose whether to
+	drop it, edit files more, or just commit the empty changes.
++
+Note that commits which start empty are kept, and commits which are
+clean cherry-picks (as determined by `git log --cherry-mark ...`) are
+always dropped.
++
+See also INCOMPATIBLE OPTIONS below.
+
 --keep-empty::
 	No-op.  Rebasing commits that started empty (had no change
 	relative to their parent) used to fail and this option would
@@ -561,6 +577,7 @@ are incompatible with the following options:
  * --interactive
  * --exec
  * --keep-empty
+ * --empty=
  * --edit-todo
  * --root when used in combination with --onto
 
@@ -569,6 +586,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --interactive
  * --preserve-merges and --signoff
  * --preserve-merges and --rebase-merges
+ * --preserve-merges and --empty=
  * --keep-base and --onto
  * --keep-base and --root
 
@@ -585,9 +603,12 @@ commits that started empty, though these are rare in practice.  It
 also drops commits that become empty and has no option for controlling
 this behavior.
 
-The interactive backend keeps intentionally empty commits.
-Unfortunately, it always halts whenever it runs across a commit that
-becomes empty, even when the rebase is not explicitly interactive.
+The interactive backend keeps intentionally empty commits.  Similar to
+the am backend, by default the interactive backend drops commits that
+become empty unless -i/--interactive is specified (in which case it
+stops and asks the user what to do).  The interactive backend also has
+an --empty={drop,keep,ask} option for changing the behavior of
+handling commits that become empty.
 
 Directory rename detection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 537b3241ce..c299869e7b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -50,8 +50,16 @@ enum rebase_type {
 	REBASE_PRESERVE_MERGES
 };
 
+enum empty_type {
+	EMPTY_UNSPECIFIED = -1,
+	EMPTY_DROP,
+	EMPTY_KEEP,
+	EMPTY_ASK
+};
+
 struct rebase_options {
 	enum rebase_type type;
+	enum empty_type empty;
 	const char *state_dir;
 	struct commit *upstream;
 	const char *upstream_name;
@@ -91,6 +99,7 @@ struct rebase_options {
 
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
+		.empty = EMPTY_UNSPECIFIED,	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT	\
@@ -109,6 +118,8 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
 	replay.allow_empty = 1;
 	replay.allow_empty_message = opts->allow_empty_message;
+	replay.drop_redundant_commits = (opts->empty == EMPTY_DROP);
+	replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
 	replay.verbose = opts->flags & REBASE_VERBOSE;
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
@@ -444,6 +455,10 @@ static int parse_opt_keep_empty(const struct option *opt, const char *arg,
 
 	BUG_ON_OPT_ARG(arg);
 
+	/*
+	 * If we ever want to remap --keep-empty to --empty=keep, insert:
+	 * 	opts->empty = unset ? EMPTY_UNSPECIFIED : EMPTY_KEEP;
+	 */
 	opts->type = REBASE_INTERACTIVE;
 	return 0;
 }
@@ -1350,6 +1365,29 @@ static int parse_opt_interactive(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static enum empty_type parse_empty_value(const char *value)
+{
+	if (!strcasecmp(value, "drop"))
+		return EMPTY_DROP;
+	else if (!strcasecmp(value, "keep"))
+		return EMPTY_KEEP;
+	else if (!strcasecmp(value, "ask"))
+		return EMPTY_ASK;
+
+	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
+}
+
+static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
+{
+	struct rebase_options *options = opt->value;
+	enum empty_type value = parse_empty_value(arg);
+
+	BUG_ON_OPT_NEG(unset);
+
+	options->empty = value;
+	return 0;
+}
+
 static void NORETURN error_on_missing_default_upstream(void)
 {
 	struct branch *current_branch = branch_get(NULL);
@@ -1494,6 +1532,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				 "ignoring them"),
 			      REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
+		OPT_CALLBACK_F(0, "empty", &options, N_("{drop,keep,ask}"),
+			       N_("how to handle empty commits"),
+			       PARSE_OPT_NONEG, parse_opt_empty),
 		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
 			N_("(DEPRECATED) keep empty commits"),
 			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
@@ -1760,6 +1801,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (!(options.flags & REBASE_NO_QUIET))
 		argv_array_push(&options.git_am_opts, "-q");
 
+	if (options.empty != EMPTY_UNSPECIFIED)
+		imply_interactive(&options, "--empty");
+
 	if (gpg_sign) {
 		free(options.gpg_sign_opt);
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
@@ -1843,6 +1887,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
+	if (options.empty == EMPTY_UNSPECIFIED) {
+		if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
+			options.empty = EMPTY_ASK;
+		else if (exec.nr > 0)
+			options.empty = EMPTY_KEEP;
+		else
+			options.empty = EMPTY_DROP;
+	}
 	if (reschedule_failed_exec > 0 && !is_interactive(&options))
 		die(_("--reschedule-failed-exec requires "
 		      "--exec or --interactive"));
diff --git a/sequencer.c b/sequencer.c
index c21fc202b1..354d0b5a38 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -158,6 +158,8 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
 static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
 static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
+static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
+static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
 
 static int git_sequencer_config(const char *k, const char *v, void *cb)
 {
@@ -1483,7 +1485,11 @@ static int is_original_commit_empty(struct commit *commit)
 }
 
 /*
- * Do we run "git commit" with "--allow-empty"?
+ * Should empty commits be allowed?  Return status:
+ *    <0: Error in is_index_unchanged(r) or is_original_commit_empty(commit)
+ *     0: Halt on empty commit
+ *     1: Allow empty commit
+ *     2: Drop empty commit
  */
 static int allow_empty(struct repository *r,
 		       struct replay_opts *opts,
@@ -1492,14 +1498,17 @@ static int allow_empty(struct repository *r,
 	int index_unchanged, originally_empty;
 
 	/*
-	 * Three cases:
+	 * Four cases:
 	 *
 	 * (1) we do not allow empty at all and error out.
 	 *
-	 * (2) we allow ones that were initially empty, but
-	 * forbid the ones that become empty;
+	 * (2) we allow ones that were initially empty, and
+	 *     just drop the ones that become empty
 	 *
-	 * (3) we allow both.
+	 * (3) we allow ones that were initially empty, but
+	 *     halt for the ones that become empty;
+	 *
+	 * (4) we allow both.
 	 */
 	if (!opts->allow_empty)
 		return 0; /* let "git commit" barf as necessary */
@@ -1516,10 +1525,12 @@ static int allow_empty(struct repository *r,
 	originally_empty = is_original_commit_empty(commit);
 	if (originally_empty < 0)
 		return originally_empty;
-	if (!originally_empty)
-		return 0;
-	else
+	if (originally_empty)
 		return 1;
+	else if (opts->drop_redundant_commits)
+		return 2;
+	else
+		return 0;
 }
 
 static struct {
@@ -1730,7 +1741,7 @@ static int do_pick_commit(struct repository *r,
 	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, reword = 0, allow;
+	int res, unborn = 0, reword = 0, allow, drop_commit;
 
 	if (opts->no_commit) {
 		/*
@@ -1935,13 +1946,18 @@ static int do_pick_commit(struct repository *r,
 		goto leave;
 	}
 
+	drop_commit = 0;
 	allow = allow_empty(r, opts, commit);
 	if (allow < 0) {
 		res = allow;
 		goto leave;
-	} else if (allow)
+	} else if (allow == 1) {
 		flags |= ALLOW_EMPTY;
-	if (!opts->no_commit) {
+	} else if (allow == 2) {
+		drop_commit = 1;
+		fprintf(stderr, _("No changes -- Patch already applied.\n"));
+	} // else allow == 0 and there's nothing special to do
+	if (!opts->no_commit && !drop_commit) {
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
 			res = do_commit(r, msg_file, author, opts, flags);
 		else
@@ -2495,6 +2511,12 @@ static int read_populate_opts(struct replay_opts *opts)
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
+		if (file_exists(rebase_path_drop_redundant_commits()))
+			opts->drop_redundant_commits = 1;
+
+		if (file_exists(rebase_path_keep_redundant_commits()))
+			opts->keep_redundant_commits = 1;
+
 		read_strategy_opts(opts, &buf);
 		strbuf_release(&buf);
 
@@ -2574,6 +2596,10 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
 	if (opts->signoff)
 		write_file(rebase_path_signoff(), "--signoff\n");
+	if (opts->drop_redundant_commits)
+		write_file(rebase_path_drop_redundant_commits(), "%s", "");
+	if (opts->keep_redundant_commits)
+		write_file(rebase_path_keep_redundant_commits(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
diff --git a/sequencer.h b/sequencer.h
index c165e0ff25..3b0ab9141f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -39,6 +39,7 @@ struct replay_opts {
 	int allow_rerere_auto;
 	int allow_empty;
 	int allow_empty_message;
+	int drop_redundant_commits;
 	int keep_redundant_commits;
 	int verbose;
 	int quiet;
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 22d97e143b..dcb4cb4751 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -34,7 +34,7 @@ test_expect_success 'setup test repository' '
 	git commit -m "Five letters ought to be enough for anybody"
 '
 
-test_expect_failure 'rebase (am-backend) with a variety of empty commits' '
+test_expect_failure 'rebase (am-backend)' '
 	test_when_finished "git rebase --abort" &&
 	git checkout -B testing localmods &&
 	# rebase (--am) should not drop commits that start empty
@@ -45,11 +45,29 @@ test_expect_failure 'rebase (am-backend) with a variety of empty commits' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'rebase --merge with a variety of empty commits' '
-	test_when_finished "git rebase --abort" &&
+test_expect_success 'rebase --merge --empty=drop' '
 	git checkout -B testing localmods &&
-	# rebase --merge should not halt on the commit that becomes empty
-	git rebase --merge upstream &&
+	git rebase --merge --empty=drop upstream &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --merge --empty=keep' '
+	git checkout -B testing localmods &&
+	git rebase --merge --empty=keep upstream &&
+
+	test_write_lines D C2 C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --merge --empty=ask' '
+	git checkout -B testing localmods &&
+	test_must_fail git rebase --merge --empty=ask upstream &&
+
+	git rebase --skip &&
 
 	test_write_lines D C B A >expect &&
 	git log --format=%s >actual &&
@@ -58,9 +76,27 @@ test_expect_failure 'rebase --merge with a variety of empty commits' '
 
 GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
 
-test_expect_success 'rebase --interactive with a variety of empty commits' '
+test_expect_success 'rebase --interactive --empty=drop' '
+	git checkout -B testing localmods &&
+	git rebase --interactive --empty=drop upstream &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --interactive --empty=keep' '
+	git checkout -B testing localmods &&
+	git rebase --interactive --empty=keep upstream &&
+
+	test_write_lines D C2 C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --interactive --empty=ask' '
 	git checkout -B testing localmods &&
-	test_must_fail git rebase --interactive upstream &&
+	test_must_fail git rebase --interactive --empty=ask upstream &&
 
 	git rebase --skip &&
 
diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 8dceef61cf..79e43a370b 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -85,10 +85,10 @@ test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
 
-test_expect_success 'Rebase -Xsubtree --onto commit' '
+test_expect_success 'Rebase -Xsubtree --empty=ask --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-onto to-rebase &&
-	test_must_fail git rebase -Xsubtree=files_subtree --onto files-master master &&
+	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --onto files-master master &&
 	: first pick results in no changes &&
 	git rebase --skip &&
 	verbose test "$(commit_message HEAD~2)" = "master4" &&
@@ -96,10 +96,10 @@ test_expect_success 'Rebase -Xsubtree --onto commit' '
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
 
-test_expect_success 'Rebase -Xsubtree --rebase-merges --onto commit' '
+test_expect_success 'Rebase -Xsubtree --empty=ask --rebase-merges --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-merges-onto to-rebase &&
-	test_must_fail git rebase -Xsubtree=files_subtree --rebase-merges --onto files-master --root &&
+	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --rebase-merges --onto files-master --root &&
 	: first pick results in no changes &&
 	git rebase --skip &&
 	verbose test "$(commit_message HEAD~2)" = "master4" &&
-- 
gitgitgadget

