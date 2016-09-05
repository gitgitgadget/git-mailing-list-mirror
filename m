Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60ECE1F6BF
	for <e@80x24.org>; Mon,  5 Sep 2016 09:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbcIEJpi (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 05:45:38 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50176 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932408AbcIEJpe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 05:45:34 -0400
X-AuditID: 1207440c-217ff700000008d5-da-57cd3ea46185
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 64.69.02261.4AE3DC75; Mon,  5 Sep 2016 05:45:08 -0400 (EDT)
Received: from bagpipes.fritz.box (p57907BC3.dip0.t-ipconnect.de [87.144.123.195])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u859iwtQ008788
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 5 Sep 2016 05:45:06 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 3/8] is_blank_line(): take a single xrecord_t as argument
Date:   Mon,  5 Sep 2016 11:44:48 +0200
Message-Id: <453ac11efe49ada493dc8af2041ad6de190c5a77.1473068229.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473068229.git.mhagger@alum.mit.edu>
References: <cover.1473068229.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsUixO6iqLvE7my4wcbjnBZdV7qZLBp6rzBb
        7F7cz2yx4uocZoszW4Gs2yvmM1v8aOlhtph51dpi8+Z2FgdOj7/vPzB57Jx1l91jwaZSj2e9
        exg9Ll5S9ti/dBubx+dNch63n21jCeCI4rJJSc3JLEst0rdL4Mr4tGs3U8Fb7oodR+4xNTBO
        4exi5OSQEDCR2DH3PksXIxeHkMBWRommO6+ZIJyTTBLv7z9jAaliE9CVWNTTzARiiwiIS7w9
        PpMdpIhZ4C+TxOJHd9lAEsICPhKPWpawgtgsAqoS3d9XM4PYvAJREmsXzmGCWCcncWnbF7A4
        p4CFxJIvfewgtpCAucS8ec3MExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdTLzSzR
        S00p3cQICT+eHYzf1skcYhTgYFTi4bXQPhMuxJpYVlyZe4hRkoNJSZS3QPVsuBBfUn5KZUZi
        cUZ8UWlOavEhRgkOZiUR3hxboBxvSmJlVWpRPkxKmoNFSZxXdYm6n5BAemJJanZqakFqEUxW
        hoNDSYJXDaRRsCg1PbUiLTOnBCHNxMEJMpwHaLizDcjw4oLE3OLMdIj8KUZFKXHeFJCEAEgi
        ozQPrheWHl4xigO9Isw7H2QFDzC1wHW/AhrMBDR43e7TIINLEhFSUg2MWS0M/hs2y5x8IWbn
        WSfxyHWW4MxJIlliy63UD4r6tng/un2jTujSVKFv0cohNTZGs85JlQkt/VZq+HH+FV2XtfVX
        OuPPVj7f5b/7l+rCyZdyjnQrZEe+9sl4fP/NnzCBdwkK6nwr+TjjBBfU+slsaV+jrdZvIfjU
        5HFOqvQe9bMnVC7/+nJViaU4I9FQi7moOBEAp9PZF+oCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no reason for it to take an array and index as argument, as it
only accesses a single element of the array.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 xdiff/xdiffi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 61deed8..ed2df64 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,9 +400,9 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
-static int is_blank_line(xrecord_t **recs, long ix, long flags)
+static int is_blank_line(xrecord_t *rec, long flags)
 {
-	return xdl_blankline(recs[ix]->ptr, recs[ix]->size, flags);
+	return xdl_blankline(rec->ptr, rec->size, flags);
 }
 
 static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
@@ -485,7 +485,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the group.
 			 */
 			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
-				blank_lines += is_blank_line(recs, ix, flags);
+				blank_lines += is_blank_line(recs[ix], flags);
 
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
@@ -524,7 +524,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * back only if at all.
 			 */
 			while (ixs > 0 &&
-			       !is_blank_line(recs, ix - 1, flags) &&
+			       !is_blank_line(recs[ix - 1], flags) &&
 			       recs_match(recs, ixs - 1, ix - 1, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
-- 
2.9.3

