From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: [PATCH] Update the git-branch man page to include the "-r" option,
Date: Fri, 28 Apr 2006 09:15:04 -0400
Message-ID: <BAYC1-PASMTP12A9682774BA94F33C4BBDAEB20@CEZ.ICE>
References: <11462301062278-git-send-email-seanlkml@sympatico.ca>
Reply-To: Sean Estabrooks <seanlkml@sympatico.ca>
Cc: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Fri Apr 28 15:19:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZSsn-0004Y7-3J
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 15:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWD1NTh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 09:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWD1NTh
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 09:19:37 -0400
Received: from bayc1-pasmtp12.bayc1.hotmail.com ([65.54.191.172]:736 "EHLO
	BAYC1-PASMTP12.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1030393AbWD1NTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 09:19:36 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from guru.attic.local ([69.156.138.66]) by BAYC1-PASMTP12.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Apr 2006 06:26:16 -0700
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by guru.attic.local (Postfix) with ESMTP id 8E7247001EB;
	Fri, 28 Apr 2006 09:15:06 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <11462301063885-git-send-email-seanlkml@sympatico.ca>
X-Mailer: git-send-email 1.3.1.gc672
In-Reply-To: <11462301062278-git-send-email-seanlkml@sympatico.ca>
X-OriginalArrivalTime: 28 Apr 2006 13:26:16.0734 (UTC) FILETIME=[5405CBE0:01C66AC7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

and fix up asciidoc "callouts"

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>


---

 Documentation/git-branch.txt |   57 +++++++++++++++++++++++++++++-------------
 1 files changed, 39 insertions(+), 18 deletions(-)

5f70eb7e8c318528885cdd9b35bfa1d92cbf6782
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 71ecd85..050e1f7 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -3,22 +3,27 @@ git-branch(1)
 
 NAME
 ----
-git-branch - Create a new branch, or remove an old one
+git-branch - List, create, or delete branches.
 
 SYNOPSIS
 --------
 [verse]
-'git-branch' [[-f] <branchname> [<start-point>]]
-'git-branch' (-d | -D) <branchname>
+'git-branch' [-r]
+'git-branch' [-f] <branchname> [<start-point>]
+'git-branch' (-d | -D) <branchname>...
 
 DESCRIPTION
 -----------
-If no argument is provided, show available branches and mark current
-branch with star. Otherwise, create a new branch of name <branchname>.
-If a starting point is also specified, that will be where the branch is
-created, otherwise it will be created at the current HEAD.
+With no arguments given (or just `-r`) a list of available branches
+will be shown, the current branch will be highlighted with an asterisk.
 
-With a `-d` or `-D` option, `<branchname>` will be deleted.
+In its second form, a new branch named <branchname> will be created.
+It will start out with a head equal to the one given as <start-point>.
+If no <start-point> is given, the branch will be created with a head
+equal to that of the currently checked out branch.
+
+With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
+specify more than one branch for deletion.
 
 
 OPTIONS
@@ -30,40 +35,56 @@ OPTIONS
 	Delete a branch irrespective of its index status.
 
 -f::
-	Force a reset of <branchname> to <start-point> (or current head).
+	Force the creation of a new branch even if it means deleting
+	a branch that already exists with the same name.
+
+-r::
+	List only the "remote" branches.
 
 <branchname>::
 	The name of the branch to create or delete.
 
 <start-point>::
-	Where to create the branch; defaults to HEAD. This
-	option has no meaning with -d and -D.
+	The new branch will be created with a HEAD equal to this.  It may
+	be given as a branch name, a commit-id, or a tag.  If this option 
+	is omitted, the current branch is assumed.
+
 
 
 Examples
-~~~~~~~~
+--------
 
 Start development off of a known tag::
 +
 ------------
 $ git clone git://git.kernel.org/pub/scm/.../linux-2.6 my2.6
 $ cd my2.6
-$ git branch my2.6.14 v2.6.14 <1>
+$ git branch my2.6.14 v2.6.14   <1>
 $ git checkout my2.6.14
-
-<1> These two steps are the same as "checkout -b my2.6.14 v2.6.14".
 ------------
++
+<1> This step and the next one could be combined into a single step with 
+"checkout -b my2.6.14 v2.6.14".
 
 Delete unneeded branch::
 +
 ------------
 $ git clone git://git.kernel.org/.../git.git my.git
 $ cd my.git
-$ git branch -D todo <1>
-
+$ git branch -D todo    <1>
+------------
++
 <1> delete todo branch even if the "master" branch does not have all
 commits from todo branch.
-------------
+
+
+Notes
+-----
+
+If you are creating a branch that you want to immediately checkout, it's 
+easier to use the git checkout command with its `-b` option to create
+a branch and check it out with a single command.
+
 
 Author
 ------
-- 
1.3.1.gc672
