Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7F71F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeAEUaJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:30:09 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:35672 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752755AbeAEU2g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:36 -0500
Received: by mail-it0-f67.google.com with SMTP id f143so2991868itb.0
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cQCmO64Xr9rHuaGOD+Uv+YNfH89iAZDuIfjIhJaUxgE=;
        b=mMWFLJzHIch1LRCfKaCvynLhKq7FEfyQGCI36zgjfKDEcNWbN1GqnxRsgfswAKviyX
         bsPX2Vkv35+MTF71nIjqmheyeBZG1gAR9+S+fDf0pj1Zp61NZeWvN27mYy+v+4lLzwxu
         QkA3pQ215nXSVMgOWhJPo//k0qwiqt8iDSSOXmX94unVE1l9ATGcOuuWmGK4XFwfTvda
         TN2Hk3WBuCitWIX9E8VE3CQXaYVIuySSaYGm9/+icAbiuE1pK8H4+8aZh0Q60alt0XCs
         9JQMzayJdG1lzanffZfDwsJNgp8Qz4OT9CmGg1rALgyzT/I2uccou780u7Erganh2mBF
         QcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cQCmO64Xr9rHuaGOD+Uv+YNfH89iAZDuIfjIhJaUxgE=;
        b=gNK3Zu/VxXPOa1YQmrqPHWGks5UTI8iiZWJkwgxDf9DymupHprTnV5ZrEYQs9kAAvG
         gkYBZLcF/3Crukwulhd+5nP6yeLl3qWlJ7T8wbj+4kbgeMxYfqBo5WusWglszgsA3c0Y
         s4OiHiz9fZuquUTUktrqp3s32qGarEG9+hQ1Yg6BcNvVDFh0fPlI5TnoehXAm1DPpAi5
         G+5qPB0LAjeo32oOpdpdHoQdnwMwn8cf4KoIVwMtAsmL2skjz5dXy3QHr+zpe1MSYAMw
         a1u6e5m/T+IAD4xrQ2lFuORS2YCOGz/CqHxn+GIaQGVPxNci784Uy/fyh74iuq8e4f1G
         xy/w==
X-Gm-Message-State: AKGB3mKj3F0aT09mY3+klARBOu00IQKy+roowP/Ivfq0s+/cu2/KQCGW
        /RC3xd7PT17JJXhIq8ARbzFrjHWQ
X-Google-Smtp-Source: ACJfBotFE/SR2FgSVyUN8VTm2p7ruiDIBfEkdnOrBFSZSFlsTwz2YDp+x/4KSa5iq5cJV519v6nvig==
X-Received: by 10.36.0.214 with SMTP id 205mr4242854ita.85.1515184115388;
        Fri, 05 Jan 2018 12:28:35 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:34 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 12/31] merge-recursive: move the get_renames() function
Date:   Fri,  5 Jan 2018 12:26:52 -0800
Message-Id: <20180105202711.24311-13-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to re-use some other functions in the file without moving those
other functions or dealing with a handful of annoying split function
declarations and definitions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 139 +++++++++++++++++++++++++++---------------------------
 1 file changed, 70 insertions(+), 69 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d78853d5e..08bf26b9c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -537,75 +537,6 @@ struct rename {
 	unsigned processed:1;
 };
 
