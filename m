Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7EF1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758341AbcHCWBA (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:01:00 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:44998 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755000AbcHCWA6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:00:58 -0400
X-AuditID: 12074411-a07ff70000000932-1e-57a2698fea18
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F7.84.02354.F8962A75; Wed,  3 Aug 2016 18:00:49 -0400 (EDT)
Received: from michael.fritz.box (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73M0fSZ023677
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 18:00:46 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	git@vger.kernel.org
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/8] xdl_change_compact(): clarify code
Date:	Thu,  4 Aug 2016 00:00:30 +0200
Message-Id: <f4ce27f389b64c9ae503152c66d183c4a4a970f1.1470259583.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1470259583.git.mhagger@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsUixO6iqDsxc1G4QcNlFYuuK91MFg29V5gt
	di/uZ7ZYcXUOs8XtFfOZLX609DBbbN7czuLA7vH3/Qcmj52z7rJ7LNhU6vGsdw+jx8VLyh6f
	N8kFsEVx2aSk5mSWpRbp2yVwZUyfz17Qo1mx4/wVpgbGPtkuRk4OCQETic0nNrN1MXJxCAls
	ZZSYevYYC4RznEni8K8frCBVbAK6Eot6mplAbBEBcYm3x2eygxQxC/QzSfzo6GIESQgLmEss
	u/SbGcRmEVCVmLtgKRuIzSsQJfHiwHxWiHVyEpenPwCLcwpYSFydNBtsqBBQ79uOXawTGHkW
	MDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11cvNLNFLTSndxAgJK8EdjDNOyh1iFOBgVOLh
	3SC5KFyINbGsuDL3EKMkB5OSKG9OKlCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO+9FKAcb0pi
	ZVVqUT5MSpqDRUmcl2+Jup+QQHpiSWp2ampBahFMVoaDQ0mCNzkDqFGwKDU9tSItM6cEIc3E
	wQkynAdo+J50kOHFBYm5xZnpEPlTjIpS4rwWIAkBkERGaR5cLyzuXzGKA70izFsNsoIHmDLg
	ul8BDWYCGnzCYAHI4JJEhJRUA+PWp9LyBi9iJzx6sm8Xkx73180RJeGSMYmiSv/burneZSXE
	SE/K6XA62sO6YXL86R+tXrqLA5paxXPkwpeK/vT98Wfz01duPn/2Tvt9X7SZYaqP5waF/7U3
	jh29+TUlLvxFJm99xSPNDcGbdjjppTsbX625tc7tzdnFmeFPd/MoeXNZZppvFFViKc5INNRi
	LipOBABWmKhA1gIAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Write things out a bit longer but less cryptically. Add more comments.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
I find the loops in the old code, with unfamiliar patterns of embedded
increment/decrement operators, confusing, and I think that writing
things out a little bit more verbosely (and with more comments) makes
it much easier to read the code and be sure that it is correct.
The compiled code and performance shouldn't be affected materially.

 xdiff/xdiffi.c | 106 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 73 insertions(+), 33 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index ff7fc42..a0a485c 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -434,8 +434,14 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		 * not need index bounding since the array is prepared with
 		 * a zero at position -1 and N.
 		 */
-		for (; i < nrec && !rchg[i]; i++)
-			while (rchgo[io++]);
+		for (; i < nrec && !rchg[i]; i++) {
+			/* skip over any changed lines in the other file... */
+			while (rchgo[io])
+				io++;
+
+			/* ...plus one non-changed line. */
+			io++;
+		}
 		if (i == nrec)
 			break;
 
@@ -444,45 +450,70 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		 * and find the end of it, on both to-be-compacted and other file
 		 * indexes (i and io).
 		 */
-		start = i;
-		for (i++; rchg[i]; i++);
-		for (; rchgo[io]; io++);
+		start = i++;
+
+		while (rchg[i])
+			i++;
+
+		while (rchgo[io])
+		       io++;
 
 		do {
 			groupsize = i - start;
+
+			/*
+			 * Are there any blank lines that could appear as the last
+			 * line of this group?
+			 */
 			blank_lines = 0;
 
 			/*
-			 * If the line before the current change group, is equal to
-			 * the last line of the current change group, shift backward
-			 * the group.
+			 * While the line before the current change group is equal
+			 * to the last line of the current change group, shift the
+			 * group backward.
 			 */
 			while (start > 0 && recs_match(recs, start - 1, i - 1, flags)) {
 				rchg[--start] = 1;
 				rchg[--i] = 0;
 
 				/*
-				 * This change might have joined two change groups,
-				 * so we try to take this scenario in account by moving
-				 * the start index accordingly (and so the other-file
-				 * end-of-group index).
+				 * This change might have joined two change groups.
+				 * If so, move the start index to the beginning of
+				 * the combined group:
 				 */
-				for (; rchg[start - 1]; start--);
-				while (rchgo[--io]);
+				while (rchg[start - 1])
+					start--;
+
+				/*
+				 * Move the other file index past a non-changed
+				 * line...
+				 */
+				io--;
+
+				/* ...and also past any changed lines: */
+				while (rchgo[io])
+					io--;
 			}
 
-			/*
-			 * Record the end-of-group position in case we are matched
-			 * with a group of changes in the other file (that is, the
-			 * change record before the end-of-group index in the other
-			 * file is set).
-			 */
-			ixref = rchgo[io - 1] ? i : nrec;
+			if (rchgo[io - 1]) {
+				/*
+				 * This change is matched to a group of changes in
+				 * the other file. Record the end-of-group
+				 * position:
+				 */
+				ixref = i;
+			} else {
+				/*
+				 * Otherwise, set a value to signify that there
+				 * are no matched changes in the other file:
+				 */
+				ixref = nrec;
+			}
 
 			/*
-			 * If the first line of the current change group, is equal to
-			 * the line next of the current change group, shift forward
-			 * the group.
+			 * Now shift the group forward as long as the first line
+			 * of the current change group is equal to the line after
+			 * the current change group.
 			 */
 			while (i < nrec && recs_match(recs, start, i, flags)) {
 				blank_lines += is_blank_line(recs, i, flags);
@@ -491,16 +522,22 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				rchg[i++] = 1;
 
 				/*
-				 * This change might have joined two change groups,
-				 * so we try to take this scenario in account by moving
-				 * the start index accordingly (and so the other-file
-				 * end-of-group index). Keep tracking the reference
-				 * index in case we are shifting together with a
-				 * corresponding group of changes in the other file.
+				 * This change might have joined two change
+				 * groups. If so, move the start index accordingly
+				 * (and so the other-file end-of-group index).
+				 * Keep tracking the reference index in case we
+				 * are shifting together with a corresponding
+				 * group of changes in the other file.
 				 */
-				for (; rchg[i]; i++);
-				while (rchgo[++io])
+				while (rchg[i])
+					i++;
+
+				io++;
+				if (rchgo[io]) {
 					ixref = i;
+					while (rchgo[io])
+						io++;
+				}
 			}
 		} while (groupsize != i - start);
 
@@ -511,7 +548,10 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		while (ixref < i) {
 			rchg[--start] = 1;
 			rchg[--i] = 0;
-			while (rchgo[--io]);
+
+			io--;
+			while (rchgo[io])
+				io--;
 		}
 
 		/*
-- 
2.8.1

