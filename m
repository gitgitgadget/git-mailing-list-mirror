Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9468A1F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932466AbeFPFmg (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:36 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38386 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755014AbeFPFmL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:11 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so17517804lfh.5
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lwfVBZK6jVsKk1HZotg7tdTTIeKjMtEQvCPgV7klkk8=;
        b=ouorDFoZo3aS0VJlUh+pxcUtojvma6ywMJkEP6PbJ+U+K22m6MQb7I2chKy4+sOV8g
         YHZE4LPk/3fwjJSuhU1incSbf9Ru7tG6jXMVjKkTzVaXMwUdMTWNoppqB8r7d+n12uCX
         HzYxDbbAHlXd35uA3HLMZtHYTGAeqQN/9Ot9MRDjkIpYnMAj8JVvbx71jWAkRExc6h9T
         W+SlsYpXdaKtCZVHTOs9aCTR3IOXEhRLwOQ66cHdaRwbzK1xRzOURpbxcE94eKEa2SkK
         J6KYeovyOLDNNtQtAEpNaD6QiOMGqw2NGbb6i1aOy5a0g+y9aICclnJSty84hZzVEUUI
         VIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwfVBZK6jVsKk1HZotg7tdTTIeKjMtEQvCPgV7klkk8=;
        b=t2nYIgKz0ebFQRlsKxFpFde1M1UtzyEunT/yy84/KNuaPqfZMrObHfA3dQDPVcLARo
         eyuvb2JwNtbjPDFCm9Raid3N6oXPeG6W4hZdKI7DsqS28wOOp1DRmvsvdbCjUJL23paG
         kf/vFK+iUsSAuxQSAJWglDDOAYHggl7cWuuM76msmfL695bfLofqK1yKIyztnD+0CnWA
         +gyvmgl1CPahNV4nIFMXGuzDrqeH7MZDViY53Qg534eBMOP5o5hRdiZt9Jp49dK8UHwg
         e5LHs87hVFqqZiufg9Yq3EFb5HZbm5MYLinlgdMBH9dNo+ki9R8+EzPxOwbOVZwA6Aaa
         ycKw==
X-Gm-Message-State: APt69E35kD2FSwqbD8mU7FY85CibwnjzD3SQXlmjD0OIlOh+8EUaHcKJ
        rk6KjiFiSlBkA0gV86RguNfUBQ==
X-Google-Smtp-Source: ADUXVKJJgV1enZ6MbYHXYqs+sYstPHw2Lavba3hFeMNeJahtAA3HGUT7ytMx3APqdhz/c3LaudyiNw==
X-Received: by 2002:a2e:5f1a:: with SMTP id t26-v6mr3112135ljb.0.1529127729321;
        Fri, 15 Jun 2018 22:42:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/15] merge-recursive.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:50 +0200
