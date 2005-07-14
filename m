From: Jerry Seutter <jerry.seutter@pason.com>
Subject: Patch to make README more newbie-friendly
Date: Wed, 13 Jul 2005 22:58:51 -0600
Message-ID: <42D5F10B.5050708@pason.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020909050607020103080200"
X-From: git-owner@vger.kernel.org Thu Jul 14 06:56:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dsvlv-0000Xh-53
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 06:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVGNE4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 00:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbVGNE4T
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 00:56:19 -0400
Received: from hemlock.pason.com ([208.38.1.1]:32378 "EHLO
	exch-calgary.int.pason.com") by vger.kernel.org with ESMTP
	id S262901AbVGNE4S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 00:56:18 -0400
Received: from [172.16.0.231] ([172.16.0.231]) by exch-calgary.int.pason.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 13 Jul 2005 22:56:17 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-OriginalArrivalTime: 14 Jul 2005 04:56:17.0429 (UTC) FILETIME=[5E726450:01C58830]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------020909050607020103080200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Attached to this email is a patch that expands the README file a bit, 
including info about basic Cogito commands at the beginning of the file. 
  I also added an distributed VCS paragraph at the beginning for people 
like me who are typically stuck in CVS-land.

Comments/critiques/flames welcome.

I'd also like to include stuff about branches, but I haven't gotten my 
head wrapped around how they work yet.  cg-branch-add expects a location
after the branch name and I'm not sure what to give it.  I have a test 
project containing hello_world.py and was trying to get 2 branches going 
and be able to switch between them.  What do you use for a location in 
this case?  I tried using ".", but switching between branches didn't 
seem to have any affect.

On another note, I thought I heard that man pages are desired.  Is the a 
certain group of commands I should start with?  Do you want dirt simple 
man pages, or are you looking for some <insert-buzzword-here> formatted 
source docs?

Jerry

--------------020909050607020103080200
Content-Type: text/plain;
 name="expand_README.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="expand_README.patch"

diff --git a/README b/README
--- a/README
+++ b/README
@@ -1,12 +1,24 @@
 	Cogito and GIT: Quick Introduction
 	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-This document describes the Cogito VCS as well as GIT.  The GIT itself is
-merely an extremely fast and flexible filesystem-based database designed to
-store directory trees with regard to their history.  The top layer is a
-SCM-like tool Cogito which enables human beings to work with the database in a
-manner to a degree similar to other SCM tools (like CVS, BitKeeper or
-Monotone).
+This document describes the Cogito VCS as well as GIT.  The GIT itself
+is merely an extremely fast and flexible filesystem-based database
+designed to store directory trees with regard to their history.  The
+top layer is a SCM-like tool Cogito which enables human beings to work
+with the database in a manner to a degree similar to other SCM tools
+(like CVS, BitKeeper or Monotone).  Mere Human Beings will seldom use
+the GIT tools directly, but use the Cogito tools instead.
+
+If you've only used a centralized version control system like CVS
+before, this package may require a change in how you visualize source
+code management.  With Cogito/GIT, every directory with a checked out
+project is also a repository for that project.  When you commit your
+changes, you are committing them into the repository in the current
+directory, not to the main repository.  In order to have your changes
+show up in the main repository they need to be merged in by a person
+that manages that repository.  This can either be done by mailing them
+a patch containing your changes or by giving them access to your 
+repository and having them pull in your changes.
 
 
 	The Cogito Version Control System
@@ -30,8 +42,11 @@ Cogito can be obtained as a tarball from
 
 	http://www.kernel.org/pub/software/scm/cogito/
 
-Download and unpack the latest version, build with make, put the executables
-somewhere in your $PATH (or add your Cogito directory itself to your $PATH),
+Download and unpack the latest version, build with 
+
+        $ make
+        $ sudo make install
+
 and you're ready to go!
 
 The following tools are required by Cogito:
@@ -43,7 +58,9 @@ The following tools are required by Cogi
 
 The following tools are optional but strongly recommended:
 
-	libcrypto (OpenSSL)
+	libcrypto (OpenSSL) (Cogito also contains an OpenSSL implementation
+        from the Mozilla project.  To use it instead of OpenSSL, build
+        with "make MOZILLA_SHA1=1"
 	rsync
 
 
@@ -67,6 +84,46 @@ That's it! You're now in your own GIT re
 directory. Go into it and look around, but don't change anything in there.
 That's what Cogito commands are for.
 
+Files that you want to add to the repository can be added with
+
+    $ cg-add newfile1 newfile2 ...
+
+When you do some local changes, you can do
+
+	$ cg-diff
+
+to display them.  You can also just show which files have changed by
+
+    $ cg-status
+
+Once you have decided that you want to commit your changes, use the
+
+    $ cg-commit
+
+command, which will present you with the editor of your choice for composing
+the commit message.
+
+If you want to see the changes made to the repository by a certain commit,
+the first thing you need to know is the commit names.  A commit name in
+Cogito/Git is the hash of the commit.  The commit history of the repository
+is displayed with
+
+    $ cg-log
+
+Once you know the name of the commit you want to see, use
+
+    $ cg-diff -r FROM_COMMIT_ID[:TO_COMMIT_ID]
+
+To tag the repository, use cg-tag.  cg-tag defaults to tagging HEAD, but
+you can also give it the name of a commit to tag
+
+    $ cg-tag TAG_NAME [COMMIT_ID]
+
+To display the tags you have in your repository, use
+
+    $ cg-tag-ls
+
+
 	Turning an Existing Directory Into a Repository
 
 If you have a directory full of files, you can easily turn this into a
@@ -198,24 +255,6 @@ the command
 repository). Then you can specify the name to cg-update and cg-pull, or use
 it anywhere where you could use the "origin" name.
 
-When you do some local changes, you can do
-
-	$ cg-diff
-
-to display them.  Of course you will want to commit. If you added any new
-files, do
-
-	$ cg-add newfile1 newfile2 ...
-
-first. Then examine your changes by cg-diff or just show what files did you
-change by
-
-	$ cg-status
-
-and feel free to commit by the
-
-	$ cg-commit
-
 command, which will present you with the editor of your choice for composing
 the commit message.
 
@@ -247,6 +286,9 @@ or, for the same information, try this:
 	The "core GIT"
 	~~~~~~~~~~~~~~
 
+Note that if all you care about is committing some small bits of code
+to a repository, you can stop reading now.
+
 	GIT - the stupid content tracker
 
 "git" can mean anything, depending on your mood.

--------------020909050607020103080200--
