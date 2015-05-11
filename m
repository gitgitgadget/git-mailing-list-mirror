From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/18] is_refname_available(): revamp the comments
Date: Mon, 11 May 2015 17:25:04 +0200
Message-ID: <1431357920-25090-3-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:25:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrpaL-0002PD-QU
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbbEKPZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:25:32 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48224 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138AbbEKPZb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:31 -0400
X-AuditID: 12074412-f79e46d0000036b4-1d-5550c9eba9a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 99.B7.14004.BE9C0555; Mon, 11 May 2015 11:25:31 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnE002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:30 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqPv6ZECoQfs7fouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd8alX3dZC84qVfzt/crYwPhYsouRk0NCwERi5vxWRghbTOLCvfVsXYxc
	HEIClxkl7j14yQ7hHGeSWLPgOzNIFZuArsSinmYmEFtEQE1iYtshFpAiZoFdQB1Lp7KAJIQF
	XCUuXr8FZrMIqEr0974FW8Er4CLRva6JGWKdnMT54z/BbE6g+qVXL4PVCwHVND2+xzKBkXcB
	I8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJAwE9rBuP6k3CFGAQ5GJR5e
	gwv+oUKsiWXFlbmHGCU5mJREeX/tDQgV4kvKT6nMSCzOiC8qzUktPsQowcGsJMKrvAYox5uS
	WFmVWpQPk5LmYFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkwdt4AqhRsCg1PbUiLTOnBCHN
	xMEJMpxLSqQ4NS8ltSixtCQjHhQd8cXA+ABJ8QDtrQJp5y0uSMwFikK0nmJUlBLnTQFJCIAk
	Mkrz4MbCkscrRnGgL4V514NU8QATD1z3K6DBTECDHePABpckIqSkGhiLt29ja+uf2bDoVWmp
	anlpn/ir6E8iVzabV+nlGkxtmrxCadst812LausL5n9ZzeBd/kAkZEbrhmOSMm8ybrM2n3WJ
	z/h3PW8t67W6m9sNPotGPeb8teJCjoyKw9y7u4vetJomPDG+H7FXqv1RyNakX7Oy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268777>

Change the comments to a running example of running the function with
refname set to "refs/foo/bar". Add some more explanation of the logic.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 69 +++++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index 47e4e53..776bbce 100644
--- a/refs.c
+++ b/refs.c
@@ -876,9 +876,9 @@ static void report_refname_conflict(struct ref_entry *entry,
  * operation).
  *
  * Two reference names conflict if one of them exactly matches the
- * leading components of the other; e.g., "foo/bar" conflicts with
- * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
- * "foo/barbados".
+ * leading components of the other; e.g., "refs/foo/bar" conflicts
+ * with both "refs/foo" and with "refs/foo/bar/baz" but not with
+ * "refs/foo/bar" or "refs/foo/barbados".
  *
  * skip must be sorted.
  */
@@ -891,19 +891,39 @@ static int is_refname_available(const char *refname,
 	int pos;
 	char *dirname;
 
+	/*
+	 * For the sake of comments in this function, suppose that
+	 * refname is "refs/foo/bar".
+	 */
+
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
 		/*
-		 * We are still at a leading dir of the refname; we are
-		 * looking for a conflict with a leaf entry.
-		 *
-		 * If we find one, we still must make sure it is
-		 * not in "skip".
+		 * We are still at a leading dir of the refname (e.g.,
+		 * "refs/foo"; if there is a reference with that name,
+		 * it is a conflict, *unless* it is in skip.
 		 */
 		pos = search_ref_dir(dir, refname, slash - refname);
 		if (pos >= 0) {
+			/*
+			 * We found a reference whose name is a proper
+			 * prefix of refname; e.g., "refs/foo".
+			 */
 			struct ref_entry *entry = dir->entries[pos];
-			if (entry_matches(entry, skip))
+			if (entry_matches(entry, skip)) {
+				/*
+				 * The reference we just found, e.g.,
+				 * "refs/foo", is also in skip, so it
+				 * is not considered a conflict.
+				 * Moreover, the fact that "refs/foo"
+				 * exists means that there cannot be
+				 * any references anywhere under the
+				 * "refs/foo/" namespace (because they
+				 * would have conflicted with
+				 * "refs/foo"). So we can stop looking
+				 * now and return true.
+				 */
 				return 1;
+			}
 			report_refname_conflict(entry, refname);
 			return 0;
 		}
@@ -911,19 +931,29 @@ static int is_refname_available(const char *refname,
 
 		/*
 		 * Otherwise, we can try to continue our search with
-		 * the next component; if we come up empty, we know
-		 * there is nothing under this whole prefix.
+		 * the next component. So try to look up the
+		 * directory, e.g., "refs/foo/".
 		 */
 		pos = search_ref_dir(dir, refname, slash + 1 - refname);
-		if (pos < 0)
+		if (pos < 0) {
+			/*
+			 * There was no directory "refs/foo/", so
+			 * there is nothing under this whole prefix,
+			 * and we are OK.
+			 */
 			return 1;
+		}
 
 		dir = get_ref_dir(dir->entries[pos]);
 	}
 
 	/*
-	 * We are at the leaf of our refname; we want to
-	 * make sure there are no directories which match it.
+	 * We are at the leaf of our refname (e.g., "refs/foo/bar").
+	 * There is no point in searching for a reference with that
+	 * name, because a refname isn't considered to conflict with
+	 * itself. But we still need to check for references whose
+	 * names are in the "refs/foo/bar/" namespace, because they
+	 * *do* conflict.
 	 */
 	len = strlen(refname);
 	dirname = xmallocz(len + 1);
@@ -933,9 +963,9 @@ static int is_refname_available(const char *refname,
 
 	if (pos >= 0) {
 		/*
-		 * We found a directory named "refname". It is a
-		 * problem iff it contains any ref that is not
-		 * in "skip".
+		 * We found a directory named "$refname/" (e.g.,
+		 * "refs/foo/bar/"). It is a problem iff it contains
+		 * any ref that is not in "skip".
 		 */
 		struct ref_entry *entry = dir->entries[pos];
 		struct ref_dir *dir = get_ref_dir(entry);
@@ -950,11 +980,6 @@ static int is_refname_available(const char *refname,
 		return 0;
 	}
 
-	/*
-	 * There is no point in searching for another leaf
-	 * node which matches it; such an entry would be the
-	 * ref we are looking for, not a conflict.
-	 */
 	return 1;
 }
 
-- 
2.1.4
