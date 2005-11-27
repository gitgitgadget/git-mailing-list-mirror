From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: git-mv: fully detect 'directory moved into itself'
Date: Sun, 27 Nov 2005 22:06:42 +0100
Message-ID: <200511272206.43113.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 22:08:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgTjW-0000fg-2l
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 22:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVK0VGq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 16:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVK0VGq
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 16:06:46 -0500
Received: from mail.gmx.de ([213.165.64.20]:27556 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751152AbVK0VGq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 16:06:46 -0500
Received: (qmail invoked by alias); 27 Nov 2005 21:06:44 -0000
Received: from p5496A06C.dip0.t-ipconnect.de (EHLO linux) [84.150.160.108]
  by mail.gmx.net (mp029) with SMTP; 27 Nov 2005 22:06:44 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12822>

This gives a better error message when trying to move a directory
into some subdirectory of itself; ie. no real bug fix: renaming
already failed before, but with a strange "invalid argument".

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---

 git-mv.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 5d83477de7a407ab0ef183c6676114e1a507cf86
29b01f820bf24c4b697765a2a117c880a730b205
diff --git a/git-mv.perl b/git-mv.perl
index ac19876..8d294d6 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -108,7 +108,7 @@ while(scalar @srcArgs > 0) {
 	}
     }
     
-    if (($bad eq "") && ($src eq $dstDir)) {
+    if (($bad eq "") && ($dst =~ /^$src\//)) {
 	$bad = "can not move directory '$src' into itself";
     }
 
---
0.99.9.GIT
