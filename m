Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A91A3037
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140576; cv=none; b=fZc1tY8YEmk+vUyDLZM92s6+DDpidv8l6wHZy11e4QpNwGuljVEOHDMGapfx4/lrseoPAR03hMEDdH6fj9lAIAnztOLklwrLXNekCcAKYuw7vViuvEwbMlzji+a+KsRYCze4D9pxesbsxeBC/SlceIN6Z6Cyww0gy1VhbjVJOeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140576; c=relaxed/simple;
	bh=LnIXckUGzoxDq3PToU69Tp9lgD147tCqeUuj7GYplfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttyyVs7vxTFgtkgbrl0JdH4PzzFA6auD6sPUvGPpzLdlczFrJp5Cz485VGInqTpRC9Ea5FWzS0kvo+AodVUDzTOmf9X9GJRJUm1WfLaHmehom5ajnh7baqo4rQHgTcmS8xOgW+3lFISOyTO188SxBVWtB/iL7SR5DXM0unn2zXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R8ztkZtw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LkxutxNX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R8ztkZtw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LkxutxNX"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D847111405B2;
	Thu, 12 Sep 2024 07:29:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 12 Sep 2024 07:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140573; x=1726226973; bh=n9r/RHC3y6
	68bCqn4KgmXwMRB3Xke8P0UlGtq+99XnA=; b=R8ztkZtwBKRczTaTLV+nQtllYM
	4sxhWbIRnWtueRgGHA8wLrKOWRKN3ulZX5m+BPougeJrlRJAhezn5NqPcT89PwlI
	ZnjgMkfuBIJBxt/E+IIEVMlUwsuN1XRo6oy9hQ+DLy0Pbc5p4P9FQd2Gn+CXQwnD
	CoLWgRj49TpY66Jxq2YUlWePxShtkMTVvg+cs6BDZBj5Qcw9+MO+b8LwQWeC6FB1
	OtqyQVN+2PHzxYEo3KgUJtrR+yjnRdn7/feZUqyIonu1a7qNfpCtjBi4pHqZ3nQH
	KeOsAmzTNCTlN9xEVeTN3Mt/MR9oFjBIiVbKPz82RT9lpPWwyCTq9RNTz71w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140573; x=1726226973; bh=n9r/RHC3y668bCqn4KgmXwMRB3Xk
	e8P0UlGtq+99XnA=; b=LkxutxNX9zdyu68KzPRi09a9syUIwsDX959gQLZ80TO1
	cJQ7pvHmBk56v85W+/hrXoD+jdS/Bn0PfSvkuuM0MCBuYmsMpkIbag7DbyEUGL4Q
	UL3bhOvPf+6XSm4zj+V58/4W01IVDwWDo0QkIQNFVEpux7OdG0qg1KsZ2RydfWNX
	Iy49Nyn3hth8kg4AkH73D4PwSBXmjY/sWGLLNllxNKulEVYqrnTIaSwSq2rjKRho
	r5Bm7PLhj75FDtkpcDuBMeEqGrSwituHQghZVq3/ofIkAW2Yvg/GaJTlbCm8nEIt
	qi27ZdCxrNeuAq/N7D/Jb01DKVpxHnldm4nmxsoD4A==
X-ME-Sender: <xms:ndDiZgWHevTFRwyZD7EJC2PLdNgTuhEcZIXLqUfUrUKJFvbjEGF2OQ>
    <xme:ndDiZkkXDER573sjYZRJvu46P816X2LratRjKEcm7uaEnWo3Q7-SbOARE7xuIRCJX
    h-3b4eQy7UssBQM4Q>
X-ME-Received: <xmr:ndDiZkbYvZLqtTJCmzThiMzkMxjlfscHNRmbMFXT1mNnu4Vl_FcyOoKr2Mo0AlAvqffSUNQZczRBdKgCkVShDX-EbrBcGwhghrGiKBgFwwz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:ndDiZvVlj2QaFacwl9pOQH9VqKbp4AzjIpLd3925wLsHc9V3lO0CMg>
    <xmx:ndDiZqlLyFYNlWEuwehFVzHAg29LA91jvH2DFzM8c1TQh0zSowwFYA>
    <xmx:ndDiZkep9LVINrVtYxwMz82O8NhS83yJKmGzqgDxe-phdGlt_50Xdw>
    <xmx:ndDiZsFuU1t61GZUvlcyvVOohQXpK2zaduL8JysY-Zt5ZN4bBJhajg>
    <xmx:ndDiZhsFeaFh1anUT7m6zb-uoq5Mo04KsjkjD7i4-DHwREWBCBteomGH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:29:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 87f3297a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:24 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:29:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 04/21] environment: make `get_index_file()` accept a
 repository
Message-ID: <f82bee6d04f59d3f340dde8c309150a14f58420d.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1726139990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726139990.git.ps@pks.im>

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
index 49c42c25daa..849a912b031 100644
--- a/repository.c
+++ b/repository.c
@@ -112,6 +112,13 @@ const char *repo_get_object_directory(struct repository *repo)
 	return repo->objects->odb->path;
 }
 
+const char *repo_get_index_file(struct repository *repo)
+{
+	if (!repo->index_file)
+		BUG("repository hasn't been set up");
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
2.46.0.551.gc5ee8f2d1c.dirty

