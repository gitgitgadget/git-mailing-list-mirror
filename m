Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F23C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C60D60240
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbhH3VrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbhH3VrA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:47:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18094C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:46:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a62-20020a254d410000b0290592f360b0ccso4827817ybb.14
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I2D20dgDdDpjM3cFmgy0uMHVjToqV1HDHJm1Pw2vQ5A=;
        b=VWm2eNWuU+2zRuky7Jr6zTDrsiqHzrQlCHBIyWOS8bF0o77gcWYSbwm/mlZ7z8flvc
         U4880edG0YWiSpTmYzRs7drynJAXqOFt07wMe+CFKHi6ZoTidC8CSaYZWBv641pV/owm
         Jb4IuTnmX7tZlS2QMhzPHP4ZSRDUZ9bK4TBf/flRdxB+GEo+p4Bf7OaWezmDpHZWqCfL
         qPH06rS6OXETj5dLkUhZ3XFkDFfNnqQEPnmRuZBaGFZ6x+5RL9dhakcHoBK3JlR80G4M
         nkGoEd34pBTBf1F8L8HCA9CDMxAVlESZe2CGazEij8exmdx/shZYMFK2KbCNgj9+ss6I
         VU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I2D20dgDdDpjM3cFmgy0uMHVjToqV1HDHJm1Pw2vQ5A=;
        b=kzDzm33e94ZVS8t3AxP4dLRQkQ2QCq8iv404sQt5r9yx3ZLVWiwCUJS9z2NdNM/0lI
         KSHar2lBq84p/sCcvngUIK1gWIuvZ2rADt6bLKnMcXrymLDaivmQ8k9oGWZMS5NxPcvo
         iF9xzY2dc9MEvgDGzxtnecwBds5f06kdg3yQLchhdLGD6AU36A/9DVXq0vgzZr1pxooK
         jOoODNsrFvm9bQC96HDoXEpHzs5uxJSGTA8gA2j+t/kRZuVzSaNPw26HU7xL6JWHSo9a
         wRxwxeHpWp/sX9RiuWCBR8/ZbVcrZexNRQ6MXU3K+x1LhH1t6gnnLqZqfjTpXaKb1f87
         i8Kw==
X-Gm-Message-State: AOAM533RT/VWcnSkOZOUEKn7/lH5KIN7I1evxjdYGgI2aohfTzJbERjA
        93Vr+yaqxhrjaSc0UunyTpYYb3tvTjfTE/+zPsk5XQDeEqYHLRBq1EeglfYELu+ONWzW7porGwn
        LbLMhZdACvjtfQDEVuflpKj8HuuXn2ZuS8R38CprcPdTBfIlF0DbNDBfuMJe6mF8=
X-Google-Smtp-Source: ABdhPJxc0c/L78JsptrgY1ViSP9fJQTx2I0LtqIkOML/fA2YTrb9Dv4cz5LIUyuPD14794okOZWONgTKd964Qw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:16fe:83fb:786f:9778])
 (user=steadmon job=sendgmr) by 2002:a25:5808:: with SMTP id
 m8mr26366597ybb.334.1630359965201; Mon, 30 Aug 2021 14:46:05 -0700 (PDT)
Date:   Mon, 30 Aug 2021 14:46:02 -0700
In-Reply-To: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
Message-Id: <691c660422676c92180feb1c2a88049afe7536b9.1630359271.git.steadmon@google.com>
Mime-Version: 1.0
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v3] sequencer: advise if skipping cherry-picked commit
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, levraiphilippeblain@gmail.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Silently skipping commits when rebasing with --no-reapply-cherry-picks
(currently the default behavior) can cause user confusion. Issue
warnings when this happens, as well as advice on how to preserve the
skipped commits.

These warnings and advice are displayed only when using the (default)
"merge" rebase backend.

Update the git-rebase docs to mention the warnings and advice.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
I dealt with the smaller suggestions from the last review round, but I
hope to eventually send out a V4 that also includes some of the larger
changes, such as extending this to git-format-patch. But I don't expect
to have time for that in the near future, so I figured it's better to
get V3 out in case we are OK with merging without those additional
features.

Junio, please let me know if you'd like me to rebase this on top of
ab/retire-advice-config.

Changes in V3:
* Switch back to warning() for individual skipped commits
* Suppress warnings when `--quiet` is given
* Fixed formatting of advice_setting entries in advice.c
* Mention the advice / warnings in git-rebase doc

