Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E707BC433FE
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA0F61504
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347449AbhI2XIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 19:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347447AbhI2XIL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 19:08:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075DDC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso5542844ybq.10
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gVtC6k+XrICK/pzRjFVb7dhxC17nV8nz3XPnQYrk/oI=;
        b=hAzkQmiaRwpqdX/eLuRj52pV7b33Xr7FNuUOxLjo3Ar3szQ6I+poN7MNeoJKM7DCFi
         7j9gLNjr0oHujxjSGa0qU+ndLZ3tTUcipDgSUJSpUKS202dWNNHA7oG4ywpBcFnz0phr
         LMCPN5c61VU1/DCgog4JkIrIZttxjymm4AU1ZtELmCcEGO8NdEUOkbyCP90oXUnh8v36
         LWGwli07i4QH40HUpzCxYfUZfhw/lHTaSgPHM8Chd8KzWWQxEYcDEv+UdTfXGiZf1rml
         TFSnCEshVJ3CIYHOa+e2/mmla93Pq6BFfXEcIqI5cijmnGhFlUR4ifT6AT7PQeLTvWe9
         ROig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gVtC6k+XrICK/pzRjFVb7dhxC17nV8nz3XPnQYrk/oI=;
        b=3dhQAittDnDvV0qBn/1ByTmUyn7mIbwj50aPQpfUhnkIxgn347ocynGcdD8rKOqt/9
         /MF5kTbWoylufSy2WiGDtHZHljCibehpF0R7iOCE3a3bmHWzh3QTQ1ObXv+MXk43WRCk
         unrMv9uC2/df10GcMbgFRY83yVQvGZmLXJQxksjTU5OmFhAR2Tb0yvFq5kLrjd5wxC+n
         jUbJBdA1VFJMGXho15sCwk//aHqm2TVECDcFjxx2qtWUYbW4zZuyBcoHvFIVPJwQr58J
         8/2x5oNA7/KGW267jVNOfEoHrnryrhbGQQnnPF5R2yg55cDJ7jwUD25S2Krok7C7PPRk
         Q/xg==
X-Gm-Message-State: AOAM533O0uXQKYXWb5WZVEWEV0IuaIb6ETB5a7tkEiEyUaOI6IPCEOCY
        Hna0RgkpKNqjIgYfh4ogEVxeNQ63byGCpuiKY9z9jojEJlAvF+x+utTdBRI+gEY0FyYskMI9baG
        DXf9LofqclXjBynSDOJ84lQkafJZXv4yfNZwUIM11UL2AxYtBSze1t2OnIVtAT4NbPcafT6micC
        4k
X-Google-Smtp-Source: ABdhPJyHW/+AjQOJ0GZVpOh3XDcsulu/pbc+laeqdwFkMCVV5B4yojforAo91zVuy0AhDCAw4cMbxz7q7+n8HHWx6OSK
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:bb93:: with SMTP id
 y19mr3077371ybg.266.1632956789252; Wed, 29 Sep 2021 16:06:29 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:06:17 -0700
In-Reply-To: <cover.1632956589.git.jonathantanmy@google.com>
Message-Id: <80673975382af534cafaec3fdc034966d6f41105.1632956589.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632956589.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 1/7] refs: plumb repo into ref stores
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for the next 2 patches that adds (partial) support for
arbitrary repositories to ref iterators, plumb a repository into all ref
stores. There are no changes to program logic.

