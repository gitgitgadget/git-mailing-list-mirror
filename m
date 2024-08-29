Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16918DF73
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924320; cv=none; b=hCmkGFJ3oHQ/p3/GyB7m2mozw+5Pw2Tm8jvcqTNhOAs5oUWpzMKN5diZp7Plfai1aRTnf9oLcj2o+tf8USBuu+jt+cS2efyVmR43qRTgIERcJRxo00RfYiLRNY7+xjSAIQkdySdEcGst0uzb2izZh45ZGnqDlFWz49n0Ko41dQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924320; c=relaxed/simple;
	bh=ciuZzXiQ5NDAhMtdT7pScJmkwMDGUpi+HuRSNUQDrPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUSySC6XDt4xyhYJNyorl890INNS6VxOoy1lE2hQnNnMMOKjSjhYuJUzjnaRQDRlzgdmgDt58WM+1UjhL5+87cBId1L3kbP8Tj2T5HvdDQoQOlv6btKcsZAZEWq9EBMSKovn/EAG32XezwtSx3OOj6A17lNTYei1jVa5pqpov7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RN19REtN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lwEKWj7O; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RN19REtN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lwEKWj7O"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0F31A1390140;
	Thu, 29 Aug 2024 05:38:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 29 Aug 2024 05:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924318; x=1725010718; bh=nCYlEAbemo
	uDSJTCplkGGNYdt9k0R4ufan2lGxVs5yU=; b=RN19REtN7I4gWTOVphEWvg1clC
	zFaqcRFPCDok5fTT8zxKhc+W6yusajsJmXyd08b5jTfnfbWtn4c+9jlOlxJPSaGl
	z7qPd906irEEdnFCL6g/438mHoqcGurizvTKJKS2dUsO0bnOkJSxK3u6KxSYWgub
	JTIlxngoEne0QKvYzJwsHrTzrcH9Yam+IEK0uE78xtKbwRhGRSMvh0eZhKJGtfP6
	DGlsrlXXQD3/RkSbtVDFHjJLTUeA0HqZkomcboMSbTj1/zaLiUBk5KZ+wWOilH1l
	Im4sb3j1xM/EFx855nxafMbAxo3U/5qhBMIe0aSehl+g1RVmtiCQXoUL8Lbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924318; x=1725010718; bh=nCYlEAbemouDSJTCplkGGNYdt9k0
	R4ufan2lGxVs5yU=; b=lwEKWj7OstrPiZXzW6UphMLctY0aujIREO/+r9No5iRO
	BKOpADe8XD8BQJ/YnXneqG1yZZtbaG6XGjzAYl374WNvKa7CoOBeOO9ftXrdf5oV
	WfbglNeWFjL+yxN8owo7svxvkC+cCbvYnlmt4jR2o0UepCXGcJ0K1ghAII7NpUzZ
	oQq2wojJYwUaCnkYxckuZ82LshFcu5c4jKUR12qcAZPUnIBvdArxG8US2anfHrHA
	+PBUzTQIXAC0OGaEgP589tdRCGXQbRZ2PDb7isYjO9BoypvvEvwUd5CiQZGMliwa
	ya+L6dgmU6YVKTOcqVy/38oa0nWzRcXgj6frOuSi6Q==
X-ME-Sender: <xms:nUHQZvwATY7yNzX5oxaZqxUPqing6s40dyjkuZsPSmLZCoVKL-OkLA>
    <xme:nUHQZnTv8X1l5881I0AhtO-ucYsQI2IuQmf4QebpltDnyMXDjDpiOFW6woLLx5CL5
    oPUhN_F3sF4lWdQWQ>
X-ME-Received: <xmr:nUHQZpWEdUvnjJhZeMcE0Uss5SlMnH_DmHYxFBnWBDQI0vupdJMMyJIZj_N0Pmx8tJHw4OifMhH2ndnOd4yFySdArK1ex9FMqLBPkUu213I7Sac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:nUHQZpi9Zmogb6VM5ppmMcEDHJY2vmu7rleNZVDbnk663qQzUuBVSQ>
    <xmx:nUHQZhAOeXBeLjmxNUcqXSB_OMlsSib2wYihV5nlfYzoyjMNFMMqfA>
    <xmx:nUHQZiL50_1HPEg_PECBOi9CFEIaARETK1oK8nhde6Td6mff-45lGg>
    <xmx:nUHQZgAxCx92E2dmwXmWludh8JNy2C5VkM1sVK5RjHjDW7gqLz_q7g>
    <xmx:nUHQZkPNcWReTU8i5VUM-4xnRad0ENZcsw1rGQABVgttpAMOshejv7fq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:38:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e1436728 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:29 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:38:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 04/21] environment: make `get_index_file()` accept a
 repository
