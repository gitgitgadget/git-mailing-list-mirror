Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D9320296C
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751005335; cv=none; b=XW59CljcLFVZm7hFG6Kp3DWaO32I8VhQ2YBefGGz1tURd4guGqwDQGa7skswMrJ1MCH0xg5CF+lORdzCAzXFbdxJI51ZcuVWPoSlPzJwgfHC62Ky/8Hvla8nFCJCQ3h+ZDYcE+T3CzUuQXdGVbvxlVKHYIa4jvu17rug2N1j0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751005335; c=relaxed/simple;
	bh=QF1j+NBTwlraN2BSyCEp/g/j8agz7PVZr/9jxKlXztM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAaX/TJyAwR5N+bRYoCEuzRvIw1cQsvbpVlkaevqAeBoESlBZ+5XeJl3PFP1vwfOg+0vhtJOtsRDWLgyNFBPsrb6T37iI+9uzeQGeFsISWMqzw5aawBwDUFIlDNj5pX9rlS2t21COY2O6R+klGReABhqdVCPAt5xkCNs6DjwkQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TikS9JsR; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TikS9JsR"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-748da522e79so1097666b3a.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 23:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751005333; x=1751610133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKTTpUH9MHolnerdnNV8qL6sw0EApA6KLLVbyPGwTZE=;
        b=TikS9JsRyWZmJ6lhGvpn+T5JT7ODKuDvAqYpxqPH+aOv3ogq7QB3m4/OgQeGKKzFiN
         RuO1HGbfPE2uquRu4WdrD7H31NeTmHWnTEyK8wfe9qnz/uw6EOQ409i1HwM3jEVkEQOu
         1f0Ru6aL896scfNmQxPsjeAlHnRm4+0e0NJ+n/Kbr94x/eQQhQairCTQ2nvyY5MASKHI
         5aSy4zM4TzbFg51diUSp9BGG/XjyC4dVouyQQT4KXNDwXdO/N1mZDDUlQoqJ+fSZrzf2
         5WCCzv3tPW3oeAJynMTCef24zOI6Aj7R2coI7Sr8KJ20yoblDu90nQ9ocqaXequhUzuG
         CmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751005333; x=1751610133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKTTpUH9MHolnerdnNV8qL6sw0EApA6KLLVbyPGwTZE=;
        b=tFsKaqh/6gi5mQxQkYQr3V3rvD/8lC8/Ty7LDp46RKNClpE0a8aiNwYnNaSHcXVcuY
         0lDZ6BNNpV9yGkkSn2vroIgUpm10qPGQbAr3nNwNY4phuvvZGlxPcGBMqUMIvEYZejZY
         RSB0o4qHI6AI2v4K9s9aIT6DXc2NmD0chvhC+gqx72VOz2t264d5CPLEFQDOOBjWphpd
         XoaTcBGZ0hjf743VwNtNIl4FLsyXVNYvwjtJAwFCX/wUh5kxHm1E6aq+34vtA/cqMb01
         xxUBVi9wHaktMaVhuoELpSdw9a/raavzwGmoTuCWnzs1Ln6MU8JYS/8lJ/xQiEOkhCDh
         nStQ==
X-Gm-Message-State: AOJu0YwrqedDoTkQj3oO/s4WhdU7ngkhrxRK1FYUjx+I1ApH67BxzNOF
	r2jN2hj/VqF2DWIMBHW6jMcGDVzepOa2MDTwTzS0NuVSHYKzJ1YO+az12wJe0oWd5WAOZ1aA
X-Gm-Gg: ASbGnctKO4szUkdU9n9LPSPf3EUak1ByqnCWPgW9SratR0su1dkbJ3UpWTqH0in6nds
	9eaeC3kxzG+7gMt6fc3244cj/JW/CpnGUKt/mDZ3wQzVxc2H6GcKdlxkfuLNSCtjO+YVOn/gOgm
	qdW/FGI+IJOMf7EfPJKvHr3Vw3Og0SZXDkYQBWjlCxn/azNSspJhi8tkx297bDqSxM29Ib0pTPp
	ve0FKxW+PdTnVRj0Mfj8MRWHpkzjGeGxHRZR+eMBU5ps1AEBuQQggMopV5LoYuf8n9DPxfMa5Sz
	mGbHibOo235Agqnw51lb78I5P/7wy6EHM/wQvg4AqItT+D2I168a7mRljmya6XSd0Vo+
