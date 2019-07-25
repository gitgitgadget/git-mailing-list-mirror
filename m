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
	by dcvr.yhbt.net (Postfix) with ESMTP id 410901F97E
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbfGYRqd (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43643 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403811AbfGYRq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so23385811pgv.10
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zb08hMGfDRHm5Nps7V9sSKqGEXOaeHTUEIbZwjHxDUM=;
        b=ZhXbEenrWR1COf+7grQdlKVaIytrqFM4weOMPwCMLmW1KRcTuuz3+MpJEB2nWn3QBt
         5PLZxxCTt2MIaxmO0XCj8/i42qukyHIWgeH7JV9DXaNXGjPXDLxioiaoZywB9Pci39/K
         /rjT7hiAK1LZ/GwEWrR7eIPF8Wyy/gUgn3Xc8fqtn9iQo1HKmjpcCZxsDx47PBzlCXEl
         0172m9wWI92Ob/P6ZUQGHZTXIvOTMQA7gSSrhUiBs3YUkh6IOgBkqHpY+1WuzQBADRUz
         HBmUuPBptj6rPddR0lIniJHzZn5kRK/Qch7QiOact4JpF4+xCsSrnYL30FmtLt6CrDN+
         GSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zb08hMGfDRHm5Nps7V9sSKqGEXOaeHTUEIbZwjHxDUM=;
        b=UrJi+mWJ3Dc7QnSN5oiaeN3SwbM594L9mcO/MQqv4Z8si087DvzTE8nSK9bvPK+DQq
         1HSEYEavmq/gcHdKfY9S4XeoPhxgY+79qLIZp47gNMdOZ9z18wrLkEk7HPOFq8l4qAgN
         Ge8W3aNvLioJuVV2n//6ggxT6OaA0aJdwHoA5WQ+bI5Dp9QE77qba4xozNhwtJj4OhGA
         Yf82GoT908Hi6hGBi/Q2ur9bGczp27RhkB29togZ1qAjHxV7Elt578kMQnNWO6ARs0Gr
         1I9a4k8+51b980Z2XmqZSL7TtS8oCdLrOy1es8h/BR/orBp34uQsIzbCWpStdfwRXZrj
         Fpxg==
X-Gm-Message-State: APjAAAXsjq18YInP1UTgMQ6WaUQJqSEEr89mJuiY/rAf9WoKv3FsfC1U
        imJTe5YFUhcqJyhS2ADKrwQqX3V/
X-Google-Smtp-Source: APXvYqyrERuhTWaxainFIovn81giYp0ZR4SRKNhw8sVlGObvqnHBV/5yFNMypskbOo4YLV/M30GtLA==
X-Received: by 2002:aa7:8711:: with SMTP id b17mr18117654pfo.234.1564076788172;
        Thu, 25 Jul 2019 10:46:28 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:27 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 12/19] merge-recursive: move some definitions around to clean up the header
Date:   Thu, 25 Jul 2019 10:46:04 -0700
Message-Id: <20190725174611.14802-13-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
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
 merge-recursive.c | 31 +++++++++++++++++++++++++++
 merge-recursive.h | 53 ++++++++++-------------------------------------
 2 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 61faa26c4f..0a944f51ae 100644
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
index e27c2a05bb..1454772528 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -39,36 +39,17 @@ struct merge_options {
 	struct repository *repo;
 };
 
-/*
- * For dir_rename_entry, directory names are stored as a full path from the
- * toplevel of the repository and do not include a trailing '/'.  Also:
- *
- *   dir:                original name of directory being renamed
- *   non_unique_new_dir: if true, could not determine new_dir
- *   new_dir:            final name of directory being renamed
- *   possible_new_dirs:  temporary used to help determine new_dir; see comments
- *                       in get_directory_renames() for details
- */
-struct dir_rename_entry {
-	struct hashmap_entry ent; /* must be the first member! */
-	char *dir;
-	unsigned non_unique_new_dir:1;
-	struct strbuf new_dir;
-	struct string_list possible_new_dirs;
-};
+void init_merge_options(struct merge_options *opt, struct repository *repo);
 
-struct collision_entry {
-	struct hashmap_entry ent; /* must be the first member! */
-	char *target_file;
-	struct string_list source_files;
-	unsigned reported_already:1;
-};
+/* parse the option in s and update the relevant field of opt */
+int parse_merge_opt(struct merge_options *opt, const char *s);
 
-static inline int merge_detect_rename(struct merge_options *opt)
-{
-	return opt->merge_detect_rename >= 0 ? opt->merge_detect_rename :
-		opt->diff_detect_rename >= 0 ? opt->diff_detect_rename : 1;
-}
+/* rename-detecting three-way merge, no recursion */
+int merge_trees(struct merge_options *opt,
+		struct tree *head,
+		struct tree *merge,
+		struct tree *merge_base,
+		struct tree **result);
 
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *opt,
@@ -77,16 +58,9 @@ int merge_recursive(struct merge_options *opt,
 		    struct commit_list *merge_bases,
 		    struct commit **result);
 
-/* rename-detecting three-way merge, no recursion */
-int merge_trees(struct merge_options *opt,
-		struct tree *head,
-		struct tree *merge,
-		struct tree *merge_base,
-		struct tree **result);
-
 /*
- * "git-merge-recursive" can be fed trees; wrap them into
- * virtual commits and call merge_recursive() proper.
+ * merge_recursive_generic can operate on trees instead of commits, by
+ * wrapping the trees into virtual commits, and calling merge_recursive().
  */
 int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
@@ -95,9 +69,4 @@ int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id **merge_bases,
 			    struct commit **result);
 
-void init_merge_options(struct merge_options *opt,
-			struct repository *repo);
-
-int parse_merge_opt(struct merge_options *opt, const char *s);
-
 #endif
-- 
2.22.0.559.g28a8880890.dirty

