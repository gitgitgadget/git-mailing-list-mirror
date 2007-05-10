From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t5000: skip ZIP tets when unzip is absent
Date: Thu, 10 May 2007 12:47:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705101246430.4167@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 12:47:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm6Ay-0002HH-MZ
	for gcvg-git@gmane.org; Thu, 10 May 2007 12:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959AbXEJKrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 06:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758391AbXEJKrJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 06:47:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:45863 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757959AbXEJKrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 06:47:07 -0400
Received: (qmail invoked by alias); 10 May 2007 10:47:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 10 May 2007 12:47:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gOmot3LigLqQsn56qBUNp4Rpa2lrTQqichiLT/F
	KtUpFNWZj9cpCm
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46854>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 t/t5000-tar-tree.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index e223c07..1580592 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -108,6 +108,13 @@ test_expect_success \
     'git-archive --format=zip' \
     'git-archive --format=zip HEAD >d.zip'
 
+unzip -v 2>/dev/null
+if [ $? -ne 10 ]; then
+	echo "Skipping ZIP tests, because unzip was not found"
+	test_done
+	exit
+fi
+
 test_expect_success \
     'extract ZIP archive' \
     '(mkdir d && cd d && $UNZIP ../d.zip)'
