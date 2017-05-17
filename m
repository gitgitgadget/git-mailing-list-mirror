Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C982F201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753606AbdEQMG2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:28 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55110 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753341AbdEQMGP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:15 -0400
X-AuditID: 12074413-0c9ff70000001dc3-d5-591c3cb6a13a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id C9.8E.07619.6BC3C195; Wed, 17 May 2017 08:06:14 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pg1000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:12 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/23] files_ref_store: put the packed files lock directly in this struct
Date:   Wed, 17 May 2017 14:05:33 +0200
Message-Id: <dd7637060bac1a27e03563edc82649812dcf897c.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqLvNRibSYM5WOYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGnKsbWAsmKVR0TtjA2sB4XKqLkZNDQsBE
        4tDd6+xdjFwcQgI7mCTW7N3PBOGcYJKYceUZI0gVm4CuxKKeZiYQW0RATWJi2yEWkCJmgcdM
        En+XdbOAJIQFIiWOP30DZrMIqErsurAKrIFXIEpiXt9OZoh18hK72i6ygticAhYS998/AlrN
        AbTNXGL79coJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6+VmluilppRuYoSEmvAO
        xl0n5Q4xCnAwKvHwTuCSjhRiTSwrrsw9xCjJwaQkyrv/AVCILyk/pTIjsTgjvqg0J7X4EKME
        B7OSCO9NU5lIId6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBK+QNVCj
        YFFqempFWmZOCUKaiYMTZDgP0HAukBre4oLE3OLMdIj8KUZFKXHeWCughABIIqM0D64Xlgpe
        MYoDvSLMmwfSzgNMI3Ddr4AGMwENbgb5iLe4JBEhJdXA6GH4NJutfZZK3VaZ3RuPb20u2nHm
        +LZlFxdKZgjV3vOSiqrovLLesaJsV+fSfU8nJES+NXdcfN/5bkX44bTLWWkrDV6fPaMkXMZ6
        8J36MR/tXXJfzuzUrPVZ7JXkrXZcXNC6oZ5/V86N3ay/zaKCivZZ/f9d+cc31uKU1pJ7xxew
        /lZbprf4jxJLcUaioRZzUXEiAJBMT0PgAgAA
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
index e7ae5538cc..ba0ad0aa44 100644
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
-	struct lock_file *packlock;
+	struct lock_file packlock;
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
 
-		if (refs->packlock)
+		if (is_lock_file_locked(&refs->packlock))
 			die("internal error: packed-ref cache cleared while locked");
 		refs->packed = NULL;
 		release_packed_ref_cache(packed_refs);
@@ -406,7 +402,7 @@ static void add_packed_ref(struct files_ref_store *refs,
 {
 	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
 
-	if (!refs->packlock)
+	if (!is_lock_file_locked(&refs->packlock))
 		die("internal error: packed refs not locked");
 	add_ref_entry(get_packed_ref_dir(packed_ref_cache),
 		      create_ref_entry(refname, sha1, REF_ISPACKED, 1));
@@ -1300,7 +1296,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	}
 
 	if (hold_lock_file_for_update_timeout(
-			    &packlock, files_packed_refs_path(refs),
+			    &refs->packlock, files_packed_refs_path(refs),
 			    flags, timeout_value) < 0)
 		return -1;
 	/*
@@ -1310,7 +1306,6 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	 * the packed-refs file.
 	 */
 	packed_ref_cache = get_packed_ref_cache(refs);
-	refs->packlock = &packlock;
 	/* Increment the reference count to prevent it from being freed: */
 	acquire_packed_ref_cache(packed_ref_cache);
 	return 0;
@@ -1333,10 +1328,10 @@ static int commit_packed_refs(struct files_ref_store *refs)
 
 	files_assert_main_repository(refs, "commit_packed_refs");
 
-	if (!refs->packlock)
+	if (!is_lock_file_locked(&refs->packlock))
 		die("internal error: packed-refs not locked");
 
-	out = fdopen_lock_file(refs->packlock, "w");
+	out = fdopen_lock_file(&refs->packlock, "w");
 	if (!out)
 		die_errno("unable to fdopen packed-refs descriptor");
 
@@ -1354,11 +1349,10 @@ static int commit_packed_refs(struct files_ref_store *refs)
 	if (ok != ITER_DONE)
 		die("error while iterating over references");
 
-	if (commit_lock_file(refs->packlock)) {
+	if (commit_lock_file(&refs->packlock)) {
 		save_errno = errno;
 		error = -1;
 	}
-	refs->packlock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
 	errno = save_errno;
 	return error;
@@ -1376,10 +1370,9 @@ static void rollback_packed_refs(struct files_ref_store *refs)
 
 	files_assert_main_repository(refs, "rollback_packed_refs");
 
-	if (!refs->packlock)
+	if (!is_lock_file_locked(&refs->packlock))
 		die("internal error: packed-refs not locked");
-	rollback_lock_file(refs->packlock);
-	refs->packlock = NULL;
+	rollback_lock_file(&refs->packlock);
 	release_packed_ref_cache(packed_ref_cache);
 	clear_packed_ref_cache(refs);
 }
-- 
2.11.0

