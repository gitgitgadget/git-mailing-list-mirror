From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] git-svn: always initialize with core.autocrlf=false
Date: Thu, 9 Apr 2009 13:29:57 +0200 (CEST)
Message-ID: <560e98ae1d5350c6ff8db56d41089900dbaab08a.1239276588u.git.johannes.schindelin@gmx.de>
References: <cover.1239276588u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 09 13:29:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrsRI-00059b-Cb
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 13:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757517AbZDIL1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 07:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756679AbZDIL1X
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 07:27:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:54196 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756352AbZDIL1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 07:27:22 -0400
Received: (qmail invoked by alias); 09 Apr 2009 11:27:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 09 Apr 2009 13:27:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ck+A+VwpcB/MVIjIy9ogt0na0ha3UXTFXEN5+zl
	3vVGsMk5U4GDg9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1239276588u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116163>

It has been reported time and time again in relation to msysGit that
git-svn does not work well when core.autocrlf has any value other than
'false'.  So let's make it so by default.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 8be6be0..d4e8fc8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -325,6 +325,7 @@ sub do_git_init_db {
 		command_noisy(@init_db);
 		$_repository = Git->repository(Repository => ".git");
 	}
+	command_noisy('config', 'core.autocrlf', 'false');
 	my $set;
 	my $pfx = "svn-remote.$Git::SVN::default_repo_id";
 	foreach my $i (keys %icv) {
-- 
1.6.2.1.613.g25746
