Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6731920A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755544AbdDPGnP (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:43:15 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56029 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755274AbdDPGnI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:43:08 -0400
X-AuditID: 12074413-f67ff700000077e1-cf-58f31275392b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 18.87.30689.57213F85; Sun, 16 Apr 2017 02:43:01 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGNJ025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:59 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 18/20] commit_packed_refs(): use reference iteration
Date:   Sun, 16 Apr 2017 08:41:40 +0200
Message-Id: <d0ea004d81d1d5af8840fd005549585775c301f8.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqFsm9DnCYMppJou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG6u6zzAWNKhWvN9c0MK6X7WLk5JAQMJHY
        tqyDuYuRi0NIYAeTxOJ/c5hBEkICJ5gkzn4WBbHZBHQlFvU0M4HYIgJqEhPbDrGANDALPGaS
        +LusmwUkISzgLvGvZS9YM4uAqkTjujtsIDavQJREx9p3zBDb5CV2tV1kBbE5BSwkptzdwAKx
        zFxi+/GrzBMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3ECAk04R2M
        u07KHWIU4GBU4uG18P8UIcSaWFZcmXuIUZKDSUmUV+Y/UIgvKT+lMiOxOCO+qDQntfgQowQH
        s5IIbzLL5wgh3pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEb7QgUKNg
        UWp6akVaZk4JQpqJgxNkOA/Q8HSQGt7igsTc4sx0iPwpRkUpcd4fAkAJAZBERmkeXC8sEbxi
        FAd6RZi3FqSdB5hE4LpfAQ1mAhrMMPkDyOCSRISUVANj7aqvfZfXcX7gVfvRpRloNDGswryV
        Vyv6kc2GJfYb+udOlL/eYFTdmX31xa0LbpN8DpWJ/0l7ZrPZd0/LN8MknaMsVzKNX69Lmyd0
        WuWj4Ff5/bfnZKybvrfkkknRHJHZR6YXvP0RxfJ4t1CMxpSa4k/rhOT2sAgabGTYtCdgwoVV
        vG8qNr3oVWIpzkg01GIuKk4EADoKkCvfAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use reference iteration rather than do_for_each_entry_in_dir() in the
definition of commit_packed_refs().

Note that an internal consistency check that was previously done in
`write_packed_entry_fn()` is not there anymore. This is actually an
improvement:

The old error message was emitted when there is an entry in the
packed-ref cache that is not `REF_KNOWS_PEELED`, and when we attempted
to peel the reference, the result was `PEEL_INVALID`,
`PEEL_IS_SYMREF`, or `PEEL_BROKEN`. Since a packed ref cannot be a
symref, `PEEL_IS_SYMREF` and `PEEL_BROKEN` can be ruled out. So we're
left with `PEEL_INVALID`.

An entry without `REF_KNOWS_PEELED` can get into the packed-refs cache
in the following two ways:

* The reference was read from a `packed-refs` file that didn't have
  the `fully-peeled` attribute. In that case, we *don't want* to emit
  an error, because the broken value is presumably a stale value of
  the reference that is now masked by a loose version of the same
  reference (which we just don't happen to be packing this time). This
  is a perfectly legitimate situation and doesn't indicate that the
  repository is corrupt. The old code incorrectly emits an error
  message in this case. (It was probably never reported as a bug
  because this scenario is rare.)

* The reference was a loose reference that was just added to the
  packed ref cache by `files_packed_refs()` via
  `pack_if_possible_fn()` in preparation for being packed. The latter
  function refuses to pack a reference for which
  `entry_resolves_to_object()` returns false, and otherwise calls
  `peel_entry()` itself and checks the return value. So an entry added
  this way should always have `REF_KNOWS_PEELED` and shouldn't trigger
  the error message in either the old code or the new.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8c360869c1..1419512d51 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1290,30 +1290,15 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
  * Write an entry to the packed-refs file for the specified refname.
  * If peeled is non-NULL, write it as the entry's peeled value.
  */
-static void write_packed_entry(FILE *fh, char *refname, unsigned char *sha1,
-			       unsigned char *peeled)
+static void write_packed_entry(FILE *fh, const char *refname,
+			       const unsigned char *sha1,
+			       const unsigned char *peeled)
 {
 	fprintf_or_die(fh, "%s %s\n", sha1_to_hex(sha1), refname);
 	if (peeled)
 		fprintf_or_die(fh, "^%s\n", sha1_to_hex(peeled));
 }
 
-/*
- * An each_ref_entry_fn that writes the entry to a packed-refs file.
- */
-static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
-{
-	enum peel_status peel_status = peel_entry(entry, 0);
-
-	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
-		error("internal error: %s is not a valid packed reference!",
-		      entry->name);
-	write_packed_entry(cb_data, entry->name, entry->u.value.oid.hash,
-			   peel_status == PEEL_PEELED ?
-			   entry->u.value.peeled.hash : NULL);
-	return 0;
-}
-
 /*
  * Lock the packed-refs file for writing. Flags is passed to
  * hold_lock_file_for_update(). Return 0 on success. On errors, set
@@ -1359,9 +1344,10 @@ static int commit_packed_refs(struct files_ref_store *refs)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
-	int error = 0;
+	int ok, error = 0;
 	int save_errno = 0;
 	FILE *out;
+	struct ref_iterator *iter;
 
 	files_assert_main_repository(refs, "commit_packed_refs");
 
@@ -1373,8 +1359,18 @@ static int commit_packed_refs(struct files_ref_store *refs)
 		die_errno("unable to fdopen packed-refs descriptor");
 
 	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
-	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
-				 write_packed_entry_fn, out);
+
+	iter = cache_ref_iterator_begin(packed_ref_cache->cache, NULL, 0);
+	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
+		struct object_id peeled;
+		int peel_error = ref_iterator_peel(iter, &peeled);
+
+		write_packed_entry(out, iter->refname, iter->oid->hash,
+				   peel_error ? NULL : peeled.hash);
+	}
+
+	if (ok != ITER_DONE)
+		die("error while iterating over references");
 
 	if (commit_lock_file(packed_ref_cache->lock)) {
 		save_errno = errno;
-- 
2.11.0

