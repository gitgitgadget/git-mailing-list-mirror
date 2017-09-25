Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 401EB20A2B
	for <e@80x24.org>; Mon, 25 Sep 2017 08:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934078AbdIYIBT (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:01:19 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:43121 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934066AbdIYIBK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:01:10 -0400
X-AuditID: 12074413-38bff70000007929-e4-59c8b7c5a5c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id EB.A8.31017.5C7B8C95; Mon, 25 Sep 2017 04:01:09 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6d027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:01:07 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 19/21] ref_cache: remove support for storing peeled values
Date:   Mon, 25 Sep 2017 10:00:16 +0200
Message-Id: <3b6ee2c23079724e5381aec77ba82e18d0088600.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqHt0+4lIgy+/lSzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZSzqPcdecFSjYunxK4wNjJcVuhg5
        OSQETCQuL/7H3sXIxSEksINJYlPXaVYI5xSTRPOs+8wgVWwCuhKLepqZQGwRATWJiW2HWECK
        mAVWMktM2nqFFSQhLOAr8WL5ORYQm0VAVWLKnOdgcV6BKIlth/4wQayTlzj34DbYUE4BC4k3
        Z46wgdhCAuYS52/cYp3AyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukm
        RkjQCe9g3HVS7hCjAAejEg9vxL/jkUKsiWXFlbmHGCU5mJREee/ynYgU4kvKT6nMSCzOiC8q
        zUktPsQowcGsJMJ7bDVQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEk
        wWsKjC4hwaLU9NSKtMycEoQ0EwcnyHAeoOHLt4EMLy5IzC3OTIfIn2LU5ei4efcPkxBLXn5e
        qpQ47waQIgGQoozSPLg5sGTxilEc6C1h3oUgVTzARAM36RXQEiagJb1TwZaUJCKkpBoYuXP+
        GBc8K2MrP3w/7MUbwalq3+2/t4U65R+f92LiTM6G1le/Z/dw+Jvo7+x4X/BglVy95/cjed+7
        kh13CLzcm/rAcE6Mcxf3AwvDeouzsU/EmRuFN0fyyzlZS684uauOv+z2g9MxP/X9F3w9bRQU
        3BJc9d/vhn2p36VPP63mzA166S54wPinEktxRqKhFnNRcSIA+40/W/ECAAA=
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
index 3829e9c294..66e5525174 100644
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

