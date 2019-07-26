Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6F11F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfGZPxW (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39223 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfGZPxT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so20724413pfn.6
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ps5Mv0xViWWM/7t8HZUEK3tY2SPHJIxjfUP8B/1IdFE=;
        b=AizV1/vI08qNKjuLIRmZKMVDvSafukGqa4zi1hMFa/8Rgjbe3OdlMI5Oq8CmK6tYrc
         Y26CSYZVFGqIfQ6tBLrh0gY6eG8dOn5y8aT3Gt08bPeJtqLqmYLmunUrHl2mXnIv8xFc
         KCHvCmFWsunWsxzkFdfM2OxSv+xxmqe6r3EbwAvnbUADzXMQ8vJzLtXGUAfTlUXix5BF
         nI64SPb85i3gEB3RS92wJzH1BiOeXv2sVns3jaUjCcVWSSkEbpwNxIzlpFTFj1/2pu5v
         V37W1iXdLw/C8XAoPp8RYz96jwffT14oe97b2SFxsNYY8M1jdyVNxu/Nj1CdAE9in5np
         FYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ps5Mv0xViWWM/7t8HZUEK3tY2SPHJIxjfUP8B/1IdFE=;
        b=N8+AezTCfnyr5f0U+rIGn4xnUifjXyX0WScloALvDY+igxpSd4kVcIKJuqj+1C5eqY
         SaipsgCoC9SVwDSMHbRhiaCUhdCZiGjkq20qatAlKphtgTcMNmhx2hAB//WlvL0DE2I+
         j9QPZwo9iM/mfDezLYMfuCVRtUGNbU1/oEaq+aqhOPTVZ4q1NCBkD9gzBuVnf42AOiY9
         89TSZbLfBoMy31KIFStKOcp4hMc3bj3+vyU5ouLyaiWfQ6L3Y1JENwOs54FMO3PI41JB
         A88nJocy/gqbJ8cRXbEqnKeQ3407olhJO+yS0cAhKVqSTHhjnSXkLSkh+PPr6CCmt89f
         LU0Q==
X-Gm-Message-State: APjAAAXLBmU8YcrmeBzDq5s6i+J1sX05xOjT0nu4yggtNyzVAf5AbCn5
        tU9FfCKAK12KZKJuasYQD7f22zvQ
X-Google-Smtp-Source: APXvYqzBHJpiQHG18+29BIoisw0WfweLND9FMBawqaua1khOAHVK2YKyOlJH+ppHr4QMSWtk2sGy5Q==
X-Received: by 2002:a17:90a:d998:: with SMTP id d24mr71362249pjv.89.1564156398286;
        Fri, 26 Jul 2019 08:53:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:17 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 12/20] merge-recursive: move some definitions around to clean up the header
Date:   Fri, 26 Jul 2019 08:52:50 -0700
Message-Id: <20190726155258.28561-13-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No substantive code changes (view this with diff --color-moved), but
a few small code cleanups:
  * Move structs and an inline function only used by merge-recursive.c
    into merge-recursive.c
  * Re-order function declarations to be more logical
  * Add or fix some explanatory comments

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 31 +++++++++++++++++
 merge-recursive.h | 87 +++++++++++++++++++++++------------------------
 2 files changed, 73 insertions(+), 45 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f36962b7b5..6820578258 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -54,6 +54,24 @@ static unsigned int path_hash(const char *path)
 	return ignore_case ? strihash(path) : strhash(path);
 }
 
