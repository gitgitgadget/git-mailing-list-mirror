Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3B2F7D00
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634172; cv=none; b=oBz3vfhGMfn2mO8XE8mPQHpj1J9hOTwcBkSxJoiYNwfnY+qLthcromnpPeXEUK3f5uqSPxzQLR3FWqUaj0uxqOjWmoQPlrgKJqEX5VX0d7t6wnFBVBbZQ2RM3Jd/bmfjCgwISrrBahfGaNMd0ONZSMMGmLqQ4cRwyQYkmmvVQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634172; c=relaxed/simple;
	bh=XtCWj61Lm3dZamHHS0CKDBUkFueeFhuoG3oRY6ONGBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q70Hsr7aV0HrGcHeRG+NrhFSXmcH1Hcl8MOhwK3jTX6sATo1kTnKydl7YR9SIZ0TO9ozW9D8HkFGWNgnYYhK/a73zbZKiI5IMXDi+FlWPLUHgp/uW7ExI3jbhw/1eGTlZ03i4f0lf1coXFhGnXUlhJlyh+7KOYltAc3cE1Qvmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK11n5pL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK11n5pL"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso406436f8f.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751634168; x=1752238968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waJ75ISkjdtWBJ9508oOu4g7LSij3iFkr5s2Gp5G0TM=;
        b=SK11n5pLisstqi4E9mBJaJjcPxCe3SQ1y7EIZsBl23rYD8xyJT4CF9QAegGAFRqYCz
         PH6fed9yS2d+x6X1G9EZtrJH9m7DPPFn4nAz6saJkGYtsJqpzGhtbiFVQaGjLy8YPuLD
         dLqWilQ58othtxUf3OxPpD5kaB2JS9ZEVdZ2BlruUAwTFv1sm5TmpXCze9uliVHkcBzJ
         r57GsJJGGhElwoscIV7uj5Z0McxKpUO8goQiYPubq40c+iWQ20zg/189ci15qpBeU/7D
         vvMp6HHVB6lc/ys/xW2ustJHU9m+O/Ydu8MupoRPH1WZfOSHcEEWlo9OkWVZN/uiyHmp
         TW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751634168; x=1752238968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waJ75ISkjdtWBJ9508oOu4g7LSij3iFkr5s2Gp5G0TM=;
        b=mViZAMMfvDbJfadFTWTHsWjc4tFjcD2NgG4uARN6aiFWpww91tTZjcIC/QO5zGTt6W
         NUcpRyXCRwnu4+UzW0WH1CeVIaYRTsubta9D/O6RDmqkCzpWTpuiHnybqNZOgBXxXBpU
         ooQOtoPtnrYCNP4Hb1TvxK4BGYsqexYFEKQybpqowxQsFUQ1S5nViUPzE0xa6/Hb83vN
         ahL7teCRAlr3yProQPhxA8pgpVgMTjZqXAX/OpLpN5cV2OuZw5utWvU1EjHaxg9y1J58
         BYKFIC668e+i3hl1nafYsfqcTZozKXbgmR0QdJ4vrudRuZdM+0koJYYHj4lc1AvYgsxO
         AUtQ==
X-Gm-Message-State: AOJu0Yxeu5tDplwJLpQLiksOnvSYwpNFxQKJqhGxQ/5d1lST4D7+A5Sc
	+R3lqKr5vEEdSRBBzCQ+fQ7a5m5ZZ8XUIHbhkyYRVftIMXgsJ1R1kh5Ntv7bDUDt
X-Gm-Gg: ASbGnctoG9oQ+4Ju68mTjmHeEJJb2CzHh6pdYp/LY/+PcJ5hFiyM0HfNQGO6T9/B70C
	EcgOSXQlv3n1eFaUdSjjFpkFqzR3l/dYmpaUXAphKOP/PD2c07317eu/bjOtbDYkxD9mzjqxva7
	pO8N5V/WOBgC4MKb9XtmD9S029nmkvTYefBoCsOrLxt0PjdXZ2xdLf+t4FG+CTAsy81H5jNjNK5
	TNxLwuF/uDet2ip9G8JCbegolwrXHY7xBvbX12EwTzFL3ghlCl2wdbWd/nFEwze5fc6oJ9gGgC4
	EurvTYxGAJPyO3oqNPyHqiY2y2Dqn/we+BrkjZU=
