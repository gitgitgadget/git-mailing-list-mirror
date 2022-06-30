Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C775C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 06:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiF3G5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiF3G5M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 02:57:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40A933A0E
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:57:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so619695wmc.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dzbgH2fkEQLvQv/d+UVZR3HXjYpl1DPaz4Io7ofjcbk=;
        b=IlQwVqR/WD4T6Yfh4uxnHwt6riU2zqy8jaVzHIAe61a2qdY1yBoAk9aFS/58GYfZxe
         j6EL/AwHXo4SDYTKBHDMp4pwE7Sfqe9m3RwqhE93UrW9f0CQGZKdHJROLHphqTVj1/TI
         hh5eIZZye+wbzG2eJkIkDv/K9zx9iUoZuxYae51fTNA+t0uXzu6IaOfELn3OlXu9thtQ
         oWy8co0Qa2eJhRn1W+Au889YjZF0fD4LSVdJXyvQpJ4rRTHLcSxo7K5xjNQ7QtxnLglv
         Cwy8qhUdcpK+EJbC/ilxKFjbPuFdPIkvdnripzKsdzGg545JBlFlcwRIhIJNWBj8wNif
         sa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dzbgH2fkEQLvQv/d+UVZR3HXjYpl1DPaz4Io7ofjcbk=;
        b=6Xkd+T5kjqLEElLL22P0gdjcsRJWXT5RsLOnVksbkcZCcg6nwiQ1rnvCGaXkox5hDb
         snWg41OIFL28NDqOkwXUGr4pdr35wByu59yVbtxp/alCI8aazQXEdpxKPzj3Q95ajeCs
         1F1e3fvswlNKrRpGev3f9FMpSSWXLWIZMLc/5yyGRJoUcslJF9FSPgOtJHEE7/BJtdTw
         +TJoY48UBPhKqgko/mE1DDz9SaUw6bUjsIzYYPARGCqMpL1C6GHbBOSqEyh+vYYgf73v
         KAUz+DiLap1lKaENeOtlnakngFnU9yrcI+1Ff5OYyHgr3jrEHYOimQt1jzAAV66M4A6I
         6jkA==
X-Gm-Message-State: AJIora/UPf0/ObewOecxwxZcSb6xBZip4C3l/7T6iE5jQnIEf0GtL1Pa
        oXhkwooQYheElilNVcv0Ip5q+n+m3r3/Kw==
X-Google-Smtp-Source: AGRyM1umOeYN6fceliUuy6puINuH0x749kOqZQoIi0Elg6hnNq1KJHCiQh3FEBvz66g9yaOiDsUqBg==
X-Received: by 2002:a05:600c:5014:b0:3a0:4867:d234 with SMTP id n20-20020a05600c501400b003a04867d234mr7940151wmr.35.1656572230088;
        Wed, 29 Jun 2022 23:57:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d4bc1000000b00219e77e489fsm18126392wrt.17.2022.06.29.23.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 23:57:09 -0700 (PDT)
Message-Id: <cfa38f01481d6a13a676e250e8254182733e0dd1.1656572226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
        <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 06:57:04 +0000
Subject: [PATCH v2 2/3] merge-ort: shuffle the computation and cleanup of
 potential collisions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Run compute_collisions() for renames on both sides of history before
any calls to collect_renames(), and do not free the computed collisions
until after both calls to collect_renames().  This is just a code
reorganization at this point that doesn't make sense on its own, but
will permit us to use the computed collision info from both sides
within each call to collect_renames() in a subsequent commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 56 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8545354dafd..fa6667de18c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2259,6 +2259,27 @@ static void compute_collisions(struct strmap *collisions,
 	}
 }
 
