From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/6] find_pack_entry(): document last_found_pack
Date: Fri, 21 Feb 2014 17:32:04 +0100
Message-ID: <1393000327-11402-4-git-send-email-mhagger@alum.mit.edu>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Feb 21 17:32:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGt1y-0001GP-AU
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 17:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933029AbaBUQcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 11:32:51 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49650 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932264AbaBUQco (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Feb 2014 11:32:44 -0500
X-AuditID: 1207440f-f79326d000003c9f-0b-53077fabdd14
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 53.3D.15519.BAF77035; Fri, 21 Feb 2014 11:32:43 -0500 (EST)
Received: from michael.fritz.box (p4FDD425E.dip0.t-ipconnect.de [79.221.66.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1LGWAgv026428
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Feb 2014 11:32:42 -0500
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqLu6nj3YYOYEK4uuK91MFg29V5gt
	bq+Yz2wx78ULNosfLT3MDqwef99/YPJ4dqKdzeNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M54PfUHW8Ek7oo56zYwNTDe5uhi5OCQEDCRWLuZpYuRE8gUk7hwbz1bFyMXh5DAZUaJ
	O7ueQDnHmSTmXd4GVsUmoCuxqKeZCcQWEciR2HL1ICOIzSzgILH5cyOYLQxkT520jR3EZhFQ
	lXi7YgpYnFfAReLb9PesENsUJFqW7WIHOYJTwFWiY7kviCkEVPK5q34CI+8CRoZVjHKJOaW5
	urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCHhxL+DsWu9zCFGAQ5GJR5eh1T2YCHWxLLi
	ytxDjJIcTEqivN9rgUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeJujgXK8KYmVValF+TApaQ4W
	JXFe9SXqfkIC6YklqdmpqQWpRTBZGQ4OJQne8jqgRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8
	lNSixNKSjHhQVMQXA+MCJMUDtLcSpJ23uCAxFygK0XqKUVFKnDcJJCEAksgozYMbC0sSrxjF
	gb4U5g0HqeIBJhi47ldAg5mABpdsZAUZXJKIkJJqYEy6UtR/u3H1ew2zjUJd+z9Ps+S8bOV6
	/Nvn7FWvbcyObxLqSkw0LpydtqTXQv2ASNJllwem7o8yP895Wq2rPSOuWbVy/pFbvCXvNLnm
	KTnGvdn569G6dp6KLMG8h8ZlMhPsKs0bvH4z17MUyyctD3Df9ehD7YFzWns8Ai4m 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242471>

Add a comment at the declaration of last_found_pack and where it is
used in find_pack_entry().  In the latter, separate the cases (1) to
make a place for the new comment and (2) to turn the success case into
affirmative logic.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6e8c05d..0910939 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -60,6 +60,12 @@ static struct cached_object empty_tree = {
 	0
 };
 
+/*
+ * A pointer to the last packed_git in which an object was found.
+ * When an object is sought, we look in this packfile first, because
+ * objects that are looked up at similar times are often in the same
+ * packfile as one another.
+ */
 static struct packed_git *last_found_pack;
 
 static struct cached_object *find_cached_object(const unsigned char *sha1)
@@ -2460,11 +2466,13 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 		return 1;
 
 	for (p = packed_git; p; p = p->next) {
-		if (p == last_found_pack || !fill_pack_entry(sha1, e, p))
-			continue;
+		if (p == last_found_pack)
+			continue; /* we already checked this one */
 
-		last_found_pack = p;
-		return 1;
+		if (fill_pack_entry(sha1, e, p)) {
+			last_found_pack = p;
+			return 1;
+		}
 	}
 	return 0;
 }
-- 
1.8.5.3