Message-Id: <20180616054157.32433-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 merge-recursive.c | 65 ++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5eb907f46e..2a9dfe3b33 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -319,7 +319,7 @@ static int add_cacheinfo(struct merge_options *o,
 	if (!ce)
 		return err(o, _("add_cacheinfo failed for path '%s'; merge aborting."), path);
 
-	ret = add_cache_entry(ce, options);
+	ret = add_index_entry(&the_index, ce, options);
 	if (refresh) {
 		struct cache_entry *nce;
 
@@ -327,7 +327,7 @@ static int add_cacheinfo(struct merge_options *o,
 		if (!nce)
 			return err(o, _("add_cacheinfo failed to refresh for path '%s'; merge aborting."), path);
 		if (nce != ce)
-			ret = add_cache_entry(nce, options);
+			ret = add_index_entry(&the_index, nce, options);
 	}
 	return ret;
 }
@@ -365,7 +365,7 @@ static int unpack_trees_start(struct merge_options *o,
 	init_tree_desc_from_tree(t+2, merge);
 
 	rc = unpack_trees(3, t, &o->unpack_opts);
-	cache_tree_free(&active_cache_tree);
+	cache_tree_free(&the_index.cache_tree);
 
 	/*
 	 * Update the_index to match the new results, AFTER saving a copy
@@ -390,11 +390,11 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 {
 	struct tree *result = NULL;
 
-	if (unmerged_cache()) {
+	if (unmerged_index(&the_index)) {
 		int i;
 		fprintf(stderr, "BUG: There are unmerged index entries:\n");
-		for (i = 0; i < active_nr; i++) {
-			const struct cache_entry *ce = active_cache[i];
+		for (i = 0; i < the_index.cache_nr; i++) {
+			const struct cache_entry *ce = the_index.cache[i];
 			if (ce_stage(ce))
 				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
 					(int)ce_namelen(ce), ce->name);
@@ -402,16 +402,16 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		BUG("unmerged index entries in merge-recursive.c");
 	}
 
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
+	if (!the_index.cache_tree)
+		the_index.cache_tree = cache_tree();
 
-	if (!cache_tree_fully_valid(active_cache_tree) &&
+	if (!cache_tree_fully_valid(the_index.cache_tree) &&
 	    cache_tree_update(&the_index, 0) < 0) {
 		err(o, _("error building trees"));
 		return NULL;
 	}
 
-	result = lookup_tree(&active_cache_tree->oid);
+	result = lookup_tree(&the_index.cache_tree->oid);
 
 	return result;
 }
@@ -488,10 +488,10 @@ static struct string_list *get_unmerged(void)
 
 	unmerged->strdup_strings = 1;
 
-	for (i = 0; i < active_nr; i++) {
+	for (i = 0; i < the_index.cache_nr; i++) {
 		struct string_list_item *item;
 		struct stage_data *e;
-		const struct cache_entry *ce = active_cache[i];
+		const struct cache_entry *ce = the_index.cache[i];
 		if (!ce_stage(ce))
 			continue;
 
@@ -651,7 +651,7 @@ static int update_stages(struct merge_options *opt, const char *path,
 	int clear = 1;
 	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
 	if (clear)
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(&the_index, path))
 			return -1;
 	if (o)
 		if (add_cacheinfo(opt, o->mode, &o->oid, path, 1, 0, options))
@@ -707,13 +707,14 @@ static int remove_file(struct merge_options *o, int clean,
 	int update_working_directory = !o->call_depth && !no_wd;
 
 	if (update_cache) {
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(&the_index, path))
 			return -1;
 	}
 	if (update_working_directory) {
 		if (ignore_case) {
 			struct cache_entry *ce;
-			ce = cache_file_exists(path, strlen(path), ignore_case);
+			ce = index_file_exists(&the_index, path, strlen(path),
+					       ignore_case);
 			if (ce && ce_stage(ce) == 0 && strcmp(path, ce->name))
 				return 0;
 		}
@@ -772,12 +773,12 @@ static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
 	strbuf_addstr(&dirpath, path);
 	strbuf_addch(&dirpath, '/');
 
-	pos = cache_name_pos(dirpath.buf, dirpath.len);
+	pos = index_name_pos(&the_index, dirpath.buf, dirpath.len);
 
 	if (pos < 0)
 		pos = -1 - pos;
-	if (pos < active_nr &&
-	    !strncmp(dirpath.buf, active_cache[pos]->name, dirpath.len)) {
+	if (pos < the_index.cache_nr &&
+	    !strncmp(dirpath.buf, the_index.cache[pos]->name, dirpath.len)) {
 		strbuf_release(&dirpath);
 		return 1;
 	}
@@ -839,19 +840,19 @@ static int would_lose_untracked(const char *path)
 	 * update_file()/would_lose_untracked(); see every comment in this
 	 * file which mentions "update_stages".
 	 */
-	int pos = cache_name_pos(path, strlen(path));
+	int pos = index_name_pos(&the_index, path, strlen(path));
 
 	if (pos < 0)
 		pos = -1 - pos;
-	while (pos < active_nr &&
-	       !strcmp(path, active_cache[pos]->name)) {
+	while (pos < the_index.cache_nr &&
+	       !strcmp(path, the_index.cache[pos]->name)) {
 		/*
 		 * If stage #0, it is definitely tracked.
 		 * If it has stage #2 then it was tracked
 		 * before this merge started.  All other
 		 * cases the path was not tracked.
 		 */
-		switch (ce_stage(active_cache[pos])) {
+		switch (ce_stage(the_index.cache[pos])) {
 		case 0:
 		case 2:
 			return 0;
@@ -1466,7 +1467,7 @@ static int handle_change_delete(struct merge_options *o,
 		 * correct; since there is no true "middle point" between
 		 * them, simply reuse the base version for virtual merge base.
 		 */
-		ret = remove_file_from_cache(path);
+		ret = remove_file_from_index(&the_index, path);
 		if (!ret)
 			ret = update_file(o, 0, o_oid, o_mode, update_path);
 	} else {
@@ -1527,7 +1528,7 @@ static int conflict_rename_delete(struct merge_options *o,
 		return -1;
 
 	if (o->call_depth)
-		return remove_file_from_cache(dest->path);
+		return remove_file_from_index(&the_index, dest->path);
 	else
 		return update_stages(o, dest->path, NULL,
 				     rename_branch == o->branch1 ? dest : NULL,
@@ -1662,14 +1663,14 @@ static int conflict_rename_rename_1to2(struct merge_options *o,
 				return -1;
 		}
 		else
-			remove_file_from_cache(a->path);
+			remove_file_from_index(&the_index, a->path);
 		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
 		if (add) {
 			if (update_file(o, 0, &add->oid, add->mode, b->path))
 				return -1;
 		}
 		else
-			remove_file_from_cache(b->path);
+			remove_file_from_index(&the_index, b->path);
 	} else if (handle_file(o, a, 2, ci) || handle_file(o, b, 3, ci))
 		return -1;
 
@@ -3063,7 +3064,7 @@ static int merge_content(struct merge_options *o,
 	if (df_conflict_remains || is_dirty) {
 		char *new_path;
 		if (o->call_depth) {
-			remove_file_from_cache(path);
+			remove_file_from_index(&the_index, path);
 		} else {
 			if (!mfi.clean) {
 				if (update_stages(o, path, &one, &a, &b))
@@ -3220,7 +3221,7 @@ static int process_entry(struct merge_options *o,
 			if (update_file(o, 0, oid, mode, new_path))
 				clean_merge = -1;
 			else if (o->call_depth)
-				remove_file_from_cache(path);
+				remove_file_from_index(&the_index, path);
 			free(new_path);
 		} else {
 			output(o, 2, _("Adding %s"), path);
@@ -3284,7 +3285,7 @@ int merge_trees(struct merge_options *o,
 		return -1;
 	}
 
-	if (unmerged_cache()) {
+	if (unmerged_index(&the_index)) {
 		struct string_list *entries;
 		struct rename_info re_info;
 		int i;
@@ -3415,7 +3416,7 @@ int merge_recursive(struct merge_options *o,
 		 * overwritten it: the committed "conflicts" were
 		 * already resolved.
 		 */
-		discard_cache();
+		discard_index(&the_index);
 		saved_b1 = o->branch1;
 		saved_b2 = o->branch2;
 		o->branch1 = "Temporary merge branch 1";
@@ -3431,9 +3432,9 @@ int merge_recursive(struct merge_options *o,
 			return err(o, _("merge returned no commit"));
 	}
 
-	discard_cache();
+	discard_index(&the_index);
 	if (!o->call_depth)
-		read_cache();
+		read_index(&the_index);
 
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, get_commit_tree(h1), get_commit_tree(h2),
-- 
2.18.0.rc0.333.g22e6ee6cdf