X-Google-Smtp-Source: AGHT+IFV6vrvHskc5J19xodr3aaJvzOsHqt99NVXEPbCPj4HduWKWpeRWSfN/ZTT9Wl/aSkxMCF3cA==
X-Received: by 2002:a05:6a00:10c5:b0:748:fe3a:49f2 with SMTP id d2e1a72fcca58-74af70276b1mr2477254b3a.21.1751005333019;
        Thu, 26 Jun 2025 23:22:13 -0700 (PDT)
Received: from r760 ([188.253.126.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ef4ccsm1414936b3a.156.2025.06.26.23.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 23:22:12 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: [PATCH v2 2/2] bloom: optimize multiple pathspec items in revision traversal
Date: Fri, 27 Jun 2025 14:21:54 +0800
Message-ID: <20250627062154.1121530-3-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.108.g6ae0c543ae
In-Reply-To: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove `if (spec->nr > 1)` to enable bloom filter given multiple
pathspec items. Add for loop in prepare_to_use_bloom_filter()
to initialize each pathspec item's struct bloom_keyvec. Add for
loop in check_maybe_different_in_bloom_filter() to find if at least one
bloom_keyvec is contained in bloom filter.

Add new function release_revisions_bloom_keyvecs() to free all bloom
keyvec owned by rev_info.

Modify t/t4216 to ensure consistent results between the optimization
for multiple pathspec items using bloom filters and the case without
bloom filter optimization.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 revision.c           | 121 ++++++++++++++++++++++++-------------------
 t/t4216-log-bloom.sh |  10 ++--
 2 files changed, 73 insertions(+), 58 deletions(-)

diff --git a/revision.c b/revision.c
index 3aa544c137..5606f6c7f6 100644
--- a/revision.c
+++ b/revision.c
@@ -675,8 +675,6 @@ static int forbid_bloom_filters(struct pathspec *spec)
 {
 	if (spec->has_wildcard)
 		return 1;
-	if (spec->nr > 1)
-		return 1;
 	if (spec->magic & ~PATHSPEC_LITERAL)
 		return 1;
 	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
@@ -685,6 +683,8 @@ static int forbid_bloom_filters(struct pathspec *spec)
 	return 0;
 }
 
+static void release_revisions_bloom_keyvecs(struct rev_info *revs);
+
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	struct pathspec_item *pi;
@@ -692,7 +692,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	char *path_alloc = NULL;
 	const char *path, *p;
 	size_t len;
-	int path_component_nr = 1;
+	int path_component_nr;
 
 	if (!revs->commits)
 		return;
@@ -709,50 +709,53 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	if (!revs->pruning.pathspec.nr)
 		return;
 
-	pi = &revs->pruning.pathspec.items[0];
-
-	/* remove single trailing slash from path, if needed */
-	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
-		path_alloc = xmemdupz(pi->match, pi->len - 1);
-		path = path_alloc;
-	} else
-		path = pi->match;
-
-	len = strlen(path);
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
-	revs->bloom_keyvecs_nr = 1;
-	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
-	bloom_keyvec = create_bloom_keyvec(path_component_nr);
-	revs->bloom_keyvecs[0] = bloom_keyvec;
+	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
+	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
+	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
+		pi = &revs->pruning.pathspec.items[i];
+		path_component_nr = 1;
+
+		/* remove single trailing slash from path, if needed */
+		if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
+			path_alloc = xmemdupz(pi->match, pi->len - 1);
+			path = path_alloc;
+		} else
+			path = pi->match;
+
+		len = strlen(path);
+		if (!len)
+			goto fail;
+
+		p = path;
+		while (*p) {
+			/*
+			 * At this point, the path is normalized to use
+			 * Unix-style path separators. This is required due to
+			 * how the changed-path Bloom filters store the paths.
+			 */
+			if (*p == '/')
+				path_component_nr++;
+			p++;
+		}
 
