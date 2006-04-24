From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 3/4] Deprecate usage of git-var -l for getting config vars list
Date: Tue, 25 Apr 2006 00:59:30 +0200
Message-ID: <20060424225930.14086.76174.stgit@machine.or.cz>
References: <20060424225925.14086.97825.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 25 00:59:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYA1P-0005Ay-VR
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 00:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWDXW7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 18:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWDXW7H
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 18:59:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50347 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932098AbWDXW7H (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 18:59:07 -0400
Received: (qmail 14194 invoked from network); 25 Apr 2006 00:59:31 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 25 Apr 2006 00:59:31 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060424225925.14086.97825.stgit@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19115>

This has been an unfortunate sideway in the git API evolution.
We use git-repo-config for all the other .git/config interaction
so let's also use git-repo-config -l for the variable listing.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-var.txt |    3 ++-
 git-cvsserver.perl        |    6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 379571e..a5b1a0d 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -19,7 +19,8 @@ OPTIONS
 -l::
 	Cause the logical variables to be listed. In addition, all the
 	variables of the git configuration file .git/config are listed
-	as well.
+	as well. (However, the configuration variables listing functionality
+	is deprecated in favor of `git-repo-config -l`.)
 
 EXAMPLE
 --------
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 7d3f78e..0b37d26 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -171,11 +171,11 @@ sub req_Root
        return 0;
     }
 
-    my @gitvars = `git-var -l`;
+    my @gitvars = `git-repo-config -l`;
     if ($?) {
-       print "E problems executing git-var on the server -- this is not a git repository or the PATH is not set correcly.\n";
+       print "E problems executing git-repo-config on the server -- this is not a git repository or the PATH is not set correcly.\n";
         print "E \n";
-        print "error 1 - problem executing git-var\n";
+        print "error 1 - problem executing git-repo-config\n";
        return 0;
     }
     foreach my $line ( @gitvars )
