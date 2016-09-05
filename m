Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B689A20193
	for <e@80x24.org>; Mon,  5 Sep 2016 09:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932702AbcIEJpm (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 05:45:42 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60354 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932301AbcIEJpb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 05:45:31 -0400
X-AuditID: 12074411-a07ff70000000932-c2-57cd3ea6d0a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 62.9A.02354.6AE3DC75; Mon,  5 Sep 2016 05:45:10 -0400 (EDT)
Received: from bagpipes.fritz.box (p57907BC3.dip0.t-ipconnect.de [87.144.123.195])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u859iwtR008788
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 5 Sep 2016 05:45:08 -0400
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
Subject: [PATCH v3 4/8] recs_match(): take two xrecord_t pointers as arguments
Date:   Mon,  5 Sep 2016 11:44:49 +0200
Message-Id: <1f7f17cc1b2434ab5dfc4fea95a09597e61a4886.1473068229.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473068229.git.mhagger@alum.mit.edu>
References: <cover.1473068229.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsUixO6iqLvM7my4wZwDnBZdV7qZLBp6rzBb
        7F7cz2yx4uocZoszW4Gs2yvmM1v8aOlhtph51dpi8+Z2FgdOj7/vPzB57Jx1l91jwaZSj2e9
        exg9Ll5S9ti/dBubx+dNch63n21jCeCI4rJJSc3JLEst0rdL4Mr4veY9S8FigYrvvXvZGxi3
        8XQxcnJICJhIfJ1wnKWLkYtDSGAro8Td2ztZIZyTTBKH5q5kBqliE9CVWNTTzARiiwiIS7w9
        PpMdpIhZ4C+TxOJHd9lAEsICfhKfPp9mBbFZBFQl9n1/wghi8wpESax99YMVYp2cxKVtX8CG
        cgpYSCz50scOYgsJmEvMm9fMPIGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXVO93MwS
        vdSU0k2MkPAT3ME446TcIUYBDkYlHt4JumfChVgTy4orcw8xSnIwKYnyFqieDRfiS8pPqcxI
        LM6ILyrNSS0+xCjBwawkwptjC5TjTUmsrEotyodJSXOwKInz8i1R9xMSSE8sSc1OTS1ILYLJ
        ynBwKEnwqoE0ChalpqdWpGXmlCCkmTg4QYbzAA13tgEZXlyQmFucmQ6RP8WoKCXOmwKSEABJ
        ZJTmwfXC0sMrRnGgV4R554Os4AGmFrjuV0CDmYAGr9t9GmRwSSJCSqqBsTTB49eHp2fdo15f
        9LjX77W84qbetqJCnaXe2zxOWx9ulp6y+31XReCROUFSgT/6thREMTycfky88MLD56+3FNrk
        Hdm94PHV0h/MM5mdcuvXxa2et1VBP3qS7G+R2epNtYKHJvI90Lme+yKNZ/9WPin9DI0DXVN2
        yu5om37t3/q/qvZHFi+tMVZiKc5INNRiLipOBAAn4P4R6gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no reason for it to take an array and two indexes as argument,
as it only accesses two elements of the array.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 xdiff/xdiffi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index ed2df64..8a5832a 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -405,11 +405,11 @@ static int is_blank_line(xrecord_t *rec, long flags)
 	return xdl_blankline(rec->ptr, rec->size, flags);
 }
 
-static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
+static int recs_match(xrecord_t *rec1, xrecord_t *rec2, long flags)
 {
-	return (recs[ixs]->ha == recs[ix]->ha &&
-		xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size,
-			     recs[ix]->ptr, recs[ix]->size,
+	return (rec1->ha == rec2->ha &&
+		xdl_recmatch(rec1->ptr, rec1->size,
+			     rec2->ptr, rec2->size,
 			     flags));
 }
 
@@ -457,7 +457,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the last line of the current change group, shift backward
 			 * the group.
 			 */
-			while (ixs > 0 && recs_match(recs, ixs - 1, ix - 1, flags)) {
+			while (ixs > 0 && recs_match(recs[ixs - 1], recs[ix - 1], flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
 
@@ -484,7 +484,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the line next of the current change group, shift forward
 			 * the group.
 			 */
-			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
+			while (ix < nrec && recs_match(recs[ixs], recs[ix], flags)) {
 				blank_lines += is_blank_line(recs[ix], flags);
 
 				rchg[ixs++] = 0;
@@ -525,7 +525,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 */
 			while (ixs > 0 &&
 			       !is_blank_line(recs[ix - 1], flags) &&
-			       recs_match(recs, ixs - 1, ix - 1, flags)) {
+			       recs_match(recs[ixs - 1], recs[ix - 1], flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
 				while (rchgo[--ixo]);
-- 
2.9.3

