Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46440278E7C
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382258; cv=none; b=DcfG9JsQ533APYN5EIjl2D9ti8kaK/pTghBcL63W6IIObKs60c3NjAqazL+TE62cdc/ZgDcnyKrrtlHFjFNpsu1440QkZ7gqBGnBmwLGMnsr3Qc8Oo6dxt11q2LP72PgjYg+08onxYSomkR9nU0AqwabqLVmXvtD0VNm5VCR7jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382258; c=relaxed/simple;
	bh=dx+FBa+p5LjQVTQ2BQiVyOk5rEh5Bwvvi/7geIGqtao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nh2JScBOn9+7PiK1oOWROWPN9W3G7B2lqFQK3OJ+DGLSy0OVUHqyu0N1GpSBcEiwnGK3BNAuBv1LSbCWhyqhrtkHLO7v4F/e+dzaILYFgg4b05ZRJqaiOJnm4sW/D+VexD/DujEwONIDr8VotJ5mQUN+YU6WpVHYk+s8TQFiIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8pL5dLB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8pL5dLB"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so9719357a12.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382254; x=1751987054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuGy3vYtFchfs+FIOzFasQZ79INWiWoz3iQd7T0vcRU=;
        b=c8pL5dLBnoKAYyl9qHLKQUJupTl2RWIFMcvOVL1irwOI9GoIvENS6oWnSxhZMXdNLU
         vHnboxo+fBzRWgy3VJ6e6yPERhtKsI2IREhkrUnwexoVPJtm7wZFf21UDYiob86nACG8
         dFlSdIrZn6wghH1u+a9+2bzuAfmAYN9wsT+L3I6DXLZSMR6/DdN5eSQbN6CAeR2l8hRo
         +DjcYcZ5BuxoKdQ41e7ohzrS09xs2rDRvrW34rqTkZLOJgQrTvMpW8l2yxRnm/9RqLYj
         FvBnOPM/dArGeCdYsF8JRo97BSKRot4U+p9ku2JS/ey1l+qWSDejocpDzoUIl7oRndpO
         IKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382254; x=1751987054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuGy3vYtFchfs+FIOzFasQZ79INWiWoz3iQd7T0vcRU=;
        b=BZyL0b7livlasjx8N0XyjWF5BppqfH21vJqxQ4xdjoDMacWQ4ZlB3CkHNqat+OcF8x
         RE4FlOelBdLqV4JS4GfTkZX7+1jTmRHVC8kJT3WlnRBCFMa+Ql7kb/Yp7wtxiDU8pZnx
         vkVS0VaW3NVOqABRVQa3zZOJPrBEX0f+JzfCQeVx/KP5W0SJYhSTBv+co+jg88XRKWI/
         euDN4KbtT5CX3DMggQtRviHszkb2HYJD6gKSUZJHH231gwkPgXlIOXOwFv1m56WZ3QUO
         lNlmi6P+s51T1GB0Sga+i9D2xGCy2wKQYVfU+D8n3oLibsbp8H7iZQ1s/G3PBy1ZbrHj
         MCqQ==
X-Gm-Message-State: AOJu0Yw+KdauBWL6u+yzPYIXze1CrIhinvZHc37bngiOeDSL/hYYyls0
	3el+nwCn9dGuwSdCVJeTifqvJXaroq6XVB3AwpzG4hebsXHYWrOI2mNNA+9QGgIf
X-Gm-Gg: ASbGncsVc6/X5wqOUE5NtvodspowRSrdeEBmMojvkRrWnFClwv5aox7g9QCrQWz7ek7
	cPhHXE7KcDTJB4UdAvCV1xb3hYVYZHIIr3Ae5gz4FXPi7U4wV/YbtbU8NYKO//oqXfwA61xmJee
	pcbhUW+pmSsqHkke31q1StwA0zHBnDGQBBNe6xCGaIuk7ss/ukGyWlwcfcQUYZXHbPlGMP545Zk
	5XTOQPLVH2PIZEbwcxZJulXdNSzTsH17wmGpvkyr4nhKcjtkcZhOrtP42nLKLIVS6cUmPC4mR7k
	vAx4EtDolVQZhADxsMLHZYqhLRlnAf/2yA5Q7DelY8EKTA==
