Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6861898EE
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540413; cv=none; b=syDgNEIpRCapI3SWDwnQwYDLwpC7NweKQ9VVbHId47Od/WJtxweYyXZvSXfAXQ1FYXVHtzC2fzYeNGoFITm90KRC/ZUS1pVjAAgFMNvSasKeRfur+bK5P6v8JQbK0ZIJ6vsT4+nweG9DultdYVEhVOKp8AHCKm1nCB6P3gh3gws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540413; c=relaxed/simple;
	bh=Z7NOGPlpGlk8jjBh8hdy+Yoq8QAM3PZIEPHTebMPUEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhcm2DFgt35lt3uUo/8AmmofdlrolCmOnrdSKBcAFvy6Mb97x69vqloGG4KUit0WW55zqAcTXs3rENMlnVPlOC5ghyA8lqkgY/KZz0xBgZqHaNssTzgeukUmvo22ZcwUk7gdmW7Vok9QSeGnZP4M6FDHl0ztWOf+ZFhlxZDavWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AE0iR7Cm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FNUNS28V; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AE0iR7Cm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FNUNS28V"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BD2A411519E2;
	Tue, 13 Aug 2024 05:13:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Aug 2024 05:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540410; x=1723626810; bh=TQpjw3XRiE
	MZyOn9PtkKhYY8rRMuySL43EOD6sMe1XQ=; b=AE0iR7CmmeX4fEb9fZ2W7Ia+pg
	LDMPEfH57vvLMr2WAAsuTi9DuliT7q6f0LYsm+0lYb2W1yqHBQccZWr1GXMD/msG
	cKJpgBZ4XRceOIhbSy9nfu5yhtrBHntThl8ESv0JmdB837JqoA6Fc4AFWlFhldUs
	TiJYAQ+m+hFdNQrahDk/ceLCB6t36eQOC2VXacP6wCeCWWlhqayNLJD/3FTAN+At
	xynOdAJIqzNSHf91fToq96v9ZEmQrDrcdMWwrqr/lVVZRnCmVNHB1PFAJbOnb0NZ
	9KUNm82G02gupCBtRXBAbumcvLy5a2l8XD7G0UVwy1lUJksu2GqcRJDCcV7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540410; x=1723626810; bh=TQpjw3XRiEMZyOn9PtkKhYY8rRMu
	ySL43EOD6sMe1XQ=; b=FNUNS28V4XDZLONEeiWgQxRqL8G2TxO0Qi1fdNDTSOfS
	9y2WsuPH5ff5qKgcCRk9h47W9NJ+Moy17XXO1MY/POdCn5DBtoEleuKGFE5VqGkT
	DkrM0LasrAonLo7WoJJ9QAU0YhlV398XF0h4l4dy5S/yRwB6bN9nzyu/L+WcWRk0
	tXEF2RDwpk/hBVmW/Mc8U2UfZkCgJjtA0e4DsTCwDb6oekNGfEagCXheM/3MWQ0U
	+4drgSFZvU6bBznVeXSdBgCdUXqPXSYIRkN8Cihb/0ZwX4Z3S+qvld+jBevVDB5n
	YDa55ANzJbom/AkBicr5LyMRFe9YmPPE4CIBbWYRVw==
X-ME-Sender: <xms:uiO7ZkBAzv_PsuziECKNOUI4K_KYNP4pysyfWnXsl7UkMaQSOeukOQ>
    <xme:uiO7Zmj3gDsLhrNQ124qQvgA9FT8RlzdCpqMoF2zyJkVQELJInk4wm_zQjMzwmlg0
    TCIma8VyW2GswJ6ww>
