From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] gitk: UTF-8 support
Date: Tue, 22 Nov 2005 23:15:01 -0500
Message-ID: <1132719301.12227.5.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 23 05:15:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eem2K-000796-Ns
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 05:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVKWEPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 23:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVKWEPH
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 23:15:07 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:28583 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932509AbVKWEPG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 23:15:06 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Eem2D-0001NR-3q
	for git@vger.kernel.org; Tue, 22 Nov 2005 23:15:05 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Eem29-0003Hp-AA; Tue, 22 Nov 2005 23:15:01 -0500
To: git <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12602>

Add gitencoding variable and set it to "utf-8".  Use it for converting
git-rev-list output.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/gitk b/gitk
index 3dd97e2..e53b609 100755
--- a/gitk
+++ b/gitk
@@ -19,7 +19,7 @@ proc gitdir {} {
 proc getcommits {rargs} {
     global commits commfd phase canv mainfont env
     global startmsecs nextupdate ncmupdate
-    global ctext maincursor textcursor leftover
+    global ctext maincursor textcursor leftover gitencoding
 
     # check that we can find a .git directory somewhere...
     set gitdir [gitdir]
@@ -49,7 +49,7 @@ proc getcommits {rargs} {
 	exit 1
     }
     set leftover {}
-    fconfigure $commfd -blocking 0 -translation lf
+    fconfigure $commfd -blocking 0 -translation lf -encoding $gitencoding
     fileevent $commfd readable [list getcommitlines $commfd]
     $canv delete all
     $canv create text 3 3 -anchor nw -text "Reading commits..." \
@@ -3657,6 +3657,7 @@ set datemode 0
 set boldnames 0
 set diffopts "-U 5 -p"
 set wrcomcmd "git-diff-tree --stdin -p --pretty"
+set gitencoding "utf-8"
 
 set mainfont {Helvetica 9}
 set textfont {Courier 9}


-- 
Regards,
Pavel Roskin
