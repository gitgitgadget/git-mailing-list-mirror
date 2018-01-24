Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4871F1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933332AbeAXLOc (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:14:32 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:55486 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933236AbeAXLO2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jan 2018 06:14:28 -0500
X-AuditID: 12074412-c9dff70000000b7d-5d-5a686a9249fe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id FD.B8.02941.29A686A5; Wed, 24 Jan 2018 06:14:26 -0500 (EST)
Received: from bagpipes.fritz.box (p54AAE3E5.dip0.t-ipconnect.de [84.170.227.229])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0OBEIi7004669
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Jan 2018 06:14:25 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/6] find_reference_location(): make function safe for empty snapshots
Date:   Wed, 24 Jan 2018 12:14:13 +0100
Message-Id: <e9f9ed1944c297a68c2b76f5d4ddd73e279bd207.1516791909.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
References: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
In-Reply-To: <cover.1516791909.git.mhagger@alum.mit.edu>
References: <cover.1516791909.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsUixO6iqDspKyPK4NMFK4uuK91MFg29V5gt
        +pd3sVkc7JzJanF7xXxmix8tPcwObB5/339g8vjwMc6j78gaRo9nvXsYPS5eUvb4vEkugC2K
        yyYlNSezLLVI3y6BK2PFy5XsBXP5KvYeXM7cwLiRu4uRk0NCwETi1vsHrF2MXBxCAjuYJCa2
        NrFAOJeYJF6ufs8OUsUmoCuxqKeZCcQWEVCTmNh2CKyIWeA0o8Su/ctYQBLCAmESa1qOMIPY
        LAKqEidWbmUFsXkFoiQ2LrzABrFOXuL9gvuMIDangINE945LYHEhAXuJ7muHgHo5gOIWEpcX
        aYGYQgLmEnf+8Uxg5FvAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdMLzezRC81pXQTIyT0
        hHYwrj8pd4hRgINRiYf3hkV6lBBrYllxZe4hRkkOJiVR3vygjCghvqT8lMqMxOKM+KLSnNTi
        Q4wSHMxKIrx5rEDlvCmJlVWpRfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvP6Z
        QEMFi1LTUyvSMnNKENJMHJwgw3mAhm/IAKrhLS5IzC3OTIfIn2LU5bjx4nUbsxBLXn5eqpQ4
        bwXIIAGQoozSPLg5sJTxilEc6C1h3sUgVTzAdAM36RXQEiagJTdqUkGWlCQipKQaGJN3vEl1
        ubh1w84v664e/ODqZCNS+N/A9ehUk7mepkIBu/1NI6+v317otHV78/pf108YXZJwLjYrcd+y
        Q2/Wmj9cGr/Kjq7qfH/KfUr8f9+1JcoSLiq8X8Q0GjUfZqT//c4udzSzZVepnMst++pJUZvY
        EvZ+OND0yOGOwMX9n8X+80ooSCd1WyqxFGckGmoxFxUnAgA7mBzn9AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function had two problems if called for an empty snapshot (i.e.,
`snapshot->start == snapshot->eof == NULL`):

* It checked `NULL < NULL`, which is undefined by C (albeit highly
  unlikely to fail in the real world).

* (Assuming the above comparison behaved as expected), it returned
  NULL when `mustexist` was false, contrary to its docstring.

Change the check and fix the docstring.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 08698de6ea..361affd7ad 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -519,9 +519,11 @@ static int load_contents(struct snapshot *snapshot)
  * `refname` starts. If `mustexist` is true and the reference doesn't
  * exist, then return NULL. If `mustexist` is false and the reference
  * doesn't exist, then return the point where that reference would be
- * inserted. In the latter mode, `refname` doesn't have to be a proper
- * reference name; for example, one could search for "refs/replace/"
- * to find the start of any replace references.
+ * inserted, or `snapshot->eof` (which might be NULL) if it would be
+ * inserted at the end of the file. In the latter mode, `refname`
+ * doesn't have to be a proper reference name; for example, one could
+ * search for "refs/replace/" to find the start of any replace
+ * references.
  *
  * The record is sought using a binary search, so `snapshot->buf` must
  * be sorted.
@@ -551,7 +553,7 @@ static const char *find_reference_location(struct snapshot *snapshot,
 	 */
 	const char *hi = snapshot->eof;
 
-	while (lo < hi) {
+	while (lo != hi) {
 		const char *mid, *rec;
 		int cmp;
 
-- 
2.14.2

