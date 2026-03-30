Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6403D3D0C
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876691; cv=none; b=eUpOkLxWqcN6RC7AMiczRFCQu7b5LGXDURYpRWHmcSC/N6fK84pTrtlF7yVI00EdBCKr3zh4Wq0P9dhndxN/PeNSvTUBAIKY1jVdG9n0U4LgXIc0wE3eAvuRmRTYAwC/VF/Ze05TlChjN2C2ThrqZzMHCE37LC1YJ6jpf/HLEGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876691; c=relaxed/simple;
	bh=PFC+UG5w7a55/qOG+FCPNNQHeFID7/+vCKMu5M31wMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsdaglkQOUUnpEI21zszmUvG0izYTIKuI1desJ+9lz1BBlsqkCJXA+MNBxA+6DLUiKX85PzZ0341M2bW7yUzUa6dhdK/uJfMj/9m7Oo41A+u+/s72VQLaB4hvvChWMvLWPhdto+4MhPOQkenc46gaK7Syv1hcTTagkNBJWSDsI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dZOqBMJd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qQbRlHmR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dZOqBMJd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qQbRlHmR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9C147A0068
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 30 Mar 2026 09:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876688;
	 x=1774963088; bh=nZ/I/IiXvJT/5rAOGJWrUFne7uJncwgtCtIgOj2I8vU=; b=
	dZOqBMJdI7v/LPX0zC601N9Vs1+gQBJv5HS6bRwbkNpAoeDs9t4jUdM/q+PoBDf4
	0wSnd2gL1bukZyMq6wSR5EiY4fM9VtCIUdZTiNHq3kPHRQzufZlHc7vz86SW+xjY
	9+R0zvH+Ez+hQkBUGLFryAPkI0ZHHYU6cvWYo2LNmohaXLKH013HeZI12fYS6C5U
	E+ZEGCmTCB9dAuO++cn6WvuxLnxI8RYnEzKpNDTj5l2xCMS+sUOVuYYUzH+B6i3q
	yL1C6/yAxBPHKmjyQhz/nibKxt1VY4n7/V0+053xA/JdOcfBKQF/seYSLOw3F1NT
	4Tb9ahGBu9MXbsuMdtSzZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876688; x=
	1774963088; bh=nZ/I/IiXvJT/5rAOGJWrUFne7uJncwgtCtIgOj2I8vU=; b=q
	QbRlHmRSwAYYiSk/h7CtrkMnUapi/7R2aHmPw4S6Sp8EXDXLbdnwyWCl4+PvpY8C
	Muf5XPAlnTHLK64B7PCdZ41M54YMoPqnOg1lf6uFDFfhbcKF5s2wSYLMVdykfir0
	d0SQfYBS8vOhnDKkxhFaVtvNPKkCI97lJgbxHUOcpnnkxMdmIDKuNEW7RSzXBSxB
	UYJo9sVpaq5QOCBZlTfWCUWSmGYSzUBiyu/6uUaNHdWnXMmgVa4I8/gmm1aLMluv
	QfLKwQZUHlbi487OsJHB5R14sSW9r+H016Z5raib6MTvzSVM7qlxEbJKOYS8MOx+
	tI4AC1Zy0NHtIZ+71MZLg==
X-ME-Sender: <xms:EHjKaUIFlLvj4zUqqlQzBKlEuOP3ADVQH-LCgQ_wKJpCWcyUpCPnXw>
    <xme:EHjKabGdN5YkOyg4DwmAePgFcFAc4UHo6DZPZMwPwy4rYBjmHQqZmKz_NJwFolPEu
    WluUL5XjwhuoOtl6m2SWHXHhmPGK_TREhj0_xagEKZobZDkI65XgA>
