Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74C15FA8F
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442463; cv=none; b=fWnAi1kut2/ibXyHdxcqlkkH/TlUr5Cwe+wp/bwXGKAzAG8Ez6d+9BQOPDx8adHycRGeFIqnezXA1iVWROBJPGf/HajC+GYs53cmQ7Wm+KcTOSNTNpz1/ppA4dnepVXdmAv4qFziC8DkV3ubiCpMzciLrG8hLI76W4XbGPt8zOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442463; c=relaxed/simple;
	bh=GyqZGBtke03ADE4dHAUqcN3XmzCKpB0YAtpWqvJrJxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbG3nPPRg1Uh5eGVXOaAb3kKKv4AscK7RhlP2gRID950Lb+dd1OPAfHzO3OkY4YG5axmNcbqwj2ESjt5Al/PJfO5ZB29bsjDR47bneI0Lmhsg6+afVRkz9lhRacPfKpVjb13RR9SAxblqCP9fsZZ72XY1Kzflqhw33nP9CbVm4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ObG3vmQY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gbQW1Fz3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ObG3vmQY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gbQW1Fz3"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EF31F11400E0;
	Thu, 18 Apr 2024 08:14:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 18 Apr 2024 08:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713442457; x=1713528857; bh=G3YMqe0YZv
	P01c6IzmPL2BIpiRwOOeid3+fZwV5KWA8=; b=ObG3vmQYto55fEgXslXk291Zk9
	l7AchloN/LkvV/YBXF6xKUWWjYOFspzJoi76cgPJtCYxUns3EaU/mrksPp4cN7iY
	VzuxVaXdO/JtkqmvIhMUwyHYSr85i48eJLs7yesUkx3Kgu2DVcnWevbTcYUEW3YY
	NbHhFyknlo3iOFzACO7Gzpev5/8Agugp+8WgCsAqlM3j5yq5JbfmeYJFL9Fuz4z6
	hyTYF7Gtrw1Rfzx3c6918dt36GLufBrD4Oi2oqaD9B9u5AomOLwI4o1et+6OHzyN
	rXKMWNLy64iCTgZyfownGxwmigYUAMQthlw29XlAfqSD5tmffNNu0JdWfgoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713442457; x=1713528857; bh=G3YMqe0YZvP01c6IzmPL2BIpiRwO
	Oeid3+fZwV5KWA8=; b=gbQW1Fz3T9t1xEOUVqtART9/lWojs2lGFsonGTr6SOlg
	NJrAyQ1++uU1Mc4iwu3XPVH+ENEyu2E+PNHojF6q7QjqZHfBfhgtgwTwRUtdq2OI
	ciG+hHT6kQzmV5a8LkjmnO+Nqz7hsceIvHhWkatHrS/+g7s+f8cnxxPz/lruTb18
	cr2iYnF+Iad4BGQjwb7iUBsUsqqHICIj6qJbakQTE5BwmKiZPoZROsefWf2Je8xx
	7krpr+onhDQDGe5S3QpLaAj8ymHlAkxQfZ/HMAv3MD4VIIEntedRc7DCbGYllVco
	Gnr2wsNIV/ce3Znvc9Lv53HRyjRZiKCJ3GOXUhGbGw==
X-ME-Sender: <xms:mQ4hZoykyqe2vyyKRmwK7o4HccR6dnHMTNgPRWbx-ZeqZSncnh0ILA>
    <xme:mQ4hZsTzI-KZa0hKkhcBuWkcBHiBEWkSYXsAd3eOXGZyrcxoN_2wMyjMn7YfyErhM
    _yi03xPtJtkk-LUFw>
X-ME-Received: <xmr:mQ4hZqU6YT6yS6qK5Pfu1qiFR9mZYUj4Hpp8gXWdZXLFh9YFS0UJ3YfjUWbE9LKWXSIIoF3WtETMe0sSqghgGwSQ9HhHVxsdijsP61P2y_UADkdvpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:mQ4hZmiiFVUf5exC2Igm_jumGEm3LdhAjzU5661lvN76K9Qh7dIVQQ>
    <xmx:mQ4hZqBaQ859Si74ELM3_ENyiXCwzuj9jTdOP0ppbhvaQVauGodP0A>
    <xmx:mQ4hZnLyfyKcIJcFXOvMDlJCf2htGxSEPPAHIXZUW0K1M4NGE1zDxw>
    <xmx:mQ4hZhA4AnQUj6a5KGAwHe4Cx320BBRvuxUxu_Vr8krjgjd5DjpPeA>
    <xmx:mQ4hZt-4XLS3g6lUXgNLfNxvc6uHFB7ShE0S4rAZZkZudUoU07yGiG_6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 08:14:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4b8700f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:13:51 +0000 (UTC)
Date: Thu, 18 Apr 2024 14:14:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] builtin: stop using `the_index`
Message-ID: <371f69a2c9023d72aab11d1b573b8fc6864df193.1713442061.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im>
 <cover.1713442061.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DadohzGqydu68p4Y"
Content-Disposition: inline
In-Reply-To: <cover.1713442061.git.ps@pks.im>


