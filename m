From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] Documentation: convert tutorials to man pages
Date: Thu, 8 May 2008 15:49:52 +0200
Message-ID: <20080508154952.10e90e2f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 15:46:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju6Rd-0002Pw-Co
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 15:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbYEHNpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 09:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbYEHNpK
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 09:45:10 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:49206 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbYEHNpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 09:45:07 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id C641E1AB2EF;
	Thu,  8 May 2008 15:45:02 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id CAF691AB2D0;
	Thu,  8 May 2008 15:45:00 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81527>

This patch renames the following documents and at the same time converts
them to the man page format:

cvs-migration.txt -> gitcvs-migration.txt
tutorial.txt      -> gittutorial.txt
tutorial-2.txt    -> gittutorial-2.txt

Other documents that reference the above ones are change accordingly.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/Makefile                             |    8 +--
 Documentation/core-tutorial.txt                    |    4 +-
 Documentation/git.txt                              |   12 ++--
 .../{cvs-migration.txt => gitcvs-migration.txt}    |   69 +++++++++++++-------
 .../{tutorial-2.txt => gittutorial-2.txt}          |   36 ++++++++--
 Documentation/{tutorial.txt => gittutorial.txt}    |   39 +++++++++--
 Documentation/user-manual.txt                      |   18 +++---
 7 files changed, 126 insertions(+), 60 deletions(-)
 rename Documentation/{cvs-migration.txt => gitcvs-migration.txt} (83%)
 rename Documentation/{tutorial-2.txt => gittutorial-2.txt} (96%)
 rename Documentation/{tutorial.txt => gittutorial.txt} (96%)

	I removed conversion of "everyday.txt" to man page from this patch.
	I will try it again in a latter patch.

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4144d1e..9750334 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -3,7 +3,8 @@ MAN1_TXT= \
 		$(wildcard git-*.txt)) \
 	gitk.txt
 MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt
-MAN7_TXT=git.txt gitcli.txt
+MAN7_TXT=git.txt gitcli.txt gittutorial.txt gittutorial-2.txt \
+	gitcvs-migration.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
@@ -11,10 +12,7 @@ MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
 
 DOC_HTML=$(MAN_HTML)
 
-ARTICLES = tutorial
-ARTICLES += tutorial-2
-ARTICLES += core-tutorial
-ARTICLES += cvs-migration
+ARTICLES = core-tutorial
 ARTICLES += diffcore
 ARTICLES += howto-index
 ARTICLES += repository-layout
diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 5a55312..b50b5dd 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -8,7 +8,7 @@ This tutorial explains how to use the "core" git programs to set up and
 work with a git repository.
 
 If you just need to use git as a revision control system you may prefer
-to start with link:tutorial.html[a tutorial introduction to git] or
+to start with linkgit:gittutorial[7][a tutorial introduction to git] or
 link:user-manual.html[the git user manual].
 
 However, an understanding of these low-level tools can be helpful if
@@ -1581,7 +1581,7 @@ suggested in the previous section may be new to you. You do not
 have to worry. git supports "shared public repository" style of
 cooperation you are probably more familiar with as well.
 
-See link:cvs-migration.html[git for CVS users] for the details.
+See linkgit:gitcvs-migration[7][git for CVS users] for the details.
 
 Bundling your work together
 ---------------------------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index adcd3e0..7c71b1d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -20,12 +20,12 @@ Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
 
