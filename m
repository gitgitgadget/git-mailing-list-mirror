From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/21] cmd_merge(): remove unneeded flag variable
Date: Wed, 23 Mar 2016 11:04:34 +0100
Message-ID: <d9541a71ee169e9214238f839fdb9ec0263a8fb6.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:06:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiffM-0002rw-B7
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbcCWKFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:05:22 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49356 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754616AbcCWKFT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:05:19 -0400
X-AuditID: 1207440f-d9fff70000007e44-12-56f26a59b7f9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E7.C5.32324.95A62F65; Wed, 23 Mar 2016 06:05:13 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1M018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:05:12 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqBuV9SnMYO9DSYuuK91MFg29V5gt
	bq+Yz2zRPeUto8WPlh5mi5lXrR3YPP6+/8DksXPWXXaPZ717GD0uXlL22L90G5vH501yAWxR
	3DZJiSVlwZnpefp2CdwZ/2Y9ZSvYyVkx80xFA+Nl9i5GTg4JAROJTx8ambsYuTiEBLYySuzZ
	fZINwjnJJLH/ThMLSBWbgK7Eop5mJhBbREBNYmLbIRaQImaBBYwSGxcvBmrn4BAWcJSYNlsD
	pIZFQFWi8/g/RhCbVyBK4tq5jcwQ25QkNjy4ADaHU8BC4uTJpWA1QgLmEtsfrGWawMizgJFh
	FaNcYk5prm5uYmZOcWqybnFyYl5eapGuiV5uZoleakrpJkZIMPHvYOxaL3OIUYCDUYmHt/Dc
	xzAh1sSy4srcQ4ySHExKorzngz6FCfEl5adUZiQWZ8QXleakFh9ilOBgVhLhPZYJlONNSays
	Si3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfC+AWkULEpNT61Iy8wpQUgzcXCC
	DOeSEilOzUtJLUosLcmIB0VAfDEwBkBSPEB7D4HtLS5IzAWKQrSeYlSUEuf1BkkIgCQySvPg
	xsJSxCtGcaAvhXl3ZABV8QDTC1z3K6DBTECDF/qADS5JREhJNTBOOVK/evGNm063n7sydzvH
	befbXiaRl73wJe8M3ys7TLNN+pk/uNgc59cTiFp1lrXyY4l34ROOWuZuq2cSd4Ka1q2skf4T
	8KlJPaLXcEenUt9DRrZN+esN2svllZ8mfns61eRexKrwl4d1njbufyZcM/XR53Sd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289612>

It is never read, so we can pass NULL to resolve_ref_unsafe().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index df0afa0..a91ae5b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1146,7 +1146,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	unsigned char head_sha1[20];
 	struct commit *head_commit;
 	struct strbuf buf = STRBUF_INIT;
-	int flag, i, ret = 0, head_subsumed;
+	int i, ret = 0, head_subsumed;
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
@@ -1160,7 +1160,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch = branch_to_free = resolve_refdup("HEAD", 0, head_sha1, &flag);
+	branch = branch_to_free = resolve_refdup("HEAD", 0, head_sha1, NULL);
 	if (branch && starts_with(branch, "refs/heads/"))
 		branch += 11;
 	if (!branch || is_null_sha1(head_sha1))
-- 
2.8.0.rc3
