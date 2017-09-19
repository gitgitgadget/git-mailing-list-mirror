Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E1C720281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbdISGXW (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:23:22 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45753 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751497AbdISGXS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:23:18 -0400
X-AuditID: 1207440e-be1ff70000007085-f8-59c0b7d50aa9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id C0.76.28805.5D7B0C95; Tue, 19 Sep 2017 02:23:17 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1q002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:23:15 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 19/21] ref_cache: remove support for storing peeled values
Date:   Tue, 19 Sep 2017 08:22:27 +0200
Message-Id: <cdc0dee1402b2b7f0d27c8d140f472437afd2d6c.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqHtt+4FIg89HWS3WPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZdyc3sRUcFSj4lp/F3MD42WFLkZO
        DgkBE4n9T06xdjFycQgJ7GCSmNC3iQnCOcUkMbPxEzNIFZuArsSinmYmEFtEQE1iYtshFpAi
        ZoGVzBKTtl5hBUkIC/hK3NjwAMxmEVCVePLnN5DNwcErECXRcAtqm7zEuQe3wWZyClhINO/Z
        zgJSIiRgLnHgaPEERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MUIC
        jm8HY/t6mUOMAhyMSjy8Atf2RwqxJpYVV+YeYpTkYFIS5Q3bdCBSiC8pP6UyI7E4I76oNCe1
        +BCjBAezkgjvoUVAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBK8i
        MLKEBItS01Mr0jJzShDSTBycIMN5gIargNTwFhck5hZnpkPkTzHqcnTcvPuHSYglLz8vVUqc
        9/42oCIBkKKM0jy4ObBE8YpRHOgtYV5DkFE8wCQDN+kV0BImoCXZG8CWlCQipKQaGIO/Fxu4
        T/4a5WprdCfCrEGhvnmNwrSlZlYbzbKfnBFxX2K8suKcW8+psjKR4sQZNvyntnIYe8qUT111
        IJ1lIkf8nK8vfjZd+HluySGjubuSv6yzjlj4xW5/EfM5xbnPrTL/7Zb3uz591Y9MaYuv5QlP
        ZYPPhG6u/5P3bWJa6RaNDwoOizrE+5VYijMSDbWYi4oTAT9tjljvAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the `packed-refs` backend doesn't use `ref_cache`, there is
nobody left who might want to store peeled values of references in
`ref_cache`. So remove that feature.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c |  9 ++++++++-
 refs/ref-cache.c      | 42 +-----------------------------------------
 refs/ref-cache.h      | 32 ++------------------------------
 3 files changed, 11 insertions(+), 72 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b4a01637a6..b1571872fa 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2,7 +2,6 @@
 #include "../config.h"
 #include "../refs.h"
 #include "refs-internal.h"
-#include "ref-cache.h"
 #include "packed-backend.h"
 #include "../iterator.h"
 #include "../lockfile.h"
@@ -226,6 +225,14 @@ static NORETURN void die_invalid_line(const char *path,
 
 }
 
+/*
+ * This value is set in `base.flags` if the peeled value of the
+ * current reference is known. In that case, `peeled` contains the
+ * correct peeled value for the reference, which might be `null_sha1`
+ * if the reference is not a tag or if it is broken.
+ */
+#define REF_KNOWS_PEELED 0x40
+
 /*
  * An iterator over a packed-refs file that is currently mmapped.
  */
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 54dfb5218c..4f850e1b5c 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -38,7 +38,6 @@ struct ref_entry *create_ref_entry(const char *refname,
 
 	FLEX_ALLOC_STR(ref, name, refname);
 	oidcpy(&ref->u.value.oid, oid);
-	oidclr(&ref->u.value.peeled);
 	ref->flag = flag;
 	return ref;
 }
@@ -491,49 +490,10 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	}
 }
 
-enum peel_status peel_entry(struct ref_entry *entry, int repeel)
-{
-	enum peel_status status;
-
-	if (entry->flag & REF_KNOWS_PEELED) {
-		if (repeel) {
-			entry->flag &= ~REF_KNOWS_PEELED;
-			oidclr(&entry->u.value.peeled);
-		} else {
-			return is_null_oid(&entry->u.value.peeled) ?
-				PEEL_NON_TAG : PEEL_PEELED;
-		}
-	}
-	if (entry->flag & REF_ISBROKEN)
-		return PEEL_BROKEN;
-	if (entry->flag & REF_ISSYMREF)
-		return PEEL_IS_SYMREF;
-
-	status = peel_object(entry->u.value.oid.hash, entry->u.value.peeled.hash);
-	if (status == PEEL_PEELED || status == PEEL_NON_TAG)
-		entry->flag |= REF_KNOWS_PEELED;
-	return status;
-}
-
 static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
-	struct cache_ref_iterator *iter =
-		(struct cache_ref_iterator *)ref_iterator;
-	struct cache_ref_iterator_level *level;
-	struct ref_entry *entry;
-
-	level = &iter->levels[iter->levels_nr - 1];
-
-	if (level->index == -1)
-		die("BUG: peel called before advance for cache iterator");
-
-	entry = level->dir->entries[level->index];
-
-	if (peel_entry(entry, 0))
-		return -1;
-	oidcpy(peeled, &entry->u.value.peeled);
-	return 0;
+	return peel_object(ref_iterator->oid->hash, peeled->hash);
 }
 
 static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index a082bfb06c..eda65e73ed 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -38,14 +38,6 @@ struct ref_value {
 	 * referred to by the last reference in the symlink chain.
 	 */
 	struct object_id oid;
-
-	/*
-	 * If REF_KNOWS_PEELED, then this field holds the peeled value
-	 * of this reference, or null if the reference is known not to
-	 * be peelable.  See the documentation for peel_ref() for an
-	 * exact definition of "peelable".
-	 */
-	struct object_id peeled;
 };
 
 /*
@@ -97,21 +89,14 @@ struct ref_dir {
  * public values; see refs.h.
  */
 
-/*
- * The field ref_entry->u.value.peeled of this value entry contains
- * the correct peeled value for the reference, which might be
- * null_sha1 if the reference is not a tag or if it is broken.
- */
-#define REF_KNOWS_PEELED 0x10
-
 /* ref_entry represents a directory of references */
-#define REF_DIR 0x20
+#define REF_DIR 0x10
 
 /*
  * Entry has not yet been read from disk (used only for REF_DIR
  * entries representing loose references)
  */
-#define REF_INCOMPLETE 0x40
+#define REF_INCOMPLETE 0x20
 
 /*
  * A ref_entry represents either a reference or a "subdirectory" of
@@ -252,17 +237,4 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 					      const char *prefix,
 					      int prime_dir);
 
-/*
- * Peel the entry (if possible) and return its new peel_status.  If
- * repeel is true, re-peel the entry even if there is an old peeled
- * value that is already stored in it.
- *
- * It is OK to call this function with a packed reference entry that
- * might be stale and might even refer to an object that has since
- * been garbage-collected.  In such a case, if the entry has
- * REF_KNOWS_PEELED then leave the status unchanged and return
- * PEEL_PEELED or PEEL_NON_TAG; otherwise, return PEEL_INVALID.
- */
-enum peel_status peel_entry(struct ref_entry *entry, int repeel);
-
 #endif /* REFS_REF_CACHE_H */
-- 
2.14.1

