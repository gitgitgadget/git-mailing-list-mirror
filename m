Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EB21F4285
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752312966; cv=none; b=KniXFfXuDIfj2wP4rjchh/y0SeRhj9/pjoGdhQaXhJbiefR3BS/NSMh56vhYh8gG4/xqBJDOTBGjcxrQrSWWCg9p0ohVZKIWt6xYEKYmxAUjplbRxWAaF7l70qoDgiGwaheUbeM7m1P+BgMGTwrelRgzPFaLQLPrsZIWzix/g4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752312966; c=relaxed/simple;
	bh=jSH5cqFtvz5vg3DNLtY3cXp4PnusHgO8hYX5R8+J6+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdaD9v9nIPrwmHkewPO5+bM+MmaJHD4fkkDJp9J6zcrfMGnQVYCmigcAcEpiNyQtksdX8ahBnfm+yQ10ixj9aCi/oGcEBTXIUm9XKTuGgNbcf5KWvLL9I3s8yaxzaxxzHY0z/SAUU3WYLQgIlJcdTr35PgXannOxKjMhYNUdCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqce77Ib; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqce77Ib"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so2966846a12.3
        for <git@vger.kernel.org>; Sat, 12 Jul 2025 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752312964; x=1752917764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrGwOXoJWTyMSkOru9Piow5jcOSDQ/lGXtV3OkLbMDU=;
        b=aqce77IbuvE9z4Xv2JPagE2GToT+IZEPAxl4zec4W6rHFD5IZi6Nmmde6AUpOnZ5bX
         unkXo8JyKQgqAw2WATDpVcI12G3WCZxBjis9XUGr7JtfGpHn6IUccJSvR3WJFrSxGDuJ
         pxUzRXo5+/cfEQ4ycat5L4oZfZGJ2/Xbp+XO/wvK8AP8n9vNyRP+TYjAsaAYwJ3VsxyO
         8lS9CfH5CY7VDEB6XaZSeiZbGFgsPFvkXFwZnycCMGnL/ZsJoOBtiOYg3grUDofJGyw6
         yqQOMYEljGirxSosnwcdUP/5g8NxR2CghhO18msEl/UQIsNdV/aoFZIKjh+MtI6FY6xl
         cgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752312964; x=1752917764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrGwOXoJWTyMSkOru9Piow5jcOSDQ/lGXtV3OkLbMDU=;
        b=ObR1A04Hnm5Tpjwc+9uE7F2Xyt0SEAa88uLBkEMn8KXIh8mhBUG0B+WrgOz0pDW2by
         iXIEFV0b/jpnf17Bx3t8mXzgbOXHG3Xyk9gj4TXUchxslA9HfHUX3wi8nP0KpGBzIoR7
         abZGw3wUiVNmmkbl7Kc21TIdCZ50Zih1z5qaH7feZXNBgckrP2MubFfmP6p2tY5Cl36N
         eNi+JcNXMQscfaWyTbD5iuAFfNVWdnv/bwm7TL68nXXkP0vxUgV7/rsBtxswtg9SFWg3
         6OvAvTLgWVGpD9vGewAFaZpr5U5jFo8sb1ukoeUobtWFecUZ1iaOSWISMXKyhlgnRCxt
         43xw==
X-Forwarded-Encrypted: i=1; AJvYcCUEkqoSKzjUGhIUzxD73zrmjH/HBRse/zOaZUIRM3wnUwKhMY6k0zaY0zktrbaBox9NSIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YympE7DgaT8at6qMIUtJDG2yeErk9W9NTzVqSH24GpyJfIjJ0FY
	Buk5pN2OIS6hXwwyb50GlL+66epNKkv1jwF5PeIeXigostsTEJ8jSPz6
X-Gm-Gg: ASbGncvVO7jKDNk1S84k+/B0/nQxkudzauGae149WSHR63BOC+qbPu1ZlIX0bkP2Sk0
	a4j6mo5+cln1Gyl3tVK+C0REDJUhBx4OZe8vUioHpXH85QXz16sGfAvHCfrpS+y3g1XQyRGdlLT
	XeWL+qjAJlxRUa8HEOL2TvdAUet7hrDfxbbJYvVCYTigv1HbGRkhGQzJ2G7IFiTsgZ15IO291sC
	ARhkd/i5eg9PYp/zfLJjxCAnoNeNk+xlUXlw+/PruhcKkhockRD20JM4UuXydFqjOkJnWYeBt5q
	rc3puf17IeiJ+y6QJT6nWV7HQK7keyV/HmnnyKaNDXrzyVSvM8Gd8VgogjtrGBnON515ODj7wpK
	aHRSm3RPMBEhT63b3+RSbjdYGY1ma6mE9NOBk+2zPf4yUlq+O1CvIa3kkCP/MQVJEjFx5bNHxws
	Fw9vXerfYHuYgxHCmNFt5W3U5PITm5hA==
