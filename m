From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/17] find_first_merges(): remove unnecessary code
Date: Sun, 19 May 2013 22:27:10 +0200
Message-ID: <1368995232-11042-16-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADZ-0004ax-9l
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839Ab3ESU2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:21 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:63560 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754787Ab3ESU2T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:19 -0400
X-AuditID: 12074414-b7fb86d000000905-5d-519935e3629b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 15.59.02309.3E539915; Sun, 19 May 2013 16:28:19 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5Y026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:17 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqPvYdGagQftHNouuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MDqwef99/YPK49PI7m8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3xpekNe8EB1oora2ewNTDuZuli5OSQEDCROHnvICuELSZx4d56ti5GLg4hgcuMEr0f
	djNBOOeZJC7unsAOUsUmoCuxqKeZCcQWEZCV+H54IyOIzSwwgVFiaX8hiC0s4CxxZP0WsDiL
	gKrEi1WH2EBsXgFXiWlLNkBtU5C4PGsNM4jNCRTf0r4LLC4k4CLxr/826wRG3gWMDKsY5RJz
	SnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQoJKZAfjkZNyhxgFOBiVeHgbPkwPFGJN
	LCuuzD3EKMnBpCTKu1x1ZqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd49QkA53pTEyqrUonyY
	lDQHi5I477fF6n5CAumJJanZqakFqUUwWRkODiUJXncToEbBotT01Iq0zJwShDQTByeI4ALZ
	wAO0YRFIIW9xQWJucWY6RNEpRkUpcd6LIAkBkERGaR7cAFj8v2IUB/pHmPcISBUPMHXAdb8C
	GswENJj12lSQwSWJCCmpBkbZ1BNV0uddfDek1V+O9YgRjtc/x6aSOOWrQujLe21Verxm3Hra
	X7Y+LFwSv7Bwi1/l6hUtHk8nJyluOX4ssfbJhPvT8wv97lRk3nrY86qzMuXVxM+il+fJpuvX
	Hti3NVppvt2KW5/cTbreHz7DkeWddNa8bn2gzKclfzNe+Jte45+QI7/ytr4SS3FG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224915>

No names are ever set for the object_array_entries in merges, so there
is no need to pretend to copy them to the result array.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 submodule.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index b837c04..ad476ce 100644
--- a/submodule.c
+++ b/submodule.c
@@ -893,8 +893,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 		}
 
 		if (!contains_another)
-			add_object_array(merges.objects[i].item,
-					 merges.objects[i].name, result);
+			add_object_array(merges.objects[i].item, NULL, result);
 	}
 
 	free(merges.objects);
-- 
1.8.2.3
