Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53A9320209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdGASb0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:31:26 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:59121 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751919AbdGASbZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:25 -0400
X-AuditID: 1207440c-c65ff70000001e54-0d-5957ea7c1446
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id C5.2E.07764.C7AE7595; Sat,  1 Jul 2017 14:31:24 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBH010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:22 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/30] packed_ref_store: move `packed_refs_path` here
Date:   Sat,  1 Jul 2017 20:30:42 +0200
Message-Id: <aaaee3174089ccefc6e3d628163edfda5de16a4b.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqFvzKjzSYOEKRYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDKe9k1mKzgvU3H06Rz2BsY74l2M
        nBwSAiYSM57+ZO1i5OIQEtjBJHHtzlt2kISQwEkmiQn/kkFsNgFdiUU9zUwgtoiAmsTEtkMs
        IA3MApOYJd5eWwiU4OAQFvCQuHvUBaSGRUBVYvqGGcwgNq9AlMTOh70sEMvkJXa1XWQFsTkF
        LCT+tK1nhthlLtF8sI9lAiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSml
        mxghIcezg/HbOplDjAIcjEo8vBtCwiKFWBPLiitzDzFKcjApifKuvBYaKcSXlJ9SmZFYnBFf
        VJqTWnyIUYKDWUmEN/d5eKQQb0piZVVqUT5MSpqDRUmcV3WJup+QQHpiSWp2ampBahFMVoaD
        Q0mClwkYW0KCRanpqRVpmTklCGkmDk6Q4TxAwxfeBRleXJCYW5yZDpE/xajL8WrC/29MQix5
        +XmpUuK8rS+BigRAijJK8+DmwFLFK0ZxoLeEeSNeAFXxANMM3KRXQEuYgJYIzwgBWVKSiJCS
        amDUWaOwnv/Yqxd2+vlBvW9ub3h3WP9vqIjB3q0fn9+1ezB7s3L7fxal2YLq+nMsspclXjw+
        34r/69JtH6UypCcs994mtXSJiPvLCmPWKdyK58TWzw18kOd4YnPQFqZtfLfO3PZ7unbK2qdu
        C9YEv+J98pBzhmZ94q6zv89P3Pv5q6u2s6CP6nNxNyWW4oxEQy3mouJEAKuE5/PwAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move `packed_refs_path` from `files_ref_store` to `packed_ref_store`,
and rename it to `path` since its meaning is clear from its new
context.

Inline `files_packed_refs_path()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2efb71cee9..c4b8e2f63b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -54,6 +54,9 @@ struct packed_ref_cache {
 struct packed_ref_store {
 	unsigned int store_flags;
 
+	/* The path of the "packed-refs" file: */
+	char *path;
+
 	/*
 	 * A cache of the values read from the `packed-refs` file, if
 	 * it might still be current; otherwise, NULL.
@@ -61,11 +64,13 @@ struct packed_ref_store {
 	struct packed_ref_cache *cache;
 };
 
-static struct packed_ref_store *packed_ref_store_create(unsigned int store_flags)
+static struct packed_ref_store *packed_ref_store_create(
+		const char *path, unsigned int store_flags)
 {
 	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
 
 	refs->store_flags = store_flags;
+	refs->path = xstrdup(path);
 	return refs;
 }
 
@@ -79,7 +84,6 @@ struct files_ref_store {
 
 	char *gitdir;
 	char *gitcommondir;
-	char *packed_refs_path;
 
 	struct ref_cache *loose;
 
@@ -154,8 +158,8 @@ static struct ref_store *files_ref_store_create(const char *gitdir,
 	get_common_dir_noenv(&sb, gitdir);
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
 	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
-	refs->packed_refs_path = strbuf_detach(&sb, NULL);
-	refs->packed_ref_store = packed_ref_store_create(flags);
+	refs->packed_ref_store = packed_ref_store_create(sb.buf, flags);
+	strbuf_release(&sb);
 
 	return ref_store;
 }
@@ -343,11 +347,6 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 	return packed_refs;
 }
 
-static const char *files_packed_refs_path(struct files_ref_store *refs)
-{
-	return refs->packed_refs_path;
-}
-
 static void files_reflog_path(struct files_ref_store *refs,
 			      struct strbuf *sb,
 			      const char *refname)
@@ -401,7 +400,7 @@ static void validate_packed_ref_cache(struct files_ref_store *refs)
 {
 	if (refs->packed_ref_store->cache &&
 	    !stat_validity_check(&refs->packed_ref_store->cache->validity,
-				 files_packed_refs_path(refs)))
+				 refs->packed_ref_store->path))
 		clear_packed_ref_cache(refs);
 }
 
@@ -415,7 +414,7 @@ static void validate_packed_ref_cache(struct files_ref_store *refs)
  */
 static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *refs)
 {
-	const char *packed_refs_file = files_packed_refs_path(refs);
+	const char *packed_refs_file = refs->packed_ref_store->path;
 
 	if (!is_lock_file_locked(&refs->packed_refs_lock))
 		validate_packed_ref_cache(refs);
@@ -1352,7 +1351,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	}
 
 	if (hold_lock_file_for_update_timeout(
-			    &refs->packed_refs_lock, files_packed_refs_path(refs),
+			    &refs->packed_refs_lock, refs->packed_ref_store->path,
 			    flags, timeout_value) < 0)
 		return -1;
 
@@ -1633,7 +1632,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(refs, 0)) {
-		unable_to_lock_message(files_packed_refs_path(refs), errno, err);
+		unable_to_lock_message(refs->packed_ref_store->path, errno, err);
 		return -1;
 	}
 	packed = get_packed_refs(refs);
-- 
2.11.0

