From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/25] find_first_merges(): remove unnecessary code
Date: Sat, 25 May 2013 11:08:13 +0200
Message-ID: <1369472904-12875-15-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgAV6-00066M-Sx
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520Ab3EYJKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:10:46 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:58130 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754094Ab3EYJJQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:16 -0400
X-AuditID: 12074411-b7f286d0000008e8-12-51a07fbc595a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id C1.22.02280.CBF70A15; Sat, 25 May 2013 05:09:16 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98guo000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:14 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqLunfkGgwdTDPBZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzvjS9Ia94ABrxZW1M9gaGHezdDFyckgImEjM/L+GDcIWk7hwbz2Q
	zcUhJHCZUeLxvz5WCOcCk8TbvtfsIFVsAroSi3qamUBsEQFHiRMProMVMQv0Mko8fPQdLCEs
	4Cbx5uszsLEsAqoSe99cArN5BVwljq6axwqxTkHi8qw1zF2MHBycQPG3JzhBwkICLhLPP51j
	ncDIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK6SZGSKAJ7mCccVLuEKMA
	B6MSD69A+fxAIdbEsuLK3EOMkhxMSqK8/LULAoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8DKk
	AOV4UxIrq1KL8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8e+uAGgWLUtNTK9Iy
	c0oQ0kwcnCCCC2QDD9CGsyCFvMUFibnFmekQRacYFaXEeW+CJARAEhmleXADYCnhFaM40D/C
	vAtAqniA6QSu+xXQYCagwTdz54MMLklESEk1MKbUPknabK2RpXK3uNdDyerezl+hx7a8/+00
	x8KeWdf3tMGdnL7Pxq0ynxk2Xaphe/RQoaORy0P+2QFfvpbM9pQVAVmF01nEnr00vxIyQc4+
	fXZt661NtSz+rTz8TEzuy8Simnyz4v7sd7d6G3TvnpdMjXlPw+xmx5U8fbnPt0ol 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225514>

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