X-Google-Smtp-Source: AGHT+IFSzIMMCZ7jJcz6mhlBSt/NvvH0CxOZJm+doV6eHkcfLuL0Iv4kDFibhLbRfGfFx8ov2WW8wA==
X-Received: by 2002:a17:907:868c:b0:ae3:6cc8:e422 with SMTP id a640c23a62f3a-ae36cc9419dmr1268282366b.47.1751382252102;
        Tue, 01 Jul 2025 08:04:12 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:6747:3d30:531b:25db])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c013c2sm895472266b.102.2025.07.01.08.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:04:11 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 01 Jul 2025 17:03:29 +0200
Subject: [PATCH 3/4] refs: selectively set prefix in the seek functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-306-git-for-each-ref-pagination-v1-3-4f0ae7c0688f@gmail.com>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14960;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=dx+FBa+p5LjQVTQ2BQiVyOk5rEh5Bwvvi/7geIGqtao=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhj+Ohv+RYuB50N1ZYzisio7m+wk550cq8Jl
 GD+D1rWDf6VgokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoY/joAAoJED7VnySO
 Rox/+KYL/j3JndpqZNshm/5ZHoM2NjJeao3SyTI3EdTbd9NK+YuZiENfB1kPQzVlgA3pikz43Sy
 8q5f8CP2ZMKQb2wYC52GFDrqVl1JoM1sFCJDZqyUDKy4D2oVvD8+uA4392bK4gevlNniiv6JmNJ
 21r12BduUUuhdFj+ROzY6d6d2qnHnClhqsGGda0DmpfRx/e9TqFjls4semFPnvFqkBN1RZ6fWRX
 Ufes9bPUFmNd6qP4sBPsKQFHcdL3QOPfEF9qWQqBbxMxx7joaZ1L8gw0eH2zMC+gRPnXv8o36rJ
 1PLF/kyH/m5sWHycU2mhVFE9BkdCNF6rtMDxRh2ZEqwQTiE2Z1ihx8tYo4tmOS9Rx/AJV2aelas
 WGDWO1JijV5E497uDh/nboo3XIDEA8+UwpZx6QgB03YcaRw1UAf9TArnP9PE0wZOzkRV5NJKifj
 rhXO+7wvhNiX+zrKuVu8x6rPOkY4S65x3YQAgeQcF6RRM537e1MIIjwx58PSVtpoHjCY90AOnW7
 IE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The ref iterator exposes a `ref_iterator_seek()` function. The name
suggests that this would seek the iterator to a specific reference in
some ways similar to how `fseek()` works for the filesystem.

However, the function actually sets the prefix for refs iteration. So
further iteration would only yield references which match the particular
prefix. This is a bit confusing.

Let's add a 'set_prefix' field to the function, which when set, will set
the prefix for the iteration in-line with the existing behavior. But
when the 'set_prefix' field is not set, the reference backends will
simply seek to the specified reference without setting prefix. This
allows users to start iteration from a specific reference.

In the packed and reftable backend, since references are available in a
sorted list, the changes are simply setting the prefix if needed. The
changes on the files-backend are a little more involved, since the files
backend uses the 'ref-cache' mechanism. We move out the existing logic
within `cache_ref_iterator_seek()` to `cache_ref_iterator_set_prefix()`
which is called when `set_prefix` is set. We then parse the provided
seek string and set the required levels and their indexes to ensure that
seeking is possible.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  2 +-
 refs.h                  | 19 +++++++-----
 refs/debug.c            |  7 +++--
 refs/files-backend.c    |  7 +++--
 refs/iterator.c         | 24 +++++++++------
 refs/packed-backend.c   | 15 +++++----
 refs/ref-cache.c        | 81 ++++++++++++++++++++++++++++++++++++++++++++++---
 refs/refs-internal.h    |  7 +++--
 refs/reftable-backend.c | 17 ++++++-----
 9 files changed, 134 insertions(+), 45 deletions(-)

diff --git a/refs.c b/refs.c
index dce5c49ca2..a4220d3537 100644
--- a/refs.c
+++ b/refs.c
@@ -2669,7 +2669,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 			if (!iter) {
 				iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
 							       DO_FOR_EACH_INCLUDE_BROKEN);
