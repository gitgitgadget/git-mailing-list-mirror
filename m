Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B02EF9B2
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250730; cv=none; b=NMCipCv33pSJtu3IPT2XVMSS6vYGO5Bj0xEQBSmDyHzCtY8t75Nxw9JY5SUTqhfa8bwuXtfQnz3Y+MGbmWjG6RLormg/hHYlLGSclzb7BhhCZqqakRZxb/HCLKekdZBVycp6UztuxHvWk953PD2bHF0vDSmJbtFZQ+x2WemArj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250730; c=relaxed/simple;
	bh=JHEPY2I86R1SQHoWAP8b51YlLJRd/1bFVlptoJh2xUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rk6bPjYmzkYvQNJa+/cdT1/0ASZNOmmfRO85nmxZSiT8X5P0HdJMtDIislRaQOKWxd0iIRYwTWT+S0QDNmcj9+ELOy1b7wOg0vpRFYM+wBHXKgvhM2GdyuwOypq5CY5ZM0bcjc2n7bPRqCaxn4TOrAKDq9wKUBy/C6BxBXL7IOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRt8kHgj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRt8kHgj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-454df871875so7132425e9.0
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752250726; x=1752855526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2ZS77XRgUA7p/3S6TNil6+kpOF3plwWACj5jE5PJ44=;
        b=ZRt8kHgjXU7S+lh9JhhxUCUoEZfH0MJoWdHAdkH9c+EMr+LOB6ziyjPAQMQbF5w5G3
         4jlQLP2zKSwGFiVSMWzpeiv6Z86lf9fn+qXw6EK1CvLHF3HMtoSuQTRViuMH1iKXdp4G
         Tn8FjRGiGM1oIPJe/+qLV3ewiJLBrznUtxWtvrh8EQOpvK5mE8YZcSlXbBXoNDzf6pZL
         BMSOJS84gLNBoOa2lfJi+iAGdhnLTdf93mulywzZimvA0LIJ+5C9pq0OBfbaPQDNjyeq
         x3aIKhgdsnfbB06BjjYK/FEADQnuc2lLuaP5pFncpkTLBzyGlzNw/WXSUkxW0TzzYFXt
         qx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250726; x=1752855526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2ZS77XRgUA7p/3S6TNil6+kpOF3plwWACj5jE5PJ44=;
        b=wB/e6pUMu4ckDE6CLsRm4cBg3jGV0V3z7c0iAJSNsv+ZR0Onrl4DmAbvjDDjDax4fw
         9tWBg4sC2bkxNPUA5z9o/DVz6fAbqBjtuUhOliKZ95QFpHLF/MwSATUVA/tWt1XAYWhH
         ktJYQ3BoOzSJOhCLRYqbEInINrUB3ZgqsKM3BIo8kZ3AZMwAdjvP5eMyx1YnY/J4fAIZ
         FsjAqa8Sixhalw7hp1bRbAXVx1wxTS2wEZGFbUgY0zbBhsskrUPP7bser942+HpzX4nG
         wBea+vbKQJtirM0aWbU+prxs2G/KsLdXuOczC2Ti9XdxuUBj2JewlyYlbfBVzxNLqGAN
         t0JA==
X-Gm-Message-State: AOJu0YzHnnV6nymnPzQ4CQ5bNkIKDzCo0CCvX2asgEBzPZDH8zV4l1uN
	cJmTWOoE8kBkg40BJIoh+oAnOicWmocdqMPPTe+/Q9xWDLW2U4aInzdU
X-Gm-Gg: ASbGncvi9XPlVnUiXh7qozlDiVDrPwdQBFdKTBNfbLaeKy8ENbvl2Y9Yp9gfHpwTMDc
	YnUfLLiTM7j5D3jRxfPZ+gsEPIrSbiqOMPIvSygMKaprWKA96S5F6XkLvzb5PFkINplN/kiqI3h
	OWT9OijHURf2ROyDZ9/ygaIIBqvg4zrRWtQuOlDCrmOEhEbJuY0xpKVegkh0trNBptFiBsTxLlW
	3zelunF2QtfWKpEzYycqh4/teSKXm4xdCnTu355Cb8WMbX8IN8XKrj3vyFtImqnh7THOkP8dXig
	Ek047kE4B/vprc9tAWh9eAXXrvzhHZ5U67pw650MQYRWCCBtx/YGisISg9SDq9bloSNuneBjZDr
	GA/zs9g==
X-Google-Smtp-Source: AGHT+IFYkM0pfxMiT6I4FRCTS2m1f1moATbcUIgvNhhMWXa3u7O0kCOzJp3v7gWSz8Gw3KsyugeBNg==
X-Received: by 2002:a05:600c:314c:b0:450:c210:a01b with SMTP id 5b1f17b1804b1-454fe0f93e3mr45317075e9.17.1752250725934;
        Fri, 11 Jul 2025 09:18:45 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5049:80b7:8726:cf1e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd55b0e4sm51293955e9.39.2025.07.11.09.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:18:45 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 11 Jul 2025 18:18:39 +0200