-	fill_bloom_keyvec_key(path, len, bloom_keyvec, 0,
-			      revs->bloom_filter_settings);
-	path_component_nr = 1;
+		bloom_keyvec = create_bloom_keyvec(path_component_nr);
+		revs->bloom_keyvecs[i] = bloom_keyvec;
+
+		fill_bloom_keyvec_key(path, len, bloom_keyvec, 0,
+			       revs->bloom_filter_settings);
+		path_component_nr = 1;
+
+		p = path + len - 1;
+		while (p > path) {
+			if (*p == '/')
+				fill_bloom_keyvec_key(path, p - path,
+					       bloom_keyvec,
+						   path_component_nr++,
+					       revs->bloom_filter_settings);
+			p--;
+		}
 
-	p = path + len - 1;
-	while (p > path) {
-		if (*p == '/')
-			fill_bloom_keyvec_key(path, p - path, bloom_keyvec,
-					      path_component_nr++,
-					      revs->bloom_filter_settings);
-		p--;
+		FREE_AND_NULL(path_alloc);
 	}
 
 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
@@ -760,14 +763,19 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
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
@@ -782,8 +790,11 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 		return -1;
 	}
 
-	result = bloom_filter_contains_vec(filter, revs->bloom_keyvecs[0],
-					   revs->bloom_filter_settings);
+	for (size_t nr = 0; !result && nr < revs->bloom_keyvecs_nr; nr++) {
+		result = bloom_filter_contains_vec(filter,
+						   revs->bloom_keyvecs[nr],
+						   revs->bloom_filter_settings);
+	}
 
 	if (result)
 		count_bloom_filter_maybe++;
@@ -3201,6 +3212,14 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 
 static void release_revisions_topo_walk_info(struct topo_walk_info *info);
 
+static void release_revisions_bloom_keyvecs(struct rev_info *revs)
+{
+	for (size_t nr = 0; nr < revs->bloom_keyvecs_nr; nr++)
+		destroy_bloom_keyvec(revs->bloom_keyvecs[nr]);
+	FREE_AND_NULL(revs->bloom_keyvecs);
+	revs->bloom_keyvecs_nr = 0;
+}
+
 static void free_void_commit_list(void *list)
 {
 	free_commit_list(list);
@@ -3229,11 +3248,7 @@ void release_revisions(struct rev_info *revs)
 	clear_decoration(&revs->treesame, free);
 	line_log_free(revs);
 	oidset_clear(&revs->missing_commits);
-
-	for (int i = 0; i < revs->bloom_keyvecs_nr; i++)
-		destroy_bloom_keyvec(revs->bloom_keyvecs[i]);
-	FREE_AND_NULL(revs->bloom_keyvecs);
-	revs->bloom_keyvecs_nr = 0;
+	release_revisions_bloom_keyvecs(revs);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 8910d53cac..46d1900a21 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -138,8 +138,8 @@ test_expect_success 'git log with --walk-reflogs does not use Bloom filters' '
 	test_bloom_filters_not_used "--walk-reflogs -- A"
 '
 
-test_expect_success 'git log -- multiple path specs does not use Bloom filters' '
-	test_bloom_filters_not_used "-- file4 A/file1"
+test_expect_success 'git log -- multiple path specs use Bloom filters' '
+	test_bloom_filters_used "-- file4 A/file1"
 '
 
 test_expect_success 'git log -- "." pathspec at root does not use Bloom filters' '
@@ -151,9 +151,9 @@ test_expect_success 'git log with wildcard that resolves to a single path uses B
 	test_bloom_filters_used "-- *renamed"
 '
 
-test_expect_success 'git log with wildcard that resolves to a multiple paths does not uses Bloom filters' '
-	test_bloom_filters_not_used "-- *" &&
-	test_bloom_filters_not_used "-- file*"
+test_expect_success 'git log with wildcard that resolves to a multiple paths uses Bloom filters' '
+	test_bloom_filters_used "-- *" &&
+	test_bloom_filters_used "-- file*"
 '
 
 test_expect_success 'setup - add commit-graph to the chain without Bloom filters' '
-- 
2.50.0.108.g6ae0c543ae

