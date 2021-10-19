Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA06C433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6467E611AE
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhJSXXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhJSXXs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB3C06176C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v127so15001407wme.5
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dk5pGnSUY1FOn3/9emytqR/3W1eZZ3vXxGhteSQxGMY=;
        b=ZHAzLPaWA4LJQr9QeWy1FTVok99191U4Se165NJfaBcnf0EhQShP7OdjsB+0Fe6RI+
         ycvUo1ZmNGGLZZcVGc1CA4waHfcDdYIdGOCbZH1uiZdagj8Rfh8DmS6W4pStFceu2lW0
         6FbnG4E2S9xtiP0oP8+JTJg6y27X/SAvlssN95jo8pzjk28rBrR6zzB5x4I2x+YwnkQ+
         numW9bvTQiXSFOycTzin+ScChZTJD96nSbvbyrK2Bdy4z9q04BRpuzpt1D+gi/wirDd+
         wlYxGi2jR84OEM2WmZPiVCsvjmc9021N5WdcbJidfCWtmqSr/UQ/Pi1TtAkoFKhx7d3o
         Tmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dk5pGnSUY1FOn3/9emytqR/3W1eZZ3vXxGhteSQxGMY=;
        b=r4/chTUYvHnzRGvSD8dZ61xohX79bNHJZIznf+E6dBzHETe9XvK7qfHB5WDP1LBYNq
         x+49ofzlZcj6Wd4lcNsJ/JEEMQK3tS/nOI0VWoRjRiFTEEhqDm1zfVC1nbLKDbUrL2sN
         NsM1EnwXTceiQbfK8FtM2BpeNeE/ratbGH51S3F+7Ze4ph15XHsh7OME9InlTtAiPxYU
         QjbVJLTR4JWUW+tkHkDzSPa/ItqeVn6LEIKV2f85JHQqOJN9qC1GBLU+2NPmTylyxgtR
         vZRpx/ZpDQ8rUg8zjsviPpYxDwinPP752MzyrJCNQy10jtUkeeLaVKzPFfVTUN/omsmd
         4ONg==
X-Gm-Message-State: AOAM5329c2RDEpJRa/nuh5deayNYqmvMEewAZCfVuSKHIXY+Nz47cDZi
        evfSaXLFXafL2mmrZggYBVKPpkJw9kfeOQ==
X-Google-Smtp-Source: ABdhPJym6BaLhyeKV5sd7op8z5TcU1PBXBmh5gAFMGlHAdf2EyTmODgprEINmep0pVo0peWariA0CA==
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr9432398wmg.14.1634685693005;
        Tue, 19 Oct 2021 16:21:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/13] hooks: convert 'post-checkout' hook to hook library
Date:   Wed, 20 Oct 2021 01:20:43 +0200
Message-Id: <patch-v3-05.13-2a747a65829-20211019T231647Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the running of the 'post-checkout' hook away from run-command.h
to the new hook.h library. For "worktree" this requires a change to it
to run the hooks from a given directory.

We could strictly speaking skip the "absolute_path" flag and just
check if "dir" is specified, but let's split them up for clarity, as
well as for any future user who'd like to set "dir" but not implicitly
change the argument to an absolute path.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c | 14 +++++++++-----
 builtin/clone.c    |  7 +++++--
 builtin/worktree.c | 28 ++++++++++++----------------
 hook.c             | 12 +++++++++++-
 hook.h             |  9 +++++++++
 reset.c            | 14 ++++++++++----
 6 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cbf73b8c9f6..54cbba821a8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "diff.h"
 #include "dir.h"
+#include "hook.h"
 #include "ll-merge.h"
 #include "lockfile.h"
 #include "merge-recursive.h"
