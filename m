Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9762082D
	for <e@80x24.org>; Fri,  8 Sep 2017 13:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754287AbdIHNwU (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 09:52:20 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57317 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754413AbdIHNwO (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 09:52:14 -0400
X-AuditID: 12074411-f95ff70000007f0a-72-59b2a08e9782
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 13.07.32522.E80A2B95; Fri,  8 Sep 2017 09:52:14 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88Dpvjx002844
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 09:52:12 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/11] prune_refs(): also free the linked list
Date:   Fri,  8 Sep 2017 15:51:48 +0200
Message-Id: <edcf7a0102ee168b9da080d38a4098774d37635e.1504877858.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1504877858.git.mhagger@alum.mit.edu>
References: <cover.1504877858.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqNu3YFOkwdYffBZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxu4Lq1gK/nJVbN91nrmBsYWzi5GDQ0LARGLzNO0u
        Ri4OIYEdTBLb/75gh3BOMkkcntDI1sXIycEmoCuxqKeZCcQWEVCTmNh2iAWkiFngKZPEzpN3
        WUESwgKOEjePzGABsVkEVCV+Hl4L1swrECXxdcFSsBoJAXmJcw9uM4PYnAIWEq/+rQGrERIw
        l7i6exLrBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfVyM0v0UlNKNzFCAkxwB+OM
        k3KHGAU4GJV4eC2CN0YKsSaWFVfmHmKU5GBSEuWV6dkUKcSXlJ9SmZFYnBFfVJqTWnyIUYKD
        WUmE13wWUI43JbGyKrUoHyYlzcGiJM7Lt0TdT0ggPbEkNTs1tSC1CCYrw8GhJMEbMB+oUbAo
        NT21Ii0zpwQhzcTBCTKcB2j4/nkgw4sLEnOLM9Mh8qcYdTk6bt79wyTEkpeflyolztsGUiQA
        UpRRmgc3B5YYXjGKA70lzDsFZB0PMKnATXoFtIQJaEnJ8w0gS0oSEVJSDYwp0vl6K9Zu4v3Y
        zRzZdzggmu1MblH20x6RZa6p+YzbVO/NFZnbfqliz07WB5IqC1Y92HxRwrH/bP9pvjTF1Z43
        9rD+2MHDu/3s7+jNpnYXkqcLZSy62Zx13EDu/8IOYYH0g/EPfHKvmy9c/qfLxsa4cZ2Vk2gO
        146kj0+zoxOe5DBHhaXNWKzEUpyRaKjFXFScCABsYjHI5wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At least since v1.7, the elements of the `refs_to_prune` linked list
have been leaked. Fix the leak by teaching `prune_refs()` to free the
list elements as it processes them.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3475c6f8a2..60031fe3ae 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1057,11 +1057,17 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	strbuf_release(&err);
 }
 
-static void prune_refs(struct files_ref_store *refs, struct ref_to_prune *r)
+/*
+ * Prune the loose versions of the references in the linked list
+ * `*refs_to_prune`, freeing the entries in the list as we go.
+ */
+static void prune_refs(struct files_ref_store *refs, struct ref_to_prune **refs_to_prune)
 {
-	while (r) {
+	while (*refs_to_prune) {
+		struct ref_to_prune *r = *refs_to_prune;
+		*refs_to_prune = r->next;
 		prune_ref(refs, r);
-		r = r->next;
+		free(r);
 	}
 }
 
@@ -1148,7 +1154,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 
 	packed_refs_unlock(refs->packed_ref_store);
 
-	prune_refs(refs, refs_to_prune);
+	prune_refs(refs, &refs_to_prune);
 	strbuf_release(&err);
 	return 0;
 }
-- 
2.14.1

