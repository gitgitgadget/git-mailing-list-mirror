From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cg-seek should not complain if run twice
Date: Mon, 19 Dec 2005 23:55:36 -0500
Message-ID: <1135054536.3815.14.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 20 05:57:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoZXh-0001C7-KT
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 05:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVLTEz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 23:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLTEz7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 23:55:59 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:23495 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750791AbVLTEz6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 23:55:58 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EoZVi-0004v2-8r
	for git@vger.kernel.org; Mon, 19 Dec 2005 23:54:03 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EoZXE-0002cn-Ec; Mon, 19 Dec 2005 23:55:36 -0500
To: Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13845>

cg-seek complains if run without arguments in a non-seeked repository:

rm: cannot remove `.git/refs/heads/cg-seek-point': No such file or directory
rm: cannot remove `.git/head-name': No such file or directory

In fact, it's OK for those files not to exist, so they should be removed
silently.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-seek b/cg-seek
index 942267f..8356593 100755
--- a/cg-seek
+++ b/cg-seek
@@ -60,7 +60,7 @@ if [ "$seek_mode" = "away" ]; then
 	git-symbolic-ref HEAD "refs/heads/cg-seek-point"
 else
 	git-symbolic-ref HEAD "refs/heads/$_git_head"
-	rm "$_git/refs/heads/cg-seek-point" "$_git/head-name"
+	rm -f "$_git/refs/heads/cg-seek-point" "$_git/head-name"
 	rm -f "$_git/blocked"
 fi
 


-- 
Regards,
Pavel Roskin