@@ -106,13 +107,16 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	return run_hook_le(NULL, "post-checkout",
-			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
-			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
-			   changed ? "1" : "0", NULL);
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
-
+	strvec_pushl(&opt.args,
+		     oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
+		     oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
+		     changed ? "1" : "0",
+		     NULL);
+	return run_hooks_oneshot("post-checkout", &opt);
 }
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
diff --git a/builtin/clone.c b/builtin/clone.c
index 559acf9e036..53ca5ca0eb2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -32,6 +32,7 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "hook.h"
 
 /*
  * Overall FIXMEs:
@@ -659,6 +660,7 @@ static int checkout(int submodule_progress)
 	struct tree *tree;
 	struct tree_desc t;
 	int err = 0;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
 	if (option_no_checkout)
 		return 0;
@@ -705,8 +707,9 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(null_oid()),
-			   oid_to_hex(&oid), "1", NULL);
+	strvec_pushl(&hook_opt.args, oid_to_hex(null_oid()), oid_to_hex(&oid),
+		     "1", NULL);
+	err |= run_hooks_oneshot("post-checkout", &hook_opt);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
 		struct strvec args = STRVEC_INIT;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d22ece93e1a..330867c19bf 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -382,22 +382,18 @@ static int add_worktree(const char *path, const char *refname,
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
 	if (!ret && opts->checkout) {
-		const char *hook = find_hook("post-checkout");
-		if (hook) {
-			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
-			cp.git_cmd = 0;
-			cp.no_stdin = 1;
-			cp.stdout_to_stderr = 1;
-			cp.dir = path;
-			cp.env = env;
-			cp.argv = NULL;
-			cp.trace2_hook_name = "post-checkout";
-			strvec_pushl(&cp.args, absolute_path(hook),
-				     oid_to_hex(null_oid()),
-				     oid_to_hex(&commit->object.oid),
-				     "1", NULL);
-			ret = run_command(&cp);
-		}
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
+		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
+		strvec_pushl(&opt.args,
+			     oid_to_hex(null_oid()),
+			     oid_to_hex(&commit->object.oid),
+			     "1",
+			     NULL);
+		opt.dir = path;
+		opt.absolute_path = 1;
+
+		ret = run_hooks_oneshot("post-checkout", &opt);
 	}
 
 	strvec_clear(&child_env);
diff --git a/hook.c b/hook.c
index 9951015dc66..bf34cd0a2c1 100644
--- a/hook.c
+++ b/hook.c
@@ -63,6 +63,7 @@ static int pick_next_hook(struct child_process *cp,
 	cp->env = hook_cb->options->env.v;
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
+	cp->dir = hook_cb->options->dir;
 
 	strvec_push(&cp->args, hook_path);
 	strvec_pushv(&cp->args, hook_cb->options->args.v);
@@ -110,10 +111,10 @@ static int notify_hook_finished(int result,
 int run_hooks(const char *hook_name, const char *hook_path,
 	      struct run_hooks_opt *options)
 {
+	struct strbuf abs_path = STRBUF_INIT;
 	struct hook_cb_data cb_data = {
 		.rc = 0,
 		.hook_name = hook_name,
-		.hook_path = hook_path,
 		.options = options,
 	};
 	int jobs = 1;
@@ -121,6 +122,12 @@ int run_hooks(const char *hook_name, const char *hook_path,
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if (options->absolute_path) {
+		strbuf_add_absolute_path(&abs_path, hook_path);
+		hook_path = abs_path.buf;
+	}
+	cb_data.hook_path = hook_path;
+
 	run_processes_parallel_tr2(jobs,
 				   pick_next_hook,
 				   notify_start_failure,
@@ -129,6 +136,9 @@ int run_hooks(const char *hook_name, const char *hook_path,
 				   "hook",
 				   hook_name);
 
+	if (options->absolute_path)
+		strbuf_release(&abs_path);
+
 	return cb_data.rc;
 }
 
diff --git a/hook.h b/hook.h
index 9e4d10df63e..252a605b125 100644
--- a/hook.h
+++ b/hook.h
@@ -9,6 +9,15 @@ struct run_hooks_opt
 
 	/* Args to be passed to each hook */
 	struct strvec args;
+
+	/*
+	 * Resolve and run the "absolute_path(hook)" instead of
+	 * "hook". Used for "git worktree" hooks
+	 */
+	int absolute_path;
+
+	/* Path to initial working directory for subprocess */
+	const char *dir;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
diff --git a/reset.c b/reset.c
index f214df3d96c..4234dd345db 100644
--- a/reset.c
+++ b/reset.c
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "unpack-trees.h"
+#include "hook.h"
 
 int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	       const char *switch_to_branch, unsigned flags,
@@ -126,10 +127,15 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 			ret = create_symref("HEAD", switch_to_branch,
 					    reflog_head);
 	}
-	if (run_hook)
-		run_hook_le(NULL, "post-checkout",
-			    oid_to_hex(orig ? orig : null_oid()),
-			    oid_to_hex(oid), "1", NULL);
+	if (run_hook) {
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+		strvec_pushl(&opt.args,
+			     oid_to_hex(orig ? orig : null_oid()),
+			     oid_to_hex(oid),
+			     "1",
+			     NULL);
+		run_hooks_oneshot("post-checkout", &opt);
+	}
 
 leave_reset_head:
 	strbuf_release(&msg);
-- 
2.33.1.1338.g20da966911a