-See this link:tutorial.html[tutorial] to get started, then see
-link:everyday.html[Everyday Git] for a useful minimum set of commands, and
-"man git-commandname" for documentation of each command.  CVS users may
-also want to read link:cvs-migration.html[CVS migration].  See
-link:user-manual.html[Git User's Manual] for a more in-depth
-introduction.
+See this linkgit:gittutorial[7][tutorial] to get started, then see
+link:everyday.html[Everyday Git] for a useful minimum set of
+commands, and "man git-commandname" for documentation of each command.
+CVS users may also want to read linkgit:gitcvs-migration[7][CVS
+migration].  See link:user-manual.html[Git User's Manual] for a more
+in-depth introduction.
 
 The COMMAND is either a name of a Git command (see below) or an alias
 as defined in the configuration file (see linkgit:git-config[1]).
diff --git a/Documentation/cvs-migration.txt b/Documentation/gitcvs-migration.txt
similarity index 83%
rename from Documentation/cvs-migration.txt
rename to Documentation/gitcvs-migration.txt
index 374bc87..700e616 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -1,14 +1,25 @@
-git for CVS users
-=================
+gitcvs-migration(7)
+===================
 
-Git differs from CVS in that every working tree contains a repository with
-a full copy of the project history, and no repository is inherently more
-important than any other.  However, you can emulate the CVS model by
-designating a single shared repository which people can synchronize with;
-this document explains how to do that.
+NAME
+----
+gitcvs-migration - git for CVS users
+
+SYNOPSIS
+--------
+git cvsimport *
+
+DESCRIPTION
+-----------
+
+Git differs from CVS in that every working tree contains a repository
+with a full copy of the project history, and no repository is
+inherently more important than any other.  However, you can emulate
+the CVS model by designating a single shared repository which people
+can synchronize with; this document explains how to do that.
 
 Some basic familiarity with git is required.  This
-link:tutorial.html[tutorial introduction to git] and the
+linkgit:gittutorial[7][tutorial introduction to git] and the
 link:glossary.html[git glossary] should be sufficient.
 
 Developing against a shared repository
@@ -30,19 +41,20 @@ $ git pull origin
 ------------------------------------------------
 
 which merges in any work that others might have done since the clone
-operation.  If there are uncommitted changes in your working tree, commit
-them first before running git pull.
+operation.  If there are uncommitted changes in your working tree,
+commit them first before running git pull.
 
 [NOTE]
 ================================
 The `pull` command knows where to get updates from because of certain
 configuration variables that were set by the first `git clone`
-command; see `git config -l` and the linkgit:git-config[1] man
-page for details.
+command; see `git config -l` and the linkgit:git-config[1] man page
+for details.
 ================================
 
-You can update the shared repository with your changes by first committing
-your changes, and then using the linkgit:git-push[1] command:
+You can update the shared repository with your changes by first
+committing your changes, and then using the linkgit:git-push[1]
+command:
 
 ------------------------------------------------
 $ git push origin master
@@ -71,12 +83,12 @@ Setting Up a Shared Repository
 
 We assume you have already created a git repository for your project,
 possibly created from scratch or from a tarball (see the
-link:tutorial.html[tutorial]), or imported from an already existing CVS
-repository (see the next section).
+linkgit:gittutorial[7][tutorial]), or imported from an already
+existing CVS repository (see the next section).
 
-Assume your existing repo is at /home/alice/myproject.  Create a new "bare"
-repository (a repository without a working tree) and fetch your project into
-it:
+Assume your existing repo is at /home/alice/myproject.  Create a new
+"bare" repository (a repository without a working tree) and fetch your
+project into it:
 
 ------------------------------------------------
 $ mkdir /pub/my-repo.git
@@ -136,12 +148,13 @@ Advanced Shared Repository Management
 -------------------------------------
 
 Git allows you to specify scripts called "hooks" to be run at certain
-points.  You can use these, for example, to send all commits to the shared
-repository to a mailing list.  See linkgit:githooks[5][Hooks used by git].
+points.  You can use these, for example, to send all commits to the
+shared repository to a mailing list.  See linkgit:githooks[5][Hooks
+used by git].
 
 You can enforce finer grained permissions using update hooks.  See
-link:howto/update-hook-example.txt[Controlling access to branches using
-update hooks].
+link:howto/update-hook-example.txt[Controlling access to branches
+using update hooks].
 
 Providing CVS Access to a git Repository
 ----------------------------------------
@@ -170,3 +183,13 @@ variants of this model.
 
 With a small group, developers may just pull changes from each other's
 repositories without the need for a central maintainer.
+
+SEE ALSO
+--------
+linkgit:gittutorial[7], linkgit:gittutorial-2[7],
+link:everyday.html[Everyday Git],
+link:user-manual.html[The Git User's Manual]
+
+GIT
+---
+Part of the linkgit:git[7] suite.
diff --git a/Documentation/tutorial-2.txt b/Documentation/gittutorial-2.txt
similarity index 96%
rename from Documentation/tutorial-2.txt
rename to Documentation/gittutorial-2.txt
index 7fac47d..c804989 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -1,8 +1,19 @@
-A tutorial introduction to git: part two
-========================================
+gittutorial-2(7)
+==============
 
-You should work through link:tutorial.html[A tutorial introduction to
-git] before reading this tutorial.
+NAME
+----
+gittutorial-2 - A tutorial introduction to git: part two
+
+SYNOPSIS
+--------
+git *
+
+DESCRIPTION
+-----------
+
+You should work through linkgit:gittutorial[7][A tutorial introduction
+to git] before reading this tutorial.
 
 The goal of this tutorial is to introduce two fundamental pieces of
 git's architecture--the object database and the index file--and to
@@ -387,14 +398,14 @@ What next?
 
 At this point you should know everything necessary to read the man
 pages for any of the git commands; one good place to start would be
-with the commands mentioned in link:everyday.html[Everyday git].  You
-should be able to find any unknown jargon in the
+with the commands mentioned in link:everyday.html[Everyday git].
+You should be able to find any unknown jargon in the
 link:glossary.html[Glossary].
 
 The link:user-manual.html[Git User's Manual] provides a more
 comprehensive introduction to git.
 
-The link:cvs-migration.html[CVS migration] document explains how to
+The linkgit:gitcvs-migration[7][CVS migration] document explains how to
 import a CVS repository into git, and shows how to use git in a
 CVS-like way.
 
@@ -404,3 +415,14 @@ link:howto-index.html[howtos].
 For git developers, the link:core-tutorial.html[Core tutorial] goes
 into detail on the lower-level git mechanisms involved in, for
 example, creating a new commit.
+
+SEE ALSO
+--------
+linkgit:gittutorial[7],
+linkgit:gitcvs-migration[7],
+link:everyday.html[Everyday git],
+link:user-manual.html[The Git User's Manual]
+
+GIT
+---
+Part of the linkgit:git[7] suite.
diff --git a/Documentation/tutorial.txt b/Documentation/gittutorial.txt
similarity index 96%
rename from Documentation/tutorial.txt
rename to Documentation/gittutorial.txt
index e2bbda5..4a15b05 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -1,12 +1,24 @@
-A tutorial introduction to git (for version 1.5.1 or newer)
-===========================================================
+gittutorial(7)
+==============
+
+NAME
+----
+gittutorial - A tutorial introduction to git (for version 1.5.1 or newer)
+
+SYNOPSIS
+--------
+git *
+
+DESCRIPTION
+-----------
 
 This tutorial explains how to import a new project into git, make
 changes to it, and share changes with other developers.
 
-If you are instead primarily interested in using git to fetch a project,
-for example, to test the latest version, you may prefer to start with
-the first two chapters of link:user-manual.html[The Git User's Manual].
+If you are instead primarily interested in using git to fetch a
+project, for example, to test the latest version, you may prefer to
+start with the first two chapters of link:user-manual.html[The Git
+User's Manual].
 
 First, note that you can get documentation for a command such as "git
 diff" with:
@@ -381,7 +393,7 @@ see linkgit:git-pull[1] for details.
 
 Git can also be used in a CVS-like mode, with a central repository
 that various users push changes to; see linkgit:git-push[1] and
-link:cvs-migration.html[git for CVS users].
+linkgit:gitcvs-migration[7][git for CVS users].
 
 Exploring history
 -----------------
@@ -560,7 +572,7 @@ is based:
     used to create commits, check out working directories, and
     hold the various trees involved in a merge.
 
-link:tutorial-2.html[Part two of this tutorial] explains the object
+linkgit:gittutorial-2[7][Part two of this tutorial] explains the object
 database, the index file, and a few other odds and ends that you'll
 need to make the most of git.
 
@@ -581,4 +593,15 @@ digressions that may be interesting at this point are:
 
   * link:everyday.html[Everyday GIT with 20 Commands Or So]
 
-  * link:cvs-migration.html[git for CVS users].
+  * linkgit:gitcvs-migration[7][git for CVS users].
+
+SEE ALSO
+--------
+linkgit:gittutorial-2[7],
+linkgit:gitcvs-migration[7],
+link:everyday.html[Everyday git],
+link:user-manual.html[The Git User's Manual]
+
+GIT
+---
+Part of the linkgit:git[7] suite.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e2db850..b2c4f2c 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1988,22 +1988,22 @@ way to publish a work-in-progress patch series, and it is an acceptable
 compromise as long as you warn other developers that this is how you
 intend to manage the branch.
 
-It's also possible for a push to fail in this way when other people have
-the right to push to the same repository.  In that case, the correct
-solution is to retry the push after first updating your work by either a
-pull or a fetch followed by a rebase; see the
+It's also possible for a push to fail in this way when other people
+have the right to push to the same repository.  In that case, the
+correct solution is to retry the push after first updating your work
+by either a pull or a fetch followed by a rebase; see the
 <<setting-up-a-shared-repository,next section>> and
-link:cvs-migration.html[git for CVS users] for more.
+linkgit:gitcvs-migration[7][git for CVS users] for more.
 
 [[setting-up-a-shared-repository]]
 Setting up a shared repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Another way to collaborate is by using a model similar to that
-commonly used in CVS, where several developers with special rights
-all push to and pull from a single shared repository.  See
-link:cvs-migration.html[git for CVS users] for instructions on how to
-set this up.
+commonly used in CVS, where several developers with special rights all
+push to and pull from a single shared repository.  See
+linkgit:gitcvs-migration[7][git for CVS users] for instructions on how
+to set this up.
 
 However, while there is nothing wrong with git's support for shared
 repositories, this mode of operation is not generally recommended,
-- 
1.5.5.1.273.g4b50
