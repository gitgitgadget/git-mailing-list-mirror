Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BDA820401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbdFOOsI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:08 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49162 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752592AbdFOOsG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:06 -0400
X-AuditID: 12074411-f2fff70000007ac9-1d-59429e25dcd6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 40.B6.31433.52E92495; Thu, 15 Jun 2017 10:48:05 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbR5014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:04 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/28] commit_packed_refs(): take a `packed_ref_store *` parameter
Date:   Thu, 15 Jun 2017 16:47:16 +0200
Message-Id: <1af134b756a56acd0c2f651708c1d8e67d6b6f52.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqKs6zynS4Ol1S4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJeXP/HWLBItOL7m5nMDYxXBLsY
        OTkkBEwknly+xtbFyMUhJLCDSWLmj8esEM5JJomzT1pYQarYBHQlFvU0M4HYIgJqEhPbDrGA
        FDELTGKWeHttIVhCWCBIYselOWA2i4CqxO7b5xlBbF6BKImfPxvZINbJS+xquwg2lFPAQmL2
        l3XMXYwcQNvMJY4t15jAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6pXm5miV5qSukm
        RkjQCe5gnHFS7hCjAAejEg+vQoNTpBBrYllxZe4hRkkOJiVRXn45oBBfUn5KZUZicUZ8UWlO
        avEhRgkOZiUR3qlzgHK8KYmVValF+TApaQ4WJXFeviXqfkIC6YklqdmpqQWpRTBZGQ4OJQle
        47lAjYJFqempFWmZOSUIaSYOTpDhPEDD/4INLy5IzC3OTIfIn2JUlBLn9QBJCIAkMkrz4Hph
        SeEVozjQK8K8yiAreIAJBa77FdBgJqDBQRccQAaXJCKkpBoYwz/JHqhseyruEzfh7nXDnpk9
        iluurPubcsC+fdpyM7lFsd1yTyesqHsVKmmf1aaRdONExPnu/k/L/dlY63UuJPi+ilv6UUOm
        p3LRUvfQhd4rNzUv/cnt2tHFF9OQLP53RTlT2ccNn2QXdD+KCpfvMw6SXZktsvYCg5fOfUnv
        nWF6OpcWq/YpsRRnJBpqMRcVJwIA8BJxbeUCAAA=
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

