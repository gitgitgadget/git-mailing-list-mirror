Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76EEE20401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754656AbdFWHCa (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:30 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50055 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754632AbdFWHC2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:28 -0400
X-AuditID: 1207440d-3e9ff70000001be7-3a-594cbcfd4bf0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id BA.51.07143.DFCBC495; Fri, 23 Jun 2017 03:02:22 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o5v001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:20 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/29] commit_packed_refs(): take a `packed_ref_store *` parameter
Date:   Fri, 23 Jun 2017 09:01:30 +0200
Message-Id: <d70848199df5bb17068391e747d71340cdc84d26.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqPtvj0+kwbUTrBZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGW8uP6PsWCRaMX3NzOZGxivCHYx
        cnJICJhITFjziwXEFhLYwSTxZTt7FyMXkH2KSWLpyV/sIAk2AV2JRT3NTCC2iICaxMS2Qywg
        RcwCk5gl3l5bCJYQFgiV6D/ZwwxiswioSkye2coIYvMKREncPdrBDLFNXmJX20VWEJtTwEKi
        Z+JydojN5hKrfq9mncDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZG
        SNDx7mD8v07mEKMAB6MSD2/CWe9IIdbEsuLK3EOMkhxMSqK8mpE+kUJ8SfkplRmJxRnxRaU5
        qcWHGCU4mJVEeHVWAeV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8
        LbuBGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGe2wGGV5ckJhbnJkOkT/FqCglzrsBpFkAJJFRmgfX
        C0sKrxjFgV4R5k0EqeIBJhS47ldAg5mABs9YAza4JBEhJdXAWDxvVobUk003v+jOX5yZ6vys
        tkIsWNOk8MeR5U7xRT1/mHYfO2Dc4jdpAfcnVf4zp2O0BT3+LuqbHFx7+NbrVJXoSRLO6nem
        rMxx/PxFINXkEO+B/posj82sH8Ptb92W3BFx/uWN0Bp1kY2Gzrszr58vurnld0PxgsAvj15u
        13kuwcSs4l68W4mlOCPRUIu5qDgRAFqMyhzlAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0d8f39089f..5d159620f0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1388,21 +1388,21 @@ static int lock_packed_refs(struct packed_ref_store *refs, int flags)
  * lock_packed_refs()). Return zero on success. On errors, set errno
  * and return a nonzero value
  */
-static int commit_packed_refs(struct files_ref_store *refs)
+static int commit_packed_refs(struct packed_ref_store *refs)
 {
 	struct packed_ref_cache *packed_ref_cache =
-		get_packed_ref_cache(refs->packed_ref_store);
+		get_packed_ref_cache(refs);
 	int ok, error = 0;
 	int save_errno = 0;
 	FILE *out;
 	struct ref_iterator *iter;
 
-	files_assert_main_repository(refs, "commit_packed_refs");
+	packed_assert_main_repository(refs, "commit_packed_refs");
 
-	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
+	if (!is_lock_file_locked(&refs->lock))
 		die("BUG: packed-refs not locked");
 
-	out = fdopen_lock_file(&refs->packed_ref_store->lock, "w");
+	out = fdopen_lock_file(&refs->lock, "w");
 	if (!out)
 		die_errno("unable to fdopen packed-refs descriptor");
 
@@ -1420,7 +1420,7 @@ static int commit_packed_refs(struct files_ref_store *refs)
 	if (ok != ITER_DONE)
 		die("error while iterating over references");
 
-	if (commit_lock_file(&refs->packed_ref_store->lock)) {
+	if (commit_lock_file(&refs->lock)) {
 		save_errno = errno;
 		error = -1;
 	}
@@ -1606,7 +1606,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	if (ok != ITER_DONE)
 		die("error while iterating over references");
 
-	if (commit_packed_refs(refs))
+	if (commit_packed_refs(refs->packed_ref_store))
 		die_errno("unable to overwrite old ref-pack file");
 
 	prune_refs(refs, refs_to_prune);
@@ -1662,7 +1662,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 	}
 
 	/* Write what remains */
-	ret = commit_packed_refs(refs);
+	ret = commit_packed_refs(refs->packed_ref_store);
 	if (ret)
 		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
 			    strerror(errno));
@@ -3227,7 +3227,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 				       &update->new_oid);
 	}
 
-	if (commit_packed_refs(refs)) {
+	if (commit_packed_refs(refs->packed_ref_store)) {
 		strbuf_addf(err, "unable to commit packed-refs file: %s",
 			    strerror(errno));
 		ret = TRANSACTION_GENERIC_ERROR;
-- 
2.11.0

