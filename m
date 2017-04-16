Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ADE420A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755410AbdDPGm6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:58 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56017 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755341AbdDPGmy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:54 -0400
X-AuditID: 12074413-f67ff700000077e1-c7-58f3126d9945
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 87.87.30689.D6213F85; Sun, 16 Apr 2017 02:42:53 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGNF025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:51 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 14/20] do_for_each_entry_in_dir(): eliminate `offset` argument
Date:   Sun, 16 Apr 2017 08:41:36 +0200
Message-Id: <3fe7a1f3caf6ca2016d2dbdae9ed300429efc880.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqJsr9DnCYNNPTou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGv/vPWQomSFT8PviFpYHxiXAXIyeHhICJ
        xKTZE1lAbCGBHUwSm6bndjFyAdknmCQe/37LDpJgE9CVWNTTzARiiwioSUxsO8QCUsQs8JhJ
        4u+ybrBuYYFAiXkb1rGB2CwCqhIfPkPYvAJREt+e/WaD2CYvsavtIiuIzSlgITHl7gaozeYS
        249fZZ7AyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkioCe9g3HVS
        7hCjAAejEg+vhf+nCCHWxLLiytxDjJIcTEqivDL/gUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVE
        eJNZPkcI8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeKMFgRoFi1LT
        UyvSMnNKENJMHJwgw3mAhqeD1PAWFyTmFmemQ+RPMSpKifP+EABKCIAkMkrz4HphqeAVozjQ
        K8K8tSDtPMA0Atf9CmgwE9BghskfQAaXJCKkpBoYvXWW/dER9TxWfbjSOuum3A++jf/n6LFM
        Zon53Xs1P4jTZ0Pqxk3cIq0Ht8s0/19ZxpAavaN+ruKWkq7VjNV7TR5Wvn27YV6Yt9tftz/u
        06+bZC57EXQn5RbP/eTPuUWPl781OTgvkHXldYHJInOsl160aXnCz28evjV5wY+PVzj1DNuD
        otOvKLEUZyQaajEXFScCAOVIDBPgAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was never used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c |  4 ++--
 refs/ref-cache.c     |  6 +++---
 refs/ref-cache.h     | 11 +++++------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 079ba941ef..c0550ad9d6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1387,7 +1387,7 @@ static int commit_packed_refs(struct files_ref_store *refs)
 
 	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
 	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
-				 0, write_packed_entry_fn, out);
+				 write_packed_entry_fn, out);
 
 	if (commit_lock_file(packed_ref_cache->lock)) {
 		save_errno = errno;
@@ -1581,7 +1581,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	lock_packed_refs(refs, LOCK_DIE_ON_ERROR);
 	cbdata.packed_refs = get_packed_refs(refs);
 
-	do_for_each_entry_in_dir(get_loose_refs(refs), 0,
+	do_for_each_entry_in_dir(get_loose_refs(refs),
 				 pack_if_possible_fn, &cbdata);
 
 	if (commit_packed_refs(refs))
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 44440e0c13..38d4c31985 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -307,18 +307,18 @@ static void sort_ref_dir(struct ref_dir *dir)
 	dir->sorted = dir->nr = i;
 }
 
-int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
+int do_for_each_entry_in_dir(struct ref_dir *dir,
 			     each_ref_entry_fn fn, void *cb_data)
 {
 	int i;
 	assert(dir->sorted == dir->nr);
-	for (i = offset; i < dir->nr; i++) {
+	for (i = 0; i < dir->nr; i++) {
 		struct ref_entry *entry = dir->entries[i];
 		int retval;
 		if (entry->flag & REF_DIR) {
 			struct ref_dir *subdir = get_ref_dir(entry);
 			sort_ref_dir(subdir);
-			retval = do_for_each_entry_in_dir(subdir, 0, fn, cb_data);
+			retval = do_for_each_entry_in_dir(subdir, fn, cb_data);
 		} else {
 			retval = fn(entry, cb_data);
 		}
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index ed51e80d88..6eecdf4276 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -258,13 +258,12 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_dir *dir);
 typedef int each_ref_entry_fn(struct ref_entry *entry, void *cb_data);
 
 /*
- * Call fn for each reference in dir that has index in the range
- * offset <= index < dir->nr.  Recurse into subdirectories that are in
- * that index range, sorting them before iterating.  This function
- * does not sort dir itself; it should be sorted beforehand.  fn is
- * called for all references, including broken ones.
+ * Call `fn` for each reference in `dir`. Recurse into subdirectories,
+ * sorting them before iterating. This function does not sort `dir`
+ * itself; it should be sorted beforehand. `fn` is called for all
+ * references, including broken ones.
  */
-int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
+int do_for_each_entry_in_dir(struct ref_dir *dir,
 			     each_ref_entry_fn fn, void *cb_data);
 
 /*
-- 
2.11.0

