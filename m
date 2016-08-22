Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339622018E
	for <e@80x24.org>; Mon, 22 Aug 2016 11:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755151AbcHVLY4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 07:24:56 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61858 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753724AbcHVLYM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Aug 2016 07:24:12 -0400
X-AuditID: 1207440e-dafff70000000931-82-57bae0933ec3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 24.47.02353.390EAB75; Mon, 22 Aug 2016 07:22:59 -0400 (EDT)
Received: from bagpipes.fritz.box (p5790719A.dip0.t-ipconnect.de [87.144.113.154])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7MBMnQS027076
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 Aug 2016 07:22:58 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 4/7] recs_match(): take two xrecord_t pointers as arguments
Date:   Mon, 22 Aug 2016 13:22:43 +0200
Message-Id: <1f7f17cc1b2434ab5dfc4fea95a09597e61a4886.1471864378.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1471864378.git.mhagger@alum.mit.edu>
References: <cover.1471864378.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsUixO6iqLvqwa5wg9vz5Sy6rnQzWTT0XmG2
        2L24n9lixdU5zBa3V8xntvjR0sNssXlzO4sDu8ff9x+YPHbOusvusWBTqcez3j2MHhcvKXt8
        3iQXwBbFZZOSmpNZllqkb5fAlfF7zXuWgsUCFd9797I3MG7j6WLk5JAQMJF4vfguSxcjF4eQ
        wFZGiaWre9ghnFNMEl3zPjGCVLEJ6Eos6mlmArFFBMQl3h6fCVbELNDPJPGjowusSFjAT+Lg
        gV1gNouAqsT57UvAGngFoiReNz1gglgnJ3Fp2xfmLkYODk4BC4mtLcogYSEBc4lnO06yT2Dk
        WcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJKz4djC2r5c5xCjAwajE
        w/vh4M5wIdbEsuLK3EOMkhxMSqK8Zq1AIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8++/tChfi
        TUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnw3gRpFCxKTU+tSMvMKUFI
        M3FwggznARp+DGx4cUFibnFmOkT+FKOilDhvPkhCACSRUZoH1wuL+1eM4kCvCPMa3Qeq4gGm
        DLjuV0CDmYAGX/+/HWRwSSJCSqqBMWPPIenL7XtOam9foxt887PprqXtsUtdT33s72S2dqh0
        zlTMD/xW/sP7Qdnm2rC7mu+jLGT1drWK3BATkOW0CXi/0bjR0vVi7wnpKT4r/KQuZTBeN/z+
        bf+67Zd3T76xtPqawip3o9nMjS1X3wg3bQmPETjKz3PTQ+M2lye7/Js+z/59yrvXKLEUZyQa
        ajEXFScCAPPOEDLWAgAA
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

