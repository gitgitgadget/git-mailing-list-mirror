From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/25] do_fetch(): reduce scope of peer_item
Date: Sat, 25 May 2013 11:08:15 +0200
Message-ID: <1369472904-12875-17-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATf-0005B0-CD
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552Ab3EYJJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:22 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:58130 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754352Ab3EYJJU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:20 -0400
X-AuditID: 12074411-b7f286d0000008e8-1a-51a07fbf5d55
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 62.22.02280.FBF70A15; Sat, 25 May 2013 05:09:19 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98guq000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:18 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqLu/fkGgQeclDYuuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFncvr2J3YPP4+/4Dk8ell9/ZPG6/ns/s8ax3D6PHxUvKHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ0yfMp+1oJOj4vmqZcwNjDvYuhg5OSQETCS+zz3ABGGLSVy4tx4o
	zsUhJHCZUWLK9J9QzgUmiYWHH4J1sAnoSizqaQbrEBFwlDjx4DorSBGzQC+jxMNH38ESwgL2
	EtdbfrOD2CwCqhLLF21nBbF5BVwlTq96ALVaQeLyrDXMXYwcHJxA8bcnOEHCQgIuEs8/nWOd
	wMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZIoAnuYJxxUu4QowAH
	oxIPr0D5/EAh1sSy4srcQ4ySHExKorz8tQsChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwMqQA
	5XhTEiurUovyYVLSHCxK4rx8S9T9hATSE0tSs1NTC1KLYLIyHBxKErx764AaBYtS01Mr0jJz
	ShDSTBycIIILZAMP0IazIIW8xQWJucWZ6RBFpxgVpcR5b4IkBEASGaV5cANgKeEVozjQP8K8
	C0CqeIDpBK77FdBgJqDBN3PngwwuSURISTUwKu94eOebFduOe/vsd316qvls4RSZSrlDZ6Pn
	pS18bMErc4/TXU7rVmum3yetpSGeeuyx8zI/dzs0LFvQezn2+aVTtg9+OSe/PmBwuGLxhl6/
	1c/tTNZNPXV+TkA/v3FNtcF1mz3V54rEZqWGf2z9yfji4u7qYm/PKY2py2ROGT0q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225498>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f949115..80c6e37 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -694,7 +694,6 @@ static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
 	struct string_list existing_refs = STRING_LIST_INIT_DUP;
-	struct string_list_item *peer_item = NULL;
 	struct ref *ref_map;
 	struct ref *rm;
 	int autotags = (transport->remote->fetch_tags == 1);
@@ -724,8 +723,9 @@ static int do_fetch(struct transport *transport,
 
 	for (rm = ref_map; rm; rm = rm->next) {
 		if (rm->peer_ref) {
-			peer_item = string_list_lookup(&existing_refs,
-						       rm->peer_ref->name);
+			struct string_list_item *peer_item =
+				string_list_lookup(&existing_refs,
+						   rm->peer_ref->name);
 			if (peer_item)
 				hashcpy(rm->peer_ref->old_sha1,
 					peer_item->util);
-- 
1.8.2.3
