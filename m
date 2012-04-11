From: marcnarc@xiplink.com
Subject: [PATCH] fetch: Only call a new ref a "branch" if it's under refs/heads/.
Date: Wed, 11 Apr 2012 10:29:29 -0400
Message-ID: <1334154569-26124-1-git-send-email-marcnarc@xiplink.com>
Cc: Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 16:34:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHycv-0005Po-D3
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 16:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760276Ab2DKOeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 10:34:23 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:50652 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754622Ab2DKOeW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 10:34:22 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Apr 2012 10:34:22 EDT
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id q3BET67v024638;
	Wed, 11 Apr 2012 10:29:06 -0400
X-Mailer: git-send-email 1.7.10.1.g8d64dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195187>

From: Marc Branchaud <marcnarc@xiplink.com>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

This has been a minor irritant in my life for a while now...  :)

 builtin/fetch.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 65f5f9b..57be58a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -298,8 +298,13 @@ static int update_local_ref(struct ref *ref,
 			what = _("[new tag]");
 		}
 		else {
-			msg = "storing head";
-			what = _("[new branch]");
+			if (!prefixcmp(ref->name, "refs/heads/")) {
+				msg = "storing head";
+				what = _("[new branch]");
+			} else {
+				msg = "storing ref";
+				what = _("[new ref]");
+			}
 			if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 			    (recurse_submodules != RECURSE_SUBMODULES_ON))
 				check_for_new_submodule_commits(ref->new_sha1);
-- 
1.7.10.1.g2bbc8
