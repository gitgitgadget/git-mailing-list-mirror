From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/7] gitweb: Remove workaround for git-diff bug fixed in f82cd3c
Date: Sat, 26 Aug 2006 19:14:21 +0200
Message-ID: <11566124672654-git-send-email-jnareb@gmail.com>
References: <1156612392716-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 26 19:14:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH1jx-0003zu-JY
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 19:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWHZROc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 13:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWHZROc
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 13:14:32 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:31878 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S964801AbWHZROb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 13:14:31 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7QHDFoM004442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Aug 2006 19:13:15 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7QHERNY032729;
	Sat, 26 Aug 2006 19:14:27 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7QHERZW032728;
	Sat, 26 Aug 2006 19:14:27 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1156612392716-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26056>

Remove workaround in git_blobdiff for error in git-diff (showing
reversed diff for diff of blobs), corrected in commit
 f82cd3c  Fix "git diff blob1 blob2" showing the diff in reverse.
which is post 1.4.2-rc2 commit.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index abd0f0d..df2f9e5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2841,8 +2841,7 @@ sub git_blobdiff {
 		}
 
 		# open patch output
-		#open $fd, "-|", $GIT, "diff", '-p', $hash_parent, $hash
-		open $fd, "-|", $GIT, "diff", '-p', $hash, $hash_parent
+		open $fd, "-|", $GIT, "diff", '-p', $hash_parent, $hash
 			or die_error(undef, "Open git-diff failed");
 	} else  {
 		die_error('404 Not Found', "Missing one of the blob diff parameters")
-- 
1.4.1.1