X-Google-Smtp-Source: AGHT+IH4lyLSLh7i6rBD+fnduM/qKekeMp4kZKlzZ2iAO9xFfJgJEQLx0MecFuT14+rB5OWI/aCO0g==
X-Received: by 2002:a05:6a20:2d23:b0:215:d611:5d9b with SMTP id adf61e73a8af0-2311d95ce85mr8919914637.12.1752312963657;
        Sat, 12 Jul 2025 02:36:03 -0700 (PDT)
Received: from localhost.localdomain (awork062176.netvigator.com. [203.198.28.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b43dsm7126997b3a.79.2025.07.12.02.36.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Jul 2025 02:36:03 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com,
	toon@iotcl.com,
	stolee@gmail.com
Subject: [PATCH v6 3/5] bloom: replace struct bloom_key * with struct bloom_keyvec
Date: Sat, 12 Jul 2025 17:35:15 +0800
Message-Id: <20250712093517.17907-4-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250712093517.17907-1-yldhome2d2@gmail.com>
References: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250712093517.17907-1-yldhome2d2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, we stored bloom keys in a flat array and marked a commit
as NOT TREESAME if any key reported "definitely not changed".

To support multiple pathspec items, we now require that for each
pathspec item, there exists a bloom key reporting "definitely not
changed".

This "for every" condition makes a flat array insufficient, so we
introduce a new structure to group keys by a single pathspec item.
`struct bloom_keyvec` is introduced to replace `struct bloom_key *`
and `bloom_key_nr`. And because we want to support multiple pathspec
items, we added a bloom_keyvec * and a bloom_keyvec_nr field to
`struct rev_info` to represent an array of bloom_keyvecs. This commit
still optimize only one pathspec item, thus bloom_keyvec_nr can only
be 0 or 1.

New bloom_keyvec_* functions are added to create and destroy a keyvec.
bloom_filter_contains_vec() is added to check if all key in keyvec is
contained in a bloom filter.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 bloom.c    | 61 +++++++++++++++++++++++++++++++++++++++++++
 bloom.h    | 38 +++++++++++++++++++++++++++
 revision.c | 76 +++++++++++++++++++++---------------------------------
 revision.h |  6 ++---
 4 files changed, 132 insertions(+), 49 deletions(-)

diff --git a/bloom.c b/bloom.c
index 5523d198c8..b86015f6d1 100644
--- a/bloom.c
+++ b/bloom.c
@@ -278,6 +278,55 @@ void deinit_bloom_filters(void)
 	deep_clear_bloom_filter_slab(&bloom_filters, free_one_bloom_filter);
 }
 
+struct bloom_keyvec *bloom_keyvec_new(const char *path, size_t len,
+				      const struct bloom_filter_settings *settings)
+{
+	struct bloom_keyvec *vec;
+	const char *p;
+	size_t sz;
+	size_t nr = 1;
+
+	p = path;
+	while (*p) {
+		/*
+		 * At this point, the path is normalized to use Unix-style
+		 * path separators. This is required due to how the
+		 * changed-path Bloom filters store the paths.
+		 */
+		if (*p == '/')
+			nr++;
+		p++;
+	}
+
+	sz = sizeof(struct bloom_keyvec);
+	sz += nr * sizeof(struct bloom_key);
+	vec = (struct bloom_keyvec *)xcalloc(1, sz);
+	if (!vec)
+		return NULL;
+	vec->count = nr;
+
+	bloom_key_fill(&vec->key[0], path, len, settings);
+	nr = 1;
+	p = path + len - 1;
+	while (p > path) {
+		if (*p == '/') {
+			bloom_key_fill(&vec->key[nr++], path, p - path, settings);
+		}
+		p--;
+	}
+	assert(nr == vec->count);
+	return vec;
+}
+
+void bloom_keyvec_free(struct bloom_keyvec *vec)
+{
+	if (!vec)
+		return;
+	for (size_t nr = 0; nr < vec->count; nr++)
+		bloom_key_clear(&vec->key[nr]);
+	free(vec);
+}
+
 static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 		       const struct hashmap_entry *eptr,
 		       const struct hashmap_entry *entry_or_key,
@@ -539,6 +588,18 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 	return 1;
 }
 