Subject: [PATCH v4 3/4] refs: selectively set prefix in the seek functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-306-git-for-each-ref-pagination-v4-3-ed3303ad5b89@gmail.com>
References: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
In-Reply-To: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=15979;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=JHEPY2I86R1SQHoWAP8b51YlLJRd/1bFVlptoJh2xUs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhxOWIBw4xiSAlANHI8iiwUfaw710D7W0yxz
 mYSI3bXptIhL4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJocTliAAoJED7VnySO
 Rox/5poL/32Ru8omAb4elNGlRgnToOdluq4WgSTZzZ0NtxjSpeRIM9nZq4zGLDl57MbEU/8tImW
 CyFp4C3CqS8mf/xI5i26bNrRjshwpnTCtBZXG97pYn5oB6FI3+1Q3yIyyvrSAHNB6p487B37ZmL
 Ua9zOQAh+Rs57WIwt+uoaMkt6fwPh8F971M0SOzKZThzTkQxCPVklGFjbxE+8OYJaxI+amblnmY
 ufxraK6W1B+JziPPTvSK2Hp30YFJEdU4vBAbKRkx3yESDpYrDHmyAYV3PIJpvJZTMzv5veRYu5g
 PYZqprG0KhMKjO1UemPL+NT7ddeKmNgXcJHK9TzQmkVl31WvSwUXf7UhKa6V8snQArSyZv4TBpr
 fyg6XuI9Z4SuZOkJLsqsW4i4X+uFMyTwh20zJESY1DLiZdfSfxxnFYMvkPYX1nK0fsV4gnorC15
 VvyBik7DmuWYBYfxNjOOVojFvPTDIMwmYzCCheAEDMVt8/t/yNqiitQcHrc9CXijamc+BIQGJ56
 Vc=
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
 refs.h                  | 26 +++++++++------
 refs/debug.c            |  7 ++--
 refs/files-backend.c    |  7 ++--
 refs/iterator.c         | 26 ++++++++-------
 refs/packed-backend.c   | 17 ++++++----
 refs/ref-cache.c        | 85 ++++++++++++++++++++++++++++++++++++++++++++++---
 refs/refs-internal.h    |  7 ++--
 refs/reftable-backend.c | 21 ++++++++----
 9 files changed, 152 insertions(+), 50 deletions(-)

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
index 7c21aaef3d..e6780a8848 100644
--- a/refs.h
+++ b/refs.h
@@ -1299,21 +1299,29 @@ struct ref_iterator *refs_ref_iterator_begin(
  */
 int ref_iterator_advance(struct ref_iterator *ref_iterator);
 
+enum ref_iterator_seek_flag {
+	/*
+	 * When the REF_ITERATOR_SEEK_SET_PREFIX flag is set, the iterator's prefix is
+	 * updated to match the provided string, affecting all subsequent iterations. If
+	 * not, the iterator seeks to the specified reference and clears any previously
+	 * set prefix.
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
  *
  * Returns 0 on success, a negative error code otherwise.
  */
-int ref_iterator_seek(struct ref_iterator *ref_iterator,
-		      const char *prefix);
+int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *refname,
+		      unsigned int flags);
 
 /*
  * If possible, peel the reference currently being viewed by the
diff --git a/refs/debug.c b/refs/debug.c
index 485e3079d7..da300efaf3 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -170,12 +170,13 @@ static int debug_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int debug_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				   const char *prefix)
+				   const char *refname, unsigned int flags)
 {
 	struct debug_ref_iterator *diter =
 		(struct debug_ref_iterator *)ref_iterator;
-	int res = diter->iter->vtable->seek(diter->iter, prefix);
-	trace_printf_key(&trace_refs, "iterator_seek: %s: %d\n", prefix ? prefix : "", res);
+	int res = diter->iter->vtable->seek(diter->iter, refname, flags);
+	trace_printf_key(&trace_refs, "iterator_seek: %s flags: %d: %d\n",
+			 refname ? refname : "", flags, res);
 	return res;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bf6f89b1d1..8b282f2a60 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -929,11 +929,11 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int files_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				   const char *prefix)
+				   const char *refname, unsigned int flags)
 {
 	struct files_ref_iterator *iter =
 		(struct files_ref_iterator *)ref_iterator;
-	return ref_iterator_seek(iter->iter0, prefix);
+	return ref_iterator_seek(iter->iter0, refname, flags);
 }
 
 static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
@@ -2316,7 +2316,8 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int files_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
-				      const char *prefix UNUSED)
+				      const char *refname UNUSED,
+				      unsigned int flags UNUSED)
 {
 	BUG("ref_iterator_seek() called for reflog_iterator");
 }
diff --git a/refs/iterator.c b/refs/iterator.c
index 766d96e795..17ef841d8a 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -15,10 +15,10 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ref_iterator->vtable->advance(ref_iterator);
 }
 
-int ref_iterator_seek(struct ref_iterator *ref_iterator,
-		      const char *prefix)
+int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *refname,
+		      unsigned int flags)
 {
-	return ref_iterator->vtable->seek(ref_iterator, prefix);
+	return ref_iterator->vtable->seek(ref_iterator, refname, flags);
 }
 
 int ref_iterator_peel(struct ref_iterator *ref_iterator,
@@ -57,7 +57,8 @@ static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator UNUSED)
 }
 
 static int empty_ref_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
-				   const char *prefix UNUSED)
+				   const char *refname UNUSED,
+				   unsigned int flags UNUSED)
 {
 	return 0;
 }
@@ -224,7 +225,7 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				   const char *prefix)
+				   const char *refname, unsigned int flags)
 {
 	struct merge_ref_iterator *iter =
 		(struct merge_ref_iterator *)ref_iterator;
@@ -234,11 +235,11 @@ static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
 	iter->iter0 = iter->iter0_owned;
 	iter->iter1 = iter->iter1_owned;
 
-	ret = ref_iterator_seek(iter->iter0, prefix);
+	ret = ref_iterator_seek(iter->iter0, refname, flags);
 	if (ret < 0)
 		return ret;
 
-	ret = ref_iterator_seek(iter->iter1, prefix);
+	ret = ref_iterator_seek(iter->iter1, refname, flags);
 	if (ret < 0)
 		return ret;
 
@@ -407,13 +408,16 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				    const char *prefix)
+				    const char *refname, unsigned int flags)
 {
 	struct prefix_ref_iterator *iter =
 		(struct prefix_ref_iterator *)ref_iterator;
-	free(iter->prefix);
-	iter->prefix = xstrdup_or_null(prefix);
-	return ref_iterator_seek(iter->iter0, prefix);
+
+	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
+		free(iter->prefix);
+		iter->prefix = xstrdup_or_null(refname);
+	}
+	return ref_iterator_seek(iter->iter0, refname, flags);
 }
 
 static int prefix_ref_iterator_peel(struct ref_iterator *ref_iterator,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 7fd73a0e6d..5fa4ae6655 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1004,19 +1004,23 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int packed_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				    const char *prefix)
+				    const char *refname, unsigned int flags)
 {
 	struct packed_ref_iterator *iter =
 		(struct packed_ref_iterator *)ref_iterator;
 	const char *start;
 
-	if (prefix && *prefix)
-		start = find_reference_location(iter->snapshot, prefix, 0);
+	if (refname && *refname)
+		start = find_reference_location(iter->snapshot, refname, 0);
 	else
 		start = iter->snapshot->start;
 
-	free(iter->prefix);
-	iter->prefix = xstrdup_or_null(prefix);
+	/* Unset any previously set prefix */
+	FREE_AND_NULL(iter->prefix);
+
+	if (flags & REF_ITERATOR_SEEK_SET_PREFIX)
+		iter->prefix = xstrdup_or_null(refname);
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
index 8aaffa8c6b..1d95b56d40 100644
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
+				   const char *refname, unsigned int flags)
+{
+	struct cache_ref_iterator *iter =
+		(struct cache_ref_iterator *)ref_iterator;
+
+	if (flags & REF_ITERATOR_SEEK_SET_PREFIX) {
+		return cache_ref_iterator_set_prefix(iter, refname);
+	} else if (refname && *refname) {
+		struct cache_ref_iterator_level *level;
+		const char *slash = refname;
+		struct ref_dir *dir;
+
+		dir = get_ref_dir(iter->cache->root);
+
+		if (iter->prime_dir)
+			prime_ref_dir(dir, refname);
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
+			len = slash ? slash - refname : (int)strlen(refname);
+
+			for (idx = 0; idx < dir->nr; idx++) {
+				cmp = strncmp(refname, dir->entries[idx]->name, len);
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
index 03f5df04d5..90de7837f8 100644
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
+				 const char *refname, unsigned int flags);
 
 /*
  * Peels the current ref, returning 0 for success or -1 for failure.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4c3817f4ec..c3d48cc412 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -719,15 +719,20 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
-				      const char *prefix)
+				      const char *refname, unsigned int flags)
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
+		iter->prefix = xstrdup_or_null(refname);
+		iter->prefix_len = refname ? strlen(refname) : 0;
+	}
+	iter->err = reftable_iterator_seek_ref(&iter->iter, refname);
 
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
+					 const char *refname UNUSED,
+					 unsigned int flags UNUSED)
 {
 	BUG("reftable reflog iterator cannot be seeked");
 	return -1;

-- 
2.49.0

