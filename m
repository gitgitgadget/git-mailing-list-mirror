Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF2BC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 21:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiIZVz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiIZVzy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 17:55:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936BEA2A9B
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 14:55:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l18so247285wrw.9
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Hx0DeMJZrpjxIuKtpeH2ucs/687NLDZmuCNf3D0Rz6A=;
        b=TrP7smeH+55pInl4vqese5nM1fix3wFlB1PhGUu2Ryexe+//R8JklGgVATkSh05YQk
         QCGOIzzxv31okn+p0b5b84jGpMJwyD5FcfNzbr6lKrHhnbwTSH3Xeew06BCPwEX2Zkb4
         L2GNNBHElmjFkexFuAg+cUNhpBTFmsc5Hvvb6TMML1nN2RRFmm7tVDo3zf6lHNy2rd6V
         /nhcYa7+pwcIGBUySYgpkKC0Z9lGgIlNDupJCTfcz6hfias7uaCFwTvJZXMPTlPeyejM
         lEV+mImZM8P/PErt6RkSkQ89uC10Y/tFeTM1d1KR6o3spWRGUyP8R+WAFu3Ji6Iy4iAd
         +Tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hx0DeMJZrpjxIuKtpeH2ucs/687NLDZmuCNf3D0Rz6A=;
        b=yPVTRTOI7jHOmZe+eDyNBJNSNQLj8KZFe3a+i9qL5XTMmmSkMWkxAIx6hOYkuJ6B9z
         gpnr10zF3zQT5F+lAdxjazdCSXyuDMOg84jxmGVvtG7OKSGqYMH1uf/y1wz+xZHbdmVd
         PocrOm+3j51Czi5WozShwgEGn54ivL4spdPZyv+h+YEAhjMynFFvo5Ux/sAVyKOTz2PH
         zuNfD0fCCk+v7EBH66gMG3p3OTD9jYm301iZVETtUUflrNqP1NVljJ50pc1XJHth7HsC
         iOIx+yMh5nLe1lDw7D04tizozBMEODHlJqkcM0wW5dX873RoBqUqg/ERoZIjPKktnGl5
         k9Cw==
X-Gm-Message-State: ACrzQf0l3wmMC1HBX2dCm/Ogo7IYS3D4uyWLWnY2cXMakhea004ojOO4
        dWFAakoTaGoQP5z7Bau4qq6RmfGd038=
X-Google-Smtp-Source: AMsMyM5Vacq/E61TNUo2PqmhW11L6JZfXvdAfZkIAD+diq3IpgH569S5ALFGKN/TfsaZb+YjMpD4WA==
X-Received: by 2002:a05:6000:1241:b0:226:d999:a2df with SMTP id j1-20020a056000124100b00226d999a2dfmr14441673wrx.19.1664229351952;
        Mon, 26 Sep 2022 14:55:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020adfe34d000000b002285f73f11dsm18536861wrj.81.2022.09.26.14.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:55:51 -0700 (PDT)
Message-Id: <087207ae0b0932fcec9aa25e97bbe9227eff81cb.1664229348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
References: <pull.1362.v3.git.1663875999939.gitgitgadget@gmail.com>
        <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 21:55:48 +0000
Subject: [PATCH v4 2/2] merge-ort: return early when failing to write a blob
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

Since we will always write out a new tree object in addition to the blob
(and if the blob did not exist in the database yet, we can be certain
that the tree object did not exist yet), the merge will _still_ fail at
that point, but it does unnecessary work by continuing after the blob
could not be written.

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

Note: This patch adjusts two variable declarations from `unsigned` to
`int` because their purpose is to hold the return value of
`handle_content_merge()`, which is of type `int`. The existing users of
those variables are only interested whether that variable is zero or
non-zero, therefore this type change does not affect the existing code.

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
