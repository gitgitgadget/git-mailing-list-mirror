Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30111F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbcHCWBG (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:01:06 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43167 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755000AbcHCWBA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:01:00 -0400
X-AuditID: 12074412-1afff70000000931-40-57a269984bfc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id EA.0F.02353.89962A75; Wed,  3 Aug 2016 18:00:56 -0400 (EDT)
Received: from michael.fritz.box (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73M0fSe023677
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 18:00:54 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	git@vger.kernel.org
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 7/8] is_blank_line: take a single xrecord_t as argument
Date:	Thu,  4 Aug 2016 00:00:35 +0200
Message-Id: <4a83126ab9e7bff9061204296798bf281242358e.1470259583.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1470259583.git.mhagger@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqDsjc1G4wdH/IhZdV7qZLBp6rzBb
	7F7cz2yx4uocZovbK+YzW/xo6WG22Ly5ncWB3ePv+w9MHjtn3WX3WLCp1ONZ7x5Gj4uXlD0+
	b5ILYIvisklJzcksSy3St0vgyph/ZCpLwVyeij1T/BsYD3F2MXJySAiYSKz5N5+ti5GLQ0hg
	K6PEzQebmCGc40wS21/uZwKpYhPQlVjU0wxmiwiIS7w9PpMdpIhZoJ9J4kdHFyNIQljAXeLP
	izssXYwcHCwCqhJrVxmAhHkFoiT2HPzPArFNTuLy9AdsIDangIXE1UmzwWYKCZhLvO3YxTqB
	kWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJCgEtrBuP6k3CFGAQ5G
	JR7eDZKLwoVYE8uKK3MPMUpyMCmJ8uakAoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8N5LAcrx
	piRWVqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1ILYLJynBwKEnwvk4HahQsSk1PrUjLzClB
	SDNxcIIM5wEavgekhre4IDG3ODMdIn+KUVFKnNcCJCEAksgozYPrhUX9K0ZxoFeEeaszgKp4
	gAkDrvsV0GAmoMEnDBaADC5JREhJNTC28VTfv9bRqmp7ayVvbHzb+8Bm20Wyhm6/nHlm8jdt
	WFvGP/PWkYaNQRmCHdMnR0jHSi95uULzUPus8pYvhy3z9wrp/rky89UTdYaCbtcrSv+u1OnX
	Vm5ND9u/TNfhopB7GsODP4X1e/6E3At9MeGb6M/L8+prpBSlLLiMHETqZsvlHVL7+UyJpTgj
	0VCLuag4EQAjAiYn1QIAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There is no reason for it to take an array and index as argument, as it
only accesses a single element of the array.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 xdiff/xdiffi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 34f021a..7518cd5 100644
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
@@ -525,7 +525,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the current change group.
 			 */
 			while (end < nrec && recs_match(recs, start, end, flags)) {
-				blank_lines += is_blank_line(recs, end, flags);
+				blank_lines += is_blank_line(recs[end], flags);
 
 				rchg[start++] = 0;
 				rchg[end++] = 1;
@@ -564,7 +564,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * backward shifts, not forward ones.
 			 */
 			while (start > 0 &&
-			       !is_blank_line(recs, end - 1, flags) &&
+			       !is_blank_line(recs[end - 1], flags) &&
 			       recs_match(recs, start - 1, end - 1, flags)) {
 				rchg[--start] = 1;
 				rchg[--end] = 0;
-- 
2.8.1

