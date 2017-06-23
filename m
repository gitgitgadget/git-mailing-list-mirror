Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9220C20401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbdFWHCW (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:22 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:58773 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754571AbdFWHCU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:20 -0400
X-AuditID: 12074413-b2dff700000069ec-92-594cbcec5c32
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 02.53.27116.CECBC495; Fri, 23 Jun 2017 03:02:04 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o5n001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:02 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/29] packed_ref_store: move `packed_refs_path` here
Date:   Fri, 23 Jun 2017 09:01:22 +0200
Message-Id: <58c0539523afba05fa8d9ef23428ba070f93ce87.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqPtmj0+kwf0TQhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGU87ZvMVnBepuLo0znsDYx3xLsY
        OTkkBEwktv15wtTFyMUhJLCDSeLYpMOsEM4pJolb+3vYQKrYBHQlFvU0M4HYIgJqEhPbDrGA
        FDELTGKWeHttIVhCWMBDYsrmmewgNouAqsTeJe8ZQWxegSiJRZ/+sUGsk5fY1XaRFcTmFLCQ
        6Jm4HKxeSMBcYtXv1awTGHkWMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSnd
        xAgJO+EdjLtOyh1iFOBgVOLhTTjrHSnEmlhWXJl7iFGSg0lJlFcz0idSiC8pP6UyI7E4I76o
        NCe1+BCjBAezkgivziqgHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJ
        glcUGF9CgkWp6akVaZk5JQhpJg5OkOE8QMM9NoMMLy5IzC3OTIfIn2JUlBLn3bAbKCEAksgo
        zYPrhaWFV4ziQK8I8yaCVPEAUwpc9yugwUxAg2esARtckoiQkmpgjNmW1PevxoWdm+t1eFxO
        Qe+7123nFbepegUxFXPxMQs+Sjqw5ddxdZU3m4Ut9vjy9n70t2xvnivFMymJl0k+rEN5zq5P
        u2bPv/8t8tMBMRWWhtYPmtOF3rg+fBsr2uF09dG5mQVF39TVlj5/N+1ZouD5D7+Ou8yI+v+Y
        ce+ig4a3JvL/O8emosRSnJFoqMVcVJwIANcTkyHmAgAA
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

