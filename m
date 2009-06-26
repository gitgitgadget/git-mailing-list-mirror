From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] git svn: Doc update for multiple branch and tag paths
Date: Fri, 26 Jun 2009 16:49:19 -0400
Message-ID: <4A45344F.1010708@xiplink.com>
References: <4A3A4945.6050307@drmicha.warpmail.net> <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net> <4A3F9A44.8070805@xiplink.com> <4A410A90.1090101@xiplink.com> <20090625093602.GA3997@dcvr.yhbt.net> <4A451F8A.9060501@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 22:49:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKIMg-0002Qb-IS
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 22:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbZFZUtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 16:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbZFZUtb
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 16:49:31 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:44693 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbZFZUtb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 16:49:31 -0400
Received: from relay16.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay16.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 43D301B4082
	for <git@vger.kernel.org>; Fri, 26 Jun 2009 16:49:34 -0400 (EDT)
Received: by relay16.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 749E51B405E;
	Fri, 26 Jun 2009 16:49:27 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <4A451F8A.9060501@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122318>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

Includes changes to the description to be more accurate.

 Documentation/git-svn.txt |   44 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index bb22d8e..5cbcdf4 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -3,7 +3,7 @@ git-svn(1)
 
 NAME
 ----
-git-svn - Bidirectional operation between a single Subversion branch and git
+git-svn - Bidirectional operation between a Subversion repository and git
 
 SYNOPSIS
 --------
@@ -15,13 +15,12 @@ DESCRIPTION
 It provides a bidirectional flow of changes between a Subversion and a git
 repository.
 
-'git-svn' can track a single Subversion branch simply by using a
-URL to the branch, follow branches laid out in the Subversion recommended
-method (trunk, branches, tags directories) with the --stdlayout option, or
-follow branches in any layout with the -T/-t/-b options (see options to
-'init' below, and also the 'clone' command).
+'git-svn' can track a standard Subversion repository,
+following the common "trunk/branches/tags" layout, with the --stdlayout option.
+It can also follow branches and tags in any layout with the -T/-t/-b options
+(see options to 'init' below, and also the 'clone' command).
 
-Once tracking a Subversion branch (with any of the above methods), the git
+Once tracking a Subversion repository (with any of the above methods), the git
 repository can be updated from Subversion by the 'fetch' command and
 Subversion updated from git by the 'dcommit' command.
 
@@ -48,8 +47,11 @@ COMMANDS
 --stdlayout;;
 	These are optional command-line options for init.  Each of
 	these flags can point to a relative repository path
-	(--tags=project/tags') or a full url
-	(--tags=https://foo.org/project/tags). The option --stdlayout is
+	(--tags=project/tags) or a full url
+	(--tags=https://foo.org/project/tags).
+	You can specify more than one --tags and/or --branches options, in case
+	your Subversion repository places tags or branches under multiple paths.
+	The option --stdlayout is
 	a shorthand way of setting trunk,tags,branches as the relative paths,
 	which is the Subversion default. If any of the other options are given
 	as well, they take precedence.
@@ -204,6 +206,20 @@ config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
 	Create a tag by using the tags_subdir instead of the branches_subdir
 	specified during git svn init.
 
+-d;;
+--destination;;
+	If more than one --branches (or --tags) option was given to the 'init'
+	or 'clone' command, you must provide the location of the branch (or
+	tag) you wish to create in the SVN repository.  The value of this
+	option must match one of the paths specified by a --branches (or
+	--tags) option.  You can see these paths with the commands
++
+	git config --get-all svn-remote.<name>.branches
+	git config --get-all svn-remote.<name>.tags
++
+where <name> is the name of the SVN repository as specified by the -R option to
+'init' (or "svn" by default).
+
 'tag'::
 	Create a tag in the SVN repository. This is a shorthand for
 	'branch -t'.
@@ -669,6 +685,16 @@ already dcommitted.  It is considered bad practice to --amend commits
 you've already pushed to a remote repository for other users, and
 dcommit with SVN is analogous to that.
 
+When using multiple --branches or --tags, 'git-svn' does not automatically
+handle name collisions (for example, if two branches from different paths have
+the same name, or if a branch and a tag have the same name).  In these cases,
+use 'init' to set up your git repository then, before your first 'fetch', edit
+the .git/config file so that the branches and tags are associated with
+different name spaces.  For example:
+
+	branches = stable/*:refs/remotes/svn/stable/*
+	branches = debug/*:refs/remotes/svn/debug/*
+
 BUGS
 ----
 
-- 
1.6.3.3
