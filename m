Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EBFA20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdGASbp (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:31:45 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45219 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751919AbdGASbo (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:44 -0400
X-AuditID: 12074412-b7fff70000000fed-c8-5957ea8e973d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 6C.65.04077.E8AE7595; Sat,  1 Jul 2017 14:31:42 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBP010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:40 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/30] commit_packed_refs(): take a `packed_ref_store *` parameter
Date:   Sat,  1 Jul 2017 20:30:50 +0200
Message-Id: <20d0b63c77d17b864a645d6c02f16b1045cbb062.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqNv3KjzSoOe6nsXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLZY8fM1s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8Fm0o9
        utqPsHk8693D6HHxkrLH501yAexRXDYpqTmZZalF+nYJXBkvrv9jLFgkWvH9zUzmBsYrgl2M
        nBwSAiYSp2fNY+xi5OIQEtjBJLH283MWCOckk8TG7S9ZQarYBHQlFvU0M4HYIgJqEhPbDoEV
        MQtMYpZ4e20hWEJYIFTi7/NjzCA2i4CqxM4Pb8CaeQWiJPr+NLNArJOX2NV2ESzOKWAh8adt
        PVi9kIC5RPPBPpYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVmluilppRuYoSE
        ndAOxvUn5Q4xCnAwKvHwbggJixRiTSwrrsw9xCjJwaQkyrvyWmikEF9SfkplRmJxRnxRaU5q
        8SFGCQ5mJRHe3OfhkUK8KYmVValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8
        k14CNQoWpaanVqRl5pQgpJk4OEGG8wANX3gXZHhxQWJucWY6RP4Uoy7Hqwn/vzEJseTl56VK
        ifO2ggwSACnKKM2DmwNLF68YxYHeEuZlACYPIR5gqoGb9ApoCRPQEuEZISBLShIRUlINjFbr
        ZHTSgxK4K95ffKH6V6Wz9vSex7fbAr8su7bTpCJ5+zGHZ4brN4YuSjqs3vLUtEbqTjwT05HK
        t5qzUi/rHD+TECy90ierMu2m8NZw78+lvIo3zpS/zZx3t2/VD0+5bSFn5e/yW647UH+dzc/2
        mu5S9raY7VHdyruCYybf8Qhef6vt4PvlzUosxRmJhlrMRcWJAGRhRTnyAgAA
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

