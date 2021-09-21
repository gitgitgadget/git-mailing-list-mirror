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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230E1C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0699361166
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhIUQwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhIUQwp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:52:45 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B08C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:16 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id p12-20020ad4496c000000b0037a535cb8b2so231447472qvy.15
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O/Hj74umZUSqytV6ZDox3DChOc/rmL/nE86YLHIW7sk=;
        b=qRjAnr3ZzSW+UkwyKhXaI2qufF7966X7nV5uPBwrBOnFjiJMEiJSgXHQwi6R7eWwRU
         ENAjva7Gs4sytipGzmScCl0Jp/SU6dwe0LNqaMtJ8LUeHXEzWrVNebPCSlXnI3BatGVO
         y7MbYAvGNNzFun35wX6iGPkNbFDp/RAIXfSYlAXL4cuqHtO2R8idIJdF1PK3aaPjEDTC
         2c9vrIfBfFkKtczM7ybp+YOLZzqETqD5LJ3bKEMel5Obp6kwaRKwkNLggokEe2O2aGr2
         mUqnSomYFT/jzRTpzaoH3Q0Pn4AycCu5yhZgED1q4RkJxSYcGATDqg/H/P6IydMFjUNu
         asew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O/Hj74umZUSqytV6ZDox3DChOc/rmL/nE86YLHIW7sk=;
        b=tUqWZB6pEyu0euzxH/y85Q/DtOr58Ztgn931G98ZSdBb9CauRW2WZjq3XajPKUOn0G
         DZhO7YBJVVSb7y2hDsINRShLPbf1AdId3hxjfTUJmjALDck79H4Opi65T0N0yMhiqYnl
         h29uSFoEsNeREItb9v3bknldJeRDjzGso6u+UmfnjbsuLziKK4c/YyCVYCSCCPg1JgKl
         IkX1/Ps/4iYhvVFNiiRuGXCjMrbZ1YWmvumbSocg+cR4L+kL1ZyTf9dLJ9gra1jdl2M4
         CAUj9LHF7N1TeeIWLNUFHmPAL6/jQkxREbiUIcOQhgFaMy6UlspVlJ/3hBdAt8VB/q2W
         0ucQ==
X-Gm-Message-State: AOAM530CGMeLU+xgTkn0gClxBf6QqN55tArQB/SIWZhorHvzyNnQ13lY
        POEmL6/CrSkdkj1crfIwd1WH3M0nIpfgZmSGf3oUJcVkZmLCA+I5o7FCEqhwdMZuYaCGdqn7Ptx
        O9E5fVyfoYOLbikkNWVGeI9l7W4QwXu6Cb+1FLSxkqL50eACa19dZVZ2WmbIAfPu8ZuRX4fhm0u
        vt
X-Google-Smtp-Source: ABdhPJzns6Q+3NF872Am62if5NuexROqGLd4rFSJt9oIFfSOQUOrI917KanlblAjwYEQMllOoibChwR46fI97JZGZx0e
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:f3c6:: with SMTP id
 f6mr15575540qvm.33.1632243075793; Tue, 21 Sep 2021 09:51:15 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:51:03 -0700
In-Reply-To: <cover.1632242495.git.jonathantanmy@google.com>
Message-Id: <493fff7f4716d889da751b5f8c6740cc1e3aa360.1632242495.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 1/9] refs: make _advance() check struct repo, not flag
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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

I have considered and rejected the following design alternative:

- Change the _advance() callback to also have a repository object
  parameter, and either skip or not skip depending on whether that
  parameter is NULL. This burdens callers to have to carry this
  information along with the iterator, and such calling code may be
  unclear as to why that parameter can be NULL in some cases and cannot
  in others.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c                | 46 +++++++++++++++++++++++--------------------
 refs/files-backend.c  | 14 ++++---------
 refs/iterator.c       | 18 ++++++++++++++++-
 refs/packed-backend.c | 10 +---------
 refs/refs-internal.h  | 27 +++++++++++++++----------
 5 files changed, 64 insertions(+), 51 deletions(-)

