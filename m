Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842272EF2BC
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250728; cv=none; b=K31bHUSHWLDj6DQob/plt2tDZjh0vnsvwVWY9DB2l43Qzg/8sxR3CzUr/G4xaQ13C6bBcKdwU5HmjuFl1GwPb9AtMMl3b+9ctU3F0t3rIGLGP+BZSkPX4r9BkOu7NTWgdYN2RzBL++dUN2BaBFQZ9U2N/jNakLwxGaGuVspCJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250728; c=relaxed/simple;
	bh=XU8l02xxNNhgEVZz3rM+FvIaKvR39lV560YINx0RLdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K3GUWUVDbas669cpPXhnYFuMfgCXxj0JcGwzcTN+o+GGVoMj5uOaPwF5hf4hp/lauM8qczR1DZS74salZCTvYHJVXOSnlYyh/v3/8PBaTlb0/C7Jn+eILZBX+W++jFtJEMZ7Gu4OJgmjrhncAf4YAJJHVSXnIYLEEWBZvs18v00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMGXskrK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMGXskrK"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455b002833bso3394025e9.0
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752250725; x=1752855525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utmrJ2jdgbNibv3JKQte8WUhjvFULp0A1QeV3YonqBo=;
        b=YMGXskrK7xmkul4ooiXpx3Jq8B3IYswVzLHOS10D3VcLIwDEtF/F9jjLTuJDS6bx1e
         ldsKj+qX7mujFn/DpS32wLIL0KOVmI0Fbvspbu4eFbpTx+24C4chn1aFzOhmMVb4+Rxo
         GsrQif8TTY/0o1NIv8J3FcPfnta6SZuQic/dSAHIE0tGCEtn63PueYkPowN/KzMONgcW
         tubB0gdHrBjHjbfxOdfZtUF4xiGLk19a0LHELtUyZWEBAT4S9VJ05RRH3l39A5rxR66q
         Zyg841X6/HpjtDGxlenA5Pw65iXLlIjcOFbZPCjMvKyBbbS6Ez2K80c9GfK++P8HLOX4
         ZgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250725; x=1752855525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utmrJ2jdgbNibv3JKQte8WUhjvFULp0A1QeV3YonqBo=;
        b=W60zGurlFF5kpvPXqRVlAdmh0jokXzb7nKknt1aMksFz7LX9AVs9ApeUnAnv2gwGy7
         Ue2vbf67drMqWuPChheY3RwNGJCgNT0pHvgAI6V2I8FGK+UynenioEQv90mKe9Y+p2Yb
         p0bqdibAyCZb+DlTALeTs+l1GgNlP5KlKwgJ+qx5KOSFuYwXj8dj9p/M8MBhBGA/T3pE
         NZoANKja34j9InAZdlcS6cR35rda6JP5mIN00OFbolEphjtubpLZ46yO5MTnJJet8dS6
         16yBT7PsylP2sRGUo5rjSOWEt6mBjStABnP5oDgdiG57Qhp+ARZzvku9gkFBygzApX6J
         xppg==
X-Gm-Message-State: AOJu0YxNerGoL8dlHU033szyhtPpNA+65Wn7ZSllTUM5eIFHaNlsAqgX
	yaUDudaKAu3BNFzuOe4JZcRPTtWyTVST2FgM3xP8isjiem1pxls0lFSz
X-Gm-Gg: ASbGncu3HDgvSua5MjHSnUo6vp/I7umh0hsVTA1wfbErkVk+lL9mcEVrsu1cp33dkPr
	OLcpzRn2FDEW7DDQSLeHY3UMJ68Q5lvkTJ0mJdxKHeCiAPALba/I9u3l5ev/1b6ItbX0PKa/9Le
	Sczmg2FPEWcjVX2MucI+iIIazNFxXv5moV27JT4hNi/7yRT0pRfyBdkN1BRQCb4fljCXMJkG4UG
	ag93MiX24A6DPGIMvPgeueNJrMvJzumE2yBjaAUlTwy47Jw13BpUM0GSMUGHCnVBBjvkSBOggWm
	7gNkeGLzR3+Jw5S2A6/gVADkGrmEMDgZS+HXqJO5HU45PcA72XMk0c1hbKtqOevVvV1dIQ51DfJ
	+rNVOB5fwZ8n0rLaL