X-ME-Received: <xmr:uiO7ZnkfcW-3P11Fr6FrueAZqQi196CGRw5u7pC0YzQQkrbtZMTTkeY97_HWZGrmb2-5J8YjfdccrHjGYmDm5u3bGAtg4ToqnEZxnGEmWvnkOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uiO7ZqyI4EtiMfUndzGGDh9khMzEXXb7xFgU3e0oEpjW5SezQ2IefQ>
    <xmx:uiO7ZpR9OGwaYq_uC7tB535UUySobPjebwGdi4C2v3If9NV7H5BOBQ>
    <xmx:uiO7ZlYMN3LxGnsL-vY8rYbzfhIP_dVBBUroYuKGmk9QNRMXtS4uaw>
    <xmx:uiO7ZiQWa3zalMIP7kGeOHweBuqdrt4jRgf3uoEzF5i2C4LwaFWEog>
    <xmx:uiO7Zrdm2AG_sAGFKzxFaJN8YpLXm-rsuKIrGJ9VZiZ505FjUxHjcBQ8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 406d34dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:13 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/20] hooks: remove implicit dependency on
 `the_repository`
Message-ID: <688d705179e0d8692c635e20f15eb18ae8e500eb.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

We implicitly depend on `the_repository` in our hook subsystem because
we use `strbuf_git_path()` to compute hook paths. Remove this dependency
by accepting a `struct repository` as parameter instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/am.c           |  9 +++++----
 builtin/bugreport.c    |  2 +-
 builtin/checkout.c     |  2 +-
 builtin/clone.c        |  2 +-
 builtin/gc.c           |  2 +-
 builtin/hook.c         |  2 +-
 builtin/merge.c        |  2 +-
 builtin/rebase.c       |  2 +-
 builtin/receive-pack.c | 10 +++++-----
 builtin/worktree.c     |  2 +-
 commit.c               |  2 +-
 hook.c                 | 21 +++++++++++----------
 hook.h                 | 13 ++++++++-----
 read-cache.c           |  6 +++---
 refs.c                 |  2 +-
 reset.c                |  2 +-
 sequencer.c            |  6 +++---
 transport.c            |  2 +-
 18 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index a12be088f7..d8875ad402 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -490,7 +490,8 @@ static int run_applypatch_msg_hook(struct am_state *state)
 	assert(state->msg);
 
 	if (!state->no_verify)
-		ret = run_hooks_l("applypatch-msg", am_path(state, "final-commit"), NULL);
+		ret = run_hooks_l(the_repository, "applypatch-msg",
+				  am_path(state, "final-commit"), NULL);
 
 	if (!ret) {
 		FREE_AND_NULL(state->msg);
@@ -512,7 +513,7 @@ static int run_post_rewrite_hook(const struct am_state *state)
 	strvec_push(&opt.args, "rebase");
 	opt.path_to_stdin = am_path(state, "rewritten");
 
-	return run_hooks_opt("post-rewrite", &opt);
+	return run_hooks_opt(the_repository, "post-rewrite", &opt);
 }
 
 /**
@@ -1663,7 +1664,7 @@ static void do_commit(const struct am_state *state)
 	const char *reflog_msg, *author, *committer = NULL;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (!state->no_verify && run_hooks("pre-applypatch"))
+	if (!state->no_verify && run_hooks(the_repository, "pre-applypatch"))
 		exit(1);
 
 	if (write_index_as_tree(&tree, the_repository->index, get_index_file(), 0, NULL))
@@ -1716,7 +1717,7 @@ static void do_commit(const struct am_state *state)
 		fclose(fp);
 	}
 
-	run_hooks("post-applypatch");
+	run_hooks(the_repository, "post-applypatch");
 
 	free_commit_list(parents);
 	strbuf_release(&sb);
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index b3cc77af53..bdfed3d8f1 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -58,7 +58,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 	for (p = hook_name_list; *p; p++) {
 		const char *hook = *p;
 
-		if (hook_exists(hook))
+		if (hook_exists(the_repository, hook))
 			strbuf_addf(hook_info, "%s\n", hook);
 	}
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0f21ddd2c6..89543b3054 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -125,7 +125,7 @@ static void branch_info_release(struct branch_info *info)
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
-	return run_hooks_l("post-checkout",
+	return run_hooks_l(the_repository, "post-checkout",
 			   oid_to_hex(old_commit ? &old_commit->object.oid : null_oid()),
 			   oid_to_hex(new_commit ? &new_commit->object.oid : null_oid()),
 			   changed ? "1" : "0", NULL);
diff --git a/builtin/clone.c b/builtin/clone.c
index af6017d41a..29d4b79eb5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -788,7 +788,7 @@ static int checkout(int submodule_progress, int filter_submodules)
 	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	err |= run_hooks_l("post-checkout", oid_to_hex(null_oid()),
+	err |= run_hooks_l(the_repository, "post-checkout", oid_to_hex(null_oid()),
 			   oid_to_hex(&oid), "1", NULL);
 
 	if (!err && (option_recurse_submodules.nr > 0)) {
diff --git a/builtin/gc.c b/builtin/gc.c
index 72bac2554f..2ca6288c6b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -463,7 +463,7 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hooks("pre-auto-gc"))
+	if (run_hooks(the_repository, "pre-auto-gc"))
 		return 0;
 	return 1;
 }
diff --git a/builtin/hook.c b/builtin/hook.c
index 5234693a94..cc37438fde 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -58,7 +58,7 @@ static int run(int argc, const char **argv, const char *prefix)
 	hook_name = argv[0];
 	if (!ignore_missing)
 		opt.error_if_missing = 1;
-	ret = run_hooks_opt(hook_name, &opt);
+	ret = run_hooks_opt(the_repository, hook_name, &opt);
 	if (ret < 0) /* error() return */
 		ret = 1;
 	return ret;
