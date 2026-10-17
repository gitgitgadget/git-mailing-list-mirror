Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB64CF49B
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792267577; cv=none; b=QheGWQDbc6bej+LGfNmcf/OFgBNGcMiDDbTvvB4eGEX9UJ4lWShvzSBQcI66TEplvNoxojrse+D0Ksetut5zFfw+MiEkSsstMwAosFOXa/oII1b5/WO32J3vM590UhltrYGVcoPb6SvO8X4AZkXuAO6JNz/HhizkpM61SdXLiRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792267577; c=relaxed/simple;
	bh=4vrAOrYwrl3Y8D4Drhbk0YgcNWGM96RotYqQUeVLhpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rW5vHhcGPC+HKuxCogs5H4OB9QeTsyzLJmodXEXHAqZN99fjy1iQj8Pq+nUoYL0S7C3wgEPfYHcHDYNQb7Sdt1nVcuQYNjyxLwHmPJGzMtRs7c8EzbuUXHH0YZyOtxuJdg931+//rX9nN06LHZaDqhQ92gkS9SlmCKmeao7mMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeOo+0aE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeOo+0aE"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so6664985e9.3
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 13:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792267574; x=1792872374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKkzLNXfT5/ce2LTLHmVz5PYmpIrSyRjE8S5+1zbgLM=;
        b=KeOo+0aEBkZHve9bOPB5CwKd+rXB/XowDTPQg/KE8znDd1x6M3pFel9Wtd29mih+oj
         +TPZGDP3PIjKqXvGj6d9flEET2oeRfkDDnbVWnpyAQy64naT2JGL1QoTJlZCNEtqZAdi
         xSzeqbTzHgMJ+B4rKu29Tx5DNhOoZlz+uEAATLJm3/VUIQKqlKZa1UA9QYgczUhHUR/O
         QWPqQoKR2vy/l+h6Nr5wSg6uyXfXSyt2LbSwZ8M87ZHtylvVA83c7K2kPeS4oBL8pX4o
         8qu3SfawhPhv34E2owNFDtHASxF7XRLV56PjmpcP6WAee/tNoI97G8umPcQM9+O933pZ
         VbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792267574; x=1792872374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xKkzLNXfT5/ce2LTLHmVz5PYmpIrSyRjE8S5+1zbgLM=;
        b=I9pIEA1Vhm/esCzJg0VH/VGCqSuHssCKN/Ysw7mt/2719so5Xel22mSEcAb4fEeOHq
         M7mob4rHz0Nd8WzxAPPsDME+cwecDvBZ9eEirt8pBnBF8fRb0B6Sasei5t38F1d73XZK
         LdlQ0x6Fw5Cr+2itS/L1Tc4YoaXJUZi0zXcQ56SHB8tHo0PpYWbjixYD9eb8uSQQC/iJ
         jWR+rVyb6CZjfJ0kdd4bROfRDqQa+S4CFgoem4JNDDCotSdVAOrJmfhjp4iC3s0/g5G2
         IWYueUharPkDCclEEN5VSWDs3fZKWB4uNbcHjeKnS0MXdywOyGolWyO4w6l8AU3RUlTM
         RJ3A==
X-Gm-Message-State: AFq9FYK64EkbrJJvSe3PJ2yKzNciR+4SJ0fNCfYX7ZgRgNqxvEPbuMN8
	V9s3MFcaVNUhzu4apUwWIlRqsOfdzbVDkUdYmTKmu9weTIFl44tapLu5uCLSpV4t
X-Gm-Gg: AYBFou2aNhWNOhA5Qa1dkKgzLl31023sPI9b+U0MDDUHBkYmzCP4uI5TD3p+YjA97Ze
	e4Eb/sPG2z5/rgTrQeJBditmoEOQl5Rsptu1aTh9ymVsaEeZbg3PpJORrvUydvQ3yqXtnwe0l+y
	7t7yrDa7DkMoPj1T6znFBgU8rFy+y39vEi+IyqG9xHsNlnSK797y307GFh0jXSbjMyutMeKtSSQ
	CFxHS5jR70k3zx9t//bMzxAoV+hHNtdveKRPKbOdMHJtZZyBj+iame3ap9lp3xFRKFh0ppSkEaQ
	bqx6aU9g5R6CYBdCcabnmVZnNTuhaCiXdxXMguhFIj0JnGCJxa1coPYyLAN2TVziy2D5kpu5M/z
	dEmZ0uColuz79iNp7wCWrEI54Pw/7zVYKoogGTbA9zRtWuTHieeN3MToQikze151/4O4b/6IGQM
	w2XTMwZb/ukFEH43B5iTyupCYDxWoUup17HR/cw7vE+dsuxUFSv/dlf8pCufyxUYSLXQdWg0BfQ
	YHIK7fGupJSX1PbQkKyjhCWcD7s+OpD4jhRsvJVSILCKDFgdpeuiQ7lhmsrIIy2pKA=
