Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF33F1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 04:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbfBOEba (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 23:31:30 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54894 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387506AbfBOEb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 23:31:28 -0500
Received: by mail-pl1-f202.google.com with SMTP id b1so5933984plr.21
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 20:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dz9FTd2++4cYiF57+2jWZto8QQk0G0ESTYeP4FFhyBY=;
        b=tJxvOdaT9w6Iam+p71Ya9oCPJUG9+MdSxBC5nwOqWvocUyOfC46prqrvlxWlxQm3bP
         qrf/daCeHuhQYy2Afw0Y3WwzHmlGFqPneHyILZSd5O75KU3AsgogNnRqOnuQ9cb5JHdw
         hDcmx2T3GJ7fGClt8f4k+eQRYZd0paFrQI6IGNw5iJhqMOrWCZeH65iXXXe7L115NMkR
         NjdSfv4BYV82cKSTAQDT6RkUCTtkdh6205PzPLrm95tG/Zjo2a5PvDb23WOZ9E/zH+Bl
         oMWO07y8fHTDO6By/IaEtsKlsabZ9cdgLkMsVK/3HgbpVtADO3X3AvWgTYbgXsEs6Ze+
         E1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dz9FTd2++4cYiF57+2jWZto8QQk0G0ESTYeP4FFhyBY=;
        b=pPuM3+p/65R16P+bppOEjXdcyeYXinJODupaJpqCvKt+id/vVzBssw3TvB344/UTSj
         5D5FLzqWV4RdVqo3S62ID4LizJxQUtutIJyeyOwzoQrPzl6I637y7KiX4fmxiq2eKwX4
         LpWRXWYwW9aZ5JLIJ3bBH4h7TDxSwEAOqhjQZXgAIuTta8EzL8P8xDHsc4MGgcFsjrHo
         cjGCGrSxPHI2lWWvpWaJQyxmivVZMYIcnUEdCE5P+1u4aGeClN9LXaYm8vY8f9tHZd8c
         iqvtT6fKNB8jCeVmUzCC1iT1hLp/pTsCRBVNHj3XVdvmQ6a/IBNP52RKqX//Uvyo04tp
         jZhw==
X-Gm-Message-State: AHQUAubi7aTyQJeFH1YDXZnrt4sMxWyaXpCZKwLIgi2uKp4EeU903lnU
        Rx66ykB7tDe/ZFH6o0oQc973Z3Av7zschhJoXODAWSgf+0TfLxr61RvOjl0vDQH9VHNBnFluXGd
        Sz9xOmRb6yZg6M9g2DTsXSSM/MdKIk8QejyGDqhQSNcrmFLmV9vJQQnT/cA==
X-Google-Smtp-Source: AHgI3IZLpkfWuoDs1iKEDmGqtGRdQxCsKkDRLYxOlaB+IhTSnE1BHGGKqAbjOYWxp1pGCyeLRnhpPp3FZXY=
X-Received: by 2002:a63:c044:: with SMTP id z4mr2773078pgi.131.1550205087492;
 Thu, 14 Feb 2019 20:31:27 -0800 (PST)
Date:   Thu, 14 Feb 2019 20:31:02 -0800
In-Reply-To: <20190215043105.163688-1-sxenos@google.com>
Message-Id: <20190215043105.163688-5-sxenos@google.com>
Mime-Version: 1.0
References: <20190215043105.163688-1-sxenos@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v5 5/8] evolve: add the change-table structure
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

A change table stores a list of changes, and supports efficient lookup
from a commit hash to the list of changes that reference that commit
directly.

It can be used to look up content commits or metacommits at the head
of a change, but does not support lookup of commits referenced as part
of the commit history.

Signed-off-by: Stefan Xenos <sxenos@google.com>
---
 Makefile       |   1 +
 change-table.c | 176 +++++++++++++++++++++++++++++++++++++++++++++++++
 change-table.h | 127 +++++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)
 create mode 100644 change-table.c
 create mode 100644 change-table.h

diff --git a/Makefile b/Makefile
index ab1103a9e9..b780f0b782 100644
--- a/Makefile
+++ b/Makefile
@@ -864,6 +864,7 @@ LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
+LIB_OBJS += change-table.o
 LIB_OBJS += chdir-notify.o
 LIB_OBJS += checkout.o
 LIB_OBJS += color.o
