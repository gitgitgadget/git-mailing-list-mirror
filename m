Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D791C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 07:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiI1Hcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 03:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiI1Hcf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 03:32:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57185EFA5B
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 00:32:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n10so18308748wrw.12
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 00:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=wmSPguGfh16smsrEzrkjJELpZVfshIOBQN3IelcR7kM=;
        b=Vo+XZ7SmlHsbowcwlrvSpZnlwxgH4zy/vaqOFHcFEC7MgUEqpcsi2hpVuv+W5Tdovy
         EEThjrs6JoMNF0u0wBjfeezGFhPUAQY48Pes2L9RhFfigW1Yx1HB6Dz/4p4rr4uRVhXA
         adLebL3fYM2jySM7f+uIbnw0Oimb9Du4WE7p80qeV8pnf1kRJKI492LO3eqBpMafucpN
         EZYDPFEKqW5b27VkWfZAIrL8fXJJ5rQK9QsQqSGJwqQ6z7HosXGRsX/564novigB5o6I
         266GF5NGYAZdiTKKIu6r6QHJH+CN0Eam1iyElWxYY2OtR4snbe9+8TAsFF1yNuVpfnoB
         HiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wmSPguGfh16smsrEzrkjJELpZVfshIOBQN3IelcR7kM=;
        b=js2p0hE/YJeCW2nPxkA6EKO1wUl/uu29aB38PLHjOUpTnX/qj+Q20KY2y7dWa8PPZX
         yCoixHkcw+vJFRGZDCf4oy7fG0RD/kr87D5Gp7am3CgApuOvxa1ATrbZCU1sWFHOt/1n
         y0OuEoMV86dvgtTkd7RZId1WbaH5nb6E9OBIutZUNSGDQ8o8EvKVDc5wDjYNHvRR494q
         Jwv2HQOTDbp8tij91IniE4KblWXE18JsjLwIxhX8mulUNOhsNhe2KNOJWj8Nq3XzOJG7
         TQ2rtG2R17KP/Y2OdhmhCzEFO8bTCPBxSq4HCvTUAwnINeRBuZ2KsrCKUnq0BTHvnyhB
         eaFQ==
X-Gm-Message-State: ACrzQf2xA6+pyGvfGMdeJLV83MX3PumHOw8tcAnVvIig0CZ6oRH06vy6
        2iKKRfiBrax3/DhhRt5mms2J/t7NFq8=
X-Google-Smtp-Source: AMsMyM5rw6LnrpRuk6dJ4GuTI+z3k/PVFW+zFOppezfoN4dtVR3u9lCw/yXfz4Wb0s42kSfFQ9QxgA==
X-Received: by 2002:a05:6000:1541:b0:22a:3b77:6ef4 with SMTP id 1-20020a056000154100b0022a3b776ef4mr19427767wry.303.1664350164237;
        Wed, 28 Sep 2022 00:29:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c1d0300b003a62400724bsm1021109wms.0.2022.09.28.00.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 00:29:23 -0700 (PDT)
Message-Id: <63be9f9f7174fb71b3b84c293e299cfaa6a94310.1664350162.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.v5.git.1664350162.gitgitgadget@gmail.com>
References: <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
        <pull.1362.v5.git.1664350162.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 07:29:21 +0000
Subject: [PATCH v5 1/2] merge-ort: fix segmentation fault in read-only
 repositories
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

If the blob/tree objects cannot be written, we really need the merge
operations to fail, and not to continue (and then try to access the tree
object which is however still set to `NULL`).

Let's stop ignoring the return value of `write_object_file()` and
`write_tree()` and set `clean = -1` in the error case.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c                      | 66 ++++++++++++++++++++------------
 t/t4301-merge-tree-write-tree.sh |  9 +++++
 2 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 99dcee2db8a..f3bdce1041a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3571,15 +3571,15 @@ static int tree_entry_order(const void *a_, const void *b_)
 				 b->string, strlen(b->string), bmi->result.mode);
 }
 
-static void write_tree(struct object_id *result_oid,
-		       struct string_list *versions,
-		       unsigned int offset,
-		       size_t hash_size)
+static int write_tree(struct object_id *result_oid,
+		      struct string_list *versions,
+		      unsigned int offset,
+		      size_t hash_size)
 {
 	size_t maxlen = 0, extra;
 	unsigned int nr;
 	struct strbuf buf = STRBUF_INIT;
-	int i;
+	int i, ret = 0;
 
 	assert(offset <= versions->nr);
 	nr = versions->nr - offset;
@@ -3605,8 +3605,10 @@ static void write_tree(struct object_id *result_oid,
 	}
 
 	/* Write this object file out, and record in result_oid */
-	write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
+	if (write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid))
+		ret = -1;
 	strbuf_release(&buf);
+	return ret;
 }
 
 static void record_entry_for_tree(struct directory_versions *dir_metadata,
@@ -3625,13 +3627,13 @@ static void record_entry_for_tree(struct directory_versions *dir_metadata,
 			   basename)->util = &mi->result;
 }
 