--DadohzGqydu68p4Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert builtins to use `the_repository->index` instead of `the_index`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/add.c               |  48 +++++++-------
 builtin/am.c                |  36 +++++------
 builtin/cat-file.c          |   4 +-
 builtin/check-attr.c        |   5 +-
 builtin/check-ignore.c      |   7 +--
 builtin/checkout-index.c    |  22 +++----
 builtin/checkout.c          |  87 +++++++++++++------------
 builtin/clean.c             |   7 +--
 builtin/commit.c            |  81 ++++++++++++------------
 builtin/describe.c          |   3 +-
 builtin/diff-tree.c         |   3 +-
 builtin/diff.c              |   6 +-
 builtin/difftool.c          |   4 +-
 builtin/merge-index.c       |  17 +++--
 builtin/merge-tree.c        |   3 +-
 builtin/merge.c             |  31 +++++----
 builtin/mv.c                |  68 ++++++++++----------
 builtin/pull.c              |   4 +-
 builtin/read-tree.c         |  15 +++--
 builtin/rebase.c            |   3 +-
 builtin/replay.c            |   1 -
 builtin/reset.c             |  32 +++++-----
 builtin/rev-parse.c         |   6 +-
 builtin/rm.c                |  40 ++++++------
 builtin/stash.c             |  45 +++++++------
 builtin/submodule--helper.c |  21 +++----
 builtin/update-index.c      | 122 ++++++++++++++++++------------------
 builtin/write-tree.c        |   6 +-
 28 files changed, 356 insertions(+), 371 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ae723bc85e..7689d8e7c5 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2006 Linus Torvalds
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
@@ -40,20 +40,20 @@ static int chmod_pathspec(struct pathspec *pathspec, ch=
ar flip, int show_only)
 {
 	int i, ret =3D 0;
=20
-	for (i =3D 0; i < the_index.cache_nr; i++) {
-		struct cache_entry *ce =3D the_index.cache[i];
+	for (i =3D 0; i < the_repository->index->cache_nr; i++) {
+		struct cache_entry *ce =3D the_repository->index->cache[i];
 		int err;
=20
 		if (!include_sparse &&
 		    (ce_skip_worktree(ce) ||
-		     !path_in_sparse_checkout(ce->name, &the_index)))
+		     !path_in_sparse_checkout(ce->name, the_repository->index)))
 			continue;
=20
-		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
+		if (pathspec && !ce_path_match(the_repository->index, ce, pathspec, NULL=
))
 			continue;
=20
 		if (!show_only)
-			err =3D chmod_index_entry(&the_index, ce, flip);
+			err =3D chmod_index_entry(the_repository->index, ce, flip);
 		else
 			err =3D S_ISREG(ce->ce_mode) ? 0 : -1;
=20
@@ -68,20 +68,20 @@ static int renormalize_tracked_files(const struct paths=
pec *pathspec, int flags)
 {
 	int i, retval =3D 0;
=20
-	for (i =3D 0; i < the_index.cache_nr; i++) {
-		struct cache_entry *ce =3D the_index.cache[i];
+	for (i =3D 0; i < the_repository->index->cache_nr; i++) {
+		struct cache_entry *ce =3D the_repository->index->cache[i];
=20
 		if (!include_sparse &&
 		    (ce_skip_worktree(ce) ||
-		     !path_in_sparse_checkout(ce->name, &the_index)))
+		     !path_in_sparse_checkout(ce->name, the_repository->index)))
 			continue;
 		if (ce_stage(ce))
 			continue; /* do not touch unmerged paths */
 		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
 			continue; /* do not touch non blobs */
-		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
+		if (pathspec && !ce_path_match(the_repository->index, ce, pathspec, NULL=
))
 			continue;
-		retval |=3D add_file_to_index(&the_index, ce->name,
+		retval |=3D add_file_to_index(the_repository->index, ce->name,
 					    flags | ADD_CACHE_RENORMALIZE);
 	}
=20
@@ -100,11 +100,11 @@ static char *prune_directory(struct dir_struct *dir, =
struct pathspec *pathspec,
 	i =3D dir->nr;
 	while (--i >=3D 0) {
 		struct dir_entry *entry =3D *src++;
-		if (dir_path_match(&the_index, entry, pathspec, prefix, seen))
+		if (dir_path_match(the_repository->index, entry, pathspec, prefix, seen))
 			*dst++ =3D entry;
 	}
 	dir->nr =3D dst - dir->entries;
-	add_pathspec_matches_against_index(pathspec, &the_index, seen,
+	add_pathspec_matches_against_index(pathspec, the_repository->index, seen,
 					   PS_IGNORE_SKIP_WORKTREE);
 	return seen;
 }
@@ -119,14 +119,14 @@ static int refresh(int verbose, const struct pathspec=
 *pathspec)
 		    (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
=20
 	seen =3D xcalloc(pathspec->nr, 1);
-	refresh_index(&the_index, flags, pathspec, seen,
+	refresh_index(the_repository->index, flags, pathspec, seen,
 		      _("Unstaged changes after refreshing the index:"));
 	for (i =3D 0; i < pathspec->nr; i++) {
 		if (!seen[i]) {
 			const char *path =3D pathspec->items[i].original;
=20
 			if (matches_skip_worktree(pathspec, i, &skip_worktree_seen) ||
-			    !path_in_sparse_checkout(path, &the_index)) {
+			    !path_in_sparse_checkout(path, the_repository->index)) {
 				string_list_append(&only_match_skip_worktree,
 						   pathspec->items[i].original);
 			} else {
@@ -335,12 +335,12 @@ static int add_files(struct dir_struct *dir, int flag=
s)
=20
 	for (i =3D 0; i < dir->nr; i++) {
 		if (!include_sparse &&
-		    !path_in_sparse_checkout(dir->entries[i]->name, &the_index)) {
+		    !path_in_sparse_checkout(dir->entries[i]->name, the_repository->inde=
x)) {
 			string_list_append(&matched_sparse_paths,
 					   dir->entries[i]->name);
 			continue;
 		}
-		if (add_file_to_index(&the_index, dir->entries[i]->name, flags)) {
+		if (add_file_to_index(the_repository->index, dir->entries[i]->name, flag=
s)) {
 			if (!ignore_add_errors)
 				die(_("adding files failed"));
 			exit_status =3D 1;
@@ -458,8 +458,8 @@ int cmd_add(int argc, const char **argv, const char *pr=
efix)
 	if (repo_read_index_preload(the_repository, &pathspec, 0) < 0)
 		die(_("index file corrupt"));
=20
-	die_in_unpopulated_submodule(&the_index, prefix);
-	die_path_inside_submodule(&the_index, &pathspec);
+	die_in_unpopulated_submodule(the_repository->index, prefix);
+	die_path_inside_submodule(the_repository->index, &pathspec);
=20
 	if (add_new_files) {
 		int baselen;
@@ -471,7 +471,7 @@ int cmd_add(int argc, const char **argv, const char *pr=
efix)
 		}
=20
 		/* This picks up the paths that are not tracked */
-		baselen =3D fill_directory(&dir, &the_index, &pathspec);
+		baselen =3D fill_directory(&dir, the_repository->index, &pathspec);
 		if (pathspec.nr)
 			seen =3D prune_directory(&dir, &pathspec, baselen);
 	}
@@ -488,7 +488,7 @@ int cmd_add(int argc, const char **argv, const char *pr=
efix)
=20
 		if (!seen)
 			seen =3D find_pathspecs_matching_against_index(&pathspec,
-					&the_index, PS_IGNORE_SKIP_WORKTREE);
+					the_repository->index, PS_IGNORE_SKIP_WORKTREE);
=20
 		/*
 		 * file_exists() assumes exact match
@@ -524,8 +524,8 @@ int cmd_add(int argc, const char **argv, const char *pr=
efix)
 			    !file_exists(path)) {
 				if (ignore_missing) {
 					int dtype =3D DT_UNKNOWN;
-					if (is_excluded(&dir, &the_index, path, &dtype))
-						dir_add_ignored(&dir, &the_index,
+					if (is_excluded(&dir, the_repository->index, path, &dtype))
+						dir_add_ignored(&dir, the_repository->index,
 								path, pathspec.items[i].len);
 				} else
 					die(_("pathspec '%s' did not match any files"),
@@ -566,7 +566,7 @@ int cmd_add(int argc, const char **argv, const char *pr=
efix)
 	end_odb_transaction();
=20
 finish:
-	if (write_locked_index(&the_index, &lock_file,
+	if (write_locked_index(the_repository->index, &lock_file,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write new index file"));
=20
diff --git a/builtin/am.c b/builtin/am.c
index 022cae2e8d..4db2bc3c2f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -3,7 +3,7 @@
  *
  * Based on git-am.sh by Junio C Hamano.
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
@@ -1536,8 +1536,8 @@ static int run_apply(const struct am_state *state, co=
nst char *index_file)
=20
 	if (index_file) {
 		/* Reload index as apply_all_patches() will have modified it. */
-		discard_index(&the_index);
-		read_index_from(&the_index, index_file, get_git_dir());
+		discard_index(the_repository->index);
+		read_index_from(the_repository->index, index_file, get_git_dir());
 	}
=20
 	return 0;
@@ -1579,10 +1579,10 @@ static int fall_back_threeway(const struct am_state=
 *state, const char *index_pa
 	if (build_fake_ancestor(state, index_path))
 		return error("could not build fake ancestor");
=20
-	discard_index(&the_index);
-	read_index_from(&the_index, index_path, get_git_dir());
+	discard_index(the_repository->index);
+	read_index_from(the_repository->index, index_path, get_git_dir());
=20
-	if (write_index_as_tree(&orig_tree, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(&orig_tree, the_repository->index, index_path, 0,=
 NULL))
 		return error(_("Repository lacks necessary blobs to fall back on 3-way m=
erge."));
=20
 	say(state, stdout, _("Using index info to reconstruct a base tree..."));
@@ -1608,12 +1608,12 @@ static int fall_back_threeway(const struct am_state=
 *state, const char *index_pa
 		return error(_("Did you hand edit your patch?\n"
 				"It does not apply to blobs recorded in its index."));
=20
-	if (write_index_as_tree(&their_tree, &the_index, index_path, 0, NULL))
+	if (write_index_as_tree(&their_tree, the_repository->index, index_path, 0=
, NULL))
 		return error("could not write tree");
=20
 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
=20
-	discard_index(&the_index);
+	discard_index(the_repository->index);
 	repo_read_index(the_repository);
=20
 	/*
@@ -1660,7 +1660,7 @@ static void do_commit(const struct am_state *state)
 	if (!state->no_verify && run_hooks("pre-applypatch"))
 		exit(1);
=20
-	if (write_index_as_tree(&tree, &the_index, get_index_file(), 0, NULL))
+	if (write_index_as_tree(&tree, the_repository->index, get_index_file(), 0=
, NULL))
 		die(_("git write-tree failed to write a tree"));
=20
 	if (!repo_get_oid_commit(the_repository, "HEAD", &parent)) {
@@ -1948,7 +1948,7 @@ static void am_resolve(struct am_state *state, int al=
low_empty)
 		}
 	}
=20
-	if (unmerged_index(&the_index)) {
+	if (unmerged_index(the_repository->index)) {
 		printf_ln(_("You still have unmerged paths in your index.\n"
 			"You should 'git add' each file with resolved conflicts to mark them as=
 such.\n"
 			"You might run `git rm` on a file to accept \"deleted by them\" for it.=
"));
@@ -1987,12 +1987,12 @@ static int fast_forward_to(struct tree *head, struc=
t tree *remote, int reset)
=20
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
=20
-	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
+	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
=20
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx =3D 1;
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
+	opts.src_index =3D the_repository->index;
+	opts.dst_index =3D the_repository->index;
 	opts.update =3D 1;
 	opts.merge =3D 1;
 	opts.reset =3D reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
@@ -2006,7 +2006,7 @@ static int fast_forward_to(struct tree *head, struct =
tree *remote, int reset)
 		return -1;
 	}
=20
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
=20
 	return 0;
@@ -2029,8 +2029,8 @@ static int merge_tree(struct tree *tree)
=20
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx =3D 1;
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
+	opts.src_index =3D the_repository->index;
+	opts.dst_index =3D the_repository->index;
 	opts.merge =3D 1;
 	opts.fn =3D oneway_merge;
 	init_tree_desc(&t[0], &tree->object.oid, tree->buffer, tree->size);
@@ -2040,7 +2040,7 @@ static int merge_tree(struct tree *tree)
 		return -1;
 	}
=20
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
=20
 	return 0;
@@ -2068,7 +2068,7 @@ static int clean_index(const struct object_id *head, =
const struct object_id *rem
 	if (fast_forward_to(head_tree, head_tree, 1))
 		return -1;
=20
-	if (write_index_as_tree(&index, &the_index, get_index_file(), 0, NULL))
+	if (write_index_as_tree(&index, the_repository->index, get_index_file(), =
0, NULL))
 		return -1;
=20
 	index_tree =3D parse_tree_indirect(&index);
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0c948f40fb..43a1d7ac49 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "config.h"
 #include "convert.h"
@@ -77,7 +77,7 @@ static int filter_object(const char *path, unsigned mode,
 		struct checkout_metadata meta;
=20
 		init_checkout_metadata(&meta, NULL, NULL, oid);
-		if (convert_to_working_tree(&the_index, path, *buf, *size, &strbuf, &met=
a)) {
+		if (convert_to_working_tree(the_repository->index, path, *buf, *size, &s=
trbuf, &meta)) {
 			free(*buf);
 			*size =3D strbuf.len;
 			*buf =3D strbuf_detach(&strbuf, NULL);
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index c1da1d184e..9376810710 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "attr.h"
@@ -71,9 +70,9 @@ static void check_attr(const char *prefix, struct attr_ch=
eck *check,
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
=20
 	if (collect_all) {
-		git_all_attrs(&the_index, full_path, check);
+		git_all_attrs(the_repository->index, full_path, check);
 	} else {
-		git_check_attr(&the_index, full_path, check);
+		git_check_attr(the_repository->index, full_path, check);
 	}
 	output_attr(check, file);
=20
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 906cd96753..6c43430ec4 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
@@ -95,21 +94,21 @@ static int check_ignore(struct dir_struct *dir,
 		       PATHSPEC_KEEP_ORDER,
 		       prefix, argv);
=20
-	die_path_inside_submodule(&the_index, &pathspec);
+	die_path_inside_submodule(the_repository->index, &pathspec);
=20
 	/*
 	 * look for pathspecs matching entries in the index, since these
 	 * should not be ignored, in order to be consistent with
 	 * 'git status', 'git add' etc.
 	 */
-	seen =3D find_pathspecs_matching_against_index(&pathspec, &the_index,
+	seen =3D find_pathspecs_matching_against_index(&pathspec, the_repository-=
>index,
 						     PS_HEED_SKIP_WORKTREE);
 	for (i =3D 0; i < pathspec.nr; i++) {
 		full_path =3D pathspec.items[i].match;
 		pattern =3D NULL;
 		if (!seen[i]) {
 			int dtype =3D DT_UNKNOWN;
-			pattern =3D last_matching_pattern(dir, &the_index,
+			pattern =3D last_matching_pattern(dir, the_repository->index,
 							full_path, &dtype);
 			if (!verbose && pattern &&
 			    pattern->flags & PATTERN_FLAG_NEGATIVE)
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 2e086a204d..29e744d11b 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2005 Linus Torvalds
  *
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -69,7 +69,7 @@ static void write_tempfile_record(const char *name, const=
 char *prefix)
 static int checkout_file(const char *name, const char *prefix)
 {
 	int namelen =3D strlen(name);
-	int pos =3D index_name_pos(&the_index, name, namelen);
+	int pos =3D index_name_pos(the_repository->index, name, namelen);
 	int has_same_name =3D 0;
 	int is_file =3D 0;
 	int is_skipped =3D 1;
@@ -79,8 +79,8 @@ static int checkout_file(const char *name, const char *pr=
efix)
 	if (pos < 0)
 		pos =3D -pos - 1;
=20
-	while (pos < the_index.cache_nr) {
-		struct cache_entry *ce =3D the_index.cache[pos];
+	while (pos <the_repository->index->cache_nr) {
+		struct cache_entry *ce =3Dthe_repository->index->cache[pos];
 		if (ce_namelen(ce) !=3D namelen ||
 		    memcmp(ce->name, name, namelen))
 			break;
@@ -140,8 +140,8 @@ static int checkout_all(const char *prefix, int prefix_=
length)
 	int i, errs =3D 0;
 	struct cache_entry *last_ce =3D NULL;
=20
-	for (i =3D 0; i < the_index.cache_nr ; i++) {
-		struct cache_entry *ce =3D the_index.cache[i];
+	for (i =3D 0; i < the_repository->index->cache_nr ; i++) {
+		struct cache_entry *ce =3D the_repository->index->cache[i];
=20
 		if (S_ISSPARSEDIR(ce->ce_mode)) {
 			if (!ce_skip_worktree(ce))
@@ -154,8 +154,8 @@ static int checkout_all(const char *prefix, int prefix_=
length)
 			 * first entry inside the expanded sparse directory).
 			 */
 			if (ignore_skip_worktree) {
-				ensure_full_index(&the_index);
-				ce =3D the_index.cache[i];
+				ensure_full_index(the_repository->index);
+				ce =3D the_repository->index->cache[i];
 			}
 		}
=20
@@ -260,7 +260,7 @@ int cmd_checkout_index(int argc, const char **argv, con=
st char *prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, builtin_checkout_index_options,
 			builtin_checkout_index_usage, 0);
-	state.istate =3D &the_index;
+	state.istate =3D the_repository->index;
 	state.force =3D force;
 	state.quiet =3D quiet;
 	state.not_new =3D not_new;
@@ -280,7 +280,7 @@ int cmd_checkout_index(int argc, const char **argv, con=
st char *prefix)
 	 */
 	if (index_opt && !state.base_dir_len && !to_tempfile) {
 		state.refresh_cache =3D 1;
-		state.istate =3D &the_index;
+		state.istate =3D the_repository->index;
 		repo_hold_locked_index(the_repository, &lock_file,
 				       LOCK_DIE_ON_ERROR);
 	}
@@ -339,7 +339,7 @@ int cmd_checkout_index(int argc, const char **argv, con=
st char *prefix)
 		return 1;
=20
 	if (is_lock_file_locked(&lock_file) &&
-	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	    write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die("Unable to write new index file");
 	return 0;
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 71e6036aab..8a1d13b399 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "branch.h"
@@ -146,7 +145,7 @@ static int update_some(const struct object_id *oid, str=
uct strbuf *base,
 		return READ_TREE_RECURSIVE;
=20
 	len =3D base->len + strlen(pathname);
-	ce =3D make_empty_cache_entry(&the_index, len);
+	ce =3D make_empty_cache_entry(the_repository->index, len);
 	oidcpy(&ce->oid, oid);
 	memcpy(ce->name, base->buf, base->len);
 	memcpy(ce->name + base->len, pathname, len - base->len);
@@ -159,9 +158,9 @@ static int update_some(const struct object_id *oid, str=
uct strbuf *base,
 	 * entry in place. Whether it is UPTODATE or not, checkout_entry will
 	 * do the right thing.
 	 */
-	pos =3D index_name_pos(&the_index, ce->name, ce->ce_namelen);
+	pos =3D index_name_pos(the_repository->index, ce->name, ce->ce_namelen);
 	if (pos >=3D 0) {
-		struct cache_entry *old =3D the_index.cache[pos];
+		struct cache_entry *old =3D the_repository->index->cache[pos];
 		if (ce->ce_mode =3D=3D old->ce_mode &&
 		    !ce_intent_to_add(old) &&
 		    oideq(&ce->oid, &old->oid)) {
@@ -171,7 +170,7 @@ static int update_some(const struct object_id *oid, str=
uct strbuf *base,
 		}
 	}
=20
-	add_index_entry(&the_index, ce,
+	add_index_entry(the_repository->index, ce,
 			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 	return 0;
 }
@@ -190,8 +189,8 @@ static int read_tree_some(struct tree *tree, const stru=
ct pathspec *pathspec)
=20
 static int skip_same_name(const struct cache_entry *ce, int pos)
 {
-	while (++pos < the_index.cache_nr &&
-	       !strcmp(the_index.cache[pos]->name, ce->name))
+	while (++pos < the_repository->index->cache_nr &&
+	       !strcmp(the_repository->index->cache[pos]->name, ce->name))
 		; /* skip */
 	return pos;
 }
@@ -199,9 +198,9 @@ static int skip_same_name(const struct cache_entry *ce,=
 int pos)
 static int check_stage(int stage, const struct cache_entry *ce, int pos,
 		       int overlay_mode)
 {
-	while (pos < the_index.cache_nr &&
-	       !strcmp(the_index.cache[pos]->name, ce->name)) {
-		if (ce_stage(the_index.cache[pos]) =3D=3D stage)
+	while (pos < the_repository->index->cache_nr &&
+	       !strcmp(the_repository->index->cache[pos]->name, ce->name)) {
+		if (ce_stage(the_repository->index->cache[pos]) =3D=3D stage)
 			return 0;
 		pos++;
 	}
@@ -218,8 +217,8 @@ static int check_stages(unsigned stages, const struct c=
ache_entry *ce, int pos)
 	unsigned seen =3D 0;
 	const char *name =3D ce->name;
=20
-	while (pos < the_index.cache_nr) {
-		ce =3D the_index.cache[pos];
+	while (pos < the_repository->index->cache_nr) {
+		ce =3D the_repository->index->cache[pos];
 		if (strcmp(name, ce->name))
 			break;
 		seen |=3D (1 << ce_stage(ce));
@@ -235,10 +234,10 @@ static int checkout_stage(int stage, const struct cac=
he_entry *ce, int pos,
 			  const struct checkout *state, int *nr_checkouts,
 			  int overlay_mode)
 {
-	while (pos < the_index.cache_nr &&
-	       !strcmp(the_index.cache[pos]->name, ce->name)) {
-		if (ce_stage(the_index.cache[pos]) =3D=3D stage)
-			return checkout_entry(the_index.cache[pos], state,
+	while (pos < the_repository->index->cache_nr &&
+	       !strcmp(the_repository->index->cache[pos]->name, ce->name)) {
+		if (ce_stage(the_repository->index->cache[pos]) =3D=3D stage)
+			return checkout_entry(the_repository->index->cache[pos], state,
 					      NULL, nr_checkouts);
 		pos++;
 	}
@@ -256,7 +255,7 @@ static int checkout_merged(int pos, const struct checko=
ut *state,
 			   int *nr_checkouts, struct mem_pool *ce_mem_pool,
 			   int conflict_style)
 {
-	struct cache_entry *ce =3D the_index.cache[pos];
+	struct cache_entry *ce =3D the_repository->index->cache[pos];
 	const char *path =3D ce->name;
 	mmfile_t ancestor, ours, theirs;
 	enum ll_merge_result merge_status;
@@ -269,7 +268,7 @@ static int checkout_merged(int pos, const struct checko=
ut *state,
 	int renormalize =3D 0;
=20
 	memset(threeway, 0, sizeof(threeway));
-	while (pos < the_index.cache_nr) {
+	while (pos < the_repository->index->cache_nr) {
 		int stage;
 		stage =3D ce_stage(ce);
 		if (!stage || strcmp(path, ce->name))
@@ -278,7 +277,7 @@ static int checkout_merged(int pos, const struct checko=
ut *state,
 		if (stage =3D=3D 2)
 			mode =3D create_ce_mode(ce->ce_mode);
 		pos++;
-		ce =3D the_index.cache[pos];
+		ce =3D the_repository->index->cache[pos];
 	}
 	if (is_null_oid(&threeway[1]) || is_null_oid(&threeway[2]))
 		return error(_("path '%s' does not have necessary versions"), path);
@@ -356,7 +355,7 @@ static void mark_ce_for_checkout_overlay(struct cache_e=
ntry *ce,
 	 * match_pathspec() for _all_ entries when
 	 * opts->source_tree !=3D NULL.
 	 */
-	if (ce_path_match(&the_index, ce, &opts->pathspec, ps_matched))
+	if (ce_path_match(the_repository->index, ce, &opts->pathspec, ps_matched))
 		ce->ce_flags |=3D CE_MATCHED;
 }
=20
@@ -367,7 +366,7 @@ static void mark_ce_for_checkout_no_overlay(struct cach=
e_entry *ce,
 	ce->ce_flags &=3D ~CE_MATCHED;
 	if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
 		return;
-	if (ce_path_match(&the_index, ce, &opts->pathspec, ps_matched)) {
+	if (ce_path_match(the_repository->index, ce, &opts->pathspec, ps_matched)=
) {
 		ce->ce_flags |=3D CE_MATCHED;
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			/*
@@ -391,7 +390,7 @@ static int checkout_worktree(const struct checkout_opts=
 *opts,
=20
 	state.force =3D 1;
 	state.refresh_cache =3D 1;
-	state.istate =3D &the_index;
+	state.istate =3D the_repository->index;
=20
 	mem_pool_init(&ce_mem_pool, 0);
 	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
@@ -404,8 +403,8 @@ static int checkout_worktree(const struct checkout_opts=
 *opts,
 	if (pc_workers > 1)
 		init_parallel_checkout();
=20
-	for (pos =3D 0; pos < the_index.cache_nr; pos++) {
-		struct cache_entry *ce =3D the_index.cache[pos];
+	for (pos =3D 0; pos < the_repository->index->cache_nr; pos++) {
+		struct cache_entry *ce =3D the_repository->index->cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce)) {
 				errs |=3D checkout_entry(ce, &state,
@@ -429,7 +428,7 @@ static int checkout_worktree(const struct checkout_opts=
 *opts,
 		errs |=3D run_parallel_checkout(&state, pc_workers, pc_threshold,
 					      NULL, NULL);
 	mem_pool_discard(&ce_mem_pool, should_validate_cache_entries());
-	remove_marked_cache_entries(&the_index, 1);
+	remove_marked_cache_entries(the_repository->index, 1);
 	remove_scheduled_dirs();
 	errs |=3D finish_delayed_checkout(&state, opts->show_progress);
=20
@@ -571,7 +570,7 @@ static int checkout_paths(const struct checkout_opts *o=
pts,
 	if (opts->source_tree)
 		read_tree_some(opts->source_tree, &opts->pathspec);
 	if (opts->merge)
-		unmerge_index(&the_index, &opts->pathspec, CE_MATCHED);
+		unmerge_index(the_repository->index, &opts->pathspec, CE_MATCHED);
=20
 	ps_matched =3D xcalloc(opts->pathspec.nr, 1);
=20
@@ -579,13 +578,13 @@ static int checkout_paths(const struct checkout_opts =
*opts,
 	 * Make sure all pathspecs participated in locating the paths
 	 * to be checked out.
 	 */
-	for (pos =3D 0; pos < the_index.cache_nr; pos++)
+	for (pos =3D 0; pos < the_repository->index->cache_nr; pos++)
 		if (opts->overlay_mode)
-			mark_ce_for_checkout_overlay(the_index.cache[pos],
+			mark_ce_for_checkout_overlay(the_repository->index->cache[pos],
 						     ps_matched,
 						     opts);
 		else
-			mark_ce_for_checkout_no_overlay(the_index.cache[pos],
+			mark_ce_for_checkout_no_overlay(the_repository->index->cache[pos],
 							ps_matched,
 							opts);
=20
@@ -596,8 +595,8 @@ static int checkout_paths(const struct checkout_opts *o=
pts,
 	free(ps_matched);
=20
 	/* Any unmerged paths? */
-	for (pos =3D 0; pos < the_index.cache_nr; pos++) {
-		const struct cache_entry *ce =3D the_index.cache[pos];
+	for (pos =3D 0; pos < the_repository->index->cache_nr; pos++) {
+		const struct cache_entry *ce =3D the_repository->index->cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce))
 				continue;
@@ -622,7 +621,7 @@ static int checkout_paths(const struct checkout_opts *o=
pts,
 	if (opts->checkout_worktree)
 		errs |=3D checkout_worktree(opts, new_branch_info);
 	else
-		remove_marked_cache_entries(&the_index, 1);
+		remove_marked_cache_entries(the_repository->index, 1);
=20
 	/*
 	 * Allow updating the index when checking out from the index.
@@ -634,7 +633,7 @@ static int checkout_paths(const struct checkout_opts *o=
pts,
 		checkout_index =3D opts->checkout_index;
=20
 	if (checkout_index) {
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 			die(_("unable to write new index file"));
 	} else {
 		/*
@@ -703,8 +702,8 @@ static int reset_tree(struct tree *tree, const struct c=
heckout_opts *o,
 	opts.merge =3D 1;
 	opts.fn =3D oneway_merge;
 	opts.verbose_update =3D o->show_progress;
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
+	opts.src_index =3D the_repository->index;
+	opts.dst_index =3D the_repository->index;
 	init_checkout_metadata(&opts.meta, info->refname,
 			       info->commit ? &info->commit->object.oid : null_oid(),
 			       NULL);
@@ -756,12 +755,12 @@ static void init_topts(struct unpack_trees_options *t=
opts, int merge,
 {
 	memset(topts, 0, sizeof(*topts));
 	topts->head_idx =3D -1;
-	topts->src_index =3D &the_index;
-	topts->dst_index =3D &the_index;
+	topts->src_index =3D the_repository->index;
+	topts->dst_index =3D the_repository->index;
=20
 	setup_unpack_trees_porcelain(topts, "checkout");
=20
-	topts->initial_checkout =3D is_index_unborn(&the_index);
+	topts->initial_checkout =3D is_index_unborn(the_repository->index);
 	topts->update =3D 1;
 	topts->merge =3D 1;
 	topts->quiet =3D merge && old_commit;
@@ -783,7 +782,7 @@ static int merge_working_tree(const struct checkout_opt=
s *opts,
 	if (repo_read_index_preload(the_repository, NULL, 0) < 0)
 		return error(_("index file corrupt"));
=20
-	resolve_undo_clear_index(&the_index);
+	resolve_undo_clear_index(the_repository->index);
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
 		if (new_branch_info->commit)
 			BUG("'switch --orphan' should never accept a commit as starting point");
@@ -807,9 +806,9 @@ static int merge_working_tree(const struct checkout_opt=
s *opts,
 		struct unpack_trees_options topts;
 		const struct object_id *old_commit_oid;
=20
-		refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
+		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
=20
-		if (unmerged_index(&the_index)) {
+		if (unmerged_index(the_repository->index)) {
 			error(_("you need to resolve your current index first"));
 			return 1;
 		}
@@ -919,10 +918,10 @@ static int merge_working_tree(const struct checkout_o=
pts *opts,
 		}
 	}
=20
-	if (!cache_tree_fully_valid(the_index.cache_tree))
-		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
+	if (!cache_tree_fully_valid(the_repository->index->cache_tree))
+		cache_tree_update(the_repository->index, WRITE_TREE_SILENT | WRITE_TREE_=
REPAIR);
=20
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
=20
 	if (!opts->discard_changes && !opts->quiet && new_branch_info->commit)
diff --git a/builtin/clean.c b/builtin/clean.c
index 29efe84153..ded5a91534 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -6,7 +6,6 @@
  * Based on git-clean.sh by Pavel Roskin
  */
=20
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
@@ -714,7 +713,7 @@ static int filter_by_patterns_cmd(void)
 		for_each_string_list_item(item, &del_list) {
 			int dtype =3D DT_UNKNOWN;
=20
-			if (is_excluded(&dir, &the_index, item->string, &dtype)) {
+			if (is_excluded(&dir, the_repository->index, item->string, &dtype)) {
 				*item->string =3D '\0';
 				changed++;
 			}
@@ -1021,7 +1020,7 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv);
=20
-	fill_directory(&dir, &the_index, &pathspec);
+	fill_directory(&dir, the_repository->index, &pathspec);
 	correct_untracked_entries(&dir);
=20
 	for (i =3D 0; i < dir.nr; i++) {
@@ -1029,7 +1028,7 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 		struct stat st;
 		const char *rel;
=20
-		if (!index_name_is_other(&the_index, ent->name, ent->len))
+		if (!index_name_is_other(the_repository->index, ent->name, ent->len))
 			continue;
=20
 		if (lstat(ent->name, &st))
diff --git a/builtin/commit.c b/builtin/commit.c
index 6e1484446b..c2943055ef 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -5,7 +5,6 @@
  * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
  */
=20
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
@@ -266,19 +265,19 @@ static int list_paths(struct string_list *list, const=
 char *with_tree,
=20
 	if (with_tree) {
 		char *max_prefix =3D common_prefix(pattern);
-		overlay_tree_on_index(&the_index, with_tree, max_prefix);
+		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
 		free(max_prefix);
 	}
=20
 	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
-	for (i =3D 0; i < the_index.cache_nr; i++) {
-		const struct cache_entry *ce =3D the_index.cache[i];
+	ensure_full_index(the_repository->index);
+	for (i =3D 0; i < the_repository->index->cache_nr; i++) {
+		const struct cache_entry *ce =3D the_repository->index->cache[i];
 		struct string_list_item *item;
=20
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
-		if (!ce_path_match(&the_index, ce, pattern, m))
+		if (!ce_path_match(the_repository->index, ce, pattern, m))
 			continue;
 		item =3D string_list_insert(list, ce->name);
 		if (ce_skip_worktree(ce))
@@ -302,10 +301,10 @@ static void add_remove_files(struct string_list *list)
 			continue;
=20
 		if (!lstat(p->string, &st)) {
-			if (add_to_index(&the_index, p->string, &st, 0))
+			if (add_to_index(the_repository->index, p->string, &st, 0))
 				die(_("updating files failed"));
 		} else
-			remove_file_from_index(&the_index, p->string);
+			remove_file_from_index(the_repository->index, p->string);
 	}
 }
=20
@@ -316,7 +315,7 @@ static void create_base_index(const struct commit *curr=
ent_head)
 	struct tree_desc t;
=20
 	if (!current_head) {
-		discard_index(&the_index);
+		discard_index(the_repository->index);
 		return;
 	}
=20
@@ -324,8 +323,8 @@ static void create_base_index(const struct commit *curr=
ent_head)
 	opts.head_idx =3D 1;
 	opts.index_only =3D 1;
 	opts.merge =3D 1;
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
+	opts.src_index =3D the_repository->index;
+	opts.dst_index =3D the_repository->index;
=20
 	opts.fn =3D oneway_merge;
 	tree =3D parse_tree_indirect(&current_head->object.oid);
@@ -344,7 +343,7 @@ static void refresh_cache_or_die(int refresh_flags)
 	 * refresh_flags contains REFRESH_QUIET, so the only errors
 	 * are for unmerged entries.
 	 */
-	if (refresh_index(&the_index, refresh_flags | REFRESH_IN_PORCELAIN, NULL,=
 NULL, NULL))
+	if (refresh_index(the_repository->index, refresh_flags | REFRESH_IN_PORCE=
LAIN, NULL, NULL, NULL))
 		die_resolve_conflict("commit");
 }
=20
@@ -393,7 +392,7 @@ static const char *prepare_index(const char **argv, con=
st char *prefix,
=20
 		refresh_cache_or_die(refresh_flags);
=20
-		if (write_locked_index(&the_index, &index_lock, 0))
+		if (write_locked_index(the_repository->index, &index_lock, 0))
 			die(_("unable to create temporary index"));
=20
 		old_repo_index_file =3D the_repository->index_file;
@@ -412,13 +411,13 @@ static const char *prepare_index(const char **argv, c=
onst char *prefix,
 			unsetenv(INDEX_ENVIRONMENT);
 		FREE_AND_NULL(old_index_env);
=20
-		discard_index(&the_index);
-		read_index_from(&the_index, get_lock_file_path(&index_lock),
+		discard_index(the_repository->index);
+		read_index_from(the_repository->index, get_lock_file_path(&index_lock),
 				get_git_dir());
-		if (cache_tree_update(&the_index, WRITE_TREE_SILENT) =3D=3D 0) {
+		if (cache_tree_update(the_repository->index, WRITE_TREE_SILENT) =3D=3D 0=
) {
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
-			if (write_locked_index(&the_index, &index_lock, 0))
+			if (write_locked_index(the_repository->index, &index_lock, 0))
 				die(_("unable to update temporary index"));
 		} else
 			warning(_("Failed to update main cache tree"));
@@ -450,8 +449,8 @@ static const char *prepare_index(const char **argv, con=
st char *prefix,
 			exit(128);
=20
 		refresh_cache_or_die(refresh_flags);
-		cache_tree_update(&the_index, WRITE_TREE_SILENT);
-		if (write_locked_index(&the_index, &index_lock, 0))
+		cache_tree_update(the_repository->index, WRITE_TREE_SILENT);
+		if (write_locked_index(the_repository->index, &index_lock, 0))
 			die(_("unable to write new index file"));
 		commit_style =3D COMMIT_NORMAL;
 		ret =3D get_lock_file_path(&index_lock);
@@ -472,10 +471,10 @@ static const char *prepare_index(const char **argv, c=
onst char *prefix,
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
 		refresh_cache_or_die(refresh_flags);
-		if (the_index.cache_changed
-		    || !cache_tree_fully_valid(the_index.cache_tree))
-			cache_tree_update(&the_index, WRITE_TREE_SILENT);
-		if (write_locked_index(&the_index, &index_lock,
+		if (the_repository->index->cache_changed
+		    || !cache_tree_fully_valid(the_repository->index->cache_tree))
+			cache_tree_update(the_repository->index, WRITE_TREE_SILENT);
+		if (write_locked_index(the_repository->index, &index_lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write new index file"));
 		commit_style =3D COMMIT_AS_IS;
@@ -516,15 +515,15 @@ static const char *prepare_index(const char **argv, c=
onst char *prefix,
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
 		exit(1);
=20
-	discard_index(&the_index);
+	discard_index(the_repository->index);
 	if (repo_read_index(the_repository) < 0)
 		die(_("cannot read the index"));
=20
 	repo_hold_locked_index(the_repository, &index_lock, LOCK_DIE_ON_ERROR);
 	add_remove_files(&partial);
-	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
-	cache_tree_update(&the_index, WRITE_TREE_SILENT);
-	if (write_locked_index(&the_index, &index_lock, 0))
+	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
+	cache_tree_update(the_repository->index, WRITE_TREE_SILENT);
+	if (write_locked_index(the_repository->index, &index_lock, 0))
 		die(_("unable to write new index file"));
=20
 	hold_lock_file_for_update(&false_lock,
@@ -534,14 +533,14 @@ static const char *prepare_index(const char **argv, c=
onst char *prefix,
=20
 	create_base_index(current_head);
 	add_remove_files(&partial);
-	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
+	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
=20
-	if (write_locked_index(&the_index, &false_lock, 0))
+	if (write_locked_index(the_repository->index, &false_lock, 0))
 		die(_("unable to write temporary index file"));
=20
-	discard_index(&the_index);
+	discard_index(the_repository->index);
 	ret =3D get_lock_file_path(&false_lock);
-	read_index_from(&the_index, ret, get_git_dir());
+	read_index_from(the_repository->index, ret, get_git_dir());
 out:
 	string_list_clear(&partial, 0);
 	clear_pathspec(&pathspec);
@@ -999,7 +998,7 @@ static int prepare_to_commit(const char *index_file, co=
nst char *prefix,
 		struct object_id oid;
 		const char *parent =3D "HEAD";
=20
-		if (!the_index.initialized && repo_read_index(the_repository) < 0)
+		if (!the_repository->index->initialized && repo_read_index(the_repositor=
y) < 0)
 			die(_("Cannot read index"));
=20
 		if (amend)
@@ -1009,11 +1008,11 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 			int i, ita_nr =3D 0;
=20
 			/* TODO: audit for interaction with sparse-index. */
-			ensure_full_index(&the_index);
-			for (i =3D 0; i < the_index.cache_nr; i++)
-				if (ce_intent_to_add(the_index.cache[i]))
+			ensure_full_index(the_repository->index);
+			for (i =3D 0; i < the_repository->index->cache_nr; i++)
+				if (ce_intent_to_add(the_repository->index->cache[i]))
 					ita_nr++;
-			committable =3D the_index.cache_nr - ita_nr > 0;
+			committable =3D the_repository->index->cache_nr - ita_nr > 0;
 		} else {
 			/*
 			 * Unless the user did explicitly request a submodule
@@ -1081,11 +1080,11 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		 * and could have updated it. We must do this before we invoke
 		 * the editor and after we invoke run_status above.
 		 */
-		discard_index(&the_index);
+		discard_index(the_repository->index);
 	}
-	read_index_from(&the_index, index_file, get_git_dir());
+	read_index_from(the_repository->index, index_file, get_git_dir());
=20
-	if (cache_tree_update(&the_index, 0)) {
+	if (cache_tree_update(the_repository->index, 0)) {
 		error(_("Error building trees"));
 		return 0;
 	}
@@ -1586,7 +1585,7 @@ int cmd_status(int argc, const char **argv, const cha=
r *prefix)
 	    status_format !=3D STATUS_FORMAT_PORCELAIN_V2)
 		progress_flag =3D REFRESH_PROGRESS;
 	repo_read_index(the_repository);
-	refresh_index(&the_index,
+	refresh_index(the_repository->index,
 		      REFRESH_QUIET|REFRESH_UNMERGED|progress_flag,
 		      &s.pathspec, NULL, NULL);
=20
@@ -1856,7 +1855,7 @@ int cmd_commit(int argc, const char **argv, const cha=
r *prefix)
 		append_merge_tag_headers(parents, &tail);
 	}
=20
-	if (commit_tree_extended(sb.buf, sb.len, &the_index.cache_tree->oid,
+	if (commit_tree_extended(sb.buf, sb.len, &the_repository->index->cache_tr=
ee->oid,
 				 parents, &oid, author_ident.buf, NULL,
 				 sign_commit, extra)) {
 		rollback_index_files();
diff --git a/builtin/describe.c b/builtin/describe.c
index d6c77a714f..c0e3301e3c 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
@@ -674,7 +673,7 @@ int cmd_describe(int argc, const char **argv, const cha=
r *prefix)
 			prepare_repo_settings(the_repository);
 			the_repository->settings.command_requires_full_index =3D 0;
 			repo_read_index(the_repository);
-			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
+			refresh_index(the_repository->index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
 			fd =3D repo_hold_locked_index(the_repository,
 						    &index_lock, 0);
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index a8e68ce8ef..0d3c611aac 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
@@ -206,7 +205,7 @@ int cmd_diff_tree(int argc, const char **argv, const ch=
ar *prefix)
 		opt->diffopt.rotate_to_strict =3D 0;
 		opt->diffopt.no_free =3D 1;
 		if (opt->diffopt.detect_rename) {
-			if (!the_index.cache)
+			if (the_repository->index->cache)
 				repo_read_index(the_repository);
 			opt->diffopt.setup |=3D DIFF_SETUP_USE_SIZE_CACHE;
 		}
diff --git a/builtin/diff.c b/builtin/diff.c
index 6e196e0c7d..efc37483b3 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "config.h"
 #include "ewah/ewok.h"
@@ -239,9 +239,9 @@ static void refresh_index_quietly(void)
 	fd =3D repo_hold_locked_index(the_repository, &lock_file, 0);
 	if (fd < 0)
 		return;
-	discard_index(&the_index);
+	discard_index(the_repository->index);
 	repo_read_index(the_repository);
-	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL,
+	refresh_index(the_repository->index, REFRESH_QUIET|REFRESH_UNMERGED, NULL=
, NULL,
 		      NULL);
 	repo_update_index_if_able(the_repository, &lock_file);
 }
diff --git a/builtin/difftool.c b/builtin/difftool.c
index a3c72b8258..a130faae4f 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -11,7 +11,7 @@
  *
  * Copyright (C) 2016 Johannes Schindelin
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
@@ -117,7 +117,7 @@ static int use_wt_file(const char *workdir, const char =
*name,
 		int fd =3D open(buf.buf, O_RDONLY);
=20
 		if (fd >=3D 0 &&
-		    !index_fd(&the_index, &wt_oid, fd, &st, OBJ_BLOB, name, 0)) {
+		    !index_fd(the_repository->index, &wt_oid, fd, &st, OBJ_BLOB, name, 0=
)) {
 			if (is_null_oid(oid)) {
 				oidcpy(oid, &wt_oid);
 				use =3D 1;
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 270d5f644a..0fabe3f6bb 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "hex.h"
 #include "read-cache-ll.h"
@@ -18,11 +17,11 @@ static int merge_entry(int pos, const char *path)
 	char ownbuf[4][60];
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
=20
-	if (pos >=3D the_index.cache_nr)
+	if (pos >=3D the_repository->index->cache_nr)
 		die("git merge-index: %s not in the cache", path);
 	found =3D 0;
 	do {
-		const struct cache_entry *ce =3D the_index.cache[pos];
+		const struct cache_entry *ce =3D the_repository->index->cache[pos];
 		int stage =3D ce_stage(ce);
=20
 		if (strcmp(ce->name, path))
@@ -32,7 +31,7 @@ static int merge_entry(int pos, const char *path)
 		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
 		arguments[stage] =3D hexbuf[stage];
 		arguments[stage + 4] =3D ownbuf[stage];
-	} while (++pos < the_index.cache_nr);
+	} while (++pos < the_repository->index->cache_nr);
 	if (!found)
 		die("git merge-index: %s not in the cache", path);
=20
@@ -51,7 +50,7 @@ static int merge_entry(int pos, const char *path)
=20
 static void merge_one_path(const char *path)
 {
-	int pos =3D index_name_pos(&the_index, path, strlen(path));
+	int pos =3D index_name_pos(the_repository->index, path, strlen(path));
=20
 	/*
 	 * If it already exists in the cache as stage0, it's
@@ -65,9 +64,9 @@ static void merge_all(void)
 {
 	int i;
 	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
-	for (i =3D 0; i < the_index.cache_nr; i++) {
-		const struct cache_entry *ce =3D the_index.cache[i];
+	ensure_full_index(the_repository->index);
+	for (i =3D 0; i < the_repository->index->cache_nr; i++) {
+		const struct cache_entry *ce =3D the_repository->index->cache[i];
 		if (!ce_stage(ce))
 			continue;
 		i +=3D merge_entry(i, ce->name)-1;
@@ -89,7 +88,7 @@ int cmd_merge_index(int argc, const char **argv, const ch=
ar *prefix UNUSED)
 	repo_read_index(the_repository);
=20
 	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
+	ensure_full_index(the_repository->index);
=20
 	i =3D 1;
 	if (!strcmp(argv[i], "-o")) {
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 8bdb439131..1082d919fd 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
@@ -364,7 +363,7 @@ static void trivial_merge_trees(struct tree_desc t[3], =
const char *base)
=20
 	setup_traverse_info(&info, base);
 	info.fn =3D threeway_callback;
-	traverse_trees(&the_index, 3, t, &info);
+	traverse_trees(the_repository->index, 3, t, &info);
 }
=20
 static void *get_tree_descriptor(struct repository *r,
diff --git a/builtin/merge.c b/builtin/merge.c
index 6f4fec87fc..6a6d379885 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -6,7 +6,6 @@
  * Based on git-merge.sh by Junio C Hamano.
  */
=20
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
@@ -300,7 +299,7 @@ static int save_state(struct object_id *stash)
 	int rc =3D -1;
=20
 	fd =3D repo_hold_locked_index(the_repository, &lock_file, 0);
-	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
+	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <=3D fd)
 		repo_update_index_if_able(the_repository, &lock_file);
 	rollback_lock_file(&lock_file);
@@ -372,7 +371,7 @@ static void restore_state(const struct object_id *head,
 	run_command(&cmd);
=20
 refresh_cache:
-	discard_index(&the_index);
+	discard_index(the_repository->index);
 	if (repo_read_index(the_repository) < 0)
 		die(_("could not read index"));
 }
@@ -657,8 +656,8 @@ static int read_tree_trivial(struct object_id *common, =
struct object_id *head,
=20
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx =3D 2;
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
+	opts.src_index =3D the_repository->index;
+	opts.dst_index =3D the_repository->index;
 	opts.update =3D 1;
 	opts.verbose_update =3D 1;
 	opts.trivial_merges_only =3D 1;
@@ -674,7 +673,7 @@ static int read_tree_trivial(struct object_id *common, =
struct object_id *head,
 	if (!trees[nr_trees++])
 		return -1;
 	opts.fn =3D threeway_merge;
-	cache_tree_free(&the_index.cache_tree);
+	cache_tree_free(&the_repository->index->cache_tree);
 	for (i =3D 0; i < nr_trees; i++) {
 		parse_tree(trees[i]);
 		init_tree_desc(t+i, &trees[i]->object.oid,
@@ -687,7 +686,7 @@ static int read_tree_trivial(struct object_id *common, =
struct object_id *head,
=20
 static void write_tree_trivial(struct object_id *oid)
 {
-	if (write_index_as_tree(oid, &the_index, get_index_file(), 0, NULL))
+	if (write_index_as_tree(oid, the_repository->index, get_index_file(), 0, =
NULL))
 		die(_("git write-tree failed to write a tree"));
 }
=20
@@ -745,7 +744,7 @@ static int try_merge_strategy(const char *strategy, str=
uct commit_list *common,
 			rollback_lock_file(&lock);
 			return 2;
 		}
-		if (write_locked_index(&the_index, &lock,
+		if (write_locked_index(the_repository->index, &lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
 		return clean ? 0 : 1;
@@ -768,8 +767,8 @@ static int count_unmerged_entries(void)
 {
 	int i, ret =3D 0;
=20
-	for (i =3D 0; i < the_index.cache_nr; i++)
-		if (ce_stage(the_index.cache[i]))
+	for (i =3D 0; i < the_repository->index->cache_nr; i++)
+		if (ce_stage(the_repository->index->cache[i]))
 			ret++;
=20
 	return ret;
@@ -843,9 +842,9 @@ static void prepare_to_commit(struct commit_list *remot=
eheads)
 		 * the editor and after we invoke run_status above.
 		 */
 		if (invoked_hook)
-			discard_index(&the_index);
+			discard_index(the_repository->index);
 	}
-	read_index_from(&the_index, index_file, get_git_dir());
+	read_index_from(the_repository->index, index_file, get_git_dir());
 	strbuf_addbuf(&msg, &merge_msg);
 	if (squash)
 		BUG("the control must not reach here under --squash");
@@ -957,7 +956,7 @@ static int suggest_conflicts(void)
 	 * Thus, we will get the cleanup mode which is returned when we _are_
 	 * using an editor.
 	 */
-	append_conflicts_hint(&the_index, &msgbuf,
+	append_conflicts_hint(the_repository->index, &msgbuf,
 			      get_cleanup_mode(cleanup_arg, 1));
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
@@ -1386,7 +1385,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 		else
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists=
)."));
 	}
-	resolve_undo_clear_index(&the_index);
+	resolve_undo_clear_index(the_repository->index);
=20
 	if (option_edit < 0)
 		option_edit =3D default_edit_option();
@@ -1595,7 +1594,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 		 * We are not doing octopus, not fast-forward, and have
 		 * only one common.
 		 */
-		refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
+		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
 		if (allow_trivial && fast_forward !=3D FF_ONLY) {
 			/*
 			 * Must first ensure that index matches HEAD before
@@ -1784,6 +1783,6 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	}
 	strbuf_release(&buf);
 	free(branch_to_free);
-	discard_index(&the_index);
+	discard_index(the_repository->index);
 	return ret;
 }
diff --git a/builtin/mv.c b/builtin/mv.c
index 22e64fc290..74aa9746aa 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2006 Johannes Schindelin
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
@@ -95,9 +95,9 @@ static void prepare_move_submodule(const char *src, int f=
irst,
 				   const char **submodule_gitfile)
 {
 	struct strbuf submodule_dotgit =3D STRBUF_INIT;
-	if (!S_ISGITLINK(the_index.cache[first]->ce_mode))
+	if (!S_ISGITLINK(the_repository->index->cache[first]->ce_mode))
 		die(_("Directory %s is in index and no submodule?"), src);
-	if (!is_staging_gitmodules_ok(&the_index))
+	if (!is_staging_gitmodules_ok(the_repository->index))
 		die(_("Please stage your changes to .gitmodules or stash them to proceed=
"));
 	strbuf_addf(&submodule_dotgit, "%s/.git", src);
 	*submodule_gitfile =3D read_gitfile(submodule_dotgit.buf);
@@ -114,13 +114,13 @@ static int index_range_of_same_dir(const char *src, i=
nt length,
 	const char *src_w_slash =3D add_slash(src);
 	int first, last, len_w_slash =3D length + 1;
=20
-	first =3D index_name_pos(&the_index, src_w_slash, len_w_slash);
+	first =3D index_name_pos(the_repository->index, src_w_slash, len_w_slash);
 	if (first >=3D 0)
 		die(_("%.*s is in index"), len_w_slash, src_w_slash);
=20
 	first =3D -1 - first;
-	for (last =3D first; last < the_index.cache_nr; last++) {
-		const char *path =3D the_index.cache[last]->name;
+	for (last =3D first; last < the_repository->index->cache_nr; last++) {
+		const char *path =3D the_repository->index->cache[last]->name;
 		if (strncmp(path, src_w_slash, len_w_slash))
 			break;
 	}
@@ -144,14 +144,14 @@ static int empty_dir_has_sparse_contents(const char *=
name)
 	const char *with_slash =3D add_slash(name);
 	int length =3D strlen(with_slash);
=20
-	int pos =3D index_name_pos(&the_index, with_slash, length);
+	int pos =3D index_name_pos(the_repository->index, with_slash, length);
 	const struct cache_entry *ce;
=20
 	if (pos < 0) {
 		pos =3D -pos - 1;
-		if (pos >=3D the_index.cache_nr)
+		if (pos >=3D the_repository->index->cache_nr)
 			goto free_return;
-		ce =3D the_index.cache[pos];
+		ce =3D the_repository->index->cache[pos];
 		if (strncmp(with_slash, ce->name, length))
 			goto free_return;
 		if (ce_skip_worktree(ce))
@@ -223,7 +223,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 			S_ISDIR(st.st_mode)) {
 		destination =3D internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BA=
SENAME);
 	} else {
-		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
+		if (!path_in_sparse_checkout(dst_w_slash, the_repository->index) &&
 		    empty_dir_has_sparse_contents(dst_w_slash)) {
 			destination =3D internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_B=
ASENAME);
 			dst_mode =3D SKIP_WORKTREE_DIR;
@@ -239,7 +239,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 			 * is deprecated at this point) sparse-checkout. As
 			 * SPARSE here is only considering cone-mode situation.
 			 */
-			if (!path_in_cone_mode_sparse_checkout(destination[0], &the_index))
+			if (!path_in_cone_mode_sparse_checkout(destination[0], the_repository->=
index))
 				dst_mode =3D SPARSE;
 		}
 	}
@@ -263,10 +263,10 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 			int pos;
 			const struct cache_entry *ce;
=20
-			pos =3D index_name_pos(&the_index, src, length);
+			pos =3D index_name_pos(the_repository->index, src, length);
 			if (pos < 0) {
 				const char *src_w_slash =3D add_slash(src);
-				if (!path_in_sparse_checkout(src_w_slash, &the_index) &&
+				if (!path_in_sparse_checkout(src_w_slash, the_repository->index) &&
 				    empty_dir_has_sparse_contents(src)) {
 					modes[i] |=3D SKIP_WORKTREE_DIR;
 					goto dir_check;
@@ -276,7 +276,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 					bad =3D _("bad source");
 				goto act_on_entry;
 			}
-			ce =3D the_index.cache[pos];
+			ce =3D the_repository->index->cache[pos];
 			if (!ce_skip_worktree(ce)) {
 				bad =3D _("bad source");
 				goto act_on_entry;
@@ -286,7 +286,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 				goto act_on_entry;
 			}
 			/* Check if dst exists in index */
-			if (index_name_pos(&the_index, dst, strlen(dst)) < 0) {
+			if (index_name_pos(the_repository->index, dst, strlen(dst)) < 0) {
 				modes[i] |=3D SPARSE;
 				goto act_on_entry;
 			}
@@ -311,7 +311,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 dir_check:
 		if (S_ISDIR(st.st_mode)) {
 			int j, dst_len, n;
-			int first =3D index_name_pos(&the_index, src, length), last;
+			int first =3D index_name_pos(the_repository->index, src, length), last;
=20
 			if (first >=3D 0) {
 				prepare_move_submodule(src, first,
@@ -339,7 +339,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 			dst_len =3D strlen(dst);
=20
 			for (j =3D 0; j < last - first; j++) {
-				const struct cache_entry *ce =3D the_index.cache[first + j];
+				const struct cache_entry *ce =3D the_repository->index->cache[first + =
j];
 				const char *path =3D ce->name;
 				source[argc + j] =3D path;
 				destination[argc + j] =3D
@@ -351,7 +351,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 			argc +=3D last - first;
 			goto act_on_entry;
 		}
-		if (!(ce =3D index_file_exists(&the_index, src, length, 0))) {
+		if (!(ce =3D index_file_exists(the_repository->index, src, length, 0))) {
 			bad =3D _("not under version control");
 			goto act_on_entry;
 		}
@@ -387,7 +387,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
=20
 		if (ignore_sparse &&
 		    (dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
-		    index_entry_exists(&the_index, dst, strlen(dst))) {
+		    index_entry_exists(the_repository->index, dst, strlen(dst))) {
 			bad =3D _("destination exists in the index");
 			if (force) {
 				if (verbose)
@@ -404,12 +404,12 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 		 * option as a way to have a successful run.
 		 */
 		if (!ignore_sparse &&
-		    !path_in_sparse_checkout(src, &the_index)) {
+		    !path_in_sparse_checkout(src, the_repository->index)) {
 			string_list_append(&only_match_skip_worktree, src);
 			skip_sparse =3D 1;
 		}
 		if (!ignore_sparse &&
-		    !path_in_sparse_checkout(dst, &the_index)) {
+		    !path_in_sparse_checkout(dst, the_repository->index)) {
 			string_list_append(&only_match_skip_worktree, dst);
 			skip_sparse =3D 1;
 		}
@@ -449,7 +449,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 		int pos;
 		int sparse_and_dirty =3D 0;
 		struct checkout state =3D CHECKOUT_INIT;
-		state.istate =3D &the_index;
+		state.istate =3D the_repository->index;
=20
 		if (force)
 			state.force =3D 1;
@@ -476,14 +476,14 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
 			continue;
=20
-		pos =3D index_name_pos(&the_index, src, strlen(src));
+		pos =3D index_name_pos(the_repository->index, src, strlen(src));
 		assert(pos >=3D 0);
 		if (!(mode & SPARSE) && !lstat(src, &st))
-			sparse_and_dirty =3D ie_modified(&the_index,
-						       the_index.cache[pos],
+			sparse_and_dirty =3D ie_modified(the_repository->index,
+						       the_repository->index->cache[pos],
 						       &st,
 						       0);
-		rename_index_entry_at(&the_index, pos, dst);
+		rename_index_entry_at(the_repository->index, pos, dst);
=20
 		if (ignore_sparse &&
 		    core_apply_sparse_checkout &&
@@ -495,11 +495,11 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 			 * should be added in a future patch.
 			 */
 			if ((mode & SPARSE) &&
-			    path_in_sparse_checkout(dst, &the_index)) {
+			    path_in_sparse_checkout(dst, the_repository->index)) {
 				/* from out-of-cone to in-cone */
-				int dst_pos =3D index_name_pos(&the_index, dst,
+				int dst_pos =3D index_name_pos(the_repository->index, dst,
 							     strlen(dst));
-				struct cache_entry *dst_ce =3D the_index.cache[dst_pos];
+				struct cache_entry *dst_ce =3D the_repository->index->cache[dst_pos];
=20
 				dst_ce->ce_flags &=3D ~CE_SKIP_WORKTREE;
=20
@@ -507,11 +507,11 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 					die(_("cannot checkout %s"), dst_ce->name);
 			} else if ((dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
 				   !(mode & SPARSE) &&
-				   !path_in_sparse_checkout(dst, &the_index)) {
+				   !path_in_sparse_checkout(dst, the_repository->index)) {
 				/* from in-cone to out-of-cone */
-				int dst_pos =3D index_name_pos(&the_index, dst,
+				int dst_pos =3D index_name_pos(the_repository->index, dst,
 							     strlen(dst));
-				struct cache_entry *dst_ce =3D the_index.cache[dst_pos];
+				struct cache_entry *dst_ce =3D the_repository->index->cache[dst_pos];
=20
 				/*
 				 * if src is clean, it will suffice to remove it
@@ -559,9 +559,9 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
 		advise_on_moving_dirty_path(&dirty_paths);
=20
 	if (gitmodules_modified)
-		stage_updated_gitmodules(&the_index);
+		stage_updated_gitmodules(the_repository->index);
=20
-	if (write_locked_index(&the_index, &lock_file,
+	if (write_locked_index(the_repository->index, &lock_file,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
=20
diff --git a/builtin/pull.c b/builtin/pull.c
index 72cbb76d52..66869210db 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -5,7 +5,7 @@
  *
  * Fetch one or more remote refs and merge it/them into the current HEAD.
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
@@ -1044,7 +1044,7 @@ int cmd_pull(int argc, const char **argv, const char =
*prefix)
 		if (opt_autostash =3D=3D -1)
 			opt_autostash =3D config_autostash;
=20
-		if (is_null_oid(&orig_head) && !is_index_unborn(&the_index))
+		if (is_null_oid(&orig_head) && !is_index_unborn(the_repository->index))
 			die(_("Updating an unborn branch with changes added to the index."));
=20
 		if (!opt_autostash)
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 6f89cec0fb..a8cf8504b8 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -4,7 +4,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
=20
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -159,8 +158,8 @@ int cmd_read_tree(int argc, const char **argv, const ch=
ar *cmd_prefix)
=20
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx =3D -1;
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
+	opts.src_index =3D the_repository->index;
+	opts.dst_index =3D the_repository->index;
=20
 	git_config(git_read_tree_config, NULL);
=20
@@ -197,7 +196,7 @@ int cmd_read_tree(int argc, const char **argv, const ch=
ar *cmd_prefix)
 			die(_("You need to resolve your current index first"));
 		stage =3D opts.merge =3D 1;
 	}
-	resolve_undo_clear_index(&the_index);
+	resolve_undo_clear_index(the_repository->index);
=20
 	for (i =3D 0; i < argc; i++) {
 		const char *arg =3D argv[i];
@@ -225,7 +224,7 @@ int cmd_read_tree(int argc, const char **argv, const ch=
ar *cmd_prefix)
 		setup_work_tree();
=20
 	if (opts.skip_sparse_checkout)
-		ensure_full_index(&the_index);
+		ensure_full_index(the_repository->index);
=20
 	if (opts.merge) {
 		switch (stage - 1) {
@@ -237,7 +236,7 @@ int cmd_read_tree(int argc, const char **argv, const ch=
ar *cmd_prefix)
 			break;
 		case 2:
 			opts.fn =3D twoway_merge;
-			opts.initial_checkout =3D is_index_unborn(&the_index);
+			opts.initial_checkout =3D is_index_unborn(the_repository->index);
 			break;
 		case 3:
 		default:
@@ -258,7 +257,7 @@ int cmd_read_tree(int argc, const char **argv, const ch=
ar *cmd_prefix)
 	if (nr_trees =3D=3D 1 && !opts.prefix)
 		opts.skip_cache_tree_update =3D 1;
=20
-	cache_tree_free(&the_index.cache_tree);
+	cache_tree_free(&the_repository->index->cache_tree);
 	for (i =3D 0; i < nr_trees; i++) {
 		struct tree *tree =3D trees[i];
 		if (parse_tree(tree) < 0)
@@ -282,7 +281,7 @@ int cmd_read_tree(int argc, const char **argv, const ch=
ar *cmd_prefix)
 				 the_repository->index,
 				 trees[0]);
=20
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		die("unable to write new index file");
 	return 0;
 }
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 891f28468e..fe17d562a8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2018 Pratik Karki
  */
=20
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
@@ -295,7 +294,7 @@ static int do_interactive_rebase(struct rebase_options =
*opts, unsigned flags)
 	if (ret)
 		error(_("could not generate todo list"));
 	else {
-		discard_index(&the_index);
+		discard_index(the_repository->index);
 		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
 						&todo_list))
 			BUG("unusable todo list");
diff --git a/builtin/replay.c b/builtin/replay.c
index 6bc4b47f09..6bf0691f15 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -2,7 +2,6 @@
  * "git replay" builtin command
  */
=20
-#define USE_THE_INDEX_VARIABLE
 #include "git-compat-util.h"
=20
 #include "builtin.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 1d62ff6332..b6dacf9678 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
@@ -66,8 +66,8 @@ static int reset_index(const char *ref, const struct obje=
ct_id *oid, int reset_t
=20
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx =3D 1;
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
+	opts.src_index =3D the_repository->index;
+	opts.dst_index =3D the_repository->index;
 	opts.fn =3D oneway_merge;
 	opts.merge =3D 1;
 	init_checkout_metadata(&opts.meta, ref, oid, NULL);
@@ -159,11 +159,11 @@ static void update_index_from_diff(struct diff_queue_=
struct *q,
 		struct cache_entry *ce;
=20
 		if (!is_in_reset_tree && !intent_to_add) {
-			remove_file_from_index(&the_index, one->path);
+			remove_file_from_index(the_repository->index, one->path);
 			continue;
 		}
=20
-		ce =3D make_cache_entry(&the_index, one->mode, &one->oid, one->path,
+		ce =3D make_cache_entry(the_repository->index, one->mode, &one->oid, one=
->path,
 				      0, 0);
=20
 		/*
@@ -174,9 +174,9 @@ static void update_index_from_diff(struct diff_queue_st=
ruct *q,
 		 * if this entry is outside the sparse cone - this is necessary
 		 * to properly construct the reset sparse directory.
 		 */
-		pos =3D index_name_pos(&the_index, one->path, strlen(one->path));
-		if ((pos >=3D 0 && ce_skip_worktree(the_index.cache[pos])) ||
-		    (pos < 0 && !path_in_sparse_checkout(one->path, &the_index)))
+		pos =3D index_name_pos(the_repository->index, one->path, strlen(one->pat=
h));
+		if ((pos >=3D 0 && ce_skip_worktree(the_repository->index->cache[pos])) =
||
+		    (pos < 0 && !path_in_sparse_checkout(one->path, the_repository->inde=
x)))
 			ce->ce_flags |=3D CE_SKIP_WORKTREE;
=20
 		if (!ce)
@@ -186,7 +186,7 @@ static void update_index_from_diff(struct diff_queue_st=
ruct *q,
 			ce->ce_flags |=3D CE_INTENT_TO_ADD;
 			set_object_name_for_intent_to_add_entry(ce);
 		}
-		add_index_entry(&the_index, ce,
+		add_index_entry(the_repository->index, ce,
 				ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 	}
 }
@@ -208,8 +208,8 @@ static int read_from_tree(const struct pathspec *pathsp=
ec,
 	opt.change =3D diff_change;
 	opt.add_remove =3D diff_addremove;
=20
-	if (pathspec->nr && pathspec_needs_expanded_index(&the_index, pathspec))
-		ensure_full_index(&the_index);
+	if (pathspec->nr && pathspec_needs_expanded_index(the_repository->index, =
pathspec))
+		ensure_full_index(the_repository->index);
=20
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
@@ -235,7 +235,7 @@ static void set_reflog_message(struct strbuf *sb, const=
 char *action,
=20
 static void die_if_unmerged_cache(int reset_type)
 {
-	if (is_merge() || unmerged_index(&the_index))
+	if (is_merge() || unmerged_index(the_repository->index))
 		die(_("Cannot do a %s reset in the middle of a merge."),
 		    _(reset_type_names[reset_type]));
=20
@@ -470,12 +470,12 @@ int cmd_reset(int argc, const char **argv, const char=
 *prefix)
 				update_ref_status =3D 1;
 				goto cleanup;
 			}
-			the_index.updated_skipworktree =3D 1;
+			the_repository->index->updated_skipworktree =3D 1;
 			if (!no_refresh && get_git_work_tree()) {
 				uint64_t t_begin, t_delta_in_ms;
=20
 				t_begin =3D getnanotime();
-				refresh_index(&the_index, flags, NULL, NULL,
+				refresh_index(the_repository->index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
 				t_delta_in_ms =3D (getnanotime() - t_begin) / 1000000;
 				if (!quiet && advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_del=
ta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
@@ -501,7 +501,7 @@ int cmd_reset(int argc, const char **argv, const char *=
prefix)
 			free(ref);
 		}
=20
-		if (write_locked_index(&the_index, &lock, COMMIT_LOCK))
+		if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK))
 			die(_("Could not write new index file."));
 	}
=20
@@ -516,7 +516,7 @@ int cmd_reset(int argc, const char **argv, const char *=
prefix)
 	if (!pathspec.nr)
 		remove_branch_state(the_repository, 0);
=20
-	discard_index(&the_index);
+	discard_index(the_repository->index);
=20
 cleanup:
 	clear_pathspec(&pathspec);
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 624182e507..af79538632 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
@@ -1049,8 +1049,8 @@ int cmd_rev_parse(int argc, const char **argv, const =
char *prefix)
 			if (!strcmp(arg, "--shared-index-path")) {
 				if (repo_read_index(the_repository) < 0)
 					die(_("Could not read the index"));
-				if (the_index.split_index) {
-					const struct object_id *oid =3D &the_index.split_index->base_oid;
+				if (the_repository->index->split_index) {
+					const struct object_id *oid =3D &the_repository->index->split_index->=
base_oid;
 					const char *path =3D git_path("sharedindex.%s", oid_to_hex(oid));
 					print_path(path, prefix, format, DEFAULT_RELATIVE);
 				}
diff --git a/builtin/rm.c b/builtin/rm.c
index fd130cea2d..d195c16e74 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds 2006
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
@@ -41,8 +41,8 @@ static int get_ours_cache_pos(const char *path, int pos)
 {
 	int i =3D -pos - 1;
=20
-	while ((i < the_index.cache_nr) && !strcmp(the_index.cache[i]->name, path=
)) {
-		if (ce_stage(the_index.cache[i]) =3D=3D 2)
+	while ((i < the_repository->index->cache_nr) && !strcmp(the_repository->i=
ndex->cache[i]->name, path)) {
+		if (ce_stage(the_repository->index->cache[i]) =3D=3D 2)
 			return i;
 		i++;
 	}
@@ -78,13 +78,13 @@ static void submodules_absorb_gitdir_if_needed(void)
 		int pos;
 		const struct cache_entry *ce;
=20
-		pos =3D index_name_pos(&the_index, name, strlen(name));
+		pos =3D index_name_pos(the_repository->index, name, strlen(name));
 		if (pos < 0) {
 			pos =3D get_ours_cache_pos(name, pos);
 			if (pos < 0)
 				continue;
 		}
-		ce =3D the_index.cache[pos];
+		ce =3D the_repository->index->cache[pos];
=20
 		if (!S_ISGITLINK(ce->ce_mode) ||
 		    !file_exists(ce->name) ||
@@ -122,7 +122,7 @@ static int check_local_mod(struct object_id *head, int =
index_only)
 		int local_changes =3D 0;
 		int staged_changes =3D 0;
=20
-		pos =3D index_name_pos(&the_index, name, strlen(name));
+		pos =3D index_name_pos(the_repository->index, name, strlen(name));
 		if (pos < 0) {
 			/*
 			 * Skip unmerged entries except for populated submodules
@@ -132,11 +132,11 @@ static int check_local_mod(struct object_id *head, in=
t index_only)
 			if (pos < 0)
 				continue;
=20
-			if (!S_ISGITLINK(the_index.cache[pos]->ce_mode) ||
+			if (!S_ISGITLINK(the_repository->index->cache[pos]->ce_mode) ||
 			    is_empty_dir(name))
 				continue;
 		}
-		ce =3D the_index.cache[pos];
+		ce =3D the_repository->index->cache[pos];
=20
 		if (lstat(ce->name, &st) < 0) {
 			if (!is_missing_file_error(errno))
@@ -173,7 +173,7 @@ static int check_local_mod(struct object_id *head, int =
index_only)
 		 * Is the index different from the file in the work tree?
 		 * If it's a submodule, is its work tree modified?
 		 */
-		if (ie_match_stat(&the_index, ce, &st, 0) ||
+		if (ie_match_stat(the_repository->index, ce, &st, 0) ||
 		    (S_ISGITLINK(ce->ce_mode) &&
 		     bad_to_remove_submodule(ce->name,
 				SUBMODULE_REMOVAL_DIE_ON_ERROR |
@@ -301,27 +301,27 @@ int cmd_rm(int argc, const char **argv, const char *p=
refix)
 	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
=20
-	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &pathspec, NULL=
, NULL);
+	refresh_index(the_repository->index, REFRESH_QUIET|REFRESH_UNMERGED, &pat=
hspec, NULL, NULL);
=20
 	seen =3D xcalloc(pathspec.nr, 1);
=20
-	if (pathspec_needs_expanded_index(&the_index, &pathspec))
-		ensure_full_index(&the_index);
+	if (pathspec_needs_expanded_index(the_repository->index, &pathspec))
+		ensure_full_index(the_repository->index);
=20
-	for (i =3D 0; i < the_index.cache_nr; i++) {
-		const struct cache_entry *ce =3D the_index.cache[i];
+	for (i =3D 0; i < the_repository->index->cache_nr; i++) {
+		const struct cache_entry *ce =3D the_repository->index->cache[i];
=20
 		if (!include_sparse &&
 		    (ce_skip_worktree(ce) ||
-		     !path_in_sparse_checkout(ce->name, &the_index)))
+		     !path_in_sparse_checkout(ce->name, the_repository->index)))
 			continue;
-		if (!ce_path_match(&the_index, ce, &pathspec, seen))
+		if (!ce_path_match(the_repository->index, ce, &pathspec, seen))
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
 		list.entry[list.nr].name =3D xstrdup(ce->name);
 		list.entry[list.nr].is_submodule =3D S_ISGITLINK(ce->ce_mode);
 		if (list.entry[list.nr++].is_submodule &&
-		    !is_staging_gitmodules_ok(&the_index))
+		    !is_staging_gitmodules_ok(the_repository->index))
 			die(_("please stage your changes to .gitmodules or stash them to procee=
d"));
 	}
=20
@@ -391,7 +391,7 @@ int cmd_rm(int argc, const char **argv, const char *pre=
fix)
 		if (!quiet)
 			printf("rm '%s'\n", path);
=20
-		if (remove_file_from_index(&the_index, path))
+		if (remove_file_from_index(the_repository->index, path))
 			die(_("git rm: unable to remove %s"), path);
 	}
=20
@@ -432,10 +432,10 @@ int cmd_rm(int argc, const char **argv, const char *p=
refix)
 		}
 		strbuf_release(&buf);
 		if (gitmodules_modified)
-			stage_updated_gitmodules(&the_index);
+			stage_updated_gitmodules(the_repository->index);
 	}
=20
-	if (write_locked_index(&the_index, &lock_file,
+	if (write_locked_index(the_repository->index, &lock_file,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
=20
diff --git a/builtin/stash.c b/builtin/stash.c
index 062be1fbc0..69c01ba136 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
@@ -273,7 +272,7 @@ static int reset_tree(struct object_id *i_tree, int upd=
ate, int reset)
 	struct lock_file lock_file =3D LOCK_INIT;
=20
 	repo_read_index_preload(the_repository, NULL, 0);
-	if (refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL))
+	if (refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL))
 		return -1;
=20
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
@@ -287,8 +286,8 @@ static int reset_tree(struct object_id *i_tree, int upd=
ate, int reset)
 	init_tree_desc(t, &tree->object.oid, tree->buffer, tree->size);
=20
 	opts.head_idx =3D 1;
-	opts.src_index =3D &the_index;
-	opts.dst_index =3D &the_index;
+	opts.src_index =3D the_repository->index;
+	opts.dst_index =3D the_repository->index;
 	opts.merge =3D 1;
 	opts.reset =3D reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
 	opts.update =3D update;
@@ -299,7 +298,7 @@ static int reset_tree(struct object_id *i_tree, int upd=
ate, int reset)
 	if (unpack_trees(nr_trees, t, &opts))
 		return -1;
=20
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
=20
 	return 0;
@@ -430,7 +429,7 @@ static void unstage_changes_unless_new(struct object_id=
 *orig_tree)
 	state.force =3D 1;
 	state.quiet =3D 1;
 	state.refresh_cache =3D 1;
-	state.istate =3D &the_index;
+	state.istate =3D the_repository->index;
=20
 	/*
 	 * Step 1: get a difference between orig_tree (which corresponding
@@ -454,7 +453,7 @@ static void unstage_changes_unless_new(struct object_id=
 *orig_tree)
=20
 		/* Look up the path's position in the current index. */
 		p =3D diff_queued_diff.queue[i];
-		pos =3D index_name_pos(&the_index, p->two->path,
+		pos =3D index_name_pos(the_repository->index, p->two->path,
 				     strlen(p->two->path));
=20
 		/*
@@ -465,10 +464,10 @@ static void unstage_changes_unless_new(struct object_=
id *orig_tree)
 		 * path, but left it out of the working tree, then clear the
 		 * SKIP_WORKTREE bit and write it to the working tree.
 		 */
-		if (pos >=3D 0 && ce_skip_worktree(the_index.cache[pos])) {
+		if (pos >=3D 0 && ce_skip_worktree(the_repository->index->cache[pos])) {
 			struct stat st;
=20
-			ce =3D the_index.cache[pos];
+			ce =3D the_repository->index->cache[pos];
 			if (!lstat(ce->name, &st)) {
 				/* Conflicting path present; relocate it */
 				struct strbuf new_path =3D STRBUF_INIT;
@@ -504,12 +503,12 @@ static void unstage_changes_unless_new(struct object_=
id *orig_tree)
 			if (pos < 0)
 				option =3D ADD_CACHE_OK_TO_ADD;
=20
-			ce =3D make_cache_entry(&the_index,
+			ce =3D make_cache_entry(the_repository->index,
 					      p->one->mode,
 					      &p->one->oid,
 					      p->one->path,
 					      0, 0);
-			add_index_entry(&the_index, ce, option);
+			add_index_entry(the_repository->index, ce, option);
 		}
 	}
 	diff_flush(&diff_opts);
@@ -518,7 +517,7 @@ static void unstage_changes_unless_new(struct object_id=
 *orig_tree)
 	 * Step 4: write the new index to disk
 	 */
 	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
-	if (write_locked_index(&the_index, &lock,
+	if (write_locked_index(the_repository->index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("could not write index"));
 }
@@ -539,7 +538,7 @@ static int do_apply_stash(const char *prefix, struct st=
ash_info *info,
 					 NULL, NULL, NULL))
 		return error(_("could not write index"));
=20
-	if (write_index_as_tree(&c_tree, &the_index, get_index_file(), 0,
+	if (write_index_as_tree(&c_tree, the_repository->index, get_index_file(),=
 0,
 				NULL))
 		return error(_("cannot apply a stash in the middle of a merge"));
=20
@@ -562,14 +561,14 @@ static int do_apply_stash(const char *prefix, struct =
stash_info *info,
 				return error(_("conflicts in index. "
 					       "Try without --index."));
=20
-			discard_index(&the_index);
+			discard_index(the_repository->index);
 			repo_read_index(the_repository);
-			if (write_index_as_tree(&index_tree, &the_index,
+			if (write_index_as_tree(&index_tree, the_repository->index,
 						get_index_file(), 0, NULL))
 				return error(_("could not save index tree"));
=20
 			reset_head();
-			discard_index(&the_index);
+			discard_index(the_repository->index);
 			repo_read_index(the_repository);
 		}
 	}
@@ -875,8 +874,8 @@ static void diff_include_untracked(const struct stash_i=
nfo *info, struct diff_op
 	}
=20
 	unpack_tree_opt.head_idx =3D -1;
-	unpack_tree_opt.src_index =3D &the_index;
-	unpack_tree_opt.dst_index =3D &the_index;
+	unpack_tree_opt.src_index =3D the_repository->index;
+	unpack_tree_opt.dst_index =3D the_repository->index;
 	unpack_tree_opt.merge =3D 1;
 	unpack_tree_opt.fn =3D stash_worktree_untracked_merge;
=20
@@ -1395,7 +1394,7 @@ static int do_create_stash(const struct pathspec *ps,=
 struct strbuf *stash_msg_b
=20
 	strbuf_addf(&commit_tree_label, "index on %s\n", msg.buf);
 	commit_list_insert(head_commit, &parents);
-	if (write_index_as_tree(&info->i_tree, &the_index, get_index_file(), 0,
+	if (write_index_as_tree(&info->i_tree, the_repository->index, get_index_f=
ile(), 0,
 				NULL) ||
 	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
 			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
@@ -1540,9 +1539,9 @@ static int do_push_stash(const struct pathspec *ps, c=
onst char *stash_msg, int q
 		char *ps_matched =3D xcalloc(ps->nr, 1);
=20
 		/* TODO: audit for interaction with sparse-index. */
-		ensure_full_index(&the_index);
-		for (i =3D 0; i < the_index.cache_nr; i++)
-			ce_path_match(&the_index, the_index.cache[i], ps,
+		ensure_full_index(the_repository->index);
+		for (i =3D 0; i < the_repository->index->cache_nr; i++)
+			ce_path_match(the_repository->index, the_repository->index->cache[i], p=
s,
 				      ps_matched);
=20
 		if (report_path_error(ps_matched, ps)) {
@@ -1612,7 +1611,7 @@ static int do_push_stash(const struct pathspec *ps, c=
onst char *stash_msg, int q
 				goto done;
 			}
 		}
-		discard_index(&the_index);
+		discard_index(the_repository->index);
 		if (ps->nr) {
 			struct child_process cp_add =3D CHILD_PROCESS_INIT;
 			struct child_process cp_diff =3D CHILD_PROCESS_INIT;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e4e18adb57..93f4b9d726 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
@@ -207,18 +206,18 @@ static int module_list_compute(const char **argv,
 	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
=20
-	for (i =3D 0; i < the_index.cache_nr; i++) {
-		const struct cache_entry *ce =3D the_index.cache[i];
+	for (i =3D 0; i < the_repository->index->cache_nr; i++) {
+		const struct cache_entry *ce =3D the_repository->index->cache[i];
=20
-		if (!match_pathspec(&the_index, pathspec, ce->name, ce_namelen(ce),
+		if (!match_pathspec(the_repository->index, pathspec, ce->name, ce_namele=
n(ce),
 				    0, ps_matched, 1) ||
 		    !S_ISGITLINK(ce->ce_mode))
 			continue;
=20
 		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
 		list->entries[list->nr++] =3D ce;
-		while (i + 1 < the_index.cache_nr &&
-		       !strcmp(ce->name, the_index.cache[i + 1]->name))
+		while (i + 1 < the_repository->index->cache_nr &&
+		       !strcmp(ce->name, the_repository->index->cache[i + 1]->name))
 			/*
 			 * Skip entries with the same name in different stages
 			 * to make sure an entry is returned only once.
@@ -907,7 +906,7 @@ static void generate_submodule_summary(struct summary_c=
b *info,
 			int fd =3D open(p->sm_path, O_RDONLY);
=20
 			if (fd < 0 || fstat(fd, &st) < 0 ||
-			    index_fd(&the_index, &p->oid_dst, fd, &st, OBJ_BLOB,
+			    index_fd(the_repository->index, &p->oid_dst, fd, &st, OBJ_BLOB,
 				     p->sm_path, 0))
 				error(_("couldn't hash object from '%s'"), p->sm_path);
 		} else {
@@ -3243,21 +3242,21 @@ static void die_on_index_match(const char *path, in=
t force)
 		char *ps_matched =3D xcalloc(ps.nr, 1);
=20
 		/* TODO: audit for interaction with sparse-index. */
-		ensure_full_index(&the_index);
+		ensure_full_index(the_repository->index);
=20
 		/*
 		 * Since there is only one pathspec, we just need to
 		 * check ps_matched[0] to know if a cache entry matched.
 		 */
-		for (i =3D 0; i < the_index.cache_nr; i++) {
-			ce_path_match(&the_index, the_index.cache[i], &ps,
+		for (i =3D 0; i < the_repository->index->cache_nr; i++) {
+			ce_path_match(the_repository->index, the_repository->index->cache[i], &=
ps,
 				      ps_matched);
=20
 			if (ps_matched[0]) {
 				if (!force)
 					die(_("'%s' already exists in the index"),
 					    path);
-				if (!S_ISGITLINK(the_index.cache[i]->ce_mode))
+				if (!S_ISGITLINK(the_repository->index->cache[i]->ce_mode))
 					die(_("'%s' already exists in the index "
 					      "and is not a submodule"), path);
 				break;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7bcaa1476c..6321810006 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "bulk-checkin.h"
 #include "config.h"
@@ -247,16 +247,16 @@ static int test_if_untracked_cache_is_supported(void)
 static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen =3D strlen(path);
-	int pos =3D index_name_pos(&the_index, path, namelen);
+	int pos =3D index_name_pos(the_repository->index, path, namelen);
 	if (0 <=3D pos) {
-		mark_fsmonitor_invalid(&the_index, the_index.cache[pos]);
+		mark_fsmonitor_invalid(the_repository->index, the_repository->index->cac=
he[pos]);
 		if (mark)
-			the_index.cache[pos]->ce_flags |=3D flag;
+			the_repository->index->cache[pos]->ce_flags |=3D flag;
 		else
-			the_index.cache[pos]->ce_flags &=3D ~flag;
-		the_index.cache[pos]->ce_flags |=3D CE_UPDATE_IN_BASE;
-		cache_tree_invalidate_path(&the_index, path);
-		the_index.cache_changed |=3D CE_ENTRY_CHANGED;
+			the_repository->index->cache[pos]->ce_flags &=3D ~flag;
+		the_repository->index->cache[pos]->ce_flags |=3D CE_UPDATE_IN_BASE;
+		cache_tree_invalidate_path(the_repository->index, path);
+		the_repository->index->cache_changed |=3D CE_ENTRY_CHANGED;
 		return 0;
 	}
 	return -1;
@@ -266,7 +266,7 @@ static int remove_one_path(const char *path)
 {
 	if (!allow_remove)
 		return error("%s: does not exist and --remove not passed", path);
-	if (remove_file_from_index(&the_index, path))
+	if (remove_file_from_index(the_repository->index, path))
 		return error("%s: cannot remove from the index", path);
 	return 0;
 }
@@ -291,24 +291,24 @@ static int add_one_path(const struct cache_entry *old=
, const char *path, int len
 	struct cache_entry *ce;
=20
 	/* Was the old index entry already up-to-date? */
-	if (old && !ce_stage(old) && !ie_match_stat(&the_index, old, st, 0))
+	if (old && !ce_stage(old) && !ie_match_stat(the_repository->index, old, s=
t, 0))
 		return 0;
=20
-	ce =3D make_empty_cache_entry(&the_index, len);
+	ce =3D make_empty_cache_entry(the_repository->index, len);
 	memcpy(ce->name, path, len);
 	ce->ce_flags =3D create_ce_flags(0);
 	ce->ce_namelen =3D len;
-	fill_stat_cache_info(&the_index, ce, st);
+	fill_stat_cache_info(the_repository->index, ce, st);
 	ce->ce_mode =3D ce_mode_from_stat(old, st->st_mode);
=20
-	if (index_path(&the_index, &ce->oid, path, st,
+	if (index_path(the_repository->index, &ce->oid, path, st,
 		       info_only ? 0 : HASH_WRITE_OBJECT)) {
 		discard_cache_entry(ce);
 		return -1;
 	}
 	option =3D allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |=3D allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_index_entry(&the_index, ce, option)) {
+	if (add_index_entry(the_repository->index, ce, option)) {
 		discard_cache_entry(ce);
 		return error("%s: cannot add to the index - missing --add option?", path=
);
 	}
@@ -341,11 +341,11 @@ static int add_one_path(const struct cache_entry *old=
, const char *path, int len
 static int process_directory(const char *path, int len, struct stat *st)
 {
 	struct object_id oid;
-	int pos =3D index_name_pos(&the_index, path, len);
+	int pos =3D index_name_pos(the_repository->index, path, len);
=20
 	/* Exact match: file or existing gitlink */
 	if (pos >=3D 0) {
-		const struct cache_entry *ce =3D the_index.cache[pos];
+		const struct cache_entry *ce =3D the_repository->index->cache[pos];
 		if (S_ISGITLINK(ce->ce_mode)) {
=20
 			/* Do nothing to the index if there is no HEAD! */
@@ -360,8 +360,8 @@ static int process_directory(const char *path, int len,=
 struct stat *st)
=20
 	/* Inexact match: is there perhaps a subdirectory match? */
 	pos =3D -pos-1;
-	while (pos < the_index.cache_nr) {
-		const struct cache_entry *ce =3D the_index.cache[pos++];
+	while (pos < the_repository->index->cache_nr) {
+		const struct cache_entry *ce =3D the_repository->index->cache[pos++];
=20
 		if (strncmp(ce->name, path, len))
 			break;
@@ -391,8 +391,8 @@ static int process_path(const char *path, struct stat *=
st, int stat_errno)
 	if (has_symlink_leading_path(path, len))
 		return error("'%s' is beyond a symbolic link", path);
=20
-	pos =3D index_name_pos(&the_index, path, len);
-	ce =3D pos < 0 ? NULL : the_index.cache[pos];
+	pos =3D index_name_pos(the_repository->index, path, len);
+	ce =3D pos < 0 ? NULL : the_repository->index->cache[pos];
 	if (ce && ce_skip_worktree(ce)) {
 		/*
 		 * working directory version is assumed "good"
@@ -400,7 +400,7 @@ static int process_path(const char *path, struct stat *=
st, int stat_errno)
 		 * On the other hand, removing it from index should work
 		 */
 		if (!ignore_skip_worktree_entries && allow_remove &&
-		    remove_file_from_index(&the_index, path))
+		    remove_file_from_index(the_repository->index, path))
 			return error("%s: cannot remove from the index", path);
 		return 0;
 	}
@@ -428,7 +428,7 @@ static int add_cacheinfo(unsigned int mode, const struc=
t object_id *oid,
 		return error("Invalid path '%s'", path);
=20
 	len =3D strlen(path);
-	ce =3D make_empty_cache_entry(&the_index, len);
+	ce =3D make_empty_cache_entry(the_repository->index, len);
=20
 	oidcpy(&ce->oid, oid);
 	memcpy(ce->name, path, len);
@@ -439,7 +439,7 @@ static int add_cacheinfo(unsigned int mode, const struc=
t object_id *oid,
 		ce->ce_flags |=3D CE_VALID;
 	option =3D allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |=3D allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_index_entry(&the_index, ce, option))
+	if (add_index_entry(the_repository->index, ce, option))
 		return error("%s: cannot add to the index - missing --add option?",
 			     path);
 	report("add '%s'", path);
@@ -451,11 +451,11 @@ static void chmod_path(char flip, const char *path)
 	int pos;
 	struct cache_entry *ce;
=20
-	pos =3D index_name_pos(&the_index, path, strlen(path));
+	pos =3D index_name_pos(the_repository->index, path, strlen(path));
 	if (pos < 0)
 		goto fail;
-	ce =3D the_index.cache[pos];
-	if (chmod_index_entry(&the_index, ce, flip) < 0)
+	ce =3D the_repository->index->cache[pos];
+	if (chmod_index_entry(the_repository->index, ce, flip) < 0)
 		goto fail;
=20
 	report("chmod %cx '%s'", flip, path);
@@ -498,7 +498,7 @@ static void update_one(const char *path)
 	}
=20
 	if (force_remove) {
-		if (remove_file_from_index(&the_index, path))
+		if (remove_file_from_index(the_repository->index, path))
 			die("git update-index: unable to remove %s", path);
 		report("remove '%s'", path);
 		return;
@@ -581,7 +581,7 @@ static void read_index_info(int nul_term_line)
=20
 		if (!mode) {
 			/* mode =3D=3D 0 means there is no such path -- remove */
-			if (remove_file_from_index(&the_index, path_name))
+			if (remove_file_from_index(the_repository->index, path_name))
 				die("git update-index: unable to remove %s",
 				    ptr);
 		}
@@ -622,12 +622,12 @@ static struct cache_entry *read_one_ent(const char *w=
hich,
 			error("%s: not in %s branch.", path, which);
 		return NULL;
 	}
-	if (!the_index.sparse_index && mode =3D=3D S_IFDIR) {
+	if (!the_repository->index->sparse_index && mode =3D=3D S_IFDIR) {
 		if (which)
 			error("%s: not a blob in %s branch.", path, which);
 		return NULL;
 	}
-	ce =3D make_empty_cache_entry(&the_index, namelen);
+	ce =3D make_empty_cache_entry(the_repository->index, namelen);
=20
 	oidcpy(&ce->oid, &oid);
 	memcpy(ce->name, path, namelen);
@@ -642,12 +642,12 @@ static int unresolve_one(const char *path)
 	struct string_list_item *item;
 	int res =3D 0;
=20
-	if (!the_index.resolve_undo)
+	if (!the_repository->index->resolve_undo)
 		return res;
-	item =3D string_list_lookup(the_index.resolve_undo, path);
+	item =3D string_list_lookup(the_repository->index->resolve_undo, path);
 	if (!item)
 		return res; /* no resolve-undo record for the path */
-	res =3D unmerge_index_entry(&the_index, path, item->util, 0);
+	res =3D unmerge_index_entry(the_repository->index, path, item->util, 0);
 	FREE_AND_NULL(item->util);
 	return res;
 }
@@ -688,13 +688,13 @@ static int do_reupdate(const char **paths,
 		 */
 		has_head =3D 0;
  redo:
-	for (pos =3D 0; pos < the_index.cache_nr; pos++) {
-		const struct cache_entry *ce =3D the_index.cache[pos];
+	for (pos =3D 0; pos < the_repository->index->cache_nr; pos++) {
+		const struct cache_entry *ce =3D the_repository->index->cache[pos];
 		struct cache_entry *old =3D NULL;
 		int save_nr;
 		char *path;
=20
-		if (ce_stage(ce) || !ce_path_match(&the_index, ce, &pathspec, NULL))
+		if (ce_stage(ce) || !ce_path_match(the_repository->index, ce, &pathspec,=
 NULL))
 			continue;
 		if (has_head)
 			old =3D read_one_ent(NULL, &head_oid,
@@ -710,7 +710,7 @@ static int do_reupdate(const char **paths,
 		 * to process each path individually
 		 */
 		if (S_ISSPARSEDIR(ce->ce_mode)) {
-			ensure_full_index(&the_index);
+			ensure_full_index(the_repository->index);
 			goto redo;
 		}
=20
@@ -718,12 +718,12 @@ static int do_reupdate(const char **paths,
 		 * path anymore, in which case, under 'allow_remove',
 		 * or worse yet 'allow_replace', active_nr may decrease.
 		 */
-		save_nr =3D the_index.cache_nr;
+		save_nr =3D the_repository->index->cache_nr;
 		path =3D xstrdup(ce->name);
 		update_one(path);
 		free(path);
 		discard_cache_entry(old);
-		if (save_nr !=3D the_index.cache_nr)
+		if (save_nr !=3D the_repository->index->cache_nr)
 			goto redo;
 	}
 	clear_pathspec(&pathspec);
@@ -739,9 +739,9 @@ static int refresh(struct refresh_params *o, unsigned i=
nt flag)
 {
 	setup_work_tree();
 	repo_read_index(the_repository);
-	*o->has_errors |=3D refresh_index(&the_index, o->flags | flag, NULL,
+	*o->has_errors |=3D refresh_index(the_repository->index, o->flags | flag,=
 NULL,
 					NULL, NULL);
-	if (has_racy_timestamp(&the_index)) {
+	if (has_racy_timestamp(the_repository->index)) {
 		/*
 		 * Even if nothing else has changed, updating the file
 		 * increases the chance that racy timestamps become
@@ -750,7 +750,7 @@ static int refresh(struct refresh_params *o, unsigned i=
nt flag)
 		 * refresh_index() as these are no actual errors.
 		 * cmd_status() does the same.
 		 */
-		the_index.cache_changed |=3D SOMETHING_CHANGED;
+		the_repository->index->cache_changed |=3D SOMETHING_CHANGED;
 	}
 	return 0;
 }
@@ -787,7 +787,7 @@ static int resolve_undo_clear_callback(const struct opt=
ion *opt UNUSED,
 {
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
-	resolve_undo_clear_index(&the_index);
+	resolve_undo_clear_index(the_repository->index);
 	return 0;
 }
=20
@@ -888,7 +888,7 @@ static enum parse_opt_result unresolve_callback(
 	*has_errors =3D do_unresolve(ctx->argc, ctx->argv,
 				prefix, prefix ? strlen(prefix) : 0);
 	if (*has_errors)
-		the_index.cache_changed =3D 0;
+		the_repository->index->cache_changed =3D 0;
=20
 	ctx->argv +=3D ctx->argc - 1;
 	ctx->argc =3D 1;
@@ -909,7 +909,7 @@ static enum parse_opt_result reupdate_callback(
 	setup_work_tree();
 	*has_errors =3D do_reupdate(ctx->argv + 1, prefix);
 	if (*has_errors)
-		the_index.cache_changed =3D 0;
+		the_repository->index->cache_changed =3D 0;
=20
 	ctx->argv +=3D ctx->argc - 1;
 	ctx->argc =3D 1;
@@ -1056,7 +1056,7 @@ int cmd_update_index(int argc, const char **argv, con=
st char *prefix)
 	if (entries < 0)
 		die("cache corrupted");
=20
-	the_index.updated_skipworktree =3D 1;
+	the_repository->index->updated_skipworktree =3D 1;
=20
 	/*
 	 * Custom copy of parse_options() because we want to handle
@@ -1111,18 +1111,18 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 	getline_fn =3D nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
 	if (preferred_index_format) {
 		if (preferred_index_format < 0) {
-			printf(_("%d\n"), the_index.version);
+			printf(_("%d\n"), the_repository->index->version);
 		} else if (preferred_index_format < INDEX_FORMAT_LB ||
 			   INDEX_FORMAT_UB < preferred_index_format) {
 			die("index-version %d not in range: %d..%d",
 			    preferred_index_format,
 			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
 		} else {
-			if (the_index.version !=3D preferred_index_format)
-				the_index.cache_changed |=3D SOMETHING_CHANGED;
+			if (the_repository->index->version !=3D preferred_index_format)
+				the_repository->index->cache_changed |=3D SOMETHING_CHANGED;
 			report(_("index-version: was %d, set to %d"),
-			       the_index.version, preferred_index_format);
-			the_index.version =3D preferred_index_format;
+			       the_repository->index->version, preferred_index_format);
+			the_repository->index->version =3D preferred_index_format;
 		}
 	}
=20
@@ -1159,16 +1159,16 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 			warning(_("core.splitIndex is set to false; "
 				  "remove or change it, if you really want to "
 				  "enable split index"));
-		if (the_index.split_index)
-			the_index.cache_changed |=3D SPLIT_INDEX_ORDERED;
+		if (the_repository->index->split_index)
+			the_repository->index->cache_changed |=3D SPLIT_INDEX_ORDERED;
 		else
-			add_split_index(&the_index);
+			add_split_index(the_repository->index);
 	} else if (!split_index) {
 		if (git_config_get_split_index() =3D=3D 1)
 			warning(_("core.splitIndex is set to true; "
 				  "remove or change it, if you really want to "
 				  "disable split index"));
-		remove_split_index(&the_index);
+		remove_split_index(the_repository->index);
 	}
=20
 	prepare_repo_settings(r);
@@ -1180,7 +1180,7 @@ int cmd_update_index(int argc, const char **argv, con=
st char *prefix)
 			warning(_("core.untrackedCache is set to true; "
 				  "remove or change it, if you really want to "
 				  "disable the untracked cache"));
-		remove_untracked_cache(&the_index);
+		remove_untracked_cache(the_repository->index);
 		report(_("Untracked cache disabled"));
 		break;
 	case UC_TEST:
@@ -1192,7 +1192,7 @@ int cmd_update_index(int argc, const char **argv, con=
st char *prefix)
 			warning(_("core.untrackedCache is set to false; "
 				  "remove or change it, if you really want to "
 				  "enable the untracked cache"));
-		add_untracked_cache(&the_index);
+		add_untracked_cache(the_repository->index);
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 		break;
 	default:
@@ -1222,7 +1222,7 @@ int cmd_update_index(int argc, const char **argv, con=
st char *prefix)
 				"set it if you really want to "
 				"enable fsmonitor"));
 		}
-		add_fsmonitor(&the_index);
+		add_fsmonitor(the_repository->index);
 		report(_("fsmonitor enabled"));
 	} else if (!fsmonitor) {
 		enum fsmonitor_mode fsm_mode =3D fsm_settings__get_mode(r);
@@ -1230,17 +1230,17 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 			warning(_("core.fsmonitor is set; "
 				"remove it if you really want to "
 				"disable fsmonitor"));
-		remove_fsmonitor(&the_index);
+		remove_fsmonitor(the_repository->index);
 		report(_("fsmonitor disabled"));
 	}
=20
-	if (the_index.cache_changed || force_write) {
+	if (the_repository->index->cache_changed || force_write) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
 			unable_to_lock_die(get_index_file(), lock_error);
 		}
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
 			die("Unable to write new index file");
 	}
=20
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 66e83d0ecb..8c75b4609b 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define USE_THE_INDEX_VARIABLE
+
 #include "builtin.h"
 #include "config.h"
 #include "environment.h"
@@ -44,8 +44,8 @@ int cmd_write_tree(int argc, const char **argv, const cha=
r *cmd_prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index =3D 0;
=20
-	ret =3D write_index_as_tree(&oid, &the_index, get_index_file(), flags,
-				  tree_prefix);
+	ret =3D write_index_as_tree(&oid, the_repository->index, get_index_file(),
+				  flags, tree_prefix);
 	switch (ret) {
 	case 0:
 		printf("%s\n", oid_to_hex(&oid));
--=20
2.44.GIT


--DadohzGqydu68p4Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYhDpUACgkQVbJhu7ck
PpQkgw/9Evjov/UyqQKzcZCB8KUH70ZqLMiMeApSL+K/X4Cr/6HBzt1iH9uERSfq
kAiFm074nkCiNr6R6b7o4aoXq3s4631vFrjuZTO5wN/vmu0L1XvZFeSsPJNPSSds
RUyd57mHL3jYCvSwYekARo/XmDPBPhUmPcCrDmnZv7yFL8UVBP3kt4TROP+LoaoE
F+7/V99E48L3ij3LJgfwdGPmeyznhgahAraauY1bwyWnSGyRmlntqqxJebmG6f05
1XB8H2xmb4dWgjF4I+8xqUnWQKMuN2z16zXvc9wKadP8CuqFX6tfU7bFFefNa6Yx
/nWIL1AHhzAN6uEXn/VINJbvJkJ3pxOs1UWE0USED5809REwNImn0+4WwbL5Pu4V
9r/rCxhDppUyt0iHcPTsxj1wdES1cc0OhU6WTu/RrS248YyLyDjAOO2FBwCmM9Lv
1P+7COFiYXKlz2H7Zv2SDdLlPscGmLRrQLXO/rZxs/xl6LtQUVrlnn+W1tLz9xye
etfMK0NLY492XmpV/uaZu0jeDgkB6uUTkCHtB8Xurywc4yDwn/nC9zt0qLZBzr6h
ZSjngtg2ynKE6tY8o/lWGszhaI9GzVFose4YyZ36eveSQ0ylbeLCu4YpTSrQof78
yeOUwCJOdXFZJWF0RtlDyHsgaafzTxi7c8vuh4k0k4ywvwtK9tA=
=uv76
-----END PGP SIGNATURE-----

--DadohzGqydu68p4Y--
