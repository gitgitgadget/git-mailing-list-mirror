Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66368184524
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751627711; cv=none; b=e9252YGFKm54OoNH3SyZZhTcqqtHYTQHTEso+RUZ/hLlS/bHOrVfNFWcCh8h66+xkCInK4avCoPvHHAKa6v1CJID+QFEGoozgZcolcMgEL0xaecsmTph0rDorEfnxOnv2Cbo4vzhCI1Bz3Rag2qOsYzhCRuFhjd3XGA4lXKH7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751627711; c=relaxed/simple;
	bh=4BZuw0MlSgmq7IFj1I0O6iGJFA1nE76VRrLHKDySffo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoj7a3sxbV6wIG9Vpjq9BHffc5kQYlvS4imCFQ6HkdE31WcbQWfX06DS0vc0n/kQbFg8Hmvbn3zZsHTckS//DWUOee1LHy9AF1B/LkRPtQQyw9CEVEuWor2z8rxLyGfHy/ecw6zFqfNIcGzcfxesx4YyeNet3yiMpBUL+yu8nBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5/IiAJX; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5/IiAJX"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-315b0050bb5so684286a91.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 04:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751627708; x=1752232508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMbKL3aeG79BNumHJZb5Y5g2CHdiyaCYEGeRsQt2E/w=;
        b=Z5/IiAJXIKTEu1x1BYcWOGUPoAx/Y3OdSTzqkfDgQFzHKwgP01Qax12BCMdpJZ7lTT
         xMrB8k+WZvrZQPMo7PgjB4V+QiIzPNzCyUR7Pf2h2sTmkpenqeOVJaHMQ+kXsSSOUW13
         zty6+l9JRFEq5Yot8nZJ2A18UH1YYEv869Z45Oho3f9/K35QhNSEI0NTU+X/uJHdCSxA
         gysNVVTy1HT5ycLC7Y+I/EEh7yNKmS4gFkhWuJ5NU+bgWDZLoAXZjb8DD4whzAyCMy7o
         NEOhuswO206Mx5dlW97ZzgGLgrSotkpquiGkcl8DUh93CUHA61e5iaacEjbwu8e5aSFc
         YGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751627708; x=1752232508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMbKL3aeG79BNumHJZb5Y5g2CHdiyaCYEGeRsQt2E/w=;
        b=soO45tV6xNihe9FZd+DfRCNtweU8gsnH/K/KJmVYl5gnh/iRKK9/8CQi/GmFmINJFV
         u8LhQfVR6S/wbiZClUp71t4FK/uT+5GWWA5Zcj/zPOA43Yc6/BDbIeRsk/oWjGcqwQgY
         IlrIkkd0EHt+M2KY4TetsDQsYuJpvmAdp/5hp56KSgtECsU9RI0ppxqpvF6sO4H4a1hz
         RegZhXEycZFhUoeSMRtFAWlCGzGmOd7PqvN9yVkbxIGe6DYJFQNL3ZgvXkaR/JOwVNb/
         UON5ptONY16xFqVwhKTT7kHKZsNuMFfqdmRRnIE7XvpjscoKcAqTSfzN1az4kBNTnesE
         yyCA==
X-Forwarded-Encrypted: i=1; AJvYcCWtvcUesVu3mp7uGiXJwsVy4q049ZWG/tHEbVPTiIUlh0+J8e1aw1nVOnIxHH2Yf4WEYjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydXOycw9/F/WHd3nBB6y9PiSfnQ2DRSUEC8zzlOfhDZwyTME8y
	M7Nkq92zMZwouMRSKzTEJO+Ylbxiyr2VChKAuy1mkSYg8Ihqg6ZsWR6lKFeWcqKt4U5viQ==
X-Gm-Gg: ASbGncvPvF7/tRKylW26CtouB4KTYv6Y8iehOOc/ofCK+9VUCVLD9v14mBd6BS9I5Xy
	vYCx99ZIcWlhn4emxOFPKt5/ryYjrYXCK9U3EmfhSMzJOwI5orUwWpngr9vqWIniqdamzXZkKwS
	DPJkS3ujj719MBh5B8Q8mA+8aDtn3CGBLOS546uyxDmm+D25B/56rEWBkHUOs8sDBUThgSP0MjW
	pznFqf0sm+8TCyzqmRG/azQvG3+rfqvgxHBznWxFryJEcME25e6VC3Nzsc+FCVhsK8XQC5Q+ev7
	WGHNy3VSatECqFCSbvY6RuDMfVd6w1XOdW5qJ4brqCthxCUU0EZFRfyE/A0xCjUkYYTV
X-Google-Smtp-Source: AGHT+IHT7HbR7zdoooRU0v/9xJFQR6OsrQGDyIoKL0xJ9UtvNcjfluaJIsLHxlLpfmF5EBmk1b3I6w==
X-Received: by 2002:a17:90b:2f0d:b0:313:20d2:c99b with SMTP id 98e67ed59e1d1-31aac44b34emr3662725a91.9.1751627708439;
        Fri, 04 Jul 2025 04:15:08 -0700 (PDT)
Received: from r760 ([188.253.126.205])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9ccf8881sm4720522a91.29.2025.07.04.04.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 04:15:08 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v4 4/4] bloom: optimize multiple pathspec items in revision traversal
Date: Fri,  4 Jul 2025 19:14:37 +0800
Message-ID: <20250704111437.2660251-5-502024330056@smail.nju.edu.cn>
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

To enable optimize multiple pathspec items in revision traversal,
return 0 if all pathspec item is literal in forbid_bloom_filters().
Add code to initialize and check each pathspec item's bloom_keyvec.

