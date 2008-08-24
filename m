From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] Clean up the git-p4 documentation
Date: Sun, 24 Aug 2008 16:12:23 +0200
Message-ID: <200808241612.23917.simon@lst.de>
References: <200808241606.39937.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 16:13:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXGLU-0005iO-MK
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 16:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbYHXOM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 10:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbYHXOM1
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 10:12:27 -0400
Received: from hoat.troll.no ([62.70.27.150]:51801 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbYHXOM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 10:12:26 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 91E13209EF;
	Sun, 24 Aug 2008 16:12:25 +0200 (CEST)
Received: from rani.localnet (unknown [172.20.1.59])
	by hoat.troll.no (Postfix) with ESMTP id 7425120A54;
	Sun, 24 Aug 2008 16:12:25 +0200 (CEST)
User-Agent: KMail/1.10.0 (Linux/2.6.26-5-generic; KDE/4.1.0; i686; ; )
In-Reply-To: <200808241606.39937.simon@lst.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93531>

This patch massages the documentation a bit for improved readability and cleans
it up from outdated options/commands.

Signed-off-by: Simon Hausmann <simon@lst.de>
---

Whoops, sorry, the previous email/patch had conflicts against master. Please
use one instead, thanks :)

 contrib/fast-import/git-p4.txt |   69 ++++++++++++++++++++++------------------
 1 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index ac551d4..49b3359 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -3,14 +3,16 @@ git-p4 - Perforce <-> Git converter using git-fast-import
 Usage
 =====
 
-git-p4 supports two main modes: Importing from Perforce to a Git repository is
-done using "git-p4 sync" or "git-p4 rebase". Submitting changes from Git back
-to Perforce is done using "git-p4 submit".
+git-p4 can be used in two different ways:
+
+1) To import changes from Perforce to a Git repository, using "git-p4 sync".
+
+2) To submit changes from Git back to Perforce, using "git-p4 submit".
 
 Importing
 =========
 
-You can simply start with
+Simply start with
 
   git-p4 clone //depot/path/project
 
@@ -18,11 +20,18 @@ or
 
   git-p4 clone //depot/path/project myproject
 
-This will create an empty git repository in a subdirectory called "project" (or
-"myproject" with the second command), import the head revision from the
-specified perforce path into a git "p4" branch (remotes/p4 actually), create a
-master branch off it and check it out. If you want the entire history (not just
-the head revision) then you can simply append a "@all" to the depot path:
+This will:
+
+1) Create an empty git repository in a subdirectory called "project" (or
+"myproject" with the second command)
+
+2) Import the head revision from the given Perforce path into a git branch
+called "p4" (remotes/p4 actually)
+
+3) Create a master branch based on it and check it out.
+
+If you want the entire history (not just the head revision) then you can simply
+append a "@all" to the depot path:
 
   git-p4 clone //depot/project/main@all myproject
 
@@ -37,31 +46,40 @@ If you want more control you can also use the git-p4 sync command directly:
 
 This will import the current head revision of the specified depot path into a
 "remotes/p4/master" branch of your git repository. You can use the
---branch=mybranch option to use a different branch.
+--branch=mybranch option to import into a different branch.
 
-If you want to import the entire history of a given depot path just use
+If you want to import the entire history of a given depot path simply use:
 
   git-p4 sync //path/in/depot@all
 
+
+Note:
+
 To achieve optimal compression you may want to run 'git repack -a -d -f' after
 a big import. This may take a while.
 
-Support for Perforce integrations is still work in progress. Don't bother
-trying it unless you want to hack on it :)
-
 Incremental Imports
 ===================
 
-After an initial import you can easily synchronize your git repository with
-newer changes from the Perforce depot by just calling
+After an initial import you can continue to synchronize your git repository
+with newer changes from the Perforce depot by just calling
 
   git-p4 sync
 
 in your git repository. By default the "remotes/p4/master" branch is updated.
 
-It is recommended to run 'git repack -a -d -f' from time to time when using
-incremental imports to optimally combine the individual git packs that each
-incremental import creates through the use of git-fast-import.
+Advanced Setup
+==============
+
+Suppose you have a periodically updated git repository somewhere, containing a
+complete import of a Perforce project. This repository can be cloned and used
+with git-p4. When updating the cloned repository with the "sync" command,
+git-p4 will try to fetch changes from the original repository first. The git
+protocol used with this is usually faster than importing from Perforce
+directly.
+
+This behaviour can be disabled by setting the "git-p4.syncFromOrigin" git
+configuration variable to "false".
 
 Updating
 ========
@@ -79,7 +97,7 @@ Submitting
 ==========
 
 git-p4 has support for submitting changes from a git repository back to the
-Perforce depot. This requires a Perforce checkout separate to your git
+Perforce depot. This requires a Perforce checkout separate from your git
 repository. To submit all changes that are in the current git branch but not in
 the "p4" branch (or "origin" if "p4" doesn't exist) simply call
 
@@ -97,17 +115,6 @@ continue importing the remaining changes with
 
   git-p4 submit --continue
 
-After submitting you should sync your perforce import branch ("p4" or "origin")
-from Perforce using git-p4's sync command.
-
-If you have changes in your working directory that you haven't committed into
-git yet but that you want to commit to Perforce directly ("quick fixes") then
-you do not have to go through the intermediate step of creating a git commit
-first but you can just call
-
-  git-p4 submit --direct
-
-
 Example
 =======
 
-- 
1.6.0.rc1.48.g2b6032
