Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BEB2DD5F3
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982486; cv=none; b=S36xMwNBiwrk/RO+i/a0p7y33TULwp84juPITnmXm9upRKLDyu0Kn/Xmki0Yh2/ZGn957fYuJuGps9wgFPpiU43inYCw7Lovccx5zBA8/hz6rbQmEQqvsL1oslncUAoTstxAlaa6FGpjei58MqTM16FIPYKq15CcjI3NTgf1gww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982486; c=relaxed/simple;
	bh=XU8l02xxNNhgEVZz3rM+FvIaKvR39lV560YINx0RLdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nrt09YvsEKud7b8tiB5M3Giohdqbwbb1rM4LXouYXUWG7Ln9PPd8SfjCaVbh/ZejRiHccvAJenx8UEtda0Vpr/GJWYq8fQEVpzk2OgD3gvUe1aL7VASyCxzrhROG/jW+1lVp462OxPmWyDFZzmLLq4jIA8Cko1hnVw/5RPzluPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9D6wMUI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9D6wMUI"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so6066866a12.2
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 06:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751982483; x=1752587283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utmrJ2jdgbNibv3JKQte8WUhjvFULp0A1QeV3YonqBo=;
        b=X9D6wMUIFEuqwn7w55tMQ3OOad8w4WXpDr7lmIjyL2hmQA0xbF/MNFZElN3gOOgLaT
         3uM/qPzVBEiy3xx6Ou3ShDq1NGe+OABP+XuZkxYDjyJEcCsbhKZDKKjzkr9oMKFA/Hbo
         BzMODmZZwvuhpKNINJ5m/bjCcHn7/uc8kle8e0zacNtK8adKIvsQy2BaNNgemD2IDRHS
         mDXRA+GPlaE4bNLSpa3VnJIIjnzjNaiJPiosGHeM5vyBxz5x6pP4kMsYvEE6S62vp+DD
         pr/L+MbQS/iu+1GoCKUu9tpqm09J0iVrxnT0nl3dUELpONFE0HwfFMD3Y4LPz9gzw4MX
         TQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982483; x=1752587283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utmrJ2jdgbNibv3JKQte8WUhjvFULp0A1QeV3YonqBo=;
        b=T/47PttydvMTG6uTS/mHiCD663IDWaXxVAlPZs6rst11EdnqAyYtApYSP2n4ogFehB
         MQLdytUmCSId5ZPO86rXIb8MSz06pvq8K3/q4xUS+1Z71L5YunNXKhoJKDV8cCMrAPMR
         3riGTJnkKxU9/ow0ITfzpFqg9TvjWeo5sGvnoJI8tLVaE+ht3uuTpwG3pUZ46Kf9l9rt
         /QikGJ7NDli1Fwc8W+2E3bxisdclglG9eo1CnC8pLe8gW3WYWoCSpgK3J73MQ7sxxjEz
         Yf/jqw5rtJueD/STiOsE2YPBc8G2IBTP3GljZ2BfTrtWkNaMGOSzuLik5H4+Nnl06vWO
         F3fQ==
X-Gm-Message-State: AOJu0YzaGcN8/cH6xVcvAE7IVYUOCJDyn3wHDoZwm/3f15Vmuvg5Tf0s
	lqqaxTTgetIYQkeFfczJPElK3FhoDIuIZQNM0eeRZ4KeulnfZt6rCbP8
X-Gm-Gg: ASbGncv5vpGT7VfMamU5Kw8Iej+IQXSaWNqHDia0XCS6xyL9VWls6L6jerjt7yLKiHg
	KIBXY2eyAPN9gibc5pbYkFWIwkclHVsbV/dDCo/TRwXYVYJqtyjHCIL93aFLk6AagwdVnf5n4Xc
	3pc4R473FXEptk26avWnIObpRnSM353RQ3hfTnYR3nyvXz1DfwtXtwKIC7O66LFTee2ESZZfVmc
	q2RAR9IoIxEEk0Tuht2+6T7iSL3XB7e+A7tNaI7eeTMxEhEhbBdDZUVxKrwh04eVAuxUiruz6Nd
	m5JWsTFsy2rAwKopmDF4ACkPjbk6/lQTUHidS9gN
X-Google-Smtp-Source: AGHT+IHu9Ar61neLzOOyu6yFVGe29eB+Dtd+/IH5vgXIAQFN4Yqx39EKRT+/QpBXGyDKC3nL6T5qhw==
X-Received: by 2002:a17:907:7f22:b0:ad8:9c97:c2e5 with SMTP id a640c23a62f3a-ae6b02600f2mr279938866b.0.1751982482505;
        Tue, 08 Jul 2025 06:48:02 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b03032sm886575466b.124.2025.07.08.06.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:48:01 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 08 Jul 2025 15:47:46 +0200
Subject: [PATCH v3 1/4] refs: expose `ref_iterator` via 'refs.h'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-306-git-for-each-ref-pagination-v3-1-8cfba1080be4@gmail.com>
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
In-Reply-To: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14218;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=XU8l02xxNNhgEVZz3rM+FvIaKvR39lV560YINx0RLdQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhtIY/8EySLS7RDy9xTr4iRxT0ePYtCRyLr7
 vo+1ry5NXpNH4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJobSGPAAoJED7VnySO
 Rox/n90L/j/27P2AszOR4JfBofWFZEyK6pV0eKjtczdPFGeo6cB0bn+rAKWy3IDv4sg80ZXqwfQ
 bBXl/wGE+1uYEoDAAqeLxatMrtYcnW1YK2WmCIE4hYTLRt9+/jDAjwqS714R8+5aPSVpfFaOLvx
 dRHxsL0M+CUNdzaS5jrFZm5HLMd2ARD4UkjKW7C11kxyishR+Za4tFJvDz7vg30EAn/kwUF4tfp
 81QXrJMgAwC+HIVVlIzIusnxPl3uFpvTvLSGuJhqBdyX0Ntp2oL23z3R1yqSWdwvjhJy3JnocVN
 N9+olhWGwzY/qL/tOtsdn3E3KhQTn+kdSPYVAg38lAPA1rUaL/SVtaogEHzl4eUTM+2ucAYY4FG
 TKAlxLJqFC/eEL/jgCgRazS+YnVLOQDMEt6F4/8aMsohA6l+tv08u+omOc86sMGEU4RvdVosZn6
 iEv63mNHUZw25Zj3JmKjRCP2vKomRD1dQgekeCzPaUunPOA37LOw2X6baRriMzR3v7OGyUPoBT5
 qo=
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

