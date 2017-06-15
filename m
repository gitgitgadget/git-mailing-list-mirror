Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5C920401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbdFOOsi (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:38 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:56139 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752481AbdFOOsf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:35 -0400
X-AuditID: 12074414-d17ff7000000283f-f0-59429e42dac0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.C0.10303.24E92495; Thu, 15 Jun 2017 10:48:34 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbRI014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:32 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 24/28] packed_refs_unlock(), packed_refs_is_locked(): new functions
Date:   Thu, 15 Jun 2017 16:47:29 +0200
Message-Id: <6ec1897ceccdc0cb8cf49b8c7da77ad3e978f52e.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqOs0zynSYPE2Dou1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDL+rOljL3grVrFv0z7GBsbtwl2M
        nBwSAiYSh+59Zu9i5OIQEtjBJPF73mYmCOckk8TmT9tZQarYBHQlFvU0M4HYIgJqEhPbDrGA
        FDELTGKWeHttIVhCWCBYYsPUK2ANLAKqEp9PrmYGsXkFoiRuzVjEBLFOXmJX20WwGk4BC4nZ
        X9YB1XAAbTOXOLZcYwIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsY
        IUEnsoPxyEm5Q4wCHIxKPLwnap0ihVgTy4orcw8xSnIwKYny8ssBhfiS8lMqMxKLM+KLSnNS
        iw8xSnAwK4nwTp0DlONNSaysSi3Kh0lJc7AoifN+W6zuJySQnliSmp2aWpBaBJOV4eBQkuA1
        ngvUKFiUmp5akZaZU4KQZuLgBBnOAzT8L9jw4oLE3OLMdIj8KUZFKXHeLJBmAZBERmkeXC8s
        KbxiFAd6RZh3Hkg7DzChwHW/AhrMBDQ46IIDyOCSRISUVAOji8/h882SJ3jStkwKOtVg4Z6/
        tspBwoa18eJn47XTmesu65gvzLdyW1pV1ZrIEFo327/melrNhQ4T9fX3HM7Md++0O5But+7w
        e3P+f5x2E/7sPy9azsoSLt5WNm3nv8X8Jr1Jx5+tTnhx697L6gNhs9cs7c9wuhJ9MKq9XKfk
        kdbWW+aloauUWIozEg21mIuKEwHDTGXc5QIAAA==
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
index 24451343b8..ff6326ddb8 100644
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

