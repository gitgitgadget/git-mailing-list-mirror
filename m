From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] Cogito README: add a block describing team workflow with git+ssh
Date: Fri, 21 Oct 2005 18:34:48 +1300
Message-ID: <11298728883894-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Oct 21 07:32:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESpVT-0001GH-KG
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 07:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVJUFbx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 01:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVJUFbx
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 01:31:53 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:16834 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S964875AbVJUFbw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 01:31:52 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1ESpVP-0003jQ-O2; Fri, 21 Oct 2005 18:31:51 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1ESpYG-0006GA-00; Fri, 21 Oct 2005 18:34:48 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10423>

This is a resend, with a silly typo (chgroup/chgrp) fixed.

---

The README doesn't talk about teams with "peer" access to a shared repo.
It took me a while to figure our the /right/ way to do it. Document for
future generations and general happiness.

---

 README |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

applies-to: 06a96ef8bc54639d5e42319c86cac2d812327cf0
1217193450bf9ae108af2341f1383eb496d31b62
diff --git a/README b/README
index 70908bc..fb87adb 100644
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
+        $ chgrp gitcommit /var/git
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
---
0.99.8.GIT
