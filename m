From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: fix a harmless warning on rebuild (with old repos)
Date: Thu, 9 Mar 2006 03:52:48 -0800
Message-ID: <20060309115248.GC11934@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 09 12:53:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHJi8-0002Ld-JH
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 12:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbWCILxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 06:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWCILxi
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 06:53:38 -0500
Received: from hand.yhbt.net ([66.150.188.102]:6082 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751849AbWCILxh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 06:53:37 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 62D3C7DC005;
	Thu,  9 Mar 2006 03:53:36 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu,  9 Mar 2006 03:52:48 -0800
To: Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17412>

It's only for repositories that were imported with very early
versions of git-svn.  Unfortunately, some of those repos are out
in the wild already, so fix this warning.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

3c3753ad761d1802cc79418ae337ee4a3110a109
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 43b50ec..cf233ef 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -155,7 +155,7 @@ sub rebuild {
 		# if we merged or otherwise started elsewhere, this is
 		# how we break out of it
 		next if (defined $SVN_UUID && ($uuid ne $SVN_UUID));
-		next if (defined $SVN_URL && ($url ne $SVN_URL));
+		next if (defined $SVN_URL && defined $url && ($url ne $SVN_URL));
 
 		print "r$rev = $c\n";
 		unless (defined $latest) {
-- 
1.2.4.ga2910
