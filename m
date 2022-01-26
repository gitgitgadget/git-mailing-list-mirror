Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FDEC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiAZNGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiAZNF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:05:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C496DC061749
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a13so25686226wrh.9
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0i+OqEyIp2gUhDcYmneCi2OS4t/v4DnKLlcRCSms98Y=;
        b=ioR+vKuAmNrsdAvKTHVO4YM98kNRom22FzluLounKt+3NH8hrWVEFZm3Uxg/ih+Tn9
         c9gYcNC8e+kyWEiqPbJFir+XvhRfsBiTXNsAN/+UGUs1Y04FXW/0pTzc6lFZ2qctwnvf
         cUbqbb+1+/8vKwOAEX5Gn8I5WAEB+iU8Lk9gV0jbyj0Yqt0tljkZp6m+NcRrHM+s+sUv
         /7wyxdszhJGJ26gIES9ZdkPhE0JW3iS4zJERw8gyIyoonv+mktuOZEGmLtfIrR26dECC
         AL29XwySEtwxC2uPDv/roaRY+6xM4AglOgl/I91CrAzQkHeHOSPhu3zEqA53ZCGSwxtD
         7HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0i+OqEyIp2gUhDcYmneCi2OS4t/v4DnKLlcRCSms98Y=;
        b=KBNEDHSgx+BkTW/HES9h45fvRTfyYbz563lOayCGV3mFZnFUPsIHLRWoJ2f3SJiX5D
         bCj+eDlokfha0K5e942f2f5Z5zP8woEwf5KROwSts+b35ks9TlJrUj/H5xpfTnO5CqdP
         LlUGST67I7Bhh6QGb0XZtlqlos5MlXL4Ix9iZSl4JSH5CFZVIQTZjIJPlxgC0G245F2R
         E3axHlCFuPKJXpZiRVjqTjH17LuXh7wBmcQMLbx9cQC3D5d8qkKENnO+uvvldZqjuJb9
         F1wHjYttSdmSEliVoGYV/KvhpjVcPyBiOd+zNVLCvHChnvRwD6pcW5Es4awW65y+uukN
         s1hw==
X-Gm-Message-State: AOAM532gvWYS1gHQUAZ76MA8qnzB6yoN/8s+T7wi9DtRYhw597vwbxQX
        ECjW/I8y4PfHF7l3bCHQ/ax+tnFH/GU=
X-Google-Smtp-Source: ABdhPJxQ1XZVEnusN/tu9A+oUMxIdrY/2dojvqNxpKRGkE/qpRFC7TBoel4Qjt9hxQTo1aUS56tlZQ==
X-Received: by 2002:a5d:6e83:: with SMTP id k3mr22126460wrz.506.1643202356249;
        Wed, 26 Jan 2022 05:05:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10sm3174452wmc.44.2022.01.26.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:05:55 -0800 (PST)
Message-Id: <ff23498e93eab5cc1d9f040aedb45c54025d0b62.1643202349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 13:05:41 +0000
Subject: [PATCH v3 06/14] reset_head(): remove action parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The only use of the action parameter is to setup the error messages
for unpack_trees(). All but two cases pass either "checkout" or
"reset". The case that passes "reset --hard" would be better passing
"reset" so that the error messages match the builtin reset command
like all the other callers that are doing a reset. The case that
passes "Fast-forwarded" is only updating HEAD and so the parameter is
unused in that case as it does not call unpack_trees(). The value to
pass to setup_unpack_trees_porcelain() can be determined by checking
whether flags contains RESET_HEAD_HARD without the caller having to
specify it.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 14 +++++++-------
 reset.c          |  5 +++--
 reset.h          |  2 +-
 sequencer.c      |  3 +--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index f5c37b7d4a5..2e5a535b54e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -583,7 +583,7 @@ static int move_to_original_branch(struct rebase_options *opts)
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
 	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
 		    opts->head_name);
