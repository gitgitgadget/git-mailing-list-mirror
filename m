Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ADF2459D1
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382256; cv=none; b=acy0UTF8EuS4kT4ZctsKIoxLciOWtVhFflEKCHVUWJNfSxNhDQUGx3UAlhT6RZSLO23o0nHs08smEoOcw01CoSdPUt1W5yo8/XUp1zOKp5Rx/u11AwtK9lVAtSyahlxKKgIHKXBbL//vo4FbrLA5mMBaZUBBSVmEj583cLNKAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382256; c=relaxed/simple;
	bh=K1rjlzwFltcWas40pBgOUp2bGh+I2fEtXX2jGRuvDuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLsLCo7rrPWY1Q+gJprc4ElzJnoPF8C+6l6AFVnFrwrXXwiQRcpmLLSAXPb9QM1XJHVQJX3bJxrILEfDN33RyiNyfV53VihTL+67t9ocIQxj8W61Bxdkmwod5dWFUxeJ9Z0wIKP1ijpE3SrYeoaLJjeZZMkCvTE6APquMzF0O5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du7C0b+u; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du7C0b+u"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so1056598566b.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382252; x=1751987052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edASrM9QAj5yDZso4yyaXIAL3bkJb2HdHeOmsvIFcOo=;
        b=du7C0b+ux31gZqiRnou2WyF70/GxGM67HQziLOKWeEZhUO/WnxLF0mHlbY1nED7beb
         fzlP3KROH5urQKyL3BNaCbjiOym05hE+x5j9+AX/HakOBwxIgmnNef/wkfil3zzxw8iz
         6PsLOoLDujomQrkHGOd7KUp/i+f1BqDUomePnrcX7SAl/X9UUDNqcdmTkBMvLbZPtlRs
         fqjMkRfQCLFY+8Y0hG1pbAAf8ORv5lMmRPgtytdrpHepE2DQ7xoESJ8FJfU1Vv3mr5MI
         0HFxbaTY0YACIdtN03i0bVqwrJtN9T3AV0Cun2pvuv0P4axItWpaW4lXvYyxYqVlzGlj
         XIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382252; x=1751987052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edASrM9QAj5yDZso4yyaXIAL3bkJb2HdHeOmsvIFcOo=;
        b=DsjOD3FBJcoATKXYCmTYY5Ldd7fLD1BAnPhe6x3PZ7BcgzWb4LiDNKCtC5tYKXHemz
         VeApwMZzrEUZBw0r1iVzzPCpUbUIbJT9hcGORMLdwfeLWttsnP1JV8TZsWcCYrFpPhaJ
         e1bLjx+MvjI1CbrbqJbTuvEj15prDfUhX/fmXeHbAjcKXyt0xrKZa5S0JA170EQJkV5M
         o49BzIz/6N9fVeI0a0JP95kxhzmL/wvw7G2b2Ijs5qEkfKG85srWWBsDznsRiEoLRZ2D
         1tTSJvmqkMpUogMyVXdyaqe5MvZne6L0uJfptJ18uvZZOASS3+/+FB3yNxIdkTXGSnqY
         wh6g==
X-Gm-Message-State: AOJu0Yz1zdIlKNKXy9MBv0hOY2tmmK75MoMYuQepqbw0UX63xFizkscF
	jVWq7jjNkOOKiAQoquCU5B46STwXaanBG9Q4C+3Un7jIk6gZ9rv6+X4gjSXBUDk/
X-Gm-Gg: ASbGnctcCDXNbjDKK7Wo1v/HklT2Cbbh4hVtrAPuEm/AfQGB5eLp13IDApIA3VHCV3U
	lLuIoTUtsOPFZwDmn28ZRNPiemqPDftLpN4Hd2MHcCb0NToqgwuFJf+8J9Cvk2M0GHkVVKwvUEW
	47tTyhzmbFqInIYc1hd7kaxAvlJwWBKZeRkNoFfVI/oSbO1TpsgDrtnhQhGOeRxTwKmGYD5HAyk
	j/SYQW6glkhASuM1E4dcrFu9+gBDtHTdyFWzXaa59X8ftNJw+P71xqMC+r0PI/aXpyTKY12M9E9
	zZIKc4k5n0642crcTnLBCFfwbABYVNJcrukEwyM4Ij8Rltsgo4o1upyY
X-Google-Smtp-Source: AGHT+IEEIXgCakSylstS0TCRIxfoIamc/jQuHhs464ehefBLRgRUcZTXIBBHVWitScH4PhgJWGuT/A==
X-Received: by 2002:a17:907:7ea3:b0:ae2:dd9f:f75c with SMTP id a640c23a62f3a-ae34fee868dmr1602133166b.25.1751382250325;
        Tue, 01 Jul 2025 08:04:10 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:6747:3d30:531b:25db])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c013c2sm895472266b.102.2025.07.01.08.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:04:09 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 01 Jul 2025 17:03:27 +0200
Subject: [PATCH 1/4] refs: expose `ref_iterator` via 'refs.h'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-306-git-for-each-ref-pagination-v1-1-4f0ae7c0688f@gmail.com>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14223;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=K1rjlzwFltcWas40pBgOUp2bGh+I2fEtXX2jGRuvDuE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhj+OcYjtRDdHSaqCjVR4DsDqhO/4VEeT9hN
 dJUmd2FyBsn5YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoY/jnAAoJED7VnySO
 Rox/z9kL/AjY943OyqQsZQ8w8bALOpvXKYsH3ZNdbluiu+jxdN/7LRG7sTIAQBDJpu/iYnPa9w7
 ojAUVbVhi5KP08bw4no9RDZdSXqgWJnZ+oLCqEdFt2kYISRU+MILj1WIyfoAlK7DzRqZCh1UncL
 DHxXBA6PAHezUJNki4i46HEMFCAKlyAWJqbPOAg+yEu+9IMxlbkCtkeuYnOlg6eKuFpABBNEPul
 uUk66qMXWJjyQmzXVLdkwTdpKoby/dWIuwhCg5QJtzqkvYqkBjZU5iWFTKuh0indn50mIMsj3EN
 n0OLuAw9e2uipvmSv1WfGCiG4laDuVRizc9CsXz8cIsGyt8S4Nu+w9go6KnGKDZzGUcRaaiMsnE
 BYVp2RO+OYHwEeJtkFEuSVUbc4KMUjlHECBDhbHITFDbfoWvAhT/NfKVR4WIWehWxzvV43Cdq3g
 bLdoQlZcaaNhsGooAYTQrTeXeCDAfqhBQdZv6O+EkYbX0nqNE9p0xmpUJ8DuoiNyQsLJ51rPb64
 HU=
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
 refs.h               | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++
 refs/refs-internal.h | 145 +------------------------------------------------
 2 files changed, 150 insertions(+), 143 deletions(-)

diff --git a/refs.h b/refs.h
index 46a6008e07..c05be6d0ac 100644
--- a/refs.h
+++ b/refs.h
@@ -1190,4 +1190,152 @@ int repo_migrate_ref_storage_format(struct repository *repo,
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
+		struct ref_store *refs,
+		const char *prefix, const char **exclude_patterns,
+		int trim, enum do_for_each_ref_flags flags);
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

