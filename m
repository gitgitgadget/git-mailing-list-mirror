Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3C620401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754636AbdFWHCR (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:17 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50046 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754571AbdFWHCN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:13 -0400
X-AuditID: 1207440d-3d1ff70000001be7-27-594cbceebd1b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 38.51.07143.EECBC495; Fri, 23 Jun 2017 03:02:06 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o5o001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:04 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/29] packed_ref_store: move `packed_refs_lock` member here
Date:   Fri, 23 Jun 2017 09:01:23 +0200
Message-Id: <3a9c91842de3c7f836565c45a9d72362103d027e.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqPtuj0+kwcOlChZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGV83tLMWLBfvmLNxdUsDYz7pboY
        OTkkBEwkVt9YxdLFyMUhJLCDSaJvXzeUc4pJYm7ra0aQKjYBXYlFPc1MILaIgJrExLZDYEXM
        ApOYJd5eWwiWEBbwlzjy4xlYA4uAqsSWj8fYQWxegSiJlv0nWSHWyUvsarsIZnMKWEj0TFwO
        ViMkYC6x6vdq1gmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihIQd
        7w7G/+tkDjEKcDAq8fAmnPWOFGJNLCuuzD3EKMnBpCTKqxnpEynEl5SfUpmRWJwRX1Sak1p8
        iFGCg1lJhFdnFVCONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTB27Ib
        qFGwKDU9tSItM6cEIc3EwQkynAdouMdmkOHFBYm5xZnpEPlTjIpS4rwbQJoFQBIZpXlwvbC0
        8IpRHOgVYd5EkCoeYEqB634FNJgJaPCMNWCDSxIRUlINjJPvZipzOE3sStKteVuwetuPd/dm
        nVjjzXNMvsmqZKGN/qQzRuxrBVhMTL13ORo6nrg6od548VnJxxIZ0qoXn9a/7mXecWAx05Yn
        VjFvDlWze4c8NQ25tkNVvkvrO+t6cQH/lrszeRbnt1snNiQwb7bU8taXaYkouPL4btbV/5p9
        l3RCT5peVmIpzkg01GIuKk4EAEpvPxDmAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the `packed_refs_lock` member from `files_ref_store` to
`packed_ref_store`, and rename it to `lock` since it's now more
obvious what it is locking.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c4b8e2f63b..de8293493f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -62,6 +62,12 @@ struct packed_ref_store {
 	 * it might still be current; otherwise, NULL.
 	 */
 	struct packed_ref_cache *cache;
+
+	/*
+	 * Lock used for the "packed-refs" file. Note that this (and
+	 * thus the enclosing `packed_ref_store`) must not be freed.
+	 */
+	struct lock_file lock;
 };
 
 static struct packed_ref_store *packed_ref_store_create(
@@ -87,12 +93,6 @@ struct files_ref_store {
 
 	struct ref_cache *loose;
 
-	/*
-	 * Lock used for the "packed-refs" file. Note that this (and
-	 * thus the enclosing `files_ref_store`) must not be freed.
-	 */
-	struct lock_file packed_refs_lock;
-
 	struct packed_ref_store *packed_ref_store;
 };
 
@@ -125,7 +125,7 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
 	if (refs->packed_ref_store->cache) {
 		struct packed_ref_cache *packed_refs = refs->packed_ref_store->cache;
 
-		if (is_lock_file_locked(&refs->packed_refs_lock))
+		if (is_lock_file_locked(&refs->packed_ref_store->lock))
 			die("BUG: packed-ref cache cleared while locked");
 		refs->packed_ref_store->cache = NULL;
 		release_packed_ref_cache(packed_refs);
@@ -416,7 +416,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 {
 	const char *packed_refs_file = refs->packed_ref_store->path;
 
-	if (!is_lock_file_locked(&refs->packed_refs_lock))
+	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
 		validate_packed_ref_cache(refs);
 
 	if (!refs->packed_ref_store->cache)
@@ -447,7 +447,7 @@ static void add_packed_ref(struct files_ref_store *refs,
 	struct ref_dir *packed_refs;
 	struct ref_entry *packed_entry;
 
-	if (!is_lock_file_locked(&refs->packed_refs_lock))
+	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
 		die("BUG: packed refs not locked");
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
@@ -1351,7 +1351,8 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	}
 
 	if (hold_lock_file_for_update_timeout(
-			    &refs->packed_refs_lock, refs->packed_ref_store->path,
+			    &refs->packed_ref_store->lock,
+			    refs->packed_ref_store->path,
 			    flags, timeout_value) < 0)
 		return -1;
 
@@ -1388,10 +1389,10 @@ static int commit_packed_refs(struct files_ref_store *refs)
 
 	files_assert_main_repository(refs, "commit_packed_refs");
 
-	if (!is_lock_file_locked(&refs->packed_refs_lock))
+	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
 		die("BUG: packed-refs not locked");
 
-	out = fdopen_lock_file(&refs->packed_refs_lock, "w");
+	out = fdopen_lock_file(&refs->packed_ref_store->lock, "w");
 	if (!out)
 		die_errno("unable to fdopen packed-refs descriptor");
 
@@ -1409,7 +1410,7 @@ static int commit_packed_refs(struct files_ref_store *refs)
 	if (ok != ITER_DONE)
 		die("error while iterating over references");
 
-	if (commit_lock_file(&refs->packed_refs_lock)) {
+	if (commit_lock_file(&refs->packed_ref_store->lock)) {
 		save_errno = errno;
 		error = -1;
 	}
@@ -1430,9 +1431,9 @@ static void rollback_packed_refs(struct files_ref_store *refs)
 
 	files_assert_main_repository(refs, "rollback_packed_refs");
 
-	if (!is_lock_file_locked(&refs->packed_refs_lock))
+	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
 		die("BUG: packed-refs not locked");
-	rollback_lock_file(&refs->packed_refs_lock);
+	rollback_lock_file(&refs->packed_ref_store->lock);
 	release_packed_ref_cache(packed_ref_cache);
 	clear_packed_ref_cache(refs);
 }
-- 
2.11.0

