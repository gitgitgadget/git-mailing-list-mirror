From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] bisect view: call gitk if Cygwin's SESSIONNAME variable is
 set
Date: Fri, 2 Jan 2009 19:08:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021304280.27818@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 02 19:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIoS7-0002Vo-MK
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758810AbZABSHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758752AbZABSHf
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:07:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:48554 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759278AbZABSHe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:07:34 -0500
Received: (qmail invoked by alias); 02 Jan 2009 18:07:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 02 Jan 2009 19:07:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZSUAIXv8ZOa/Yf5Dm/drp0+jVdhdTtWc5EXCDZz
	foV/8/4W+aZdJT
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104392>


It seems that Cygwin sets the variable SESSIONNAME when an interactive
desktop session is running, and does not set it when you log in via ssh.

So we can use this variable to determine whether to run gitk or git log
in git bisect view.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 17a35f6..85db4ba 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -508,7 +508,7 @@ bisect_visualize() {
 
 	if test $# = 0
 	then
-		case "${DISPLAY+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" in
+		case "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" in
 		'')	set git log ;;
 		set*)	set gitk ;;
 		esac
-- 
1.6.1.rc3.224.g95ac9
