Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97E156F4A
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137337; cv=none; b=JDbNi++kypWm7AoWzM93l4Br45zK2XyWW+Icbf5EihlVYgrmd/zlg9/v5bRz4BXdsGloYH1uyGHEXxkIMH6AQvZDB/MYlUPxVg2//aIGZXeIIW1aijOlguI12NDnSBMVHwg4825SzsUiEcYz7GQ47k5fuM5Tofr24TJmuUNGg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137337; c=relaxed/simple;
	bh=PPD9QI9EL7YJlb8D2FQCu/T3AYku/v8joJAtyy+rrNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mt6tZnkJdHFCA+lM5P15VNNJ/dEaaXND5LTnd+67UHYBlCQ2qdIyU+A/By3yCUi0Dj/gxUa33doDPb/eC5DtFnHW5qzFCxwyLQB5YrwT2KDU7jTRH64KYY6ezAtY+iHhkm/gsBac8HgTTzpkmrc8OLMf2i4/3XSH/jl8YgRb9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGvbyuVb; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGvbyuVb"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-74b54af901bso506033b3a.2
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 01:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752137335; x=1752742135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+IMh7BdYkHtKznPSCl28LHPidYolaIL+BTbBXa/bIM=;
        b=bGvbyuVbNDF9FDiD0Bhp/yA4GJNFmZpJWaXBKsBzHyC38U0jTLGmRz+GzW/QgKag3o
         dzt9jBdQmEHYNHd4TnJPljk1KSf+LAdpk7sFVJPPDvjxlSGTMTkLOf//e96/YczS4Mlo
         9vDbbrO/nw4B0JdzlnunS1q61OPGAtHrw5h2OK0oDxhJ8jd1ZUgPpl3N1Pg3OOZP2Bfj
         mc86vHWZMRecLIX75UggySR7T825JUiOjYxaYfoPydZ8AXSZ5Epz/zUR4CBveYngQjfo
         aofF7C52u9xZ28hnNZq5KgqY/8JZ4MIwRNf4WU0Eoi7q6ox1wUA2CAmCVajdJAovgPea
         Vg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137335; x=1752742135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+IMh7BdYkHtKznPSCl28LHPidYolaIL+BTbBXa/bIM=;
        b=PWD7er6hdDuQ9X5dXMK6+3UNUPELqyS6KqbnkFU6rNXuba2qDViGMWREGqc9X+SIk8
         69R+I8FwUEFZ56aGegdLNqoeMNZ8fS6yGJzlUdwaHCm4aegLaVisV//GTLMIFbv8N2CF
         z5XJK/Y049nlfiLLwbOvaxMq+3Z807OWQsIZYjINfY0cEQ6Fmd5d1fq/xjHybQrv4vLG
         QmOBBnVJYS3EPFjlL60AfrP8WeL3hMIbYQtzbUeUCFRxGSrhddj50TsG3NJETkAM9E+L
         AthOZvjM5mJGkMcUuZ52kLgzQkwsMLhU9tDD9xuztEh7J8sY2sDpYUlTvGfK2VLuPQ7y
         ykSg==
X-Forwarded-Encrypted: i=1; AJvYcCVNApEyImKfwh2SYKCDpjoouyOiwdiZMrWvfEzNlE5qwn+ydG6L2ftaRwP+/LiDqvMYbr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnpJlaAct8acM9E+1r6hACslHDJd1zMu6iGZ3syT10+MDGSUo
	4m9J3F1Je2FaEqyWivwpdw70aVFJ6gPTSRK33nPsNPwABdRsLJpalW+o
X-Gm-Gg: ASbGnctkFLvd5YBIVq5xEUiuc6NuAFT1SMmmUAj3gWQGBJia60WrMD8MOIk4OxGSv+k
	yZrFhfqOKEYaIMTXqQmp7RQ6/GEWQgAzJ1TatqQ0m5WdCV1MDeDe7MqnfaJf7uKMEEY2mnEgA7z
	VInOW8n0rr5OAZJphvP6EH8oEfFQxGTm/LomthmrbX9sqs63pp7rXrL9v0AMo6Q3VrIx6xEfPIE
	CkNg3ww4HU5ST1lQaPvzqWdbY76rN6qbx/o5dyuvq1xvj3sTwJAHmBeN7EADFxQdYuy68JDePaG
	c4fqX37pHbwy1mzu9JarZETLh0q3FU5YQD7SgowHGT00oBAXU8WkU05U815WJQQd6SmI
X-Google-Smtp-Source: AGHT+IEQbE7q0hW59ofneYmvTzUURNNSgllMimZvbB+2L9e8KqVohh4g97utOXtmijcKsPmY0ljBBA==
X-Received: by 2002:aa7:8896:0:b0:749:93d:b098 with SMTP id d2e1a72fcca58-74ea66c23b3mr7795064b3a.22.1752137334648;
        Thu, 10 Jul 2025 01:48:54 -0700 (PDT)
Received: from r760 ([188.253.126.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f22d93sm1535777b3a.89.2025.07.10.01.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:48:54 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com,
	toon@iotcl.com
Subject: [PATCH v5 3/4] bloom: replace struct bloom_key * with struct bloom_keyvec
Date: Thu, 10 Jul 2025 16:48:28 +0800
Message-ID: <20250710084829.2171855-4-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.110.g198a7da17c
In-Reply-To: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
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
 bloom.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++
 bloom.h    | 38 +++++++++++++++++++++++++++
 revision.c | 75 ++++++++++++++++++++++--------------------------------
 revision.h |  6 ++---
 4 files changed, 132 insertions(+), 48 deletions(-)

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
index 603bc1f90f..3602d32054 100644
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
+ * bloom_keyvec_fill - Allocate and populate a bloom_keyvec with keys for the
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
index a7eadff0a5..22bcfab7f9 100644
--- a/revision.c
+++ b/revision.c
@@ -685,13 +685,15 @@ static int forbid_bloom_filters(struct pathspec *spec)
 	return 0;
 }
 
+static void release_revisions_bloom_keyvecs(struct rev_info *revs);
+
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	struct pathspec_item *pi;
+	struct bloom_keyvec *bloom_keyvec;
 	char *path_alloc = NULL;
 	const char *path, *p;
 	size_t len;
-	int path_component_nr = 1;
 
 	if (!revs->commits)
 		return;
@@ -708,6 +710,8 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	if (!revs->pruning.pathspec.nr)
 		return;
 
+	revs->bloom_keyvecs_nr = 1;
+	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
 	pi = &revs->pruning.pathspec.items[0];
 
 	/* remove single trailing slash from path, if needed */
@@ -718,53 +722,30 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
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
@@ -779,10 +760,10 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
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
@@ -823,7 +804,7 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
-	if (revs->bloom_keys_nr && !nth_parent) {
+	if (revs->bloom_keyvecs_nr && !nth_parent) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 
 		if (bloom_ret == 0)
@@ -850,7 +831,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit,
 	if (!t1)
 		return 0;
 
-	if (!nth_parent && revs->bloom_keys_nr) {
+	if (!nth_parent && revs->bloom_keyvecs_nr) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 		if (!bloom_ret)
 			return 1;
@@ -3201,6 +3182,14 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 
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
@@ -3229,11 +3218,7 @@ void release_revisions(struct rev_info *revs)
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
2.50.0.107.g33b6ec8c79

