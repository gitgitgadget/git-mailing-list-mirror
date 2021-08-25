Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01039C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A0961075
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhHYXY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhHYXY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:24:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB4BC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:23:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m66-20020a257145000000b00598282d96ceso1170502ybc.3
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T9YyoqLGWbUJgYIEunSJjS5cBhbcRuH237N8fMXxEhE=;
        b=fQtkgNlNqqADZNfWbfjIzaEOgU+M9wuNEI6ktEyZvny0pzjgEoPwFsNLhgnbhNvd6O
         ZObliQB7HlEMxLiuKohFpgXD+sU9vZkaNR2xd3INle3LgvkVOUeMw0XHOARdZ30KTw8Q
         dFM0SHRfame7r9PChm8gCIvRlag1fWAnl9CD0590HUpG6ZbyoneNozwiMhXvvTfTuGPK
         mOpQ8Yp37b7o1EcZBsXchnUaRauvj8kdQmfMvZJxc2JY3ANfjBWKLYzw82dqnEueafgj
         S6PouLGvD0GdlcqFNw6RIykhzFRh3hTP0Glzc+/3/UezaQBOsDWBJmTRYgTEKmjSTIJI
         y0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T9YyoqLGWbUJgYIEunSJjS5cBhbcRuH237N8fMXxEhE=;
        b=gBMFq3+S4HsosuWCGGhxwSAtWVLkXzMYyAvS6NfFcsZoH9E/4uo0i/lcPUvMCiOcOJ
         zfr6GHmJBiWUtctpuWVjnVGBxGjRWAYtkBGcyC+IwT9xRh6DIBuW0KIu2S1DBOZj4wMa
         fvJgq66KRjEEz7un4GpxhZZTcG0/szRnjP8qj370uG6HGqKFX/dEAyJLWfX4mjBeszwx
         TWIcNz7MkaKaayI57Xz3zNV78gZN8G7gjdKVAETb3fYMfo7OeRLQPGP2uR1LXAMqtGuA
         t4cGDyiG/zqzOZDjgFhC6SjikmjQ1M9aKhAvWR32LLIdbxSEcYmrP2PVNV1Kkp9s1s+f
         URPw==
X-Gm-Message-State: AOAM532WDUwI50HvwfGpc7k5DxqMdEjiqo9Kd5WdB7TWfcVDPyBbHMae
        q2SxrSbqrKCPZ8IGvUsO4KRKGf5ogy2zjmgvSwqkoL/CWIBT5A4fTrZ9m5z++Ysr5IAA5Y9bt1F
        lSKHJDW7mmLQFnct97lUloAL/u4ESfi3rjcitBiLa2gaQe/4bXcYW2+70xsy5iCRajD6vzlO5cm
        BR
X-Google-Smtp-Source: ABdhPJxMRMUuAzfveCGUjU1UUlfsjrAftIAbnN0QwZ8anrMUggvogXGP9qHtZ6vsXxc72mbBSqS/v36LBpTDGMsstFt3
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:42c2:: with SMTP id
 p185mr1566207yba.0.1629933819640; Wed, 25 Aug 2021 16:23:39 -0700 (PDT)
Date:   Wed, 25 Aug 2021 16:23:30 -0700
In-Reply-To: <cover.1629933380.git.jonathantanmy@google.com>
Message-Id: <9187eab52552630863285ef5743a107ccc555495.1629933380.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1629933380.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [RFC PATCH 1/2] refs: make _advance() check struct repo, not flag
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, hanwen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, ref iterators access the object store each time they advance
if and only if the boolean flag DO_FOR_EACH_INCLUDE_BROKEN is unset.
(The iterators access the object store because, if
DO_FOR_EACH_INCLUDE_BROKEN is unset, they need to attempt to resolve
each ref to determine that it is not broken.)

Also, the object store accessed is always that of the_repository, making
it impossible to iterate over a submodule's refs without
DO_FOR_EACH_INCLUDE_BROKEN (unless add_submodule_odb() is used).

As a first step in resolving both these problems, replace the
DO_FOR_EACH_INCLUDE_BROKEN flag with a struct repository pointer. This
commit is a mechanical conversion - whenever DO_FOR_EACH_INCLUDE_BROKEN
is set, a NULL repository (representing access to no object store) is
used instead, and whenever DO_FOR_EACH_INCLUDE_BROKEN is unset, a
non-NULL repository (representing access to that repository's object
store) is used instead. Right now, the locations in which
non-the_repository support needs to be added are marked with BUG()
statements - in a future patch, these will be replaced. (NEEDSWORK: in
this RFC patch set, this has not been done)