diff --git a/refs.c b/refs.c
index 8b9f7c3a80..49ddcdac53 100644
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
 
 	iter = refs->be->iterator_begin(refs, prefix, flags);
+	iter->repo = ref_paranoia ? NULL : repo;
 
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
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 677b7e4cdd..cd145301d0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -744,12 +744,6 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		    ref_type(iter->iter0->refname) != REF_TYPE_PER_WORKTREE)
 			continue;
 
-		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-		    !ref_resolves_to_object(iter->iter0->refname,
-					    iter->iter0->oid,
-					    iter->iter0->flags))
-			continue;
-
 		iter->base.refname = iter->iter0->refname;
 		iter->base.oid = iter->iter0->oid;
 		iter->base.flags = iter->iter0->flags;
@@ -801,9 +795,6 @@ static struct ref_iterator *files_ref_iterator_begin(
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
 
-	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
-		required_flags |= REF_STORE_ODB;
-
 	refs = files_downcast(ref_store, required_flags, "ref_iterator_begin");
 
 	/*
@@ -836,10 +827,13 @@ static struct ref_iterator *files_ref_iterator_begin(
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
 
diff --git a/refs/iterator.c b/refs/iterator.c
index a89d132d4f..5af6554887 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -10,7 +10,23 @@
 
 int ref_iterator_advance(struct ref_iterator *ref_iterator)
 {
-	return ref_iterator->vtable->advance(ref_iterator);
+	int ok;
+
+	if (ref_iterator->repo && ref_iterator->repo != the_repository)
+		/*
+		 * NEEDSWORK: make ref_resolves_to_object() support
+		 * arbitrary repositories
+		 */
+		BUG("ref_iterator->repo must be NULL or the_repository");
+	while ((ok = ref_iterator->vtable->advance(ref_iterator)) == ITER_OK) {
+		if (ref_iterator->repo &&
+		    !ref_resolves_to_object(ref_iterator->refname,
+					    ref_iterator->oid,
+					    ref_iterator->flags))
+			continue;
+		return ITER_OK;
+	}
+	return ok;
 }
 
 int ref_iterator_peel(struct ref_iterator *ref_iterator,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f8aa97d799..f52d5488b8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -863,11 +863,6 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		    ref_type(iter->base.refname) != REF_TYPE_PER_WORKTREE)
 			continue;
 
-		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-		    !ref_resolves_to_object(iter->base.refname, &iter->oid,
-					    iter->flags))
-			continue;
-
 		return ITER_OK;
 	}
 
@@ -922,8 +917,6 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
 
-	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
-		required_flags |= REF_STORE_ODB;
 	refs = packed_downcast(ref_store, required_flags, "ref_iterator_begin");
 
 	/*
@@ -1136,8 +1129,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 	 * list of refs is exhausted, set iter to NULL. When the list
 	 * of updates is exhausted, leave i set to updates->nr.
 	 */
-	iter = packed_ref_iterator_begin(&refs->base, "",
-					 DO_FOR_EACH_INCLUDE_BROKEN);
+	iter = refs_ref_iterator_begin(&refs->base, "", 0, NULL, 0);
 	if ((ok = ref_iterator_advance(iter)) != ITER_OK)
 		iter = NULL;
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3155708345..dc0ed65686 100644
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
@@ -305,6 +302,12 @@ struct ref_iterator {
 	 */
 	unsigned int ordered : 1;
 
+	/*
+	 * See the documentation of refs_ref_iterator_begin() for more
+	 * information.
+	 */
+	struct repository *repo;
+
 	const char *refname;
 	const struct object_id *oid;
 	unsigned int flags;
@@ -349,16 +352,19 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
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
@@ -446,8 +452,9 @@ void base_ref_iterator_free(struct ref_iterator *iter);
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
@@ -504,7 +511,7 @@ int do_for_each_repo_ref_iterator(struct repository *r,
  * where all reference backends will presumably store their
  * per-worktree refs.
  */
-#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
+#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x01
 
 struct ref_store;
 
-- 
2.33.0.464.g1972c5931b-goog

