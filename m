Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C3120401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbdFOOsA (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:00 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45426 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752161AbdFOOr7 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:47:59 -0400
X-AuditID: 1207440c-619ff70000002ef9-de-59429e1d41ce
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 2E.DC.12025.D1E92495; Thu, 15 Jun 2017 10:47:57 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbR1014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:47:55 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/28] get_packed_ref_cache(): take a `packed_ref_store *` parameter
Date:   Thu, 15 Jun 2017 16:47:12 +0200
Message-Id: <e8404678ec31e1b1f1096e3db7f6a4d562e30473.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqCs7zynS4O5uM4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJenTvNXrBPpmLRoktsDYwLJboY
        OTkkBEwk+p/tY+9i5OIQEtjBJLH54l42COckk8Sf+V+ZQKrYBHQlFvU0g9kiAmoSE9sOsYAU
        MQtMYpZ4e20hWEJYIERi8/czbCA2i4CqxImrz8HivAJREh0PlrBBrJOX2NV2kRXE5hSwkJj9
        ZR1zFyMH0DZziWPLNSYw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuol5tZopeaUrqJ
        ERJ0PDsYv62TOcQowMGoxMOr0OAUKcSaWFZcmXuIUZKDSUmUl18OKMSXlJ9SmZFYnBFfVJqT
        WnyIUYKDWUmEd+ocoBxvSmJlVWpRPkxKmoNFSZxXdYm6n5BAemJJanZqakFqEUxWhoNDSYJ3
        G0ijYFFqempFWmZOCUKaiYMTZDgP0PC/YMOLCxJzizPTIfKnGBWlxHk9QBICIImM0jy4XlhS
        eMUoDvSKMK/yXKAqHmBCget+BTSYCWhw0AUHkMEliQgpqQZGyQq1M49Ze+XkCt2CCi3fBp7c
        9Oyrqeos5g8yFdV2cW0BiXYy3xreaCVaPL8Z6lxtndN047PZ7wL2usLSwoJF+m8Pid7gLdZb
        mcF/6e3vY+eEvpZYr2rh4epb6nrpkn6zwLr9OZuLp01LF+BPnqt40XfFo5e7p9g63Cvo0eR/
        dMZxzapz5yOUWIozEg21mIuKEwF/6JYt5QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f061506bf0..b2ef7b3bb9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -404,24 +404,22 @@ static void validate_packed_ref_cache(struct packed_ref_store *refs)
 }
 
 /*
- * Get the packed_ref_cache for the specified files_ref_store,
+ * Get the packed_ref_cache for the specified packed_ref_store,
  * creating and populating it if it hasn't been read before or if the
  * file has been changed (according to its `validity` field) since it
  * was last read. On the other hand, if we hold the lock, then assume
  * that the file hasn't been changed out from under us, so skip the
  * extra `stat()` call in `stat_validity_check()`.
  */
-static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *refs)
+static struct packed_ref_cache *get_packed_ref_cache(struct packed_ref_store *refs)
 {
-	const char *packed_refs_file = refs->packed_ref_store->path;
+	if (!is_lock_file_locked(&refs->lock))
+		validate_packed_ref_cache(refs);
 
-	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
-		validate_packed_ref_cache(refs->packed_ref_store);
-
-	if (!refs->packed_ref_store->cache)
-		refs->packed_ref_store->cache = read_packed_refs(packed_refs_file);
+	if (!refs->cache)
+		refs->cache = read_packed_refs(refs->path);
 
-	return refs->packed_ref_store->cache;
+	return refs->cache;
 }
 
 static struct ref_dir *get_packed_ref_dir(struct packed_ref_cache *packed_ref_cache)
@@ -431,7 +429,7 @@ static struct ref_dir *get_packed_ref_dir(struct packed_ref_cache *packed_ref_ca
 
 static struct ref_dir *get_packed_refs(struct files_ref_store *refs)
 {
-	return get_packed_ref_dir(get_packed_ref_cache(refs));
+	return get_packed_ref_dir(get_packed_ref_cache(refs->packed_ref_store));
 }
 
 /*
@@ -1151,7 +1149,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
 					      prefix, 1);
 
-	iter->packed_ref_cache = get_packed_ref_cache(refs);
+	iter->packed_ref_cache = get_packed_ref_cache(refs->packed_ref_store);
 	acquire_packed_ref_cache(iter->packed_ref_cache);
 	packed_iter = cache_ref_iterator_begin(iter->packed_ref_cache->cache,
 					       prefix, 0);
@@ -1365,7 +1363,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	 */
 	validate_packed_ref_cache(refs->packed_ref_store);
 
-	packed_ref_cache = get_packed_ref_cache(refs);
+	packed_ref_cache = get_packed_ref_cache(refs->packed_ref_store);
 	/* Increment the reference count to prevent it from being freed: */
 	acquire_packed_ref_cache(packed_ref_cache);
 	return 0;
@@ -1380,7 +1378,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 static int commit_packed_refs(struct files_ref_store *refs)
 {
 	struct packed_ref_cache *packed_ref_cache =
-		get_packed_ref_cache(refs);
+		get_packed_ref_cache(refs->packed_ref_store);
 	int ok, error = 0;
 	int save_errno = 0;
 	FILE *out;
@@ -1426,7 +1424,7 @@ static int commit_packed_refs(struct files_ref_store *refs)
 static void rollback_packed_refs(struct files_ref_store *refs)
 {
 	struct packed_ref_cache *packed_ref_cache =
-		get_packed_ref_cache(refs);
+		get_packed_ref_cache(refs->packed_ref_store);
 
 	files_assert_main_repository(refs, "rollback_packed_refs");
 
-- 
2.11.0