Message-ID: <d857c5fab44a8592b397dd0495c6582b9d22227d.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

The `get_index_file()` function retrieves the path to the index file
of `the_repository`. Make it accept a `struct repository` such that it
can work on arbitrary repositories and make it part of the repository
subsystem. This reduces our reliance on `the_repository` and clarifies
scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/am.c           |  8 ++++++--
 builtin/commit.c       |  6 +++---
 builtin/merge.c        | 14 ++++++++------
 builtin/stash.c        | 12 ++++++------
 builtin/update-index.c |  2 +-
 builtin/write-tree.c   |  3 ++-
 environment.c          |  7 -------
 environment.h          |  1 -
 repository.c           |  7 +++++++
 repository.h           |  1 +
 wt-status.c            |  2 +-
 11 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 405214e242a..5498ddeb6aa 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1668,7 +1668,9 @@ static void do_commit(const struct am_state *state)
 	if (!state->no_verify && run_hooks(the_repository, "pre-applypatch"))
 		exit(1);
 
-	if (write_index_as_tree(&tree, the_repository->index, get_index_file(), 0, NULL))
+	if (write_index_as_tree(&tree, the_repository->index,
+				repo_get_index_file(the_repository),
+				0, NULL))
 		die(_("git write-tree failed to write a tree"));
 
 	if (!repo_get_oid_commit(the_repository, "HEAD", &parent)) {
@@ -2078,7 +2080,9 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
 	if (fast_forward_to(head_tree, head_tree, 1))
 		return -1;
 
-	if (write_index_as_tree(&index, the_repository->index, get_index_file(), 0, NULL))
+	if (write_index_as_tree(&index, the_repository->index,
+				repo_get_index_file(the_repository),
+				0, NULL))
 		return -1;
 
 	index_tree = parse_tree_indirect(&index);
diff --git a/builtin/commit.c b/builtin/commit.c
index 55124ee28f0..dea1733c6f6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -472,7 +472,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write new index file"));
 		commit_style = COMMIT_AS_IS;
-		ret = get_index_file();
+		ret = repo_get_index_file(the_repository);
 		goto out;
 	}
 
@@ -1873,8 +1873,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	repo_rerere(the_repository, 0);
 	run_auto_maintenance(quiet);
