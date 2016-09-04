Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B605E1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754575AbcIDQNU (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:13:20 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55354 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754531AbcIDQNC (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:13:02 -0400
X-AuditID: 12074414-c8fff70000000931-3a-57cc4740b9a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 97.9A.02353.0474CC75; Sun,  4 Sep 2016 12:09:36 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5j026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:35 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 23/38] refs: make peel_ref() virtual
Date:   Sun,  4 Sep 2016 18:08:29 +0200
Message-Id: <c1b265f4d4476a4dd9ce85aabbfb02b154fee094.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqOvgfibc4MleDYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGSfnBxZ8FaqYPeMMSwPjIf4uRk4O
        CQETiSvflzGB2EICWxkl2pbmdjFyAdknmSTOfNrBDJJgE9CVWNTTDFYkIqAmMbHtEAtIETNI
        0ayJM9lBEsIC5hJ/Dh4Ea2ARUJW48nYPWJxXIEri0NkudohtchKXtn0Bq+EUsJA4s3sukM0B
        tM1cov1F9gRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQsJNZAfj
        kZNyhxgFOBiVeHgttM+EC7EmlhVX5h5ilORgUhLlnXXwZLgQX1J+SmVGYnFGfFFpTmrxIUYJ
        DmYlEV5tF6By3pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUwWRkODiUJ3uuuQI2C
        RanpqRVpmTklCGkmDk6Q4TxAw2+C1PAWFyTmFmemQ+RPMSpKifO+BEkIgCQySvPgemHp4BWj
        ONArwrwJbkBVPMBUAtf9CmgwE9DgdbtPgwwuSURISTUwcjw/eeH6xw+l4V29p3fGJWn05H4p
        rTuzfoqoZdrMeuZiiSnzSs/scfDcXs4oc/eX8/vTWSv1pPonbY8/GRG31OTtovUcGzgkF1zy
        r0i+uFXnt56hc9pP0/1znIo9oy5P0GzTUOAP6m/vFvLtF5KQsm66ZuLl2ify58utlbOWuG4x
        //piinCyEktxRqKhFnNRcSIAjke7keICAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For now it only supports the main reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 7 +++++++
 refs/files-backend.c | 6 ++++--
 refs/refs-internal.h | 3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 74874e5..f10f86a 100644
--- a/refs.c
+++ b/refs.c
@@ -1428,6 +1428,13 @@ int pack_refs(unsigned int flags)
 	return refs->be->pack_refs(refs, flags);
 }
 
+int peel_ref(const char *refname, unsigned char *sha1)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->peel_ref(refs, refname, sha1);
+}
+
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bf53670..8d43e0b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1759,9 +1759,10 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(struct ref_store *ref_store,
+			  const char *refname, unsigned char *sha1)
 {
-	struct files_ref_store *refs = get_files_ref_store(NULL, "peel_ref");
+	struct files_ref_store *refs = files_downcast(ref_store, 0, "peel_ref");
 	int flag;
 	unsigned char base[20];
 
@@ -4037,6 +4038,7 @@ struct ref_storage_be refs_be_files = {
 	files_transaction_commit,
 
 	files_pack_refs,
+	files_peel_ref,
 	files_create_symref,
 
 	files_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index bf96503..84c81ad 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -501,6 +501,8 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct strbuf *err);
 
 typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
+typedef int peel_ref_fn(struct ref_store *ref_store,
+			const char *refname, unsigned char *sha1);
 typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *ref_target,
 			     const char *refs_heads_master,
@@ -561,6 +563,7 @@ struct ref_storage_be {
 	ref_transaction_commit_fn *transaction_commit;
 
 	pack_refs_fn *pack_refs;
+	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 
 	read_raw_ref_fn *read_raw_ref;
-- 
2.9.3