I have considered and rejected the following design alternatives:

- Making all ref stores not access the object store during their
  _advance() callbacks, and making ref_iterator_advance() be responsible
  for checking the object store - thus, simplifying the code in that the
  logic of checking for the flag (current) or the pointer (after the
  equivalent of this commit) is only in one place instead of in every
  ref store's callback. However, the ref stores already make use of this
  flag for another reason - for determining if refs are resolvable when
  writing (search for "REF_STORE_ODB"). Thus, I decided to retain each
  ref store's knowledge of this flag.

- Teaching the ref iterator mechanism to never skip any ref. This has
  the same problem as above, and furthermore, all callers now need to
  handle unresolvable refs.

- Change the _advance() callback to also have a repository object
  parameter, and either skip or not skip depending on whether that
  parameter is NULL. This burdens callers to have to carry this
  information along with the iterator, and such calling code may be
  unclear as to why that parameter can be NULL in some cases and cannot
  in others.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c                | 48 +++++++++++++++++++++++--------------------
 refs/debug.c          |  4 ++--
 refs/files-backend.c  | 19 +++++++++++++----
 refs/packed-backend.c | 16 +++++++++++----
 refs/refs-internal.h  | 24 ++++++++++++----------
 5 files changed, 68 insertions(+), 43 deletions(-)

diff --git a/refs.c b/refs.c
index 8b9f7c3a80..35b85f3e79 100644
--- a/refs.c
+++ b/refs.c
@@ -1413,16 +1413,16 @@ int head_ref(each_ref_fn fn, void *cb_data)
 
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
-		const char *prefix, int trim, int flags)
+		const char *prefix, int trim, struct repository *repo,
+		int flags)
 {
 	struct ref_iterator *iter;
 
 	if (ref_paranoia < 0)
 		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
-	if (ref_paranoia)
-		flags |= DO_FOR_EACH_INCLUDE_BROKEN;
 
-	iter = refs->be->iterator_begin(refs, prefix, flags);
+	iter = refs->be->iterator_begin(refs, prefix,
+					ref_paranoia ? NULL : repo, flags);
 
 	/*
 	 * `iterator_begin()` already takes care of prefix, but we
@@ -1442,13 +1442,16 @@ struct ref_iterator *refs_ref_iterator_begin(
  * Call fn for each reference in the specified submodule for which the
  * refname begins with prefix. If trim is non-zero, then trim that
  * many characters off the beginning of each refname before passing
- * the refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to
- * include broken references in the iteration. If fn ever returns a
+ * the refname to fn. If fn ever returns a
  * non-zero value, stop the iteration and return that value;
  * otherwise, return 0.
+ *
+ * See the documentation of refs_ref_iterator_begin() for more information on
+ * the repo parameter.
  */
 static int do_for_each_repo_ref(struct repository *r, const char *prefix,
-				each_repo_ref_fn fn, int trim, int flags,
+				each_repo_ref_fn fn, int trim,
+				struct repository *repo, int flags,
 				void *cb_data)
 {
 	struct ref_iterator *iter;
@@ -1457,7 +1460,7 @@ static int do_for_each_repo_ref(struct repository *r, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
+	iter = refs_ref_iterator_begin(refs, prefix, trim, repo, flags);
 
 	return do_for_each_repo_ref_iterator(r, iter, fn, cb_data);
 }
@@ -1479,7 +1482,8 @@ static int do_for_each_ref_helper(struct repository *r,
 }
 
 static int do_for_each_ref(struct ref_store *refs, const char *prefix,
-			   each_ref_fn fn, int trim, int flags, void *cb_data)
+			   each_ref_fn fn, int trim, struct repository *repo,
+			   int flags, void *cb_data)
 {
 	struct ref_iterator *iter;
 	struct do_for_each_ref_help hp = { fn, cb_data };
@@ -1487,7 +1491,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
+	iter = refs_ref_iterator_begin(refs, prefix, trim, repo, flags);
 
 	return do_for_each_repo_ref_iterator(the_repository, iter,
 					do_for_each_ref_helper, &hp);
@@ -1495,7 +1499,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "", fn, 0, the_repository, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1506,7 +1510,7 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 			 each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(refs, prefix, fn, strlen(prefix), the_repository, 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
@@ -1518,10 +1522,10 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsig
 {
 	unsigned int flag = 0;
 
-	if (broken)
-		flag = DO_FOR_EACH_INCLUDE_BROKEN;
 	return do_for_each_ref(get_main_ref_store(the_repository),
-			       prefix, fn, 0, flag, cb_data);
+			       prefix, fn, 0,
+			       broken ? NULL : the_repository,
+			       flag, cb_data);
 }
 
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
@@ -1530,16 +1534,16 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 {
 	unsigned int flag = 0;
 
-	if (broken)
-		flag = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
+	return do_for_each_ref(refs, prefix, fn, 0,
+			       broken ? NULL : the_repository,
+			       flag, cb_data);
 }
 
 int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
 	return do_for_each_repo_ref(r, git_replace_ref_base, fn,
 				    strlen(git_replace_ref_base),
-				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+				    NULL, 0, cb_data);
 }
 
 int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
@@ -1548,7 +1552,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
 	ret = do_for_each_ref(get_main_ref_store(the_repository),
-			      buf.buf, fn, 0, 0, cb_data);
+			      buf.buf, fn, 0, the_repository, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
@@ -1556,7 +1560,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(refs, "", fn, 0,
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+			       NULL, 0, cb_data);
 }
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
@@ -2263,7 +2267,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 	strbuf_addch(&dirname, '/');
 
 	iter = refs_ref_iterator_begin(refs, dirname.buf, 0,
-				       DO_FOR_EACH_INCLUDE_BROKEN);
+				       NULL, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		if (skip &&
 		    string_list_has_string(skip, iter->refname))
