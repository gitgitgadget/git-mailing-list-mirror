Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32ADC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiJQNSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiJQNRy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:17:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EBD5F7E9
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f11so18408906wrm.6
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzkAdR/cmhQWP52wBCVOyaeBNaay//gaD99aQbZf56w=;
        b=GfnyYSDTT5W0PA+AdeF6Tzg7e5cVAA/nFQU6PMT212h68H7z7xft47dXk7PSniHkac
         94v28it+Sz3IgyAGlsfwrhyDXzGlI7FUzhE2AsIkZZW3zg+OxAAcznFVle4YMDb4nj58
         PEAeX6RI5oWvsmtq/PuvJUfOVWaiNOB1GAN765T3kImyS3e4Pa1F9W6kN2PJKfwQC7x5
         yL7kILlUpenfG9bqP61hBvWRU+qQnPfmAqBTKuPqJlDJa583dbB9tX+bkgnL4CXDLx3G
         rkZfRRY5PU/q/RURLVjmYUylH7vyJGqSC4RpNkwv5kPn2/ifrXr2eut6550eJPSTW9Xc
         BWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzkAdR/cmhQWP52wBCVOyaeBNaay//gaD99aQbZf56w=;
        b=3vyd6sRkP9F/+nMbFXV3ot72RU1LsyyjzdgCy+UNIipIVC9PGksJQCPzUN1PHp7W/s
         QS3UlLzCgRgUBswuoLOlNdTmO5fj9wFIinPLz2R5oLdccukI1BLGM47jH98gpeA+XCT9
         1iNn5rEh7+O6vB4UqjtgcPg3F7P09Eh9wDHQBus4om9mjzbctQfx/HAfX2RGi7jVYkHk
         qrVHXy/6AQgc1GqyhDRTJqcv2kyGoGb+zFkM1ck8oj61WeeEz7wKLk9Kjeg2w67voLkU
         PH0qyfd1xt7bRUMNsuyv4GK54CLvwNnW77dCzQ6DVbJIo56+Lsdq4KWMJwz0tCtZ0phF
         2ccg==
X-Gm-Message-State: ACrzQf3gwOIcAfMU76x3zQI/bGzWnJhlfvGnhaJjAcl9zyGavtKGLVeT
        GqD+qwGmNkHZvSJQo/P32WoupnQPPQk=
X-Google-Smtp-Source: AMsMyM5HCVaVxtOdRacs6KPZhXBcBB2BoST9eAS2S+V128vYp9ntzVcgv1QYr0typfw8ybuZcUM2mA==
X-Received: by 2002:a5d:5988:0:b0:22e:5a65:1e21 with SMTP id n8-20020a5d5988000000b0022e5a651e21mr6357887wri.338.1666012670249;
        Mon, 17 Oct 2022 06:17:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6a48000000b0022b11a27e39sm8382397wrw.1.2022.10.17.06.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:17:49 -0700 (PDT)
Message-Id: <22f3d265b57a7148d503a9eeddd19614f441824d.1666012665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
References: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 13:17:41 +0000
Subject: [PATCH v4 4/8] rebase: store orig_head as a commit
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
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

To avoid changing the behavior of "git rebase <upstream> <branch>" we
keep the existing call to read_ref() and use lookup_commit_object()
on the oid returned by that rather than calling
lookup_commit_reference_by_name() which applies the ref dwim rules to
its argument.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 67 ++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 06903eb6d4d..211e9139f2e 100644
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
-	if (get_oid_hex(buf.buf, &opts->orig_head))
+	if (get_oid_hex(buf.buf, &oid) ||
+	    !(opts->orig_head = lookup_commit_object(the_repository, &oid)))
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
@@ -1604,25 +1600,27 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 */
 	if (argc == 1) {
 		/* Is it "rebase other branchname" or "rebase other commit"? */
+		struct object_id branch_oid;
 		branch_name = argv[0];
 		options.switch_to = argv[0];
 
 		/* Is it a local branch? */
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "refs/heads/%s", branch_name);
-		if (!read_ref(buf.buf, &options.orig_head)) {
+		if (!read_ref(buf.buf, &branch_oid)) {
 			die_if_checked_out(buf.buf, 1);
 			options.head_name = xstrdup(buf.buf);
+			options.orig_head =
+				lookup_commit_object(the_repository,
+						     &branch_oid);
 		/* If not is it a valid ref (branch or commit)? */
 		} else {
-			struct commit *commit =
+			options.orig_head =
 				lookup_commit_reference_by_name(branch_name);
-			if (!commit)
-				die(_("no such branch/commit '%s'"),
-				    branch_name);
-			oidcpy(&options.orig_head, &commit->object.oid);
 			options.head_name = NULL;
 		}
+		if (!options.orig_head)
+			die(_("no such branch/commit '%s'"), branch_name);
 	} else if (argc == 0) {
 		/* Do not need to switch branches, we are already on it. */
 		options.head_name =
@@ -1639,8 +1637,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
 
@@ -1672,13 +1671,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1708,7 +1703,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * call it before checking allow_preemptive_ff.
 	 */
 	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
-		    &options.orig_head, &merge_base) &&
+		    options.orig_head, &merge_base) &&
 	    allow_preemptive_ff) {
 		int flag;
 
@@ -1785,7 +1780,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	ropts.oid = &options.onto->object.oid;
-	ropts.orig_head = &options.orig_head,
+	ropts.orig_head = &options.orig_head->object.oid,
 	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
@@ -1799,7 +1794,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * we just fast-forwarded.
 	 */
 	strbuf_reset(&msg);
-	if (oideq(&merge_base, &options.orig_head)) {
+	if (oideq(&merge_base, &options.orig_head->object.oid)) {
 		printf(_("Fast-forwarded %s to %s.\n"),
 			branch_name, options.onto_name);
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
@@ -1820,7 +1815,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		    (options.restrict_revision ?
 		     oid_to_hex(&options.restrict_revision->object.oid) :
 		     oid_to_hex(&options.upstream->object.oid)),
-		    oid_to_hex(&options.orig_head));
+		    oid_to_hex(&options.orig_head->object.oid));
 
 	options.revisions = revisions.buf;
 
-- 
gitgitgadget

