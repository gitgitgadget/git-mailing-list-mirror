Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586A3C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 07:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiI1Hrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 03:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiI1Hra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 03:47:30 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D91B913E
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 00:44:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id rk17so12143943ejb.1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=9AntiJsr8eSt6Ew1m0l/SVmzWAM5AiB1shIKnslJxzA=;
        b=UO8H5GHfAkhif7hOihjOqWrEY6htBLsWBoMQYkT4rysMYMq2mtPv5XH5vtzB5T9qcW
         GGQQXi3G8kLCQmzadOIv56FUeZN/7kzjPCMF7fcl8oSQlhbj1AG5ZZC/W3pjj4IUfufg
         COH+R9vaMItQlmVChe3qz9r6RUN206qYkU1mmTv4LGUK+qBFznVBlNxbxCN4wzEDEWfD
         qK85VMW5zJGbtYWLPQ9YJ0yywn4zrwFxraaR7V//CxmkrB6yOe4uxZSgJK2k/tvEdOd7
         F7jyepD8wEbOz34WLJiEpXSrV0VTmuWS4wHdH5kud5k6vWqKUH1qoDUgeQfD/nKtc6+/
         NRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9AntiJsr8eSt6Ew1m0l/SVmzWAM5AiB1shIKnslJxzA=;
        b=sMA6xjimTHtYmXy2jv7+RywxH0CIUs+HcxGJgQR7OQpaJl4UMSW4EybtEJbLkQXIp2
         4fLamCFLBlDscA0JDHXzhf+D4ZgB72lEZEb2q4KUPy9urzXqP4Rl7TSapMzd9RG21hHD
         IfJRfkYdNWD07CIPghkja9IiFR6RgNDpwDf+nAazZgHOXwoGVAOlyOng9jqsghsVQWxs
         aY5HBERDStWkoGMZ3d4Z21KirmKdI3Kfobrs4pKgiQ4GByuWKZCpvNxxzwLmG4DqiLuI
         x0Q6JVB+yma3/3YnxXEKmxSCN3x1VpzK/id0bjbhB6kBP73btFL2lDYJ5hbsdckvVsOD
         5e7A==
X-Gm-Message-State: ACrzQf0W7z1yHHOzSPIjl7oq/Neq3pliFEK9DqQ5tbnwbz0JJUJhR7Gp
        j8ncu8FWsRaDoo4LLxbVrHjVAyXx4uM=
X-Google-Smtp-Source: AMsMyM48W2qrQF/wK54Duyxhz3wQkVOxwpakL/lnwi1GAVudaUw7a0/0zNa9rfCIDTPFrnb+SNAkEQ==
X-Received: by 2002:a5d:6a04:0:b0:22c:c250:7222 with SMTP id m4-20020a5d6a04000000b0022cc2507222mr4006391wru.352.1664350165319;
        Wed, 28 Sep 2022 00:29:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d6289000000b00226dfac0149sm3378124wru.114.2022.09.28.00.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 00:29:24 -0700 (PDT)
Message-Id: <bfc71a2d8adfbf9b899a47d469fe2343e4703ff7.1664350162.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.v5.git.1664350162.gitgitgadget@gmail.com>
References: <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
        <pull.1362.v5.git.1664350162.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 07:29:22 +0000
Subject: [PATCH v5 2/2] merge-ort: return early when failing to write a blob
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the previous commit, we fixed a segmentation fault when a tree object
could not be written.

However, before the tree object is written, `merge-ort` wants to write
out a blob object (except in cases where the merge results in a blob
that already exists in the database). And this can fail, too, but we
ignore that write failure so far.

