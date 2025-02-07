Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F81F1DF73E
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926221; cv=none; b=ba+ssL2dPR4NrHZ9TFfV2oUkGrQYT0FtLVl8KRaEPfcCSdSKAdcQZ+OwTJQI/wO6wt4nA08FkKZMPwTReunQvRoWUyXDD+xlIVc1Z4ElqZI+ohIPt4o/1ativTuFTGpY75abZ0jzjfu+1VfAe8yDL0tSTI7L7rI8FO6CkaiWY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926221; c=relaxed/simple;
	bh=TNdn/8zW3ZPqk7eQoJ76KFfnDdZZ7klBnnSoEHcoXs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUW8FJQ35lHW9ZxOSn7SzwsVFsE+sxImBjuSwiqszrQ6zWkzkkWCqUXo55UctS+DXiRvE++Dr4c6hPwGK//R3MMFIiPgThW5Uohycas8wkRk6a0kfGeIl81aVgk4nSpS/pxnSbX+QnCLx6jAICpWiT1tvSca/kYzMIupHql3Hos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BlWeERPi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BrKpVpG9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BlWeERPi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BrKpVpG9"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 924CB1140120;
	Fri,  7 Feb 2025 06:03:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 07 Feb 2025 06:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738926218;
	 x=1739012618; bh=SiGCfHrc9FVKF9PXlxyADN2g6y0Do9oyhurkTi+mwLI=; b=
	BlWeERPiY8f3cGYyFoW/FSbK9FblASuh9H+5pKb4PjjFFBmJaUAT6PIArtaAyW4N
	5r+Dede9UEMk+rp3eHGAaWZy0QOwWCuDITjwHJhHguWtZD1zNwLdHjw7M7dECnpX
	+eYxfbthNjwI6V04/tM2nARxzE7OyabEQ8rWRFcJA/rBzhSada2IgYwePWhc6OP/
	w2nAo+5YNTy1zbtfMWLfgNyO/Nh0P3tG5AgLWWQY19nhPXSQ+pi+kNvJfzkBv+7J
	v09n5B39lmxuXixxInijnBMxBZtIf/fv6rApej3ojPJ3Ku0R98ubrIZRfKgLpBj3
	IVnFmSIbtVIrHFMcFOJGog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926218; x=
	1739012618; bh=SiGCfHrc9FVKF9PXlxyADN2g6y0Do9oyhurkTi+mwLI=; b=B
	rKpVpG9MPrNU0p8N49OpBOz2GRvXt8j/NociMXqEqrPiTWMdCG5H92ErUKPpamLs
	8tGt/f/JI3w3v46xb0kSbPp+34t1AV4FhCMoZIfQN+N4r5ZUijhoC+69TTh2gH63
	bUf7CoXkQ5n2P6kDZDx/o4hWGsB2LqyVhT3yQ49/+LUirXgUNpusOoqs5uI8l//V
	QXSYl7NfR9USsUaHl3zJ3cPJdu5NKisOqIMPquUSN5jNqITkgbL/sNFHD39QXO3v
	VVFXcP0WC/1ZVav0XSDVerhhnOqAeMkWkiXqyFi/PvoB8eMXgPc2uDMGSUD4tbGi
	HSkDGR+lyT6VUs2M4//+Q==
X-ME-Sender: <xms:iuilZ-sUqM9yO3F2lGzzLc9szucNU-LJ7lM8Yer5tMGfGf1VFtY4eg>
    <xme:iuilZzcm9sfgQvExsNWPMg41bFsGACVEkebOUDFFdPBejzXcwvyhGtkznFZnhCDZ3
    n3xRcG2HtEjlXvGwg>
