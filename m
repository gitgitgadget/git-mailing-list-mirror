From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 4/6] cache_tree_find(): remove redundant check
Date: Wed,  5 Mar 2014 18:26:28 +0100
Message-ID: <1394040390-7954-5-git-send-email-mhagger@alum.mit.edu>
References: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 18:27:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLFaq-0007UZ-1w
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 18:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbaCER0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 12:26:48 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54521 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754079AbaCER0q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2014 12:26:46 -0500
X-AuditID: 12074413-f79076d000002d17-40-53175e55a15b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 8F.20.11543.55E57135; Wed,  5 Mar 2014 12:26:45 -0500 (EST)
Received: from michael.fritz.box (p57A24002.dip0.t-ipconnect.de [87.162.64.2])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s25HQY7D022625
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 5 Mar 2014 12:26:43 -0500
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394040390-7954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqBsaJx5scOsVi8XsG9vYLLqudDNZ
	NPReYba4vWI+swOLx9/3H5g82qaZeVy8pOzxeZNcAEsUt01SYklZcGZ6nr5dAnfGm513mQqe
	sVTs6T/J3MD4kLmLkZNDQsBE4taBE2wQtpjEhXvrgWwuDiGBy4wSp9unMEE4R5kkXs6bwApS
	xSagK7Gop5kJxBYRUJOY2HaIBcRmFkiTeLDlCpgtLOAo0fzvAdgGFgFViadPOhlBbF4BZ4mn
	P38zQWyTk5jyewE7iM0p4CLRuLQDKM4BtMxZYtF+5gmMvAsYGVYxyiXmlObq5iZm5hSnJusW
	Jyfm5aUW6Zrr5WaW6KWmlG5ihASP8A7GXSflDjEKcDAq8fByBooHC7EmlhVX5h5ilORgUhLl
	vRoNFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCGxAJlONNSaysSi3Kh0lJc7AoifOqLVH3ExJI
	TyxJzU5NLUgtgsnKcHAoSfDmxQA1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIMi
	I74YGBsgKR6gvSog7bzFBYm5QFGI1lOMilLivIdAjhUASWSU5sGNhaWEV4ziQF8K82aDtPMA
	0wlc9yugwUxAg6P5wAaXJCKkpBoYq+L/CRgY71Odu25CygUlt+y5TMIGa4Wf/5eu4k8r53k/
	PZ/pg/ptlwmZOVOYr8g4WbguiVgnHWYj8nLS6x28FyZ92bjNUX/3bqV6Ds6GmUz1rYmLzO6/
	bFd45WzmZHpTK1+RK8Fr5j+ppTyOd0qXC9+oWhAUphbZ1750kdhmswly9xNaTRYr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243449>

If *slash == '/', then it is necessarily non-NUL.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 408ee57..39ad8c9 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -563,7 +563,7 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 		if (!sub)
 			return NULL;
 		it = sub->cache_tree;
-		while (*slash && *slash == '/')
+		while (*slash == '/')
 			slash++;
 		if (!*slash)
 			return it; /* prefix ended with slashes */
-- 
1.9.0
