Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5D420209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbdGAScU (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:20 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48721 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752121AbdGAScO (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:32:14 -0400
X-AuditID: 1207440e-8bfff70000006f9a-e6-5957eaad931f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.A9.28570.DAAE7595; Sat,  1 Jul 2017 14:32:13 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBc010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:32:10 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 25/30] packed_refs_unlock(), packed_refs_is_locked(): new functions
Date:   Sat,  1 Jul 2017 20:31:03 +0200
Message-Id: <ade8d87db881b5406a68363f4bed5201a3958ac3.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLv2VXikwa1r0hZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGWsutnFVPBWrOL6ntdsDYzbhbsY
        OTkkBEwkjjacYO1i5OIQEtjBJLHw6k12COckk8SbD9dZQarYBHQlFvU0M4HYIgJqEhPbDrGA
        FDELTGKWeHttIVhCWCBMYlZPHzOIzSKgKjFv9kSgOAcHr0CUxPFpzBDb5CV2tV0Em8kpYCHx
        p209WFxIwFyi+WAfywRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI31cjNL9FJTSjcx
        QoKObwdj+3qZQ4wCHIxKPLwbQsIihVgTy4orcw8xSnIwKYnyrrwWGinEl5SfUpmRWJwRX1Sa
        k1p8iFGCg1lJhDf3eXikEG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJ
        gnfSS6BGwaLU9NSKtMycEoQ0EwcnyHAeoOEL74IMLy5IzC3OTIfIn2LU5Xg14f83JiGWvPy8
        VClx3laQQQIgRRmleXBzYMniFaM40FvCvBEvgKp4gIkGbtIroCVMQEuEZ4SALClJREhJNTCG
        Pnp06YefUOMBI6sXE1OnpHdefyGb6/7017G139yVIz+U5d6os85sd13l8n6taW9i7cnaHXJ9
        2XKVZ063HVt5+X7kgorZh7g+Loj6mmT+uH5Tb0jTkrWHU3sr1wh8XPGjy3Pl/DnfJ/T+W/Mn
        pNX7z6Xwow+Fg5lsfYr+Nj/Yt6PgW3ZTaZaaEktxRqKhFnNRcSIA0PvHmfECAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add two new public functions, `packed_refs_unlock()` and
`packed_refs_is_locked()`, with which callers can manage and query the
`packed-refs` lock externally.

Call `packed_refs_unlock()` from `commit_packed_refs()` and
`rollback_packed_refs()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 31 +++++++++++++++++++++++++------
 refs/packed-backend.h |  3 +++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 78e877a9e3..f27943f9a1 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -563,6 +563,29 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	return 0;
 }
 
+void packed_refs_unlock(struct ref_store *ref_store)
+{
+	struct packed_ref_store *refs = packed_downcast(
+			ref_store,
+			REF_STORE_READ | REF_STORE_WRITE,
+			"packed_refs_unlock");
+
+	if (!is_lock_file_locked(&refs->lock))
+		die("BUG: packed_refs_unlock() called when not locked");
+	rollback_lock_file(&refs->lock);
+	release_packed_ref_cache(refs->cache);
+}
+
+int packed_refs_is_locked(struct ref_store *ref_store)
+{
+	struct packed_ref_store *refs = packed_downcast(
+			ref_store,
+			REF_STORE_READ | REF_STORE_WRITE,
+			"packed_refs_is_locked");
+
+	return is_lock_file_locked(&refs->lock);
+}
+
 /*
  * The packed-refs header line that we write out.  Perhaps other
  * traits will be added later.  The trailing space is required.
@@ -649,8 +672,7 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 	delete_tempfile(&refs->tempfile);
 
 out:
-	rollback_lock_file(&refs->lock);
-	release_packed_ref_cache(packed_ref_cache);
+	packed_refs_unlock(ref_store);
 	return ret;
 }
 
@@ -661,14 +683,11 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
  */
 static void rollback_packed_refs(struct packed_ref_store *refs)
 {
-	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
-
 	packed_assert_main_repository(refs, "rollback_packed_refs");
 
 	if (!is_lock_file_locked(&refs->lock))
 		die("BUG: packed-refs not locked");
-	rollback_lock_file(&refs->lock);
-	release_packed_ref_cache(packed_ref_cache);
+	packed_refs_unlock(&refs->base);
 	clear_packed_ref_cache(refs);
 }
 
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 210e3f35ce..03b7c1de95 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -11,6 +11,9 @@ struct ref_store *packed_ref_store_create(const char *path,
  */
 int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err);
 
+void packed_refs_unlock(struct ref_store *ref_store);
+int packed_refs_is_locked(struct ref_store *ref_store);
+
 void add_packed_ref(struct ref_store *ref_store,
 		    const char *refname, const struct object_id *oid);
 
-- 
2.11.0

