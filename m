From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] git-p4: Fix p4 user cache population on Windows.
Date: Wed, 25 Jul 2007 09:31:38 +0200
Message-ID: <200707250931.41414.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 25 09:29:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDbJD-0000Az-V9
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 09:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764951AbXGYH3U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 03:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764939AbXGYH3T
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 03:29:19 -0400
Received: from verein.lst.de ([213.95.11.210]:51231 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764800AbXGYH3S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 03:29:18 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l6P7TBA5017038
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Wed, 25 Jul 2007 09:29:13 +0200
User-Agent: KMail/1.9.7
Content-Disposition: inline
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53671>

Fall back to USERPROFILE if HOME isn't set.

Signed-off-by: Simon Hausmann <shausman@trolltech.com>
Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 contrib/fast-import/git-p4 |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index e3404ca..1f5a56e 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -901,7 +901,8 @@ class P4Sync(Command):
                            % (labelDetails["label"], change))
 
     def getUserCacheFilename(self):
-        return os.environ["HOME"] + "/.gitp4-usercache.txt"
+        home = os.environ.get("HOME", os.environ.get("USERPROFILE"))
+        return home + "/.gitp4-usercache.txt"
 
     def getUserMapFromPerforceServer(self):
         if self.userMapFromPerforceServer:
-- 
1.5.3.rc0.63.gc956