-			} else if (ref_iterator_seek(iter, dirname.buf) < 0) {
+			} else if (ref_iterator_seek(iter, dirname.buf, 1) < 0) {
 				goto cleanup;
 			}
 
diff --git a/refs.h b/refs.h
index c05be6d0ac..c5e08db0ff 100644
--- a/refs.h
+++ b/refs.h
@@ -1300,20 +1300,25 @@ struct ref_iterator *refs_ref_iterator_begin(
 int ref_iterator_advance(struct ref_iterator *ref_iterator);
 
 /*
- * Seek the iterator to the first reference with the given prefix.
- * The prefix is matched as a literal string, without regard for path
+ * Seek the iterator to the first reference matching the given seek string.
+ * The seek string is matched as a literal string, without regard for path
  * separators. If prefix is NULL or the empty string, seek the iterator to the
  * first reference again.
  *
- * This function is expected to behave as if a new ref iterator with the same
- * prefix had been created, but allows reuse of iterators and thus may allow
- * the backend to optimize. Parameters other than the prefix that have been
- * passed when creating the iterator will remain unchanged.
+ * When set_prefix is true, this function behaves as if a new ref iterator
+ * with the same prefix had been created, setting the prefix for subsequent
+ * iteration. When set_prefix is false, the iterator simply seeks to the
+ * specified reference without changing the existing prefix, allowing
+ * iteration to start from that specific reference.
+ *
+ * This function allows reuse of iterators and thus may allow the backend
+ * to optimize. Parameters other than the prefix that have been passed when
+ * creating the iterator will remain unchanged.
  *
  * Returns 0 on success, a negative error code otherwise.
  */
 int ref_iterator_seek(struct ref_iterator *ref_iterator,
-		      const char *prefix);
+		      const char *seek, int set_prefix);
 
 /*
  * If possible, peel the reference currently being viewed by the
diff --git a/refs/debug.c b/refs/debug.c
index 485e3079d7..7c04bcba10 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -170,12 +170,13 @@ static int debug_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int debug_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				   const char *prefix)
+				   const char *seek, int set_prefix)
 {
 	struct debug_ref_iterator *diter =
 		(struct debug_ref_iterator *)ref_iterator;
-	int res = diter->iter->vtable->seek(diter->iter, prefix);
-	trace_printf_key(&trace_refs, "iterator_seek: %s: %d\n", prefix ? prefix : "", res);
+	int res = diter->iter->vtable->seek(diter->iter, seek, set_prefix);
+	trace_printf_key(&trace_refs, "iterator_seek: %s set_prefix: %d: %d\n",
+			 seek ? seek : "", set_prefix, res);
 	return res;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bf6f89b1d1..827b15981c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -929,11 +929,11 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int files_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				   const char *prefix)
+				   const char *seek, int set_prefix)
 {
 	struct files_ref_iterator *iter =
 		(struct files_ref_iterator *)ref_iterator;
-	return ref_iterator_seek(iter->iter0, prefix);
+	return ref_iterator_seek(iter->iter0, seek, set_prefix);
 }
 
 static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
@@ -2316,7 +2316,8 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int files_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
-				      const char *prefix UNUSED)
+				      const char *seek UNUSED,
+				      int set_prefix UNUSED)
 {
 	BUG("ref_iterator_seek() called for reflog_iterator");
 }
diff --git a/refs/iterator.c b/refs/iterator.c
index 766d96e795..1f99045d40 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -16,9 +16,9 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 int ref_iterator_seek(struct ref_iterator *ref_iterator,
-		      const char *prefix)
+		      const char *seek, int set_prefix)
 {
-	return ref_iterator->vtable->seek(ref_iterator, prefix);
+	return ref_iterator->vtable->seek(ref_iterator, seek, set_prefix);
 }
 
 int ref_iterator_peel(struct ref_iterator *ref_iterator,
@@ -57,7 +57,8 @@ static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator UNUSED)
 }
 
 static int empty_ref_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
-				   const char *prefix UNUSED)
+				   const char *seek UNUSED,
+				   int set_prefix UNUSED)
 {
 	return 0;
 }
@@ -224,7 +225,7 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				   const char *prefix)
+				   const char *seek, int set_prefix)
 {
 	struct merge_ref_iterator *iter =
 		(struct merge_ref_iterator *)ref_iterator;
@@ -234,11 +235,11 @@ static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
 	iter->iter0 = iter->iter0_owned;
 	iter->iter1 = iter->iter1_owned;
 
-	ret = ref_iterator_seek(iter->iter0, prefix);
+	ret = ref_iterator_seek(iter->iter0, seek, set_prefix);
 	if (ret < 0)
 		return ret;
 
-	ret = ref_iterator_seek(iter->iter1, prefix);
+	ret = ref_iterator_seek(iter->iter1, seek, set_prefix);
 	if (ret < 0)
 		return ret;
 
@@ -407,13 +408,16 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				    const char *prefix)
+				    const char *seek, int set_prefix)
 {
 	struct prefix_ref_iterator *iter =
 		(struct prefix_ref_iterator *)ref_iterator;
-	free(iter->prefix);
-	iter->prefix = xstrdup_or_null(prefix);
-	return ref_iterator_seek(iter->iter0, prefix);
+
+	if (set_prefix) {
+		free(iter->prefix);
+		iter->prefix = xstrdup_or_null(seek);
+	}
+	return ref_iterator_seek(iter->iter0, seek, set_prefix);
 }
 
 static int prefix_ref_iterator_peel(struct ref_iterator *ref_iterator,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 7fd73a0e6d..dca886c5cc 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1004,19 +1004,22 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int packed_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				    const char *prefix)
+				    const char *seek, int set_prefix)
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
+	if (set_prefix) {
+		free(iter->prefix);
+		iter->prefix = xstrdup_or_null(seek);
+	}
+
 	iter->pos = start;
 	iter->eof = iter->snapshot->eof;
 
@@ -1194,7 +1197,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	iter->repo = ref_store->repo;
 	iter->flags = flags;
 
-	if (packed_ref_iterator_seek(&iter->base, prefix) < 0) {
+	if (packed_ref_iterator_seek(&iter->base, prefix, 1) < 0) {
 		ref_iterator_free(&iter->base);
 		return NULL;
 	}
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 8aaffa8c6b..656e6cd9ff 100644
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
 
@@ -469,6 +467,79 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 	return 0;
 }
 
+static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *seek, int set_prefix)
+{
+	struct cache_ref_iterator *iter =
+		(struct cache_ref_iterator *)ref_iterator;
+
+	if (set_prefix) {
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
@@ -509,7 +580,7 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 	iter->cache = cache;
 	iter->prime_dir = prime_dir;
 
-	if (cache_ref_iterator_seek(&iter->base, prefix) < 0) {
+	if (cache_ref_iterator_seek(&iter->base, prefix, 1) < 0) {
 		ref_iterator_free(&iter->base);
 		return NULL;
 	}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 03f5df04d5..cee377696c 100644
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
+				 const char *seek, int set_prefix);
 
 /*
  * Peels the current ref, returning 0 for success or -1 for failure.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4c3817f4ec..81fb6a9028 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -719,15 +719,17 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				      const char *prefix)
+				      const char *seek, int set_prefix)
 {
 	struct reftable_ref_iterator *iter =
 		(struct reftable_ref_iterator *)ref_iterator;
 
-	free(iter->prefix);
-	iter->prefix = xstrdup_or_null(prefix);
-	iter->prefix_len = prefix ? strlen(prefix) : 0;
-	iter->err = reftable_iterator_seek_ref(&iter->iter, prefix);
+	if (set_prefix) {
+		free(iter->prefix);
+		iter->prefix = xstrdup_or_null(seek);
+		iter->prefix_len = seek ? strlen(seek) : 0;
+	}
+	iter->err = reftable_iterator_seek_ref(&iter->iter, seek);
 
 	return iter->err;
 }
@@ -839,7 +841,7 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 	if (ret)
 		goto done;
 
-	ret = reftable_ref_iterator_seek(&iter->base, prefix);
+	ret = reftable_ref_iterator_seek(&iter->base, prefix, 1);
 	if (ret)
 		goto done;
 
@@ -2042,7 +2044,8 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int reftable_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
-					 const char *prefix UNUSED)
+					 const char *seek UNUSED,
+					 int set_prefix UNUSED)
 {
 	BUG("reftable reflog iterator cannot be seeked");
 	return -1;

-- 
2.49.0