Add new function release_revisions_bloom_keyvecs() to free all bloom
keyvec owned by rev_info.

Add new test cases in t/t4216-log-bloom.sh to ensure
  - consistent results between the optimization for multiple pathspec
    items using bloom filter and the case without bloom filter
    optimization.
  - does not use bloom filter if any pathspec item is not literal.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 revision.c           | 118 ++++++++++++++++++++++++-------------------
 t/t4216-log-bloom.sh |  23 +++++----
 2 files changed, 79 insertions(+), 62 deletions(-)

diff --git a/revision.c b/revision.c
index 7cbb49617d..9a77c0d0bc 100644
--- a/revision.c
+++ b/revision.c
@@ -675,16 +675,17 @@ static int forbid_bloom_filters(struct pathspec *spec)
 {
 	if (spec->has_wildcard)
 		return 1;
-	if (spec->nr > 1)
-		return 1;
 	if (spec->magic & ~PATHSPEC_LITERAL)
 		return 1;
-	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
-		return 1;
+	for (size_t nr = 0; nr < spec->nr; nr++)
+		if (spec->items[nr].magic & ~PATHSPEC_LITERAL)
+			return 1;
 
 	return 0;
 }
 
+static void release_revisions_bloom_keyvecs(struct rev_info *revs);
+
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	struct pathspec_item *pi;
@@ -692,7 +693,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	char *path_alloc = NULL;
 	const char *path, *p;
 	size_t len;
-	int path_component_nr = 1;
+	int path_component_nr;
 
 	if (!revs->commits)
 		return;
@@ -709,50 +710,52 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
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
-	bloom_keyvec = bloom_keyvec_new(path_component_nr);
-	revs->bloom_keyvecs[0] = bloom_keyvec;
-
-	bloom_keyvec_fill_key(path, len, bloom_keyvec, 0,
-			      revs->bloom_filter_settings);
-	path_component_nr = 1;
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
 
-	p = path + len - 1;
-	while (p > path) {
-		if (*p == '/')
-			bloom_keyvec_fill_key(path, p - path, bloom_keyvec,
-					      path_component_nr++,
-					      revs->bloom_filter_settings);
-		p--;
+		bloom_keyvec = bloom_keyvec_new(path_component_nr);
+		revs->bloom_keyvecs[i] = bloom_keyvec;
+
+		bloom_keyvec_fill_key(path, len, bloom_keyvec, 0,
+				      revs->bloom_filter_settings);
+		path_component_nr = 1;
+
+		p = path + len - 1;
+		while (p > path) {
+			if (*p == '/')
+				bloom_keyvec_fill_key(path, p - path,
+						      bloom_keyvec,
+						      path_component_nr++,
+						      revs->bloom_filter_settings);
+			p--;
+		}
+		FREE_AND_NULL(path_alloc);
 	}
 
 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
@@ -760,7 +763,12 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
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
@@ -3204,6 +3212,14 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 
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
@@ -3232,11 +3248,7 @@ void release_revisions(struct rev_info *revs)
 	clear_decoration(&revs->treesame, free);
 	line_log_free(revs);
 	oidset_clear(&revs->missing_commits);
-
-	for (size_t i = 0; i < revs->bloom_keyvecs_nr; i++)
-		bloom_keyvec_free(revs->bloom_keyvecs[i]);
-	FREE_AND_NULL(revs->bloom_keyvecs);
-	revs->bloom_keyvecs_nr = 0;
+	release_revisions_bloom_keyvecs(revs);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 8910d53cac..639868ac56 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -66,8 +66,9 @@ sane_unset GIT_TRACE2_CONFIG_PARAMS
 
 setup () {
 	rm -f "$TRASH_DIRECTORY/trace.perf" &&
-	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom &&
-	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
+	eval git -c core.commitGraph=false log --pretty="format:%s" "$1" >log_wo_bloom &&
+	eval "GIT_TRACE2_PERF=\"$TRASH_DIRECTORY/trace.perf\"" \
+		git -c core.commitGraph=true log --pretty="format:%s" "$1" >log_w_bloom
 }
 
 test_bloom_filters_used () {
@@ -138,10 +139,6 @@ test_expect_success 'git log with --walk-reflogs does not use Bloom filters' '
 	test_bloom_filters_not_used "--walk-reflogs -- A"
 '
 
-test_expect_success 'git log -- multiple path specs does not use Bloom filters' '
-	test_bloom_filters_not_used "-- file4 A/file1"
-'
-
 test_expect_success 'git log -- "." pathspec at root does not use Bloom filters' '
 	test_bloom_filters_not_used "-- ."
 '
@@ -151,9 +148,17 @@ test_expect_success 'git log with wildcard that resolves to a single path uses B
 	test_bloom_filters_used "-- *renamed"
 '
 
-test_expect_success 'git log with wildcard that resolves to a multiple paths does not uses Bloom filters' '
-	test_bloom_filters_not_used "-- *" &&
-	test_bloom_filters_not_used "-- file*"
+test_expect_success 'git log with multiple literal paths uses Bloom filter' '
+	test_bloom_filters_used "-- file4 A/file1" &&
+	test_bloom_filters_used "-- *" &&
+	test_bloom_filters_used "-- file*"
+'
+
+test_expect_success 'git log with path contains a wildcard does not use Bloom filter' '
+	test_bloom_filters_not_used "-- file\*" &&
+	test_bloom_filters_not_used "-- A/\* file4" &&
+	test_bloom_filters_not_used "-- file4 A/\*" &&
+	test_bloom_filters_not_used "-- * A/\*"
 '
 
 test_expect_success 'setup - add commit-graph to the chain without Bloom filters' '
-- 
2.50.0.107.g33b6ec8c79