-/*
- * Get information of all renames which occurred between 'o_tree' and
- * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
- * 'b_tree') to be able to associate the correct cache entries with
- * the rename information. 'tree' is always equal to either a_tree or b_tree.
- */
-static struct string_list *get_renames(struct merge_options *o,
-				       struct tree *tree,
-				       struct tree *o_tree,
-				       struct tree *a_tree,
-				       struct tree *b_tree,
-				       struct string_list *entries)
-{
-	int i;
-	struct string_list *renames;
-	struct diff_options opts;
-
-	renames = xcalloc(1, sizeof(struct string_list));
-	if (!o->detect_rename)
-		return renames;
-
-	diff_setup(&opts);
-	opts.flags.recursive = 1;
-	opts.flags.rename_empty = 0;
-	opts.detect_rename = DIFF_DETECT_RENAME;
-	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
-			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
-			    1000;
-	opts.rename_score = o->rename_score;
-	opts.show_rename_progress = o->show_rename_progress;
-	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_setup_done(&opts);
-	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
-	diffcore_std(&opts);
-	if (opts.needed_rename_limit > o->needed_rename_limit)
-		o->needed_rename_limit = opts.needed_rename_limit;
-	for (i = 0; i < diff_queued_diff.nr; ++i) {
-		struct string_list_item *item;
-		struct rename *re;
-		struct diff_filepair *pair = diff_queued_diff.queue[i];
-		if (pair->status != 'R') {
-			diff_free_filepair(pair);
-			continue;
-		}
-		re = xmalloc(sizeof(*re));
-		re->processed = 0;
-		re->pair = pair;
-		item = string_list_lookup(entries, re->pair->one->path);
-		if (!item)
-			re->src_entry = insert_stage_data(re->pair->one->path,
-					o_tree, a_tree, b_tree, entries);
-		else
-			re->src_entry = item->util;
-
-		item = string_list_lookup(entries, re->pair->two->path);
-		if (!item)
-			re->dst_entry = insert_stage_data(re->pair->two->path,
-					o_tree, a_tree, b_tree, entries);
-		else
-			re->dst_entry = item->util;
-		item = string_list_insert(renames, pair->one->path);
-		item->util = re;
-	}
-	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_queued_diff.nr = 0;
-	diff_flush(&opts);
-	return renames;
-}
-
 static int update_stages(struct merge_options *opt, const char *path,
 			 const struct diff_filespec *o,
 			 const struct diff_filespec *a,
@@ -1380,6 +1311,76 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 	return ret;
 }
 
+/*
+ * Get information of all renames which occurred between 'o_tree' and
+ * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
+ * 'b_tree') to be able to associate the correct cache entries with
+ * the rename information. 'tree' is always equal to either a_tree or b_tree.
+ */
+static struct string_list *get_renames(struct merge_options *o,
+				       struct tree *tree,
+				       struct tree *o_tree,
+				       struct tree *a_tree,
+				       struct tree *b_tree,
+				       struct string_list *entries)
+{
+	int i;
+	struct string_list *renames;
+	struct diff_options opts;
+
+	renames = xcalloc(1, sizeof(struct string_list));
+	if (!o->detect_rename)
+		return renames;
+
+	diff_setup(&opts);
+	opts.flags.recursive = 1;
+	opts.flags.rename_empty = 0;
+	opts.detect_rename = DIFF_DETECT_RENAME;
+	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
+			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
+			    1000;
+	opts.rename_score = o->rename_score;
+	opts.show_rename_progress = o->show_rename_progress;
+	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&opts);
+	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
+	diffcore_std(&opts);
+	if (opts.needed_rename_limit > o->needed_rename_limit)
+		o->needed_rename_limit = opts.needed_rename_limit;
+	for (i = 0; i < diff_queued_diff.nr; ++i) {
+		struct string_list_item *item;
+		struct rename *re;
+		struct diff_filepair *pair = diff_queued_diff.queue[i];
+
+		if (pair->status != 'R') {
+			diff_free_filepair(pair);
+			continue;
+		}
+		re = xmalloc(sizeof(*re));
+		re->processed = 0;
+		re->pair = pair;
+		item = string_list_lookup(entries, re->pair->one->path);
+		if (!item)
+			re->src_entry = insert_stage_data(re->pair->one->path,
+					o_tree, a_tree, b_tree, entries);
+		else
+			re->src_entry = item->util;
+
+		item = string_list_lookup(entries, re->pair->two->path);
+		if (!item)
+			re->dst_entry = insert_stage_data(re->pair->two->path,
+					o_tree, a_tree, b_tree, entries);
+		else
+			re->dst_entry = item->util;
+		item = string_list_insert(renames, pair->one->path);
+		item->util = re;
+	}
+	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_queued_diff.nr = 0;
+	diff_flush(&opts);
+	return renames;
+}
+
 static int process_renames(struct merge_options *o,
 			   struct string_list *a_renames,
 			   struct string_list *b_renames)
-- 
2.14.2