+/*
+ * For dir_rename_entry, directory names are stored as a full path from the
+ * toplevel of the repository and do not include a trailing '/'.  Also:
+ *
+ *   dir:                original name of directory being renamed
+ *   non_unique_new_dir: if true, could not determine new_dir
+ *   new_dir:            final name of directory being renamed
+ *   possible_new_dirs:  temporary used to help determine new_dir; see comments
+ *                       in get_directory_renames() for details
+ */
+struct dir_rename_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	char *dir;
+	unsigned non_unique_new_dir:1;
+	struct strbuf new_dir;
+	struct string_list possible_new_dirs;
+};
+
 static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *hashmap,
 						      char *dir)
 {
@@ -92,6 +110,13 @@ static void dir_rename_entry_init(struct dir_rename_entry *entry,
 	string_list_init(&entry->possible_new_dirs, 0);
 }
 
+struct collision_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	char *target_file;
+	struct string_list source_files;
+	unsigned reported_already:1;
+};
+
 static struct collision_entry *collision_find_entry(struct hashmap *hashmap,
 						    char *target_file)
 {
@@ -358,6 +383,12 @@ static int add_cacheinfo(struct merge_options *opt,
 	return ret;
 }
 
+static inline int merge_detect_rename(struct merge_options *opt)
+{
+	return opt->merge_detect_rename >= 0 ? opt->merge_detect_rename :
+		opt->diff_detect_rename >= 0 ? opt->diff_detect_rename : 1;
+}
+
 static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
 {
 	parse_tree(tree);
diff --git a/merge-recursive.h b/merge-recursive.h
index c201de0fc3..ebec855a65 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -39,47 +39,50 @@ struct merge_options {
 	struct repository *repo;
 };
 
+void init_merge_options(struct merge_options *opt, struct repository *repo);
+
+/* parse the option in s and update the relevant field of opt */
+int parse_merge_opt(struct merge_options *opt, const char *s);
+
 /*
- * For dir_rename_entry, directory names are stored as a full path from the
- * toplevel of the repository and do not include a trailing '/'.  Also:
- *
- *   dir:                original name of directory being renamed
- *   non_unique_new_dir: if true, could not determine new_dir
- *   new_dir:            final name of directory being renamed
- *   possible_new_dirs:  temporary used to help determine new_dir; see comments
- *                       in get_directory_renames() for details
+ * RETURN VALUES: All the merge_* functions below return a value as follows:
+ *   > 0     Merge was clean
+ *   = 0     Merge had conflicts
+ *   < 0     Merge hit an unexpected and unrecoverable problem (e.g. disk
+ *             full) and aborted merge part-way through.
  */
-struct dir_rename_entry {
-	struct hashmap_entry ent; /* must be the first member! */
-	char *dir;
-	unsigned non_unique_new_dir:1;
-	struct strbuf new_dir;
-	struct string_list possible_new_dirs;
-};
-
-struct collision_entry {
-	struct hashmap_entry ent; /* must be the first member! */
-	char *target_file;
-	struct string_list source_files;
-	unsigned reported_already:1;
-};
 
-static inline int merge_detect_rename(struct merge_options *opt)
-{
-	return opt->merge_detect_rename >= 0 ? opt->merge_detect_rename :
-		opt->diff_detect_rename >= 0 ? opt->diff_detect_rename : 1;
-}
+/*
+ * rename-detecting three-way merge, no recursion.
+ *
+ * Outputs:
+ *   - See RETURN VALUES above
+ *   - No commit is created
+ *   - opt->repo->index has the new index
+ *   - $GIT_INDEX_FILE is not updated
+ *   - The working tree is updated with results of the merge
+ */
+int merge_trees(struct merge_options *opt,
+		struct tree *head,
+		struct tree *merge,
+		struct tree *merge_base);
 
 /*
  * merge_recursive is like merge_trees() but with recursive ancestor
- * consolidation, and when successful, it creates an actual commit
- * and writes its address to *result.
+ * consolidation and, if the commit is clean, creation of a commit.
  *
  * NOTE: empirically, about a decade ago it was determined that with more
  *       than two merge bases, optimal behavior was found when the
  *       merge_bases were passed in the order of oldest commit to newest
  *       commit.  Also, merge_bases will be consumed (emptied) so make a
  *       copy if you need it.
+ *
+ * Outputs:
+ *   - See RETURN VALUES above
+ *   - If merge is clean, a commit is created and its address written to *result
+ *   - opt->repo->index has the new index
+ *   - $GIT_INDEX_FILE is not updated
+ *   - The working tree is updated with results of the merge
  */
 int merge_recursive(struct merge_options *opt,
 		    struct commit *h1,
@@ -88,17 +91,16 @@ int merge_recursive(struct merge_options *opt,
 		    struct commit **result);
 
 /*
- * rename-detecting three-way merge, no recursion; result of merge is written
- * to opt->repo->index.
- */
-int merge_trees(struct merge_options *opt,
-		struct tree *head,
-		struct tree *merge,
-		struct tree *merge_base);
-
-/*
- * "git-merge-recursive" can be fed trees; wrap them into
- * virtual commits and call merge_recursive() proper.
+ * merge_recursive_generic can operate on trees instead of commits, by
+ * wrapping the trees into virtual commits, and calling merge_recursive().
+ * It also writes out the in-memory index to disk if the merge is successful.
+ *
+ * Outputs:
+ *   - See RETURN VALUES above
+ *   - If merge is clean, a commit is created and its address written to *result
+ *   - opt->repo->index has the new index
+ *   - $GIT_INDEX_FILE is updated
+ *   - The working tree is updated with results of the merge
  */
 int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
@@ -107,9 +109,4 @@ int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id **merge_bases,
 			    struct commit **result);
 
-void init_merge_options(struct merge_options *opt,
-			struct repository *repo);
-
-int parse_merge_opt(struct merge_options *opt, const char *s);
-
 #endif
-- 
2.22.0.550.g71c37a0928.dirty

