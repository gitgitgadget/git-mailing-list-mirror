From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/19] remove_branches(): remove temporary
Date: Mon, 22 Jun 2015 16:02:53 +0200
Message-ID: <0c78010d9f06e2bfc8136c1ac11d5bc107a7043a.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:04:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72Kr-0005yL-MX
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933737AbbFVOE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:04:27 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42854 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751252AbbFVODS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:18 -0400
X-AuditID: 1207440e-f79516d0000012b3-bf-558815a60903
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9C.96.04787.6A518855; Mon, 22 Jun 2015 10:03:18 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3Cc0030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:17 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixO6iqLtMtCPU4M1XFouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ/xY+o6pYDVrxY2uO+wNjOtYuhg5OSQETCT6dxxhg7DFJC7cWw9kc3EICVxmlNi5dx0T
	hHOSSWLpvTZWkCo2AV2JRT3NTCC2iICaxMS2QywgRcwCHYwSF5ZvYwdJCAvYSvSvOQpWxCKg
	KtF44ABYnFcgSuL4sYesEOvkJM4f/8kMYnMKWEjM3/cfrEZIwFxi4sxHLBMYeRcwMqxilEvM
	Kc3VzU3MzClOTdYtTk7My0st0jXWy80s0UtNKd3ECAkqvh2M7etlDjEKcDAq8fDOsG8PFWJN
	LCuuzD3EKMnBpCTKe+A1UIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb8tZoBxvSmJlVWpRPkxK
	moNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYLXT6QjVEiwKDU9tSItM6cEIc3EwQkynEtK
	pDg1LyW1KLG0JCMeFB3xxcD4AEnxAO01AWnnLS5IzAWKQrSeYtTlWPDj9lomIZa8/LxUKXFe
	f5AiAZCijNI8uBWwFPKKURzoY2FeVWBCEeIBph+4Sa+AljABLfmS2waypCQRISXVwFh0R+Nc
	0bagsG57/blPVRs/cPH3LtBYWODKo7nrEY+W+LUoppseK2ozJbw+n2Gavv/n5q+t92fVzpm1
	ctnKBdz97xiuOC1rvxaR0nvjw657UjZXdROnzngW3Lb9JJulVM/Xy5+3TmhuzvMq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272361>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f4a6ec9..53b8e13 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -756,8 +756,7 @@ static int remove_branches(struct string_list *branches)
 	strbuf_release(&err);
 
 	for (i = 0; i < branches->nr; i++) {
-		struct string_list_item *item = branches->items + i;
-		const char *refname = item->string;
+		const char *refname = branches->items[i].string;
 
 		if (delete_ref(refname, NULL, 0))
 			result |= error(_("Could not remove branch %s"), refname);
-- 
2.1.4