+static void free_collisions(struct strmap *collisions)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	/* Free each value in the collisions map */
+	strmap_for_each_entry(collisions, &iter, entry) {
+		struct collision_info *info = entry->value;
+		string_list_clear(&info->source_files, 0);
+	}
+	/*
+	 * In compute_collisions(), we set collisions.strdup_strings to 0
+	 * so that we wouldn't have to make another copy of the new_path
+	 * allocated by apply_dir_rename().  But now that we've used them
+	 * and have no other references to these strings, it is time to
+	 * deallocate them.
+	 */
+	free_strmap_strings(collisions);
+	strmap_clear(collisions, 1);
+}
+
 static char *check_for_directory_rename(struct merge_options *opt,
 					const char *path,
 					unsigned side_index,
@@ -2314,7 +2335,8 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	}
 
 	new_path = handle_path_level_conflicts(opt, path, side_index,
-					       rename_info, collisions);
+					       rename_info,
+					       &collisions[side_index]);
 	*clean_merge &= (new_path != NULL);
 
 	return new_path;
@@ -3023,18 +3045,15 @@ static int detect_regular_renames(struct merge_options *opt,
 static int collect_renames(struct merge_options *opt,
 			   struct diff_queue_struct *result,
 			   unsigned side_index,
+			   struct strmap *collisions,
 			   struct strmap *dir_renames_for_side,
 			   struct strmap *rename_exclusions)
 {
 	int i, clean = 1;
-	struct strmap collisions;
 	struct diff_queue_struct *side_pairs;
-	struct hashmap_iter iter;
-	struct strmap_entry *entry;
 	struct rename_info *renames = &opt->priv->renames;
 
 	side_pairs = &renames->pairs[side_index];
-	compute_collisions(&collisions, dir_renames_for_side, side_pairs);
 
 	for (i = 0; i < side_pairs->nr; ++i) {
 		struct diff_filepair *p = side_pairs->queue[i];
@@ -3050,7 +3069,7 @@ static int collect_renames(struct merge_options *opt,
 						      side_index,
 						      dir_renames_for_side,
 						      rename_exclusions,
-						      &collisions,
+						      collisions,
 						      &clean);
 
 		possibly_cache_new_pair(renames, p, side_index, new_path);
@@ -3076,20 +3095,6 @@ static int collect_renames(struct merge_options *opt,
 		result->queue[result->nr++] = p;
 	}
 
-	/* Free each value in the collisions map */
-	strmap_for_each_entry(&collisions, &iter, entry) {
-		struct collision_info *info = entry->value;
-		string_list_clear(&info->source_files, 0);
-	}
-	/*
-	 * In compute_collisions(), we set collisions.strdup_strings to 0
-	 * so that we wouldn't have to make another copy of the new_path
-	 * allocated by apply_dir_rename().  But now that we've used them
-	 * and have no other references to these strings, it is time to
-	 * deallocate them.
-	 */
-	free_strmap_strings(&collisions);
-	strmap_clear(&collisions, 1);
 	return clean;
 }
 
@@ -3100,6 +3105,7 @@ static int detect_and_process_renames(struct merge_options *opt,
 {
 	struct diff_queue_struct combined = { 0 };
 	struct rename_info *renames = &opt->priv->renames;
+	struct strmap collisions[3];
 	int need_dir_renames, s, i, clean = 1;
 	unsigned detection_run = 0;
 
@@ -3149,12 +3155,22 @@ static int detect_and_process_renames(struct merge_options *opt,
 	ALLOC_GROW(combined.queue,
 		   renames->pairs[1].nr + renames->pairs[2].nr,
 		   combined.alloc);
+	for (int i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
+		int other_side = 3 - i;
+		compute_collisions(&collisions[i],
+				   &renames->dir_renames[other_side],
+				   &renames->pairs[i]);
+	}
 	clean &= collect_renames(opt, &combined, MERGE_SIDE1,
+				 collisions,
 				 &renames->dir_renames[2],
 				 &renames->dir_renames[1]);
 	clean &= collect_renames(opt, &combined, MERGE_SIDE2,
+				 collisions,
 				 &renames->dir_renames[1],
 				 &renames->dir_renames[2]);
+	for (int i = MERGE_SIDE1; i <= MERGE_SIDE2; i++)
+		free_collisions(&collisions[i]);
 	STABLE_QSORT(combined.queue, combined.nr, compare_pairs);
 	trace2_region_leave("merge", "directory renames", opt->repo);
 
-- 
gitgitgadget