-	run_commit_hook(use_editor, get_index_file(), NULL, "post-commit",
-			NULL);
+	run_commit_hook(use_editor, repo_get_index_file(the_repository),
+			NULL, "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index 6c22912b63c..80ea1d52eef 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -695,7 +695,9 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 
 static void write_tree_trivial(struct object_id *oid)
 {
-	if (write_index_as_tree(oid, the_repository->index, get_index_file(), 0, NULL))
+	if (write_index_as_tree(oid, the_repository->index,
+				repo_get_index_file(the_repository),
+				0, NULL))
 		die(_("git write-tree failed to write a tree"));
 }
 
@@ -757,7 +759,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		}
 		if (write_locked_index(the_repository->index, &lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-			die(_("unable to write %s"), get_index_file());
+			die(_("unable to write %s"), repo_get_index_file(the_repository));
 		return clean ? 0 : 1;
 	} else {
 		return try_merge_command(the_repository,
@@ -839,7 +841,7 @@ static void write_merge_heads(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
-	const char *index_file = get_index_file();
+	const char *index_file = repo_get_index_file(the_repository);
 
 	if (!no_verify) {
 		int invoked_hook;
@@ -879,8 +881,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		append_signoff(&msg, ignored_log_message_bytes(msg.buf, msg.len), 0);
 	write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
-	if (run_commit_hook(0 < option_edit, get_index_file(), NULL,
-			    "prepare-commit-msg",
+	if (run_commit_hook(0 < option_edit, repo_get_index_file(the_repository),
+			    NULL, "prepare-commit-msg",
 			    git_path_merge_msg(the_repository), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
@@ -888,7 +890,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 			abort_commit(remoteheads, NULL);
 	}
 
-	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
+	if (!no_verify && run_commit_hook(0 < option_edit, repo_get_index_file(the_repository),
 					  NULL, "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
diff --git a/builtin/stash.c b/builtin/stash.c
index ed56299098e..ae42da02b97 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -539,8 +539,8 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 					 NULL, NULL, NULL))
 		return error(_("could not write index"));
 
-	if (write_index_as_tree(&c_tree, the_repository->index, get_index_file(), 0,
-				NULL))
+	if (write_index_as_tree(&c_tree, the_repository->index,
+				repo_get_index_file(the_repository), 0, NULL))
 		return error(_("cannot apply a stash in the middle of a merge"));
 
 	if (index) {
@@ -565,7 +565,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 			discard_index(the_repository->index);
 			repo_read_index(the_repository);
 			if (write_index_as_tree(&index_tree, the_repository->index,
-						get_index_file(), 0, NULL))
+						repo_get_index_file(the_repository), 0, NULL))
 				return error(_("could not save index tree"));
 
 			reset_head();
@@ -1405,8 +1405,8 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 
 	strbuf_addf(&commit_tree_label, "index on %s\n", msg.buf);
 	commit_list_insert(head_commit, &parents);
-	if (write_index_as_tree(&info->i_tree, the_repository->index, get_index_file(), 0,
-				NULL) ||
+	if (write_index_as_tree(&info->i_tree, the_repository->index,
+				repo_get_index_file(the_repository), 0, NULL) ||
 	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
 			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
 		if (!quiet)
@@ -1904,7 +1904,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	index_file = get_index_file();
+	index_file = repo_get_index_file(the_repository);
 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
 		    (uintmax_t)pid);
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 35a1f957adc..86c5d40e400 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1239,7 +1239,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-			unable_to_lock_die(get_index_file(), lock_error);
+			unable_to_lock_die(repo_get_index_file(the_repository), lock_error);
 		}
 		if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 			die("Unable to write new index file");
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 8c75b4609b5..a1b29737214 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -44,7 +44,8 @@ int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
-	ret = write_index_as_tree(&oid, the_repository->index, get_index_file(),
+	ret = write_index_as_tree(&oid, the_repository->index,
+				  repo_get_index_file(the_repository),
 				  flags, tree_prefix);
 	switch (ret) {
 	case 0:
diff --git a/environment.c b/environment.c
index 0a2057399e0..10ef77576c3 100644
--- a/environment.c
+++ b/environment.c
@@ -306,13 +306,6 @@ int odb_pack_keep(const char *name)
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
-char *get_index_file(void)
-{
-	if (!the_repository->index_file)
-		BUG("git environment hasn't been setup");
-	return the_repository->index_file;
-}
-
 char *get_graft_file(struct repository *r)
 {
 	if (!r->graft_file)
diff --git a/environment.h b/environment.h
index 91125d82991..ff590cfff73 100644
--- a/environment.h
+++ b/environment.h
@@ -106,7 +106,6 @@ int have_git_dir(void);
 extern int is_bare_repository_cfg;
 int is_bare_repository(void);
 extern char *git_work_tree_cfg;
-char *get_index_file(void);
 char *get_graft_file(struct repository *r);
 void set_git_dir(const char *path, int make_realpath);
 const char *get_git_namespace(void);
diff --git a/repository.c b/repository.c
index 914ee25a1f0..a9bbde80b5d 100644
--- a/repository.c
+++ b/repository.c
@@ -112,6 +112,13 @@ const char *repo_get_object_directory(struct repository *repo)
 	return repo->objects->odb->path;
 }
 
+const char *repo_get_index_file(struct repository *repo)
+{
+	if (!repo->index_file)
+		BUG("git environment hasn't been setup");
+	return repo->index_file;
+}
+
 static void repo_set_commondir(struct repository *repo,
 			       const char *commondir)
 {
diff --git a/repository.h b/repository.h
index 778f1511ab1..15660ac2f19 100644
--- a/repository.h
+++ b/repository.h
@@ -209,6 +209,7 @@ extern struct repository *the_repository;
 const char *repo_get_git_dir(struct repository *repo);
 const char *repo_get_common_dir(struct repository *repo);
 const char *repo_get_object_directory(struct repository *repo);
+const char *repo_get_index_file(struct repository *repo);
 
 /*
  * Define a custom repository layout. Any field can be NULL, which
diff --git a/wt-status.c b/wt-status.c
index b477239039d..b41db1451ba 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -152,7 +152,7 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
 					"HEAD", 0, NULL, NULL);
 	s->reference = "HEAD";
 	s->fp = stdout;
-	s->index_file = get_index_file();
+	s->index_file = repo_get_index_file(the_repository);
 	s->change.strdup_strings = 1;
 	s->untracked.strdup_strings = 1;
 	s->ignored.strdup_strings = 1;
-- 
2.46.0.421.g159f2d50e7.dirty

