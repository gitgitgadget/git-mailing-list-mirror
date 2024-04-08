Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12451428EE
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597901; cv=none; b=nk4nFDxBxDTaeUGuAEFx7GcD+BHE3pZfK9ybbuGxakesLqaho/27HQYe2pfOMzXI/z+or03HSQkUWAHfBq9w7xExRWO3fP76KXjziNtb/mZ4XqsTmZm4VAcdYpBI2CRWCpHkBCsHThCHeWwPH3JYYneU/4WO4xPGP1A0hsSAscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597901; c=relaxed/simple;
	bh=m4a/LFpPnZf76EWTT6kJ1dpDszrwzJRWye0ISP5cHZA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=O4lceNRTyfokvYWztHcn/asUdy8lXIa8gMZFTidrA8gvdINBKh8w41pf9o5IleDbuHF+4rvGgDpSZcuEQVMQ3Y1MBgjxD0tc+sTmH7vSrty6+O0T5NLQXuLsAHs2wpo3HxnNaF8EAvsorS9WmhVSvXdl1iqAY2DM4w1MwAdYTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asD+1Ro4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asD+1Ro4"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-345e1c645c4so522607f8f.0
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712597896; x=1713202696; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SV8q6rJXq1eh5Uu1B7laT+K51IcOaJVQ7JywKtBbkbA=;
        b=asD+1Ro4cx/t+GCf9ZgogFvBHEO7qrAt2yyEBUCWIa11adbJ0bk4j1qvxbYgxF2sBi
         fBQTqW3F2MjqzOQUTu28FJlIJlSHtj/vNqhnsdgVE3brKc3oiXAGSCUEGLz9yVGJ58CT
         ZU+cL8vKZ9mSP/hujpFcQCmujyyQxdd0/a8BoD2HcmHWkJ/h2AtGav/JBX7Xmu2jqrZr
         5gIh/ufnQ9k5pN4BPiBSD9Hwd3es9s840FplkrtQz+pmI0TR5xbxES8bBIQ8YYqOMtHt
         JY+zaVihRwiKEadmjWremxekOuTG8lfiYdoddt8IkXEpjej5sHHwWj992pY3ECEV2nYn
         89aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597896; x=1713202696;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV8q6rJXq1eh5Uu1B7laT+K51IcOaJVQ7JywKtBbkbA=;
        b=svBphHG1+/DiPV95o5bon/2c/FDpIbbYtjTRLQ6zuINxHb+DAKFE0XNCwM67LRA6Y+
         RMdUN1TQfdkzVTvLl9sH+zO3fpRNBZrouV2i9M1RJGsgE1cFuoYVcEnzg+HojU29rG00
         FgvQMQvImf39WqUQwekO4f6kYxRpvWuTRwAz08tE+lksE7fS3ONw4hKimd2dw9SZKheg
         NxFzaIECbmK4nFebYg0uAASslVfbe2JnaNqlz8/L6a4m/3FcWsCa6+ur+PO687Z0r1Yw
         540AfR0exSPN8hKogN+aLbIq7NyzEjSGK8XMtCFKstSUq4NCgoX07mPUByb7QqXCKncX
         Pe8g==
X-Gm-Message-State: AOJu0YwIZVJObw2DdAjSKCvzhEPCuwepXq11/hfkI0Obnq+c7tFRefC6
	i5d1EE78EHsX073Z7JfSm0z9JzCFq9xmzJk8E0RA/c68JOaLxD4JV3ep3e66
X-Google-Smtp-Source: AGHT+IGQOnzLENxm9HNV/rkPaWSVblTpAPIXqJmlgaKHg2SDeyiQtwd3zUQ01XKRLxYK+jPSns72OA==
X-Received: by 2002:adf:e4c9:0:b0:343:68ea:c0a3 with SMTP id v9-20020adfe4c9000000b0034368eac0a3mr6008494wrm.54.1712597896321;
        Mon, 08 Apr 2024 10:38:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d4284000000b0033e7603987dsm9535846wrq.12.2024.04.08.10.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:38:15 -0700 (PDT)
Message-Id: <6adc9dd26da4459d246591ce148c960b33bde336.1712597893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
	<pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 17:38:11 +0000
