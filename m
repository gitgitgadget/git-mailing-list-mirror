Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C2DC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27342087E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 17:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDHZkXnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgDJRvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:51:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35545 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJRvk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 13:51:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id c7so3334462edl.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gWl/iWRa+0Hj+QnUOe1RWiSj/z2+1/SC7I+NNnKt1+M=;
        b=NDHZkXnM0f70hE+7b1Luh3wAvjDD3/623fyEGRs4ZiNEy/4gCcZMMaYvedqBoVEEX6
         do0zEZt3xN+fPLA71kIHmrLubfq4nWfLMxKk8lbwvQo1qulathoRuhvNBXEI7xCLlCmV
         sX6bd+tUAlHltHzF6dB53P1lN8QVEECzp8HXtU53hcy/n7+6NjpoxpJL80ewmFfE43xy
         GoSvoz6Y6lJrzKM1CFllfesUCfkJkQpAoIQ0Fy8lt2KiW9IO63UtlwOLgbcp5Qid1uQz
         t2Z4kFR991Nl/vcEcI/7ZinHZcYOjSQ1HBp12vMyPaA5plBzspVL/eQquJLNZye7Ouzx
         pYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gWl/iWRa+0Hj+QnUOe1RWiSj/z2+1/SC7I+NNnKt1+M=;
        b=AgbGkNKgi3YRJUHkGTTkTZ/xqid49VOvFIyrJiYhpe3EGr2xL1PutkSdAjkgd065R9
         pcUEOEp29smRaRQa6998MUgZwhRpTuEW4uTIbfk2zdaYkdzUP2i6vlqrYaZdUIkTkoI3
         z8A5v6JRPMEPTwCukTWUVkzbSl7m+3S4WCnxFY3h6HKhJsqPjTJ4vidZUvrtViw8TWeA
         F0O1i45U/F110/Tk2M6JzOxUdENdIwB9QOOd5/2H+K47u218Afl1UlfVzJkNv0AZusJr
         xFpf9S1xJs3AyzkV9iAn0Bkhblgeayr690PgQoABHQaAd6To10UrNkioTZWeqqdrvFKY
         3TGQ==
X-Gm-Message-State: AGi0PubirVlhnCbi4B8pkWGx32NCn9ECGVkuKifGqqlXKw8VIC+2EwMB
        k5kzIlkKlZQzAEHZFXFls9DmizYr
X-Google-Smtp-Source: APiQypIxd+bEOXkMGfOI7tpyL4q+PGqT/FJTbwTbcC2kai4wbrCIsR4yg7TQIO3PSj85PPXBRKpYkQ==
X-Received: by 2002:a17:906:2bcb:: with SMTP id n11mr5061655ejg.72.1586541098253;
        Fri, 10 Apr 2020 10:51:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m24sm164222edp.49.2020.04.10.10.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:51:37 -0700 (PDT)
Message-Id: <e15c599c874956f1a297424c68fe28e04c71807b.1586541094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
        <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 17:51:33 +0000
Subject: [PATCH v2 2/3] rebase: reinstate --no-keep-empty
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        bturner@atlassian.com, sami@boukortt.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit d48e5e21da ("rebase (interactive-backend): make --keep-empty the
default", 2020-02-15) turned --keep-empty (for keeping commits which
start empty) into the default.  That commit viewed this, though as
turning that flag into a no-op.  As such, --no-keep-empty was translated
into undoing a no-op, i.e. also a no-op.  The logic underpinning that
commit was:

  1) 'git commit' errors out on the creation of empty commits without an
     override flag
  2) Once someone determines that the override is worthwhile, it's
     annoying and/or harmful to required them to take extra steps in
     order to keep such commits around (and to repeat such steps with
     every rebase).

While the logic on which the decision was made is sound, the result was
a bit of an overcorrection.  Instead of jumping to having --keep-empty
being the default, it jumped to making --keep-empty the only available
behavior.  There was a simple workaround, though, which was thought to
be good enough at the time.  People could still drop commits which
started empty the same way the could drop any commits: by firing up an
interactive rebase and picking out the commits they didn't want from the
list.  However, there are cases where external tools might create enough
empty commits that picking all of them out is painful.  As such, having
a flag to automatically remove start-empty commits may be beneficial.

Provide users a way to drop commits which start empty using a flag that
existed for years: --no-keep-empty.  Interpret --keep-empty as
countermanding any previous --no-keep-empty, but otherwise leaving
--keep-empty as the default.

This might lead to some slight weirdness since commands like
  git rebase --empty=drop --keep-empty
  git rebase --empty=keep --no-keep-empty
