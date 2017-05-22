Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 598922023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934706AbdEVOSq (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:46 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44117 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934407AbdEVOSg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:36 -0400
X-AuditID: 1207440f-701ff700000004e5-0c-5922f339eaf0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A7.45.01253.933F2295; Mon, 22 May 2017 10:18:34 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24K023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:31 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/25] files_ref_store: put the packed files lock directly in this struct
Date:   Mon, 22 May 2017 16:17:41 +0200
Message-Id: <65189c542226105b83163559192fe647484328d6.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqGv1WSnSoOMUs8XaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8WTuXeZLW6vmM9sseTha2aL7ilvGS1+tPQwW2ze3M7iwOXx9/0HJo+ds+6y
        eyzYVOrx8FUXu0dX+xE2j2e9exg9Ll5S9vi8SS6AI4rLJiU1J7MstUjfLoEr49vkT8wFrYoV
        H6ZeYm1g3CfdxcjJISFgIrF8xnVmEFtIYAeTxJ6PPhD2KSaJ5q38IDabgK7Eop5mJhBbREBN
        YmLbIZYuRi4OZoENzBJvpq8GSwgLxEhcm7UbzGYRUJV4tewnI4jNKxAlcWP1UVaIZfISu9ou
        gtmcAhYSv2cdYIJYZi7R+281ywRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE30cjNL
        9FJTSjcxQsKQfwdj13qZQ4wCHIxKPLwaj5UihVgTy4orcw8xSnIwKYnyHn0DFOJLyk+pzEgs
        zogvKs1JLT7EKMHBrCTCq30XKMebklhZlVqUD5OS5mBREudVX6LuJySQnliSmp2aWpBaBJOV
        4eBQkuDV+wTUKFiUmp5akZaZU4KQZuLgBBnOAzR8zQeQ4cUFibnFmekQ+VOMilLivAYgzQIg
        iYzSPLheWJp4xSgO9IowbyFIFQ8wxcB1vwIazAQ02PqZPMjgkkSElFQDY2kdy50N5su8zBiq
        Fq7WjmfbWFFvmdOQPOul3qf5Ny7FLHw1+4u2yFy+pGUvMpZ0Lt/eky2nx9+57Y21ml3p/McC
        c5Krf+snhDVO4f3Lkl+/tjMy9QLn2zOqEtV/t79eeVR6Z15E1BGlBV2/X/2fd0Ti4qGXk7Nq
        nz2fdC80iudme9yhSMX4ViWW4oxEQy3mouJEAB/BSljuAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a global `lock_file` instance for the main
"packed-refs" file and using a pointer in `files_ref_store` to keep
track of whether it is locked, embed the `lock_file` instance directly
in the `files_ref_store` struct and use the new
`is_lock_file_locked()` function to keep track of whether it is
locked. This keeps related data together and makes the main reference
store less of a special case.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bfc555a417..1db40432af 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -63,16 +63,12 @@ struct files_ref_store {
 	struct packed_ref_cache *packed;
 
 	/*
-	 * Iff the packed-refs file associated with this instance is
-	 * currently locked for writing, this points at the associated
-	 * lock (which is owned by somebody else).
+	 * Lock used for the "packed-refs" file. Note that this (and
+	 * thus the enclosing `files_ref_store`) must not be freed.
 	 */
-	struct lock_file *packed_refs_lock;
+	struct lock_file packed_refs_lock;
 };
 
-/* Lock used for the main packed-refs file: */
-static struct lock_file packlock;
-
 /*
  * Increment the reference count of *packed_refs.
  */
@@ -102,7 +98,7 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
 	if (refs->packed) {
 		struct packed_ref_cache *packed_refs = refs->packed;
 
-		if (refs->packed_refs_lock)
+		if (is_lock_file_locked(&refs->packed_refs_lock))
 			die("BUG: packed-ref cache cleared while locked");
 		refs->packed = NULL;
 		release_packed_ref_cache(packed_refs);
@@ -394,7 +390,7 @@ static void add_packed_ref(struct files_ref_store *refs,
 {
 	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
 
-	if (!refs->packed_refs_lock)
+	if (!is_lock_file_locked(&refs->packed_refs_lock))
 		die("BUG: packed refs not locked");
 	add_ref_entry(get_packed_ref_dir(packed_ref_cache),
 		      create_ref_entry(refname, oid, REF_ISPACKED, 1));
@@ -1288,7 +1284,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	}
 
 	if (hold_lock_file_for_update_timeout(
-			    &packlock, files_packed_refs_path(refs),
+			    &refs->packed_refs_lock, files_packed_refs_path(refs),
 			    flags, timeout_value) < 0)
 		return -1;
 	/*
@@ -1298,7 +1294,6 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	 * the packed-refs file.
 	 */
 	packed_ref_cache = get_packed_ref_cache(refs);
-	refs->packed_refs_lock = &packlock;
 	/* Increment the reference count to prevent it from being freed: */
 	acquire_packed_ref_cache(packed_ref_cache);
 	return 0;
@@ -1321,10 +1316,10 @@ static int commit_packed_refs(struct files_ref_store *refs)
 
 	files_assert_main_repository(refs, "commit_packed_refs");
 
-	if (!refs->packed_refs_lock)
+	if (!is_lock_file_locked(&refs->packed_refs_lock))
 		die("BUG: packed-refs not locked");
 
-	out = fdopen_lock_file(refs->packed_refs_lock, "w");
+	out = fdopen_lock_file(&refs->packed_refs_lock, "w");
 	if (!out)
 		die_errno("unable to fdopen packed-refs descriptor");
 
@@ -1342,11 +1337,10 @@ static int commit_packed_refs(struct files_ref_store *refs)
 	if (ok != ITER_DONE)
 		die("error while iterating over references");
 
-	if (commit_lock_file(refs->packed_refs_lock)) {
+	if (commit_lock_file(&refs->packed_refs_lock)) {
 		save_errno = errno;
 		error = -1;
 	}
-	refs->packed_refs_lock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
 	errno = save_errno;
 	return error;
@@ -1364,10 +1358,9 @@ static void rollback_packed_refs(struct files_ref_store *refs)
 
 	files_assert_main_repository(refs, "rollback_packed_refs");
 
-	if (!refs->packed_refs_lock)
+	if (!is_lock_file_locked(&refs->packed_refs_lock))
 		die("BUG: packed-refs not locked");
-	rollback_lock_file(refs->packed_refs_lock);
-	refs->packed_refs_lock = NULL;
+	rollback_lock_file(&refs->packed_refs_lock);
 	release_packed_ref_cache(packed_ref_cache);
 	clear_packed_ref_cache(refs);
 }
-- 
2.11.0

