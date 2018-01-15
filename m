Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC241F406
	for <e@80x24.org>; Mon, 15 Jan 2018 12:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933586AbeAOMSD (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 07:18:03 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47992 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932252AbeAOMR6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jan 2018 07:17:58 -0500
X-AuditID: 1207440d-973ff70000000c05-1b-5a5c9bf161c4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F6.C0.03077.1FB9C5A5; Mon, 15 Jan 2018 07:17:54 -0500 (EST)
Received: from bagpipes.fritz.box (p54AAEF2D.dip0.t-ipconnect.de [84.170.239.45])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0FCHiEs010101
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Jan 2018 07:17:51 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/3] find_reference_location(): don't invoke if `snapshot->buf` is NULL
Date:   Mon, 15 Jan 2018 13:17:35 +0100
Message-Id: <46a457904cf0261e337dfd94dc2f1d62abf64053.1516017331.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180114191416.2368-1-kgybels@infogroep.be>
References: <20180114191416.2368-1-kgybels@infogroep.be>
In-Reply-To: <cover.1516017331.git.mhagger@alum.mit.edu>
References: <cover.1516017331.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsUixO6iqPtpdkyUwYfLshZdV7qZLBp6rzBb
        9C/vYrM42DmT1eL2ivnMDqwef99/YPL48DHOo+/IGkaPi5eUPT5vkgtgjeKySUnNySxLLdK3
        S+DK2Df1OXPBHP6Ko0cXszYwzubpYuTkkBAwkbh86QxbFyMXh5DADiaJHw9WM0E4F5kkFrTu
        ZwepYhPQlVjU08wEYosIqEocnD+FEaSIWWAFo8Taph6gBAeHsEC4xMRJ6iA1LEA1P3e9B6vn
        FYiSWNr/kRFim7zE+wX3wWxOAUuJo++2sYHYQgIWEp8OfWIGGcMJZK+7kAwRNpc4+b2TfQIj
        3wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYIWHGu4Px/zqZQ4wCHIxK
        PLwRy6KjhFgTy4orcw8xSnIwKYnyqvfGRAnxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4W0MBsrx
        piRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4V8wCahQsSk1PrUjLzClB
        SDNxcIIM5wEa/hSkhre4IDG3ODMdIn+KUZfjxovXbcxCLHn5ealS4rxdIEUCIEUZpXlwc2Dp
        4RWjONBbwry3QKp4gKkFbtIroCVMQEvql0SCLClJREhJNTDWzL2m8P9fsrTl5YSpggKN654+
        3/Yh5K94XJ+PeOqc1srYirhS+3WhrToeP8oSX+bk6Trdu7H4cJLbivsXlHauyxT8vD5c9UL6
        yerN/q+FftYfCjxZ6vy05t36rMUWbPUy5cxJXiE71Bc5zpSU/PXY5Jbjea7y6x/bDWYt2uWr
        e2LXylWMe8WUWIozEg21mIuKEwFtZUK56gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If `snapshot->buf` is NULL, then `find_reference_location()` has two
problems:

1. It relies on behavior that is technically undefined in C, such as
   computing `NULL + 0`.

2. It returns NULL if the reference doesn't exist, even if `mustexist`
   is not set. This problem doesn't come up in the current code,
   because we never call this function with `snapshot->buf == NULL`
   and `mustexist` set. But it is something that future callers need
   to be aware of.

We could fix the first problem by adding some extra logic to the
function. But considering both problems together, it is more
straightforward to document that the function should only be called if
`snapshot->buf` is non-NULL.

Adjust `packed_read_raw_ref()` to return early if `snapshot->buf` is
NULL rather than calling `find_reference_location()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 36796d65f0..ed2b396bef 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -521,8 +521,9 @@ static int load_contents(struct snapshot *snapshot)
  * reference name; for example, one could search for "refs/replace/"
  * to find the start of any replace references.
  *
+ * This function must only be called if `snapshot->buf` is non-NULL.
  * The record is sought using a binary search, so `snapshot->buf` must
- * be sorted.
+ * also be sorted.
  */
 static const char *find_reference_location(struct snapshot *snapshot,
 					   const char *refname, int mustexist)
@@ -728,6 +729,12 @@ static int packed_read_raw_ref(struct ref_store *ref_store,
 
 	*type = 0;
 
+	if (!snapshot->buf) {
+		/* There are no packed references */
+		errno = ENOENT;
+		return -1;
+	}
+
 	rec = find_reference_location(snapshot, refname, 1);
 
 	if (!rec) {
-- 
2.14.2