X-Google-Smtp-Source: AGHT+IEItOgVrQ+f8yQ6J3bt1vk14jI0HHDlBk+5mre1zR123yrG5cxYvQ0VT0jWieSAgBt0JEixLA==
X-Received: by 2002:a5d:64c9:0:b0:3a1:f5c4:b81b with SMTP id ffacd0b85a97d-3b4964d6731mr2218335f8f.23.1751634167168;
        Fri, 04 Jul 2025 06:02:47 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba69sm2477687f8f.16.2025.07.04.06.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 06:02:46 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 04 Jul 2025 15:02:31 +0200
Subject: [PATCH v2 3/4] refs: selectively set prefix in the seek functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-306-git-for-each-ref-pagination-v2-3-bcde14acdd81@gmail.com>
References: <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
In-Reply-To: <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=15999;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=XtCWj61Lm3dZamHHS0CKDBUkFueeFhuoG3oRY6ONGBs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhn0PO65YPOSxEhWtcUC0ohZHewI8F2gZi5L
 cJvFZz7viigMYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoZ9DzAAoJED7VnySO
 Rox/ihYL/1tqPqoUTLdIPt2b6UlO3u97kv/piha9Nw2Qu8outO7efyIy8J+TEYucM9y5gslsxw8
 gO7knu/jVnc3/pRYZE8z7fNy54z6HwuOK0yUQUIsyhAGvM9jwO52uj3e1PxMcFqMjbic4mtNY7J
 vK/Zh5T+nSNgzLZPXoosaymnM0/hZn5uOBUypSipMEhT3DvsiBw6Kdr0EDRtUXM+7O0KW8bRjDD
 mc5Jk68hCMla86uuyTSfRQS/RTvxszBPwW2gByN4ojgO7TQouOScIQ2C1U2gKl27clfgalLCtUX
 lOrtuATzG9Nx3tiv1PruHCRrt09wf/7AnfRITwl7IDE4P/ZbfmrFSop6px4cZKJVrx2Im6m5yf2
 JVcVz0xqoRAsLeOVWqpS1avIIHBOZ29xouxNKKIWW9FbgI9umYfp4lBogdG9QF9l8qKxTOKEtKQ
 lKOzfGzJScnb/rCzsUWqiNBr74kosgM+K0sgAPrXeGGLmauih74Rsf3ndutKf2FjnLeQjkcIwQ6
 /I=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The ref iterator exposes a `ref_iterator_seek()` function. The name
suggests that this would seek the iterator to a specific reference in
some ways similar to how `fseek()` works for the filesystem.

However, the function actually sets the prefix for refs iteration. So
further iteration would only yield references which match the particular
prefix. This is a bit confusing.

Let's add a 'flags' field to the function, which when set with the
'REF_ITERATOR_SEEK_SET_PREFIX' flag, will set the prefix for the
iteration in-line with the existing behavior. Otherwise, the reference
backends will simply seek to the specified reference and clears any
previously set prefix. This allows users to start iteration from a
specific reference.

In the packed and reftable backend, since references are available in a
sorted list, the changes are simply setting the prefix if needed. The
changes on the files-backend are a little more involved, since the files
backend uses the 'ref-cache' mechanism. We move out the existing logic
within `cache_ref_iterator_seek()` to `cache_ref_iterator_set_prefix()`
which is called when the 'REF_ITERATOR_SEEK_SET_PREFIX' flag is set. We
then parse the provided seek string and set the required levels and
their indexes to ensure that seeking is possible.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  6 ++--
 refs.h                  | 29 +++++++++++------
 refs/debug.c            |  7 ++--
 refs/files-backend.c    |  7 ++--
 refs/iterator.c         | 26 ++++++++-------
 refs/packed-backend.c   | 17 ++++++----
 refs/ref-cache.c        | 85 ++++++++++++++++++++++++++++++++++++++++++++++---
 refs/refs-internal.h    |  7 ++--
 refs/reftable-backend.c | 21 ++++++++----
 9 files changed, 155 insertions(+), 50 deletions(-)

