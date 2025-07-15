Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA9272E43
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578915; cv=none; b=LnFFrPPUHKL36zBu31fYfAlsjaN3LwEUFI/UbMlnveYjXvNBm7zaanwoToYKoZlM+XSAvLJjw4t5Bo+ky5JVppkkPDt6YOxv0nzGRYHQvyW7/3gxqTSyp8lRlONk4nHZqe0EzM3yuC36MtAJYsHoV/U/D3Q5RvFKoEVpXfPXDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578915; c=relaxed/simple;
	bh=XU8l02xxNNhgEVZz3rM+FvIaKvR39lV560YINx0RLdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGw8qZVSPUGz99WRa0f63YPOjBCGoDhs6JV8OprBwhPIa5LEUhix6RqVm8BKO1LZBmyABR5C79led5yV+SzrMG5k7Q1D31AlLpVi70iU4f8c2umLPfpvItG9KoSI2tUutDFypfAJ0VMXoNHMoJB0NQGogZrUty+P+Irj7SaVh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoqB/5WG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoqB/5WG"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so10083034a12.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 04:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752578912; x=1753183712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utmrJ2jdgbNibv3JKQte8WUhjvFULp0A1QeV3YonqBo=;
        b=GoqB/5WGonc4zkSzPvAcChw+XxyGs3IUCQNLsvX6ZW9TVWpIcZnijfR4K9T/P3o8FP
         U441fHMZ/lbCW5sVAb002Aykr+JX1x/36RZFCsmpo4lsxYTaIM33DDKu3es+m1IEVItq
         s1fROkfmMUJrpUO3CMW/5wPiHWQZ+X+RP2RWndDPOoBBc9g8IUt7srzogpFEk7mgloBZ
         ljpnhA1eFqaoCZamFoqIH4xlFl6ZOS8HdUajNZkf1xetzM9uuza30wlrQU35MLsDaIK3
         mdBSEF6nRTMjW+NvJt60DNv3W7dgrNLkv9FILoQBp6xT5+9zbvRH28yOIMDyTGCb/EuR
         jx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578912; x=1753183712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utmrJ2jdgbNibv3JKQte8WUhjvFULp0A1QeV3YonqBo=;
        b=lrhuKSWM83a4w6NzCbGBjtJot8NIuCOUjiDBkpCZ34+F4vt5F7ieqsPTbv4tnYP6Qe
         7f2u+jm5sJ6d/rxKG+yjfQ6DxZK9RqfI3lC3bEcLAcBvaYWodrbD5B7pNNcFbwc42YaM
         lrqS78JshAZFsuDJ/4lQFweUcW6Noztan+1ygwycfpmxi8QVLd3RZ2n4ptyFh7Tkz+H6
         1NcBLI4GPaRkXx2XYQBhahLPQ19v6dGIOgkUA+jtEjo/mpEiO52A9chyIJrxNGG7ZMa/
         thQSo/7pPlP10aZnrEy3QBBpwcG1kDoyN8W0mFstoX1vnxcQo3vmIW9AMThqZNmagu40
         sltQ==
X-Gm-Message-State: AOJu0YwLeOhxv58GvU+U29YZ7sBqJfPp+vd3Z1iu+f7MUHI8RZ+qAUTD
	OFvldSpRUd9Fd8pvJeUxXueOwMcnkoknVgGS7wRRI2nJMb6WEb6+Wf9i
X-Gm-Gg: ASbGncvnD/kX0tQzGu8XdfvYVmQX5bbig1c1hP9C4foqCfDztAAYaqFTvlWWgDJgCqg
	bZIHbPTAfCU1C5Fogf2mAzH6w7MVbBYq7JYicytdp9e96m8IWVWhTa9EMxPJ+jYG42MD78uK2F3
	F9EglkWLCLHd0bC9s4nO1X9rHtJczt2Lb0stsy5If+Oll6tuIKPaQWILYcfEHcweWPVK0iiPc4M
	PLuYbCFkI7FOG4oliBVXNPWIcOo6xGQBqRUTKovU3CA3BdweIaMyBiCg1wJqy1LgCG/KBhkBv80
	jQeMM3p0Ka12zXqoXL01WjfVgbbuveMrBAdgT4KvQ1cYSBWG9D7ckYULTFa+O4hubtVdBLSB4bz
	kkEbj41WgeGbQgPw=
X-Google-Smtp-Source: AGHT+IE0ncxUxXtutr0m8Qf7UP2V0IJW7JH8rqrLwQfz7aOn5Qx83O/Du25iEHx/Rkm1/hWw/OnVKg==
X-Received: by 2002:a05:6402:2341:b0:612:77ae:f5e6 with SMTP id 4fb4d7f45d1cf-61277af07eamr643451a12.24.1752578911426;
        Tue, 15 Jul 2025 04:28:31 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:624:7896:99ce:d9ca])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976dc62sm7206596a12.59.2025.07.15.04.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:28:31 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 15 Jul 2025 13:28:26 +0200
Subject: [PATCH v5 1/5] refs: expose `ref_iterator` via 'refs.h'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-306-git-for-each-ref-pagination-v5-1-852d5a2f56e1@gmail.com>
References: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
In-Reply-To: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14218;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=XU8l02xxNNhgEVZz3rM+FvIaKvR39lV560YINx0RLdQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGh2O1xILBo1G4UzBIuUL1Zmr2a6Ym7yQFoO7
 5pVH1yfYvBOb4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJodjtcAAoJED7VnySO
 Rox/rbcL/048QtlEMS9bD7UlY59ko7WUcIqNBLJ0iLge62bRWeCqlo3OUm2YqHzlCvW5Seg8sIL
 x1XwniKkacGXwaD3WebmJslYS+hAu5hEwo/bb4vEEEro6J61zCs0L8agyXZGA3/AuWcWCcstZHv
 kcnuSsIXqyCU0tRKApsyV88md1oKO+uxDGPc2kxXmQo8eYM0JDNnsdvNPLEcSN1gozuAbL0AZgA
 sYnTZSmFIz9a1Ejg9pHMMkkvgZm2lwMI583VAESOmH2IZUMUsowCDkycAInbd34GNyT4wBbAiFa
 nUjYktCNNa/5u7BNB1gZTPaXmNvmrwmzYT6IhC8edbML1H+PWAh22sWdP7fw5YY4ctlZrv7IvSK
 Zj/syOq8oE0s11jLC2Yo2+F1hzJHjER1raIiy8Zb88FdTjKC/dpB7g+GFV4fedUVz11znUZvX/L
 rYrnPm/kLZqlt1LFhiQQrLnFP5c9qdIT2JA0iO9gQgDZnIabwe6RXvvEJYncwvjPdR6tQGg0hp5
 Hk=
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

