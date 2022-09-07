Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CAFC6FA89
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIGOiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIGOh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:37:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043E7755C
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:37:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso9666258wmq.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=l85nBnlGEJZ7I0Tetme70BjmV9LBB9ZHP/7uw8NOMII=;
        b=YnFBaTlCYlL/hb9d56G+qZIW3T3kzs3FidcsYkFZZs2ZXfiJ02kAoUVmM+h8Y4tDXm
         Jf71Kr11TQBtI/1ZrpTIQ+mbDSxxU9XC+ntdl7tLBCpbVBM+F2JsyiKdtiOB0KuQ1Gt0
         U4Lih0q2cugIHmBj75t+Ygxlkl+gRSiVXDNoOkNUYnbEVlPvyoi1lNd8V6pY7CCLFdsI
         8fxs+O4T/OLvV9cHWXQzSA8cVD50W7Cl0cPumUU4Ta1jR8DIiDdaS10phpx46HKVk3Rv
         /SQC+c7oSR0FG0BXhSXDJKIClT2vmRDn8ZomYQXaWM+h534j38N9DJnKcCuaFge44FBu
         CE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=l85nBnlGEJZ7I0Tetme70BjmV9LBB9ZHP/7uw8NOMII=;
        b=aqbTDMBUtjv17RtLgcEQGXisKj0sgWFSu0cgQXt8aL2nRnHwGfGcod5UPXNfG9Wq1w
         Mi89nr1Ah0VtQm2li9nr/fim8Ve9iePiC1QNUBxfRSyKVzbLcXCQPf9w9wqaxRZf3ivs
         Kfhh/D9PeZ0jF6o2uK9V93+gee3WUcCQKyhynVVbTjdLyLIGc1QwY4LKIqTiV+VR4cZq
         gF5mQsPKP5dVjhcdpF8Oz6P9Y/oWHx60RkXALdwAiuJIAL5jceyF/+oOMXozYojxodNY
         rDFbw+BrWnnqmWv94i9xr+8Mh2Tow50tYCSBe4Q/Rs0FjhyuIQc9Iw8QcADR15iUDe7o
         jGkQ==
X-Gm-Message-State: ACgBeo3qMj/MauFWhcUhyRJ2zaNHa+1rVz8/t/g1PSVKGzriI8xU39Xf
        b/2x+zD59hOhhRM160ReKUeivF6SzIM=
X-Google-Smtp-Source: AA6agR4L9G9eRWF8K1flh+qihde/FSRmoKTJhC6cJkgytk0Tg0usaKf+FA1NH429qCj0RZcqawFSsA==
X-Received: by 2002:a05:600c:582:b0:3a5:4f7b:3146 with SMTP id o2-20020a05600c058200b003a54f7b3146mr2267162wmd.152.1662561476523;
        Wed, 07 Sep 2022 07:37:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b003a61306d79dsm22555320wmr.41.2022.09.07.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:37:55 -0700 (PDT)
Message-Id: <9daee95d434155742dbb19271eea8c0bc05eb365.1662561470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 14:37:46 +0000
Subject: [PATCH v2 3/7] rebase: store orig_head as a commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Using a struct commit rather than a struct oid to hold orig_head means
that we error out straight away if the branch being rebased does not
point to a commit. It also simplifies the code that handles finding
the merge base and fork point as it no longer has to convert from an
oid to a commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 61 +++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 56e4214b441..a3cf1ef5923 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -68,7 +68,7 @@ struct rebase_options {
 	const char *upstream_name;
 	const char *upstream_arg;
 	char *head_name;
-	struct object_id orig_head;
+	struct commit *orig_head;
 	struct commit *onto;
 	const char *onto_name;
 	const char *revisions;
@@ -261,13 +261,13 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	struct replay_opts replay = get_replay_opts(opts);
 	struct string_list commands = STRING_LIST_INIT_DUP;
 
-	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head,
+	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head->object.oid,
 				&revisions, &shortrevisions))
 		return -1;
 
 	if (init_basic_state(&replay,
 			     opts->head_name ? opts->head_name : "detached HEAD",
-			     opts->onto, &opts->orig_head)) {
+			     opts->onto, &opts->orig_head->object.oid)) {
 		free(revisions);
 		free(shortrevisions);
 
@@ -298,9 +298,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 		split_exec_commands(opts->cmd, &commands);
 		ret = complete_action(the_repository, &replay, flags,
 			shortrevisions, opts->onto_name, opts->onto,
-			&opts->orig_head, &commands, opts->autosquash,
-			opts->update_refs,
-			&todo_list);
+			&opts->orig_head->object.oid, &commands,
+			opts->autosquash, opts->update_refs, &todo_list);
 	}
 
 	string_list_clear(&commands, 0);
@@ -448,7 +447,8 @@ static int read_basic_state(struct rebase_options *opts)
 	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
 				  READ_ONELINER_WARN_MISSING))
 		return -1;
-	if (get_oid(buf.buf, &opts->orig_head))
+	opts->orig_head = lookup_commit_reference_by_name(buf.buf);
+	if (!opts->orig_head)
 		return error(_("invalid orig-head: '%s'"), buf.buf);
 
 	if (file_exists(state_dir_path("quiet", opts)))
@@ -517,7 +517,7 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 	write_file(state_dir_path("onto", opts), "%s",
 		   opts->onto ? oid_to_hex(&opts->onto->object.oid) : "");
 	write_file(state_dir_path("orig-head", opts), "%s",
-		   oid_to_hex(&opts->orig_head));
+		   oid_to_hex(&opts->orig_head->object.oid));
 	if (!(opts->flags & REBASE_NO_QUIET))
 		write_file(state_dir_path("quiet", opts), "%s", "");
 	if (opts->flags & REBASE_VERBOSE)
