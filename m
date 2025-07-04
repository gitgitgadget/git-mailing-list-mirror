Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DA02C3256
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751627707; cv=none; b=e3Y5UJ+yGNnAuJGLegIz1aaK2DOUWJGgmRkwfJVEFhdcZfAHrS4Kmz8wnvNoZMXIrSJ3A/iTL/aCABKVALQTF7+cIRJJ3rC9IeEzvTB/Hf5TqRogVAOKsAb1xZtnUdiC3ocmDkD6Tk03+Pk7c7r4/IITanQo3HEWeOkBxG1j1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751627707; c=relaxed/simple;
	bh=PNVkszfbk/29+DQRbheH12jXVJtATMOrw7gChoMe5Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4vxVEARH3JMMtsSqUGmSAl3gjTQSVc1VerLadf6I2+8xPXWTEjifuiP+j8988H7FrCQTi0emmQpnARMNXi4++kLKPK52Uri5o6iwXpLNQ57UQLaBKuQBvHKvWscq3tOSYNTGt8G37J614v3btkASnRmKK8kTbFmt9waK0kvvPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsR07H2t; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsR07H2t"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso874364a12.2
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 04:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751627705; x=1752232505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/Cxo6SY44omoy/I9t0d2OUEodgTG2zGYbH8AfEihec=;
        b=SsR07H2tXx3lEw8d/9KB4SCWB+3+z+AtDqCpoMhbzE1+XAFheuhYs6wXm81sPgUV7g
         iy9133SU1zgQv9VUpqR3yLx5go9ZweXWj35cBGvFTlJCXO3nIEBh1C6cOZTwGK/H/A53
         K1Ql2EdX488dsAUZRiuKoMIArcYX53wbm4BVUF7LVKHZK9RtfSvEZPKKebGeYGLXVP77
         BO7wDx8/NYCMjhW2gScRhV+XzwkozhelZkanXumek8R///wYGPUk/Sa+3zSsPmo07Ax4
         rB+vpH3s7F96mE4kED6ypXTcUKr+cgWmrAa2hrsYTP/CgpC2TEKCHzya02gKJQuPu/e7
         BHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751627705; x=1752232505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/Cxo6SY44omoy/I9t0d2OUEodgTG2zGYbH8AfEihec=;
        b=xGRXwB6wbx3JpmQHo25QiQNRqdUXY70RHfn1sPbrnrdj2zzefZIjH1LG9FFZQPpcno
         C2kfg6VDLCbEhKB6UTwHouY8K0vVVdV1A80kjQP0A/XueGhYTEJlgvpcmQsXZy5mlOyb
         5oCfVH5oHVccaYlKFIi1qh5UHomOMwV4Zwi6n9XoAYYneis9sh9wO+V+jviTqjLcjNYu
         OBdJ9uJ0/31ONz/yfiaAYJ4POwI70OEP3wS6aTDTKheCbpKnmpOV9WoX/kS63dFnUTZQ
         LIWevmTb92qEr3qUrY1D+tdgIo4kchMAXnM98lenWtJAsxolU66SDNzlIT15Fdsk+mmg
         0Gqw==
X-Forwarded-Encrypted: i=1; AJvYcCVdMr5i78OWTqkQ6nyRTeVn7S4bQkJbAwrlnpqNTlaVkavU9vmCqWHSqI+OEmhjd+BwFTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtLPST2Z0AF3IbPVcgNsX40KUs8LTROofXLmVpSv/80U+kaoQf
	QV/2S1sl7W7SRW7xEnbWo7gHg45n7TrPWbT31l9AG61hPQVmZasU1DDzfk0OXvRJu/bKHA==