(The repository is plumbed into the ref stores instead of directly into
the ref iterators themselves, so that existing code that operates on ref
stores do not need to be modified to also handle repositories.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c                | 29 ++++++++++++++++++++++-------
 refs/files-backend.c  |  6 ++++--
 refs/packed-backend.c |  4 +++-
 refs/packed-backend.h |  3 ++-
 refs/refs-internal.h  | 10 ++++++++--
 5 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 2be0d0f057..9c4e388153 100644
--- a/refs.c
+++ b/refs.c
@@ -1873,7 +1873,8 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
  * Create, record, and return a ref_store instance for the specified
  * gitdir.
  */
-static struct ref_store *ref_store_init(const char *gitdir,
+static struct ref_store *ref_store_init(struct repository *repo,
+					const char *gitdir,
 					unsigned int flags)
 {
 	const char *be_name = "files";
@@ -1883,7 +1884,7 @@ static struct ref_store *ref_store_init(const char *gitdir,
 	if (!be)
 		BUG("reference backend %s is unknown", be_name);
 
-	refs = be->init(gitdir, flags);
+	refs = be->init(repo, gitdir, flags);
 	return refs;
 }
 
@@ -1895,7 +1896,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
+	r->refs_private = ref_store_init(r, r->gitdir, REF_STORE_ALL_CAPS);
 	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
 	return r->refs_private;
 }
@@ -1925,6 +1926,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	struct ref_store *refs;
 	char *to_free = NULL;
 	size_t len;
+	struct repository *subrepo;
 
 	if (!submodule)
 		return NULL;
@@ -1950,8 +1952,19 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	if (submodule_to_gitdir(&submodule_sb, submodule))
 		goto done;
 
-	/* assume that add_submodule_odb() has been called */
-	refs = ref_store_init(submodule_sb.buf,
+	subrepo = xmalloc(sizeof(*subrepo));
+	/*
+	 * NEEDSWORK: Make get_submodule_ref_store() work with arbitrary
+	 * superprojects other than the_repository. This probably should be
+	 * done by making it take a struct repository * parameter instead of a
+	 * submodule path.
+	 */
+	if (repo_submodule_init(subrepo, the_repository, submodule,
+				null_oid())) {
+		free(subrepo);
+		goto done;
+	}
+	refs = ref_store_init(subrepo, submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -1977,10 +1990,12 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 		return refs;
 
 	if (wt->id)
-		refs = ref_store_init(git_common_path("worktrees/%s", wt->id),
+		refs = ref_store_init(the_repository,
+				      git_common_path("worktrees/%s", wt->id),
 				      REF_STORE_ALL_CAPS);
 	else
-		refs = ref_store_init(get_git_common_dir(),
+		refs = ref_store_init(the_repository,
+				      get_git_common_dir(),
 				      REF_STORE_ALL_CAPS);
 
 	if (refs)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1148c0cf09..6a481e968f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -79,13 +79,15 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
  */
-static struct ref_store *files_ref_store_create(const char *gitdir,
+static struct ref_store *files_ref_store_create(struct repository *repo,
+						const char *gitdir,
 						unsigned int flags)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 	struct strbuf sb = STRBUF_INIT;
 
+	ref_store->repo = repo;
 	ref_store->gitdir = xstrdup(gitdir);
 	base_ref_store_init(ref_store, &refs_be_files);
 	refs->store_flags = flags;
@@ -93,7 +95,7 @@ static struct ref_store *files_ref_store_create(const char *gitdir,
 	get_common_dir_noenv(&sb, gitdir);
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
 	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
-	refs->packed_ref_store = packed_ref_store_create(sb.buf, flags);
+	refs->packed_ref_store = packed_ref_store_create(repo, sb.buf, flags);
 	strbuf_release(&sb);
 
 	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f8aa97d799..ea3493b24e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -193,13 +193,15 @@ static int release_snapshot(struct snapshot *snapshot)
 	}
 }
 
-struct ref_store *packed_ref_store_create(const char *path,
+struct ref_store *packed_ref_store_create(struct repository *repo,
+					  const char *path,
 					  unsigned int store_flags)
 {
 	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 
 	base_ref_store_init(ref_store, &refs_be_packed);
+	ref_store->repo = repo;
 	ref_store->gitdir = xstrdup(path);
 	refs->store_flags = store_flags;
 
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index a01a0aff9c..942c908771 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -12,7 +12,8 @@ struct ref_transaction;
  * even among packed refs.
  */
 
-struct ref_store *packed_ref_store_create(const char *path,
+struct ref_store *packed_ref_store_create(struct repository *repo,
+					  const char *path,
 					  unsigned int store_flags);
 
 /*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 96911fb26e..d28440c9cc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -539,7 +539,8 @@ struct ref_store;
  * should call base_ref_store_init() to initialize the shared part of
  * the ref_store and to record the ref_store for later lookup.
  */
-typedef struct ref_store *ref_store_init_fn(const char *gitdir,
+typedef struct ref_store *ref_store_init_fn(struct repository *repo,
+					    const char *gitdir,
 					    unsigned int flags);
 
 typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
@@ -697,7 +698,12 @@ struct ref_store {
 	/* The backend describing this ref_store's storage scheme: */
 	const struct ref_storage_be *be;
 
-	/* The gitdir that this ref_store applies to: */
+	struct repository *repo;
+
+	/*
+	 * The gitdir that this ref_store applies to. Note that this is not
+	 * necessarily repo->gitdir if the repo has multiple worktrees.
+	 */
 	char *gitdir;
 };
 
-- 
2.33.0.685.g46640cef36-goog

