Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADACC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8399F60F9E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbhJHVKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243252AbhJHVKX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:10:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D3C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 14:08:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so14221572yba.11
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wSQ99jjxVl/mNmoRMOWX1gPFUEKmek58/+NZa0+tBoA=;
        b=GSd3tgmP918RjataDsLREjnTSUl3RrxgJsswfhLaXl3S5iRN8xtCAN3/US5zdz44YR
         n1wsdO3oEOipsgs0xdc+3O8T+R3dDeQOcpbRUzOufadWPNWHT5TTLXIHLxXgtWY+U0TW
         125yduG/Ou7L4b6Wgg5eiQmI00aoXwGhnqzjYLUgr15DvHON246xmwdwwn99hBrg4hRD
         ZMOwzpL6WCRbFe2foFXXbdBa+cMlH/HF+LKqRoJ2+fk7vtwlVD82gSclOwoFPYFLDZjN
         W1s2j/5xx0P28Ltf0Hdgxasjv9sJZcNUdTHXCzp1mkyTa+WKOfETUBhUTW4lUTUR5XQE
         MmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wSQ99jjxVl/mNmoRMOWX1gPFUEKmek58/+NZa0+tBoA=;
        b=E1znGHmvGQk4GZrhadhZZ7BBasHipuTizU8L3aERk/j9oyLmL8Wsu34FKBu0fG+S4P
         ZKawhJ+OwVMAIb9KdByO4j3aN/bu41BhnxAmINMGHk+0kS6P3Pt88Whury4u9GiBMfOf
         b8bJJObfQJKx0/PMuDQMo/gLSJ5Z9fu/a/g/wIJQcRbaJdQlGjgzv7QRWd0vcBmJIFpV
         feK3IaRixFSwJvNlI6rYaIaLtOHdklQ1nybK0o0A3/9Ep/bNyEmlLgBzQcmGHc2ZptcL
         jN/sbrXwt5UngggxFiQkH8ggKhwNCWySdhmSNRv2O3rvrRGZP4qskCo6MDHHGQEIyxbz
         C6qg==
X-Gm-Message-State: AOAM533GCSpuAYHkoQ+mX5wUa+QJStwv3rJTGbf7vYfldMrFf1dERJOe
        Y+maYkYv6MkYgFyEhoMhiW+a10Ta50CV9BEsdHapU3IqCNBxuEVj5632i3dMgryEFd+bq/ltMT1
        lNynvGUfTYJLeq+dh2SsiifkxYxGI5yw/GvKSXvvFk/EhLu2bS/gDL5Kw8pI3eBsTeDj9ZKuqus
        vj
X-Google-Smtp-Source: ABdhPJxdi/F5oMRzl5R7vcetyDoiWwXc8zTy7W85nvdbTlOHRpAbcV+GxHcSBactrXptDHoaXThz1gRbR7wkY0iMwkZQ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:47d6:: with SMTP id
 u205mr5762578yba.193.1633727306589; Fri, 08 Oct 2021 14:08:26 -0700 (PDT)
Date:   Fri,  8 Oct 2021 14:08:14 -0700
In-Reply-To: <cover.1633727270.git.jonathantanmy@google.com>
Message-Id: <f050191d4c9c3d588dccf4858e28dd394e6243f7.1633727270.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1633727270.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 1/7] refs: plumb repo into ref stores
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, carenas@gmail.com,
        chooglen@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for the next 2 patches that adds (partial) support for
arbitrary repositories to ref iterators, plumb a repository into all ref
stores. There are no changes to program logic.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c                | 29 ++++++++++++++++++++++-------
 refs/files-backend.c  |  6 ++++--
 refs/packed-backend.c |  4 +++-
 refs/packed-backend.h |  4 +++-
 refs/refs-internal.h  | 10 ++++++++--
 5 files changed, 40 insertions(+), 13 deletions(-)

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
index a01a0aff9c..f61a73ec25 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -1,6 +1,7 @@
 #ifndef REFS_PACKED_BACKEND_H
 #define REFS_PACKED_BACKEND_H
 
+struct repository;
 struct ref_transaction;
 
 /*
@@ -12,7 +13,8 @@ struct ref_transaction;
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
2.33.0.882.g93a45727a2-goog