diff --git a/refs.c b/refs.c
index dce5c49ca2..243e6898b8 100644
--- a/refs.c
+++ b/refs.c
@@ -2666,12 +2666,12 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 		if (!initial_transaction) {
 			int ok;
 
-			if (!iter) {
+			if (!iter)
 				iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
 							       DO_FOR_EACH_INCLUDE_BROKEN);
-			} else if (ref_iterator_seek(iter, dirname.buf) < 0) {
+			else if (ref_iterator_seek(iter, dirname.buf,
+						   REF_ITERATOR_SEEK_SET_PREFIX) < 0)
 				goto cleanup;
-			}
 
 			while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 				if (skip &&
diff --git a/refs.h b/refs.h
index 7c21aaef3d..7852ad36f3 100644
--- a/refs.h
+++ b/refs.h
@@ -1299,21 +1299,32 @@ struct ref_iterator *refs_ref_iterator_begin(
  */
 int ref_iterator_advance(struct ref_iterator *ref_iterator);
 
+enum ref_iterator_seek_flag {
+	/*
+	 * Also set the seek pattern as a prefix for iteration. This ensures
+	 * that only references which match the prefix are yielded.
+	 */
+	REF_ITERATOR_SEEK_SET_PREFIX = (1 << 0),
+};
+
 /*
- * Seek the iterator to the first reference with the given prefix.
- * The prefix is matched as a literal string, without regard for path
- * separators. If prefix is NULL or the empty string, seek the iterator to the
+ * Seek the iterator to the first reference matching the given seek string.
+ * The seek string is matched as a literal string, without regard for path
+ * separators. If seek is NULL or the empty string, seek the iterator to the
  * first reference again.
  *
- * This function is expected to behave as if a new ref iterator with the same
- * prefix had been created, but allows reuse of iterators and thus may allow
- * the backend to optimize. Parameters other than the prefix that have been
- * passed when creating the iterator will remain unchanged.
+ * This function is expected to behave as if a new ref iterator has been
+ * created, but allows reuse of existing iterators for optimization.
+ *
+ * When the REF_ITERATOR_SEEK_SET_PREFIX flag is set, the iterator's prefix is
+ * updated to match the seek string, affecting all subsequent iterations. If
+ * not, the iterator seeks to the specified reference and clears any previously
+ * set prefix.
  *
  * Returns 0 on success, a negative error code otherwise.
  */
-int ref_iterator_seek(struct ref_iterator *ref_iterator,
-		      const char *prefix);
+int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *seek,
+		      unsigned int flags);
 
 /*
  * If possible, peel the reference currently being viewed by the
diff --git a/refs/debug.c b/refs/debug.c
index 485e3079d7..2ed8cff2aa 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -170,12 +170,13 @@ static int debug_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int debug_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				   const char *prefix)
+				   const char *seek, unsigned int flags)
 {
 	struct debug_ref_iterator *diter =
 		(struct debug_ref_iterator *)ref_iterator;
-	int res = diter->iter->vtable->seek(diter->iter, prefix);
-	trace_printf_key(&trace_refs, "iterator_seek: %s: %d\n", prefix ? prefix : "", res);
+	int res = diter->iter->vtable->seek(diter->iter, seek, flags);
+	trace_printf_key(&trace_refs, "iterator_seek: %s flags: %d: %d\n",
+			 seek ? seek : "", flags, res);
 	return res;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bf6f89b1d1..0e63013319 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -929,11 +929,11 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int files_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				   const char *prefix)
+				   const char *seek, unsigned int flags)
 {
 	struct files_ref_iterator *iter =
 		(struct files_ref_iterator *)ref_iterator;
-	return ref_iterator_seek(iter->iter0, prefix);
+	return ref_iterator_seek(iter->iter0, seek, flags);
 }
 
 static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
@@ -2316,7 +2316,8 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int files_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
-				      const char *prefix UNUSED)
+				      const char *seek UNUSED,
+				      unsigned int flags UNUSED)
 {
 	BUG("ref_iterator_seek() called for reflog_iterator");
 }
diff --git a/refs/iterator.c b/refs/iterator.c
index 766d96e795..f2364bd6e7 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -15,10 +15,10 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ref_iterator->vtable->advance(ref_iterator);
 }
 
-int ref_iterator_seek(struct ref_iterator *ref_iterator,
-		      const char *prefix)
+int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *seek,
+		      unsigned int flags)
 {
-	return ref_iterator->vtable->seek(ref_iterator, prefix);
+	return ref_iterator->vtable->seek(ref_iterator, seek, flags);
 }
 
 int ref_iterator_peel(struct ref_iterator *ref_iterator,
@@ -57,7 +57,8 @@ static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator UNUSED)
 }
 
 static int empty_ref_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
-				   const char *prefix UNUSED)
+				   const char *seek UNUSED,
+				   unsigned int flags UNUSED)
 {
 	return 0;
 }
@@ -224,7 +225,7 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				   const char *prefix)
+				   const char *seek, unsigned int flags)
 {
 	struct merge_ref_iterator *iter =
 		(struct merge_ref_iterator *)ref_iterator;
@@ -234,11 +235,11 @@ static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
 	iter->iter0 = iter->iter0_owned;
 	iter->iter1 = iter->iter1_owned;
 
-	ret = ref_iterator_seek(iter->iter0, prefix);
+	ret = ref_iterator_seek(iter->iter0, seek, flags);
 	if (ret < 0)
 		return ret;
 
-	ret = ref_iterator_seek(iter->iter1, prefix);
+	ret = ref_iterator_seek(iter->iter1, seek, flags);
 	if (ret < 0)
 		return ret;
 
@@ -407,13 +408,16 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				    const char *prefix)
+				    const char *seek, unsigned int flags)
 {
 	struct prefix_ref_iterator *iter =
 		(struct prefix_ref_iterator *)ref_iterator;
-	free(iter->prefix);
-	iter->prefix = xstrdup_or_null(prefix);
-	return ref_iterator_seek(iter->iter0, prefix);
+
+	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
+		free(iter->prefix);
+		iter->prefix = xstrdup_or_null(seek);
+	}
+	return ref_iterator_seek(iter->iter0, seek, flags);
 }
 
 static int prefix_ref_iterator_peel(struct ref_iterator *ref_iterator,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 7fd73a0e6d..11a363d246 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1004,19 +1004,23 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int packed_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				    const char *prefix)
+				    const char *seek, unsigned int flags)
 {
 	struct packed_ref_iterator *iter =
 		(struct packed_ref_iterator *)ref_iterator;
 	const char *start;
 
-	if (prefix && *prefix)
-		start = find_reference_location(iter->snapshot, prefix, 0);
+	if (seek && *seek)
+		start = find_reference_location(iter->snapshot, seek, 0);
 	else
 		start = iter->snapshot->start;
 
-	free(iter->prefix);
-	iter->prefix = xstrdup_or_null(prefix);
+	/* Unset any previously set prefix */
+	FREE_AND_NULL(iter->prefix);
+
+	if (flags & REF_ITERATOR_SEEK_SET_PREFIX)
+		iter->prefix = xstrdup_or_null(seek);
+
 	iter->pos = start;
 	iter->eof = iter->snapshot->eof;
 
@@ -1194,7 +1198,8 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	iter->repo = ref_store->repo;
 	iter->flags = flags;
 
-	if (packed_ref_iterator_seek(&iter->base, prefix) < 0) {
+	if (packed_ref_iterator_seek(&iter->base, prefix,
+				     REF_ITERATOR_SEEK_SET_PREFIX) < 0) {
 		ref_iterator_free(&iter->base);
 		return NULL;
 	}
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 8aaffa8c6b..01dfbeb50c 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -434,11 +434,9 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	}
 }
 
