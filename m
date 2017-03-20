Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756412095B
	for <e@80x24.org>; Mon, 20 Mar 2017 16:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754994AbdCTQd6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:33:58 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52940 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753447AbdCTQd4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:33:56 -0400
X-AuditID: 12074412-4a3ff70000000b04-e6-58d0046328b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D4.CA.02820.36400D85; Mon, 20 Mar 2017 12:33:40 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9D010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:38 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/20] refs_ref_iterator_begin(): new function
Date:   Mon, 20 Mar 2017 17:33:08 +0100
Message-Id: <840b199ad58f11a690c684ad110807ed81d3b0eb.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqJvCciHCYM0WLouuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHl3tR9g8nvXuYfS4eEnZ4/MmuQC2
        KC6blNSczLLUIn27BK6M9kvf2ApmClb07L7A1sDYytfFyMkhIWAiMW3CY7YuRi4OIYEdTBKn
        z/1lh3BOMUn0TZjCClLFJqArsainmQnEFhFQk5jYdogFpIhZ4BGjxNX5d9lBEsICdhIT9k5k
        AbFZBFQlVm3/yQhi8wpESVz4N5URYp28xK62i2BDOQUsJL7cbwSrFxIwl+hc0Ms+gZFnASPD
        Kka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQgBLawbj+pNwhRgEORiUe3hVX
        zkcIsSaWFVfmHmKU5GBSEuV9ehsoxJeUn1KZkVicEV9UmpNafIhRgoNZSYS36iVQjjclsbIq
        tSgfJiXNwaIkzvtzsbqfkEB6YklqdmpqQWoRTFaGg0NJgpcdGDlCgkWp6akVaZk5JQhpJg5O
        kOE8QMMVQGp4iwsSc4sz0yHypxh1OW417HnDJMSSl5+XKiXOe44JqEgApCijNA9uDiwRvGIU
        B3pLmPcrSBUPMInATXoFtIQJaMmyG2dAlpQkIqSkGhgXG2kpd0yLtOn617YuTkNvxqO+6x9Y
        //ren+UezVHhefGlc9WVAL6/BTt638v35EQcy5tU9EtG/v7iqRmiKu8ub34b+raBaRrjQamP
        1sGrFvusSDe7410XePfOivWOxtXeb2356kPkvvFNX6bS9W+y1dMtMVLLkw6sr3qhdHPd+sz1
        rx9l3itVYinOSDTUYi4qTgQAwf7Z6t8CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a new function from `do_for_each_ref()`. It will be useful
elsewhere.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 15 +++++++++++++--
 refs/refs-internal.h | 11 +++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 0ed6c3c7a4..aeb704ab92 100644
--- a/refs.c
+++ b/refs.c
@@ -1230,6 +1230,18 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return head_ref_submodule(NULL, fn, cb_data);
 }
 
+struct ref_iterator *refs_ref_iterator_begin(
+		struct ref_store *refs,
+		const char *prefix, int trim, int flags)
+{
+	struct ref_iterator *iter;
+
+	iter = refs->be->iterator_begin(refs, prefix, flags);
+	iter = prefix_ref_iterator_begin(iter, prefix, trim);
+
+	return iter;
+}
+
 /*
  * Call fn for each reference in the specified submodule for which the
  * refname begins with prefix. If trim is non-zero, then trim that
@@ -1247,8 +1259,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = refs->be->iterator_begin(refs, prefix, flags);
-	iter = prefix_ref_iterator_begin(iter, prefix, trim);
+	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
 
 	return do_for_each_ref_iterator(iter, fn, cb_data);
 }
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 6ee9f20dbc..545989ae7f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -335,6 +335,17 @@ struct ref_iterator *empty_ref_iterator_begin(void);
  */
 int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
 
+/*
+ * Return an iterator that goes over each reference in `refs` for
+ * which the refname begins with prefix. If trim is non-zero, then
+ * trim that many characters off the beginning of each refname. flags
+ * can be DO_FOR_EACH_INCLUDE_BROKEN to include broken references in
+ * the iteration.
+ */
+struct ref_iterator *refs_ref_iterator_begin(
+		struct ref_store *refs,
+		const char *prefix, int trim, int flags);
+
 /*
  * A callback function used to instruct merge_ref_iterator how to
  * interleave the entries from iter0 and iter1. The function should
-- 
2.11.0

