Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4982082D
	for <e@80x24.org>; Fri,  8 Sep 2017 13:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754486AbdIHNwV (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 09:52:21 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57317 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752663AbdIHNwL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 09:52:11 -0400
X-AuditID: 12074411-f7dff70000007f0a-69-59b2a08ae0aa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E1.07.32522.A80A2B95; Fri,  8 Sep 2017 09:52:10 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88Dpvjv002844
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 09:52:08 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/11] packed_delete_refs(): implement method
Date:   Fri,  8 Sep 2017 15:51:46 +0200
Message-Id: <efcd2e74427a4b05566c1afaf81af02f4f9a5672.1504877858.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1504877858.git.mhagger@alum.mit.edu>
References: <cover.1504877858.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqNu1YFOkwe0eAYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj2e9exg9
        Ll5S9vi8SS6ALYrLJiU1J7MstUjfLoEr48nHdewFV0UrDr1eztjA+Fuwi5GTQ0LAROLCyctM
        XYxcHEICO5gkbqzpYYRwTjJJPNt9nA2kik1AV2JRTzMTiC0ioCYxse0QC0gRs8BTJomdJ++y
        giSEBRwk7l9pYgSxWQRUJS73rwGL8wpEScw78IAJYp28xLkHt5lBbE4BC4lX/9aALRASMJe4
        unsS6wRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJTSjcxQkJMcAfjjJNy
        hxgFOBiVeHgtgjdGCrEmlhVX5h5ilORgUhLllenZFCnEl5SfUpmRWJwRX1Sak1p8iFGCg1lJ
        hNd8FlCONyWxsiq1KB8mJc3BoiTOy7dE3U9IID2xJDU7NbUgtQgmK8PBoSTBGzAfqFGwKDU9
        tSItM6cEIc3EwQkynAdo+P55IMOLCxJzizPTIfKnGHU5Om7e/cMkxJKXn5cqJc7bBlIkAFKU
        UZoHNweWGl4xigO9Jcw7BWQdDzCtwE16BbSECWhJyfMNIEtKEhFSUg2MqZfq7+X19qxrWBs7
        u1VYboMlm4Dlyx8PHGTDfU64NW9+JHJPNuCu4X8V5rlqLAtTUucaZS36tmxR3TneY5+79neE
        L++O9mVwec+knvRY7cYvfeubhv9/P41VktCTsbMVu81hGPLXT7Pz2pKvxYJSx8Wn5oaXrd7X
        o2kpEll+ppqZ+9PCT3pKLMUZiYZazEXFiQCTCOCe6AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement `packed_delete_refs()` using a reference transaction. This
means that `files_delete_refs()` can use `refs_delete_refs()` instead
of `repack_without_refs()` to delete any packed references, decreasing
the coupling between the classes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c  |  2 +-
 refs/packed-backend.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fccbc24ac4..2c78f63494 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1157,7 +1157,7 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
 		goto error;
 
-	if (repack_without_refs(refs->packed_ref_store, refnames, &err)) {
+	if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
 		packed_refs_unlock(refs->packed_ref_store);
 		goto error;
 	}
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 9ab65c5a0a..9d5f76b1dc 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1086,7 +1086,50 @@ static int packed_initial_transaction_commit(struct ref_store *ref_store,
 static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
 			     struct string_list *refnames, unsigned int flags)
 {
-	die("BUG: not implemented yet");
+	struct packed_ref_store *refs =
+		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
+	struct strbuf err = STRBUF_INIT;
+	struct ref_transaction *transaction;
+	struct string_list_item *item;
+	int ret;
+
+	(void)refs; /* We need the check above, but don't use the variable */
+
+	if (!refnames->nr)
+		return 0;
+
+	/*
+	 * Since we don't check the references' old_oids, the
+	 * individual updates can't fail, so we can pack all of the
+	 * updates into a single transaction.
+	 */
+
+	transaction = ref_store_transaction_begin(ref_store, &err);
+	if (!transaction)
+		return -1;
+
+	for_each_string_list_item(item, refnames) {
+		if (ref_transaction_delete(transaction, item->string, NULL,
+					   flags, msg, &err)) {
+			warning(_("could not delete reference %s: %s"),
+				item->string, err.buf);
+			strbuf_reset(&err);
+		}
+	}
+
+	ret = ref_transaction_commit(transaction, &err);
+
+	if (ret) {
+		if (refnames->nr == 1)
+			error(_("could not delete reference %s: %s"),
+			      refnames->items[0].string, err.buf);
+		else
+			error(_("could not delete references: %s"), err.buf);
+	}
+
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	return ret;
 }
 
 static int packed_pack_refs(struct ref_store *ref_store, unsigned int flags)
-- 
2.14.1

