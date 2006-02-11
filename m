From: Christian Biesinger <cbiesinger@web.de>
Subject: [PATCH] Use a relative path for SVN importing
Date: Sat, 11 Feb 2006 16:44:11 +0100
Message-ID: <1139672651713-git-send-email-cbiesinger@web.de>
Reply-To: Christian Biesinger <cbiesinger@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Feb 11 16:44:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7wvM-0002d6-UR
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 16:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWBKPof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 10:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWBKPoe
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 10:44:34 -0500
Received: from 85-124-17-142.dynamic.xdsl-line.inode.at ([85.124.17.142]:21475
	"EHLO biesi.no-ip.org") by vger.kernel.org with ESMTP
	id S932327AbWBKPoe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 10:44:34 -0500
Received: from christian (localhost.localdomain [127.0.0.1])
	by biesi.no-ip.org (8.13.4/8.13.4) with SMTP id k1BFiB15008901
	for <git@vger.kernel.org>; Sat, 11 Feb 2006 16:44:11 +0100
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15949>

The absolute path (with the leading slash) breaks SVN importing, because it then
looks for /trunk/... instead of /svn/trunk/... (in my case, the repository URL
was https://servername/svn/)

Signed-off-by: Christian Biesinger <cbiesinger@web.de>

---

 git-svnimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

7718b5a5fec01c0774f6b9cdc84f908e68b403ac
diff --git a/git-svnimport.perl b/git-svnimport.perl
index b6799d8..f17d5a2 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -318,7 +318,7 @@ sub get_file($$$) {
 			die $res->status_line." at $url\n";
 		}
 	} else {
-		$name = $svn->file("/$svnpath",$rev);
+		$name = $svn->file("$svnpath",$rev);
 		return undef unless defined $name;
 	}
 
-- 
1.1.6.g486a-dirty
