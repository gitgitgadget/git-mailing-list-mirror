From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/33] refs: document the fields of struct ref_value
Date: Sun, 14 Apr 2013 14:54:17 +0200
Message-ID: <1365944088-10588-3-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:55:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMSy-000411-U4
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861Ab3DNMzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:22 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:52896 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751824Ab3DNMzT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:19 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-4e-516aa737223f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 25.D8.02380.737AA615; Sun, 14 Apr 2013 08:55:19 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAjx007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:17 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqGu+PCvQ4Gsbi0XXlW4mi4beK8wW
	Kx/fZba4vWI+s8WPlh5mB1aPv+8/MHm0v3/H7PGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGf82HqFseAQW8XStjtMDYx/WboYOTkkBEwktpxpgbLFJC7cW88GYgsJXGaU2HnFpIuR
	C8g+yyTx9+EXRpAEm4CuxKKeZqYuRg4OEYFsid1r5UHCzAIOEps/N4KVCAu4SHRvuQw2h0VA
	VeLjvDVgcV6g+NqzR5ghdilIHN++DSzOKeAqMf35MXaIvS4SszbPZp3AyLuAkWEVo1xiTmmu
	bm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkhA8e1gbF8vc4hRgINRiYf3BWNWoBBrYllx
	Ze4hRkkOJiVR3pPLgEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeB1bgXK8KYmVValF+TApaQ4W
	JXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQneaSBDBYtS01Mr0jJzShDSTBycIIILZAMP0IZ5
	IIW8xQWJucWZ6RBFpxgVpcR5U0ASAiCJjNI8uAGw2H/FKA70jzDEHh5g2oDrfgU0mAlosM/e
	dJDBJYkIKakGRr8vi3pvzGp/+zti/5xrDOHdnx6E33pyNqFpJW/A96xnOZJCci+vXHBusPVj
	3CYvuu+zUYyTk4rTDOb/S1wO2e19aNq614Y5Oixl0dbvl7O/5ETv2xnkzDfHs+B0Xq645a65
	H564vcoPrdfkervhwNKjZf/U5aUc7B8+0t6y/ZTVJMPDG7dJuyixFGckGmoxFxUn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221101>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/refs.c b/refs.c
index 30b4bf7..1df1ccd 100644
--- a/refs.c
+++ b/refs.c
@@ -109,7 +109,19 @@ struct ref_entry;
  * (ref_entry->flag & REF_DIR) is zero.
  */
 struct ref_value {
+	/*
+	 * The name of the object to which this reference resolves
+	 * (which may be a tag object).  If REF_ISBROKEN, this is
+	 * null.  If REF_ISSYMREF, then this is the name of the object
+	 * referred to by the last reference in the symlink chain.
+	 */
 	unsigned char sha1[20];
+
+	/*
+	 * If REF_KNOWS_PEELED, then this field holds the peeled value
+	 * of this reference, or null if the reference is known not to
+	 * be peelable.
+	 */
 	unsigned char peeled[20];
 };
 
-- 
1.8.2.1
