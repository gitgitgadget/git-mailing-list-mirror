Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A52320209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbdGASbt (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:31:49 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:59128 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752040AbdGASbo (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:44 -0400
X-AuditID: 1207440c-c4dff70000001e54-1b-5957ea8a1cf4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 77.2E.07764.A8AE7595; Sat,  1 Jul 2017 14:31:38 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBN010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:35 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/30] add_packed_ref(): take a `packed_ref_store *` parameter
Date:   Sat,  1 Jul 2017 20:30:48 +0200
Message-Id: <7a56a1e4b8dd02d4b92170f705260d832f1673a7.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqNv1KjzS4M5cMYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJ6Fz5hKZggUHFs1gmWBsY1vF2M
        nBwSAiYS3/8vZOpi5OIQEtjBJNFx+zcbhHOSSWJLayMrSBWbgK7Eop5mJhBbREBNYmLbIRaQ
        ImaBScwSb6+BtHNwCAsEShztcQSpYRFQldg/fTk7iM0rECWxZeIJFoht8hK72i6CzeQUsJD4
        07aeGcQWEjCXaD7YxzKBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJN
        jJCg49nB+G2dzCFGAQ5GJR7eDSFhkUKsiWXFlbmHGCU5mJREeVdeC40U4kvKT6nMSCzOiC8q
        zUktPsQowcGsJMKb+zw8Uog3JbGyKrUoHyYlzcGiJM6rukTdT0ggPbEkNTs1tSC1CCYrw8Gh
        JMHLBIwuIcGi1PTUirTMnBKENBMHJ8hwHqDhC++CDC8uSMwtzkyHyJ9i1OV4NeH/NyYhlrz8
        vFQpcd7Wl0BFAiBFGaV5cHNgyeIVozjQW8K8ES+AqniAiQZu0iugJUxAS4RnhIAsKUlESEk1
        MOZKWKxvykpncjxY4OBdcqkzp99NRM5dKn77i38LfkZ6Pb36aPmGa1mMZXksm5wycpvDOlxk
        C0/cFmhT+bzEdHZ5g0z4xm0b27pn2Xw16NmhsfrXTL68jMDVH8/VK09MmqfCnvXjzt+DBrGn
        Qi8c3Dn12dOeyHnSbreVgloLX3E87Yo6xKHMrsRSnJFoqMVcVJwIAFa1He/xAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bc5c0de84e..4943207098 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -438,19 +438,19 @@ static struct ref_dir *get_packed_refs(struct packed_ref_store *refs)
  * (see lock_packed_refs()). To actually write the packed-refs file,
  * call commit_packed_refs().
  */
-static void add_packed_ref(struct files_ref_store *refs,
+static void add_packed_ref(struct packed_ref_store *refs,
 			   const char *refname, const struct object_id *oid)
 {
 	struct ref_dir *packed_refs;
 	struct ref_entry *packed_entry;
 
-	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
+	if (!is_lock_file_locked(&refs->lock))
 		die("BUG: packed refs not locked");
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
 
-	packed_refs = get_packed_refs(refs->packed_ref_store);
+	packed_refs = get_packed_refs(refs);
 	packed_entry = find_ref_entry(packed_refs, refname);
 	if (packed_entry) {
 		/* Overwrite the existing entry: */
@@ -1579,7 +1579,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		 * we don't copy the peeled status, because we want it
 		 * to be re-peeled.
 		 */
-		add_packed_ref(refs, iter->refname, iter->oid);
+		add_packed_ref(refs->packed_ref_store, iter->refname, iter->oid);
 
 		/* Schedule the loose reference for pruning if requested. */
 		if ((flags & PACK_REFS_PRUNE)) {
@@ -3210,7 +3210,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 
 		if ((update->flags & REF_HAVE_NEW) &&
 		    !is_null_oid(&update->new_oid))
-			add_packed_ref(refs, update->refname,
+			add_packed_ref(refs->packed_ref_store, update->refname,
 				       &update->new_oid);
 	}
 
-- 
2.11.0

