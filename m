Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF3420281
	for <e@80x24.org>; Fri, 29 Sep 2017 22:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbdI2Wy2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 18:54:28 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:46477 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbdI2Wy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 18:54:26 -0400
Received: by mail-pf0-f173.google.com with SMTP id r68so496055pfj.3
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0gtSpB0Pir2WhAUWQhIaSTxq8VhgVCe+pfhx3LcTn8M=;
        b=KScAKaoXAM0tEsldWlf//+2W1LRPh0hiyHeS/rSU3aUX9L4Ifa+c30hP5KRMk4v2lJ
         K2NNBIT9aDWmznLZDjPvujY/t4IQE9rRJzEN/C5i0L9afcx/oJCIsbkI4QqoKe0aPaID
         DSY1u1K5taVxMfzhUpnJslUtqHZ9dwY5T/gWO9MudwlH+p40z2CXROrcKuJOAHx8xTT5
         Bq5c+TPvr++fgqFogo5zOpiYSEEyPfraolVjDzEF5sj0xXHprJUoTukAgxZkdkxzdWhP
         HyRq00hIZ/4c/ikYJD+TBTfm/FUb3mw0prJucEmp6YMNPbuWXBLKqBnf+Ag/hKdNLGcR
         CqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0gtSpB0Pir2WhAUWQhIaSTxq8VhgVCe+pfhx3LcTn8M=;
        b=VyI/3ItnSX2ro86q6fw31MIrlNSuJbjRnvswbZG/tONMqWA0mOiQo5ercf0WM4O72y
         nUoNPrYfXMhkfjDKr5TWY2p32ZpSHuudSgGB5pCGvttovEs1HFpRhu+ajEQleM9mVmtB
         rjdmJfo7xymOIvRxCE98YtDk59Hk7GNHL6nH+slbT4MjWjVxuuaq03l5GhbIaMbX/LP3
         YDKLIJzmQxIpLH5UuOqX+qg3zFYlr+2bdb7snes6Gg00Rlz1uZkhZeD3IbkF0t8KS7d/
         a5nDCipUevkzb/5OglLdWES+tpojKyVQzlNe3ydbeoWvei8/qDbRK16M+avSL+QFU/7D
         N8tw==
X-Gm-Message-State: AHPjjUhu1n9esHhsCUuZyqdboLuePpR0d8i09cNO/xW8f3GqR+lMcVTQ
        I4nDMGCbqHLgsU4gVq7298HC3GYQA6w=
X-Google-Smtp-Source: AOwi7QDDcp9j99cfcCjIYK0vL2flrRKWu3X0j9mnS8ucTvezrdiSxBaa1ekI4HrXAgdw+8B2f77jGQ==
X-Received: by 10.84.237.9 with SMTP id s9mr8412902plk.187.1506725665807;
        Fri, 29 Sep 2017 15:54:25 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id l131sm8372498pga.24.2017.09.29.15.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 15:54:24 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v2] oidmap: map with OID as key
Date:   Fri, 29 Sep 2017 15:54:22 -0700
Message-Id: <20170929225422.81467-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.2.607.g89a6f60d5.dirty
In-Reply-To: <20170927221910.164552-1-jonathantanmy@google.com>
References: <20170927221910.164552-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to using the hashmap in hashmap.c, but with an
easier-to-use API. In particular, custom entry comparisons no longer
need to be written, and lookups can be done without constructing a
temporary entry structure.

This is implemented as a thin wrapper over the hashmap API. In
particular, this means that there is an additional 4-byte overhead due
to the fact that the first 4 bytes of the hash is redundantly stored.
For now, I'm taking the simpler approach, but if need be, we can
reimplement oidmap without affecting the callers significantly.

oidset has been updated to use oidmap.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Some replies to v1 [1] [2] seem to indicate that simpler non-duplicated
code should be preferred over optimizing away the storage of the 4-byte
hash code, and I have no objection to that, so I have updated this code
to be a thin wrapper over hashmap with the 4-byte overhead.

After this patch, if the 4-byte overhead is found to be too much, we can
migrate to something similar to v1 relatively easily.

I decided not to go with the util pointer method because we will not be
able to migrate away from it so easily if need be.