+int bloom_filter_contains_vec(const struct bloom_filter *filter,
+			      const struct bloom_keyvec *vec,
+			      const struct bloom_filter_settings *settings)
+{
+	int ret = 1;
+
+	for (size_t nr = 0; ret > 0 && nr < vec->count; nr++)
+		ret = bloom_filter_contains(filter, &vec->key[nr], settings);
+
+	return ret;
+}
+
 uint32_t test_bloom_murmur3_seeded(uint32_t seed, const char *data, size_t len,
 				   int version)
 {
diff --git a/bloom.h b/bloom.h
index 603bc1f90f..92ab2100d3 100644
--- a/bloom.h
+++ b/bloom.h
@@ -74,6 +74,16 @@ struct bloom_key {
 	uint32_t *hashes;
 };
 
+/*
+ * A bloom_keyvec is a vector of bloom_keys, which
+ * can be used to store multiple keys for a single
+ * pathspec item.
+ */
+struct bloom_keyvec {
+	size_t count;
+	struct bloom_key key[FLEX_ARRAY];
+};
+
 int load_bloom_filter_from_graph(struct commit_graph *g,
 				 struct bloom_filter *filter,
 				 uint32_t graph_pos);
@@ -82,6 +92,23 @@ void bloom_key_fill(struct bloom_key *key, const char *data, size_t len,
 		    const struct bloom_filter_settings *settings);
 void bloom_key_clear(struct bloom_key *key);
 
+/*
+ * bloom_keyvec_new - Allocate and populate a bloom_keyvec with keys for the
+ * given path.
+ *
+ * This function splits the input path by '/' and generates a bloom key for each
+ * prefix, in reverse order of specificity. For example, given the input
+ * "a/b/c", it will generate bloom keys for:
+ *   - "a/b/c"
+ *   - "a/b"
+ *   - "a"
+ *
+ * The resulting keys are stored in a newly allocated bloom_keyvec.
+ */
+struct bloom_keyvec *bloom_keyvec_new(const char *path, size_t len,
+				      const struct bloom_filter_settings *settings);
+void bloom_keyvec_free(struct bloom_keyvec *vec);
+
 void add_key_to_filter(const struct bloom_key *key,
 		       struct bloom_filter *filter,
 		       const struct bloom_filter_settings *settings);
@@ -126,6 +153,17 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
 			  const struct bloom_filter_settings *settings);
 
+/*
+ * bloom_filter_contains_vec - Check if all keys in a key vector are in the
+ * Bloom filter.
+ *
+ * Returns 1 if **all** keys in the vector are present in the filter,
+ * 0 if **any** key is not present.
+ */
+int bloom_filter_contains_vec(const struct bloom_filter *filter,
+			      const struct bloom_keyvec *v,
+			      const struct bloom_filter_settings *settings);
+
 uint32_t test_bloom_murmur3_seeded(uint32_t seed, const char *data, size_t len,
 				   int version);
 
diff --git a/revision.c b/revision.c
index a7eadff0a5..e4e0c83b0c 100644
--- a/revision.c
+++ b/revision.c
@@ -685,13 +685,14 @@ static int forbid_bloom_filters(struct pathspec *spec)
 	return 0;
 }
 
+static void release_revisions_bloom_keyvecs(struct rev_info *revs);
+
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	struct pathspec_item *pi;
 	char *path_alloc = NULL;
-	const char *path, *p;
+	const char *path;
 	size_t len;
-	int path_component_nr = 1;
 
 	if (!revs->commits)
 		return;
@@ -708,6 +709,8 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	if (!revs->pruning.pathspec.nr)
 		return;
 
+	revs->bloom_keyvecs_nr = 1;
+	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
 	pi = &revs->pruning.pathspec.items[0];
 
 	/* remove single trailing slash from path, if needed */
@@ -718,53 +721,30 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 		path = pi->match;
 
 	len = strlen(path);
