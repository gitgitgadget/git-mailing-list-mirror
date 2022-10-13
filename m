Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCFEC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 08:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJMInH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJMIm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 04:42:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D78C14BB79
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso2752185wma.1
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pA+ksGgWHi9wkjUhFVrYzCvmnDpHFT71ffrPZEbDo/8=;
        b=R9CspTBJSetxDmVA4ED+lDSpft4+ol96ut+hPvCJYcfXee8GpT8ru2OUPnYMU1YBBv
         QtU28lMYgx8osQigJqsctV8mEg+87aziKl/egAJD79VolXAQXXOVv7Yo57MsNR6O/Z6m
         qig8Es/sF/qmlOEqmA1Cmlhbx3sNdQA5jYUY2WHNLfbQKzRRJJ4KHRI4uETzAzbBzISR
         u4W2+xWQRxXoc2u7B9tHI7RGIEpa2/3gS82MbLnS1xSBrit+f9/6ONF9LceAe5nVasmi
         0KBppatsFu0r5dImHeD8x7k2q/QP/ranj7zWlTlr/w49JqO69hov5DHiNNjaouLqHJxT
         aX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pA+ksGgWHi9wkjUhFVrYzCvmnDpHFT71ffrPZEbDo/8=;
        b=AAJiD5gRh3fJnE8p92EpCMSVJJ81iNG//X9REyRE5hDZj9oxNFE0tQwgvY980VZgjw
         419tXZ8sCSjqWDTFBFgajNRbUAWnCqNDsfZgRIWvZQE4Vr6R3iJjl8GqQkgOTSr4tJE9
         CJ5s+4NpMEVQNxUM6DxlQmoJ41MubfrDIp+E+cPZ0VmBMQez2lmGveBWDA4FBfMIyZcu
         vtef/FIvVjgZwpKZLAQfbdzEX5KPY+DizZr/JMftpYzCxai8xUBQCnnw6koNdgUrqwxa
         aXTPFiDgyJlYQlPRd11uipTetrgWN68+ho43wkO46qZW3qypK0sMeB7gYhkuZIuyqIaG
         RA1Q==
X-Gm-Message-State: ACrzQf0N0fZaub6eC0FBzP1bnFdtR6vUJjEeMCesSsUJA3Fz/tdT4CGT
        WR6vW0TOBINm78shS1MTsK40urSzuNk=
X-Google-Smtp-Source: AMsMyM5KruYXsxLedXkM+ydfXcF/B3q0BRPAUGp0oezIYF3Nsiwb2g7kErmNlkzBcHHLCdZYHwjp7w==
X-Received: by 2002:a05:600c:4194:b0:3c3:d0ed:2d44 with SMTP id p20-20020a05600c419400b003c3d0ed2d44mr5770535wmh.151.1665650573296;
        Thu, 13 Oct 2022 01:42:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c001100b003c6bbe910fdsm4581653wmc.9.2022.10.13.01.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:42:52 -0700 (PDT)
Message-Id: <dc056b13ed5c62729f97bd2cedbe769c531f4bc4.1665650564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 08:42:40 +0000
Subject: [PATCH v3 4/8] rebase: store orig_head as a commit
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

To avoid changing the behavior of "git rebase <upstream> <branch>" we
keep the existing call to read_ref() and use lookup_commit_reference()
on the oid returned by that rather than calling
lookup_commit_reference_by_name() which applies the ref dwim rules to
its argument. lookup_commit_reference() will dereference tag objects
but we do not expect the branch being rebased to be pointing to a tag
object.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 67 ++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 76f83a42f49..7e6ce374c59 100644
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
+	    !(opts->orig_head = lookup_commit_reference(the_repository, &oid)))
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
+				lookup_commit_reference(the_repository,
+							&branch_oid);
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

