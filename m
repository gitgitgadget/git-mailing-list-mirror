Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 055881F453
	for <e@80x24.org>; Sun, 27 Jan 2019 19:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfA0Tlo (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 14:41:44 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52058 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfA0Tln (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 14:41:43 -0500
Received: by mail-pg1-f201.google.com with SMTP id t26so10013384pgu.18
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 11:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7cMyXIzIL94D6VTnKdFBV3rrJTxL/qORHkyq0bTsvjU=;
        b=ApKZtkexMo453bjiTwn3kRlOJe99VgwzCWJYSdFZ3SBqgWLH3Q2PbcQd1AKJRLn/xA
         l2RiBiIjrhdO6gEB/imnGOBzsWtc719xR8Okza+Wv4xByHVTuviVw5551/3P+A8LSLjy
         8hn0APjij7KHHsic7w5qEt2nnDF8eOPYy/Y5oJSfibnDYSIEVKZDuy6A9GR32Rqyg0AB
         1AcgPENX52f+EKlg47UJkss1HJZbSZVBqawI+WjnFHrXIA/MOGHfCR1ZO3XoN7ChhM1S
         9mwnyZSREBLW68lCNC6gbNhAVLSx4lLH2YeRiJH45lF+gpeDY/3JrxwIrPNfZACvqN+E
         apFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7cMyXIzIL94D6VTnKdFBV3rrJTxL/qORHkyq0bTsvjU=;
        b=ZtOdUuXhz0y1nJZeFVptyouIefZRr2J70ZD5zFBti34yhwGBuBy5ne0G6Jm4I8wD5n
         WYd3ZpcGRvZtJmDiiJxpuIUPMXm+BW/evJPR3vLIzXwfPPdUDWw4NTCPGYYQFoo9V6Qi
         e+vlryz61/j4FHFjC3Z7jsiutZx89JbaUh9t3iafBGbDXM5lPRHFLZRWbvX4rKq2sMP2
         HEoCmIP+wAsfOtlTYgQk6+iC/brPJEi69qopMWf1KJDRJ4T7HbCRd6kTj/7cy9Q0x+tm
         At52b00VVeYZbEuv1LVF49/tgMlrmMTCl/sZg5s2ybfhVGUCx16Az+79UcGVWxrOS6tZ
         i+WQ==
X-Gm-Message-State: AJcUukchQApzI++I886AwdX0bLwRF6pSDlXBVQgXKRbPbdjmNoc3Vx/B
        suQybRR3M8mgmFZ2i/OZRnQhIT3vXml+d4kr8hxZLYzkVkTVNpWk/KxSlfrCRFTEMCL8so3FeaP
        wE8fbbixyTv9cjtcwrE8lC9wSUlXJEFDLzT/doOJHCcNiCHjabFREYeyHlQ==
X-Google-Smtp-Source: ALg8bN6ghv4WkGtLrVZy3ObUtinsIbCZWWREYaaLYm8AxyDyC1mCAAF9jvCAsVCRauR3mwClz6DUHVxNEuA=
X-Received: by 2002:a62:6989:: with SMTP id e131mr8629764pfc.95.1548618102735;
 Sun, 27 Jan 2019 11:41:42 -0800 (PST)
Date:   Sun, 27 Jan 2019 11:41:25 -0800
In-Reply-To: <20190127194128.161250-1-sxenos@google.com>
Message-Id: <20190127194128.161250-5-sxenos@google.com>
Mime-Version: 1.0
References: <20190127194128.161250-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH v2 5/8] evolve: Add the change-table structure
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
 change-table.c | 207 +++++++++++++++++++++++++++++++++++++++++++++++++
 change-table.h | 138 +++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 change-table.c
 create mode 100644 change-table.h

diff --git a/Makefile b/Makefile
index 7ffc383f2b..09cfd3ef1b 100644
--- a/Makefile
+++ b/Makefile
@@ -844,6 +844,7 @@ LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
+LIB_OBJS += change-table.o
 LIB_OBJS += chdir-notify.o
 LIB_OBJS += checkout.o
 LIB_OBJS += color.o
diff --git a/change-table.c b/change-table.c
new file mode 100644
index 0000000000..6daff5f58c
--- /dev/null
+++ b/change-table.c
@@ -0,0 +1,207 @@
+#include "cache.h"
+#include "change-table.h"
+#include "commit.h"
+#include "ref-filter.h"
+#include "metacommit-parser.h"
+
+void change_table_init(struct change_table *to_initialize)
+{
+	memset(to_initialize, 0, sizeof(*to_initialize));
+	mem_pool_init(&(to_initialize->memory_pool), 0);
+	to_initialize->memory_pool->block_alloc = 4*1024 - sizeof(struct mp_block);
+	oidmap_init(&(to_initialize->oid_to_metadata_index), 0);
+	string_list_init(&(to_initialize->refname_to_change_head), 1);
+}
+
+static void change_list_clear(struct change_list *to_clear) {
+	string_list_clear(&to_clear->additional_refnames, 0);
+}
+
+static void commit_change_list_entry_clear(
+	struct commit_change_list_entry *to_clear) {
+	change_list_clear(&(to_clear->changes));
+}
+
+static void change_head_array_clear(struct change_head_array *to_clear)
+{
+	FREE_AND_NULL(to_clear->array);
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
+	string_list_clear(&(to_clear->refname_to_change_head), 0);
+	change_head_array_clear(&to_clear->heads);
+	mem_pool_discard(to_clear->memory_pool, 0);
+}
+
+/*
+ * Appends a new, empty, change_head struct to the end of the given array.
+ * Returns the index of the newly-added struct.
+ */
+static int change_head_array_append(struct change_head_array *to_add)
+{
+	int index = to_add->nr++;
+	struct change_head *new_head;
+	ALLOC_GROW(to_add->array, to_add->nr, to_add->alloc);
+	new_head = &(to_add->array[index]);
+	memset(new_head, 0, sizeof(*new_head));
+	return index;
+}
+
+static void add_head_to_commit(struct change_table *to_modify,
+	const struct object_id *to_add, const char *refname)
+{
+	struct commit_change_list_entry *entry;
+
+	// Note: the indices in the map are 1-based. 0 is used to indicate a missing
+	// element.
+	entry = oidmap_get(&(to_modify->oid_to_metadata_index), to_add);
+	if (!entry) {
+		entry = mem_pool_calloc(to_modify->memory_pool, 1,
+			sizeof(*entry));
+		oidcpy(&entry->entry.oid, to_add);
+		oidmap_put(&(to_modify->oid_to_metadata_index), entry);
+		string_list_init(&(entry->changes.additional_refnames), 0);
+	}
+
+	if (entry->changes.first_refname == NULL) {
+		entry->changes.first_refname = refname;
+	} else {
+		string_list_insert(&entry->changes.additional_refnames, refname);
+	}
+}
+
+void change_table_add(struct change_table *to_modify, const char *refname,
+	struct commit *to_add)
+{
+	struct change_head *new_head;
+	struct string_list_item *new_item;
+	long index;
+	int metacommit_type;
+
+	index = change_head_array_append(&to_modify->heads);
+	new_head = &(to_modify->heads.array[index]);
+
+	oidcpy(&new_head->head, &(to_add->object.oid));
+
+	metacommit_type = get_metacommit_content(to_add, &new_head->content);
+	if (metacommit_type == METACOMMIT_TYPE_NONE) {
+		oidcpy(&new_head->content, &(to_add->object.oid));
+	}
+	new_head->abandoned = (metacommit_type == METACOMMIT_TYPE_ABANDONED);
+	new_head->remote = starts_with(refname, "refs/remote/");
+	new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
+
+	new_item = string_list_insert(&to_modify->refname_to_change_head, refname);
+	new_item->util = (void*)index;
+	// Use pointers to the copy of the string we're retaining locally
+	refname = new_item->string;
+
+	if (!oideq(&new_head->content, &new_head->head)) {
+		add_head_to_commit(to_modify, &(new_head->content), refname);
+	}
+	add_head_to_commit(to_modify, &(new_head->head), refname);
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
+	// Determine the object id for the latest content commit for each change.
+	// Fetch the commit at the head of each change ref. If it's a normal commit,
+	// that's the commit we want. If it's a metacommit, locate its content parent
+	// and use that.
+
+	for (i = 0; i < matching_refs.nr; i++) {
+		struct ref_array_item *item = matching_refs.items[i];
+		struct commit *commit = item->commit;
+
+		commit = lookup_commit_reference_gently(repo, &(item->objectname), 1);
+
+		if (commit != NULL) {
+			change_table_add(to_modify, item->refname, commit);
+		}
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
+	// If this commit isn't referenced by any changes, it won't be in the map
+	if (!entry) {
+		return 0;
+	}
+	changes = &(entry->changes);
+	if (changes->first_refname == NULL) {
+		return 0;
+	}
+	retvalue = fn(changes->first_refname, cb_data);
+	for (i = 0; retvalue == 0 && i < changes->additional_refnames.nr; i++) {
+		retvalue = fn(changes->additional_refnames.items[i].string, cb_data);
+	}
+	return retvalue;
+}
+
+struct change_head* get_change_head(struct change_table *heads,
+	const char* refname)
+{
+	struct string_list_item *item = string_list_lookup(
+		&heads->refname_to_change_head, refname);
+	long index;
+
+	if (!item) {
+		return NULL;
+	}
+
+	index = (long)item->util;
+	return &(heads->heads.array[index]);
+}
+
diff --git a/change-table.h b/change-table.h
new file mode 100644
index 0000000000..85bb19c3bf
--- /dev/null
+++ b/change-table.h
@@ -0,0 +1,138 @@
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
+	int abandoned:1,
+		hidden:1,
+		remote:1,
+		deleted:1;
+};
+
+/*
+ * An array of change_head.
+ */
+struct change_head_array {
+	struct change_head* array;
+	int nr;
+	int alloc;
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
+	/* List of ref names. The util value is an int index into change_metadata
+	 * array.
+	 */
+	struct string_list refname_to_change_head;
+	/* change_head structures for each head */
+	struct change_head_array heads;
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
2.20.1.495.gaa96b0ce6b-goog