-	if (!len) {
-		revs->bloom_filter_settings = NULL;
-		free(path_alloc);
-		return;
-	}
-
-	p = path;
-	while (*p) {
-		/*
-		 * At this point, the path is normalized to use Unix-style
-		 * path separators. This is required due to how the
-		 * changed-path Bloom filters store the paths.
-		 */
-		if (*p == '/')
-			path_component_nr++;
-		p++;
-	}
-
-	revs->bloom_keys_nr = path_component_nr;
-	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
+	if (!len)
+		goto fail;
 
-	bloom_key_fill(&revs->bloom_keys[0], path, len,
-		       revs->bloom_filter_settings);
-	path_component_nr = 1;
-
-	p = path + len - 1;
-	while (p > path) {
-		if (*p == '/')
-			bloom_key_fill(&revs->bloom_keys[path_component_nr++],
-				       path, p - path,
-				       revs->bloom_filter_settings);
-		p--;
-	}
+	revs->bloom_keyvecs[0] =
+		bloom_keyvec_new(path, len, revs->bloom_filter_settings);
 
 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
 		atexit(trace2_bloom_filter_statistics_atexit);
 		bloom_filter_atexit_registered = 1;
 	}
 
+	return;
+
+fail:
+	revs->bloom_filter_settings = NULL;
 	free(path_alloc);
+	release_revisions_bloom_keyvecs(revs);
 }
 
 static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 						 struct commit *commit)
 {
 	struct bloom_filter *filter;
-	int result = 1, j;
+	int result = 0;
 
 	if (!revs->repo->objects->commit_graph)
 		return -1;
@@ -779,10 +759,10 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 		return -1;
 	}
 
-	for (j = 0; result && j < revs->bloom_keys_nr; j++) {
-		result = bloom_filter_contains(filter,
-					       &revs->bloom_keys[j],
-					       revs->bloom_filter_settings);
+	for (size_t nr = 0; !result && nr < revs->bloom_keyvecs_nr; nr++) {
+		result = bloom_filter_contains_vec(filter,
+						   revs->bloom_keyvecs[nr],
+						   revs->bloom_filter_settings);
 	}
 
 	if (result)
@@ -823,7 +803,7 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
-	if (revs->bloom_keys_nr && !nth_parent) {
+	if (revs->bloom_keyvecs_nr && !nth_parent) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 
 		if (bloom_ret == 0)
@@ -850,7 +830,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit,
 	if (!t1)
 		return 0;
 
-	if (!nth_parent && revs->bloom_keys_nr) {
+	if (!nth_parent && revs->bloom_keyvecs_nr) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 		if (!bloom_ret)
 			return 1;
@@ -3201,6 +3181,14 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 
 static void release_revisions_topo_walk_info(struct topo_walk_info *info);
 
+static void release_revisions_bloom_keyvecs(struct rev_info *revs)
+{
+	for (size_t nr = 0; nr < revs->bloom_keyvecs_nr; nr++)
+		bloom_keyvec_free(revs->bloom_keyvecs[nr]);
+	FREE_AND_NULL(revs->bloom_keyvecs);
+	revs->bloom_keyvecs_nr = 0;
+}
+
 static void free_void_commit_list(void *list)
 {
 	free_commit_list(list);
@@ -3229,11 +3217,7 @@ void release_revisions(struct rev_info *revs)
 	clear_decoration(&revs->treesame, free);
 	line_log_free(revs);
 	oidset_clear(&revs->missing_commits);
-
-	for (int i = 0; i < revs->bloom_keys_nr; i++)
-		bloom_key_clear(&revs->bloom_keys[i]);
-	FREE_AND_NULL(revs->bloom_keys);
-	revs->bloom_keys_nr = 0;
+	release_revisions_bloom_keyvecs(revs);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/revision.h b/revision.h
index 6d369cdad6..ac843f58d0 100644
--- a/revision.h
+++ b/revision.h
@@ -62,7 +62,7 @@ struct repository;
 struct rev_info;
 struct string_list;
 struct saved_parents;
-struct bloom_key;
+struct bloom_keyvec;
 struct bloom_filter_settings;
 struct option;
 struct parse_opt_ctx_t;
@@ -360,8 +360,8 @@ struct rev_info {
 
 	/* Commit graph bloom filter fields */
 	/* The bloom filter key(s) for the pathspec */
-	struct bloom_key *bloom_keys;
-	int bloom_keys_nr;
+	struct bloom_keyvec **bloom_keyvecs;
+	int bloom_keyvecs_nr;
 
 	/*
 	 * The bloom filter settings used to generate the key.
-- 
2.39.5 (Apple Git-154)

