From: andy@petdance.com
Subject: [PATCH 1/2] Localizing temporary variables
Date: Wed, 22 Apr 2009 01:00:36 -0500
Message-ID: <1240380037-24785-1-git-send-email-andy@petdance.com>
Cc: gitster@pobox.com, Andy Lester <andy@petdance.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 08:30:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwVyY-0000GY-G0
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 08:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbZDVG25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 02:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbZDVG2z
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 02:28:55 -0400
Received: from uniqua.petdance.com ([64.81.227.163]:51498 "EHLO
	uniqua.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZDVG2y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 02:28:54 -0400
Received: by uniqua.petdance.com (Postfix, from userid 500)
	id D954C5CD0112; Wed, 22 Apr 2009 01:00:37 -0500 (CDT)
X-Mailer: git-send-email 1.6.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117176>

From: Andy Lester <andy@petdance.com>

---
 builtin-show-ref.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index dc76c50..3dc8fe2 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -22,8 +22,6 @@ static void show_one(const char *refname, const unsigned char *sha1)
 
 static int show_ref(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
 {
-	struct object *obj;
-	const char *hex;
 	unsigned char peeled[20];
 
 	if (tags_only || heads_only) {
@@ -75,16 +73,19 @@ match:
 
 	if ((flag & REF_ISPACKED) && !peel_ref(refname, peeled)) {
 		if (!is_null_sha1(peeled)) {
+			const char *hex;
 			hex = find_unique_abbrev(peeled, abbrev);
 			printf("%s %s^{}\n", hex, refname);
 		}
 	}
 	else {
+		struct object *obj;
 		obj = parse_object(sha1);
 		if (!obj)
 			die("git show-ref: bad ref %s (%s)", refname,
 			    sha1_to_hex(sha1));
 		if (obj->type == OBJ_TAG) {
+			const char *hex;
 			obj = deref_tag(obj, refname, 0);
 			if (!obj)
 				die("git show-ref: bad tag at ref %s (%s)", refname,
-- 
1.6.2.4
