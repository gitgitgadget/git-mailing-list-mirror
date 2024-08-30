Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840A916F0EF
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008951; cv=none; b=AQCm2FjH0FHyd7Go7IYAse4wGah3pbq7dLZjEhsTeysTTOcQwDBz/UGZhfbI4cZ67HRLDw1NgcVjfuBAjUzk3olbJ1VGgGKFLVXGJNIEQfwUDPVvz4cKkqkDXQxmqwQEq5MyJvTQaXOxEBvidiquSa9sYfC6QcL8Uu7es9QiBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008951; c=relaxed/simple;
	bh=l7n4d7BJZ0Mf3pLvL7kwT+4mgSEOJRmUXj3jtkB1txw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGh5P5SuCEo5EQwGo/2IN3aazcvp71nhVhA46neP+UVG8hmtflr/t3p/rmwuJHJKz7p04MeskofN7RlDlC2nJMOqMRLI9mPs7gqLqVnj+GB3IKcwWz7yaF2vQjXH+gRdHH9m76XBks6f0rU1+Ftq4Ebc1Zk/aMGUt8ygJv1YP+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jja1i3aZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFwSVFbz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jja1i3aZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFwSVFbz"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id D6A161380266;
	Fri, 30 Aug 2024 05:09:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 30 Aug 2024 05:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008948; x=1725095348; bh=kVNjnRoQio
	hDVsNIf/2KePZBYvh0TZ4wL5PwC5mknBw=; b=Jja1i3aZ40aS5nYS2059PegTjM
	VgV7N9tGzUJIdL5iwn0G0sAmeR79pJmexjxmAWSO69LneDjEAD2gvntO5B8LJLoD
	WeLTfTDDpmntY3pzNQkEg2KNarpWM1W0LUUPkWVPqzzFZS6jtKJKDuuDGYnSSUeJ
	aQyFyhACjG3EF5ag5gu4TrJxBKKrUA0w5Eo3aVGpSr8Rjdfp1dNJnsBfzh2cw2dL
	qnyBmkBr1dhd++ZggDUH9NlHCuAxrl5fJYPH8vgxOrsFEJlRJwtxYlvcOVYo9L3f
	+Z0UmZpF+gCoEbQqwCPWlwH3tvRhgpLKVQV4FDHd9sHqn5OzOvk/qU0S+LlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008948; x=1725095348; bh=kVNjnRoQiohDVsNIf/2KePZBYvh0
	TZ4wL5PwC5mknBw=; b=CFwSVFbzeUTZ3AdcdnIOC3xqSxqD+Ea82xgRlCFlDkaN
	bd5eIx556WAsSG/jsvJ3+OkG55MSS/lEtS3cckR2PHFvSQaFsEfEeS4mkbT+R6uk
	z3E8wM12HA97FWskUcrxbefI/UQVJ4LdTS4sQkgqPrnm0pGC/Ck5+P8TTc4v4q3g
	4kf6u+tZNrOde+g6R5WrR80jPBGx0vgtMO3aH0OacP1Yztx70tk2ZjgIV8soa65x
	be9L3Ln466JHSqRmp0i1Im7jlt7fr8Svl1daR7u5I4Ec/OLkWMu5a+q1FTaU4IMR
	BS057LGSjlAOH0z+1+FoEAqGK9j4TrXo8DyMASE8pQ==
X-ME-Sender: <xms:NIzRZm1kQmWEWBYAUH68whJ_-esUHHhJ4ZqglFNNsIBUBr_P2agonw>
    <xme:NIzRZpHM8CUPxpXkaEPHnqFvZDzzsnw2wLOI6nXc7_yzxIGsyv9YiScWHUa_5PSJ7
    D9oEz26omO1lLn2TA>
X-ME-Received: <xmr:NIzRZu63XcrZdpM7vApLFfdHFzu4UFBndMySbLkPXXv9X2-XhU1hNJXesFmKSQzTqi5cPnql-K7anMV5Re56neebYJvaEAgKL_4tACBy9BzMQvXsog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:NIzRZn2QcpWNwY-RruX_160_zz58CGprWIwabb5vv--oowHB3pCFsQ>
    <xmx:NIzRZpGXF2XYyQRevUCwdklOEEB0ZHr2yDI4WRxBcPF78rbPLAG1IA>
    <xmx:NIzRZg9ryjUMhmK_P2LkM-FizgJE7HvN14FfHQnH3xmLL2Ih9ATB2A>
    <xmx:NIzRZumg0OkC8RpBRFq9R--LGTI-Ws1VxAmwY-Vz0Q-i5kwJP5Ywpw>
    <xmx:NIzRZtgDdAUa7VJ5nD9FsE6iCCuhph4Pb33jwc7SZ_1sD6ygGDQSz4N7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8530c310 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:08:56 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/21] environment: make `get_index_file()` accept a
 repository
