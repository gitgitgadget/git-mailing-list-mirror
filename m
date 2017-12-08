Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5997920954
	for <e@80x24.org>; Fri,  8 Dec 2017 00:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbdLHAOd (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 19:14:33 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:37675 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdLHAOc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 19:14:32 -0500
Received: by mail-it0-f44.google.com with SMTP id d137so1216368itc.2
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 16:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EEOHRALQgw1U7rporFoy0FTWZwvshtp80dgEdsabaoc=;
        b=MoGpt8Hq8QuJ/NxKoCL6q0Hy/b3o3hKPqMXB+mgFR7/osxvw99Jo4HDf5e8eVRadQI
         3F5ijRZ5CkXQwNzoDO48YG6M/VfaL3V/rRndTmEBk3x6PuXep917fxommNF6l0HABTM6
         o7JSXFT7S9P4Vfwr/veih+0gX0/eHOAm4AYvwz21AHs4iOgSkilXXj+AP2jmKpuShyfL
         VdgrFt8CyIWunbcYwrHIqQFuMWfAGqdoa3XPRbhlrAu1Xb2JlD9HEUQcuslYMJV07NqG
         fHdJdDY2Mi8zRyPDfbJ5U7dnV6aOhgGvqNWQaXSklzbWP+44hgKsl3E+/XVRUBb2NJrz
         H9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EEOHRALQgw1U7rporFoy0FTWZwvshtp80dgEdsabaoc=;
        b=jpqYsfs7t7f3FAc+Uju2yatXOlB5crpt5Ds1OYWnHfK2xK2zEtjonLmsHdzkS1HfKP
         yKyTuVwJ16qQojLlp4Z5/GsaabGxx6V7dQDCpG4RlL5VJ6sLVfVOfOK18MHiD9v1dH36
         05vY0DLtkCtqxT6960zh0cM5o49DrDEl2E28xgBLe+0C33SqkBEBidfVb3fJNd2LWc0X
         khtB3nqpChY01VbybPrhqCs8A3TsjLpPbMjigVlv8mRmAI3ljgkm2scgkeIjG1omMeFP
         tAiAdAjyNcw4q3XqWVKU407TXNIfKL8nqGftjKhnUUjSM0TaM0Qe1RXz6qIDY0T1w17+
         Sh2g==
X-Gm-Message-State: AKGB3mIeWZXNhgyXM4HplKJDVZ5vMCazGx2jSzGSjNuTwbxwWQgB1bOL
        M+aFKCZr4wZKQr8lJ6C1cuYwNqlBd8s=
X-Google-Smtp-Source: AGs4zMbdEBGq4vpvW06tv6yy0TktSW08g6DzKuuxkNxwc5TzAppoPc/OGr8Yh4NWeLoB2tFgorZ1TQ==
X-Received: by 10.36.50.11 with SMTP id j11mr3679786ita.153.1512692071702;
        Thu, 07 Dec 2017 16:14:31 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id m63sm195264itm.12.2017.12.07.16.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 16:14:30 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        peff@peff.net, gitster@pobox.com, sbeller@google.com,
        johannes.schindelin@gmx.de
Subject: [PATCH] decorate: clean up and document API
Date:   Thu,  7 Dec 2017 16:14:24 -0800
Message-Id: <20171208001424.81712-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.1.355.g79f9fc25e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the names of the identifiers in decorate.h, document them, and
add an example of how to use these functions.

The example is compiled and run as part of the test suite.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This patch contains some example code in a test helper.

There is a discussion at [1] about where example code for hashmap should
go. For something relatively simple, like decorate, perhaps example code
isn't necessary; but if we include example code anyway, I think that we
might as well make it compiled and tested, so this patch contains that
example code in a test helper.

[1] https://public-inbox.org/git/466dd5331907754ca5c25cc83173ca895220ca81.1511999045.git.johannes.schindelin@gmx.de/
---
 Documentation/technical/api-decorate.txt |  6 ---
 Makefile                                 |  1 +
 builtin/fast-export.c                    |  2 +-
 decorate.c                               | 28 ++++++------
 decorate.h                               | 49 +++++++++++++++++++--
 t/helper/.gitignore                      |  1 +
 t/helper/test-example-decorate.c         | 74 ++++++++++++++++++++++++++++++++
 t/t9004-example.sh                       | 10 +++++
 8 files changed, 146 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/technical/api-decorate.txt
 create mode 100644 t/helper/test-example-decorate.c
 create mode 100755 t/t9004-example.sh

diff --git a/Documentation/technical/api-decorate.txt b/Documentation/technical/api-decorate.txt
deleted file mode 100644
index 1d52a6ce1..000000000
--- a/Documentation/technical/api-decorate.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-decorate API
-============
-
-Talk about <decorate.h>
-
-(Linus)
diff --git a/Makefile b/Makefile
index fef9c8d27..df52cc1c3 100644
--- a/Makefile
+++ b/Makefile
@@ -651,6 +651,7 @@ TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
+TEST_PROGRAMS_NEED_X += test-example-decorate
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-hashmap
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index f8fe04ca5..796d0cd66 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -895,7 +895,7 @@ static void export_marks(char *file)
 {
 	unsigned int i;
 	uint32_t mark;
-	struct object_decoration *deco = idnums.hash;
+	struct decoration_entry *deco = idnums.entries;
 	FILE *f;
 	int e = 0;
 
diff --git a/decorate.c b/decorate.c
index 270eb2519..de31331fa 100644
--- a/decorate.c
+++ b/decorate.c
@@ -14,20 +14,20 @@ static unsigned int hash_obj(const struct object *obj, unsigned int n)
 static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
 {
 	int size = n->size;
-	struct object_decoration *hash = n->hash;
+	struct decoration_entry *entries = n->entries;
 	unsigned int j = hash_obj(base, size);
 
-	while (hash[j].base) {
-		if (hash[j].base == base) {
-			void *old = hash[j].decoration;
-			hash[j].decoration = decoration;
+	while (entries[j].base) {
+		if (entries[j].base == base) {
+			void *old = entries[j].decoration;
+			entries[j].decoration = decoration;
 			return old;
 		}
 		if (++j >= size)
 			j = 0;
 	}
-	hash[j].base = base;
-	hash[j].decoration = decoration;
+	entries[j].base = base;
+	entries[j].decoration = decoration;
 	n->nr++;
 	return NULL;
 }
@@ -36,24 +36,23 @@ static void grow_decoration(struct decoration *n)
 {
 	int i;
 	int old_size = n->size;
-	struct object_decoration *old_hash = n->hash;
+	struct decoration_entry *old_entries = n->entries;
 
 	n->size = (old_size + 1000) * 3 / 2;
-	n->hash = xcalloc(n->size, sizeof(struct object_decoration));
+	n->entries = xcalloc(n->size, sizeof(struct decoration_entry));
 	n->nr = 0;
 
 	for (i = 0; i < old_size; i++) {
-		const struct object *base = old_hash[i].base;
-		void *decoration = old_hash[i].decoration;
+		const struct object *base = old_entries[i].base;
+		void *decoration = old_entries[i].decoration;
 
 		if (!decoration)
 			continue;
 		insert_decoration(n, base, decoration);
 	}
-	free(old_hash);
+	free(old_entries);
 }
 
-/* Add a decoration pointer, return any old one */
 void *add_decoration(struct decoration *n, const struct object *obj,
 		void *decoration)
 {
@@ -64,7 +63,6 @@ void *add_decoration(struct decoration *n, const struct object *obj,
 	return insert_decoration(n, obj, decoration);
 }
 
-/* Lookup a decoration pointer */
 void *lookup_decoration(struct decoration *n, const struct object *obj)
 {
 	unsigned int j;
@@ -74,7 +72,7 @@ void *lookup_decoration(struct decoration *n, const struct object *obj)
 		return NULL;
 	j = hash_obj(obj, n->size);
 	for (;;) {
-		struct object_decoration *ref = n->hash + j;
+		struct decoration_entry *ref = n->entries + j;
 		if (ref->base == obj)
 			return ref->decoration;
 		if (!ref->base)
diff --git a/decorate.h b/decorate.h
index e7328044f..9014c1e99 100644
--- a/decorate.h
+++ b/decorate.h
@@ -1,18 +1,61 @@
 #ifndef DECORATE_H
 #define DECORATE_H
 
-struct object_decoration {
+/*
+ * A data structure that associates Git objects to void pointers. See
+ * t/helper/test-example-decorate.c for a demonstration of how to use these
+ * functions.
+ */
+
+/*
+ * An entry in the data structure.
+ */
+struct decoration_entry {
 	const struct object *base;
 	void *decoration;
 };
 
+/*
+ * The data structure.
+ *
+ * This data structure must be zero-initialized.
+ */
 struct decoration {
+	/*
+	 * Not used by the decoration mechanism. Clients may use this for
+	 * whatever they want.
+	 */
 	const char *name;
-	unsigned int size, nr;
-	struct object_decoration *hash;
+
+	/*
+	 * The capacity of "entries".
+	 */
+	unsigned int size;
+
+	/*
+	 * The number of real Git objects (that is, entries with non-NULL
+	 * "base").
+	 */
+	unsigned int nr;
+
+	/*
+	 * The entries. This is an array of size "size", containing nr entries
+	 * with non-NULL "base" and (size - nr) entries with NULL "base".
+	 */
+	struct decoration_entry *entries;
 };
 
+/*
+ * Add an association from the given object to the given pointer (which may be
+ * NULL), returning the previously associated pointer. If there is no previous
+ * association, this function returns NULL.
+ */
 extern void *add_decoration(struct decoration *n, const struct object *obj, void *decoration);
+
+/*
+ * Return the pointer associated to the given object. If there is no
+ * association, this function returns NULL.
+ */
 extern void *lookup_decoration(struct decoration *n, const struct object *obj);
 
 #endif
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index d02f9b39a..fff6aef22 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -8,6 +8,7 @@
 /test-dump-fsmonitor
 /test-dump-split-index
 /test-dump-untracked-cache
+/test-example-decorate
 /test-fake-ssh
 /test-scrap-cache-tree
 /test-genrandom
diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
new file mode 100644
index 000000000..90dc97a9d
--- /dev/null
+++ b/t/helper/test-example-decorate.c
@@ -0,0 +1,74 @@
+#include "cache.h"
+#include "object.h"
+#include "decorate.h"
+
+int cmd_main(int argc, const char **argv)
+{
+	struct decoration n;
+	struct object_id one_oid = { {1} };
+	struct object_id two_oid = { {2} };
+	struct object_id three_oid = { {3} };
+	struct object *one, *two, *three;
+
+	int decoration_a, decoration_b;
+
+	void *ret;
+
+	int i, objects_noticed = 0;
+
+	/*
+	 * The struct must be zero-initialized.
+	 */
+	memset(&n, 0, sizeof(n));
+
+	/*
+	 * Add 2 objects, one with a non-NULL decoration and one with a NULL
+	 * decoration.
+	 */
+	one = lookup_unknown_object(one_oid.hash);
+	two = lookup_unknown_object(two_oid.hash);
+	ret = add_decoration(&n, one, &decoration_a);
+	if (ret)
+		die("BUG: when adding a brand-new object, NULL should be returned");
+	ret = add_decoration(&n, two, NULL);
+	if (ret)
+		die("BUG: when adding a brand-new object, NULL should be returned");
+
+	/*
+	 * When re-adding an already existing object, the old decoration is
+	 * returned.
+	 */
+	ret = add_decoration(&n, one, NULL);
+	if (ret != &decoration_a)
+		die("BUG: when readding an already existing object, existing decoration should be returned");
+	ret = add_decoration(&n, two, &decoration_b);
+	if (ret)
+		die("BUG: when readding an already existing object, existing decoration should be returned");
+
+	/*
+	 * Lookup returns the added declarations, or NULL if the object was
+	 * never added.
+	 */
+	ret = lookup_decoration(&n, one);
+	if (ret)
+		die("BUG: lookup should return added declaration");
+	ret = lookup_decoration(&n, two);
+	if (ret != &decoration_b)
+		die("BUG: lookup should return added declaration");
+	three = lookup_unknown_object(three_oid.hash);
+	ret = lookup_decoration(&n, three);
+	if (ret)
+		die("BUG: lookup for unknown object should return NULL");
+
+	/*
+	 * The user can also loop through all entries.
+	 */
+	for (i = 0; i < n.size; i++) {
+		if (n.entries[i].base)
+			objects_noticed++;
+	}
+	if (objects_noticed != 2)
+		die("BUG: should have 2 objects");
+
+	return 0;
+}
diff --git a/t/t9004-example.sh b/t/t9004-example.sh
new file mode 100755
index 000000000..b28a028f5
--- /dev/null
+++ b/t/t9004-example.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+test_description='check that example code compiles and runs'
+. ./test-lib.sh
+
+test_expect_success 'decorate' '
+	test-example-decorate
+'
+
+test_done
-- 
2.15.1.424.g9478a66081-goog

