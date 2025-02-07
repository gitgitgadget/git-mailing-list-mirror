Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86961E04A9
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926224; cv=none; b=IwKpkjpSdqtsnmtabSK6iUsybzsPSpzgeeYyYd+u2cU2DyhxPnq+g2rSh2Ja2bYOdpKT+HduyxdUkLm1qdR08zgeenULWs1BZUyXw3W/YNQuehP+T0CVxBAvSDUHh/KlMPW2DtFI75pToNZBAAHvnqVoYBuev8dB3Wy8F8MrEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926224; c=relaxed/simple;
	bh=RhZxDRF2Obq4Kvmhauh+6daTJoPj6J/IvgBaHgjzfJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jv0YcCK4zNWXWUHpMcQ1qDmnPd6Ot8Mb2ykFtMSrj3rXKrvIwijp5mlsSuWWO8gfgmozjutWNzsQclJzCvpG5U3llO89WS3PxQPFHWGo+hDvmpMU5pix8bFwduMPAIseACmhC+3n0qjnyX6Y0kuhtBdQ3HMOQXwy3ZakYj5wQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vtw/2DHQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z6XOCVtp; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vtw/2DHQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6XOCVtp"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B4C91140120;
	Fri,  7 Feb 2025 06:03:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 07 Feb 2025 06:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738926222;
	 x=1739012622; bh=UFZsxfb+viKUTPtg2B71Z5+8Bn7tUSEZxoSJ2vBiVX8=; b=
	Vtw/2DHQs/NUCUarUTqqR4HOkVV6jl3aQ8O0cMV1gM5iYmcr4Usxl9FQoQTw2OXq
	yZa5f15D3RH6aERCAphqQVvFU0hGeZLOeoWtxVOOqkBgTE8LJCc4XEc0owISb3IV
	kZWMhGs17RNHSCsh5/E5jdpVlcym7GaK2SQgmEBJ/a4lNSH5CDNL7En8L4MxvgAk
	axppEKH5mBspDkdxQGk425owjm7qlbTrPfMrV04X5hEn3WMEtkn8692BIyhP0zbT
	Gfo0pRxK/2LlrIqVEScSz95R5yL/FTdnyr8YWiu9l9Yi36qkb5l1NpX8YBQUBtOW
	dOZ0YfxhNKmlFnZ/b+6FMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926222; x=
	1739012622; bh=UFZsxfb+viKUTPtg2B71Z5+8Bn7tUSEZxoSJ2vBiVX8=; b=Z
	6XOCVtpGvJByU5hlzgM/DKjs7cUM46kSfGQTLKVH80yVunhpTL+XfC0LbPl+Fy9G
	n1cpcAPnYghvspO1SCAGgwi64nePyaSJodAWhg2QNml1/ZgGf4hurQRp3stqiJPL
	+1O+8XgIyxxQ4NldcwJMGpNCpec2jqbmYQG2h9IB8g1rkrh/MqYrRkjrY1OKO/e6
	Vt551e2lGx2a8OeqwOvZ9/nSsHkzpk71A81+TvIPtpJyBjz2juKE3qPCECrSS+Pk
	4eOfqRP6bZ0fBtJN6haMvniml54PEZNsmET9q/Lm/1y8D7vDpt9XPt7wOT1O1Zuo
	bdpIjEH0tcmp+i8oekhkg==
X-ME-Sender: <xms:jeilZ5KwVfhP0Ug7AcT889_s_jylDaZCyJXVJM7ZzhB8REJb8wPgRg>
    <xme:jeilZ1J2rWPnw9IeMCcsESsb9FlfQDqF1jYGetTbysTmpN6TTvKvGC1Z7zmbNpR3u
    bnDMUmq2F8Qu1CHaA>