Message-ID: <d7554cb0fe066eea8c752a3dcccb1f5975b7e6f5.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

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
 builtin/write-tree.c   |  4 ++--
 environment.c          |  7 -------
 environment.h          |  1 -
 repository.c           |  7 +++++++
 repository.h           |  1 +
 wt-status.c            |  3 ++-
 11 files changed, 36 insertions(+), 29 deletions(-)

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
index a1c1d16a099..b09320f9070 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -473,7 +473,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write new index file"));
 		commit_style = COMMIT_AS_IS;
-		ret = get_index_file();
+		ret = repo_get_index_file(the_repository);
 		goto out;
 	}
 
@@ -1874,8 +1874,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
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
index a2bae0700b4..7f5475f738c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -696,7 +696,9 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 
 static void write_tree_trivial(struct object_id *oid)
 {
-	if (write_index_as_tree(oid, the_repository->index, get_index_file(), 0, NULL))
+	if (write_index_as_tree(oid, the_repository->index,
+				repo_get_index_file(the_repository),
+				0, NULL))
 		die(_("git write-tree failed to write a tree"));
 }
 
@@ -758,7 +760,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		}
 		if (write_locked_index(the_repository->index, &lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-			die(_("unable to write %s"), get_index_file());
+			die(_("unable to write %s"), repo_get_index_file(the_repository));
 		return clean ? 0 : 1;
 	} else {
 		return try_merge_command(the_repository,
@@ -840,7 +842,7 @@ static void write_merge_heads(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
-	const char *index_file = get_index_file();
+	const char *index_file = repo_get_index_file(the_repository);
 
 	if (!no_verify) {
 		int invoked_hook;
@@ -880,8 +882,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
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
@@ -889,7 +891,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 			abort_commit(remoteheads, NULL);
 	}
 
-	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
+	if (!no_verify && run_commit_hook(0 < option_edit, repo_get_index_file(the_repository),
 					  NULL, "commit-msg",
 					  git_path_merge_msg(the_repository), NULL))
 		abort_commit(remoteheads, NULL);
diff --git a/builtin/stash.c b/builtin/stash.c
index ad6bcefb770..f2ec9549a47 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -540,8 +540,8 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 					 NULL, NULL, NULL))
 		return error(_("could not write index"));
 
-	if (write_index_as_tree(&c_tree, the_repository->index, get_index_file(), 0,
-				NULL))
+	if (write_index_as_tree(&c_tree, the_repository->index,
+				repo_get_index_file(the_repository), 0, NULL))
 		return error(_("cannot apply a stash in the middle of a merge"));
 
 	if (index) {
@@ -566,7 +566,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 			discard_index(the_repository->index);
 			repo_read_index(the_repository);
 			if (write_index_as_tree(&index_tree, the_repository->index,
-						get_index_file(), 0, NULL))
+						repo_get_index_file(the_repository), 0, NULL))
 				return error(_("could not save index tree"));
 
 			reset_head();
@@ -1406,8 +1406,8 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 
 	strbuf_addf(&commit_tree_label, "index on %s\n", msg.buf);
 	commit_list_insert(head_commit, &parents);
-	if (write_index_as_tree(&info->i_tree, the_repository->index, get_index_file(), 0,
-				NULL) ||
+	if (write_index_as_tree(&info->i_tree, the_repository->index,
+				repo_get_index_file(the_repository), 0, NULL) ||
 	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
 			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
 		if (!quiet)
@@ -1905,7 +1905,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
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
index 8c75b4609b5..9bcc4470ce1 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -6,7 +6,6 @@
 
 #include "builtin.h"
 #include "config.h"
-#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "tree.h"
@@ -44,7 +43,8 @@ int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
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
index b477239039d..b813d3fe1c4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -16,6 +16,7 @@
 #include "revision.h"
 #include "diffcore.h"
 #include "quote.h"
+#include "repository.h"
 #include "run-command.h"
 #include "strvec.h"
 #include "remote.h"
@@ -152,7 +153,7 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
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

