Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9501F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbfHOVlU (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41660 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732551AbfHOVlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so1550826pls.8
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WGUr1o3ckLrj6SVrNNDq4kCRzlmt2+rH6QBsIi2Wcl8=;
        b=I75lSEPmcsJbyN+peortCp4nXRgHmRAWnqgklHp1HVCxMGsbai0V3VqlgSbxliq78g
         TSlm6A9vLxYK7W1uCJGUbMa7D+tngvx/J6fzuBTSvwk/e3uLJWvc7pfqJTFow7XgGPSK
         2x6LjdfXiT8m9JAhh48ZiK2b9Vjq0P22r58+7s6Ycv/o7pNgFrRwBXjMWVFTCUhbdlN2
         skNNnICtd6WgDy0EV5RqKRc/nOzlmqDH9AoPB/z6jvAD0ekEzB8/TitA7q/XcqyKNkgg
         i2AKPeIzff7rV54ye/TSoxmkdS3+gRavA+sfS390pZrHh32bBgNAv2UoM5O/R53Y/PdH
         rMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WGUr1o3ckLrj6SVrNNDq4kCRzlmt2+rH6QBsIi2Wcl8=;
        b=rv4EY1VXs5d59OPcQm8O3CuK56uxXbKBfq5t0pBiT2hTdlSB9GxukKWs1G15vOzwx0
         nGTwyZW6VpHmT0NlExWlNFddO04L/2AEKyYrmrBQpLJZ5nTCdmgKGGJHCM6/YdNPb6gw
         cU83yibXUJNsA5djtZnmXcQaCgh7qU4HVg73vM8ZbYgC3jVjQJZ/9UMnlCH8izU0a84V
         H1Yq6v4zLElWaaq9izoOHJZyeXPco9si9GD6QbfKK1DRjer7bxAFhKWQWwS6epw4KIGm
         HQrHnQIGOD4u6OwLAI3LJ7ljYYFpXLBdFQOCe5x76LnxVfl9pLyByJY9IMpTvzuKpkT2
         /79Q==
X-Gm-Message-State: APjAAAWe6VEpo3SG369BARzC9BuH5+idS12cq3SwBz4WyvmjcESfz5sl
        Sk289+guZCIwIrcjB22oPUoGQVeN
X-Google-Smtp-Source: APXvYqwj/EKJtwZQ59ZS7Xg2pB9MXuX36ny5nJ6D5rxSSeKxcB3QFM/MSa4wPThyCbsYAtkLleHunw==
X-Received: by 2002:a17:902:b48f:: with SMTP id y15mr6322811plr.268.1565905278210;
        Thu, 15 Aug 2019 14:41:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:17 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 05/24] merge-recursive: introduce an enum for detect_directory_renames values
Date:   Thu, 15 Aug 2019 14:40:34 -0700
Message-Id: <20190815214053.16594-6-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Improve code readability by introducing an enum to replace the
not-quite-boolean values taken on by detect_directory_renames.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c      |  2 +-
 merge-recursive.c | 24 +++++++++++++++---------
 merge-recursive.h |  6 +++++-
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1aea657a7f..037e828efe 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1538,7 +1538,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	o.branch1 = "HEAD";
 	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
 	o.branch2 = their_tree_name;
-	o.detect_directory_renames = 0;
+	o.detect_directory_renames = MERGE_DIRECTORY_RENAMES_NONE;
 
 	if (state->quiet)
 		o.verbosity = 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index 3a7a9514b9..dd2ee5edee 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1375,7 +1375,8 @@ static int handle_rename_via_dir(struct merge_options *opt,
 	const struct rename *ren = ci->ren1;
 	const struct diff_filespec *dest = ren->pair->two;
 	char *file_path = dest->path;
-	int mark_conflicted = (opt->detect_directory_renames == 1);
+	int mark_conflicted = (opt->detect_directory_renames ==
+			       MERGE_DIRECTORY_RENAMES_CONFLICT);
 	assert(ren->dir_rename_original_dest);
 
 	if (!opt->call_depth && would_lose_untracked(opt, dest->path)) {
@@ -2860,8 +2861,9 @@ static int detect_and_process_renames(struct merge_options *opt,
 	head_pairs = get_diffpairs(opt, common, head);
 	merge_pairs = get_diffpairs(opt, common, merge);
 
-	if ((opt->detect_directory_renames == 2) ||
-	    (opt->detect_directory_renames == 1 && !opt->call_depth)) {
+	if ((opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE) ||
+	    (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT &&
+	     !opt->call_depth)) {
 		dir_re_head = get_directory_renames(head_pairs);
 		dir_re_merge = get_directory_renames(merge_pairs);
 
@@ -3119,7 +3121,8 @@ static int handle_rename_normal(struct merge_options *opt,
 	clean = handle_content_merge(&mfi, opt, path, was_dirty(opt, path),
 				     o, a, b, ci);
 
-	if (clean && opt->detect_directory_renames == 1 &&
+	if (clean &&
+	    opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT &&
 	    ren->dir_rename_original_dest) {
 		if (update_stages(opt, path,
 				  NULL,
@@ -3164,12 +3167,12 @@ static int warn_about_dir_renamed_entries(struct merge_options *opt,
 		return clean;
 
 	/* Sanity checks */
-	assert(opt->detect_directory_renames > 0);
+	assert(opt->detect_directory_renames > MERGE_DIRECTORY_RENAMES_NONE);
 	assert(ren->dir_rename_original_type == 'A' ||
 	       ren->dir_rename_original_type == 'R');
 
 	/* Check whether to treat directory renames as a conflict */
-	clean = (opt->detect_directory_renames == 2);
+	clean = (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE);
 
 	is_add = (ren->dir_rename_original_type == 'A');
 	if (ren->dir_rename_original_type == 'A' && clean) {
@@ -3684,9 +3687,12 @@ static void merge_recursive_config(struct merge_options *opt)
 	if (!git_config_get_string("merge.directoryrenames", &value)) {
 		int boolval = git_parse_maybe_bool(value);
 		if (0 <= boolval) {
-			opt->detect_directory_renames = boolval ? 2 : 0;
+			opt->detect_directory_renames = boolval ?
+				MERGE_DIRECTORY_RENAMES_TRUE :
+				MERGE_DIRECTORY_RENAMES_NONE;
 		} else if (!strcasecmp(value, "conflict")) {
-			opt->detect_directory_renames = 1;
+			opt->detect_directory_renames =
+				MERGE_DIRECTORY_RENAMES_CONFLICT;
 		} /* avoid erroring on values from future versions of git */
 		free(value);
 	}
@@ -3706,7 +3712,7 @@ void init_merge_options(struct merge_options *opt,
 	opt->renormalize = 0;
 	opt->diff_detect_rename = -1;
 	opt->merge_detect_rename = -1;
-	opt->detect_directory_renames = 1;
+	opt->detect_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
 	merge_recursive_config(opt);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
diff --git a/merge-recursive.h b/merge-recursive.h
index c2b7bb65c6..f1b6ef38ae 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -22,7 +22,11 @@ struct merge_options {
 	unsigned renormalize : 1;
 	long xdl_opts;
 	int verbosity;
-	int detect_directory_renames;
+	enum {
+		MERGE_DIRECTORY_RENAMES_NONE = 0,
+		MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
+		MERGE_DIRECTORY_RENAMES_TRUE = 2
+	} detect_directory_renames;
 	int diff_detect_rename;
 	int merge_detect_rename;
 	int diff_rename_limit;
-- 
2.23.0.rc2.32.g2123e9e4e4

