Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEFAC433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 15:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiJEPA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiJEPAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 11:00:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CB4BC30
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 07:59:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l8so10942598wmi.2
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=mEMKEg7++tdOMsOD+mKC4y4bXBMjaJEp7SFZPjgY9no=;
        b=OsCxB16J95l4/JlO2wa0eNSGvPlDW+1ny12sVBynT7IoBtWeJH3aL0yCQTrxbj1SKM
         aejey1P+Tw1KFlg91m+W7SpjLp/J5mHwH/My/N6ULQFxewFeuviPr6RXVGi0QGsmyC5N
         9JpgUd6JqlxC1LQMdF0QiKoexeSvXUdJxlTVVEpZYYouOuvAS0MXlyaP4kmTFYZ1u/ED
         asDb6C7cN2vcbiKWWg7GoFy+YF3hZ6MWeVH89bsG3AxKBanuqbcDtbbQFWiTY7HCMNQr
         uVF28M+l76PPSVHFtDV1xdtlTIrNN5FlPJdGXB7bq0smz1pNLK5LDrV3mASxrN8MDDQD
         Fozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mEMKEg7++tdOMsOD+mKC4y4bXBMjaJEp7SFZPjgY9no=;
        b=B/1wRyWJ+FfZcG4LMTUQwxiHZA3KZpG+Ur8nhSRLsWtc2VAtPkwI/XIWi2wPeqV6Fc
         XPRykzxT8RtPh7Bja2BFhHNrH1iZ/WRkcBwTeH7gj//RuVpsxmLn7VR6okDsxgXhpl4S
         NgUU4NrzZZMhTY2SKLonSIuTFql0bzu3EbR6m+cs1HVf7GjvKqur72C4DOKE+jHlUvUI
         htPmJOUSmXQZCDSFoBDmAJrd6oiIz9ut2nMNr4Is3KihC5tTd2DXrE0+j9q0bPCTWkCR
         W0xFZMFYgESUgjI43XE+gwvAxzVcuud77AkH4axUgwMcEnNa9iA037b6AjOKyBC06QFr
         F36A==
X-Gm-Message-State: ACrzQf3n2D9kTAZ1v9zOBtm0+D3AdPuc76T3dNCLfC/qwIIOJ7MXy/vN
        PNDFYyigYrc8cS2GGQQjrcpPSmZjHEI=
X-Google-Smtp-Source: AMsMyM5F0gTeWdK2V8FJT1Ho3KE0Nr1UtCmeUQS8FQIPADTm3QFwr6xlMkNeHj7q9yD5qUOtP5UCrw==
X-Received: by 2002:a05:600c:524b:b0:3b4:8c0c:f3b6 with SMTP id fc11-20020a05600c524b00b003b48c0cf3b6mr3790483wmb.50.1664981964555;
        Wed, 05 Oct 2022 07:59:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c3b8b00b003a540fef440sm2566475wms.1.2022.10.05.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:59:24 -0700 (PDT)
Message-Id: <48cd92d35ef40b523255ea3b0470a3873a251933.1664981958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
        <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
From:   "Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Oct 2022 14:59:12 +0000
Subject: [PATCH v2 05/10] evolve: add the change-table structure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
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
Signed-off-by: Chris Poucet <poucet@google.com>
---
 Makefile       |   1 +
 change-table.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++
 change-table.h | 122 ++++++++++++++++++++++++++++++++++++
 3 files changed, 287 insertions(+)
 create mode 100644 change-table.c
 create mode 100644 change-table.h

diff --git a/Makefile b/Makefile
index b2bcc00c289..2b847e7e7de 100644
--- a/Makefile
+++ b/Makefile
@@ -913,6 +913,7 @@ LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle-uri.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
+LIB_OBJS += change-table.o
 LIB_OBJS += cbtree.o
 LIB_OBJS += chdir-notify.o
 LIB_OBJS += checkout.o
