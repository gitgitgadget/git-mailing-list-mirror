From: Johan Herland <johan@herland.net>
Subject: [PATCH 10/15] git-note: (Transfer) Teach git-clone how to clone notes
Date: Sun, 27 May 2007 16:15:01 +0200
Message-ID: <200705271615.01210.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:15:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJWc-0007Nx-Fd
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbXE0OPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbXE0OPJ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:15:09 -0400
Received: from smtp.getmail.no ([84.208.20.33]:51215 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340AbXE0OPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:15:07 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP0000DE94EA00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:15:04 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP0003SE917J00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:15:01 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP00093E91J760@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:15:01 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48550>

This patch causes git notes to be cloned in the same way that tags are
cloned.

Signed-off-by: Johan Herland <johan@herland.net>
---
 git-clone.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index fdd354f..6bb2fd5 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -57,7 +57,7 @@ Perhaps git-update-server-info needs to be run there?"
 		*^*)	continue;;
 		esac
 		case "$bare,$name" in
-		yes,* | ,heads/* | ,tags/*) ;;
+		yes,* | ,heads/* | ,tags/* | ,notes/*) ;;
 		*)	continue ;;
 		esac
 		if test -n "$use_separate_remote" &&
@@ -320,6 +320,7 @@ then
 		branch_top="heads"
 	fi
 	tag_top="tags"
+	note_top="notes"
 	while read sha1 name
 	do
 		case "$name" in
@@ -331,6 +332,8 @@ then
 			destname="refs/$branch_top/${name#refs/heads/}" ;;
 		refs/tags/*)
 			destname="refs/$tag_top/${name#refs/tags/}" ;;
+		refs/notes/*)
+			destname="refs/$note_top/${name#refs/notes/}" ;;
 		*)
 			continue ;;
 		esac
-- 
1.5.2.101.gee49f
