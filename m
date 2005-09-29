From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] Cogito README: add a block describing team workflow with git+ssh
Date: Thu, 29 Sep 2005 18:31:17 +1200
Message-ID: <11279754774179-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Sep 29 08:31:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKrwz-0007D5-DV
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 08:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVI2Gah (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 02:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVI2Gah
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 02:30:37 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:9611 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932092AbVI2Gag (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 02:30:36 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1EKrwA-0002o7-Cr; Thu, 29 Sep 2005 18:30:34 +1200
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1EKrwr-0007ev-00; Thu, 29 Sep 2005 18:31:17 +1200
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9468>

The README doesn't talk about teams with "peer" access to a shared repo.
It took me a while to figure our the /right/ way to do it. Document for
future generations and general happiness.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 README |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

ffd2191e527f6b7c67fa7939927a0bd30270c11a
diff --git a/README b/README
--- a/README
+++ b/README
@@ -268,6 +268,41 @@ Note that we gave only a glimpse to the 
 - merging (`cg-merge`), moving your tree to an older commit (`cg-seek`),
 pushing (`cg-push`), etc.
 
+Using Cogito for Team Work
+--------------------------
+
+A small team with SSH access to a shared server can use Cogito in a way 
+similar to traditional CVS over SSH. 
+
+If you are bootstrapping the project, and you have a local Cogito working copy,
+you must set up the shared repository and push a local head to it.
+
+To set up the shared repository, for example in 
+remoteserver:/var/git, login to the remote server and do
+
+        $ umask  002
+        $ mkdir /var/git
+        $ chgroup gitcommit /var/git
+        $ chmod  2775 /var/git
+        $ mkdir -p /var/git/projectname.git
+        $ GIT_DIR=/var/git/projectname.git git-init-db
+        
+Note: All the developers with "commit" access must belong to the gitcommit
+group and have a 002 umask on the remote server.
+
+Going back to your Cogito working copy, run 
+
+        $ git-push  remoteserver:/var/git/projectname.git master branchname
+
+Now your other teammembers can start working with you, doing
+
+         $ cg-clone git+ssh://remoteserver/var/git/project.git#branchname localdir
+
+And when they are ready to push their work onto the shared repository, just do
+
+         $ cg-update
+         $ cg-push
+
 
 Understanding GIT branching and merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
