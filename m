From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Ignore dirty submodule states in "git pull --rebase"
Date: Tue, 22 Jul 2008 22:41:41 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807222241200.8986@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 22 23:42:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPd4-0001K2-VL
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbYGVVlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbYGVVlm
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:41:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:41269 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751079AbYGVVll (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:41:41 -0400
Received: (qmail invoked by alias); 22 Jul 2008 21:41:39 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp037) with SMTP; 22 Jul 2008 23:41:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18COR4ITo0CISnKb16iPawZcx5xof/c6RmyaVj5Fm
	bXkyNjveLm6K0w
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89545>


This is a companion patch to 6848d58c(Ignore dirty submodule states
during rebase and stash).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-pull.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 6afd4e2..75c3610 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -107,9 +107,9 @@ error_on_no_merge_candidates () {
 }
 
 test true = "$rebase" && {
-	git update-index --refresh &&
-	git diff-files --quiet &&
-	git diff-index --cached --quiet HEAD -- ||
+	git update-index --ignore-submodules --refresh &&
+	git diff-files --ignore-submodules --quiet &&
+	git diff-index --ignore-submodules --cached --quiet HEAD -- ||
 	die "refusing to pull with rebase: your working tree is not up-to-date"
 
 	. git-parse-remote &&
-- 
1.6.0.rc0.22.gf2096d.dirty