Let's pay close attention and error out early if the blob could not be
written. This reduces the error output of t4301.25 ("merge-ort fails
gracefully in a read-only repository") from:

	error: insufficient permission for adding an object to repository database ./objects
	error: error: Unable to add numbers to database
	error: insufficient permission for adding an object to repository database ./objects
	error: error: Unable to add greeting to database
	error: insufficient permission for adding an object to repository database ./objects
	fatal: failure to merge

to:

	error: insufficient permission for adding an object to repository database ./objects
	error: error: Unable to add numbers to database
	fatal: failure to merge

This is _not_ just a cosmetic change: Even though one might assume that
the operation would have failed anyway at the point when the new tree
object is written (and the corresponding tree object _will_ be new if it
contains a blob that is new), but that is not so: As pointed out by
Elijah Newren, when Git has previously been allowed to add loose objects
via `sudo` calls, it is very possible that the blob object cannot be
written (because the corresponding `.git/objects/??/` directory may be
owned by `root`) but the tree object can be written (because the
corresponding objects directory is owned by the current user). This
would result in a corrupt repository because it is missing the blob
object, and with this here patch we prevent that.

Note: This patch adjusts two variable declarations from `unsigned` to
`int` because their purpose is to hold the return value of
`handle_content_merge()`, which is of type `int`. The existing users of
those variables are only interested whether that variable is zero or
non-zero, therefore this type change does not affect the existing code.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index f3bdce1041a..e5f41cce481 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2807,6 +2807,8 @@ static int process_renames(struct merge_options *opt,
 							   pathnames,
 							   1 + 2 * opt->priv->call_depth,
 							   &merged);
+			if (clean_merge < 0)
+				return -1;
 			if (!clean_merge &&
 			    merged.mode == side1->stages[1].mode &&
 			    oideq(&merged.oid, &side1->stages[1].oid))
@@ -2916,7 +2918,7 @@ static int process_renames(struct merge_options *opt,
 			struct version_info merged;
 
 			struct conflict_info *base, *side1, *side2;
-			unsigned clean;
+			int clean;
 
 			pathnames[0] = oldpath;
 			pathnames[other_source_index] = oldpath;
@@ -2937,6 +2939,8 @@ static int process_renames(struct merge_options *opt,
 						     pathnames,
 						     1 + 2 * opt->priv->call_depth,
 						     &merged);
+			if (clean < 0)
+				return -1;
 
 			memcpy(&newinfo->stages[target_index], &merged,
 			       sizeof(merged));
@@ -3806,10 +3810,10 @@ static int write_completed_directory(struct merge_options *opt,
 }
 
 /* Per entry merge function */
-static void process_entry(struct merge_options *opt,
-			  const char *path,
-			  struct conflict_info *ci,
-			  struct directory_versions *dir_metadata)
+static int process_entry(struct merge_options *opt,
+			 const char *path,
+			 struct conflict_info *ci,
+			 struct directory_versions *dir_metadata)
 {
 	int df_file_index = 0;
 
@@ -3823,7 +3827,7 @@ static void process_entry(struct merge_options *opt,
 		record_entry_for_tree(dir_metadata, path, &ci->merged);
 		if (ci->filemask == 0)
 			/* nothing else to handle */
-			return;
+			return 0;
 		assert(ci->df_conflict);
 	}
 
@@ -3870,7 +3874,7 @@ static void process_entry(struct merge_options *opt,
 		 */
 		if (ci->filemask == 1) {
 			ci->filemask = 0;
-			return;
+			return 0;
 		}
 
 		/*
@@ -4065,7 +4069,7 @@ static void process_entry(struct merge_options *opt,
 	} else if (ci->filemask >= 6) {
 		/* Need a two-way or three-way content merge */
 		struct version_info merged_file;
-		unsigned clean_merge;
+		int clean_merge;
 		struct version_info *o = &ci->stages[0];
 		struct version_info *a = &ci->stages[1];
 		struct version_info *b = &ci->stages[2];
@@ -4074,6 +4078,8 @@ static void process_entry(struct merge_options *opt,
 						   ci->pathnames,
 						   opt->priv->call_depth * 2,
 						   &merged_file);
+		if (clean_merge < 0)
+			return -1;
 		ci->merged.clean = clean_merge &&
 				   !ci->df_conflict && !ci->path_conflict;
 		ci->merged.result.mode = merged_file.mode;
@@ -4169,6 +4175,7 @@ static void process_entry(struct merge_options *opt,
 
 	/* Record metadata for ci->merged in dir_metadata */
 	record_entry_for_tree(dir_metadata, path, &ci->merged);
+	return 0;
 }
 
 static void prefetch_for_content_merges(struct merge_options *opt,
@@ -4285,7 +4292,10 @@ static int process_entries(struct merge_options *opt,
 			record_entry_for_tree(&dir_metadata, path, mi);
 		else {
 			struct conflict_info *ci = (struct conflict_info *)mi;
-			process_entry(opt, path, ci, &dir_metadata);
+			if (process_entry(opt, path, ci, &dir_metadata) < 0) {
+				ret = -1;
+				goto cleanup;
+			};
 		}
 	}
 	trace2_region_leave("merge", "processing", opt->repo);
-- 
gitgitgadget