X-Received: by 2002:a05:600c:a4e:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-4a1d760005bmr64022605e9.20.1792267573499;
        Sat, 17 Oct 2026 13:06:13 -0700 (PDT)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd409989sm13635644f8f.0.2026.10.17.13.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 13:06:12 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2] refs/files: keep root refs out of loose ref cache
Date: Sat, 17 Oct 2026 21:04:00 +0100
Message-ID: <20261017200405.2332914-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014153208.2194727-1-andy.koppe@gmail.com>
References: <20261014153208.2194727-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the files backend, root refs such as HEAD or ORIG_HEAD are only
added to the loose ref cache if REFS_FOR_EACH_INCLUDE_ROOT_REFS is
passed when the cache is created. If the cache has already been created
for an earlier ref iterator, root refs are silently omitted. Conversely,
once they have been added, any later iterator also yields them, whether
or not they were requested. This has been the case since d0f00c1ac1
(refs: introduce `refs_for_each_include_root_refs()`, 2024-02-23).

For example, `git for-each-ref --include-root-refs --merged=main` omits
root refs that are merged into main, because looking up the given commit
loads the replace refs, which populates the loose ref cache first. The
reftable backend is not affected, as it filters root refs for each
iterator rather than caching them.

Fix this by keeping the root refs out of the loose ref cache. Instead,
read them into a separate, temporary ref cache whenever an iterator is
requested with REFS_FOR_EACH_INCLUDE_ROOT_REFS, and overlay an iterator
over that cache on the loose ref iterator. The cache is freed along with
the iterator.

Alternatively, the root refs could always be added to the loose ref
cache and skipped during iteration unless requested. But that would mean
reading them in every command that uses the loose ref cache, even though
only two call sites actually request them. Also, keeping the root ref
cache for reuse by later iterators is not worthwhile, because those two
call sites only request the root refs once per command.

Correct the documentation, help text and flag comment for
`--include-root-refs`, which wrongly claim that it lists pseudorefs.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
Changes since v1:
- Move create_root_ref_cache() below get_loose_ref_cache() for a smaller
  diff, and tweak its comment.
- Correct the documentation, help text and refs.h comment for
  `--include-root-refs`, which claimed that it lists pseudorefs.
- Consider alternative approaches in the log message.

 Documentation/for-each-ref-options.adoc |  3 +-
 builtin/for-each-ref.c                  |  2 +-
 refs.h                                  |  4 +--
 refs/files-backend.c                    | 37 +++++++++++++++++++------
 t/t6302-for-each-ref-filter.sh          | 12 ++++++++
 5 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/Documentation/for-each-ref-options.adoc b/Documentation/for-each-ref-options.adoc