diff --git a/refs/debug.c b/refs/debug.c
index 1a7a9e11cf..753d5da893 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -224,11 +224,11 @@ static struct ref_iterator_vtable debug_ref_iterator_vtable = {
 
 static struct ref_iterator *
 debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
-			 unsigned int flags)
+			 struct repository *repo, unsigned int flags)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	struct ref_iterator *res =
-		drefs->refs->be->iterator_begin(drefs->refs, prefix, flags);
+		drefs->refs->be->iterator_begin(drefs->refs, prefix, repo, flags);
 	struct debug_ref_iterator *diter = xcalloc(1, sizeof(*diter));
 	base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable, 1);
 	diter->iter = res;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 677b7e4cdd..4c42db1092 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -730,6 +730,7 @@ struct files_ref_iterator {
 	struct ref_iterator base;
 
 	struct ref_iterator *iter0;
+	struct repository *repo;
 	unsigned int flags;
 };
 
@@ -744,7 +745,13 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		    ref_type(iter->iter0->refname) != REF_TYPE_PER_WORKTREE)
 			continue;
 
-		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+		if (iter->repo && iter->repo != the_repository)
+			/*
+			 * NEEDSWORK: make ref_resolves_to_object() support
+			 * arbitrary repositories
+			 */
+			BUG("iter->repo must be NULL or the_repository");
+		if (iter->repo &&
 		    !ref_resolves_to_object(iter->iter0->refname,
 					    iter->iter0->oid,
 					    iter->iter0->flags))
@@ -793,7 +800,7 @@ static struct ref_iterator_vtable files_ref_iterator_vtable = {
 
 static struct ref_iterator *files_ref_iterator_begin(
 		struct ref_store *ref_store,
-		const char *prefix, unsigned int flags)
+		const char *prefix, struct repository *repo, unsigned int flags)
 {
 	struct files_ref_store *refs;
 	struct ref_iterator *loose_iter, *packed_iter, *overlay_iter;
@@ -801,7 +808,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
 
-	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
+	if (repo)
 		required_flags |= REF_STORE_ODB;
 
 	refs = files_downcast(ref_store, required_flags, "ref_iterator_begin");
@@ -836,10 +843,13 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * references, and (if needed) do our own check for broken
 	 * ones in files_ref_iterator_advance(), after we have merged
 	 * the packed and loose references.
+	 *
+	 * Do this by not supplying any repo, regardless of whether a repo was
+	 * supplied to files_ref_iterator_begin().
 	 */
 	packed_iter = refs_ref_iterator_begin(
 			refs->packed_ref_store, prefix, 0,
-			DO_FOR_EACH_INCLUDE_BROKEN);
+			NULL, 0);
 
 	overlay_iter = overlay_ref_iterator_begin(loose_iter, packed_iter);
 
@@ -848,6 +858,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable,
 			       overlay_iter->ordered);
 	iter->iter0 = overlay_iter;
+	iter->repo = repo;
 	iter->flags = flags;
 
 	return ref_iterator;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f8aa97d799..bc2302a6e0 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -776,6 +776,7 @@ struct packed_ref_iterator {
 	struct object_id oid, peeled;
 	struct strbuf refname_buf;
 
+	struct repository *repo;
 	unsigned int flags;
 };
 
