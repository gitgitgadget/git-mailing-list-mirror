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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DC0C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4035F64FAA
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCKCMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCKCLi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:38 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0E4C061762
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:37 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id o7so14419094qtw.7
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bnq0SMExdgj7ERjG7VLd2BP1kiGs0pvkvTHdIxv+kaE=;
        b=HoAtqWZWb8Gg/NS5WW/UxdtqamIcVebB1Ouf23Lo2zl3uEZ53ERtsoQW/xF43tVk/u
         tppt0S6Xqv+BiOiP1MWQIT2N9cgC3zfEUqvG+YFoIWKaPVrH6JPTeKiuwlqvI0FzAOkA
         dC09PyNM+DjlqgTlA+M1Rcxm3sL/MiiXvlDhTbVekfXoFI7/cXkBChRRGNVezsDveXg6
         AW+CLykWMCkJ6Z5XH9Y7ErHTo/OS8G2B+0uT8OxQxgMiMSOpDjKe+PXgHXSh9cer15k7
         sJImq/W+wAMPDmo3SqdRY7CDZr2hPN76kZQW/0fYVAZV26UDYB9+NI5lHw6a4J5SyDed
         KFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bnq0SMExdgj7ERjG7VLd2BP1kiGs0pvkvTHdIxv+kaE=;
        b=M4WmNKgW8YikiX1515GwpLzVvb3NcZTexOabNvw7LZhZS7N36hL31vran484B12Mtm
         0I8U27qBchnCe2aQ8dgZ5mVkSLFjfyCsPAKe730shHETaAEvKDvFu+XWPrzbzelGTxIV
         qXwEeIFLFSutccuMsKK7t/QLa8/3Zr7F+KWJAloGD7hO7H/7hJ7KHr4NBRY8WUtbhIrV
         tJud36MCRpR7sHXJwgdLJt/9KrS47l9WLYI+qtes7xyBPhaQ1zSNYXw9kMk7XH3bc1gW
         L2n8AeZlfDnezCJzSFtUFbQxC5obpUWofZVFFkBZeByW+m7GvnLHxRJ+7eEMj+JsxKF3
         GZnQ==
X-Gm-Message-State: AOAM531CHPiAEC9A8iYZYI8gwy8+PBUuJIGzVsKX4sYxPncGj+Z/gqS2
        yzflDLU9BIzEo5bQH8eMc6nwQoQxzpExRhk0Vnd37M/vwT735rNtg+XUaa976Y7gVilAOf9xvcC
        NuGLa9Xx6pGI0BtbfeVF6qJ1pKzMoo6O7ER84oD4vzDBc4C1NUjDwIZOMRkkKH0NurHoXfUzY/A
        ==
X-Google-Smtp-Source: ABdhPJwh9ws8WNEdoYLlZE5iSBg3HGpqVE1CluthIKNwdEadHUxrwt06hARZt5Unl5a8skf9Y2/GpoOeBQvMTvD1xag=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:262a:: with SMTP id
 gv10mr6016177qvb.50.1615428697038; Wed, 10 Mar 2021 18:11:37 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:26 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-27-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 26/37] hooks: convert 'post-checkout' hook to hook library
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using the 'hook.h' library, 'post-checkout' hooks can now be
specified in the config as well as in the hook directory.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  2 ++
 builtin/checkout.c         | 19 ++++++++++++++-----
 builtin/clone.c            |  8 ++++++--
 builtin/worktree.c         | 31 +++++++++++++++----------------
 reset.c                    | 16 ++++++++++++----
 5 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index f2178dbc83..362224a03b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -231,6 +231,8 @@ This hook can be used to perform repository validity checks, auto-display
 differences from the previous HEAD if different, or set working dir metadata
 properties.
 
