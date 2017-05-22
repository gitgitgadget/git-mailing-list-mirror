Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ABF12023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934695AbdEVOSn (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:43 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51818 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934692AbdEVOSh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:37 -0400
X-AuditID: 1207440c-9d9ff70000001412-7a-5922f33ccdab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id BB.C0.05138.C33F2295; Mon, 22 May 2017 10:18:36 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24L023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:34 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/25] files_transaction_cleanup(): new helper function
Date:   Mon, 22 May 2017 16:17:42 +0200
Message-Id: <e87859cae9e47cb4d3569111d4604468448637fd.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqGvzWSnSoOenhMXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8WTuXeZLW6vmM9sseTha2aL7ilvGS1+tPQwW2ze3M7iwOXx9/0HJo+ds+6y
        eyzYVOrx8FUXu0dX+xE2j2e9exg9Ll5S9vi8SS6AI4rLJiU1J7MstUjfLoEr48at52wFhwQr
        ji58wN7AOJuvi5GTQ0LARGLC/82MXYxcHEICO5gk3rTdYwZJCAmcYpL4Ny8NxGYT0JVY1NPM
        BGKLCKhJTGw7xALSwCywgVnizfTVYAlhAS+JtR9mgzWzCKhKnOq5zQJi8wpESVw718MCsU1e
        YlfbRVYQm1PAQuL3rANMEMvMJXr/rWaZwMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGu
        oV5uZoleakrpJkZIIPLsYPy2TuYQowAHoxIPb8NTpUgh1sSy4srcQ4ySHExKorxH3wCF+JLy
        UyozEosz4otKc1KLDzFKcDArifBq3wXK8aYkVlalFuXDpKQ5WJTEeVWXqPsJCaQnlqRmp6YW
        pBbBZGU4OJQkePU+ATUKFqWmp1akZeaUIKSZODhBhvMADV/zAWR4cUFibnFmOkT+FKOilDiv
        AUizAEgiozQPrheWKF4xigO9IsxrAlLFA0wycN2vgAYzAQ22fiYPMrgkESEl1cDIprrh9ZxP
        LRWxq5ind2/yNPrAdsezyqMqb8HRti2BW+/Mcd5yQXpt6zy1fE7TRYtXOj495TVHN6Hlx4b/
        ASJNvybWHBfgEUi67f1wblyCmNG7lSkNE2yvv84Mjrm8uoVpGStTiq3Lwnsva/87b+IvFW3f
        6FB2e2pdp/b13xGrwjsWVz62dP+uxFKckWioxVxUnAgAooIOfe8CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract the cleanup functionality from `files_transaction_commit()`
into a new function. It will soon have another caller.

Use the common cleanup code even on early exit if the transaction is
empty, to reduce code duplication.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1db40432af..2c70de5209 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2834,6 +2834,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	return 0;
 }
 
+/*
+ * Unlock any references in `transaction` that are still locked, and
+ * mark the transaction closed.
+ */
+static void files_transaction_cleanup(struct ref_transaction *transaction)
+{
+	size_t i;
+
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		struct ref_lock *lock = update->backend_data;
+
+		if (lock) {
+			unlock_ref(lock);
+			update->backend_data = NULL;
+		}
+	}
+
+	transaction->state = REF_TRANSACTION_CLOSED;
+}
+
 static int files_transaction_commit(struct ref_store *ref_store,
 				    struct ref_transaction *transaction,
 				    struct strbuf *err)
@@ -2856,10 +2877,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: commit called for transaction that is not open");
 
-	if (!transaction->nr) {
-		transaction->state = REF_TRANSACTION_CLOSED;
-		return 0;
-	}
+	if (!transaction->nr)
+		goto cleanup;
 
 	/*
 	 * Fail if a refname appears more than once in the
@@ -3005,15 +3024,11 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	clear_loose_ref_cache(refs);
 
 cleanup:
+	files_transaction_cleanup(transaction);
 	strbuf_release(&sb);
-	transaction->state = REF_TRANSACTION_CLOSED;
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
-		struct ref_lock *lock = update->backend_data;
-
-		if (lock)
-			unlock_ref(lock);
 
 		if (update->flags & REF_DELETED_LOOSE) {
 			/*
-- 
2.11.0