-	ret = reset_head(the_repository, NULL, "", opts->head_name,
+	ret = reset_head(the_repository, NULL, opts->head_name,
 			 RESET_HEAD_REFS_ONLY,
 			 orig_head_reflog.buf, head_reflog.buf,
 			 DEFAULT_REFLOG_ACTION);
@@ -674,7 +674,7 @@ static int run_am(struct rebase_options *opts)
 		free(rebased_patches);
 		strvec_clear(&am.args);
 
-		reset_head(the_repository, &opts->orig_head, "checkout",
+		reset_head(the_repository, &opts->orig_head,
 			   opts->head_name, 0,
 			   "HEAD", NULL, DEFAULT_REFLOG_ACTION);
 		error(_("\ngit encountered an error while preparing the "
@@ -820,7 +820,7 @@ static int checkout_up_to_date(struct rebase_options *options)
 	strbuf_addf(&buf, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    options->switch_to);
-	if (reset_head(the_repository, &options->orig_head, "checkout",
+	if (reset_head(the_repository, &options->orig_head,
 		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		       NULL, buf.buf, DEFAULT_REFLOG_ACTION) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
@@ -1272,7 +1272,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 
-		if (reset_head(the_repository, NULL, "reset", NULL, RESET_HEAD_HARD,
+		if (reset_head(the_repository, NULL, NULL, RESET_HEAD_HARD,
 			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
@@ -1290,7 +1290,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		if (read_basic_state(&options))
 			exit(1);
-		if (reset_head(the_repository, &options.orig_head, "reset",
+		if (reset_head(the_repository, &options.orig_head,
 			       options.head_name, RESET_HEAD_HARD,
 			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
 			die(_("could not move back to %s"),
@@ -1759,7 +1759,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
-	if (reset_head(the_repository, &options.onto->object.oid, "checkout", NULL,
+	if (reset_head(the_repository, &options.onto->object.oid, NULL,
 		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		       NULL, msg.buf, DEFAULT_REFLOG_ACTION))
@@ -1777,7 +1777,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
-		reset_head(the_repository, NULL, "Fast-forwarded", options.head_name,
+		reset_head(the_repository, NULL, options.head_name,
 			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf,
 			   DEFAULT_REFLOG_ACTION);
 		strbuf_release(&msg);
diff --git a/reset.c b/reset.c
index 3537de91f65..7841b2b2a02 100644
--- a/reset.c
+++ b/reset.c
@@ -8,7 +8,7 @@
 #include "tree.h"
 #include "unpack-trees.h"
 
-int reset_head(struct repository *r, struct object_id *oid, const char *action,
+int reset_head(struct repository *r, struct object_id *oid,
 	       const char *switch_to_branch, unsigned flags,
 	       const char *reflog_orig_head, const char *reflog_head,
 	       const char *default_reflog_action)
@@ -23,7 +23,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	struct lock_file lock = LOCK_INIT;
 	struct unpack_trees_options unpack_tree_opts = { 0 };
 	struct tree *tree;
-	const char *reflog_action;
+	const char *action, *reflog_action;
 	struct strbuf msg = STRBUF_INIT;
 	size_t prefix_len;
 	struct object_id *old_orig = NULL, oid_old_orig;
@@ -50,6 +50,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	if (refs_only)
 		goto reset_head_refs;
 
+	action = reset_hard ? "reset" : "checkout";
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
 	unpack_tree_opts.head_idx = 1;
 	unpack_tree_opts.src_index = r->index;
diff --git a/reset.h b/reset.h
index 12f83c78e28..2daec804259 100644
--- a/reset.h
+++ b/reset.h
@@ -12,7 +12,7 @@
 #define RESET_HEAD_REFS_ONLY (1<<3)
 #define RESET_ORIG_HEAD (1<<4)
 
-int reset_head(struct repository *r, struct object_id *oid, const char *action,
+int reset_head(struct repository *r, struct object_id *oid,
 	       const char *switch_to_branch, unsigned flags,
 	       const char *reflog_orig_head, const char *reflog_head,
 	       const char *default_reflog_action);
diff --git a/sequencer.c b/sequencer.c
index ea96837cde3..3d3c3fbe305 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4131,8 +4131,7 @@ void create_autostash(struct repository *r, const char *path,
 			    path);
 		write_file(path, "%s", oid_to_hex(&oid));
 		printf(_("Created autostash: %s\n"), buf.buf);
-		if (reset_head(r, NULL, "reset --hard",
-			       NULL, RESET_HEAD_HARD, NULL, NULL,
+		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
 			       default_reflog_action) < 0)
 			die(_("could not reset --hard"));
 
-- 
gitgitgadget

