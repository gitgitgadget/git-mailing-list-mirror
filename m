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
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B831F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfHQSmU (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41036 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfHQSmS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so4581323pgg.8
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLtjfjVSwf1iIxIP8Fe28GktKoGFCcz97TWeMQ84cP0=;
        b=WyV3qbcNVKfHM6jAWrOcIGEUhCI46UjjHldJCfS990Sxmh+vVj/4uyAyxezFn2iABS
         oBbX8ndrFHxtnswzBWSaf/fX9y48HNIB8ncEEi0r/pRVa2SyI0cPxVGuG37D1/z7bsXh
         B2LFHR6j+xhLCF+TjTAjY0givH/Bsr/Eu9qmZov7PPUDAenSklHoemH/esjmLX2AXU4W
         8sUFV7FMR4hPl00b8U+O25YKR9KHyjFXJz/2uOq4Cm+WEl+3vsKs7O++9rfk1xzcnFJv
         XvD7uwkiw3C3C0R/ithclOu1gwf08phUvyTAXm2tE6vMLXai0eFvI91/ZEz91BSRuT7/
         3RVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLtjfjVSwf1iIxIP8Fe28GktKoGFCcz97TWeMQ84cP0=;
        b=rHvSO+VgFgC3ta9GxOhhInS9j6Rran2Bmf7kELEdl2SJzJLJc1NAwjPJK6XfyQrXew
         X17HhlZpSh2/23NaACehvY3JHEqOw4e/8lQ0kS2PvashH52e/HXzgn24K+hGpJ5sVKM0
         aDKcEheMwRadtINDTTD+eOdd1+rlfGMjcGAm1SnTxpIWkllyJOp6Zyencj7Joc5qi7C8
         nda6fUm6n86YwVJVW8SWDSd1phAGjvKJxNSDuA6o4jyA/86+SP6rtPRPlLnHRBIzqMhr
         WZaMUOu42F5tU3ah46Y1L8N2KYUvXyrZv8/hqafmMpRAeAp6fWbG09vAjZQa8FmGmQuk
         /qRA==
X-Gm-Message-State: APjAAAVN6kvTbPZeGnBABi42mw/8p+FaAoCrHmII4Wu3IF0dEeDPa3+D
        Ah6u8sDSQFd23VmrcvofGrhQy4u4
X-Google-Smtp-Source: APXvYqzrHlfT6DpbzZnNT5tzNulrAEgi18y4nZuO4A26t4Bz+TFYuFbeS4+yjUfNN7ZWGkE3xfT8Pw==
X-Received: by 2002:a63:20d:: with SMTP id 13mr13214830pgc.253.1566067337402;
        Sat, 17 Aug 2019 11:42:17 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:16 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 17/24] merge-recursive: move some definitions around to clean up the header
Date:   Sat, 17 Aug 2019 11:41:37 -0700
Message-Id: <20190817184144.32179-18-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
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
index 1823a87706..9807b24c65 100644
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
index 2cb3844ad9..0fdae904dd 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -43,47 +43,50 @@ struct merge_options {
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
@@ -92,17 +95,16 @@ int merge_recursive(struct merge_options *opt,
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
@@ -111,9 +113,4 @@ int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id **merge_bases,
 			    struct commit **result);
 
-void init_merge_options(struct merge_options *opt,
-			struct repository *repo);
-
-int parse_merge_opt(struct merge_options *opt, const char *s);
-
 #endif
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

