Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F74E20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbdGASb0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:31:26 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59448 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751968AbdGASbY (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:24 -0400
X-AuditID: 1207440f-b69ff7000000740c-dc-5957ea772dfd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.41.29708.87AE7595; Sat,  1 Jul 2017 14:31:22 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBF010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:18 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/30] add_packed_ref(): teach function to overwrite existing refs
Date:   Sat,  1 Jul 2017 20:30:40 +0200
Message-Id: <7f88f3ecbbaccc6d5f517494a1c33c063967b8ba.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqFv1KjzS4MNFUYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDLu7/jNVDBbvuJKy17mBsabkl2M
        nBwSAiYSk27MYgOxhQR2MEk0b07sYuQCsk8ySexdchsswSagK7Gop5kJxBYRUJOY2HaIBaSI
        WWASs8TbawvBEsICoRI923aygtgsAqoSH3c+ZQaxeQWiJJ7/388IsU1eYlfbRbAaTgELiT9t
        65khNptLNB/sY5nAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6JXm5miV5qSukmRkjQ
        8e9g7Fovc4hRgINRiYd3Q0hYpBBrYllxZe4hRkkOJiVR3pXXQiOF+JLyUyozEosz4otKc1KL
        DzFKcDArifDmPg+PFOJNSaysSi3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfBO
        egnUKFiUmp5akZaZU4KQZuLgBBnOAzR84V2Q4cUFibnFmekQ+VOMuhyvJvz/xiTEkpeflyol
        ztsKMkgApCijNA9uDixZvGIUB3pLmDfiBVAVDzDRwE16BbSECWiJ8IwQkCUliQgpqQZGLrMY
        65XC3ZyBlj4Tz81+WasUlhP4j+GV5BGOvPQpPUzrHk7TYdi8aqNzxv/QyX15J1OU5BtnXzrS
        cPlDuLhW0WFDgeJc09mN8cnZJx3TLeZkqHx+VbHsy/T055MtHK4uO7Tv447XrlKaSyZZ/H32
        gFs9SmZjos7p2x/mZp2JWGmqHr42kkNHiaU4I9FQi7moOBEA2d1oE/ECAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach `add_packed_ref()` to overwrite an existing entry if one already
exists for the specified `refname`. This means that we can call it
from `files_pack_refs()`, thereby reducing the amount that the latter
function needs to know about the internals of packed-reference
handling.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b040bb3b0a..87cecde231 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -413,15 +413,16 @@ static struct ref_dir *get_packed_refs(struct files_ref_store *refs)
 }
 
 /*
- * Add a reference to the in-memory packed reference cache.  This may
- * only be called while the packed-refs file is locked (see
- * lock_packed_refs()).  To actually write the packed-refs file, call
- * commit_packed_refs().
+ * Add or overwrite a reference in the in-memory packed reference
+ * cache. This may only be called while the packed-refs file is locked
+ * (see lock_packed_refs()). To actually write the packed-refs file,
+ * call commit_packed_refs().
  */
 static void add_packed_ref(struct files_ref_store *refs,
 			   const char *refname, const struct object_id *oid)
 {
-	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
+	struct ref_dir *packed_refs;
+	struct ref_entry *packed_entry;
 
 	if (!is_lock_file_locked(&refs->packed_refs_lock))
 		die("BUG: packed refs not locked");
@@ -429,8 +430,17 @@ static void add_packed_ref(struct files_ref_store *refs,
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
 
-	add_ref_entry(get_packed_ref_dir(packed_ref_cache),
-		      create_ref_entry(refname, oid, REF_ISPACKED));
+	packed_refs = get_packed_refs(refs);
+	packed_entry = find_ref_entry(packed_refs, refname);
+	if (packed_entry) {
+		/* Overwrite the existing entry: */
+		oidcpy(&packed_entry->u.value.oid, oid);
+		packed_entry->flag = REF_ISPACKED;
+		oidclr(&packed_entry->u.value.peeled);
+	} else {
+		packed_entry = create_ref_entry(refname, oid, REF_ISPACKED);
+		add_ref_entry(packed_refs, packed_entry);
+	}
 }
 
 /*
@@ -1526,12 +1536,10 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
 			       "pack_refs");
 	struct ref_iterator *iter;
-	struct ref_dir *packed_refs;
 	int ok;
 	struct ref_to_prune *refs_to_prune = NULL;
 
 	lock_packed_refs(refs, LOCK_DIE_ON_ERROR);
-	packed_refs = get_packed_refs(refs);
 
 	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
@@ -1540,8 +1548,6 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		 * in the packed ref cache. If the reference should be
 		 * pruned, also add it to refs_to_prune.
 		 */
-		struct ref_entry *packed_entry;
-
 		if (!should_pack_ref(iter->refname, iter->oid, iter->flags,
 				     flags))
 			continue;
@@ -1552,17 +1558,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		 * we don't copy the peeled status, because we want it
 		 * to be re-peeled.
 		 */
-		packed_entry = find_ref_entry(packed_refs, iter->refname);
-		if (packed_entry) {
-			/* Overwrite existing packed entry with info from loose entry */
-			packed_entry->flag = REF_ISPACKED;
-			oidcpy(&packed_entry->u.value.oid, iter->oid);
-		} else {
-			packed_entry = create_ref_entry(iter->refname, iter->oid,
-							REF_ISPACKED);
-			add_ref_entry(packed_refs, packed_entry);
-		}
-		oidclr(&packed_entry->u.value.peeled);
+		add_packed_ref(refs, iter->refname, iter->oid);
 
 		/* Schedule the loose reference for pruning if requested. */
 		if ((flags & PACK_REFS_PRUNE)) {
-- 
2.11.0

