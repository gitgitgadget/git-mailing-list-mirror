Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8B781F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754454AbcIDQMI (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:12:08 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61523 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754336AbcIDQLu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:50 -0400
X-AuditID: 12074413-aa3ff70000000955-9e-57cc474bb746
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 0A.21.02389.B474CC75; Sun,  4 Sep 2016 12:09:47 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5p026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:46 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 29/38] split_symref_update(): add a files_ref_store argument
Date:   Sun,  4 Sep 2016 18:08:35 +0200
Message-Id: <c83131a4e0776271ec15265b0b712de16a0fb513.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqOvtfibcYN4EXYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGT1v1rIXXOCseLrzBWsD42n2LkZO
        DgkBE4nObbsYuxi5OIQEtjJKzJywGiwhJHCSSeLybQ0Qm01AV2JRTzMTiC0ioCYxse0QC0gD
        M0jNrIkzgRo4OIQF/CX2rfMHqWERUJU4OXcG2BxegSiJe39PMUMsk5O4tO0LmM0pYCFxZvdc
        ZpBWIQFzifYX2RMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3ECAk3
        4R2Mu07KHWIU4GBU4uGdoHsmXIg1say4MvcQoyQHk5Io76yDJ8OF+JLyUyozEosz4otKc1KL
        DzFKcDArifBquwCV86YkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeK+7
        AjUKFqWmp1akZeaUIKSZODhBhvMADb8JUsNbXJCYW5yZDpE/xagoJc77EiQhAJLIKM2D64Wl
        g1eM4kCvCPMmuAFV8QBTCVz3K6DBTECD1+0+DTK4JBEhJdXA2Hgx9OVcSePHIWIaWTLN9p87
        ZU7H3FWeJMbCKrVDw3PZLKW9GhN1bv5enpt9tczxlp1wbXKn0zWJc85TGTffLz98b/KKjfZH
        Sm5Gu117dDTpfK8qX+j0OYc0i7dzXNqXkau/28PPuIpDR6Mq86cva8Q6l8Rf2w5ZnJdKDOVe
        ufaVZvad/R08SizFGYmGWsxFxYkANKN8EOICAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ab2c1de..3a0db5a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3401,7 +3401,8 @@ static int split_head_update(struct ref_update *update,
  * Note that the new update will itself be subject to splitting when
  * the iteration gets to it.
  */
-static int split_symref_update(struct ref_update *update,
+static int split_symref_update(struct files_ref_store *refs,
+			       struct ref_update *update,
 			       const char *referent,
 			       struct ref_transaction *transaction,
 			       struct string_list *affected_refnames,
@@ -3583,7 +3584,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * of processing the split-off update, so we
 			 * don't have to do it here.
 			 */
-			ret = split_symref_update(update, referent.buf, transaction,
+			ret = split_symref_update(refs, update,
+						  referent.buf, transaction,
 						  affected_refnames, err);
 			if (ret)
 				return ret;
-- 
2.9.3

