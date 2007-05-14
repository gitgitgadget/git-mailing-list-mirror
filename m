From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 04/10] user-manual: move quick-start to an appendix
Date: Mon, 14 May 2007 11:21:23 -0400
Message-ID: <22383.8743790568$1179156136@news.gmane.org>
References: <11791560893572-git-send-email->
 <1179156089759-git-send-email->
 <11791560893022-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 17:22:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HncNH-0006P0-RY
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789AbXENPVm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756761AbXENPVm
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:21:42 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54959 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755431AbXENPVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:21:32 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HncMb-0004z6-OK; Mon, 14 May 2007 11:21:29 -0400
X-Mailer: git-send-email 1.5.1.4.19.g69e2
In-Reply-To: <11791560893022-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47254>

From: J. Bruce Fields <bfields@citi.umich.edu>

The quick start interrupts the flow of the manual a bit.  Move it to
"appendix A" but add a reference to it in the preface.  Also rename the
todo chapter to "appendix B", and revise the preface a little.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |  484 +++++++++++++++++++++--------------------
 1 files changed, 245 insertions(+), 239 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 7abdc3e..986e617 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4,15 +4,13 @@ ______________________________________________
 This manual is designed to be readable by someone with basic unix
 command-line skills, but no previous knowledge of git.
 
-Chapter 1 gives a brief overview of git commands, without any
-explanation; you may prefer to skip to chapter 2 on a first reading.
+<<repositories-and-branches>> and <<exploring-git-history>> explain how
+to fetch and study a project using git--read these chapters to learn how
+to build and test a particular version of a software project, search for
+regressions, and so on.
 
-Chapters 2 and 3 explain how to fetch and study a project using
-git--the tools you'd need to build and test a particular version of a
-software project, to search for regressions, and so on.
-
-Chapter 4 explains how to do development with git, and chapter 5 how
-to share that development with others.
+People needing to do actual development will also want to read
+<<Developing-with-git>> and <<sharing-development>>.
 
 Further chapters cover more specialized topics.
 
@@ -23,237 +21,12 @@ pages.  For a command such as "git clone", just use
 $ man git-clone
 ------------------------------------------------
 
