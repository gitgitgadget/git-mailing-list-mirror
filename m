Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB0B20401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754679AbdFWHC7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:59 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49102 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754131AbdFWHC5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:57 -0400
X-AuditID: 12074411-d03ff700000033ea-47-594cbd1a8021
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 82.FD.13290.A1DBC495; Fri, 23 Jun 2017 03:02:50 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o6A001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:48 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 25/29] packed_refs_unlock(), packed_refs_is_locked(): new functions
Date:   Fri, 23 Jun 2017 09:01:43 +0200
Message-Id: <c738682de2b1aa5b44ff6ee92c951c0cd47a0683.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqCu11yfS4NZJK4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJW3exiKngrVnF9z2u2Bsbtwl2M
        nBwSAiYS204dZuti5OIQEtjBJLH4cQcjSEJI4BSTxLJvSSA2m4CuxKKeZiYQW0RATWJi2yEW
        kAZmgUnMEm+vLQRLCAuEScxrvM8KYrMIqEqc6/8HFucViJJoebqTGWKbvMSutotgNZwCFhI9
        E5ezQywzl1j1ezXrBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfVyM0v0UlNKNzFC
        gk5wB+OMk3KHGAU4GJV4eBPOekcKsSaWFVfmHmKU5GBSEuXVjPSJFOJLyk+pzEgszogvKs1J
        LT7EKMHBrCTCq7MKKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQkuAV
        3QPUKFiUmp5akZaZU4KQZuLgBBnOAzTcYzPI8OKCxNzizHSI/ClGRSlx3g27gRICIImM0jy4
        XlhSeMUoDvSKMG8iSBUPMKHAdb8CGswENHjGGrDBJYkIKakGxnla7pvccl7Odu4Su7RNxMbu
        jsxupXOOXN/q3hXd7/KXM7v9f3/O43PMygnHsm1CpfIY0iaFF19KZJgg+27zihTW33x3qtpN
        rx/YmBtg95LnhXHbzvtrYmNPC62Q7mtTj3p3lUGwRmWJqrlEjuLHZexu9f/e37l9my2Ta9Pi
        E+YXvnOsOcO3VYmlOCPRUIu5qDgRALRiSNnlAgAA
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