-static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				   const char *prefix)
+static int cache_ref_iterator_set_prefix(struct cache_ref_iterator *iter,
+					 const char *prefix)
 {
-	struct cache_ref_iterator *iter =
-		(struct cache_ref_iterator *)ref_iterator;
 	struct cache_ref_iterator_level *level;
 	struct ref_dir *dir;
 
@@ -469,6 +467,82 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 	return 0;
 }
 
+static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *seek, unsigned int flags)
+{
+	struct cache_ref_iterator *iter =
+		(struct cache_ref_iterator *)ref_iterator;
+
+	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
+		return cache_ref_iterator_set_prefix(iter, seek);
+	} else if (seek && *seek) {
+		struct cache_ref_iterator_level *level;
+		const char *slash = seek;
+		struct ref_dir *dir;
+
+		dir = get_ref_dir(iter->cache->root);
+
+		if (iter->prime_dir)
+			prime_ref_dir(dir, seek);
+
+		iter->levels_nr = 1;
+		level = &iter->levels[0];
+		level->index = -1;
+		level->dir = dir;
+
+		/* Unset any previously set prefix */
+		FREE_AND_NULL(iter->prefix);
+
+		/*
+		 * Breakdown the provided seek path and assign the correct
+		 * indexing to each level as needed.
+		 */
+		do {
+			int len, idx;
+			int cmp = 0;
+
+			sort_ref_dir(dir);
+
+			slash = strchr(slash, '/');
+			len = slash ? slash - seek : (int)strlen(seek);
+
+			for (idx = 0; idx < dir->nr; idx++) {
+				cmp = strncmp(seek, dir->entries[idx]->name, len);
+				if (cmp <= 0)
+					break;
+			}
+			/* don't overflow the index */
+			idx = idx >= dir->nr ? dir->nr - 1 : idx;
+
+			if (slash)
+				slash = slash + 1;
+
+			level->index = idx;
+			if (dir->entries[idx]->flag & REF_DIR) {
+				/* push down a level */
+				dir = get_ref_dir(dir->entries[idx]);
+
+				ALLOC_GROW(iter->levels, iter->levels_nr + 1,
+					   iter->levels_alloc);
+				level = &iter->levels[iter->levels_nr++];
+				level->dir = dir;
+				level->index = -1;
+			} else {
+				/* reduce the index so the leaf node is iterated over */
+				if (cmp <= 0 && !slash)
+					level->index = idx - 1;
+				/*
+				 * while the seek path may not be exhausted, our
+				 * match is exhausted at a leaf node.
+				 */
+				break;
+			}
+		} while (slash);
+	}
+
+	return 0;
+}
+
 static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -509,7 +583,8 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 	iter->cache = cache;
 	iter->prime_dir = prime_dir;
 