diff --git a/change-table.c b/change-table.c
new file mode 100644
index 0000000000..15105b2d96
--- /dev/null
+++ b/change-table.c
@@ -0,0 +1,176 @@
+#include "cache.h"
+#include "change-table.h"
+#include "commit.h"
+#include "ref-filter.h"
+#include "metacommit-parser.h"
+
+void change_table_init(struct change_table *to_initialize)
+{
+	memset(to_initialize, 0, sizeof(*to_initialize));
+	mem_pool_init(&to_initialize->memory_pool, 0);
+	to_initialize->memory_pool->block_alloc = 4*1024 - sizeof(struct mp_block);
+	oidmap_init(&to_initialize->oid_to_metadata_index, 0);
+	string_list_init(&to_initialize->refname_to_change_head, 1);
+}
+
+static void change_list_clear(struct change_list *to_clear) {
+	string_list_clear(&to_clear->additional_refnames, 0);
+}
+
+static void commit_change_list_entry_clear(
+	struct commit_change_list_entry *to_clear) {
+	change_list_clear(&to_clear->changes);
+}
+
+void change_table_clear(struct change_table *to_clear)
+{
+	struct oidmap_iter iter;
+	struct commit_change_list_entry *next;
+	for (next = oidmap_iter_first(&to_clear->oid_to_metadata_index, &iter);
+		next;
+		next = oidmap_iter_next(&iter)) {
+
+		commit_change_list_entry_clear(next);
+	}
+
+	oidmap_free(&to_clear->oid_to_metadata_index, 0);
+	string_list_clear(&to_clear->refname_to_change_head, 0);
+	mem_pool_discard(to_clear->memory_pool, 0);
+}
+
+static void add_head_to_commit(struct change_table *to_modify,
+	const struct object_id *to_add, const char *refname)
+{
+	struct commit_change_list_entry *entry;
+
+	/* Note: the indices in the map are 1-based. 0 is used to indicate a missing
+	 * element. */
+	entry = oidmap_get(&to_modify->oid_to_metadata_index, to_add);
+	if (!entry) {
+		entry = mem_pool_calloc(to_modify->memory_pool, 1,
+			sizeof(*entry));
+		oidcpy(&entry->entry.oid, to_add);
+		oidmap_put(&to_modify->oid_to_metadata_index, entry);
+		string_list_init(&entry->changes.additional_refnames, 0);
+	}
+
+	if (entry->changes.first_refname == NULL)
+		entry->changes.first_refname = refname;
+	else
+		string_list_insert(&entry->changes.additional_refnames, refname);
+}
+
+void change_table_add(struct change_table *to_modify, const char *refname,
+	struct commit *to_add)
+{
+	struct change_head *new_head;
+	struct string_list_item *new_item;
+	int metacommit_type;
+
+	new_head = mem_pool_calloc(to_modify->memory_pool, 1,
+		sizeof(*new_head));
+
+	oidcpy(&new_head->head, &to_add->object.oid);
+
+	metacommit_type = get_metacommit_content(to_add, &new_head->content);
+	if (metacommit_type == METACOMMIT_TYPE_NONE)
+		oidcpy(&new_head->content, &to_add->object.oid);
+	new_head->abandoned = (metacommit_type == METACOMMIT_TYPE_ABANDONED);
+	new_head->remote = starts_with(refname, "refs/remote/");
+	new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
+
+	new_item = string_list_insert(&to_modify->refname_to_change_head, refname);
+	new_item->util = new_head;
+	/* Use pointers to the copy of the string we're retaining locally */
+	refname = new_item->string;
+
+	if (!oideq(&new_head->content, &new_head->head))
+		add_head_to_commit(to_modify, &new_head->content, refname);
+	add_head_to_commit(to_modify, &new_head->head, refname);
+}
+
+void change_table_add_all_visible(struct change_table *to_modify,
+	struct repository* repo)
+{
+	struct ref_filter filter;
+	const char *name_patterns[] = {NULL};
+	memset(&filter, 0, sizeof(filter));
+	filter.kind = FILTER_REFS_CHANGES;
+	filter.name_patterns = name_patterns;
+
+	change_table_add_matching_filter(to_modify, repo, &filter);
+}
+
+void change_table_add_matching_filter(struct change_table *to_modify,
+	struct repository* repo, struct ref_filter *filter)
+{
+	struct ref_array matching_refs;
+	int i;
+
+	memset(&matching_refs, 0, sizeof(matching_refs));
+	filter_refs(&matching_refs, filter, filter->kind);
+
+	/* Determine the object id for the latest content commit for each change.
+	 * Fetch the commit at the head of each change ref. If it's a normal commit,
+	 * that's the commit we want. If it's a metacommit, locate its content parent
+	 * and use that. */
+
+	for (i = 0; i < matching_refs.nr; i++) {
+		struct ref_array_item *item = matching_refs.items[i];
+		struct commit *commit = item->commit;
+
+		commit = lookup_commit_reference_gently(repo, &item->objectname, 1);
+
+		if (commit != NULL)
+			change_table_add(to_modify, item->refname, commit);
+	}
+
+	ref_array_clear(&matching_refs);
+}
+
+static int return_true_callback(const char *refname, void *cb_data)
+{
+	return 1;
+}
+
+int change_table_has_change_referencing(struct change_table *changes,
+	const struct object_id *referenced_commit_id)
+{
+	return for_each_change_referencing(changes, referenced_commit_id,
+		return_true_callback, NULL);
+}
+
+int for_each_change_referencing(struct change_table *table,
+	const struct object_id *referenced_commit_id, each_change_fn fn, void *cb_data)
+{
+	const struct change_list *changes;
+	int i;
+	int retvalue;
+	struct commit_change_list_entry *entry;
+
+	entry = oidmap_get(&table->oid_to_metadata_index,
+		referenced_commit_id);
+	/* If this commit isn't referenced by any changes, it won't be in the map */
+	if (!entry)
+		return 0;
+	changes = &entry->changes;
+	if (changes->first_refname == NULL)
+		return 0;
+	retvalue = fn(changes->first_refname, cb_data);
+	for (i = 0; retvalue == 0 && i < changes->additional_refnames.nr; i++)
+		retvalue = fn(changes->additional_refnames.items[i].string, cb_data);
+	return retvalue;
+}
+
+struct change_head* get_change_head(struct change_table *heads,
+	const char* refname)
+{
+	struct string_list_item *item = string_list_lookup(
+		&heads->refname_to_change_head, refname);
+
+	if (!item)
+		return NULL;
+
+	return (struct change_head *)item->util;
+}
+
diff --git a/change-table.h b/change-table.h
new file mode 100644
index 0000000000..b6ad670965
--- /dev/null
+++ b/change-table.h
@@ -0,0 +1,127 @@
+#ifndef CHANGE_TABLE_H
+#define CHANGE_TABLE_H
+
+#include "oidmap.h"
+
+struct commit;
+struct ref_filter;
+
+/*
+ * This struct holds a list of change refs. The first element is stored inline,
+ * to optimize for small lists.
+ */
+struct change_list {
+	/* Ref name for the first change in the list, or null if none.
+	 *
+	 * This field is private. Use for_each_change_in to read.
+	 */
+	const char* first_refname;
+	/* List of additional change refs. Note that this is empty if the list
+	 * contains 0 or 1 elements.
+	 *
+	 * This field is private. Use for_each_change_in to read.
+	 */
+	struct string_list additional_refnames;
+};
+
+/*
+ * Holds information about the head of a single change.
+ */
+struct change_head {
+	/*
+	 * The location pointed to by the head of the change. May be a commit or a
+	 * metacommit.
+	 */
+	struct object_id head;
+	/*
+	 * The content commit for the latest commit in the change. Always points to a
+	 * real commit, never a metacommit.
+	 */
+	struct object_id content;
+	/*
+	 * Abandoned: indicates that the content commit should be removed from the
+	 * history.
+	 *
+	 * Hidden: indicates that the change is an inactive change from the
+	 * hiddenmetas namespace. Such changes will be hidden from the user by
+	 * default.
+	 *
+	 * Deleted: indicates that the change has been removed from the repository.
+	 * That is the ref was deleted since the time this struct was created. Such
+	 * entries should be ignored.
+	 */
+	unsigned int abandoned:1,
+		hidden:1,
+		remote:1,
+		deleted:1;
+};
+
+/*
+ * Holds the list of change refs whose content points to a particular content
+ * commit.
+ */
+struct commit_change_list_entry {
+	struct oidmap_entry entry;
+	struct change_list changes;
+};
+
+/*
+ * Holds information about the heads of each change, and permits effecient
+ * lookup from a commit to the changes that reference it directly.
+ *
+ * All fields should be considered private. Use the change_table functions
+ * to interact with this struct.
+ */
+struct change_table {
+	/**
+	 * Memory pool for the objects allocated by the change table.
+	 */
+	struct mem_pool *memory_pool;
+	/* Map object_id to commit_change_list_entry structs. */
+	struct oidmap oid_to_metadata_index;
+	/* List of ref names. The util value points to a change_head structure
+	 * allocated from memory_pool.
+	 */
+	struct string_list refname_to_change_head;
+};
+
+extern void change_table_init(struct change_table *to_initialize);
+extern void change_table_clear(struct change_table *to_clear);
+
+/* Adds the given change head to the change_table struct */
+extern void change_table_add(struct change_table *to_modify,
+	const char *refname, struct commit *target);
+
+/* Adds the non-hidden local changes to the given change_table struct.
+ */
+extern void change_table_add_all_visible(struct change_table *to_modify,
+	struct repository *repo);
+
+/*
+ * Adds all changes matching the given ref filter to the given change_table
+ * struct.
+ */
+extern void change_table_add_matching_filter(struct change_table *to_modify,
+	struct repository* repo, struct ref_filter *filter);
+
+typedef int each_change_fn(const char *refname, void *cb_data);
+
+extern int change_table_has_change_referencing(struct change_table *changes,
+	const struct object_id *referenced_commit_id);
+
+/* Iterates over all changes that reference the given commit. For metacommits,
+ * this is the list of changes that point directly to that metacommit.
+ * For normal commits, this is the list of changes that have this commit as
+ * their latest content.
+ */
+extern int for_each_change_referencing(struct change_table *heads,
+	const struct object_id *referenced_commit_id, each_change_fn fn, void *cb_data);
+
+/**
+ * Returns the change head for the given refname. Returns NULL if no such change
+ * exists.
+ */
+extern struct change_head* get_change_head(struct change_table *heads,
+	const char* refname);
+
+#endif
-- 
2.21.0.rc0.258.g878e2cd30e-goog