@@ -646,7 +646,7 @@ static int run_am(struct rebase_options *opts)
 			       /* this is now equivalent to !opts->upstream */
 			       &opts->onto->object.oid :
 			       &opts->upstream->object.oid),
-		    oid_to_hex(&opts->orig_head));
+		    oid_to_hex(&opts->orig_head->object.oid));
 
 	rebased_patches = xstrdup(git_path("rebased-patches"));
 	format_patch.out = open(rebased_patches,
@@ -680,7 +680,7 @@ static int run_am(struct rebase_options *opts)
 		free(rebased_patches);
 		strvec_clear(&am.args);
 
-		ropts.oid = &opts->orig_head;
+		ropts.oid = &opts->orig_head->object.oid;
 		ropts.branch = opts->head_name;
 		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
 		reset_head(the_repository, &ropts);
@@ -833,7 +833,7 @@ static int checkout_up_to_date(struct rebase_options *options)
 	strbuf_addf(&buf, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    options->switch_to);
-	ropts.oid = &options->orig_head;
+	ropts.oid = &options->orig_head->object.oid;
 	ropts.branch = options->head_name;
 	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	if (!ropts.branch)
@@ -866,15 +866,11 @@ static int is_linear_history(struct commit *from, struct commit *to)
 
 static int can_fast_forward(struct commit *onto, struct commit *upstream,
 			    struct commit *restrict_revision,
-			    struct object_id *head_oid, struct object_id *merge_base)
+			    struct commit *head, struct object_id *merge_base)
 {
-	struct commit *head = lookup_commit(the_repository, head_oid);
 	struct commit_list *merge_bases = NULL;
 	int res = 0;
 
-	if (!head)
-		goto done;
-
 	merge_bases = get_merge_bases(onto, head);
 	if (!merge_bases || merge_bases->next) {
 		oidcpy(merge_base, null_oid());
@@ -1312,13 +1308,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		if (read_basic_state(&options))
 			exit(1);
-		ropts.oid = &options.orig_head;
+		ropts.oid = &options.orig_head->object.oid;
 		ropts.branch = options.head_name;
 		ropts.flags = RESET_HEAD_HARD;
 		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
 		if (reset_head(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
-			    oid_to_hex(&options.orig_head));
+			    oid_to_hex(&options.orig_head->object.oid));
 		remove_branch_state(the_repository, 0);
 		ret = finish_rebase(&options);
 		goto cleanup;
@@ -1610,17 +1606,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		/* Is it a local branch? */
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "refs/heads/%s", branch_name);
-		if (!read_ref(buf.buf, &options.orig_head)) {
+		options.orig_head = lookup_commit_reference_by_name(buf.buf);
+		if (options.orig_head) {
 			die_if_checked_out(buf.buf, 1);
 			options.head_name = xstrdup(buf.buf);
 		/* If not is it a valid ref (branch or commit)? */
 		} else {
-			struct commit *commit =
+			options.orig_head =
 				lookup_commit_reference_by_name(branch_name);
-			if (!commit)
+			if (!options.orig_head)
 				die(_("no such branch/commit '%s'"),
 				    branch_name);
-			oidcpy(&options.orig_head, &commit->object.oid);
 			options.head_name = NULL;
 		}
 	} else if (argc == 0) {
@@ -1639,8 +1635,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			FREE_AND_NULL(options.head_name);
 			branch_name = "HEAD";
 		}
-		if (get_oid("HEAD", &options.orig_head))
-			die(_("Could not resolve HEAD to a revision"));
+		options.orig_head = lookup_commit_reference_by_name("HEAD");
+		if (!options.orig_head)
+			die(_("Could not resolve HEAD to a commit"));
 	} else
 		BUG("unexpected number of arguments left to parse");
 
@@ -1672,13 +1669,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				options.onto_name);
 	}
 
-	if (options.fork_point > 0) {
-		struct commit *head =
-			lookup_commit_reference(the_repository,
-						&options.orig_head);
+	if (options.fork_point > 0)
 		options.restrict_revision =
-			get_fork_point(options.upstream_name, head);
-	}
+			get_fork_point(options.upstream_name, options.orig_head);
 
 	if (repo_read_index(the_repository) < 0)
 		die(_("could not read index"));
@@ -1708,7 +1701,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * call it before checking allow_preemptive_ff.
 	 */
 	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
-		    &options.orig_head, &merge_base) &&
+		    options.orig_head, &merge_base) &&
 	    allow_preemptive_ff) {
 		int flag;
 
@@ -1785,7 +1778,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	ropts.oid = &options.onto->object.oid;
-	ropts.orig_head = &options.orig_head,
+	ropts.orig_head = &options.orig_head->object.oid,
 	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
@@ -1799,7 +1792,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * we just fast-forwarded.
 	 */
 	strbuf_reset(&msg);
-	if (oideq(&merge_base, &options.orig_head)) {
+	if (oideq(&merge_base, &options.orig_head->object.oid)) {
 		printf(_("Fast-forwarded %s to %s.\n"),
 			branch_name, options.onto_name);
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
@@ -1820,7 +1813,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		    (options.restrict_revision ?
 		     oid_to_hex(&options.restrict_revision->object.oid) :
 		     oid_to_hex(&options.upstream->object.oid)),
-		    oid_to_hex(&options.orig_head));
+		    oid_to_hex(&options.orig_head->object.oid));
 
 	options.revisions = revisions.buf;
 
-- 
gitgitgadget