Subject: [PATCH v2 1/3] refs: keep track of unresolved reference value in
 iterator
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Since ref iterators do not hold onto the direct value of a reference
without resolving it, the only way to get ahold of a direct value of a
symbolic ref is to make a separate call to refs_read_symbolic_ref.

To make accessing the direct value of a symbolic ref more efficient,
let's save the direct value of the ref in the iterator for both the
files backend and reftable backend.

To do so, we also need to add an argument to refs_resolve_ref_unsafe to
save the direct value of the reference somewhere.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/submodule--helper.c |  2 +-
 refs.c                      | 23 +++++++++++++----------
 refs.h                      |  3 ++-
 refs/files-backend.c        | 20 +++++++++++---------
 refs/iterator.c             |  1 +
 refs/ref-cache.c            |  3 +++
 refs/ref-cache.h            |  2 ++
 refs/refs-internal.h        |  1 +
 refs/reftable-backend.c     | 13 +++++++++----
 remote.c                    |  2 +-
 sequencer.c                 |  4 ++--
 t/helper/test-ref-store.c   |  2 +-
 worktree.c                  |  4 +++-
 13 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fda50f2af1e..cf9966b7827 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -45,7 +45,7 @@ static int repo_get_default_remote(struct repository *repo, char **default_remot
 	char *dest = NULL;
 	struct strbuf sb = STRBUF_INIT;
 	struct ref_store *store = get_main_ref_store(repo);
-	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", 0, NULL,
+	const char *refname = refs_resolve_ref_unsafe(store, "HEAD", NULL, 0, NULL,
 						      NULL);
 
 	if (!refname)
diff --git a/refs.c b/refs.c
index 55d2e0b2cb9..b87a680249e 100644
--- a/refs.c
+++ b/refs.c
@@ -379,7 +379,7 @@ char *refs_resolve_refdup(struct ref_store *refs,
 {
 	const char *result;
 
-	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
+	result = refs_resolve_ref_unsafe(refs, refname, NULL, resolve_flags,
 					 oid, flags);
 	return xstrdup_or_null(result);
 }
@@ -404,7 +404,7 @@ int read_ref_full(const char *refname, int resolve_flags, struct object_id *oid,
 {
 	struct ref_store *refs = get_main_ref_store(the_repository);
 
-	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags,
+	if (refs_resolve_ref_unsafe(refs, refname, NULL, resolve_flags,
 				    oid, flags))
 		return 0;
 	return -1;
@@ -417,7 +417,7 @@ int read_ref(const char *refname, struct object_id *oid)
 
 int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
-	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING,
+	return !!refs_resolve_ref_unsafe(refs, refname, NULL, RESOLVE_REF_READING,
 					 NULL, NULL);
 }
 
@@ -773,7 +773,7 @@ int expand_ref(struct repository *repo, const char *str, int len,
 		this_result = refs_found ? &oid_from_ref : oid;
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
-		r = refs_resolve_ref_unsafe(refs, fullref.buf,
+		r = refs_resolve_ref_unsafe(refs, fullref.buf, NULL,
 					    RESOLVE_REF_READING,
 					    this_result, &flag);
 		if (r) {
@@ -807,7 +807,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
-		ref = refs_resolve_ref_unsafe(refs, path.buf,
+		ref = refs_resolve_ref_unsafe(refs, path.buf, NULL,
 					      RESOLVE_REF_READING,
 					      oid ? &hash : NULL, NULL);
 		if (!ref)
@@ -876,7 +876,7 @@ int is_pseudoref(struct ref_store *refs, const char *refname)
 		return 0;
 
 	if (ends_with(refname, "_HEAD")) {
-		refs_resolve_ref_unsafe(refs, refname,
+		refs_resolve_ref_unsafe(refs, refname, NULL,
 					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 					&oid, NULL);
 		return !is_null_oid(&oid);
@@ -884,7 +884,7 @@ int is_pseudoref(struct ref_store *refs, const char *refname)
 
 	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
 		if (!strcmp(refname, irregular_pseudorefs[i])) {
-			refs_resolve_ref_unsafe(refs, refname,
+			refs_resolve_ref_unsafe(refs, refname, NULL,
 						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 						&oid, NULL);
 			return !is_null_oid(&oid);
@@ -1590,7 +1590,7 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 	struct object_id oid;
 	int flag;
 
-	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
+	if (refs_resolve_ref_unsafe(refs, "HEAD", NULL, RESOLVE_REF_READING,
 				    &oid, &flag))
 		return fn("HEAD", &oid, flag, cb_data);
 
@@ -1928,6 +1928,7 @@ int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
 
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
+				    char **referent,
 				    int resolve_flags,
 				    struct object_id *oid,
 				    int *flags)
@@ -1989,6 +1990,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		}
 
 		*flags |= read_flags;
+		if (referent && read_flags & REF_ISSYMREF && sb_refname.len > 0)
+			*referent = sb_refname.buf;
 
 		if (!(read_flags & REF_ISSYMREF)) {
 			if (*flags & REF_BAD_NAME) {
@@ -2024,7 +2027,7 @@ int refs_init_db(struct ref_store *refs, int flags, struct strbuf *err)
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       struct object_id *oid, int *flags)
 {
-	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refname,
+	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refname, NULL,
 				       resolve_flags, oid, flags);
 }
 
@@ -2039,7 +2042,7 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	if (!refs)
 		return -1;
 
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
+	if (!refs_resolve_ref_unsafe(refs, refname, NULL, 0, oid, &flags) ||
 	    is_null_oid(oid))
 		return -1;
 	return 0;
diff --git a/refs.h b/refs.h
index 298caf6c618..2e740c692ac 100644
--- a/refs.h
+++ b/refs.h
@@ -71,9 +71,10 @@ struct pack_refs_opts {
 	struct ref_exclusions *exclusions;
 	struct string_list *includes;
 };
-
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
+
 				    const char *refname,
+				    char **referent,
 				    int resolve_flags,
 				    struct object_id *oid,
 				    int *flags);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a098d14ea00..90342549af9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -235,8 +235,9 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
 {
 	struct object_id oid;
 	int flag;
+	char *referent;
 
-	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
+	if (!refs_resolve_ref_unsafe(&refs->base, refname, &referent, RESOLVE_REF_READING,
 				     &oid, &flag)) {
 		oidclr(&oid);
 		flag |= REF_ISBROKEN;
@@ -258,7 +259,7 @@ static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
 		oidclr(&oid);
 		flag |= REF_BAD_NAME | REF_ISBROKEN;
 	}
-	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
+	add_entry_to_dir(dir, create_ref_entry(refname, referent, &oid, flag));
 }
 
 /*
@@ -843,6 +844,7 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			continue;
 
 		iter->base.refname = iter->iter0->refname;
+		iter->base.referent = iter->iter0->referent;
 		iter->base.oid = iter->iter0->oid;
 		iter->base.flags = iter->iter0->flags;
 		return ITER_OK;
@@ -1109,7 +1111,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		goto error_return;
 	}
 
-	if (!refs_resolve_ref_unsafe(&refs->base, lock->ref_name, 0,
+	if (!refs_resolve_ref_unsafe(&refs->base, lock->ref_name, NULL, 0,
 				     &lock->old_oid, NULL))
 		oidclr(&lock->old_oid);
 	goto out;
@@ -1444,7 +1446,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
-	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
+	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname, NULL,
 				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 				     &orig_oid, &flag)) {
 		ret = error("refname %s not found", oldrefname);
@@ -1490,7 +1492,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	 * the safety anyway; we want to delete the reference whatever
 	 * its current value.
 	 */
-	if (!copy && refs_resolve_ref_unsafe(&refs->base, newrefname,
+	if (!copy && refs_resolve_ref_unsafe(&refs->base, newrefname, NULL,
 					     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 					     NULL, NULL) &&
 	    refs_delete_ref(&refs->base, NULL, newrefname,
@@ -1863,7 +1865,7 @@ static int commit_ref_update(struct files_ref_store *refs,
 		int head_flag;
 		const char *head_ref;
 
-		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
+		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD", NULL,
 						   RESOLVE_REF_READING,
 						   NULL, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
@@ -1911,7 +1913,7 @@ static void update_symref_reflog(struct files_ref_store *refs,
 	struct object_id new_oid;
 
 	if (logmsg &&
-	    refs_resolve_ref_unsafe(&refs->base, target,
+	    refs_resolve_ref_unsafe(&refs->base, target, NULL,
 				    RESOLVE_REF_READING, &new_oid, NULL) &&
 	    files_log_ref_write(refs, refname, &lock->old_oid,
 				&new_oid, logmsg, 0, &err)) {
@@ -2505,7 +2507,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * to record and possibly check old_oid:
 			 */
 			if (!refs_resolve_ref_unsafe(&refs->base,
-						     referent.buf, 0,
+						     referent.buf, NULL, 0,
 						     &lock->old_oid, NULL)) {
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
@@ -3200,7 +3202,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 			int type;
 			const char *ref;
 
-			ref = refs_resolve_ref_unsafe(&refs->base, refname,
+			ref = refs_resolve_ref_unsafe(&refs->base, refname, NULL,
 						      RESOLVE_REF_NO_RECURSE,
 						      NULL, &type);
 			update = !!(ref && !(type & REF_ISSYMREF));
diff --git a/refs/iterator.c b/refs/iterator.c
index 9db8b056d56..26ca6f645ee 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -199,6 +199,7 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		}
 
 		if (selection & ITER_YIELD_CURRENT) {
+			iter->base.referent = (*iter->current)->referent;
 			iter->base.refname = (*iter->current)->refname;
 			iter->base.oid = (*iter->current)->oid;
 			iter->base.flags = (*iter->current)->flags;
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 9f9797209a4..4c23b92414a 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -34,12 +34,14 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 }
 
 struct ref_entry *create_ref_entry(const char *refname,
+				   const char *referent,
 				   const struct object_id *oid, int flag)
 {
 	struct ref_entry *ref;
 
 	FLEX_ALLOC_STR(ref, name, refname);
 	oidcpy(&ref->u.value.oid, oid);
+	ref->u.value.referent = referent;
 	ref->flag = flag;
 	return ref;
 }
@@ -428,6 +430,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			level->prefix_state = entry_prefix_state;
 			level->index = -1;
 		} else {
+			iter->base.referent = entry->u.value.referent;
 			iter->base.refname = entry->name;
 			iter->base.oid = &entry->u.value.oid;
 			iter->base.flags = entry->flag;
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 95c76e27c83..12ddee4fddc 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -42,6 +42,7 @@ struct ref_value {
 	 * referred to by the last reference in the symlink chain.
 	 */
 	struct object_id oid;
+	const char *referent;
 };
 
 /*
@@ -173,6 +174,7 @@ struct ref_entry *create_dir_entry(struct ref_cache *cache,
 				   const char *dirname, size_t len);
 
 struct ref_entry *create_ref_entry(const char *refname,
+				   const char *referent,
 				   const struct object_id *oid, int flag);
 
 /*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 56641aa57a1..a10363eccf4 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -319,6 +319,7 @@ enum do_for_each_ref_flags {
 struct ref_iterator {
 	struct ref_iterator_vtable *vtable;
 	const char *refname;
+	const char *referent;
 	const struct object_id *oid;
 	unsigned int flags;
 };
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e206d5a073c..7e8d15cc6a0 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -342,6 +342,7 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 	while (!iter->err) {
 		int flags = 0;
+		char **symref = NULL;
 
 		iter->err = reftable_iterator_next_ref(&iter->iter, &iter->ref);
 		if (iter->err)
@@ -377,7 +378,10 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			oidread(&iter->oid, iter->ref.value.val2.value);
 			break;
 		case REFTABLE_REF_SYMREF:
-			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname,
+			if (!iter->ref.value.symref)
+				symref = &iter->ref.value.symref;
+
+			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname, symref,
 						     RESOLVE_REF_READING, &iter->oid, &flags))
 				oidclr(&iter->oid);
 			break;
@@ -406,6 +410,7 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 				continue;
 
 		iter->base.refname = iter->ref.refname;
+		iter->base.referent = iter->ref.value.symref;
 		iter->base.oid = &iter->oid;
 		iter->base.flags = flags;
 
@@ -877,7 +882,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			 * so it is safe to call `refs_resolve_ref_unsafe()`
 			 * here without causing races.
 			 */
-			const char *resolved = refs_resolve_ref_unsafe(&refs->base, u->refname, 0,
+			const char *resolved = refs_resolve_ref_unsafe(&refs->base, u->refname, NULL, 0,
 								       &current_oid, NULL);
 
 			if (u->flags & REF_NO_DEREF) {
@@ -1252,7 +1257,7 @@ static int write_create_symref_table(struct reftable_writer *writer, void *cb_da
 	 * never happens.
 	 */
 	if (!create->logmsg ||
-	    !refs_resolve_ref_unsafe(&create->refs->base, create->target,
+	    !refs_resolve_ref_unsafe(&create->refs->base, create->target, NULL,
 				     RESOLVE_REF_READING, &new_oid, NULL) ||
 	    !should_write_log(&create->refs->base, create->refname))
 		return 0;
@@ -1263,7 +1268,7 @@ static int write_create_symref_table(struct reftable_writer *writer, void *cb_da
 	log.value.update.message = xstrndup(create->logmsg,
 					    create->refs->write_options.block_size / 2);
 	memcpy(log.value.update.new_hash, new_oid.hash, GIT_MAX_RAWSZ);
-	if (refs_resolve_ref_unsafe(&create->refs->base, create->refname,
+	if (refs_resolve_ref_unsafe(&create->refs->base, create->refname, NULL,
 				    RESOLVE_REF_READING, &old_oid, NULL))
 		memcpy(log.value.update.old_hash, old_oid.hash, GIT_MAX_RAWSZ);
 
diff --git a/remote.c b/remote.c
index 2b650b813b7..36525451e9c 100644
--- a/remote.c
+++ b/remote.c
@@ -518,7 +518,7 @@ static void read_config(struct repository *repo, int early)
 	repo->remote_state->current_branch = NULL;
 	if (startup_info->have_repository && !early) {
 		const char *head_ref = refs_resolve_ref_unsafe(
-			get_main_ref_store(repo), "HEAD", 0, NULL, &flag);
+			get_main_ref_store(repo), "HEAD", NULL, 0, NULL, &flag);
 		if (head_ref && (flag & REF_ISSYMREF) &&
 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
 			repo->remote_state->current_branch = make_branch(
diff --git a/sequencer.c b/sequencer.c
index fa838f264f5..e9cc2a4fdf4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1430,7 +1430,7 @@ void print_commit_summary(struct repository *r,
 	diff_setup_done(&rev.diffopt);
 
 	refs = get_main_ref_store(r);
-	head = refs_resolve_ref_unsafe(refs, "HEAD", 0, NULL, NULL);
+	head = refs_resolve_ref_unsafe(refs, "HEAD", NULL, 0, NULL, NULL);
 	if (!head)
 		die(_("unable to resolve HEAD after creating commit"));
 	if (!strcmp(head, "HEAD"))
@@ -4651,7 +4651,7 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 	if (!refs_ref_exists(get_main_ref_store(r), refname))
 		return 0;
 
-	if (!refs_resolve_ref_unsafe(get_main_ref_store(r), refname,
+	if (!refs_resolve_ref_unsafe(get_main_ref_store(r), refname, NULL,
 				     RESOLVE_REF_READING, &stash_oid, &flag))
 		return -1;
 	if (flag & REF_ISSYMREF)
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 7a0f6cac53d..bc501c5253c 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -203,7 +203,7 @@ static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 	int flags;
 	const char *ref;
 
-	ref = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
+	ref = refs_resolve_ref_unsafe(refs, refname, NULL, resolve_flags,
 				      &oid, &flags);
 	printf("%s %s 0x%x\n", oid_to_hex(&oid), ref ? ref : "(null)", flags);
 	return ref ? 0 : 1;
diff --git a/worktree.c b/worktree.c
index b02a05a74a3..1fb865c2ae7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -42,6 +42,7 @@ static void add_head_info(struct worktree *wt)
 
 	target = refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
 					 "HEAD",
+					 NULL,
 					 0,
 					 &wt->head_oid, &flags);
 	if (!target)
@@ -446,7 +447,7 @@ int is_shared_symref(const struct worktree *wt, const char *symref,
 	}
 
 	refs = get_worktree_ref_store(wt);
-	symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
+	symref_target = refs_resolve_ref_unsafe(refs, symref, NULL, 0,
 						NULL, &flags);
 	if ((flags & REF_ISSYMREF) &&
 	    symref_target && !strcmp(symref_target, target))
@@ -547,6 +548,7 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 		strbuf_worktree_ref(wt, &refname, "HEAD");
 		if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 					    refname.buf,
+					    NULL,
 					    RESOLVE_REF_READING,
 					    &oid, &flag))
 			ret = fn(refname.buf, &oid, flag, cb_data);
-- 
gitgitgadget