-static void write_completed_directory(struct merge_options *opt,
-				      const char *new_directory_name,
-				      struct directory_versions *info)
+static int write_completed_directory(struct merge_options *opt,
+				     const char *new_directory_name,
+				     struct directory_versions *info)
 {
 	const char *prev_dir;
 	struct merged_info *dir_info = NULL;
-	unsigned int offset;
+	unsigned int offset, ret = 0;
 
 	/*
 	 * Some explanation of info->versions and info->offsets...
@@ -3717,7 +3719,7 @@ static void write_completed_directory(struct merge_options *opt,
 	 * strcmp here.)
 	 */
 	if (new_directory_name == info->last_directory)
-		return;
+		return 0;
 
 	/*
 	 * If we are just starting (last_directory is NULL), or last_directory
@@ -3739,7 +3741,7 @@ static void write_completed_directory(struct merge_options *opt,
 		 */
 		string_list_append(&info->offsets,
 				   info->last_directory)->util = (void*)offset;
-		return;
+		return 0;
 	}
 
 	/*
@@ -3769,8 +3771,9 @@ static void write_completed_directory(struct merge_options *opt,
 		 */
 		dir_info->is_null = 0;
 		dir_info->result.mode = S_IFDIR;
-		write_tree(&dir_info->result.oid, &info->versions, offset,
-			   opt->repo->hash_algo->rawsz);
+		if (write_tree(&dir_info->result.oid, &info->versions, offset,
+			       opt->repo->hash_algo->rawsz) < 0)
+			ret = -1;
 	}
 
 	/*
@@ -3798,6 +3801,8 @@ static void write_completed_directory(struct merge_options *opt,
 	/* And, of course, we need to update last_directory to match. */
 	info->last_directory = new_directory_name;
 	info->last_directory_len = strlen(info->last_directory);
+
+	return ret;
 }
 
 /* Per entry merge function */
@@ -4214,8 +4219,8 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 	oid_array_clear(&to_fetch);
 }
 
-static void process_entries(struct merge_options *opt,
-			    struct object_id *result_oid)
+static int process_entries(struct merge_options *opt,
+			   struct object_id *result_oid)
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
@@ -4224,11 +4229,12 @@ static void process_entries(struct merge_options *opt,
 	struct directory_versions dir_metadata = { STRING_LIST_INIT_NODUP,
 						   STRING_LIST_INIT_NODUP,
 						   NULL, 0 };
+	int ret = 0;
 
 	trace2_region_enter("merge", "process_entries setup", opt->repo);
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
-		return;
+		return 0;
 	}
 
 	/* Hack to pre-allocate plist to the desired size */
@@ -4270,8 +4276,11 @@ static void process_entries(struct merge_options *opt,
 		 */
 		struct merged_info *mi = entry->util;
 
-		write_completed_directory(opt, mi->directory_name,
-					  &dir_metadata);
+		if (write_completed_directory(opt, mi->directory_name,
+					      &dir_metadata) < 0) {
+			ret = -1;
+			goto cleanup;
+		}
 		if (mi->clean)
 			record_entry_for_tree(&dir_metadata, path, mi);
 		else {
@@ -4291,12 +4300,16 @@ static void process_entries(struct merge_options *opt,
 		fflush(stdout);
 		BUG("dir_metadata accounting completely off; shouldn't happen");
 	}
-	write_tree(result_oid, &dir_metadata.versions, 0,
-		   opt->repo->hash_algo->rawsz);
+	if (write_tree(result_oid, &dir_metadata.versions, 0,
+		       opt->repo->hash_algo->rawsz) < 0)
+		ret = -1;
+cleanup:
 	string_list_clear(&plist, 0);
 	string_list_clear(&dir_metadata.versions, 0);
 	string_list_clear(&dir_metadata.offsets, 0);
 	trace2_region_leave("merge", "process_entries cleanup", opt->repo);
+
+	return ret;
 }
 
 /*** Function Grouping: functions related to merge_switch_to_result() ***/
@@ -4928,15 +4941,18 @@ redo:
 	}
 
 	trace2_region_enter("merge", "process_entries", opt->repo);
-	process_entries(opt, &working_tree_oid);
+	if (process_entries(opt, &working_tree_oid) < 0)
+		result->clean = -1;
 	trace2_region_leave("merge", "process_entries", opt->repo);
 
 	/* Set return values */
 	result->path_messages = &opt->priv->conflicts;
 
-	result->tree = parse_tree_indirect(&working_tree_oid);
-	/* existence of conflicted entries implies unclean */
-	result->clean &= strmap_empty(&opt->priv->conflicted);
+	if (result->clean >= 0) {
+		result->tree = parse_tree_indirect(&working_tree_oid);
+		/* existence of conflicted entries implies unclean */
+		result->clean &= strmap_empty(&opt->priv->conflicted);
+	}
 	if (!opt->priv->call_depth) {
 		result->priv = opt->priv;
 		result->_properly_initialized = RESULT_INITIALIZED;
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 28ca5c38bb5..013b77144bd 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -810,4 +810,13 @@ test_expect_success 'can override merge of unrelated histories' '
 	test_cmp expect actual
 '
 
+test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository' '
+	git init --bare read-only &&
+	git push read-only side1 side2 side3 &&
+	test_when_finished "chmod -R u+w read-only" &&
+	chmod -R a-w read-only &&
+	test_must_fail git -C read-only merge-tree side1 side3 &&
+	test_must_fail git -C read-only merge-tree side1 side2
+'
+
 test_done
-- 
gitgitgadget

