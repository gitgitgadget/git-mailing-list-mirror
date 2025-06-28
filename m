Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF83321D3C5
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 04:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751084513; cv=none; b=qJL6WIFjYVF4IklI1+38FaDPGkpDuO/ukogr9xhq7uv/QnLwtkcaqUhJ8xoOaF7oSUsSvhiYfjmDqSjzuClEh9y7Qa9UbwhsW/N06iM5CvF54iWRifprAXo/ZT2VmnmRTo6MPalDf35RqzkOwm+0Gh0nnF5BCmr9WQubl3sDay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751084513; c=relaxed/simple;
	bh=nOfMWiz6bMNngH+FY0ClwUbb4Z22MNBfYj0BiVkRdIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfEBRoAPuBogmJarWYLB3n2TWqbTn6uDdDGHzxz0gZVSX/ulTMz5j8V7yjphpWc5aDMLJDQuc0zavr34Jkvo5X0HW8YH8K5ZkOIcj78/dCDzkGoRw+5BEhui/lxYnYG+FdnU8SeZTXs2J87TrHvzgCnITzvxc0PuIoUXnGS4n8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwDywdk+; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwDywdk+"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7490acf57b9so512132b3a.2
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 21:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751084511; x=1751689311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nGppUasQoK218vjpa99I+vnN0ou3tE1lLHJI+5Mf4M=;
        b=WwDywdk+WXr0QR19IrchzKc0S702Oqbsaysc4OV0L/kn1t7ArRGA+VxhDfRG3UKgxd
         Yj8SF/RJ4v687e1fsb0Ve2PsY6m++ZqVFc5esYuxbaAsmpUW1gwXx+MgM8UDw/wCB5Qb
         WPJLhuIXQjYq6duZeQI26rilEyVTvajNnzELy1NTFi8Fgu0hZkjFMpsx1RUl+7kuPnpt
         Pqn1VSbj5VOszFQwygWh0B3luUZqkd0jeh/hz4jPz4rxEWs3YibEj7SE0xCQ/LnYA/eY
         tAHPJcFAPbvPJQLJ4lkA8Cys8iuT2vSf3gUGWBsmgSSZ6fsU226a7zIpzV+fgFiXFTDj
         FKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751084511; x=1751689311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nGppUasQoK218vjpa99I+vnN0ou3tE1lLHJI+5Mf4M=;
        b=PFR3cdE6L+iCGOKPspbW6BQCe+C63FuLOlqpLvQ7ZIFQI5HpzdHhnwpW7bWxbzx9Tx
         HMGLeDn0IqT9mWBPoQ0N4wWCjBG3a5aKxkJxeSOVWpRr+DuHPqSskDAxhC0v7K7ixg4z
         wuXfa/QFlatYY97qS9HEuR7VBM13bfY4NpJ3PioswXdxgf5spilA14eW17GY6r4vzbvF
         sopvWjP0uHKD3qADpPUuCNgD8qPpiugLb5gfr+s3NDZUXShTzrm2qv3uwwHWlYEQXkYK
         ReI7CJs0fR7XPe6UbQ+xNsnD+B2Mv3HVCCP4ERTMZm39aVHrQVbiUIfJmrOhvUv+HCQw
         cDdQ==
X-Gm-Message-State: AOJu0Yy8LGlRFVZ5f4YofFsl2kF0W7fVsgtthsCaMRs+WhyL06C9o8qV
	qUYwW8heugtk55PKzrr7VycMc1PGWKuQfFrod+Zp/ZjUE1i9GOYUuLSvUKeO2mt0Ccy3Pw==
X-Gm-Gg: ASbGnctY3OueRszS5slp24l2ZwFrlkHYLd7cwmqa8sItLXUY7PdqIICDOdROyL30iI9
	vUUFyfNguK6VV7oNeZ5qOO72oQb3N7UgKAJVaaL3Abp8HVHQcs1WjvAsGN9T2GZ3QknZZqxRAHt
	hxLciV38OHWThmvh1jxCpUHwSd3DDvB8jNg79pKAoEyMSuhbFiD2cJ6KmWgOgBcmdObnlgobLVp
	p5aQyqLWxHTQ1jcnp1mmx5hZD2SALv5KPyB9vVgPS9otr2Xpd8asHtnPHFKD+5JO7eZj1vzlDHl
	upLSpK6gsp9jq3Nw98zjIy+wwfhXE6y7DCqvvy0HZmfdqCYDAJNs9OjWzuCtUioDjTk6
X-Google-Smtp-Source: AGHT+IH3vYQR+RmM3V2ZMOexX40bSTKT2pHXfSDd2pXUtUXOq+9RenbW0nyn5L8JjGAw+pwjob4HLQ==
X-Received: by 2002:a05:6a00:2441:b0:748:3485:b99d with SMTP id d2e1a72fcca58-74af6f4372bmr7883509b3a.18.1751084510911;
        Fri, 27 Jun 2025 21:21:50 -0700 (PDT)
Received: from r760 ([188.253.126.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5580faasm3402914b3a.76.2025.06.27.21.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 21:21:50 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: [PATCH v3 2/2] bloom: optimize multiple pathspec items in revision traversal
Date: Sat, 28 Jun 2025 12:21:40 +0800
Message-ID: <20250628042140.1097910-3-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.108.g6ae0c543ae
In-Reply-To: <20250627062154.1121530-1-502024330056@smail.nju.edu.cn>
References: <20250627062154.1121530-1-502024330056@smail.nju.edu.cn>
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
 revision.c           | 126 ++++++++++++++++++++++++-------------------
 t/t4216-log-bloom.sh |  23 ++++----
 2 files changed, 85 insertions(+), 64 deletions(-)

diff --git a/revision.c b/revision.c
index 3aa544c137..8d73395f26 100644
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
@@ -709,50 +710,53 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
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
@@ -760,14 +764,19 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
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
@@ -782,8 +791,11 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
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
@@ -3201,6 +3213,14 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 
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
@@ -3229,11 +3249,7 @@ void release_revisions(struct rev_info *revs)
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
2.50.0.108.g6ae0c543ae

