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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1868C4332E
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC13822B3B
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgLVAGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgLVAGE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:06:04 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56D0C0611CB
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:59 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id l7so9113808qth.15
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LUxw/hFdF9lowPah09S7Zj467fY7yAG7wcNTSHnpxaE=;
        b=pRsHALvO3OybA+4+vuCn/zpiQ5GxTueiRQqDWAXi2N01rZv5/c/FTOPqXIDoAzt5c1
         qSUVZj8HCdudtb0Ub43Xx+MUeORJTuwv95Xm/LS0cCRjHWjDdOUDoy7ILbrIX7idxXAG
         IDL1TlFedfyEBJJg6KFr2z4zpgtY+k/f0okBKXSc0Md3bS5TRd+q0GcV4eg3oprRFDaO
         Y27rSL2M5XOwZ8YWgRgcpjNpn8+UXYC16Qgdv68hygOcDn4B7yIvIVsdBlvj9JVWAk9n
         7BTTLHwHz8nQe6zli3KIGYuUNP2Wl8FMjlIRehDDiSyg25t71Qazr2t8mNeuOSc3xvxX
         BW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LUxw/hFdF9lowPah09S7Zj467fY7yAG7wcNTSHnpxaE=;
        b=cmWi1XYGP5eYqnq2spbeISvBNo1Ts9g+GpVFzDOmDp86X4SxVVZ8ALpIjNvb0gE6qz
         9LQav59P0T+ijGy6PkmlK4lgDGAAmqA3LEigmAaCLItWVeWZgQg2ZKFxWVxOtxjfpRRj
         ceG4cD2wO9EjrL9UWqzGqY3trWx+ZQOmUOIEAiNb7UAFfN3WXhQVcO1Q/i0byUdBZT8u
         HZ/AhtwGR4Gm6jCmqzK7kdzHFhI6uyJNt5oGbSXRBwxDbbNPgDVJHEqtCWuaNu0Qa8Rk
         4dT1XPC55i5SJMmG7sAtT2zVWLpFR2n326qyv3WjKSIGoIIobv6UnlbA1yPe4KRLk/MF
         yoYA==
X-Gm-Message-State: AOAM530kEetIOyr4kZUuuYto1OKBlXXx5EuBJdjL7VRpiLFd7bFKjmUn
        RCfNndd+x2LW3Z2UNXZrFQJlRQ0k9RrsdDSsq70u2LK6ok5BMFxqbIBkpfw3QqZGC3CHvTQUHIg
        Iv6/Ezt8EUZyv44olAAqcDvWWitmHkLHLN5SV2kdElMC014skZV8/ioLXSR9/MLUzgSKrA1+bgA
        ==
X-Google-Smtp-Source: ABdhPJz0uPhwxJX4GOY0vRaX3NEIoQmfi6Vqk27+CoCo9sKZwIr8gDhQ7hPm6miLGTOtcscNhg0Vr6nxJzDbGbjhk0k=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:8642:: with SMTP id
 p60mr17002905qva.6.1608595499088; Mon, 21 Dec 2020 16:04:59 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:27 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-10-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 09/17] hooks: convert 'post-checkout' hook to hook library
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
 builtin/checkout.c         | 16 +++++++++++-----
 builtin/clone.c            |  7 +++++--
 builtin/worktree.c         | 30 ++++++++++++++----------------
 reset.c                    | 15 +++++++++++----
 5 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 8de512ee5d..14035ef725 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -224,6 +224,8 @@ This hook can be used to perform repository validity checks, auto-display
 differences from the previous HEAD if different, or set working dir metadata
 properties.
 
+Hooks executed during 'post-checkout' will not be parallelized.
+
 post-merge
 ~~~~~~~~~~
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b82119129..20966452b8 100644
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
@@ -104,13 +105,18 @@ struct branch_info {
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	return run_hook_le(NULL, "post-checkout",
-			   oid_to_hex(old_commit ? &old_commit->object.oid : &null_oid),
-			   oid_to_hex(new_commit ? &new_commit->object.oid : &null_oid),
-			   changed ? "1" : "0", NULL);
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SYNC;
+	int rc;
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
index a0841923cf..307336e576 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -32,6 +32,7 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "hook.h"
 
 /*
  * Overall FIXMEs:
@@ -771,6 +772,7 @@ static int checkout(int submodule_progress)
 	struct tree *tree;
 	struct tree_desc t;
 	int err = 0;
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_SYNC;
 
 	if (option_no_checkout)
 		return 0;
@@ -816,8 +818,9 @@ static int checkout(int submodule_progress)
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
index 197fd24a55..9a87c4c120 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -12,6 +12,7 @@
 #include "submodule.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "hook.h"
 
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
@@ -455,22 +456,19 @@ static int add_worktree(const char *path, const char *refname,
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
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SYNC;
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
index 2f4fbd07c5..e6bfaf67e1 100644
--- a/reset.c
+++ b/reset.c
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "unpack-trees.h"
+#include "hook.h"
 
 int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	       const char *switch_to_branch, unsigned flags,
@@ -126,10 +127,16 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 			ret = create_symref("HEAD", switch_to_branch,
 					    reflog_head);
 	}
-	if (run_hook)
-		run_hook_le(NULL, "post-checkout",
-			    oid_to_hex(orig ? orig : &null_oid),
-			    oid_to_hex(oid), "1", NULL);
+	if (run_hook) {
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_SYNC;
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
2.28.0.rc0.142.g3c755180ce-goog

