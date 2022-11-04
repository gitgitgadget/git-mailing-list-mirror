Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32936C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 15:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiKDPTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 11:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiKDPTH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 11:19:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD971B2F
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 08:19:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y16so7474700wrt.12
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gzxdgIH0WLqNXTnksfq+5rIdt0RIEu8MlTsqcI6TIg=;
        b=HwUDb0sQWNB8HTHgmNJNQMxs15ocR1eaB6olgPwFd4Lj+YpIM0GBIPevMAAyeb7HX0
         RQfWRTBMOPPmNoRJf7YjgNmi+1dzc2r63V1MEMNPAhxOZLX2j3s5STzDZ1mMcYA4spdR
         st1Ei3L+NVxIwonRiPF88ioH1wfhr53By4+lurhPs7EM/LB1koPgmbSUETjUodoGgxmn
         33YbIofrDnbW0c7ezxois6G4O6DiC9ACTux2R/QzQsM07L5oEEb6AIRuF59Bl46q4MP1
         CmTUzTwlkxtyYnwRm977oaAcOrVJd12p2MCGlgGxcvhviJZNJttKfLm4Jg8FQFL9bxgR
         D7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gzxdgIH0WLqNXTnksfq+5rIdt0RIEu8MlTsqcI6TIg=;
        b=zEHxLxLUMOcpnTzc+aFZb2fBQLc6HhfoHcJdtrL2qG5tlCK4A+qd60gQ3n4IY3my69
         ewDdjcSOHzSIpVsu5Tn80RhQ1BDNTUzoS9H2A1775A+lPngFW1PrLWF+t2JjzpzDspLi
         EXz2lB1FkVIXsJjNBW3Z2nX+4SbI0t4x01v6eYY/5nyyNxXRhg7VqewHxFYxcZl1J+Az
         BQ4nksh5VBmYbakqPtjd86kqei6F4/856/kAs3OWcqT+MC0HdNe5kERND9yOq1inh+Xm
         IFDNGaSMehl+QFXqi38eAI2KUFu5vIOWBAuexGE+/8U9iERQlvAyloZUXx0UyRkY3k9d
         +gtA==
X-Gm-Message-State: ACrzQf2uFirYWNOyCjL4DCJoARKTJnHM6nzrYDBfqUwYxJ6Dx7lXMOhi
        JQGwCjMNqzA2QP1Kv/5qa+hXck9RoI8=
X-Google-Smtp-Source: AMsMyM6iwI/Nu3o7Kyf3KONtzi9/nq8/iFHquvG5+QvdLuGLOGfgR+trXJH+9FIVUgFWNjTB7cHQBw==
X-Received: by 2002:adf:e704:0:b0:23a:1e9a:c554 with SMTP id c4-20020adfe704000000b0023a1e9ac554mr3333565wrm.167.1667575145020;
        Fri, 04 Nov 2022 08:19:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003b4ff30e566sm12119659wmq.3.2022.11.04.08.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:19:04 -0700 (PDT)
Message-Id: <d3747bcc8d138192592727a3e63b2ccede8b9fc5.1667575142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Nov 2022 15:19:02 +0000
Subject: [PATCH 2/2] rebase: stop exporting GIT_REFLOG_ACTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that struct replay_opts has a reflog_action member we no longer
need to export GIT_REFLOG_ACTION when starting a rebase. If the user
has set GIT_REFLOG_ACTION then we use it when initializing
reflog_action.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5d855fd8f51..4d6839a5785 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -30,8 +30,6 @@
 #include "reset.h"
 #include "hook.h"
 
-#define DEFAULT_REFLOG_ACTION "rebase"
-
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] "
 		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
@@ -106,6 +104,7 @@ struct rebase_options {
 	} flags;
 	struct strvec git_am_opts;
 	enum action action;
+	char *reflog_action;
 	int signoff;
 	int allow_rerere_autoupdate;
 	int keep_empty;
@@ -159,6 +158,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 					opts->committer_date_is_author_date;
 	replay.ignore_date = opts->ignore_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
+	replay.reflog_action = xstrdup(opts->reflog_action);
 	if (opts->strategy)
 		replay.strategy = xstrdup_or_null(opts->strategy);
 	else if (!replay.strategy && replay.default_strategy) {
@@ -585,10 +585,10 @@ static int move_to_original_branch(struct rebase_options *opts)
 		BUG("move_to_original_branch without onto");
 
 	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
-		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
+		    opts->reflog_action,
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
 	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
-		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
+		    opts->reflog_action, opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_HEAD_REFS_ONLY;
 	ropts.branch_msg = branch_reflog.buf;
@@ -618,7 +618,7 @@ static int run_am(struct rebase_options *opts)
 	am.git_cmd = 1;
 	strvec_push(&am.args, "am");
 	strvec_pushf(&am.env, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
-		     getenv(GIT_REFLOG_ACTION_ENVIRONMENT));
+		     opts->reflog_action);
 	if (opts->action == ACTION_CONTINUE) {
 		strvec_push(&am.args, "--resolved");
 		strvec_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -685,7 +685,7 @@ static int run_am(struct rebase_options *opts)
 
 		ropts.oid = &opts->orig_head->object.oid;
 		ropts.branch = opts->head_name;
-		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
+		ropts.default_reflog_action = opts->reflog_action;
 		reset_head(the_repository, &ropts);
 		error(_("\ngit encountered an error while preparing the "
 			"patches to replay\n"
@@ -834,8 +834,7 @@ static int checkout_up_to_date(struct rebase_options *options)
 	int ret = 0;
 
 	strbuf_addf(&buf, "%s: checkout %s",
-		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
-		    options->switch_to);
+		    options->reflog_action, options->switch_to);
 	ropts.oid = &options->orig_head->object.oid;
 	ropts.branch = options->head_name;
 	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
@@ -1243,7 +1242,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.action != ACTION_NONE && !in_progress)
 		die(_("No rebase in progress?"));
-	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
 
 	if (options.action == ACTION_EDIT_TODO && !is_merge(&options))
 		die(_("The --edit-todo action can only be used during "
@@ -1258,6 +1256,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			trace2_cmd_mode(action_names[options.action]);
 	}
 
+	options.reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
+	options.reflog_action =
+		xstrdup(options.reflog_action ? options.reflog_action : "rebase");
+
 	switch (options.action) {
 	case ACTION_CONTINUE: {
 		struct object_id head;
@@ -1310,7 +1312,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			exit(1);
 
 		strbuf_addf(&head_msg, "%s (abort): returning to %s",
-			    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
+			    options.reflog_action,
 			    options.head_name ? options.head_name
 					      : oid_to_hex(&options.orig_head->object.oid));
 		ropts.oid = &options.orig_head->object.oid;
@@ -1786,13 +1788,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 "it...\n"));
 
 	strbuf_addf(&msg, "%s (start): checkout %s",
-		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
+		    options.reflog_action, options.onto_name);
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head->object.oid,
 	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
-	ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
+	ropts.default_reflog_action = options.reflog_action;
 	if (reset_head(the_repository, &ropts))
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
@@ -1824,6 +1826,7 @@ run_rebase:
 cleanup:
 	strbuf_release(&buf);
 	strbuf_release(&revisions);
+	free(options.reflog_action);
 	free(options.head_name);
 	free(options.gpg_sign_opt);
 	free(options.cmd);
-- 
gitgitgadget
