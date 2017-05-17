Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58AAF201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbdEQMGT (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:19 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45801 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753015AbdEQMGN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:13 -0400
X-AuditID: 1207440e-797ff70000007d8a-e6-591c3caeae5e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 23.B5.32138.EAC3C195; Wed, 17 May 2017 08:06:07 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pfv000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:05 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/23] refs: use `size_t` indexes when iterating over ref transaction updates
Date:   Wed, 17 May 2017 14:05:29 +0200
Message-Id: <17922578c2fbec4c0b8040cb37f432f913218489.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqLveRibS4P4eRou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGro6VjAWLuCsWdJ9lbGCcztnFyMkhIWAi
        cej8GTYQW0hgB5PErOnmXYxcQPYJJomOv0+ZQBJsAroSi3qawWwRATWJiW2HWECKmAUeM0n8
        XdbNApIQFoiV+PvpLNgkFgFVibbrfawgNq9AlMSy7uusENvkJXa1XQSzOQUsJO6/f8TexcgB
        tM1cYvv1ygmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrr5WaW6KWmlG5ihAQa3w7G
        9vUyhxgFOBiVeHgncElHCrEmlhVX5h5ilORgUhLl3f8AKMSXlJ9SmZFYnBFfVJqTWnyIUYKD
        WUmE96apTKQQb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCd4o1UKNg
        UWp6akVaZk4JQpqJgxNkOA/QcC6QGt7igsTc4sx0iPwpRkUpcd4DIAkBkERGaR5cLywRvGIU
        B3pFmDcPpIoHmETgul8BDWYCGtwM8hFvcUkiQkqqgbG+9P+niq6zR+ulq4z+yM9ReNN345XI
        U56tTX+4926Yq5fiKzzNfsP8liN6FXM8+lIKFlhsyRX+95n13cyLBk+vvw9bdmSxyjuGi7a+
        L+/P7q7uz/iwRkmU7VD/ZRVX+zO2zw6kpQtncflX7jjGeHfyyy1pazbX7/IrPBTxxXT2Rh6x
        1AbheiMlluKMREMt5qLiRAAxbSrC3wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 2 +-
 refs/files-backend.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index f4a485cd8a..ea8233c67d 100644
--- a/refs.c
+++ b/refs.c
@@ -848,7 +848,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 
 void ref_transaction_free(struct ref_transaction *transaction)
 {
-	int i;
+	size_t i;
 
 	if (!transaction)
 		return;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4925e698d8..893029f9dc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2862,7 +2862,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE,
 			       "ref_transaction_commit");
-	int ret = 0, i;
+	size_t i;
+	int ret = 0;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
@@ -3069,7 +3070,8 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE,
 			       "initial_ref_transaction_commit");
-	int ret = 0, i;
+	size_t i;
+	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
 	assert(err);
-- 
2.11.0