Changes in V2:
* use advise_if_enabled() instead of warning()
* s/seen/applied/ in the advice text

Range-diff against v2:
1:  496da0b174 ! 1:  691c660422 sequencer: advise if skipping cherry-picked commit
    @@ Commit message
         sequencer: advise if skipping cherry-picked commit
     
         Silently skipping commits when rebasing with --no-reapply-cherry-picks
    -    (currently the default behavior) can cause user confusion. Issue advice
    -    in this case so that users are aware of what's happening.
    +    (currently the default behavior) can cause user confusion. Issue
    +    warnings when this happens, as well as advice on how to preserve the
    +    skipped commits.
    +
    +    These warnings and advice are displayed only when using the (default)
    +    "merge" rebase backend.
    +
    +    Update the git-rebase docs to mention the warnings and advice.
     
     
    @@ Documentation/config/advice.txt: advice.*::
      		Shown when linkgit:git-status[1] computes the ahead/behind
      		counts for a local ref compared to its remote tracking ref,
     
    + ## Documentation/git-rebase.txt ##
    +@@ Documentation/git-rebase.txt: remain the checked-out branch.
    + 
    + If the upstream branch already contains a change you have made (e.g.,
    + because you mailed a patch which was applied upstream), then that commit
    +-will be skipped. For example, running `git rebase master` on the
    +-following history (in which `A'` and `A` introduce the same set of changes,
    +-but have different committer information):
    ++will be skipped and warnings will be issued (if the `merge` backend is
    ++used).  For example, running `git rebase master` on the following
    ++history (in which `A'` and `A` introduce the same set of changes, but
    ++have different committer information):
    + 
    + ------------
    +           A---B---C topic
    +@@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
    + By default (or if `--no-reapply-cherry-picks` is given), these commits
    + will be automatically dropped.  Because this necessitates reading all
    + upstream commits, this can be expensive in repos with a large number
    +-of upstream commits that need to be read.
    ++of upstream commits that need to be read.  When using the `merge`
    ++backend, warnings will be issued for each dropped commit (unless
    ++`--quiet` is given). Advice will also be issued unless
    ++`advice.skippedCherryPicks` is set to false (see linkgit:git-config[1]).
    + +
    + `--reapply-cherry-picks` allows rebase to forgo reading all upstream
    + commits, potentially improving performance.
    +
      ## advice.c ##
     @@ advice.c: int advice_checkout_ambiguous_remote_branch_name = 1;
      int advice_submodule_alternate_error_strategy_die = 1;
    @@ advice.c: static struct {
      	/* make this an alias for backward compatibility */
      	{ "pushNonFastForward", &advice_push_update_rejected }
     @@ advice.c: static struct {
    - 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
    - 	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
    - 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
    -+	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks", 1},
    - };
    - 
    - static const char turn_off_instructions[] =
    + 	[ADVICE_RM_HINTS]				= { "rmHints", 1 },
    + 	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse", 1 },
    + 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure", 1 },
    ++	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks", 1 },
    + 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning", 1 },
    + 	[ADVICE_STATUS_HINTS]				= { "statusHints", 1 },
    + 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
     
      ## advice.h ##
     @@ advice.h: extern int advice_add_empty_pathspec;
    @@ advice.h: extern int advice_add_empty_pathspec;
      
      int git_default_advice_config(const char *var, const char *value);
     
    + ## builtin/rebase.c ##
    +@@ builtin/rebase.c: static int run_sequencer_rebase(struct rebase_options *opts,
    + 	flags |= opts->root_with_onto ? TODO_LIST_ROOT_WITH_ONTO : 0;
    + 	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
    + 	flags |= opts->reapply_cherry_picks ? TODO_LIST_REAPPLY_CHERRY_PICKS : 0;
    ++	flags |= opts->flags & REBASE_NO_QUIET ? TODO_LIST_WARN_SKIPPED_CHERRY_PICKS : 0;
    + 
    + 	switch (command) {
    + 	case ACTION_NONE: {
    +
      ## sequencer.c ##
     @@ sequencer.c: static int make_script_with_merges(struct pretty_print_context *pp,
      	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
    @@ sequencer.c: static int make_script_with_merges(struct pretty_print_context *pp,
      		is_empty = is_original_commit_empty(commit);
     -		if (!is_empty && (commit->object.flags & PATCHSAME))
     +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
    -+			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
    -+					_("skipped previously applied commit %s"),
    ++			if (flags & TODO_LIST_WARN_SKIPPED_CHERRY_PICKS)
    ++				warning(_("skipped previously applied commit %s"),
     +					short_commit_name(commit));
     +			skipped_commit = 1;
      			continue;
    @@ sequencer.c: int sequencer_make_script(struct repository *r, struct strbuf *out,
      
     -		if (!is_empty && (commit->object.flags & PATCHSAME))
     +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
    -+			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
    -+					  _("skipped previously applied commit %s"),
    -+					  short_commit_name(commit));
    ++			if (flags & TODO_LIST_WARN_SKIPPED_CHERRY_PICKS)
    ++				warning(_("skipped previously applied commit %s"),
    ++					short_commit_name(commit));
     +			skipped_commit = 1;
      			continue;
     +		}
    @@ sequencer.c: int sequencer_make_script(struct repository *r, struct strbuf *out,
      	return 0;
      }
      
    +
    + ## sequencer.h ##
    +@@ sequencer.h: int sequencer_remove_state(struct replay_opts *opts);
    +  */
    + #define TODO_LIST_ROOT_WITH_ONTO (1U << 6)
    + #define TODO_LIST_REAPPLY_CHERRY_PICKS (1U << 7)
    ++#define TODO_LIST_WARN_SKIPPED_CHERRY_PICKS (1U << 8)
    + 
    + int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
    + 			  const char **argv, unsigned flags);

 Documentation/config/advice.txt |  3 +++
 Documentation/git-rebase.txt    | 12 ++++++++----
 advice.c                        |  3 +++
 advice.h                        |  1 +
 builtin/rebase.c                |  1 +
 sequencer.c                     | 22 ++++++++++++++++++++--
 sequencer.h                     |  1 +
 7 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 8b2849ff7b..063eec2511 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -44,6 +44,9 @@ advice.*::
 		Shown when linkgit:git-push[1] rejects a forced update of
 		a branch when its remote-tracking ref has updates that we
 		do not have locally.
+	skippedCherryPicks::
+		Shown when linkgit:git-rebase[1] skips a commit that has already
+		been cherry-picked onto the upstream branch.
 	statusAheadBehind::
 		Shown when linkgit:git-status[1] computes the ahead/behind
 		counts for a local ref compared to its remote tracking ref,
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 55af6fd24e..3978814912 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -79,9 +79,10 @@ remain the checked-out branch.
 
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
-will be skipped. For example, running `git rebase master` on the
-following history (in which `A'` and `A` introduce the same set of changes,
-but have different committer information):
+will be skipped and warnings will be issued (if the `merge` backend is
+used).  For example, running `git rebase master` on the following
+history (in which `A'` and `A` introduce the same set of changes, but
+have different committer information):
 
 ------------
           A---B---C topic
@@ -312,7 +313,10 @@ See also INCOMPATIBLE OPTIONS below.
 By default (or if `--no-reapply-cherry-picks` is given), these commits
 will be automatically dropped.  Because this necessitates reading all
 upstream commits, this can be expensive in repos with a large number
-of upstream commits that need to be read.
+of upstream commits that need to be read.  When using the `merge`
+backend, warnings will be issued for each dropped commit (unless
+`--quiet` is given). Advice will also be issued unless
+`advice.skippedCherryPicks` is set to false (see linkgit:git-config[1]).
 +
 `--reapply-cherry-picks` allows rebase to forgo reading all upstream
 commits, potentially improving performance.
diff --git a/advice.c b/advice.c
index 0b9c89c48a..ba6e703280 100644
--- a/advice.c
+++ b/advice.c
@@ -34,6 +34,7 @@ int advice_checkout_ambiguous_remote_branch_name = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
 int advice_add_ignored_file = 1;
 int advice_add_empty_pathspec = 1;
+int advice_skipped_cherry_picks = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -96,6 +97,7 @@ static struct {
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
 	{ "addIgnoredFile", &advice_add_ignored_file },
 	{ "addEmptyPathspec", &advice_add_empty_pathspec },
+	{ "skippedCherryPicks", &advice_skipped_cherry_picks },
 
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
@@ -133,6 +135,7 @@ static struct {
 	[ADVICE_RM_HINTS]				= { "rmHints", 1 },
 	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse", 1 },
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure", 1 },
+	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks", 1 },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning", 1 },
 	[ADVICE_STATUS_HINTS]				= { "statusHints", 1 },
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
diff --git a/advice.h b/advice.h
index 9f8ffc7354..d705bf164c 100644
--- a/advice.h
+++ b/advice.h
@@ -75,6 +75,7 @@ extern int advice_add_empty_pathspec;
 	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
 	ADVICE_UPDATE_SPARSE_PATH,
 	ADVICE_WAITING_FOR_EDITOR,
+	ADVICE_SKIPPED_CHERRY_PICKS,
 };
 
 int git_default_advice_config(const char *var, const char *value);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d..aa9a795f46 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -405,6 +405,7 @@ static int run_sequencer_rebase(struct rebase_options *opts,
 	flags |= opts->root_with_onto ? TODO_LIST_ROOT_WITH_ONTO : 0;
 	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 	flags |= opts->reapply_cherry_picks ? TODO_LIST_REAPPLY_CHERRY_PICKS : 0;
+	flags |= opts->flags & REBASE_NO_QUIET ? TODO_LIST_WARN_SKIPPED_CHERRY_PICKS : 0;
 
 	switch (command) {
 	case ACTION_NONE: {
diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3..8b036925e4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5099,6 +5099,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
 	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
+	int skipped_commit = 0;
 	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
 	struct strbuf label = STRBUF_INIT;
 	struct commit_list *commits = NULL, **tail = &commits, *iter;
@@ -5149,8 +5150,13 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		oidset_insert(&interesting, &commit->object.oid);
 
 		is_empty = is_original_commit_empty(commit);
-		if (!is_empty && (commit->object.flags & PATCHSAME))
+		if (!is_empty && (commit->object.flags & PATCHSAME)) {
+			if (flags & TODO_LIST_WARN_SKIPPED_CHERRY_PICKS)
+				warning(_("skipped previously applied commit %s"),
+					short_commit_name(commit));
+			skipped_commit = 1;
 			continue;
+		}
 		if (is_empty && !keep_empty)
 			continue;
 
@@ -5214,6 +5220,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		oidcpy(&entry->entry.oid, &commit->object.oid);
 		oidmap_put(&commit2todo, entry);
 	}
+	if (skipped_commit)
+		advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
+				  _("use --reapply-cherry-picks to include skipped commits"));
 
 	/*
 	 * Second phase:
@@ -5334,6 +5343,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
 	int reapply_cherry_picks = flags & TODO_LIST_REAPPLY_CHERRY_PICKS;
+	int skipped_commit = 0;
 
 	repo_init_revisions(r, &revs, NULL);
 	revs.verbose_header = 1;
@@ -5369,8 +5379,13 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 	while ((commit = get_revision(&revs))) {
 		int is_empty = is_original_commit_empty(commit);
 
-		if (!is_empty && (commit->object.flags & PATCHSAME))
+		if (!is_empty && (commit->object.flags & PATCHSAME)) {
+			if (flags & TODO_LIST_WARN_SKIPPED_CHERRY_PICKS)
+				warning(_("skipped previously applied commit %s"),
+					short_commit_name(commit));
+			skipped_commit = 1;
 			continue;
+		}
 		if (is_empty && !keep_empty)
 			continue;
 		strbuf_addf(out, "%s %s ", insn,
@@ -5380,6 +5395,9 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			strbuf_addf(out, " %c empty", comment_line_char);
 		strbuf_addch(out, '\n');
 	}
+	if (skipped_commit)
+		advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
+				  _("use --reapply-cherry-picks to include skipped commits"));
 	return 0;
 }
 
diff --git a/sequencer.h b/sequencer.h
index d57d8ea23d..2088344cb3 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -156,6 +156,7 @@ int sequencer_remove_state(struct replay_opts *opts);
  */
 #define TODO_LIST_ROOT_WITH_ONTO (1U << 6)
 #define TODO_LIST_REAPPLY_CHERRY_PICKS (1U << 7)
+#define TODO_LIST_WARN_SKIPPED_CHERRY_PICKS (1U << 8)
 
 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			  const char **argv, unsigned flags);
-- 
2.33.0.259.gc128427fd7-goog

