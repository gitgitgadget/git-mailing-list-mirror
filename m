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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B8DC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA24D60EBB
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhHJTVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhHJTVD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:21:03 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FCAC0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:20:41 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w11-20020ac857cb0000b029024e7e455d67so11859677qta.16
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TORhpcQYHT4GjpOJmFSDTyP1k3+fhIHGVEK6OFT1X6w=;
        b=IYRklHjanantmVJTl2WgAE1GszIVwGN9cPi12gs6iZt8ITjTIR7TvAZmApOo3YXbPS
         HmyYxkhMwM6EjMiU8vdvY2K4eRySsny/efr25D5fbK+fwNsaeAsnHQvyfJjXyU2Nmc3v
         LARAuR3ArzvZPxxSFtKLgBkGq5MBPif2DL+EYcgtNQ9QS3KosQ6QgdL2S/p9xfQCdIat
         YcneSagWaodYuIF0QcwAtzb8k5j/Z5/uiEQGqjxZMMRvczcBCr+T1rPr2kPVEPDkXEEO
         zlO+Hq1LDuGUjFAqEe0bo5EG6eTnsmByYK1JKgxgVcGaNFvVes7Kicag0K0DzuhVEy4H
         EVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TORhpcQYHT4GjpOJmFSDTyP1k3+fhIHGVEK6OFT1X6w=;
        b=DB9uKnRb6oHGsup7D2aW4SbyzRagKLICAgdw8aOn7lfT6qrJlJy6mEypF6nC5BMaic
         IjqrLp4M25kZNabY5Az/qllg2hZ62T64OCxsRk8Klfxk/0R6XygYYez61mmnzfwur37b
         dSn7zfjfrfRhgXKZUrhqF5UpVddmVBbALZucGwYK2+Idf0LBASiR+JUGDd+XBl5PT3P7
         gPBvoUJZSgVexISX71kmLxfayX0ioQYrOOiD1m7+a80dvk+xUj9Hpe6OvMW1No2EbXix
         81Ll/ON3esS6tQ95QY5Ct9jID5jD9IpCjQPYUECTZDOhPA08xqLEnymvqCcgZLTJ9mFt
         EM1w==
X-Gm-Message-State: AOAM531SGTMgriWnVJFlaER6FR7B3GzGsCDO+0KD4tvvDMupncTARy64
        HNb2XF9s6zdUHz3yM44FF1GIy4Lszy/BKCuFsbxb5I+eOH7zi6ovjbmVG+I1XHM4Y7qgScSLI+P
        4W6+FjTsAMwHiKQv9kQ1tgSkHazL3ZkJmTiJh4ry80f499dCppvaWMVE04jLtUvE=
X-Google-Smtp-Source: ABdhPJxWeNKKi6f3GDOAdiVs0iyGQaZ8B7C9ilATGWV32akP0MAJKhTpNHZ/hlrg0Ve3D9Pb1OaxnPy/3YbIhg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:8483:7200:7ec:f495])
 (user=steadmon job=sendgmr) by 2002:a05:6214:e82:: with SMTP id
 hf2mr19628302qvb.24.1628623240097; Tue, 10 Aug 2021 12:20:40 -0700 (PDT)
Date:   Tue, 10 Aug 2021 12:20:38 -0700
In-Reply-To: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
Message-Id: <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
Mime-Version: 1.0
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2] sequencer: advise if skipping cherry-picked commit
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Silently skipping commits when rebasing with --no-reapply-cherry-picks
(currently the default behavior) can cause user confusion. Issue advice
in this case so that users are aware of what's happening.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Changes in V2:
* use advise_if_enabled() instead of warning()
* s/seen/applied/ in the advice text

 Documentation/config/advice.txt |  3 +++
 advice.c                        |  3 +++
 advice.h                        |  1 +
 sequencer.c                     | 22 ++++++++++++++++++++--
 4 files changed, 27 insertions(+), 2 deletions(-)

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
diff --git a/advice.c b/advice.c
index 0b9c89c48a..7768319b4a 100644
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
@@ -139,6 +141,7 @@ static struct {
 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
 	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
+	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks", 1},
 };
 
 static const char turn_off_instructions[] =
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
diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3..1235f61c9d 100644
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
+			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
+					_("skipped previously applied commit %s"),
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
+			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
+					  _("skipped previously applied commit %s"),
+					  short_commit_name(commit));
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
 
-- 
2.32.0.605.g8dce9f2422-goog