-[[git-quick-start]]
-Git Quick Start
-===============
-
-This is a quick summary of the major commands; the following chapters
-will explain how these work in more detail.
-
-[[quick-creating-a-new-repository]]
-Creating a new repository
--------------------------
-
-From a tarball:
-
------------------------------------------------
-$ tar xzf project.tar.gz
-$ cd project
-$ git init
-Initialized empty Git repository in .git/
-$ git add .
-$ git commit
------------------------------------------------
-
-From a remote repository:
-
------------------------------------------------
-$ git clone git://example.com/pub/project.git
-$ cd project
------------------------------------------------
-
-[[managing-branches]]
-Managing branches
------------------
-
------------------------------------------------
-$ git branch	     # list all local branches in this repo
-$ git checkout test  # switch working directory to branch "test"
-$ git branch new     # create branch "new" starting at current HEAD
-$ git branch -d new  # delete branch "new"
------------------------------------------------
-
-Instead of basing new branch on current HEAD (the default), use:
-
------------------------------------------------
-$ git branch new test    # branch named "test"
-$ git branch new v2.6.15 # tag named v2.6.15
-$ git branch new HEAD^   # commit before the most recent
-$ git branch new HEAD^^  # commit before that
-$ git branch new test~10 # ten commits before tip of branch "test"
------------------------------------------------
-
-Create and switch to a new branch at the same time:
-
------------------------------------------------
-$ git checkout -b new v2.6.15
------------------------------------------------
-
-Update and examine branches from the repository you cloned from:
-
------------------------------------------------
-$ git fetch		# update
-$ git branch -r		# list
-  origin/master
-  origin/next
-  ...
-$ git checkout -b masterwork origin/master
------------------------------------------------
-
-Fetch a branch from a different repository, and give it a new
-name in your repository:
-
------------------------------------------------
-$ git fetch git://example.com/project.git theirbranch:mybranch
-$ git fetch git://example.com/project.git v2.6.15:mybranch
------------------------------------------------
-
-Keep a list of repositories you work with regularly:
-
------------------------------------------------
-$ git remote add example git://example.com/project.git
-$ git remote			# list remote repositories
-example
-origin
-$ git remote show example	# get details
-* remote example
-  URL: git://example.com/project.git
-  Tracked remote branches
-    master next ...
-$ git fetch example		# update branches from example
-$ git branch -r			# list all remote branches
------------------------------------------------
-
-
-[[exploring-history]]
-Exploring history
------------------
-
------------------------------------------------
-$ gitk			    # visualize and browse history
-$ git log		    # list all commits
-$ git log src/		    # ...modifying src/
-$ git log v2.6.15..v2.6.16  # ...in v2.6.16, not in v2.6.15
-$ git log master..test	    # ...in branch test, not in branch master
-$ git log test..master	    # ...in branch master, but not in test
-$ git log test...master	    # ...in one branch, not in both
-$ git log -S'foo()'	    # ...where difference contain "foo()"
-$ git log --since="2 weeks ago"
-$ git log -p		    # show patches as well
-$ git show		    # most recent commit
-$ git diff v2.6.15..v2.6.16 # diff between two tagged versions
-$ git diff v2.6.15..HEAD    # diff with current head
-$ git grep "foo()"	    # search working directory for "foo()"
-$ git grep v2.6.15 "foo()"  # search old tree for "foo()"
-$ git show v2.6.15:a.txt    # look at old version of a.txt
------------------------------------------------
-
-Search for regressions:
-
------------------------------------------------
-$ git bisect start
-$ git bisect bad		# current version is bad
-$ git bisect good v2.6.13-rc2	# last known good revision
-Bisecting: 675 revisions left to test after this
-				# test here, then:
-$ git bisect good		# if this revision is good, or
-$ git bisect bad		# if this revision is bad.
-				# repeat until done.
------------------------------------------------
-
-[[making-changes]]
-Making changes
---------------
-
-Make sure git knows who to blame:
-
-------------------------------------------------
-$ cat >>~/.gitconfig <<\EOF
-[user]
-	name = Your Name Comes Here
-	email = you@yourdomain.example.com
-EOF
-------------------------------------------------
-
-Select file contents to include in the next commit, then make the
-commit:
-
------------------------------------------------
-$ git add a.txt    # updated file
-$ git add b.txt    # new file
-$ git rm c.txt     # old file
-$ git commit
------------------------------------------------
+See also <<git-quick-start>> for a brief overview of git commands,
+without any explanation.
 
-Or, prepare and create the commit in one step:
+Also, see <<todo>> for ways that you can help make this manual more
+complete.
 
------------------------------------------------
-$ git commit d.txt # use latest content only of d.txt
-$ git commit -a	   # use latest content of all tracked files
------------------------------------------------
-
-[[merging]]
-Merging
--------
-
------------------------------------------------
-$ git merge test   # merge branch "test" into the current branch
-$ git pull git://example.com/project.git master
-		   # fetch and merge in remote branch
-$ git pull . test  # equivalent to git merge test
------------------------------------------------
-
-[[sharing-your-changes]]
-Sharing your changes
---------------------
-
-Importing or exporting patches:
-
------------------------------------------------
-$ git format-patch origin..HEAD # format a patch for each commit
-				# in HEAD but not in origin
-$ git am mbox # import patches from the mailbox "mbox"
------------------------------------------------
-
-Fetch a branch in a different git repository, then merge into the
-current branch:
-
------------------------------------------------
-$ git pull git://example.com/project.git theirbranch
------------------------------------------------
-
-Store the fetched branch into a local branch before merging into the
-current branch:
-
------------------------------------------------
-$ git pull git://example.com/project.git theirbranch:mybranch
------------------------------------------------
-
-After creating commits on a local branch, update the remote
-branch with your commits:
-
------------------------------------------------
-$ git push ssh://example.com/project.git mybranch:theirbranch
------------------------------------------------
-
-When remote and local branch are both named "test":
-
------------------------------------------------
-$ git push ssh://example.com/project.git test
------------------------------------------------
-
-Shortcut version for a frequently used remote repository:
-
------------------------------------------------
-$ git remote add example ssh://example.com/project.git
-$ git push example test
------------------------------------------------
-
-[[repository-maintenance]]
-Repository maintenance
-----------------------
-
-Check for corruption:
-
------------------------------------------------
-$ git fsck
------------------------------------------------
-
-Recompress, remove unused cruft:
-
------------------------------------------------
-$ git gc
------------------------------------------------
 
 [[repositories-and-branches]]
 Repositories and Branches