X-ME-Received: <xmr:EHjKaaWVqUZ66Exw8c1NJeLLazRn6K-MNzKsv2L3q_GdcZE2Y1X__HAm2ATSmCBfGqIQ9Tnpvjf0AbK68sfOjnX9fNI49A10qlCGhVYBeJP6rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:EHjKaWh2OOXccqyhg5BhQnuFG44nO6eujqON0ZODNz_EDcbGC6eWKA>
    <xmx:EHjKabTPcEw2WkRiSsJrWZIdb2bMhDSQ-d_gcZAlk1Uld7kYfxguYw>
    <xmx:EHjKaZEUPzqyAuJCEmutQVRVqcFJCRXsWeGa40tTitBuwI_PhKLsEw>
    <xmx:EHjKaTkRATxgXbfv4YUQi5_lM8Oi1Dp02xV3yX7FHBV_9EYKkAKPZg>
    <xmx:EHjKadovV60csWErLeINyN0klQ3mUfT2TnoxGX-4ay1TDdTbo7XZslip>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab4cfe32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:18:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:31 +0200
Subject: [PATCH 09/18] setup: stop using `the_repository` in
 `setup_work_tree()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-9-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Stop using `the_repository` in `setup_work_tree()` and instead accept
the repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Note that the function tracks bogus worktree configuration via a global
variable. If we have bogus configuration, and if later on some caller
tries to setup a worktree, then we'll die instead.

Of course, tracking this as a global variable doesn't make sense anymore
now that we can set up worktrees for arbitrary repositories. Move the
variable into `struct repository` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 blame.c                     |  2 +-
 builtin/check-attr.c        |  2 +-
 builtin/clone.c             |  2 +-
 builtin/describe.c          |  2 +-
 builtin/diff-index.c        |  2 +-
 builtin/diff.c              |  4 ++--
 builtin/difftool.c          |  2 +-
 builtin/grep.c              |  2 +-
 builtin/ls-files.c          |  2 +-
 builtin/read-tree.c         |  2 +-
 builtin/reset.c             |  2 +-
 builtin/rm.c                |  2 +-
 builtin/sparse-checkout.c   | 16 ++++++++--------
 builtin/submodule--helper.c |  2 +-
 builtin/update-index.c      | 10 +++++-----
 git.c                       |  2 +-
 repository.h                |  1 +
 setup.c                     |  9 ++++-----
 setup.h                     |  2 +-
 t/helper/test-subprocess.c  |  4 +++-
 wt-status.c                 |  2 +-
 21 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/blame.c b/blame.c
index a3c49d132e..977cbb7097 100644
--- a/blame.c
+++ b/blame.c
@@ -2813,7 +2813,7 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 		}
 
 		if (!sb->contents_from)
-			setup_work_tree();
+			setup_work_tree(the_repository);
 
 		sb->final = fake_working_tree_commit(sb->repo,
 						     &sb->revs->diffopt,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 04b86e42ae..98f64d5b92 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -117,7 +117,7 @@ int cmd_check_attr(int argc,
 	int cnt, i, doubledash, filei;
 
 	if (!is_bare_repository())
-		setup_work_tree();
+		setup_work_tree(the_repository);
 
 	repo_config(the_repository, git_default_config, NULL);
 
diff --git a/builtin/clone.c b/builtin/clone.c
index fba3c9c508..91b9a105a4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -668,7 +668,7 @@ static int checkout(int submodule_progress,
 	}
 
 	/* We need to be in the new work tree for the checkout */
-	setup_work_tree();
+	setup_work_tree(the_repository);
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 
diff --git a/builtin/describe.c b/builtin/describe.c
index bffeed13a3..1c47d7c0b7 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -781,7 +781,7 @@ int cmd_describe(int argc,
 			struct rev_info revs;
 			int fd;
 
-			setup_work_tree();
+			setup_work_tree(the_repository);
 			prepare_repo_settings(the_repository);
 			the_repository->settings.command_requires_full_index = 0;
 			repo_read_index(the_repository);
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 522dacfc4c..3db7cffede 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -69,7 +69,7 @@ int cmd_diff_index(int argc,
 	    rev.max_count != -1 || rev.min_age != -1 || rev.max_age != -1)
 		usage(diff_cache_usage);
 	if (!(option & DIFF_INDEX_CACHED)) {
-		setup_work_tree();
+		setup_work_tree(the_repository);
 		if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
 			perror("repo_read_index_preload");
 			return -1;
diff --git a/builtin/diff.c b/builtin/diff.c
index 7ddebce2ac..1ede873ac1 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -159,7 +159,7 @@ static void builtin_diff_index(struct rev_info *revs,
 	    revs->max_age != -1)
 		usage(builtin_diff_usage);
 	if (!(option & DIFF_INDEX_CACHED)) {
-		setup_work_tree();
+		setup_work_tree(the_repository);
 		if (repo_read_index_preload(the_repository,
 					    &revs->diffopt.pathspec, 0) < 0) {
 			die_errno("repo_read_index_preload");
@@ -281,7 +281,7 @@ static void builtin_diff_files(struct rev_info *revs, int argc, const char **arg
 	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
 		diff_merges_set_dense_combined_if_unset(revs);
 
-	setup_work_tree();
+	setup_work_tree(the_repository);
 	if (repo_read_index_preload(the_repository, &revs->diffopt.pathspec,
 				    0) < 0) {
 		die_errno("repo_read_index_preload");
diff --git a/builtin/difftool.c b/builtin/difftool.c
index e4bc1f8316..2a21005f2e 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -767,7 +767,7 @@ int cmd_difftool(int argc,
 		die(_("difftool requires worktree or --no-index"));
 
 	if (!no_index){
-		setup_work_tree();
+		setup_work_tree(repo);
 		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(repo)), 1);
 		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(repo)), 1);
 	} else if (dir_diff)
diff --git a/builtin/grep.c b/builtin/grep.c
index 4ec0c016b1..679f8b567a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1272,7 +1272,7 @@ int cmd_grep(int argc,
 		die(_("--[no-]exclude-standard cannot be used for tracked contents"));
 	} else if (!list.nr) {
 		if (!cached)
-			setup_work_tree();
+			setup_work_tree(the_repository);
 
 		hit = grep_cache(&opt, &pathspec, cached);
 	} else {
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 09d95111b3..e1a22b41b9 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -704,7 +704,7 @@ int cmd_ls_files(int argc,
 		exc_given = 1;
 
 	if (require_work_tree && !is_inside_work_tree(repo))
-		setup_work_tree();
+		setup_work_tree(repo);
 
 	if (recurse_submodules &&
 	    (show_deleted || show_others || show_unmerged ||
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 460b21e40a..999a82ecdf 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -229,7 +229,7 @@ int cmd_read_tree(int argc,
 		opts.preserve_ignored = 0;
 	/* otherwise, opts.preserve_ignored is irrelevant */
 	if (opts.merge && !opts.index_only)
-		setup_work_tree();
+		setup_work_tree(the_repository);
 
 	if (opts.skip_sparse_checkout)
 		ensure_full_index(the_repository->index);
diff --git a/builtin/reset.c b/builtin/reset.c
index 11f57605b5..3be6bd0121 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -468,7 +468,7 @@ int cmd_reset(int argc,
 		trace2_cmd_mode(reset_type_names[reset_type]);
 
 	if (reset_type != SOFT && (reset_type != MIXED || repo_get_work_tree(the_repository)))
-		setup_work_tree();
+		setup_work_tree(the_repository);
 
 	if (reset_type == MIXED && is_bare_repository())
 		die(_("%s reset is not allowed in a bare repository"),
diff --git a/builtin/rm.c b/builtin/rm.c
index 05d89e98c3..081d0bc375 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -296,7 +296,7 @@ int cmd_rm(int argc,
 		die(_("No pathspec was given. Which files should I remove?"));
 
 	if (!index_only)
-		setup_work_tree();
+		setup_work_tree(the_repository);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 2af50fb2f9..d89acbeb53 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -63,7 +63,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 	int res;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	setup_work_tree();
+	setup_work_tree(the_repository);
 	if (!cfg->apply_sparse_checkout)
 		die(_("this worktree is not sparse"));
 
@@ -229,7 +229,7 @@ static int update_working_directory(struct repository *r,
 	o.dst_index = r->index;
 	o.skip_sparse_checkout = 0;
 
-	setup_work_tree();
+	setup_work_tree(the_repository);
 
 	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
 
@@ -468,7 +468,7 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix,
 		OPT_END(),
 	};
 
-	setup_work_tree();
+	setup_work_tree(the_repository);
 	repo_read_index(repo);
 
 	init_opts.cone_mode = -1;
@@ -802,7 +802,7 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
 	int ret;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	setup_work_tree();
+	setup_work_tree(the_repository);
 	if (!cfg->apply_sparse_checkout)
 		die(_("no sparse-checkout to add to"));
 
@@ -856,7 +856,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 	struct strvec patterns = STRVEC_INIT;
 	int ret;
 
-	setup_work_tree();
+	setup_work_tree(the_repository);
 	repo_read_index(repo);
 
 	set_opts.cone_mode = -1;
@@ -912,7 +912,7 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 	};
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	setup_work_tree();
+	setup_work_tree(the_repository);
 	if (!cfg->apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
@@ -975,7 +975,7 @@ static int sparse_checkout_clean(int argc, const char **argv,
 		OPT_END(),
 	};
 
-	setup_work_tree();
+	setup_work_tree(the_repository);
 	if (!cfg->apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to clean directories"));
 	if (!core_sparse_checkout_cone)
@@ -1053,7 +1053,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	 * forcibly return to a dense checkout regardless of initial state.
 	 */
 
-	setup_work_tree();
+	setup_work_tree(the_repository);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_disable_options,
 			     builtin_sparse_checkout_disable_usage, 0);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2f589e3b37..1cc82a134d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1250,7 +1250,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 
 	if (!info->cached) {
 		if (diff_cmd == DIFF_INDEX)
-			setup_work_tree();
+			setup_work_tree(the_repository);
 		if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
 			perror("repo_read_index_preload");
 			ret = -1;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7434112b8e..d6dabacfd1 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -732,7 +732,7 @@ struct refresh_params {
 
 static int refresh(struct refresh_params *o, unsigned int flag)
 {
-	setup_work_tree();
+	setup_work_tree(the_repository);
 	repo_read_index(the_repository);
 	*o->has_errors |= refresh_index(the_repository->index, o->flags | flag, NULL,
 					NULL, NULL);
@@ -901,7 +901,7 @@ static enum parse_opt_result reupdate_callback(
 	BUG_ON_OPT_ARG(arg);
 
 	/* consume remaining arguments. */
-	setup_work_tree();
+	setup_work_tree(the_repository);
 	*has_errors = do_reupdate(ctx->argv + 1, prefix);
 	if (*has_errors)
 		the_repository->index->cache_changed = 0;
@@ -1157,7 +1157,7 @@ int cmd_update_index(int argc,
 				transaction = NULL;
 			}
 
-			setup_work_tree();
+			setup_work_tree(the_repository);
 			p = prefix_path(the_repository, prefix, prefix_length, path);
 			update_one(p);
 			if (set_executable_bit)
@@ -1199,7 +1199,7 @@ int cmd_update_index(int argc,
 		struct strbuf buf = STRBUF_INIT;
 		struct strbuf unquoted = STRBUF_INIT;
 
-		setup_work_tree();
+		setup_work_tree(the_repository);
 		while (getline_fn(&buf, stdin) != EOF) {
 			char *p;
 			if (!nul_term_line && buf.buf[0] == '"') {
@@ -1253,7 +1253,7 @@ int cmd_update_index(int argc,
 		report(_("Untracked cache disabled"));
 		break;
 	case UC_TEST:
-		setup_work_tree();
+		setup_work_tree(the_repository);
 		return !test_if_untracked_cache_is_supported();
 	case UC_ENABLE:
 	case UC_FORCE:
diff --git a/git.c b/git.c
index 2b212e6675..c146eaa20b 100644
--- a/git.c
+++ b/git.c
@@ -497,7 +497,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	commit_pager_choice();
 
 	if (!help && p->option & NEED_WORK_TREE)
-		setup_work_tree();
+		setup_work_tree(the_repository);
 
 	trace_argv_printf(argv, "trace: built-in: git");
 	trace2_cmd_name(p->cmd);
diff --git a/repository.h b/repository.h
index 078059a6e0..abeef3129e 100644
--- a/repository.h
+++ b/repository.h
@@ -113,6 +113,7 @@ struct repository {
 	 * A NULL value indicates that there is no working directory.
 	 */
 	char *worktree;
+	bool worktree_config_is_bogus;
 
 	/*
 	 * Path from the root of the top-level superproject down to this
diff --git a/setup.c b/setup.c
index dca32addae..64a030c6cd 100644
--- a/setup.c
+++ b/setup.c
@@ -26,7 +26,6 @@
 #include "trace2.h"
 #include "worktree.h"
 
-static int work_tree_config_is_bogus;
 enum allowed_bare_repo {
 	ALLOWED_BARE_REPO_EXPLICIT = 0,
 	ALLOWED_BARE_REPO_ALL,
@@ -485,7 +484,7 @@ int is_inside_work_tree(struct repository *repo)
 	return is_inside_dir(strbuf_realpath(&buf, worktree, 1));
 }
 
-void setup_work_tree(void)
+void setup_work_tree(struct repository *repo)
 {
 	const char *work_tree;
 	static int initialized = 0;
@@ -493,10 +492,10 @@ void setup_work_tree(void)
 	if (initialized)
 		return;
 
-	if (work_tree_config_is_bogus)
+	if (repo->worktree_config_is_bogus)
 		die(_("unable to set up work tree using invalid config"));
 
-	work_tree = repo_get_work_tree(the_repository);
+	work_tree = repo_get_work_tree(repo);
 	if (!work_tree || chdir_notify(work_tree))
 		die(_("this operation must be run in a work tree"));
 
@@ -1155,7 +1154,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 		if (git_work_tree_cfg) {
 			/* #22.2, #30 */
 			warning("core.bare and core.worktree do not make sense");
-			work_tree_config_is_bogus = 1;
+			repo->worktree_config_is_bogus = true;
 		}
 
 		/* #18, #26 */
diff --git a/setup.h b/setup.h
index d0cfdfd44a..8fed365637 100644
--- a/setup.h
+++ b/setup.h
@@ -56,7 +56,7 @@ const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
 void die_upon_dubious_ownership(const char *gitfile, const char *worktree,
 				const char *gitdir);
 
-void setup_work_tree(void);
+void setup_work_tree(struct repository *repo);
 
 /*
  * discover_git_directory_reason() is similar to discover_git_directory(),
diff --git a/t/helper/test-subprocess.c b/t/helper/test-subprocess.c
index c344f1694d..8a070e47cd 100644
--- a/t/helper/test-subprocess.c
+++ b/t/helper/test-subprocess.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "run-command.h"
 #include "setup.h"
@@ -11,7 +13,7 @@ int cmd__subprocess(int argc, const char **argv)
 	if (nogit)
 		die("No git repo found");
 	if (argc > 1 && !strcmp(argv[1], "--setup-work-tree")) {
-		setup_work_tree();
+		setup_work_tree(the_repository);
 		argv++;
 	}
 	cp.git_cmd = 1;
diff --git a/wt-status.c b/wt-status.c
index 479ccc3304..6cc77ba68c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1206,7 +1206,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 		status_printf_ln(s, c,
 			"--------------------------------------------------");
 		status_printf_ln(s, c, _("Changes not staged for commit:"));
-		setup_work_tree();
+		setup_work_tree(the_repository);
 		rev.diffopt.a_prefix = "i/";
 		rev.diffopt.b_prefix = "w/";
 		run_diff_files(&rev, 0);

-- 
2.53.0.1185.g05d4b7b318.dirty

