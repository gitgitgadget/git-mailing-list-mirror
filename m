Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581B2DEA9C
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982489; cv=none; b=bL3D0WATu61Lrt+QWcwv+jmvKXwTwS9QmUq81M2dPn3oEM5C696X1TS/GBGYZ1Jv8sjCHoevAHx3MREROQ0xOK/+ggCTx4FTEwlOOIzzNtUbsXWo7wVlWxSeNt9aVX7k8xwL7ki4zIefonXWfFFz0suye2bL006rXntJemeHJ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982489; c=relaxed/simple;
	bh=XtCWj61Lm3dZamHHS0CKDBUkFueeFhuoG3oRY6ONGBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLIE0NGMzlUXGero9Xh8moytJa1BmJAc3otJyU3rnZ4qh/M283vF3PSp0ob2PCPmi50zfyIvXt4GkgkiAAH0hsidReMyoVjTNk/j2ypk+gOZvnPUyGYDp+FTrxIcS9YeSuoLknCSPNRoKUU8Qgo3yXFEvrMGp1TbKdrGA4Z3SwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQT9tlL4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQT9tlL4"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ade76b8356cso800886966b.2
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751982485; x=1752587285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waJ75ISkjdtWBJ9508oOu4g7LSij3iFkr5s2Gp5G0TM=;
        b=LQT9tlL4uG/XwVxgSYJFxPP8yU24evQh13GHA5qABeRjlMaJ8f6qfn5WPNXEH4lFwG
         IgCR/oYA6UjcyNdZes5QcZsSE1jHFxQV/eX/n6ZtPqVcmLq6Sx7zH5PJk8WqR9kflyfs
         Wox8TDlcp4/GBH0mPJFvwN9Zxtz42JdKRPhrIJe8fun5aamMiZsOg5C3frJFSEbJjedx
         TA2Ajb41Ozb0mwcBkmH6U2f3lIaKhmSniQ+6NkB0eRfuYu8ngpXU0QAdbgDNaGddD26x
         r3Ktdq0kT49MdSXz0/myW0o8ulk02h1ttOFUMMKGbJHG3lI2Fy8s7SllU50J+yjneKdW
         DQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982485; x=1752587285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waJ75ISkjdtWBJ9508oOu4g7LSij3iFkr5s2Gp5G0TM=;
        b=OA86+DtF311TZQzq8W6cy5Ffk9Ha3AX1DKL5oY8bG13A/RmyKfWFRFaqGCWbfM1fOl
         IxO7uMYrVoKOwBaU74jEvjouHTW0wRb48CxSUr2gsX1yBplu0E6vzgiYGcZ3QXwPstw6
         fb3V11Y0SYAU6Kf2hSO+SISbfn5vtPbqX404X1a6ec2Svw1bSogjJuxIYelEbDYv6SOu
         sST49HM7a/mP3YZjzJxNuA39fV2unEblIxDKwKmbohNDWZa9uLtaVUT53Zsh61pdIV1L
         7rRcisl/646xPDndzxg07acLJNbzufV9AFgi6FT1qY+om1cTpfixZGx0A6SM+3c1xgpJ
         3//w==
X-Gm-Message-State: AOJu0YwXCQBGXQZYbscJBM/KcU2ulcGcVhKtDoQbL2lml6Kc7iIXihqP
	f2EfH0fe2SGAaAZj4AA9NDzmqqcbEsm0RD987xAtQ8eGecoiMPgQpZJK
X-Gm-Gg: ASbGncsC3i/n+0vWfd7ymxbyTusiFfNiI5UkqseaiYQVWSpsm9hYgNksVPZj/D5VXDG
	KjxXNhTDtoAWpg4w26lfpaCXo/IaqK3A/ppNcGLcQSfHKyJbB/BigYaZ0+Bj0CETs2ZNcqZUqwO
	qv7M0PcnznbaofY97TbWjLaTSZR5mqEZCmlhYPK4vpkPxusvB3IOTdTxoojNaBA+GOwC5mKxGLg
	8b7Di2Nn+Aptfd6hNT2MU+gS8uwvr9Y+Va/iKL8l4uV6O6H25RWpstLeb7Xnz/v2ui4c8bebrth
	onPGnKoCsRtlKVfP828zo+pl+zhiiiTkxK7CHSGJ
X-Google-Smtp-Source: AGHT+IGYS6WrE6QduQUQvUsF6uB0tbAYEey+sHPYqSyUoaja/5wM8rzkn/DdC79F1ZvUXdo/S0B4GA==
X-Received: by 2002:a17:907:3f87:b0:ae0:ad8c:a559 with SMTP id a640c23a62f3a-ae3fbc8c443mr1767366966b.4.1751982484750;
        Tue, 08 Jul 2025 06:48:04 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b03032sm886575466b.124.2025.07.08.06.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:48:04 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 08 Jul 2025 15:47:48 +0200
Subject: [PATCH v3 3/4] refs: selectively set prefix in the seek functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-306-git-for-each-ref-pagination-v3-3-8cfba1080be4@gmail.com>
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
In-Reply-To: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=15999;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=XtCWj61Lm3dZamHHS0CKDBUkFueeFhuoG3oRY6ONGBs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhtIY+ZGzyHc6TWy2RtHS5BFG2meY/b/XltO
 88dYpgosoEjookBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJobSGPAAoJED7VnySO
 Rox/U40MAIo0uZy058Kx7k99dvevWpRtlEGwt5xtsEZOAr9vK/zV1O/NUNwwWf5KTcTSHBnG5tY
 87LgmjUAhMGGtf4bTaLpnJsDPjx9IHn7gLs9ANgEOdrs4HI2BLlc6V98+q6PgzFJlx56SasjIsY
 2xEwmnjyRiBtri2h4YDHhTgQHGABcwsUz1hdhCXHo6vqOTTdioINIvk3ycaJivdHIr3a/9xiNNi
 hlnt1OimrzoioaAV2KerfrgusBQlAC/iWthukVZowusyO2IDKIf/N2Mt0A0XXxOwxlc6iH39RUK
 8mMp6U6yqvHaRVrLlo5cnsn6PEXEl1K3iqqMXU8WjZN4N3qoLzIUbxWNbTPx4yftFHgrpTYD/22
 xGr8Dj7B67dRQ2LSBz1gCOvdJiR3Sqh0VNup0Eb7rKigcDV1eQxvTwPjLG0ebMpe8i5zooL1VLL
 rtPUKVpsqd6iAOCXX4pCwERzTZ9O0ntBuASETw2C2guFbpo9jdWML8G+8IkVx+4itMssgu/tos6
 Fs=
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

