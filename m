From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC] revision walker: introduce shortcut -g for --walk-reflogs
Date: Wed, 24 Jan 2007 15:05:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241505050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jan 24 15:05:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9ikh-0001nb-Kg
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 15:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXAXOFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 09:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbXAXOFT
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 09:05:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:33784 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751482AbXAXOFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 09:05:18 -0500
Received: (qmail invoked by alias); 24 Jan 2007 14:05:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 24 Jan 2007 15:05:17 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37639>


Since reflogs are such a useful thing, I need a short way to tell
git-log to show me the history according to the reflogs.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Documentation/git-rev-list.txt |    2 +-
 revision.c                     |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index beb0906..4f145ea 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -192,7 +192,7 @@ limiting may be applied.
 	In addition to the '<commit>' listed on the command
 	line, read them from the standard input.
 
---walk-reflogs::
+-g, --walk-reflogs::
 
 	Instead of walking the commit ancestry chain, walk
 	reflog entries from the most recent one to older ones.
diff --git a/revision.c b/revision.c
index 6726f73..42ba310 100644
--- a/revision.c
+++ b/revision.c
@@ -868,7 +868,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_reflog(revs, flags);
 				continue;
 			}
-			if (!strcmp(arg, "--walk-reflogs")) {
+			if (!strcmp(arg, "-g") ||
+					!strcmp(arg, "--walk-reflogs")) {
 				init_reflog_walk(&revs->reflog_info);
 				continue;
 			}
-- 
1.5.0.rc2.g8b13f-dirty
