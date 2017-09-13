Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324A720286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbdIMRQa (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:30 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45703 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751117AbdIMRQ2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:28 -0400
X-AuditID: 12074413-3a3ff70000007929-32-59b967ea0e04
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 57.25.31017.AE769B95; Wed, 13 Sep 2017 13:16:26 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIiQ001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:24 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/20] prefix_ref_iterator: break when we leave the prefix
Date:   Wed, 13 Sep 2017 19:15:56 +0200
Message-Id: <2bb2e8ccb57eef8acbea5004167751a007a1bd2f.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqPsqfWekwbMpmhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxtQ/k1gL/ghVNL3qZmtgbObvYuTkkBAwkVg5cQkz
        iC0ksINJYuYp9S5GLiD7JJPE4rbjTCAJNgFdiUU9zWC2iICaxMS2QywgRcwCT5kkdp68ywqS
        EBbwkrjypRWsiEVAVWL5+qVsXYwcHLwCURKnnipALJOXOPfgNtgyTgELiY07njBCLDaXaJyz
        k3ECI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCHhJbyDcddJuUOM
        AhyMSjy8FjY7I4VYE8uKK3MPMUpyMCmJ8u7VBQrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4Q2K
        AsrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4nYBxJCRYlJqeWpGW
        mVOCkGbi4AQZzgM0XBCkhre4IDG3ODMdIn+KUZej4+bdP0xCLHn5ealS4rx/U4GKBECKMkrz
        4ObA0sIrRnGgt4R5j6UBVfEAUwrcpFdAS5iAlpw5vQNkSUkiQkqqgZGNJe6fZVpn2cLMnZkb
        XOQOTqx0vrNaXiea6coqoekz7n3//DRsu2PpdkcrjQ3lr/SfLldUSPOyV6naVVp7V/D4mumy
        HX7JF77O0WLdv2HzVKltobxzN7K8nnNdcSfvT3uxvUFvNdiUZYuzciRY02uven36N+VPeVDu
        /7CNsV/kJy68My/k2CQlluKMREMt5qLiRACwkyaw5gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

If the underlying iterator is ordered, then `prefix_ref_iterator` can
stop as soon as it sees a refname that comes after the prefix. This
will rarely make a big difference now, because `ref_cache_iterator`
only iterates over the directory containing the prefix (and usually
the prefix will span a whole directory anyway). But if *hint, hint* a
future reference backend doesn't itself know where to stop the
iteration, then this optimization will be a big win.

Note that there is no guarantee that the underlying iterator doesn't
include output preceding the prefix, so we have to skip over any
unwanted references before we get to the ones that we want.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Note that the implementation of `compare_prefix()` here is a bit
different than Peff's original version.

 refs/iterator.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/refs/iterator.c b/refs/iterator.c
index c475360f0a..bd35da4e62 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -287,6 +287,20 @@ struct prefix_ref_iterator {
 	int trim;
 };
 
+/* Return -1, 0, 1 if refname is before, inside, or after the prefix. */
+static int compare_prefix(const char *refname, const char *prefix)
+{
+	while (*prefix) {
+		if (*refname != *prefix)
+			return ((unsigned char)*refname < (unsigned char)*prefix) ? -1 : +1;
+
+		refname++;
+		prefix++;
+	}
+
+	return 0;
+}
+
 static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 {
 	struct prefix_ref_iterator *iter =
@@ -294,9 +308,25 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	int ok;
 
 	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
-		if (!starts_with(iter->iter0->refname, iter->prefix))
+		int cmp = compare_prefix(iter->iter0->refname, iter->prefix);
+
+		if (cmp < 0)
 			continue;
 
+		if (cmp > 0) {
+			/*
+			 * If the source iterator is ordered, then we
+			 * can stop the iteration as soon as we see a
+			 * refname that comes after the prefix:
+			 */
+			if (iter->iter0->ordered) {
+				ok = ref_iterator_abort(iter->iter0);
+				break;
+			} else {
+				continue;
+			}
+		}
+
 		if (iter->trim) {
 			/*
 			 * It is nonsense to trim off characters that
-- 
2.14.1

