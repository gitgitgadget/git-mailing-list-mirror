Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1863220285
	for <e@80x24.org>; Tue, 29 Aug 2017 08:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbdH2IU5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:20:57 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57706 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751066AbdH2IUv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 04:20:51 -0400
X-AuditID: 12074413-38bff70000007929-89-59a523e16e7e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id AF.B2.31017.1E325A95; Tue, 29 Aug 2017 04:20:49 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC836.dip0.t-ipconnect.de [87.188.200.54])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7T8KcRw002808
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 04:20:48 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/10] packed_delete_refs(): implement method
Date:   Tue, 29 Aug 2017 10:20:28 +0200
Message-Id: <7c61f04574e32d6172062a6a8ffa8ade5c90bb1d.1503993268.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1503993268.git.mhagger@alum.mit.edu>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqPtIeWmkwRwVi7XP7jBZPF9/gt2i
        60o3k0VD7xVmi9sr5jNbdE95y2jxo6WH2WLz5nYWBw6Pv+8/MHnsnHWX3WPBplKPZ717GD0u
        XlL2+LxJLoAtissmJTUnsyy1SN8ugStj7e3XLAVXRSt+bj7M0sD4W7CLkYNDQsBEYt/7wC5G
        Lg4hgR1MEndevWaEcE4ySXTdecrexcjJwSagK7Gop5kJxBYRUJOY2HaIBaSIWeApk8TOk3dZ
        QRLCArYS7z+1sIHYLAKqEpd3HAFr5hWIktj08R9YjYSAvMS5B7eZQWxOAQuJS58fMYLYQgLm
        Eqc7HzBPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXXC83s0QvNaV0EyMkvIR3MO46
        KXeIUYCDUYmHd4X1kkgh1sSy4srcQ4ySHExKorwZCksjhfiS8lMqMxKLM+KLSnNSiw8xSnAw
        K4nwBrMD5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErw5SkCNgkWp
        6akVaZk5JQhpJg5OkOE8QMOFQWp4iwsSc4sz0yHypxgVpcR5JygCJQRAEhmleXC9sPh/xSgO
        9Iow73eQdh5g6oDrfgU0mAlosKLgQpDBJYkIKakGRu0Wt9s6XifS339orIiR/SskfnjXlt1b
        ivpZPc1vHBUSmhcnNm2e0dz5n8TeaPkt43+/+IbY7rezTD/+25ThWH5mZU+gBRuHYFao+L0m
        y8CO6d3zpd3lZGYdP7KS/c6LGXv79j6bvPHtH+9LXZuUnc+ELduy/PUFoYKOsrUS7bf0ZIoz
        fhdszFBiKc5INNRiLipOBABgh3hU2gIAAA==
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
index d19b3bfba5..83a088118f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1082,7 +1082,50 @@ static int packed_initial_transaction_commit(struct ref_store *ref_store,
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