-	if (cache_ref_iterator_seek(&iter->base, prefix) < 0) {
+	if (cache_ref_iterator_seek(&iter->base, prefix,
+				    REF_ITERATOR_SEEK_SET_PREFIX) < 0) {
 		ref_iterator_free(&iter->base);
 		return NULL;
 	}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 03f5df04d5..6376a3b379 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -353,11 +353,12 @@ void base_ref_iterator_init(struct ref_iterator *iter,
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
 /*
- * Seek the iterator to the first reference matching the given prefix. Should
- * behave the same as if a new iterator was created with the same prefix.
+ * Seek the iterator to the first matching reference. If set_prefix is set,
+ * it would behave the same as if a new iterator was created with the same
+ * prefix.
  */
 typedef int ref_iterator_seek_fn(struct ref_iterator *ref_iterator,
-				 const char *prefix);
+				 const char *seek, unsigned int flags);
 
 /*
  * Peels the current ref, returning 0 for success or -1 for failure.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4c3817f4ec..d627221b65 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -719,15 +719,20 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				      const char *prefix)
+				      const char *seek, unsigned int flags)
 {
 	struct reftable_ref_iterator *iter =
 		(struct reftable_ref_iterator *)ref_iterator;
 
-	free(iter->prefix);
-	iter->prefix = xstrdup_or_null(prefix);
-	iter->prefix_len = prefix ? strlen(prefix) : 0;
-	iter->err = reftable_iterator_seek_ref(&iter->iter, prefix);
+	/* Unset any previously set prefix */
+	FREE_AND_NULL(iter->prefix);
+	iter->prefix_len = 0;
+
+	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
+		iter->prefix = xstrdup_or_null(seek);
+		iter->prefix_len = seek ? strlen(seek) : 0;
+	}
+	iter->err = reftable_iterator_seek_ref(&iter->iter, seek);
 
 	return iter->err;
 }
@@ -839,7 +844,8 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 	if (ret)
 		goto done;
 
-	ret = reftable_ref_iterator_seek(&iter->base, prefix);
+	ret = reftable_ref_iterator_seek(&iter->base, prefix,
+					 REF_ITERATOR_SEEK_SET_PREFIX);
 	if (ret)
 		goto done;
 
@@ -2042,7 +2048,8 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int reftable_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
-					 const char *prefix UNUSED)
+					 const char *seek UNUSED,
+					 unsigned int flags UNUSED)
 {
 	BUG("reftable reflog iterator cannot be seeked");
 	return -1;

-- 
2.49.0