X-ME-Received: <xmr:jeilZxtlIXBnBMLkVeSe9WbvpbzhxAJjNA19kM_0c3sgzXY6R8Lwx4b_DA2jlWJ-RBQo7P9T3CfaeZWF-H3sUnPlsmTS0amb9qRHXjwB9imMQ4Bo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jeilZ6a61aJ9ADyzng3XYKTrUF-Wq-sWy1hRZUlRODwPuve7EBt6uQ>
    <xmx:jeilZwZh_Zv5dlu-IZ9FPeYh_fn3blf5gUIVBvplE_m962KeB9d2eQ>
    <xmx:jeilZ-BPfDahRHpm9DHJdkCpTuv68vCj8yOoAieuLWUyTHLHq9OZ2Q>
    <xmx:jeilZ-bTzjcGsCN9X6Q0OdoFWcjWuCyohIHTmyJDrZT-rGLdJWGCkA>
    <xmx:juilZ4HRqsw7hd1CGHq_1o2uaWDhl08uARE1M2A0hyka3VEyFwDNDeIq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:03:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d8c3f9ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:03:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:03:37 +0100
Subject: [PATCH v2 12/16] path: drop `git_path()` in favor of
 `repo_git_path()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-b4-pks-path-drop-the-repository-v2-12-13cad3c11b8a@pks.im>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
X-Mailer: b4 0.14.2

Remove `git_path()` in favor of the `repo_git_path()` family of
functions, which makes the implicit dependency on `the_repository` go
away.

Note that `git_path()` returned a string allocated via `get_pathname()`,
which uses a rotating set of statically allocated buffers. Consequently,
callers didn't have to free the returned string. The same isn't true for
`repo_common_path()`, so we also have to add logic to free the returned
strings.

This refactoring also allows us to remove `repo_common_pathv()` as well
as `get_pathname()` from the public interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit.c    |  8 +++++---
 builtin/gc.c        | 21 +++++++++++++++------
 builtin/notes.c     |  7 ++++++-
 builtin/rebase.c    |  2 +-
 builtin/remote.c    |  6 ++++--
 builtin/rev-parse.c |  6 +++---
 builtin/worktree.c  | 11 +++++++++--
 notes-merge.c       | 20 ++++++++++++--------
 path.c              |  8 ++++----
 path.h              | 27 ---------------------------
 read-cache.c        | 24 +++++++++++++++++-------
 remote.c            | 21 ++++++++++++---------
 rerere.c            | 14 +++++++++++---
 shallow.c           |  4 +++-
 wt-status.c         | 42 ++++++++++++++++++++++++++----------------
 15 files changed, 128 insertions(+), 93 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9fb405dd4a..2f45968222 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -352,6 +352,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	struct pathspec pathspec;
 	int refresh_flags = REFRESH_QUIET;
 	const char *ret;
+	char *path = NULL;
 
 	if (is_status)
 		refresh_flags |= REFRESH_UNMERGED;
@@ -524,9 +525,9 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	if (write_locked_index(the_repository->index, &index_lock, 0))
 		die(_("unable to write new index file"));
 
-	hold_lock_file_for_update(&false_lock,
-				  git_path("next-index-%"PRIuMAX,
-					   (uintmax_t) getpid()),
+	path = repo_git_path(the_repository, "next-index-%"PRIuMAX,
+			     (uintmax_t) getpid());
+	hold_lock_file_for_update(&false_lock, path,
 				  LOCK_DIE_ON_ERROR);
 
 	create_base_index(current_head);
@@ -542,6 +543,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 out:
 	string_list_clear(&partial, 0);
 	clear_pathspec(&pathspec);
+	free(path);
 	return ret;
 }
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 57f6aee174..5923d9a05b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -99,9 +99,11 @@ static void process_log_file(void)
 		/* There was some error recorded in the lock file */
 		commit_lock_file(&log_lock);
 	} else {
+		char *path = repo_git_path(the_repository, "gc.log");
 		/* No error, clean up any old gc.log */
-		unlink(git_path("gc.log"));
+		unlink(path);
 		rollback_lock_file(&log_lock);
+		free(path);
 	}
 }
 
@@ -299,8 +301,11 @@ static int too_many_loose_objects(struct gc_config *cfg)
 	int num_loose = 0;
 	int needed = 0;
 	const unsigned hexsz_loose = the_hash_algo->hexsz - 2;
+	char *path;
 
-	dir = opendir(git_path("objects/17"));
+	path = repo_git_path(the_repository, "objects/17");
+	dir = opendir(path);
+	free(path);
 	if (!dir)
 		return 0;
 
@@ -821,11 +826,12 @@ struct repository *repo UNUSED)
 	}
 
 	if (daemonized) {
-		hold_lock_file_for_update(&log_lock,
-					  git_path("gc.log"),
+		char *path = repo_git_path(the_repository, "gc.log");
+		hold_lock_file_for_update(&log_lock, path,
 					  LOCK_DIE_ON_ERROR);
 		dup2(get_lock_file_fd(&log_lock), 2);
 		atexit(process_log_file_at_exit);
+		free(path);
 	}
 
 	gc_before_repack(&opts, &cfg);
@@ -887,8 +893,11 @@ struct repository *repo UNUSED)
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 
-	if (!daemonized)
-		unlink(git_path("gc.log"));
+	if (!daemonized) {
+		char *path = repo_git_path(the_repository, "gc.log");
+		unlink(path);
+		free(path);
+	}
 
 out:
 	gc_config_release(&cfg);
diff --git a/builtin/notes.c b/builtin/notes.c
index 18bcbb2f91..ff61ec5f2d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -979,6 +979,8 @@ static int merge(int argc, const char **argv, const char *prefix,
 	else { /* Merge has unresolved conflicts */
 		struct worktree **worktrees;
 		const struct worktree *wt;
+		char *path;
+
 		/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
 		refs_update_ref(get_main_ref_store(the_repository), msg.buf,
 				"NOTES_MERGE_PARTIAL", &result_oid, NULL,
@@ -994,10 +996,13 @@ static int merge(int argc, const char **argv, const char *prefix,
 		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", notes_ref, NULL))
 			die(_("failed to store link to current notes ref (%s)"),
 			    notes_ref);
+
+		path = repo_git_path(the_repository, NOTES_MERGE_WORKTREE);
 		fprintf(stderr, _("Automatic notes merge failed. Fix conflicts in %s "
 				  "and commit the result with 'git notes merge --commit', "
 				  "or abort the merge with 'git notes merge --abort'.\n"),
-			git_path(NOTES_MERGE_WORKTREE));
+			path);
+		free(path);
 	}
 
 	free_notes(t);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6c9eaf3788..d4715ed35d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -644,7 +644,7 @@ static int run_am(struct rebase_options *opts)
 		return run_command(&am);
 	}
 
-	rebased_patches = xstrdup(git_path("rebased-patches"));
+	rebased_patches = repo_git_path(the_repository, "rebased-patches");
 	format_patch.out = open(rebased_patches,
 				O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (format_patch.out < 0) {
diff --git a/builtin/remote.c b/builtin/remote.c
index 71d84fb3cf..0489fcc8f3 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -644,9 +644,11 @@ static int migrate_file(struct remote *remote)
 		git_config_set_multivar(buf.buf, remote->fetch.items[i].raw, "^$", 0);
 #ifndef WITH_BREAKING_CHANGES
 	if (remote->origin == REMOTE_REMOTES)
-		unlink_or_warn(git_path("remotes/%s", remote->name));
+		unlink_or_warn(repo_git_path_replace(the_repository, &buf,
+						     "remotes/%s", remote->name));
 	else if (remote->origin == REMOTE_BRANCHES)
-		unlink_or_warn(git_path("branches/%s", remote->name));
+		unlink_or_warn(repo_git_path_replace(the_repository, &buf,
+						     "branches/%s", remote->name));
 #endif /* WITH_BREAKING_CHANGES */
 	strbuf_release(&buf);
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 428c866c05..490da33bec 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -789,8 +789,8 @@ int cmd_rev_parse(int argc,
 			if (!strcmp(arg, "--git-path")) {
 				if (!argv[i + 1])
 					die(_("--git-path requires an argument"));
-				strbuf_reset(&buf);
-				print_path(git_path("%s", argv[i + 1]), prefix,
+				print_path(repo_git_path_replace(the_repository, &buf,
+								 "%s", argv[i + 1]), prefix,
 						format,
 						DEFAULT_RELATIVE_IF_SHARED);
 				i++;
@@ -1083,7 +1083,7 @@ int cmd_rev_parse(int argc,
 					die(_("Could not read the index"));
 				if (the_repository->index->split_index) {
 					const struct object_id *oid = &the_repository->index->split_index->base_oid;
-					const char *path = git_path("sharedindex.%s", oid_to_hex(oid));
+					const char *path = repo_git_path_replace(the_repository, &buf, "sharedindex.%s", oid_to_hex(oid));
 					print_path(path, prefix, format, DEFAULT_RELATIVE);
 				}
 				continue;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 761e302a36..48448a8355 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -163,7 +163,9 @@ static int delete_git_dir(const char *id)
 
 static void delete_worktrees_dir_if_empty(void)
 {
-	rmdir(git_path("worktrees")); /* ignore failed removal */
+	char *path = repo_git_path(the_repository, "worktrees");
+	rmdir(path); /* ignore failed removal */
+	free(path);
 }
 
 static void prune_worktree(const char *id, const char *reason)
@@ -212,8 +214,13 @@ static void prune_worktrees(void)
 	struct strbuf reason = STRBUF_INIT;
 	struct strbuf main_path = STRBUF_INIT;
 	struct string_list kept = STRING_LIST_INIT_DUP;
-	DIR *dir = opendir(git_path("worktrees"));
+	char *path;
+	DIR *dir;
 	struct dirent *d;
+
+	path = repo_git_path(the_repository, "worktrees");
+	dir = opendir(path);
+	free(path);
 	if (!dir)
 		return;
 	while ((d = readdir_skip_dot_and_dotdot(dir)) != NULL) {
diff --git a/notes-merge.c b/notes-merge.c
index 8c22a171c1..67a472020d 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -275,34 +275,38 @@ static void diff_tree_local(struct notes_merge_options *o,
 
 static void check_notes_merge_worktree(struct notes_merge_options *o)
 {
+	struct strbuf buf = STRBUF_INIT;
+
 	if (!o->has_worktree) {
 		/*
 		 * Must establish NOTES_MERGE_WORKTREE.
 		 * Abort if NOTES_MERGE_WORKTREE already exists
 		 */
-		if (file_exists(git_path(NOTES_MERGE_WORKTREE)) &&
-		    !is_empty_dir(git_path(NOTES_MERGE_WORKTREE))) {
+		if (file_exists(repo_git_path_replace(the_repository, &buf, NOTES_MERGE_WORKTREE)) &&
+		    !is_empty_dir(repo_git_path_replace(the_repository, &buf, NOTES_MERGE_WORKTREE))) {
 			if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
 				die(_("You have not concluded your previous "
 				    "notes merge (%s exists).\nPlease, use "
 				    "'git notes merge --commit' or 'git notes "
 				    "merge --abort' to commit/abort the "
 				    "previous merge before you start a new "
-				    "notes merge."), git_path("NOTES_MERGE_*"));
+				    "notes merge."), repo_git_path_replace(the_repository, &buf, "NOTES_MERGE_*"));
 			else
 				die(_("You have not concluded your notes merge "
-				    "(%s exists)."), git_path("NOTES_MERGE_*"));
+				    "(%s exists)."), repo_git_path_replace(the_repository, &buf, "NOTES_MERGE_*"));
 		}
 
-		if (safe_create_leading_directories_const(git_path(
+		if (safe_create_leading_directories_const(repo_git_path_replace(the_repository, &buf,
 				NOTES_MERGE_WORKTREE "/.test")))
 			die_errno("unable to create directory %s",
-				  git_path(NOTES_MERGE_WORKTREE));
+				  repo_git_path_replace(the_repository, &buf, NOTES_MERGE_WORKTREE));
 		o->has_worktree = 1;
-	} else if (!file_exists(git_path(NOTES_MERGE_WORKTREE)))
+	} else if (!file_exists(repo_git_path_replace(the_repository, &buf, NOTES_MERGE_WORKTREE)))
 		/* NOTES_MERGE_WORKTREE should already be established */
 		die("missing '%s'. This should not happen",
-		    git_path(NOTES_MERGE_WORKTREE));
+		    repo_git_path_replace(the_repository, &buf, NOTES_MERGE_WORKTREE));
+
+	strbuf_release(&buf);
 }
 
 static void write_buf_to_worktree(const struct object_id *obj,
diff --git a/path.c b/path.c
index 2d07ba723d..a42f72800d 100644
--- a/path.c
+++ b/path.c
@@ -30,7 +30,7 @@ static int get_st_mode_bits(const char *path, int *mode)
 	return 0;
 }
 
-struct strbuf *get_pathname(void)
+static struct strbuf *get_pathname(void)
 {
 	static struct strbuf pathname_array[4] = {
 		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
@@ -417,9 +417,9 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
 		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
 }
 
-void repo_git_pathv(const struct repository *repo,
-		    const struct worktree *wt, struct strbuf *buf,
-		    const char *fmt, va_list args)
+static void repo_git_pathv(const struct repository *repo,
+			   const struct worktree *wt, struct strbuf *buf,
+			   const char *fmt, va_list args)
 {
 	int gitdir_len;
 	strbuf_worktree_gitdir(buf, repo, wt);
diff --git a/path.h b/path.h
index bed0a4c6f9..f28d5a7ca9 100644
--- a/path.h
+++ b/path.h
@@ -221,37 +221,10 @@ char *xdg_cache_home(const char *filename);
  */
 void safe_create_dir(const char *dir, int share);
 
-/*
- * Do not use this function. It is only exported to other subsystems until we
- * can get rid of the below block of functions that implicitly rely on
- * `the_repository`.
- */
-struct strbuf *get_pathname(void);
-
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
 #  include "repository.h"
 
-/* Internal implementation details that should not be used. */
-void repo_git_pathv(const struct repository *repo,
-		    const struct worktree *wt, struct strbuf *buf,
-		    const char *fmt, va_list args);
-
-/*
- * Return a statically allocated path into the main repository's
- * (the_repository) git directory.
- */
-__attribute__((format (printf, 1, 2)))
-static inline const char *git_path(const char *fmt, ...)
-{
-	struct strbuf *pathname = get_pathname();
-	va_list args;
-	va_start(args, fmt);
-	repo_git_pathv(the_repository, NULL, pathname, fmt, args);
-	va_end(args);
-	return pathname->buf;
-}
-
 #define GIT_PATH_FUNC(func, filename) \
 	const char *func(void) \
 	{ \
diff --git a/read-cache.c b/read-cache.c
index d54be2c172..66ad0015a7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3251,15 +3251,18 @@ static int clean_shared_index_files(const char *current_hex)
 
 	while ((de = readdir(dir)) != NULL) {
 		const char *sha1_hex;
-		const char *shared_index_path;
+		char *shared_index_path;
 		if (!skip_prefix(de->d_name, "sharedindex.", &sha1_hex))
 			continue;
 		if (!strcmp(sha1_hex, current_hex))
 			continue;
-		shared_index_path = git_path("%s", de->d_name);
+
+		shared_index_path = repo_git_path(the_repository, "%s", de->d_name);
 		if (should_delete_shared_index(shared_index_path) > 0 &&
 		    unlink(shared_index_path))
 			warning_errno(_("unable to unlink: %s"), shared_index_path);
+
+		free(shared_index_path);
 	}
 	closedir(dir);
 
@@ -3271,6 +3274,7 @@ static int write_shared_index(struct index_state *istate,
 {
 	struct split_index *si = istate->split_index;
 	int ret, was_full = !istate->sparse_index;
+	char *path;
 
 	move_cache_to_base_index(istate);
 	convert_to_sparse(istate, 0);
@@ -3291,13 +3295,15 @@ static int write_shared_index(struct index_state *istate,
 		error(_("cannot fix permission bits on '%s'"), get_tempfile_path(*temp));
 		return ret;
 	}
-	ret = rename_tempfile(temp,
-			      git_path("sharedindex.%s", oid_to_hex(&si->base->oid)));
+
+	path = repo_git_path(the_repository, "sharedindex.%s", oid_to_hex(&si->base->oid));
+	ret = rename_tempfile(temp, path);
 	if (!ret) {
 		oidcpy(&si->base_oid, &si->base->oid);
 		clean_shared_index_files(oid_to_hex(&si->base->oid));
 	}
 
+	free(path);
 	return ret;
 }
 
@@ -3378,9 +3384,12 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if (new_shared_index) {
 		struct tempfile *temp;
 		int saved_errno;
+		char *path;
 
 		/* Same initial permissions as the main .git/index file */
-		temp = mks_tempfile_sm(git_path("sharedindex_XXXXXX"), 0, 0666);
+		path = repo_git_path(the_repository, "sharedindex_XXXXXX");
+		temp = mks_tempfile_sm(path, 0, 0666);
+		free(path);
 		if (!temp) {
 			ret = do_write_locked_index(istate, lock, flags,
 						    ~WRITE_SPLIT_INDEX_EXTENSION);
@@ -3401,9 +3410,10 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 
 	/* Freshen the shared index only if the split-index was written */
 	if (!ret && !new_shared_index && !is_null_oid(&si->base_oid)) {
-		const char *shared_index = git_path("sharedindex.%s",
-						    oid_to_hex(&si->base_oid));
+		char *shared_index = repo_git_path(the_repository, "sharedindex.%s",
+						   oid_to_hex(&si->base_oid));
 		freshen_shared_index(shared_index, 1);
+		free(shared_index);
 	}
 
 out:
diff --git a/remote.c b/remote.c
index 1779f0e7bb..81d151a507 100644
--- a/remote.c
+++ b/remote.c
@@ -321,10 +321,11 @@ static void read_remotes_file(struct remote_state *remote_state,
 			      struct remote *remote)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen_or_warn(git_path("remotes/%s", remote->name), "r");
+	FILE *f = fopen_or_warn(repo_git_path_append(the_repository, &buf,
+						     "remotes/%s", remote->name), "r");
 
 	if (!f)
-		return;
+		goto out;
 
 	warn_about_deprecated_remote_type("remotes", remote);
 
@@ -343,8 +344,10 @@ static void read_remotes_file(struct remote_state *remote_state,
 		else if (skip_prefix(buf.buf, "Pull:", &v))
 			refspec_append(&remote->fetch, skip_spaces(v));
 	}
-	strbuf_release(&buf);
 	fclose(f);
+
+out:
+	strbuf_release(&buf);
 }
 
 static void read_branches_file(struct remote_state *remote_state,
@@ -352,20 +355,19 @@ static void read_branches_file(struct remote_state *remote_state,
 {
 	char *frag, *to_free = NULL;
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen_or_warn(git_path("branches/%s", remote->name), "r");
+	FILE *f = fopen_or_warn(repo_git_path_append(the_repository, &buf,
+						     "branches/%s", remote->name), "r");
 
 	if (!f)
-		return;
+		goto out;
 
 	warn_about_deprecated_remote_type("branches", remote);
 
 	strbuf_getline_lf(&buf, f);
 	fclose(f);
 	strbuf_trim(&buf);
-	if (!buf.len) {
-		strbuf_release(&buf);
-		return;
-	}
+	if (!buf.len)
+		goto out;
 
 	remote->configured_in_repo = 1;
 	remote->origin = REMOTE_BRANCHES;
@@ -393,6 +395,7 @@ static void read_branches_file(struct remote_state *remote_state,
 	refspec_appendf(&remote->push, "HEAD:refs/heads/%s", frag);
 	remote->fetch_tags = 1; /* always auto-follow */
 
+out:
 	strbuf_release(&buf);
 	free(to_free);
 }
diff --git a/rerere.c b/rerere.c
index 763cb715a6..2239c2d775 100644
--- a/rerere.c
+++ b/rerere.c
@@ -127,8 +127,12 @@ static int is_rr_file(const char *name, const char *filename, int *variant)
 static void scan_rerere_dir(struct rerere_dir *rr_dir)
 {
 	struct dirent *de;
-	DIR *dir = opendir(git_path("rr-cache/%s", rr_dir->name));
+	char *path;
+	DIR *dir;
 
+	path = repo_git_path(the_repository, "rr-cache/%s", rr_dir->name);
+	dir = opendir(path);
+	free(path);
 	if (!dir)
 		return;
 	while ((de = readdir(dir)) != NULL) {
@@ -1234,6 +1238,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	timestamp_t now = time(NULL);
 	timestamp_t cutoff_noresolve = now - 15 * 86400;
 	timestamp_t cutoff_resolve = now - 60 * 86400;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (setup_rerere(r, rr, 0) < 0)
 		return;
@@ -1243,7 +1248,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	repo_config_get_expiry_in_days(the_repository, "gc.rerereunresolved",
 				       &cutoff_noresolve, now);
 	git_config(git_default_config, NULL);
-	dir = opendir(git_path("rr-cache"));
+	dir = opendir(repo_git_path_replace(the_repository, &buf, "rr-cache"));
 	if (!dir)
 		die_errno(_("unable to open rr-cache directory"));
 	/* Collect stale conflict IDs ... */
@@ -1272,9 +1277,12 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 
 	/* ... and then remove the empty directories */
 	for (i = 0; i < to_remove.nr; i++)
-		rmdir(git_path("rr-cache/%s", to_remove.items[i].string));
+		rmdir(repo_git_path_replace(the_repository, &buf,
+					    "rr-cache/%s", to_remove.items[i].string));
+
 	string_list_clear(&to_remove, 0);
 	rollback_lock_file(&write_lock);
+	strbuf_release(&buf);
 }
 
 /*
diff --git a/shallow.c b/shallow.c
index b54244ffa9..4bd9342c9a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -364,7 +364,9 @@ const char *setup_temporary_shallow(const struct oid_array *extra)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (write_shallow_commits(&sb, 0, extra)) {
-		temp = xmks_tempfile(git_path("shallow_XXXXXX"));
+		char *path = repo_git_path(the_repository, "shallow_XXXXXX");
+		temp = xmks_tempfile(path);
+		free(path);
 
 		if (write_in_full(temp->fd, sb.buf, sb.len) < 0 ||
 		    close_tempfile_gently(temp) < 0)
diff --git a/wt-status.c b/wt-status.c
index 3ee9181764..1da5732f57 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1289,7 +1289,8 @@ static void show_am_in_progress(struct wt_status *s,
 static char *read_line_from_git_path(const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *fp = fopen_or_warn(git_path("%s", filename), "r");
+	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
+						      "%s", filename), "r");
 
 	if (!fp) {
 		strbuf_release(&buf);
@@ -1383,27 +1384,33 @@ static void abbrev_oid_in_line(struct strbuf *line)
 
 static int read_rebase_todolist(const char *fname, struct string_list *lines)
 {
-	struct strbuf line = STRBUF_INIT;
-	FILE *f = fopen(git_path("%s", fname), "r");
+	struct strbuf buf = STRBUF_INIT;
+	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
+	int ret;
 
 	if (!f) {
-		if (errno == ENOENT)
-			return -1;
+		if (errno == ENOENT) {
+			ret = -1;
+			goto out;
+		}
 		die_errno("Could not open file %s for reading",
-			  git_path("%s", fname));
+			  repo_git_path_replace(the_repository, &buf, "%s", fname));
 	}
-	while (!strbuf_getline_lf(&line, f)) {
-		if (starts_with(line.buf, comment_line_str))
+	while (!strbuf_getline_lf(&buf, f)) {
+		if (starts_with(buf.buf, comment_line_str))
 			continue;
-		strbuf_trim(&line);
-		if (!line.len)
+		strbuf_trim(&buf);
+		if (!buf.len)
 			continue;
-		abbrev_oid_in_line(&line);
-		string_list_append(lines, line.buf);
+		abbrev_oid_in_line(&buf);
+		string_list_append(lines, buf.buf);
 	}
 	fclose(f);
-	strbuf_release(&line);
-	return 0;
+
+	ret = 0;
+out:
+	strbuf_release(&buf);
+	return ret;
 }
 
 static void show_rebase_information(struct wt_status *s,
@@ -1434,9 +1441,12 @@ static void show_rebase_information(struct wt_status *s,
 				i < have_done.nr;
 				i++)
 				status_printf_ln(s, color, "   %s", have_done.items[i].string);
-			if (have_done.nr > nr_lines_to_show && s->hints)
+			if (have_done.nr > nr_lines_to_show && s->hints) {
+				char *path = repo_git_path(the_repository, "rebase-merge/done");
 				status_printf_ln(s, color,
-					_("  (see more in file %s)"), git_path("rebase-merge/done"));
+					_("  (see more in file %s)"), path);
+				free(path);
+			}
 		}
 
 		if (yet_to_do.nr == 0)

-- 
2.48.1.538.gc4cfc42d60.dirty