+Hooks executed during 'post-checkout' will not be parallelized.
+
 post-merge
 ~~~~~~~~~~
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d6550bc3c..f287b5e643 100644
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
@@ -104,13 +105,21 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	return run_hook_le(NULL, "post-checkout",
-			   oid_to_hex(old_commit ? &old_commit->object.oid : &null_oid),
-			   oid_to_hex(new_commit ? &new_commit->object.oid : &null_oid),
-			   changed ? "1" : "0", NULL);
+	struct run_hooks_opt opt;
+	int rc;
+
+	run_hooks_opt_init_sync(&opt);
+
 	/* "new_commit" can be NULL when checking out from the index before
 	   a commit exists. */
-
+	strvec_pushl(&opt.args,
+		     oid_to_hex(old_commit ? &old_commit->object.oid : &null_oid),
+		     oid_to_hex(new_commit ? &new_commit->object.oid : &null_oid),
+		     changed ? "1" : "0",
+		     NULL);
+	rc = run_hooks("post-checkout", &opt);
+	run_hooks_opt_clear(&opt);
+	return rc;
 }
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
diff --git a/builtin/clone.c b/builtin/clone.c
index 51e844a2de..52f2a5ecb4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -32,6 +32,7 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "hook.h"
 
 /*
  * Overall FIXMEs:
@@ -771,6 +772,8 @@ static int checkout(int submodule_progress)
 	struct tree *tree;
 	struct tree_desc t;
 	int err = 0;
+	struct run_hooks_opt hook_opt;
+	run_hooks_opt_init_sync(&hook_opt);
 
 	if (option_no_checkout)
 		return 0;
@@ -816,8 +819,9 @@ static int checkout(int submodule_progress)
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
-			   oid_to_hex(&oid), "1", NULL);
+	strvec_pushl(&hook_opt.args, oid_to_hex(&null_oid), oid_to_hex(&oid), "1", NULL);
+	err |= run_hooks("post-checkout", &hook_opt);
+	run_hooks_opt_clear(&hook_opt);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
 		struct strvec args = STRVEC_INIT;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1cd5c2016e..8b06d121e5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "worktree.h"
 #include "quote.h"
+#include "hook.h"
 
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
@@ -383,22 +384,20 @@ static int add_worktree(const char *path, const char *refname,
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
-				     oid_to_hex(&null_oid),
-				     oid_to_hex(&commit->object.oid),
-				     "1", NULL);
-			ret = run_command(&cp);
-		}
+		struct run_hooks_opt opt;
+		run_hooks_opt_init_sync(&opt);
+
+		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
+		strvec_pushl(&opt.args,
+			     oid_to_hex(&null_oid),
+			     oid_to_hex(&commit->object.oid),
+			     "1",
+			     NULL);
+		opt.dir = path;
+
+		ret = run_hooks("post-checkout", &opt);
+
+		run_hooks_opt_clear(&opt);
 	}
 
 	strvec_clear(&child_env);
diff --git a/reset.c b/reset.c
index 2f4fbd07c5..85ee75f7fd 100644
--- a/reset.c
+++ b/reset.c
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "unpack-trees.h"
+#include "hook.h"
 
 int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	       const char *switch_to_branch, unsigned flags,
@@ -126,10 +127,17 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 			ret = create_symref("HEAD", switch_to_branch,
 					    reflog_head);
 	}
-	if (run_hook)
-		run_hook_le(NULL, "post-checkout",
-			    oid_to_hex(orig ? orig : &null_oid),
-			    oid_to_hex(oid), "1", NULL);
+	if (run_hook) {
+		struct run_hooks_opt opt;
+		run_hooks_opt_init_sync(&opt);
+		strvec_pushl(&opt.args,
+			     oid_to_hex(orig ? orig : &null_oid),
+			     oid_to_hex(oid),
+			     "1",
+			     NULL);
+		run_hooks("post-checkout", &opt);
+		run_hooks_opt_clear(&opt);
+	}
 
 leave_reset_head:
 	strbuf_release(&msg);
-- 
2.31.0.rc2.261.g7f71774620-goog