X-Gm-Gg: ASbGnctjwVsHAT2HajV4rtY6RKZkiCFegvmc80/qssQazdW26CjI+gVSjzv/M5hGHe6
	ET38GB2pK+gGgcx05WsSCu+Y7Hj5Mxris/WR+xPDCxV/F1hL9skA1soaoRz/eki39h00cOqCklX
	qJPAMLf0VVeVf/+vV0DEOdxqCTVXLkCyLgPvmHTY5H5arkqYi08pK3b280g8WX4SdsOMKj2w9CF
	obCrebVYrttvQLFGaGjoKaAN/vyn4J0VFZq74eV8zX9QWlDqPByzZs+kooIByjxfDkoDYF8vCuL
	5PoVwAsq3sTgBTSFXYNKx56zdKmu26OrkGQ2kRmEFW18R+5S4cSK3nRYUK4/63Z3hnPV
X-Google-Smtp-Source: AGHT+IGhsuxr1K+1+ohqFbVhtdUQw5OuKNzQybgzuN1piaDNehnhJC65piLtApi5FEmlP94v2c3tiQ==
X-Received: by 2002:a17:90b:5445:b0:313:1769:eb49 with SMTP id 98e67ed59e1d1-31aadd22d25mr2518891a91.8.1751627704784;
        Fri, 04 Jul 2025 04:15:04 -0700 (PDT)
Received: from r760 ([188.253.126.205])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9ccf8881sm4720522a91.29.2025.07.04.04.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 04:15:04 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v4 3/4] bloom: replace struct bloom_key * with struct bloom_keyvec
Date: Fri,  4 Jul 2025 19:14:36 +0800
Message-ID: <20250704111437.2660251-4-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.107.g33b6ec8c79
In-Reply-To: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
References: <20250628042140.1097910-1-502024330056@smail.nju.edu.cn>
 <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The revision traversal limited by pathspec has optimization when
the pathspec has only one element. To support optimization for
multiple pathspec items, we need to modify the data structures
in struct rev_info.

struct rev_info uses bloom_keys and bloom_nr to store the bloom keys
corresponding to a single pathspec item. To allow struct rev_info
to store bloom keys for multiple pathspec items, a new data structure
`struct bloom_keyvec` is introduced. Each `struct bloom_keyvec`
corresponds to a single pathspec item.

In `struct rev_info`, replace bloom_keys and bloom_nr with bloom_keyvecs
and bloom_keyvec_nr. This commit still optimize one pathspec item, thus
bloom_keyvec_nr can only be 0 or 1.

New bloom_keyvec_* functions are added to create and destroy a keyvec.
bloom_filter_contains_vec() is added to check if all key in keyvec is
contained in a bloom filter. bloom_keyvec_fill_key() is added to
initialize a key in keyvec.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 bloom.c    | 31 +++++++++++++++++++++++++++++++
 bloom.h    | 25 +++++++++++++++++++++++++
 revision.c | 39 +++++++++++++++++++++------------------
 revision.h |  6 +++---
 4 files changed, 80 insertions(+), 21 deletions(-)

diff --git a/bloom.c b/bloom.c
index 35ff36c31c..877bda0ef3 100644
--- a/bloom.c
+++ b/bloom.c
@@ -280,6 +280,25 @@ void deinit_bloom_filters(void)
 	deep_clear_bloom_filter_slab(&bloom_filters, free_one_bloom_filter);
 }
 