@@ -3379,9 +3152,242 @@ itself!
 [[glossary]]
 include::glossary.txt[]
 
+[[git-quick-start]]
+Appendix A: Git Quick Start
+===========================
+
+This is a quick summary of the major commands; the following chapters
+will explain how these work in more detail.
+
+[[quick-creating-a-new-repository]]
+Creating a new repository
+-------------------------
+
+From a tarball:
+
+-----------------------------------------------
+$ tar xzf project.tar.gz
+$ cd project
+$ git init
+Initialized empty Git repository in .git/
+$ git add .
+$ git commit
+-----------------------------------------------
+
+From a remote repository:
+
+-----------------------------------------------
+$ git clone git://example.com/pub/project.git
+$ cd project
+-----------------------------------------------
+
+[[managing-branches]]
+Managing branches
+-----------------
+
+-----------------------------------------------
+$ git branch	     # list all local branches in this repo
+$ git checkout test  # switch working directory to branch "test"
+$ git branch new     # create branch "new" starting at current HEAD
+$ git branch -d new  # delete branch "new"
+-----------------------------------------------
+
+Instead of basing new branch on current HEAD (the default), use:
+
+-----------------------------------------------
+$ git branch new test    # branch named "test"
+$ git branch new v2.6.15 # tag named v2.6.15
+$ git branch new HEAD^   # commit before the most recent
+$ git branch new HEAD^^  # commit before that
+$ git branch new test~10 # ten commits before tip of branch "test"
+-----------------------------------------------
+
+Create and switch to a new branch at the same time:
+
+-----------------------------------------------
+$ git checkout -b new v2.6.15
+-----------------------------------------------
+
+Update and examine branches from the repository you cloned from:
+
+-----------------------------------------------
+$ git fetch		# update
+$ git branch -r		# list
+  origin/master
+  origin/next
+  ...
+$ git checkout -b masterwork origin/master
+-----------------------------------------------
+
+Fetch a branch from a different repository, and give it a new
+name in your repository:
+
+-----------------------------------------------
+$ git fetch git://example.com/project.git theirbranch:mybranch
+$ git fetch git://example.com/project.git v2.6.15:mybranch
+-----------------------------------------------
+
+Keep a list of repositories you work with regularly:
+
+-----------------------------------------------
+$ git remote add example git://example.com/project.git
+$ git remote			# list remote repositories
+example
+origin
+$ git remote show example	# get details
+* remote example
+  URL: git://example.com/project.git
+  Tracked remote branches
+    master next ...
+$ git fetch example		# update branches from example
+$ git branch -r			# list all remote branches
+-----------------------------------------------
+
+
+[[exploring-history]]
+Exploring history
+-----------------
+
+-----------------------------------------------
+$ gitk			    # visualize and browse history
+$ git log		    # list all commits
+$ git log src/		    # ...modifying src/
+$ git log v2.6.15..v2.6.16  # ...in v2.6.16, not in v2.6.15
+$ git log master..test	    # ...in branch test, not in branch master
+$ git log test..master	    # ...in branch master, but not in test
+$ git log test...master	    # ...in one branch, not in both
+$ git log -S'foo()'	    # ...where difference contain "foo()"
+$ git log --since="2 weeks ago"
+$ git log -p		    # show patches as well
+$ git show		    # most recent commit
+$ git diff v2.6.15..v2.6.16 # diff between two tagged versions
+$ git diff v2.6.15..HEAD    # diff with current head
+$ git grep "foo()"	    # search working directory for "foo()"
+$ git grep v2.6.15 "foo()"  # search old tree for "foo()"
+$ git show v2.6.15:a.txt    # look at old version of a.txt
+-----------------------------------------------
+
+Search for regressions:
+
+-----------------------------------------------
+$ git bisect start
+$ git bisect bad		# current version is bad
+$ git bisect good v2.6.13-rc2	# last known good revision
+Bisecting: 675 revisions left to test after this
+				# test here, then:
+$ git bisect good		# if this revision is good, or
+$ git bisect bad		# if this revision is bad.
+				# repeat until done.
+-----------------------------------------------
+
+[[making-changes]]
+Making changes
+--------------
+
+Make sure git knows who to blame:
+
+------------------------------------------------
+$ cat >>~/.gitconfig <<\EOF
+[user]
+	name = Your Name Comes Here
+	email = you@yourdomain.example.com
+EOF
+------------------------------------------------
+
+Select file contents to include in the next commit, then make the
+commit:
+
+-----------------------------------------------
+$ git add a.txt    # updated file
+$ git add b.txt    # new file
+$ git rm c.txt     # old file
+$ git commit
+-----------------------------------------------
+
+Or, prepare and create the commit in one step:
+
+-----------------------------------------------
+$ git commit d.txt # use latest content only of d.txt
+$ git commit -a	   # use latest content of all tracked files
+-----------------------------------------------
+
+[[merging]]
+Merging
+-------
+
+-----------------------------------------------
+$ git merge test   # merge branch "test" into the current branch
+$ git pull git://example.com/project.git master
+		   # fetch and merge in remote branch
+$ git pull . test  # equivalent to git merge test
+-----------------------------------------------
+
+[[sharing-your-changes]]
+Sharing your changes
+--------------------
+
+Importing or exporting patches:
+
+-----------------------------------------------
+$ git format-patch origin..HEAD # format a patch for each commit
+				# in HEAD but not in origin
+$ git am mbox # import patches from the mailbox "mbox"
+-----------------------------------------------
+
+Fetch a branch in a different git repository, then merge into the
+current branch:
+
+-----------------------------------------------
+$ git pull git://example.com/project.git theirbranch
+-----------------------------------------------
+
+Store the fetched branch into a local branch before merging into the
+current branch:
+
+-----------------------------------------------
+$ git pull git://example.com/project.git theirbranch:mybranch
+-----------------------------------------------
+
+After creating commits on a local branch, update the remote
+branch with your commits:
+
+-----------------------------------------------
+$ git push ssh://example.com/project.git mybranch:theirbranch
+-----------------------------------------------
+
+When remote and local branch are both named "test":
+
+-----------------------------------------------
+$ git push ssh://example.com/project.git test
+-----------------------------------------------
+
+Shortcut version for a frequently used remote repository:
+
+-----------------------------------------------
+$ git remote add example ssh://example.com/project.git
+$ git push example test
+-----------------------------------------------
+
+[[repository-maintenance]]
+Repository maintenance
+----------------------
+
+Check for corruption:
+
+-----------------------------------------------
+$ git fsck
+-----------------------------------------------
+
+Recompress, remove unused cruft:
+
+-----------------------------------------------
+$ git gc
+-----------------------------------------------
+
+
 [[todo]]
-Notes and todo list for this manual
-===================================
+Appendix B: Notes and todo list for this manual
+===============================================
 
 This is a work in progress.
 
-- 
1.5.1.4.19.g69e2