diff --git a/change-table.c b/change-table.c
new file mode 100644
index 00000000000..1d3d64b36d8
--- /dev/null
+++ b/change-table.c
@@ -0,0 +1,164 @@
+#include "cache.h"
+#include "change-table.h"
+#include "commit.h"
+#include "ref-filter.h"
+#include "metacommit-parser.h"
+
+void change_table_init(struct change_table *table)
+{
+	memset(table, 0, sizeof(*table));
+	mem_pool_init(&table->memory_pool, 0);
+	oidmap_init(&table->oid_to_metadata_index, 0);
+	strmap_init(&table->refname_to_change_head);
+}
+
+static void change_list_clear(struct change_list *change_list) {
+	strset_clear(&change_list->refnames);
+}
+
+static void commit_change_list_entry_clear(
+	struct commit_change_list_entry *entry) {
+	change_list_clear(&entry->changes);
+}
+
+void change_table_clear(struct change_table *table)
+{
+	struct oidmap_iter iter;
+	struct commit_change_list_entry *next;
+	for (next = oidmap_iter_first(&table->oid_to_metadata_index, &iter);
+		next;
+		next = oidmap_iter_next(&iter)) {
+
+		commit_change_list_entry_clear(next);
+	}
+
+	oidmap_free(&table->oid_to_metadata_index, 0);
+	strmap_clear(&table->refname_to_change_head, 0);
+	mem_pool_discard(&table->memory_pool, 0);
+}
+
+static void add_head_to_commit(struct change_table *table,
+			       const struct object_id *to_add,
+			       const char *refname)
+{
+	struct commit_change_list_entry *entry;
+
+	entry = oidmap_get(&table->oid_to_metadata_index, to_add);
+	if (!entry) {
+		entry = mem_pool_calloc(&table->memory_pool, 1, sizeof(*entry));
+		oidcpy(&entry->entry.oid, to_add);
+		strset_init(&entry->changes.refnames);
+		oidmap_put(&table->oid_to_metadata_index, entry);
+	}
+	strset_add(&entry->changes.refnames, refname);
+}
+
+void change_table_add(struct change_table *table,
+		      const char *refname,
+		      struct commit *to_add)
+{
+	struct change_head *new_head;
+	int metacommit_type;
+
+	new_head = mem_pool_calloc(&table->memory_pool, 1, sizeof(*new_head));
+
+	oidcpy(&new_head->head, &to_add->object.oid);
+
+	metacommit_type = get_metacommit_content(to_add, &new_head->content);
+	/* If to_add is not a metacommit then the content is to_add itself,
+	 * otherwise it will have been set by the call to
+	 * get_metacommit_content.
+	 */
+	if (metacommit_type == METACOMMIT_TYPE_NONE)
+		oidcpy(&new_head->content, &to_add->object.oid);
+	new_head->abandoned = (metacommit_type == METACOMMIT_TYPE_ABANDONED);
+	new_head->remote = starts_with(refname, "refs/remote/");
+	new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
+
+	strmap_put(&table->refname_to_change_head, refname, new_head);
+
+	if (!oideq(&new_head->content, &new_head->head)) {
+		/* We also remember to link between refname and the content oid */
+		add_head_to_commit(table, &new_head->content, refname);
+	}
+	add_head_to_commit(table, &new_head->head, refname);
+}
+
+static void change_table_add_matching_filter(struct change_table *table,
+					     struct repository* repo,
+					     struct ref_filter *filter)
+{
+	int i;
+	struct ref_array matching_refs = { 0 };
+
+	filter_refs(&matching_refs, filter, filter->kind);
+
+	/*
+	 * Determine the object id for the latest content commit for each change.
+	 * Fetch the commit at the head of each change ref. If it's a normal commit,
+	 * that's the commit we want. If it's a metacommit, locate its content parent
+	 * and use that.
+	 */
+
+	for (i = 0; i < matching_refs.nr; i++) {
+		struct ref_array_item *item = matching_refs.items[i];
+		struct commit *commit;
+
+		commit = lookup_commit_reference(repo, &item->objectname);
+		if (!commit) {
+			BUG("Invalid commit for refs/meta: %s", item->refname);
+		}
+		change_table_add(table, item->refname, commit);
+	}
+
+	ref_array_clear(&matching_refs);
+}
+
+void change_table_add_all_visible(struct change_table *table,
+	struct repository* repo)
+{
+	struct ref_filter filter = { 0 };
+	const char *name_patterns[] = {NULL};
+	filter.kind = FILTER_REFS_CHANGES;
+	filter.name_patterns = name_patterns;
+
+	change_table_add_matching_filter(table, repo, &filter);
+}
+
+static int return_true_callback(const char *refname, void *cb_data)
+{
+	return 1;
+}
+
+int change_table_has_change_referencing(struct change_table *table,
+	const struct object_id *referenced_commit_id)
+{
+	return for_each_change_referencing(table, referenced_commit_id,
+		return_true_callback, NULL);
+}
+
+int for_each_change_referencing(struct change_table *table,
+	const struct object_id *referenced_commit_id, each_change_fn fn, void *cb_data)
+{
+	int ret;
+	struct commit_change_list_entry *ccl_entry;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	ccl_entry = oidmap_get(&table->oid_to_metadata_index,
+			       referenced_commit_id);
+	/* If this commit isn't referenced by any changes, it won't be in the map */
+	if (!ccl_entry)
+		return 0;
+	strset_for_each_entry(&ccl_entry->changes.refnames, &iter, entry) {
+		ret = fn(entry->key, cb_data);
+		if (ret != 0) break;
+	}
+	return ret;
+}
+
+struct change_head* get_change_head(struct change_table *table,
+	const char* refname)
+{
+	return strmap_get(&table->refname_to_change_head, refname);
+}
diff --git a/change-table.h b/change-table.h
new file mode 100644
index 00000000000..85c2fb80d18
--- /dev/null
+++ b/change-table.h
@@ -0,0 +1,122 @@
+#ifndef CHANGE_TABLE_H
+#define CHANGE_TABLE_H
+
+#include "oidmap.h"
+#include "strmap.h"
+
+struct commit;
+struct ref_filter;
+
+/**
+ * This struct holds a set of change refs.
+ */
+struct change_list {
+	/**
+	 * The refnames in this set.
+	 * This field is private. Use for_each_change_in to read.
+	 */
+	struct strset refnames;
+};
+
+/**
+ * Holds information about the head of a single change.
+ */
+struct change_head {
+	/**
+	 * The location pointed to by the head of the change. May be a commit or a
+	 * metacommit.
+	 */
+	struct object_id head;
+	/**
+	 * The content commit for the latest commit in the change. Always points to a
+	 * real commit, never a metacommit.
+	 */
+	struct object_id content;
+	/**
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
+/**
+ * Holds the list of change refs whose content points to a particular content
+ * commit.
+ */
+struct commit_change_list_entry {
+	struct oidmap_entry entry;
+	struct change_list changes;
+};
+
+/**
+ * Holds information about the heads of each change, and permits efficient
+ * lookup from a commit to the changes that reference it directly.
+ *
+ * All fields should be considered private. Use the change_table functions
+ * to interact with this struct.
+ */
+struct change_table {
+	/**
+	 * Memory pool for the objects allocated by the change table.
+	 */
+	struct mem_pool memory_pool;
+	/* Map object_id to commit_change_list_entry structs. */
+	struct oidmap oid_to_metadata_index;
+	/**
+	 * Map of refnames to change_head structure which are allocated from
+	 * memory_pool.
+	 */
+	struct strmap refname_to_change_head;
+};
+
+extern void change_table_init(struct change_table *table);
+extern void change_table_clear(struct change_table *table);
+
+/* Adds the given change head to the change_table struct */
+extern void change_table_add(struct change_table *table,
+			     const char *refname,
+			     struct commit *target);
+
+/**
+ * Adds the non-hidden local changes to the given change_table struct.
+ */
+extern void change_table_add_all_visible(struct change_table *table,
+					 struct repository *repo);
+
+typedef int each_change_fn(const char *refname, void *cb_data);
+
+extern int change_table_has_change_referencing(
+	struct change_table *table,
+	const struct object_id *referenced_commit_id);
+
+/**
+ * Iterates over all changes that reference the given commit. For metacommits,
+ * this is the list of changes that point directly to that metacommit.
+ * For normal commits, this is the list of changes that have this commit as
+ * their latest content.
+ */
+extern int for_each_change_referencing(
+	struct change_table *table,
+	const struct object_id *referenced_commit_id,
+	each_change_fn fn,
+	void *cb_data);
+
+/**
+ * Returns the change head for the given refname. Returns NULL if no such change
+ * exists.
+ */
+extern struct change_head* get_change_head(struct change_table *table,
+	const char* refname);
+
+#endif
-- 
gitgitgadget