index 54e2fa95c2..b93ffbd74d 100644
--- a/Documentation/for-each-ref-options.adoc
+++ b/Documentation/for-each-ref-options.adoc
@@ -73,7 +73,8 @@ TAB %(refname)`.
 	using the same rules as _<pattern>_ above.
 
 `--include-root-refs`::
-	List root refs (`HEAD` and pseudorefs) apart from regular refs.
+	List root refs such as `HEAD` and `ORIG_HEAD` in addition to regular
+	refs. (The pseudorefs `FETCH_HEAD` and `MERGE_HEAD` are not included.)
 
 `--start-after=<marker>`::
     Allows paginating the output by skipping references up to and including the
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 4a2fc421db..a12e46cdbe 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -48,7 +48,7 @@ int for_each_ref_core(int argc, const char **argv, const char *prefix, struct re
 		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
 		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_BOOL(0, "stdin", &from_stdin, N_("read reference patterns from stdin")),
-		OPT_BOOL(0, "include-root-refs", &include_root_refs, N_("also include HEAD ref and pseudorefs")),
+		OPT_BOOL(0, "include-root-refs", &include_root_refs, N_("also include root refs like HEAD")),
 		OPT_END(),
 	};
 
diff --git a/refs.h b/refs.h
index 9979446d15..5319e0b570 100644
--- a/refs.h
+++ b/refs.h
@@ -444,8 +444,8 @@ enum refs_for_each_flag {
 	REFS_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
 
 	/*
-	 * Include root refs i.e. HEAD and pseudorefs along with the regular
-	 * refs.
+	 * Include root refs such as HEAD and ORIG_HEAD in addition to the
+	 * regular refs. Pseudorefs are not root refs and thus not included.
 	 */
 	REFS_FOR_EACH_INCLUDE_ROOT_REFS = (1 << 3),
 };
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 71628550f2..9d1e527114 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -481,8 +481,7 @@ static void add_root_refs(struct files_ref_store *refs,
 	for_each_root_ref(refs, fill_root_ref, &data);
 }
 
-static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
-					     unsigned int flags)
+static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 {
 	if (!refs->loose) {
 		struct ref_dir *dir;
@@ -499,9 +498,6 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
 
 		dir = get_ref_dir(refs->loose->root);
 
-		if (flags & REFS_FOR_EACH_INCLUDE_ROOT_REFS)
-			add_root_refs(refs, dir);
-
 		/*
 		 * Add an incomplete entry for "refs/" (to be filled
 		 * lazily):
@@ -511,6 +507,19 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
 	return refs->loose;
 }
 
+/*
+ * Root refs are kept out of the loose ref cache because ref iterators must
+ * only include them when requested with REFS_FOR_EACH_INCLUDE_ROOT_REFS.
+ */
+static struct ref_cache *create_root_ref_cache(struct files_ref_store *refs)
+{
+	struct ref_cache *cache = create_ref_cache(&refs->base, NULL);
+
+	cache->root->flag &= ~REF_INCOMPLETE;
+	add_root_refs(refs, get_ref_dir(cache->root));
+	return cache;
+}
+
 static int read_ref_internal(struct ref_store *ref_store, const char *refname,
 			     struct object_id *oid, struct strbuf *referent,
 			     unsigned int *type, int *failure_errno, int skip_packed_refs)
@@ -1004,6 +1013,7 @@ struct files_ref_iterator {
 	struct ref_iterator base;
 
 	struct ref_iterator *iter0;
+	struct ref_cache *root_refs;
 	struct repository *repo;
 	unsigned int flags;
 };
@@ -1053,6 +1063,7 @@ static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
 	struct files_ref_iterator *iter =
 		(struct files_ref_iterator *)ref_iterator;
 	ref_iterator_free(iter->iter0);
+	free_ref_cache(iter->root_refs);
 }
 
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
@@ -1068,6 +1079,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 {
 	struct files_ref_store *refs;
 	struct ref_iterator *loose_iter, *packed_iter, *overlay_iter;
+	struct ref_cache *root_refs = NULL;
 	struct files_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
@@ -1094,9 +1106,17 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * disk, and re-reads it if not.
 	 */
 
-	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, flags),
+	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
 					      prefix, ref_store->repo, 1);
 
+	if (flags & REFS_FOR_EACH_INCLUDE_ROOT_REFS) {
+		root_refs = create_root_ref_cache(refs);
+		loose_iter = overlay_ref_iterator_begin(
+				cache_ref_iterator_begin(root_refs, prefix,
+							 ref_store->repo, 0),
+				loose_iter);
+	}
+
 	/*
 	 * The packed-refs file might contain broken references, for
 	 * example an old version of a reference that points at an
@@ -1118,6 +1138,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	ref_iterator = &iter->base;
 	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable);
 	iter->iter0 = overlay_iter;
+	iter->root_refs = root_refs;
 	iter->repo = ref_store->repo;
 	iter->flags = flags;
 
@@ -1490,7 +1511,7 @@ static int should_pack_refs(struct files_ref_store *refs,
 	if (limit < 16)
 		limit = 16;
 
-	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, 0), NULL,
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL,
 					refs->base.repo, 0);
 	while ((ret = ref_iterator_advance(iter)) == ITER_OK) {
 		if (should_pack_ref(refs, &iter->ref, opts))
@@ -1530,7 +1551,7 @@ static int files_optimize(struct ref_store *ref_store,
 
 	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
-	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, 0), NULL,
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL,
 					refs->base.repo, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		/*
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 7f060d97bf..a2fc257f98 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -96,6 +96,18 @@ test_expect_success '--include-root-refs omits dangling symrefs' '
 	)
 '
 
+test_expect_success '--include-root-refs with --merged' '
+	cat >expect <<-\EOF &&
+	HEAD
+	ORIG_HEAD
+	EOF
+	test_when_finished "git update-ref -d ORIG_HEAD" &&
+	git update-ref ORIG_HEAD main &&
+	git for-each-ref --format="%(refname)" --include-root-refs \
+		--merged=main "*HEAD" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'filtering with --points-at' '
 	cat >expect <<-\EOF &&
 	refs/heads/main
-- 
2.56.0