X-ME-Received: <xmr:iuilZ5wHOC5-HZrHc25kr_Pu6Wp7746tr7ZdPQxfTT-FBEZmnTzhuAeR4OsvOpbmLAP1C4H896yqBrBSMSx5pVGgw8C1eHKvZCGCSyOA7F6dTQ9y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:iuilZ5PRZJWCzJdlOzzQb6U-K63tlpflEQBcIv3qLqtkyAhllY6wug>
    <xmx:iuilZ-8R_xnM1k6PsglG5TvQpfsmXzGu6pJ-s_JuExhRgrLxR98qbg>
    <xmx:iuilZxX58YYkC_rEN5lJxRcm8CTP6iO5WUJAu-2EmQtEyzi7yYADvA>
    <xmx:iuilZ3d9ySLTbbi2yV9HCnzFbsl_RIiJ-tYKI9HWgypiiWAjrC3mLw>
    <xmx:iuilZ1aMlp9DWwo2eGoOabmr9SeW8ZRkh9Wt9sZ0NtxLQ7EuVGXNgsnS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:03:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e4881afb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:03:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:03:34 +0100
Subject: [PATCH v2 09/16] worktree: return allocated string from
 `get_worktree_git_dir()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-b4-pks-path-drop-the-repository-v2-9-13cad3c11b8a@pks.im>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
X-Mailer: b4 0.14.2

The `get_worktree_git_dir()` function returns a string constant that
does not need to be free'd by the caller. This string is computed for
three different cases:

  - If we don't have a worktree we return a path into the Git directory.
    The returned string is owned by `the_repository`, so there is no
    need for the caller to free it.

  - If we have a worktree, but no worktree ID then the caller requests
    the main worktree. In this case we return a path into the common
    directory, which again is owned by `the_repository` and thus does
    not need to be free'd.

  - In the third case, where we have an actual worktree, we compute the
    path relative to "$GIT_COMMON_DIR/worktrees/". This string does not
    need to be released either, even though `git_common_path()` ends up
    allocating memory. But this doesn't result in a memory leak either
    because we write into a buffer returned by `get_pathname()`, which
    returns one out of four static buffers.

We're about to drop `git_common_path()` in favor of `repo_common_path()`,
which doesn't use the same mechanism but instead returns an allocated
string owned by the caller. While we could adapt `get_worktree_git_dir()`
to also use `get_pathname()` and print the derived common path into that
buffer, the whole schema feels a lot like premature optimization in this
context. There are some callsites where we call `get_worktree_git_dir()`
in a loop that iterates through all worktrees. But none of these loops
seem to be even remotely in the hot path, so saving a single allocation
there does not feel worth it.

Refactor the function to instead consistently return an allocated path
so that we can start using `repo_common_path()` in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c               |  7 +++++--
 builtin/fsck.c         |  8 ++++++--
 builtin/receive-pack.c |  4 +++-
 builtin/worktree.c     | 10 ++++++++--
 reachable.c            |  6 +++++-
 revision.c             |  7 ++++++-
 worktree.c             | 11 ++++++-----
 worktree.h             |  2 +-
 8 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/branch.c b/branch.c
index 77716966fe..91297d55ac 100644
--- a/branch.c
+++ b/branch.c
@@ -397,7 +397,7 @@ static void prepare_checked_out_branches(void)
 	worktrees = get_worktrees();
 
 	while (worktrees[i]) {
-		char *old;
+		char *old, *wt_gitdir;
 		struct wt_status_state state = { 0 };
 		struct worktree *wt = worktrees[i++];
 		struct string_list update_refs = STRING_LIST_INIT_DUP;
@@ -437,7 +437,8 @@ static void prepare_checked_out_branches(void)
 		}
 		wt_status_state_free_buffers(&state);
 
-		if (!sequencer_get_update_refs_state(get_worktree_git_dir(wt),
+		wt_gitdir = get_worktree_git_dir(wt);
+		if (!sequencer_get_update_refs_state(wt_gitdir,
 						     &update_refs)) {
 			struct string_list_item *item;
 			for_each_string_list_item(item, &update_refs) {
@@ -448,6 +449,8 @@ static void prepare_checked_out_branches(void)
 			}
 			string_list_clear(&update_refs, 1);
 		}
+
+		free(wt_gitdir);
 	}
 
 	free_worktrees(worktrees);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index c12203e012..eea1d43647 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1057,7 +1057,7 @@ int cmd_fsck(int argc,
 			struct worktree *wt = *p;
 			struct index_state istate =
 				INDEX_STATE_INIT(the_repository);
-			char *path;
+			char *path, *wt_gitdir;
 
 			/*
 			 * Make a copy since the buffer is reusable
@@ -1065,9 +1065,13 @@ int cmd_fsck(int argc,
 			 * while we're examining the index.
 			 */
 			path = xstrdup(worktree_git_path(the_repository, wt, "index"));
-			read_index_from(&istate, path, get_worktree_git_dir(wt));
+			wt_gitdir = get_worktree_git_dir(wt);
+
+			read_index_from(&istate, path, wt_gitdir);
 			fsck_index(&istate, path, wt->is_current);
+
 			discard_index(&istate);
+			free(wt_gitdir);
 			free(path);
 		}
 		free_worktrees(worktrees);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b7ea774609..d65a441f32 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1435,7 +1435,8 @@ static const char *push_to_checkout(unsigned char *hash,
 
 static const char *update_worktree(unsigned char *sha1, const struct worktree *worktree)
 {
-	const char *retval, *git_dir;
+	const char *retval;
+	char *git_dir;
 	struct strvec env = STRVEC_INIT;
 	int invoked_hook;
 
@@ -1453,6 +1454,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 		retval = push_to_deploy(sha1, &env, worktree->path);
 
 	strvec_clear(&env);
+	free(git_dir);
 	return retval;
 }
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7959b10d26..2cea9441a6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -657,8 +657,9 @@ static int can_use_local_refs(const struct add_opts *opts)
 		if (!opts->quiet) {
 			struct strbuf path = STRBUF_INIT;
 			struct strbuf contents = STRBUF_INIT;
+			char *wt_gitdir = get_worktree_git_dir(NULL);
 
-			strbuf_add_real_path(&path, get_worktree_git_dir(NULL));
+			strbuf_add_real_path(&path, wt_gitdir);
 			strbuf_addstr(&path, "/HEAD");
 			strbuf_read_file(&contents, path.buf, 64);
 			strbuf_stripspace(&contents, NULL);
@@ -670,6 +671,7 @@ static int can_use_local_refs(const struct add_opts *opts)
 				  path.buf, contents.buf);
 			strbuf_release(&path);
 			strbuf_release(&contents);
+			free(wt_gitdir);
 		}
 		return 1;
 	}
@@ -1157,6 +1159,9 @@ static void validate_no_submodules(const struct worktree *wt)
 	struct index_state istate = INDEX_STATE_INIT(the_repository);
 	struct strbuf path = STRBUF_INIT;
 	int i, found_submodules = 0;
+	char *wt_gitdir;
+
+	wt_gitdir = get_worktree_git_dir(wt);
 
 	if (is_directory(worktree_git_path(the_repository, wt, "modules"))) {
 		/*
@@ -1166,7 +1171,7 @@ static void validate_no_submodules(const struct worktree *wt)
 		 */
 		found_submodules = 1;
 	} else if (read_index_from(&istate, worktree_git_path(the_repository, wt, "index"),
-				   get_worktree_git_dir(wt)) > 0) {
+				   wt_gitdir) > 0) {
 		for (i = 0; i < istate.cache_nr; i++) {
 			struct cache_entry *ce = istate.cache[i];
 			int err;
@@ -1185,6 +1190,7 @@ static void validate_no_submodules(const struct worktree *wt)
 	}
 	discard_index(&istate);
 	strbuf_release(&path);
+	free(wt_gitdir);
 
 	if (found_submodules)
 		die(_("working trees containing submodules cannot be moved or removed"));
diff --git a/reachable.c b/reachable.c
index ecf7ccf504..9ee04c89ec 100644
--- a/reachable.c
+++ b/reachable.c
@@ -65,8 +65,10 @@ static void add_rebase_files(struct rev_info *revs)
 	struct worktree **worktrees = get_worktrees();
 
 	for (struct worktree **wt = worktrees; *wt; wt++) {
+		char *wt_gitdir = get_worktree_git_dir(*wt);
+
 		strbuf_reset(&buf);
-		strbuf_addstr(&buf, get_worktree_git_dir(*wt));
+		strbuf_addstr(&buf, wt_gitdir);
 		strbuf_complete(&buf, '/');
 		len = buf.len;
 		for (size_t i = 0; i < ARRAY_SIZE(path); i++) {
@@ -74,6 +76,8 @@ static void add_rebase_files(struct rev_info *revs)
 			strbuf_addstr(&buf, path[i]);
 			add_one_file(buf.buf, revs);
 		}
+
+		free(wt_gitdir);
 	}
 	strbuf_release(&buf);
 	free_worktrees(worktrees);
diff --git a/revision.c b/revision.c
index 474fa1e767..c4390f0938 100644
--- a/revision.c
+++ b/revision.c
@@ -1874,15 +1874,20 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
 		struct index_state istate = INDEX_STATE_INIT(revs->repo);
+		char *wt_gitdir;
 
 		if (wt->is_current)
 			continue; /* current index already taken care of */
 
+		wt_gitdir = get_worktree_git_dir(wt);
+
 		if (read_index_from(&istate,
 				    worktree_git_path(the_repository, wt, "index"),
-				    get_worktree_git_dir(wt)) > 0)
+				    wt_gitdir) > 0)
 			do_add_index_objects_to_pending(revs, &istate, flags);
+
 		discard_index(&istate);
+		free(wt_gitdir);
 	}
 	free_worktrees(worktrees);
 }
diff --git a/worktree.c b/worktree.c
index 8f4fc10c44..3b94535963 100644
--- a/worktree.c
+++ b/worktree.c
@@ -59,8 +59,9 @@ static void add_head_info(struct worktree *wt)
 static int is_current_worktree(struct worktree *wt)
 {
 	char *git_dir = absolute_pathdup(repo_get_git_dir(the_repository));
-	const char *wt_git_dir = get_worktree_git_dir(wt);
+	char *wt_git_dir = get_worktree_git_dir(wt);
 	int is_current = !fspathcmp(git_dir, absolute_path(wt_git_dir));
+	free(wt_git_dir);
 	free(git_dir);
 	return is_current;
 }
@@ -175,14 +176,14 @@ struct worktree **get_worktrees(void)
 	return get_worktrees_internal(0);
 }
 
-const char *get_worktree_git_dir(const struct worktree *wt)
+char *get_worktree_git_dir(const struct worktree *wt)
 {
 	if (!wt)
-		return repo_get_git_dir(the_repository);
+		return xstrdup(repo_get_git_dir(the_repository));
 	else if (!wt->id)
-		return repo_get_common_dir(the_repository);
+		return xstrdup(repo_get_common_dir(the_repository));
 	else
-		return git_common_path("worktrees/%s", wt->id);
+		return xstrdup(git_common_path("worktrees/%s", wt->id));
 }
 
 static struct worktree *find_worktree_by_suffix(struct worktree **list,
diff --git a/worktree.h b/worktree.h
index 38145df80f..16368588a0 100644
--- a/worktree.h
+++ b/worktree.h
@@ -39,7 +39,7 @@ int submodule_uses_worktrees(const char *path);
  * Return git dir of the worktree. Note that the path may be relative.
  * If wt is NULL, git dir of current worktree is returned.
  */
-const char *get_worktree_git_dir(const struct worktree *wt);
+char *get_worktree_git_dir(const struct worktree *wt);
 
 /*
  * Search for the worktree identified unambiguously by `arg` -- typically

-- 
2.48.1.538.gc4cfc42d60.dirty