look really weird despite making perfect sense (the first will drop
commits which become empty, but keep commits that started empty; the
second will keep commits which become empty, but drop commits which
started empty).

Reported-by: Bryan Turner <bturner@atlassian.com>
Reported-by: Sami Boukortt <sami@boukortt.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt      | 37 +++++++++++++++++--------------
 builtin/rebase.c                  | 15 ++++++++-----
 sequencer.c                       |  6 +++++
 sequencer.h                       |  2 +-
 t/t3421-rebase-topology-linear.sh | 10 ++++-----
 t/t3424-rebase-empty.sh           | 36 ++++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8ab0558aca2..e58ca37786c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -277,20 +277,21 @@ See also INCOMPATIBLE OPTIONS below.
 	Other options, like --exec, will use the default of drop unless
 	-i/--interactive is explicitly specified.
 +
-Note that commits which start empty are kept, and commits which are
-clean cherry-picks (as determined by `git log --cherry-mark ...`) are
-always dropped.
+Note that commits which start empty are kept (unless --no-keep-empty
+is specified), and commits which are clean cherry-picks (as determined
+by `git log --cherry-mark ...`) are detected and dropped as a preliminary
+step (unless --keep-cherry-picks is passed).
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--no-keep-empty::
 --keep-empty::
-	No-op.  Rebasing commits that started empty (had no change
-	relative to their parent) used to fail and this option would
-	override that behavior, allowing commits with empty changes to
-	be rebased.  Now commits with no changes do not cause rebasing
-	to halt.
+	Do not keep commits that start empty before the rebase
+	(i.e. that do not change anything from its parent) in the
+	result.  For commits which become empty after rebasing, see
+	the --empty and --keep-cherry-pick flags.
 +
-See also BEHAVIORAL DIFFERENCES and INCOMPATIBLE OPTIONS below.
+See also INCOMPATIBLE OPTIONS below.
 
 --allow-empty-message::
 	No-op.  Rebasing commits with an empty message used to fail
@@ -587,7 +588,7 @@ are incompatible with the following options:
  * --preserve-merges
  * --interactive
  * --exec
- * --keep-empty
+ * --no-keep-empty
  * --empty=
  * --edit-todo
  * --root when used in combination with --onto
@@ -620,13 +621,15 @@ commits that started empty, though these are rare in practice.  It
 also drops commits that become empty and has no option for controlling
 this behavior.
 
-The merge backend keeps intentionally empty commits (though with -i
-they are marked as empty in the todo list editor).  Similar to the
-apply backend, by default the merge backend drops commits that become
-empty unless -i/--interactive is specified (in which case it stops and
-asks the user what to do).  The merge backend also has an
---empty={drop,keep,ask} option for changing the behavior of handling
-commits that become empty.
+The merge backend keeps intentionally empty commits by default (though
+with -i they are marked as empty in the todo list editor, or they can
+be dropped automatically with --no-keep-empty).
+
+Similar to the apply backend, by default the merge backend drops
+commits that become empty unless -i/--interactive is specified (in
+which case it stops and asks the user what to do).  The merge backend
+also has an --empty={drop,keep,ask} option for changing the behavior
+of handling commits that become empty.
 
 Directory rename detection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/rebase.c b/builtin/rebase.c