@@ -863,7 +864,13 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		    ref_type(iter->base.refname) != REF_TYPE_PER_WORKTREE)
 			continue;
 
-		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+		if (iter->repo && iter->repo != the_repository)
+			/*
+			 * NEEDSWORK: make ref_resolves_to_object() support
+			 * arbitrary repositories
+			 */
+			BUG("iter->repo must be NULL or the_repository");
+		if (iter->repo &&
 		    !ref_resolves_to_object(iter->base.refname, &iter->oid,
 					    iter->flags))
 			continue;
@@ -913,7 +920,7 @@ static struct ref_iterator_vtable packed_ref_iterator_vtable = {
 
 static struct ref_iterator *packed_ref_iterator_begin(
 		struct ref_store *ref_store,
-		const char *prefix, unsigned int flags)
+		const char *prefix, struct repository *repo, unsigned int flags)
 {
 	struct packed_ref_store *refs;
 	struct snapshot *snapshot;
@@ -922,7 +929,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
 
-	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
+	if (repo)
 		required_flags |= REF_STORE_ODB;
 	refs = packed_downcast(ref_store, required_flags, "ref_iterator_begin");
 
@@ -954,6 +961,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 
 	iter->base.oid = &iter->oid;
 
+	iter->repo = repo;
 	iter->flags = flags;
 
 	if (prefix && *prefix)
@@ -1137,7 +1145,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 	 * of updates is exhausted, leave i set to updates->nr.
 	 */
 	iter = packed_ref_iterator_begin(&refs->base, "",
-					 DO_FOR_EACH_INCLUDE_BROKEN);
+					 NULL, 0);
 	if ((ok = ref_iterator_advance(iter)) != ITER_OK)
 		iter = NULL;
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3155708345..b20fa1f5cd 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -245,9 +245,6 @@ int refs_rename_ref_available(struct ref_store *refs,
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define SYMREF_MAXDEPTH 5
 
-/* Include broken references in a do_for_each_ref*() iteration: */
-#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
-
 /*
  * Reference iterators
  *
@@ -349,16 +346,19 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
  * Return an iterator that goes over each reference in `refs` for
  * which the refname begins with prefix. If trim is non-zero, then
  * trim that many characters off the beginning of each refname.
- * The output is ordered by refname. The following flags are supported:
+ * The output is ordered by refname.
+ *
+ * Pass NULL as repo to include broken references in the iteration, or non-NULL
+ * to skip references that do not resolve to an object in the given repo.
  *
- * DO_FOR_EACH_INCLUDE_BROKEN: include broken references in
- *         the iteration.
+ * The following flags are supported:
  *
  * DO_FOR_EACH_PER_WORKTREE_ONLY: only produce REF_TYPE_PER_WORKTREE refs.
  */
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
-		const char *prefix, int trim, int flags);
+		const char *prefix, int trim, struct repository *repo,
+		int flags);
 
 /*
  * A callback function used to instruct merge_ref_iterator how to
@@ -446,8 +446,9 @@ void base_ref_iterator_free(struct ref_iterator *iter);
 /*
  * backend-specific implementation of ref_iterator_advance. For symrefs, the
  * function should set REF_ISSYMREF, and it should also dereference the symref
- * to provide the OID referent. If DO_FOR_EACH_INCLUDE_BROKEN is set, symrefs
- * with non-existent referents and refs pointing to non-existent object names
+ * to provide the OID referent. If a NULL repo was passed to the _begin()
+ * function that created this iterator, symrefs with non-existent referents and
+ * refs pointing to non-existent object names
  * should also be returned. If DO_FOR_EACH_PER_WORKTREE_ONLY, only
  * REF_TYPE_PER_WORKTREE refs should be returned.
  */
@@ -504,7 +505,7 @@ int do_for_each_repo_ref_iterator(struct repository *r,
  * where all reference backends will presumably store their
  * per-worktree refs.
  */
-#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
+#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x01
 
 struct ref_store;
 
@@ -569,7 +570,8 @@ typedef int copy_ref_fn(struct ref_store *ref_store,
  */
 typedef struct ref_iterator *ref_iterator_begin_fn(
 		struct ref_store *ref_store,
-		const char *prefix, unsigned int flags);
+		const char *prefix, struct repository *repo,
+		unsigned int flags);
 
 /* reflog functions */
 
-- 
2.33.0.rc2.250.ged5fa647cd-goog

