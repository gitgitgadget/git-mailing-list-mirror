From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH for 'next'] fast-import: in_merge_bases() has a different
 signature now
Date: Wed, 7 Feb 2007 12:37:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071235370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 12:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEl7L-0003ry-2k
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 12:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbXBGLhg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 06:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbXBGLhg
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 06:37:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:50055 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161216AbXBGLhf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 06:37:35 -0500
Received: (qmail invoked by alias); 07 Feb 2007 11:37:33 -0000
X-Provags-ID: V01U2FsdGVkX1/DV9ZDwHPDc50WvWES9BxP2qwtCa71USlzJLxkAC
	d/dw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38913>


The function in_merge_bases() can take more than one reference now,
and therefore we need to call it differently.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Yes, yes, I know. BAD Dscho. Still not using master. Maybe 
	tomorrow I will find the time to rebase my changes on top of
	next to master. That will be my first experience with git-rebase!

 fast-import.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index c72c5c7..bc95a0d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1302,7 +1302,7 @@ static int update_branch(struct branch *b)
 			return error("Branch %s is missing commits.", b->name);
 		}
 
-		if (!in_merge_bases(old_cmit, new_cmit)) {
+		if (!in_merge_bases(old_cmit, &new_cmit, 1)) {
 			unlock_ref(lock);
 			warn("Not updating %s"
 				" (new tip %s does not contain %s)",
-- 
1.5.0.rc3.2124.g3861-dirty