[1] https://public-inbox.org/git/xmqqr2ur348z.fsf@gitster.mtv.corp.google.com/
[2] https://public-inbox.org/git/20170929192624.4ukvpjujgiyzgibb@sigill.intra.peff.net/
---
 Makefile     |  1 +
 fetch-pack.c |  2 +-
 oidmap.c     | 51 +++++++++++++++++++++++++++++++++++++++++++++
 oidmap.h     | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 oidset.c     | 36 +++++++-------------------------
 oidset.h     |  6 ++++--
 6 files changed, 133 insertions(+), 31 deletions(-)
 create mode 100644 oidmap.c
 create mode 100644 oidmap.h

diff --git a/Makefile b/Makefile
index ed4ca438b..64136dde4 100644
--- a/Makefile
+++ b/Makefile
@@ -821,6 +821,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
+LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
 LIB_OBJS += packfile.o
 LIB_OBJS += pack-bitmap.o
diff --git a/fetch-pack.c b/fetch-pack.c
index 105506e9a..008b25d3d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -611,7 +611,7 @@ static int tip_oids_contain(struct oidset *tip_oids,
 	 * add to "newlist" between calls, the additions will always be for
 	 * oids that are already in the set.
 	 */
-	if (!tip_oids->map.tablesize) {
+	if (!tip_oids->map.map.tablesize) {
 		add_refs_to_oidset(tip_oids, unmatched);
 		add_refs_to_oidset(tip_oids, newlist);
 	}
diff --git a/oidmap.c b/oidmap.c
new file mode 100644
index 000000000..6db4fffcd
--- /dev/null
+++ b/oidmap.c
@@ -0,0 +1,51 @@
+#include "cache.h"
+#include "oidmap.h"
+
+static int cmpfn(const void *hashmap_cmp_fn_data,
+		 const void *entry, const void *entry_or_key,
+		 const void *keydata)
+{
+	const struct oidmap_entry *entry_ = entry;
+	if (keydata)
+		return oidcmp(&entry_->oid, (const struct object_id *) keydata);
+	return oidcmp(&entry_->oid,
+		      &((const struct oidmap_entry *) entry_or_key)->oid);
+}
+
+static int hash(const struct object_id *oid)
+{
+	int hash;
+	memcpy(&hash, oid->hash, sizeof(hash));
+	return hash;
+}
+
+void oidmap_init(struct oidmap *map, size_t initial_size)
+{
+	hashmap_init(&map->map, cmpfn, NULL, initial_size);
+}
+
+void oidmap_free(struct oidmap *map, int free_entries)
+{
+	if (!map)
+		return;
+	hashmap_free(&map->map, free_entries);
+}
+
+void *oidmap_get(const struct oidmap *map, const struct object_id *key)
+{
+	return hashmap_get_from_hash(&map->map, hash(key), key);
+}
+
+void *oidmap_remove(struct oidmap *map, const struct object_id *key)
+{
+	struct hashmap_entry entry;
+	hashmap_entry_init(&entry, hash(key));
+	return hashmap_remove(&map->map, &entry, key);
+}
+
+void *oidmap_put(struct oidmap *map, void *entry)
+{
+	struct oidmap_entry *to_put = entry;
+	hashmap_entry_init(&to_put->internal_entry, hash(&to_put->oid));
+	return hashmap_put(&map->map, to_put);
+}
diff --git a/oidmap.h b/oidmap.h
new file mode 100644
index 000000000..18f54cde1
--- /dev/null
+++ b/oidmap.h
@@ -0,0 +1,68 @@
+#ifndef OIDMAP_H
+#define OIDMAP_H
+
+#include "hashmap.h"
+
+/*
+ * struct oidmap_entry is a structure representing an entry in the hash table,
+ * which must be used as first member of user data structures.
+ *
+ * Users should set the oid field. oidmap_put() will populate the
+ * internal_entry field.
+ */
+struct oidmap_entry {
+	/* For internal use only */
+	struct hashmap_entry internal_entry;
+
+	struct object_id oid;
+};
+
+struct oidmap {
+	struct hashmap map;
+};
+
+#define OIDMAP_INIT { { NULL } }
+
+/*
+ * Initializes an oidmap structure.
+ *
+ * `map` is the oidmap to initialize.
+ *
+ * If the total number of entries is known in advance, the `initial_size`
+ * parameter may be used to preallocate a sufficiently large table and thus
+ * prevent expensive resizing. If 0, the table is dynamically resized.
+ */
+extern void oidmap_init(struct oidmap *map, size_t initial_size);
+
+/*
+ * Frees an oidmap structure and allocated memory.
+ *
+ * If `free_entries` is true, each oidmap_entry in the map is freed as well
+ * using stdlibs free().
+ */
+extern void oidmap_free(struct oidmap *map, int free_entries);
+
+/*
+ * Returns the oidmap entry for the specified oid, or NULL if not found.
+ */
+extern void *oidmap_get(const struct oidmap *map,
+			const struct object_id *key);
+
+/*
+ * Adds or replaces an oidmap entry.
+ *
+ * ((struct oidmap_entry *) entry)->internal_entry will be populated by this
+ * function.
+ *
+ * Returns the replaced entry, or NULL if not found (i.e. the entry was added).
+ */
+extern void *oidmap_put(struct oidmap *map, void *entry);
+
+/*
+ * Removes an oidmap entry matching the specified oid.
+ *
+ * Returns the removed entry, or NULL if not found.
+ */
+extern void *oidmap_remove(struct oidmap *map, const struct object_id *key);
+
+#endif
diff --git a/oidset.c b/oidset.c
index a6a08ba52..f1f874aaa 100644
--- a/oidset.c
+++ b/oidset.c
@@ -1,50 +1,30 @@
 #include "cache.h"
 #include "oidset.h"
 
-struct oidset_entry {
-	struct hashmap_entry hash;
-	struct object_id oid;
-};
-
-static int oidset_hashcmp(const void *unused_cmp_data,
-			  const void *va, const void *vb,
-			  const void *vkey)
-{
-	const struct oidset_entry *a = va, *b = vb;
-	const struct object_id *key = vkey;
-	return oidcmp(&a->oid, key ? key : &b->oid);
-}
-
 int oidset_contains(const struct oidset *set, const struct object_id *oid)
 {
-	struct hashmap_entry key;
-
-	if (!set->map.cmpfn)
+	if (!set->map.map.tablesize)
 		return 0;
-
-	hashmap_entry_init(&key, sha1hash(oid->hash));
-	return !!hashmap_get(&set->map, &key, oid);
+	return !!oidmap_get(&set->map, oid);
 }
 
 int oidset_insert(struct oidset *set, const struct object_id *oid)
 {
-	struct oidset_entry *entry;
-
-	if (!set->map.cmpfn)
-		hashmap_init(&set->map, oidset_hashcmp, NULL, 0);
+	struct oidmap_entry *entry;
 
-	if (oidset_contains(set, oid))
+	if (!set->map.map.tablesize)
+		oidmap_init(&set->map, 0);
+	else if (oidset_contains(set, oid))
 		return 1;
 
 	entry = xmalloc(sizeof(*entry));
-	hashmap_entry_init(&entry->hash, sha1hash(oid->hash));
 	oidcpy(&entry->oid, oid);
 
-	hashmap_add(&set->map, entry);
+	oidmap_put(&set->map, entry);
 	return 0;
 }
 
 void oidset_clear(struct oidset *set)
 {
-	hashmap_free(&set->map, 1);
+	oidmap_free(&set->map, 1);
 }
diff --git a/oidset.h b/oidset.h
index b7eaab5b8..f4c9e0f9c 100644
--- a/oidset.h
+++ b/oidset.h
@@ -1,6 +1,8 @@
 #ifndef OIDSET_H
 #define OIDSET_H
 
+#include "oidmap.h"
+
 /**
  * This API is similar to sha1-array, in that it maintains a set of object ids
  * in a memory-efficient way. The major differences are:
@@ -17,10 +19,10 @@
  * A single oidset; should be zero-initialized (or use OIDSET_INIT).
  */
 struct oidset {
-	struct hashmap map;
+	struct oidmap map;
 };
 
-#define OIDSET_INIT { { NULL } }
+#define OIDSET_INIT { OIDMAP_INIT }
 
 /**
  * Returns true iff `set` contains `oid`.
-- 
2.14.2.822.g60be5d43e6-goog