X-Google-Smtp-Source: AGHT+IFzC2RppGNe8tNUD/dgCg9nOClcO2m8pD7RaVr1i0RqFMA9et8i9OkOJet8kR2v/9iZ9PwdgA==
X-Received: by 2002:a05:600c:1c21:b0:453:d3d:d9fd with SMTP id 5b1f17b1804b1-454ec13ea92mr41878745e9.12.1752250724259;
        Fri, 11 Jul 2025 09:18:44 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5049:80b7:8726:cf1e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd55b0e4sm51293955e9.39.2025.07.11.09.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:18:43 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 11 Jul 2025 18:18:37 +0200
Subject: [PATCH v4 1/4] refs: expose `ref_iterator` via 'refs.h'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-306-git-for-each-ref-pagination-v4-1-ed3303ad5b89@gmail.com>
References: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
In-Reply-To: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14218;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=XU8l02xxNNhgEVZz3rM+FvIaKvR39lV560YINx0RLdQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhxOWE9OQlj5XiVWg7iNQ6jJWlp2ytDAf8JW
 QLONRQlryskRYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJocTlhAAoJED7VnySO
 Rox/4n0L/1cy/8uqegWKBGf4xqA3diRCSTnvWUiR+6qnq8Bbif9cMFc/Iz90w09jxG+Q44I/xmO
 rUIvmE5OedLAfNnNcEhZl/d5vsehklG1WQaFoKanwCKsDXYjE3+KAo693MvTHz59lThJ5WRgAZ1
 nJVZgmwSBRjbqajnkEwaJQEUDcQ4iEYvMYCGbiVNjorK0GIIb2csEaDvHsmGGsVIJPVt1mo+ZJS
 Hc3NSJr99LRduvNwgXdFkRtd+atKSBPek18fzEha26GGk8YESjmKyGJUZmjKkZPHyf1F0p4TeOM
 p3JkKlsn/pLU3cJQIapqVHWrBYc+utTsBuMI0l4YoFnvoUY9FF8A4/F1UYXUi6EWFGml+LpzOFR
 12LRkrdrngRpQrx0SIUGn792alw1z7gSqTakF9Do4FrAdma6SpbYdJa0F9R5PozPBIw2t/pFGdv
 zhWTYpQWxS6LBeeB1njIDZCqRzjLHINNZ2gbt0bc87kVVHC3H28azoCgFiR2OGdcet5c3VpWwA3
 Jo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `ref_iterator` is an internal structure to the 'refs/'
sub-directory, which allows iteration over refs. All reference iteration
is built on top of these iterators.

External clients of the 'refs' subsystem use the various
'refs_for_each...()' functions to iterate over refs. However since these
are wrapper functions, each combination of functionality requires a new
wrapper function. This is not feasible as the functions pile up with the
increase in requirements. Expose the internal reference iterator, so
advanced users can mix and match options as needed.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.h               | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++
 refs/refs-internal.h | 145 +-------------------------------------------------
 2 files changed, 149 insertions(+), 143 deletions(-)

diff --git a/refs.h b/refs.h
index 46a6008e07..7c21aaef3d 100644
--- a/refs.h
+++ b/refs.h
@@ -1190,4 +1190,151 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 				    unsigned int flags,
 				    struct strbuf *err);
 