+struct bloom_keyvec *bloom_keyvec_new(size_t count)
+{
+	struct bloom_keyvec *vec;
+	size_t sz = sizeof(struct bloom_keyvec);
+	sz += count * sizeof(struct bloom_key);
+	vec = (struct bloom_keyvec *)xcalloc(1, sz);
+	vec->count = count;
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
@@ -541,6 +560,18 @@ int bloom_filter_contains(const struct bloom_filter *filter,
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
index edf14fef3e..3669074f3a 100644
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
@@ -84,6 +94,17 @@ void bloom_key_fill(const char *data,
 		    const struct bloom_filter_settings *settings);
 void bloom_key_clear(struct bloom_key *key);
 
+struct bloom_keyvec *bloom_keyvec_new(size_t count);
+void bloom_keyvec_free(struct bloom_keyvec *vec);
+
+static inline void bloom_keyvec_fill_key(const char *data, size_t len,
+					 struct bloom_keyvec *vec, size_t nr,
+					 const struct bloom_filter_settings *settings)
+{
+	assert(nr < vec->count);
+	bloom_key_fill(data, len, &vec->key[nr], settings);
+}
+
 void add_key_to_filter(const struct bloom_key *key,
 		       struct bloom_filter *filter,
 		       const struct bloom_filter_settings *settings);
@@ -128,6 +149,10 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
 			  const struct bloom_filter_settings *settings);
 
+int bloom_filter_contains_vec(const struct bloom_filter *filter,
+			      const struct bloom_keyvec *v,
+			      const struct bloom_filter_settings *settings);
+
 uint32_t test_bloom_murmur3_seeded(uint32_t seed, const char *data, size_t len,
 				   int version);
 
diff --git a/revision.c b/revision.c
index 49fc650ac7..7cbb49617d 100644
--- a/revision.c
+++ b/revision.c
@@ -688,6 +688,7 @@ static int forbid_bloom_filters(struct pathspec *spec)
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	struct pathspec_item *pi;
+	struct bloom_keyvec *bloom_keyvec;
 	char *path_alloc = NULL;
 	const char *path, *p;
 	size_t len;
@@ -736,19 +737,21 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 		p++;
 	}
 
-	revs->bloom_keys_nr = path_component_nr;
-	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
+	revs->bloom_keyvecs_nr = 1;
+	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
+	bloom_keyvec = bloom_keyvec_new(path_component_nr);
+	revs->bloom_keyvecs[0] = bloom_keyvec;
 
-	bloom_key_fill(path, len, &revs->bloom_keys[0],
-		       revs->bloom_filter_settings);
+	bloom_keyvec_fill_key(path, len, bloom_keyvec, 0,
+			      revs->bloom_filter_settings);
 	path_component_nr = 1;
 
 	p = path + len - 1;
 	while (p > path) {
 		if (*p == '/')
-			bloom_key_fill(path, p - path,
-				       &revs->bloom_keys[path_component_nr++],
-				       revs->bloom_filter_settings);
+			bloom_keyvec_fill_key(path, p - path, bloom_keyvec,
+					      path_component_nr++,
+					      revs->bloom_filter_settings);
 		p--;
 	}
 
@@ -764,7 +767,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 						 struct commit *commit)
 {
 	struct bloom_filter *filter;
-	int result = 1, j;
+	int result = 0;
 
 	if (!revs->repo->objects->commit_graph)
 		return -1;
@@ -779,10 +782,10 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
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
@@ -823,7 +826,7 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
-	if (revs->bloom_keys_nr && !nth_parent) {
+	if (revs->bloom_keyvecs_nr && !nth_parent) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 
 		if (bloom_ret == 0)
@@ -850,7 +853,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit,
 	if (!t1)
 		return 0;
 
-	if (!nth_parent && revs->bloom_keys_nr) {
+	if (!nth_parent && revs->bloom_keyvecs_nr) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 		if (!bloom_ret)
 			return 1;
@@ -3230,10 +3233,10 @@ void release_revisions(struct rev_info *revs)
 	line_log_free(revs);
 	oidset_clear(&revs->missing_commits);
 
-	for (int i = 0; i < revs->bloom_keys_nr; i++)
-		bloom_key_clear(&revs->bloom_keys[i]);
-	FREE_AND_NULL(revs->bloom_keys);
-	revs->bloom_keys_nr = 0;
+	for (size_t i = 0; i < revs->bloom_keyvecs_nr; i++)
+		bloom_keyvec_free(revs->bloom_keyvecs[i]);
+	FREE_AND_NULL(revs->bloom_keyvecs);
+	revs->bloom_keyvecs_nr = 0;
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