diff --git a/builtin/merge.c b/builtin/merge.c
index c896b18d1a..662a49a0e8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -478,7 +478,7 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hooks_l("post-merge", squash ? "1" : "0", NULL);
+	run_hooks_l(the_repository, "post-merge", squash ? "1" : "0", NULL);
 
 	if (new_head)
 		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
diff --git a/builtin/rebase.c b/builtin/rebase.c
index e3a8e74cfc..fa0ca613e1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1774,7 +1774,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	/* If a hook exists, give it a chance to interrupt*/
 	if (!ok_to_skip_pre_rebase &&
-	    run_hooks_l("pre-rebase", options.upstream_arg,
+	    run_hooks_l(the_repository, "pre-rebase", options.upstream_arg,
 			argc ? argv[0] : NULL, NULL))
 		die(_("The pre-rebase hook refused to rebase."));
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 339524ae2a..4ff22d8b15 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -792,7 +792,7 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct async muxer;
 	int code;
-	const char *hook_path = find_hook(hook_name);
+	const char *hook_path = find_hook(the_repository, hook_name);
 
 	if (!hook_path)
 		return 0;
@@ -922,7 +922,7 @@ static int run_update_hook(struct command *cmd)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int code;
-	const char *hook_path = find_hook("update");
+	const char *hook_path = find_hook(the_repository, "update");
 
 	if (!hook_path)
 		return 0;
@@ -1098,7 +1098,7 @@ static int run_proc_receive_hook(struct command *commands,
 	int hook_use_push_options = 0;
 	int version = 0;
 	int code;
-	const char *hook_path = find_hook("proc-receive");
+	const char *hook_path = find_hook(the_repository, "proc-receive");
 
 	if (!hook_path) {
 		rp_error("cannot find hook 'proc-receive'");
@@ -1409,7 +1409,7 @@ static const char *push_to_checkout(unsigned char *hash,
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
 	strvec_pushv(&opt.env, env->v);
 	strvec_push(&opt.args, hash_to_hex(hash));
-	if (run_hooks_opt(push_to_checkout_hook, &opt))
+	if (run_hooks_opt(the_repository, push_to_checkout_hook, &opt))
 		return "push-to-checkout hook declined";
 	else
 		return NULL;
@@ -1618,7 +1618,7 @@ static void run_update_post_hook(struct command *commands)
 	struct child_process proc = CHILD_PROCESS_INIT;
 	const char *hook;
 
-	hook = find_hook("post-update");
+	hook = find_hook(the_repository, "post-update");
 	if (!hook)
 		return;
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1d51e54fcd..a4b7f24e1e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -573,7 +573,7 @@ static int add_worktree(const char *path, const char *refname,
 			     NULL);
 		opt.dir = path;
 
-		ret = run_hooks_opt("post-checkout", &opt);
+		ret = run_hooks_opt(the_repository, "post-checkout", &opt);
 	}
 
 	strvec_clear(&child_env);
diff --git a/commit.c b/commit.c
index 087cb19f4f..24ab5c1b50 100644
--- a/commit.c
+++ b/commit.c
@@ -1960,5 +1960,5 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 	va_end(args);
 
 	opt.invoked_hook = invoked_hook;
-	return run_hooks_opt(name, &opt);
+	return run_hooks_opt(the_repository, name, &opt);
 }
diff --git a/hook.c b/hook.c
index 7e90787bca..a9320cb0ce 100644
--- a/hook.c
+++ b/hook.c
@@ -10,14 +10,14 @@
 #include "environment.h"
 #include "setup.h"
 
-const char *find_hook(const char *name)
+const char *find_hook(struct repository *r, const char *name)
 {
 	static struct strbuf path = STRBUF_INIT;
 
 	int found_hook;
 
 	strbuf_reset(&path);
-	strbuf_git_path(&path, "hooks/%s", name);
+	strbuf_repo_git_path(&path, r, "hooks/%s", name);
 	found_hook = access(path.buf, X_OK) >= 0;
 #ifdef STRIP_EXTENSION
 	if (!found_hook) {
@@ -48,9 +48,9 @@ const char *find_hook(const char *name)
 	return path.buf;
 }
 
-int hook_exists(const char *name)
+int hook_exists(struct repository *r, const char *name)
 {
-	return !!find_hook(name);
+	return !!find_hook(r, name);
 }
 
 static int pick_next_hook(struct child_process *cp,
@@ -121,7 +121,8 @@ static void run_hooks_opt_clear(struct run_hooks_opt *options)
 	strvec_clear(&options->args);
 }
 
-int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
+int run_hooks_opt(struct repository *r, const char *hook_name,
+		  struct run_hooks_opt *options)
 {
 	struct strbuf abs_path = STRBUF_INIT;
 	struct hook_cb_data cb_data = {
@@ -129,7 +130,7 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 		.hook_name = hook_name,
 		.options = options,
 	};
-	const char *const hook_path = find_hook(hook_name);
+	const char *const hook_path = find_hook(r, hook_name);
 	int ret = 0;
 	const struct run_process_parallel_opts opts = {
 		.tr2_category = "hook",
@@ -173,14 +174,14 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
 	return ret;
 }
 
-int run_hooks(const char *hook_name)
+int run_hooks(struct repository *r, const char *hook_name)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
-	return run_hooks_opt(hook_name, &opt);
+	return run_hooks_opt(r, hook_name, &opt);
 }
 
-int run_hooks_l(const char *hook_name, ...)
+int run_hooks_l(struct repository *r, const char *hook_name, ...)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	va_list ap;
@@ -191,5 +192,5 @@ int run_hooks_l(const char *hook_name, ...)
 		strvec_push(&opt.args, arg);
 	va_end(ap);
 
-	return run_hooks_opt(hook_name, &opt);
+	return run_hooks_opt(r, hook_name, &opt);
 }
diff --git a/hook.h b/hook.h
index 6511525aeb..11863fa734 100644
--- a/hook.h
+++ b/hook.h
@@ -2,6 +2,8 @@
 #define HOOK_H
 #include "strvec.h"
 
+struct repository;
+
 struct run_hooks_opt
 {
 	/* Environment vars to be set for each hook */
@@ -55,12 +57,12 @@ struct hook_cb_data {
  * or disabled. Note that this points to static storage that will be
  * overwritten by further calls to find_hook and run_hook_*.
  */
-const char *find_hook(const char *name);
+const char *find_hook(struct repository *r, const char *name);
 
 /**
  * A boolean version of find_hook()
  */
-int hook_exists(const char *hookname);
+int hook_exists(struct repository *r, const char *hookname);
 
 /**
  * Takes a `hook_name`, resolves it to a path with find_hook(), and
@@ -70,13 +72,14 @@ int hook_exists(const char *hookname);
  * Returns the status code of the run hook, or a negative value on
  * error().
  */
-int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options);
+int run_hooks_opt(struct repository *r, const char *hook_name,
+		  struct run_hooks_opt *options);
 
 /**
  * A wrapper for run_hooks_opt() which provides a dummy "struct
  * run_hooks_opt" initialized with "RUN_HOOKS_OPT_INIT".
  */
-int run_hooks(const char *hook_name);
+int run_hooks(struct repository *r, const char *hook_name);
 
 /**
  * Like run_hooks(), a wrapper for run_hooks_opt().
@@ -87,5 +90,5 @@ int run_hooks(const char *hook_name);
  * hook. This function behaves like the old run_hook_le() API.
  */
 LAST_ARG_MUST_BE_NULL
-int run_hooks_l(const char *hook_name, ...);
+int run_hooks_l(struct repository *r, const char *hook_name, ...);
 #endif
diff --git a/read-cache.c b/read-cache.c
index 48bf24f87c..742369b295 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3156,9 +3156,9 @@ static int do_write_locked_index(struct index_state *istate,
 	else
 		ret = close_lock_file_gently(lock);
 
-	run_hooks_l("post-index-change",
-			istate->updated_workdir ? "1" : "0",
-			istate->updated_skipworktree ? "1" : "0", NULL);
+	run_hooks_l(the_repository, "post-index-change",
+		    istate->updated_workdir ? "1" : "0",
+		    istate->updated_skipworktree ? "1" : "0", NULL);
 	istate->updated_workdir = 0;
 	istate->updated_skipworktree = 0;
 
diff --git a/refs.c b/refs.c
index e082fc59b0..0afc70b51b 100644
--- a/refs.c
+++ b/refs.c
@@ -2132,7 +2132,7 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	const char *hook;
 	int ret = 0, i;
 
-	hook = find_hook("reference-transaction");
+	hook = find_hook(transaction->ref_store->repo, "reference-transaction");
 	if (!hook)
 		return ret;
 
diff --git a/reset.c b/reset.c
index 9550dea03d..b22b1be792 100644
--- a/reset.c
+++ b/reset.c
@@ -79,7 +79,7 @@ static int update_refs(const struct reset_head_opts *opts,
 						 reflog_head);
 	}
 	if (!ret && run_hook)
-		run_hooks_l("post-checkout",
+		run_hooks_l(the_repository, "post-checkout",
 			    oid_to_hex(head ? head : null_oid()),
 			    oid_to_hex(oid), "1", NULL);
 	strbuf_release(&msg);
diff --git a/sequencer.c b/sequencer.c
index 0291920f0b..edeeec6f15 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1316,7 +1316,7 @@ static int run_rewrite_hook(const struct object_id *oldoid,
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int code;
 	struct strbuf sb = STRBUF_INIT;
-	const char *hook_path = find_hook("post-rewrite");
+	const char *hook_path = find_hook(the_repository, "post-rewrite");
 
 	if (!hook_path)
 		return 0;
@@ -1614,7 +1614,7 @@ static int try_to_commit(struct repository *r,
 		}
 	}
 
-	if (hook_exists("prepare-commit-msg")) {
+	if (hook_exists(r, "prepare-commit-msg")) {
 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
@@ -5149,7 +5149,7 @@ static int pick_commits(struct repository *r,
 
 			hook_opt.path_to_stdin = rebase_path_rewritten_list();
 			strvec_push(&hook_opt.args, "rebase");
-			run_hooks_opt("post-rewrite", &hook_opt);
+			run_hooks_opt(r, "post-rewrite", &hook_opt);
 		}
 		apply_autostash(rebase_path_autostash());
 
diff --git a/transport.c b/transport.c
index 12cc5b4d96..f8cd2810a5 100644
--- a/transport.c
+++ b/transport.c
@@ -1271,7 +1271,7 @@ static int run_pre_push_hook(struct transport *transport,
 	struct ref *r;
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf;
-	const char *hook_path = find_hook("pre-push");
+	const char *hook_path = find_hook(the_repository, "pre-push");
 
 	if (!hook_path)
 		return 0;
-- 
2.46.0.46.g406f326d27.dirty