+/*
+ * Reference iterators
+ *
+ * A reference iterator encapsulates the state of an in-progress
+ * iteration over references. Create an instance of `struct
+ * ref_iterator` via one of the functions in this module.
+ *
+ * A freshly-created ref_iterator doesn't yet point at a reference. To
+ * advance the iterator, call ref_iterator_advance(). If successful,
+ * this sets the iterator's refname, oid, and flags fields to describe
+ * the next reference and returns ITER_OK. The data pointed at by
+ * refname and oid belong to the iterator; if you want to retain them
+ * after calling ref_iterator_advance() again or calling
+ * ref_iterator_free(), you must make a copy. When the iteration has
+ * been exhausted, ref_iterator_advance() releases any resources
+ * associated with the iteration, frees the ref_iterator object, and
+ * returns ITER_DONE. If you want to abort the iteration early, call
+ * ref_iterator_free(), which also frees the ref_iterator object and
+ * any associated resources. If there was an internal error advancing
+ * to the next entry, ref_iterator_advance() aborts the iteration,
+ * frees the ref_iterator, and returns ITER_ERROR.
+ *
+ * The reference currently being looked at can be peeled by calling
+ * ref_iterator_peel(). This function is often faster than peel_ref(),
+ * so it should be preferred when iterating over references.
+ *
+ * Putting it all together, a typical iteration looks like this:
+ *
+ *     int ok;
+ *     struct ref_iterator *iter = ...;
+ *
+ *     while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
+ *             if (want_to_stop_iteration()) {
+ *                     ok = ITER_DONE;
+ *                     break;
+ *             }
+ *
+ *             // Access information about the current reference:
+ *             if (!(iter->flags & REF_ISSYMREF))
+ *                     printf("%s is %s\n", iter->refname, oid_to_hex(iter->oid));
+ *
+ *             // If you need to peel the reference:
+ *             ref_iterator_peel(iter, &oid);
+ *     }
+ *
+ *     if (ok != ITER_DONE)
+ *             handle_error();
+ *     ref_iterator_free(iter);
+ */
+struct ref_iterator;
+
+/*
+ * These flags are passed to refs_ref_iterator_begin() (and do_for_each_ref(),
+ * which feeds it).
+ */
+enum do_for_each_ref_flags {
+	/*
+	 * Include broken references in a do_for_each_ref*() iteration, which
+	 * would normally be omitted. This includes both refs that point to
+	 * missing objects (a true repository corruption), ones with illegal
+	 * names (which we prefer not to expose to callers), as well as
+	 * dangling symbolic refs (i.e., those that point to a non-existent
+	 * ref; this is not a corruption, but as they have no valid oid, we
+	 * omit them from normal iteration results).
+	 */
+	DO_FOR_EACH_INCLUDE_BROKEN = (1 << 0),
+
+	/*
+	 * Only include per-worktree refs in a do_for_each_ref*() iteration.
+	 * Normally this will be used with a files ref_store, since that's
+	 * where all reference backends will presumably store their
+	 * per-worktree refs.
+	 */
+	DO_FOR_EACH_PER_WORKTREE_ONLY = (1 << 1),
+
+	/*
+	 * Omit dangling symrefs from output; this only has an effect with
+	 * INCLUDE_BROKEN, since they are otherwise not included at all.
+	 */
+	DO_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
+
+	/*
+	 * Include root refs i.e. HEAD and pseudorefs along with the regular
+	 * refs.
+	 */
+	DO_FOR_EACH_INCLUDE_ROOT_REFS = (1 << 3),
+};
+
+/*
+ * Return an iterator that goes over each reference in `refs` for
+ * which the refname begins with prefix. If trim is non-zero, then
+ * trim that many characters off the beginning of each refname.
+ * The output is ordered by refname.
+ */
+struct ref_iterator *refs_ref_iterator_begin(
+	struct ref_store *refs,
+	const char *prefix, const char **exclude_patterns,
+	int trim, enum do_for_each_ref_flags flags);
+
+/*
+ * Advance the iterator to the first or next item and return ITER_OK.
+ * If the iteration is exhausted, free the resources associated with
+ * the ref_iterator and return ITER_DONE. On errors, free the iterator
+ * resources and return ITER_ERROR. It is a bug to use ref_iterator or
+ * call this function again after it has returned ITER_DONE or
+ * ITER_ERROR.
+ */
+int ref_iterator_advance(struct ref_iterator *ref_iterator);
+
+/*
+ * Seek the iterator to the first reference with the given prefix.
+ * The prefix is matched as a literal string, without regard for path
+ * separators. If prefix is NULL or the empty string, seek the iterator to the
+ * first reference again.
+ *
+ * This function is expected to behave as if a new ref iterator with the same
+ * prefix had been created, but allows reuse of iterators and thus may allow
+ * the backend to optimize. Parameters other than the prefix that have been
+ * passed when creating the iterator will remain unchanged.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int ref_iterator_seek(struct ref_iterator *ref_iterator,
+		      const char *prefix);
+
+/*
+ * If possible, peel the reference currently being viewed by the
+ * iterator. Return 0 on success.
+ */
+int ref_iterator_peel(struct ref_iterator *ref_iterator,
+		      struct object_id *peeled);
+
+/* Free the reference iterator and any associated resources. */
+void ref_iterator_free(struct ref_iterator *ref_iterator);
+
+/*
+ * The common backend for the for_each_*ref* functions. Call fn for
+ * each reference in iter. If the iterator itself ever returns
+ * ITER_ERROR, return -1. If fn ever returns a non-zero value, stop
+ * the iteration and return that value. Otherwise, return 0. In any
+ * case, free the iterator when done. This function is basically an
+ * adapter between the callback style of reference iteration and the
+ * iterator style.
+ */
+int do_for_each_ref_iterator(struct ref_iterator *iter,
+			     each_ref_fn fn, void *cb_data);
+
 #endif /* REFS_H */
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f868870851..03f5df04d5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -244,90 +244,8 @@ const char *find_descendant_ref(const char *dirname,
 #define SYMREF_MAXDEPTH 5
 
 /*
- * These flags are passed to refs_ref_iterator_begin() (and do_for_each_ref(),
- * which feeds it).
- */
-enum do_for_each_ref_flags {
-	/*
-	 * Include broken references in a do_for_each_ref*() iteration, which
-	 * would normally be omitted. This includes both refs that point to
-	 * missing objects (a true repository corruption), ones with illegal
-	 * names (which we prefer not to expose to callers), as well as
-	 * dangling symbolic refs (i.e., those that point to a non-existent
-	 * ref; this is not a corruption, but as they have no valid oid, we
-	 * omit them from normal iteration results).
-	 */
-	DO_FOR_EACH_INCLUDE_BROKEN = (1 << 0),
-
-	/*
-	 * Only include per-worktree refs in a do_for_each_ref*() iteration.
-	 * Normally this will be used with a files ref_store, since that's
-	 * where all reference backends will presumably store their
-	 * per-worktree refs.
-	 */
-	DO_FOR_EACH_PER_WORKTREE_ONLY = (1 << 1),
-
-	/*
-	 * Omit dangling symrefs from output; this only has an effect with
-	 * INCLUDE_BROKEN, since they are otherwise not included at all.
-	 */
-	DO_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
-
-	/*
-	 * Include root refs i.e. HEAD and pseudorefs along with the regular
-	 * refs.
-	 */
-	DO_FOR_EACH_INCLUDE_ROOT_REFS = (1 << 3),
-};
-
-/*
- * Reference iterators
- *
- * A reference iterator encapsulates the state of an in-progress
- * iteration over references. Create an instance of `struct
- * ref_iterator` via one of the functions in this module.
- *
- * A freshly-created ref_iterator doesn't yet point at a reference. To
- * advance the iterator, call ref_iterator_advance(). If successful,
- * this sets the iterator's refname, oid, and flags fields to describe
- * the next reference and returns ITER_OK. The data pointed at by
- * refname and oid belong to the iterator; if you want to retain them
- * after calling ref_iterator_advance() again or calling
- * ref_iterator_free(), you must make a copy. When the iteration has
- * been exhausted, ref_iterator_advance() releases any resources
- * associated with the iteration, frees the ref_iterator object, and
- * returns ITER_DONE. If you want to abort the iteration early, call
- * ref_iterator_free(), which also frees the ref_iterator object and
- * any associated resources. If there was an internal error advancing
- * to the next entry, ref_iterator_advance() aborts the iteration,
- * frees the ref_iterator, and returns ITER_ERROR.
- *
- * The reference currently being looked at can be peeled by calling
- * ref_iterator_peel(). This function is often faster than peel_ref(),
- * so it should be preferred when iterating over references.
- *
- * Putting it all together, a typical iteration looks like this:
- *
- *     int ok;
- *     struct ref_iterator *iter = ...;
- *
- *     while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
- *             if (want_to_stop_iteration()) {
- *                     ok = ITER_DONE;
- *                     break;
- *             }
- *
- *             // Access information about the current reference:
- *             if (!(iter->flags & REF_ISSYMREF))
- *                     printf("%s is %s\n", iter->refname, oid_to_hex(iter->oid));
- *
- *             // If you need to peel the reference:
- *             ref_iterator_peel(iter, &oid);
- *     }
- *
- *     if (ok != ITER_DONE)
- *             handle_error();
- *     ref_iterator_free(iter);
+ * Data structure for holding a reference iterator. See refs.h for
+ * more details and usage instructions.
  */
 struct ref_iterator {
 	struct ref_iterator_vtable *vtable;
@@ -337,42 +255,6 @@ struct ref_iterator {
 	unsigned int flags;
 };
 
-/*
- * Advance the iterator to the first or next item and return ITER_OK.
- * If the iteration is exhausted, free the resources associated with
- * the ref_iterator and return ITER_DONE. On errors, free the iterator
- * resources and return ITER_ERROR. It is a bug to use ref_iterator or
- * call this function again after it has returned ITER_DONE or
- * ITER_ERROR.
- */
-int ref_iterator_advance(struct ref_iterator *ref_iterator);
-
-/*
- * Seek the iterator to the first reference with the given prefix.
- * The prefix is matched as a literal string, without regard for path
- * separators. If prefix is NULL or the empty string, seek the iterator to the
- * first reference again.
- *
- * This function is expected to behave as if a new ref iterator with the same
- * prefix had been created, but allows reuse of iterators and thus may allow
- * the backend to optimize. Parameters other than the prefix that have been
- * passed when creating the iterator will remain unchanged.
- *
- * Returns 0 on success, a negative error code otherwise.
- */
-int ref_iterator_seek(struct ref_iterator *ref_iterator,
-		      const char *prefix);
-
-/*
- * If possible, peel the reference currently being viewed by the
- * iterator. Return 0 on success.
- */
-int ref_iterator_peel(struct ref_iterator *ref_iterator,
-		      struct object_id *peeled);
-
-/* Free the reference iterator and any associated resources. */
-void ref_iterator_free(struct ref_iterator *ref_iterator);
-
 /*
  * An iterator over nothing (its first ref_iterator_advance() call
  * returns ITER_DONE).
@@ -384,17 +266,6 @@ struct ref_iterator *empty_ref_iterator_begin(void);
  */
 int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
 
-/*
- * Return an iterator that goes over each reference in `refs` for
- * which the refname begins with prefix. If trim is non-zero, then
- * trim that many characters off the beginning of each refname.
- * The output is ordered by refname.
- */
-struct ref_iterator *refs_ref_iterator_begin(
-		struct ref_store *refs,
-		const char *prefix, const char **exclude_patterns,
-		int trim, enum do_for_each_ref_flags flags);
-
 /*
  * A callback function used to instruct merge_ref_iterator how to
  * interleave the entries from iter0 and iter1. The function should
@@ -520,18 +391,6 @@ struct ref_iterator_vtable {
  */
 extern struct ref_iterator *current_ref_iter;
 
-/*
- * The common backend for the for_each_*ref* functions. Call fn for
- * each reference in iter. If the iterator itself ever returns
- * ITER_ERROR, return -1. If fn ever returns a non-zero value, stop
- * the iteration and return that value. Otherwise, return 0. In any
- * case, free the iterator when done. This function is basically an
- * adapter between the callback style of reference iteration and the
- * iterator style.
- */
-int do_for_each_ref_iterator(struct ref_iterator *iter,
-			     each_ref_fn fn, void *cb_data);
-
 struct ref_store;
 
 /* refs backends */

-- 
2.49.0

