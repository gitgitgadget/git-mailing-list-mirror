Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F8139E
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634170; cv=none; b=lPipdbGS/7nyxjLQdtGBWBTuN+pvYg1uHfKH0oDdL2qfjP8TnYPvZqHf5XBRgS1TY6zAs0Eo5vNkMxWNuxL9XlPyjDPoqtAwM5Wf8V/29qy/ZlESyADAQ2+Wmjj3KHN56emX8YBSGpYlZKROayB7GBaz0MxnU8syScpRoGYlmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634170; c=relaxed/simple;
	bh=XU8l02xxNNhgEVZz3rM+FvIaKvR39lV560YINx0RLdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZKiHqZEsAXOAlEAsBzPGS31VCl2szZenLfCgOwG7RnZL0+5D9SBvweN9ZSnnAY7PqW2U8C6leyqp+lv6QwpimPCRTSp7zuwva4LDKVO7vMiJH53Ex6EsRMk6h65+IikiDroUt50c6dlj65vf3V0/qDA/jPz3x1aFu8aFYSq5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8ZIKFo/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8ZIKFo/"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a510432236so651475f8f.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751634166; x=1752238966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utmrJ2jdgbNibv3JKQte8WUhjvFULp0A1QeV3YonqBo=;
        b=Q8ZIKFo/XW8AQmgdK3PZF59q8Yt2FjVlpR8euE5nNnF5pexahni0zgUGwYlf8t5THf
         s2FOPj6cLunh9AMtTwZu4XeYI6xEc7Exkqws5aT46yX9CymouY2k46GHjU9ZUd4cNUBF
         zs44hg3nsXrVifQGwhcjuGSWF7TJimXNbmVdetHzb/SFwTnFnVtV8xEMkqURGCGdeAe8
         QrVW9B8D3zEhOhUdTIu512CltRDLh1tBcRdBjJ+XXbFQ4jfUUnPWvO4Q6Fbi4SD/6uGL
         CSCl9TFMVyaTf7kRPuDW0Kg+XOnD43oCLB9FN8Be4n4u/fQGlAVsttAmPFE5h0+JszP4
         KCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751634166; x=1752238966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utmrJ2jdgbNibv3JKQte8WUhjvFULp0A1QeV3YonqBo=;
        b=IBQ54CzQLH2a21ZHzqChMQq2Lf/gNUhtCJHISfqEHR/8rtHNHdCzN6ARDgxd99pVic
         yHdkAgHh+EGHsbmHCe+Aw2wkATaYyYDh7UF+28SkzVaFjvW0UqbyXVidn7ryPv07u+Uy
         JDB7UB3DXXgA5H1DI6YKcdOM/jL/pjz+JoYMLyoHUg+N9C4CQXBK2FUHVxOqKrFFQBI8
         Dd/uUuzmMd2pyCGq05t05bdbhd+J+2IZ8vbwQUsALgYHQJoVRp/7esNXqpTy+yrTZpMM
         qzTHzZaRocBzgS8O23AjWMpJ97E8GOY+usks4otB91rf9lwT1FS/v/BUQUH8bUYZidOc
         6/Iw==
X-Gm-Message-State: AOJu0YxZoaXMG27jpXcuaLtD9ZfPlCPaInzoOYb1IqjxGWwrPuSazuWj
	uvG166xREWvv7QyaACOujH/qzzpfatUwAKVW5MeuReJpnvZ+hTadzVAqAWyNbSFe
X-Gm-Gg: ASbGncvk2EKUtC+WFd6+JjknZRRkZt8fLKIn3v+wUKQsxcjDwMJq4pDsVW1uHRJd0DE
	5mdR08A83P3abYme7tHmlKia9FgDGkvye9oMAW7ebfkQzkTy+jK9vd8g4pRiSew5HRi6T5hlnvb
	xtj5vog7PEfZNfFJgYWJJI4WiwcMj3sHSLNKMgTaqtIZ9FVdC5cXzSogTj9Ce2+AVHzNGtWAWkN
	kNme78mzlvOIGqu6n0ZPgFUiYFwx/u74qO3C00cTSCagM0v68pf3lGcrkTlbXPdl7+rOeFnWJR6
	8/LT6QMKjG8dkI10R9VFT0GeZddgRafG5a1uqs8=
X-Google-Smtp-Source: AGHT+IGBPK3YYuIJbVVYoZYn/13I3g1jE3iaaWkrPfKhbFUNPYu/XSmhWhhngqYCjG5AF1AVv36bQQ==
X-Received: by 2002:a05:6000:2912:b0:3a5:2e9c:edb with SMTP id ffacd0b85a97d-3b497038f72mr1656125f8f.47.1751634165443;
        Fri, 04 Jul 2025 06:02:45 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba69sm2477687f8f.16.2025.07.04.06.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 06:02:45 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 04 Jul 2025 15:02:29 +0200
Subject: [PATCH v2 1/4] refs: expose `ref_iterator` via 'refs.h'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-306-git-for-each-ref-pagination-v2-1-bcde14acdd81@gmail.com>
References: <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
In-Reply-To: <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14218;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=XU8l02xxNNhgEVZz3rM+FvIaKvR39lV560YINx0RLdQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhn0PKfeD4TdAWjeA2lXnxt12j8Gk3Swrcds
 /VM/d2OduzSQokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoZ9DyAAoJED7VnySO
 Rox/ZCwL/jD8Cu97T7sarLwyVotdSsdUcNKbrkClCG+7FXGNoktMC3lISs9Nl7co5q0o80++hX9
 BsSSGnLpxI0BBGwRxkMbBE+c2Xgy9biL0obsLLqSgDdcq5nL7dwF0dVJpvRsMMD0b5rT8iWX4gb
 uAT4EY1QeE2RZR3yLs+WraziQ5I44fTy/k3/Qpfwe1pjypbyEeFKvgKyl+Sf+m/4wSpnZ8LmnMd
 ZkkDtwIF+lHKrqvGtinuwIks/rQh5Z4sCMl8uIgcRLR/UoG+cF/i8QReskl1YDLdh1k5X9nsEiu
 bhT9uO7AFNrTQCW4ZdWnTdp6maGZCfEGYyGzADW74JOGPSCokkRIOgAy3frQ11nDXgmGlQ6zREy
 3p6uL8TbfhvgY4r6iWHj1enTV8vjelZ/YQdFSi18ZzCB5kdFFv4FsbwmW0bbkJJP7OzdjBdF9AJ
 ExrgLrcVOqVRvjt4NgjtMAEZPYoqiahlJ1FmnautrlP26r+4qWe+xVftILWXyAldjMX5E+FTAF6
 hM=
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