index bff53d5d167..022aa2589a5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -85,6 +85,7 @@ struct rebase_options {
 	const char *action;
 	int signoff;
 	int allow_rerere_autoupdate;
+	int keep_empty;
 	int autosquash;
 	char *gpg_sign_opt;
 	int autostash;
@@ -100,6 +101,7 @@ struct rebase_options {
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.empty = EMPTY_UNSPECIFIED,	  	\
+		.keep_empty = 1,			\
 		.default_backend = "merge",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
@@ -379,6 +381,7 @@ static int run_sequencer_rebase(struct rebase_options *opts,
 
 	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
 
+	flags |= opts->keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= opts->rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
 	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
@@ -442,6 +445,7 @@ static int run_sequencer_rebase(struct rebase_options *opts,
 	return ret;
 }
 
+static void imply_merge(struct rebase_options *opts, const char *option);
 static int parse_opt_keep_empty(const struct option *opt, const char *arg,
 				int unset)
 {
@@ -449,10 +453,8 @@ static int parse_opt_keep_empty(const struct option *opt, const char *arg,
 
 	BUG_ON_OPT_ARG(arg);
 
-	/*
-	 * If we ever want to remap --keep-empty to --empty=keep, insert:
-	 * 	opts->empty = unset ? EMPTY_UNSPECIFIED : EMPTY_KEEP;
-	 */
+	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
+	opts->keep_empty = !unset;
 	opts->type = REBASE_MERGE;
 	return 0;
 }
@@ -471,7 +473,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
 			   REBASE_FORCE),
 		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
-			N_("(DEPRECATED) keep empty commits"),
+			N_("keep commits which start empty"),
 			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
 			parse_opt_keep_empty },
 		OPT_BOOL_F(0, "allow-empty-message", &opts.allow_empty_message,
@@ -1162,6 +1164,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 		opts->allow_rerere_autoupdate ?
 			opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE ?
 			"--rerere-autoupdate" : "--no-rerere-autoupdate" : "");
+	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
 	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
 	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
 	add_var(&script_snippet, "cmd", opts->cmd);
@@ -1547,7 +1550,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			       N_("how to handle commits that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
 		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
-			N_("(DEPRECATED) keep empty commits"),
+			N_("keep commits which start empty"),
 			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
 			parse_opt_keep_empty },
 		OPT_BOOL(0, "autosquash", &options.autosquash,
diff --git a/sequencer.c b/sequencer.c
index ce9fd27a878..d973e19729e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4591,6 +4591,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 				   struct rev_info *revs, struct strbuf *out,
 				   unsigned flags)
 {
+	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
 	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
@@ -4645,6 +4646,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		is_empty = is_original_commit_empty(commit);
 		if (!is_empty && (commit->object.flags & PATCHSAME))
 			continue;
+		if (is_empty && !keep_empty)
+			continue;
 
 		strbuf_reset(&oneline);
 		pretty_print_commit(pp, commit, &oneline);
@@ -4822,6 +4825,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	struct pretty_print_context pp = {0};
 	struct rev_info revs;
 	struct commit *commit;
+	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
 
@@ -4861,6 +4865,8 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 
 		if (!is_empty && (commit->object.flags & PATCHSAME))
 			continue;
+		if (is_empty && !keep_empty)
+			continue;
 		strbuf_addf(out, "%s %s ", insn,
 			    oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&pp, commit, out);
diff --git a/sequencer.h b/sequencer.h
index 718a07426da..7ebaa237340 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -134,7 +134,7 @@ int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
 int sequencer_skip(struct repository *repo, struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
-/* #define TODO_LIST_KEEP_EMPTY (1U << 0) */ /* No longer used */
+#define TODO_LIST_KEEP_EMPTY (1U << 0)
 #define TODO_LIST_SHORTEN_IDS (1U << 1)
 #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
 #define TODO_LIST_REBASE_MERGES (1U << 3)
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index cf8dfd6c203..4a9204b4b64 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -220,14 +220,13 @@ test_have_prereq !REBASE_P || test_run_rebase failure -p
 test_run_rebase () {
 	result=$1
 	shift
-	test_expect_$result "rebase $* --keep-empty" "
+	test_expect_$result "rebase $* --no-keep-empty drops begin-empty commits" "
 		reset_rebase &&
-		git rebase $* --keep-empty c l &&
-		test_cmp_rev c HEAD~3 &&
-		test_linear_range 'd k l' c..
+		git rebase $* --no-keep-empty c l &&
+		test_cmp_rev c HEAD~2 &&
+		test_linear_range 'd l' c..
 	"
 }
-test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -242,7 +241,6 @@ test_run_rebase () {
 		test_linear_range 'd k l' j..
 	"
 }
-test_run_rebase success --apply
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index e1e30517ea6..5e1045a0afc 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -123,6 +123,42 @@ test_expect_success 'rebase --interactive uses default of --empty=ask' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase --merge --empty=drop --keep-empty' '
+	git checkout -B testing localmods &&
+	git rebase --merge --empty=drop --keep-empty upstream &&
+
+	test_write_lines D C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --merge --empty=drop --no-keep-empty' '
+	git checkout -B testing localmods &&
+	git rebase --merge --empty=drop --no-keep-empty upstream &&
+
+	test_write_lines C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --merge --empty=keep --keep-empty' '
+	git checkout -B testing localmods &&
+	git rebase --merge --empty=keep --keep-empty upstream &&
+
+	test_write_lines D C2 C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --merge --empty=keep --no-keep-empty' '
+	git checkout -B testing localmods &&
+	git rebase --merge --empty=keep --no-keep-empty upstream &&
+
+	test_write_lines C2 C B A >expect &&
+	git log --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase --merge does not leave state laying around' '
 	git checkout -B testing localmods~2 &&
 	git rebase --merge upstream &&
-- 
gitgitgadget

