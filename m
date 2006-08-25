From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 7/7] git-svn(1): improve asciidoc markup
Date: Fri, 25 Aug 2006 03:07:46 +0200
Message-ID: <20060825010746.GH4069@diku.dk>
References: <20060818084545.GB4717@diku.dk> <7virkqbcq3.fsf@assigned-by-dhcp.cox.net> <20060825005655.GB4069@diku.dk> <20060825005820.GC4069@diku.dk> <20060825010149.GD4069@diku.dk> <20060825010458.GE4069@diku.dk> <20060825010548.GF4069@diku.dk> <20060825010650.GG4069@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 03:08:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGQAt-00065V-CW
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 03:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422812AbWHYBHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 21:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWHYBHw
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 21:07:52 -0400
Received: from [130.225.96.91] ([130.225.96.91]:31121 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1030493AbWHYBHv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 21:07:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 1E9F777007C;
	Fri, 25 Aug 2006 03:07:48 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26295-08; Fri, 25 Aug 2006 03:07:46 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 42F75770076;
	Fri, 25 Aug 2006 03:07:46 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 160BC6DF89F; Fri, 25 Aug 2006 03:06:28 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 232AE629FB; Fri, 25 Aug 2006 03:07:46 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060825010650.GG4069@diku.dk>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25990>

Use list continuation to have better wrapping. This accounts for most of
the changes because it reindents a lot of text without applying other
changes.

Use cross-referencing for interlinking and the gitlink macro for pointing
to other tools in the git suite.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-svn.txt |  199 ++++++++++++++++++++++++++-------------------
 1 files changed, 114 insertions(+), 85 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 7d86809..f21aced 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -12,10 +12,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 git-svn is a simple conduit for changesets between a single Subversion
-branch and git.
-
-git-svn is not to be confused with git-svnimport.  The were designed
-with very different goals in mind.
+branch and git. It is not to be confused with gitlink:git-svnimport[1].
+They were designed with very different goals in mind.
 
 git-svn is designed for an individual developer who wants a
 bidirectional flow of changesets between a single branch in Subversion
@@ -34,26 +32,29 @@ git-svnimport is designed for.
 
 COMMANDS
 --------
-init::
+--
+
+'init'::
 	Creates an empty git repository with additional metadata
 	directories for git-svn.  The Subversion URL must be specified
 	as a command-line argument.
 
-fetch::
-	Fetch unfetched revisions from the Subversion URL we are
-	tracking.  refs/remotes/git-svn will be updated to the
-	latest revision.
+'fetch'::
 
-	Note: You should never attempt to modify the remotes/git-svn
-	branch outside of git-svn.  Instead, create a branch from
-	remotes/git-svn and work on that branch.  Use the 'commit'
-	command (see below) to write git commits back to
-	remotes/git-svn.
+Fetch unfetched revisions from the Subversion URL we are
+tracking.  refs/remotes/git-svn will be updated to the
+latest revision.
 
-	See 'Additional Fetch Arguments' if you are interested in
-	manually joining branches on commit.
+Note: You should never attempt to modify the remotes/git-svn
+branch outside of git-svn.  Instead, create a branch from
+remotes/git-svn and work on that branch.  Use the 'commit'
+command (see below) to write git commits back to
+remotes/git-svn.
 
-commit::
+See '<<fetch-args,Additional Fetch Arguments>>' if you are interested in
+manually joining branches on commit.
+
+'commit'::
 	Commit specified commit or tree objects to SVN.  This relies on
 	your imported fetch data being up-to-date.  This makes
 	absolutely no attempts to do patching when committing to SVN, it
@@ -61,9 +62,9 @@ commit::
 	commit.  All merging is assumed to have taken place
 	independently of git-svn functions.
 
-rebuild::
+'rebuild'::
 	Not a part of daily usage, but this is a useful command if
-	you've just cloned a repository (using git-clone) that was
+	you've just cloned a repository (using gitlink:git-clone[1]) that was
 	tracked with git-svn.  Unfortunately, git-clone does not clone
 	git-svn metadata and the svn working tree that git-svn uses for
 	its operations.  This rebuilds the metadata so git-svn can
@@ -71,130 +72,152 @@ rebuild::
 	specified at the command-line if the directory/repository you're
 	tracking has moved or changed protocols.
 
-show-ignore::
+'show-ignore'::
 	Recursively finds and lists the svn:ignore property on
 	directories.  The output is suitable for appending to
 	the $GIT_DIR/info/exclude file.
 
+--
+
 OPTIONS
 -------
+--
+
 -r <ARG>::
 --revision <ARG>::
-	Only used with the 'fetch' command.
 
-	Takes any valid -r<argument> svn would accept and passes it
-	directly to svn. -r<ARG1>:<ARG2> ranges and "{" DATE "}" syntax
-	is also supported.  This is passed directly to svn, see svn
-	documentation for more details.
+Only used with the 'fetch' command.
 
-	This can allow you to make partial mirrors when running fetch.
+Takes any valid -r<argument> svn would accept and passes it
+directly to svn. -r<ARG1>:<ARG2> ranges and "{" DATE "}" syntax
+is also supported.  This is passed directly to svn, see svn
+documentation for more details.
+				
+This can allow you to make partial mirrors when running fetch.
 
 -::
 --stdin::
-	Only used with the 'commit' command.
 
-	Read a list of commits from stdin and commit them in reverse
-	order.  Only the leading sha1 is read from each line, so
-	git-rev-list --pretty=oneline output can be used.
+Only used with the 'commit' command.
+
+Read a list of commits from stdin and commit them in reverse
+order.  Only the leading sha1 is read from each line, so
+git-rev-list --pretty=oneline output can be used.
 
 --rmdir::
-	Only used with the 'commit' command.
 
-	Remove directories from the SVN tree if there are no files left
-	behind.  SVN can version empty directories, and they are not
-	removed by default if there are no files left in them.  git
-	cannot version empty directories.  Enabling this flag will make
-	the commit to SVN act like git.
+Only used with the 'commit' command.
 
-	repo-config key: svn.rmdir
+Remove directories from the SVN tree if there are no files left
+behind.  SVN can version empty directories, and they are not
+removed by default if there are no files left in them.  git
+cannot version empty directories.  Enabling this flag will make
+the commit to SVN act like git.
+
+repo-config key: svn.rmdir
 
 -e::
 --edit::
-	Only used with the 'commit' command.
 
-	Edit the commit message before committing to SVN.  This is off by
-	default for objects that are commits, and forced on when committing
-	tree objects.
+Only used with the 'commit' command.
+
+Edit the commit message before committing to SVN.  This is off by
+default for objects that are commits, and forced on when committing
+tree objects.
 
-	repo-config key: svn.edit
+repo-config key: svn.edit
 
 -l<num>::
 --find-copies-harder::
-	Both of these are only used with the 'commit' command.
 
-	They are both passed directly to git-diff-tree see
-	git-diff-tree(1) for more information.
+Both of these are only used with the 'commit' command.
 
-	repo-config key: svn.l
-	repo-config key: svn.findcopiesharder
+They are both passed directly to git-diff-tree see
+gitlink:git-diff-tree[1] for more information.
+
+[verse]
+repo-config key: svn.l 
+repo-config key: svn.findcopiesharder
 
 -A<filename>::
 --authors-file=<filename>::
 
-	Syntax is compatible with the files used by git-svnimport and
-	git-cvsimport:
+Syntax is compatible with the files used by git-svnimport and
+git-cvsimport:
 
 ------------------------------------------------------------------------
-loginname = Joe User <user@example.com>
+	loginname = Joe User <user@example.com>
 ------------------------------------------------------------------------
 
-	If this option is specified and git-svn encounters an SVN
-	committer name that does not exist in the authors-file, git-svn
-	will abort operation. The user will then have to add the
-	appropriate entry.  Re-running the previous git-svn command
-	after the authors-file is modified should continue operation.
+If this option is specified and git-svn encounters an SVN
+committer name that does not exist in the authors-file, git-svn
+will abort operation. The user will then have to add the
+appropriate entry.  Re-running the previous git-svn command
+after the authors-file is modified should continue operation.
+
+repo-config key: svn.authors-file
 
-	repo-config key: svn.authors-file
+--
 
 ADVANCED OPTIONS
 ----------------
+--
+
 -b<refname>::
 --branch <refname>::
-	Used with 'fetch' or 'commit'.
+Used with 'fetch' or 'commit'.
 
-	This can be used to join arbitrary git branches to remotes/git-svn
-	on new commits where the tree object is equivalent.
+This can be used to join arbitrary git branches to remotes/git-svn
+on new commits where the tree object is equivalent.
 
-	When used with different GIT_SVN_ID values, tags and branches in
-	SVN can be tracked this way, as can some merges where the heads
-	end up having completely equivalent content.  This can even be
-	used to track branches across multiple SVN _repositories_.
+When used with different GIT_SVN_ID values, tags and branches in
+SVN can be tracked this way, as can some merges where the heads
+end up having completely equivalent content.  This can even be
+used to track branches across multiple SVN _repositories_.
 
-	This option may be specified multiple times, once for each
-	branch.
+This option may be specified multiple times, once for each
+branch.
 
-	repo-config key: svn.branch
+repo-config key: svn.branch
 
 -i<GIT_SVN_ID>::
 --id <GIT_SVN_ID>::
-	This sets GIT_SVN_ID (instead of using the environment).  See
-	the section on "Tracking Multiple Repositories or Branches" for
-	more information on using GIT_SVN_ID.
+
+This sets GIT_SVN_ID (instead of using the environment).  See the
+section on
+'<<tracking-multiple-repos,Tracking Multiple Repositories or Branches>>'
+for more information on using GIT_SVN_ID.
+
+--
 
 COMPATIBILITY OPTIONS
 ---------------------
+--
+
 --upgrade::
-	Only used with the 'rebuild' command.
+Only used with the 'rebuild' command.
 
-	Run this if you used an old version of git-svn that used
-	"git-svn-HEAD" instead of "remotes/git-svn" as the branch
-	for tracking the remote.
+Run this if you used an old version of git-svn that used
+"git-svn-HEAD" instead of "remotes/git-svn" as the branch
+for tracking the remote.
 
 --no-ignore-externals::
-	Only used with the 'fetch' and 'rebuild' command.
+Only used with the 'fetch' and 'rebuild' command.
+
+By default, git-svn passes --ignore-externals to svn to avoid
+fetching svn:external trees into git.  Pass this flag to enable
+externals tracking directly via git.
 
-	By default, git-svn passes --ignore-externals to svn to avoid
-	fetching svn:external trees into git.  Pass this flag to enable
-	externals tracking directly via git.
+Versions of svn that do not support --ignore-externals are
+automatically detected and this flag will be automatically
+enabled for them.
 
-	Versions of svn that do not support --ignore-externals are
-	automatically detected and this flag will be automatically
-	enabled for them.
+Otherwise, do not enable this flag unless you know what you're
+doing.
 
-	Otherwise, do not enable this flag unless you know what you're
-	doing.
+repo-config key: svn.noignoreexternals
 
-	repo-config key: svn.noignoreexternals
+--
 
 Basic Examples
 ~~~~~~~~~~~~~~
@@ -226,6 +249,7 @@ any automated merge/branch tracking on t
 entirely up to the user on the git side.  It's simply not worth it to do
 a useful translation when the original signal is weak.
 
+[[tracking-multiple-repos]]
 TRACKING MULTIPLE REPOSITORIES OR BRANCHES
 ------------------------------------------
 This is for advanced users, most users should ignore this section.
@@ -241,6 +265,7 @@ invocation.  The interface branch will b
 remotes/git-svn.  Any remotes/$GIT_SVN_ID branch should never be modified
 by the user outside of git-svn commands.
 
+[[fetch-args]]
 ADDITIONAL FETCH ARGUMENTS
 --------------------------
 This is for advanced users, most users should ignore this section.
@@ -251,11 +276,15 @@ optionally be specified in the form of s
 command-line.  Unfetched SVN revisions may also be tied to particular
 git commits with the following syntax:
 
+------------------------------------------------
 	svn_revision_number=git_commit_sha1
+------------------------------------------------
 
-This allows you to tie unfetched SVN revision 375 to your current HEAD::
+This allows you to tie unfetched SVN revision 375 to your current HEAD:
 
-	`git-svn fetch 375=$(git-rev-parse HEAD)`
+------------------------------------------------
+	git-svn fetch 375=$(git-rev-parse HEAD)
+------------------------------------------------
 
 Advanced Example: Tracking a Reorganized Repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
1.4.2.GIT

-- 
Jonas Fonseca
