From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: convert "glossary" and "core-tutorial" to
 man pages
Date: Sun, 4 May 2008 12:21:57 +0200
Message-ID: <20080504122157.ca98c75d.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>, Jeff
X-From: git-owner@vger.kernel.org Sun May 04 12:18:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsbI6-0001gB-0A
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 12:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbYEDKRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 06:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbYEDKRI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 06:17:08 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:53642 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322AbYEDKRG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 06:17:06 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 871A01AB2ED;
	Sun,  4 May 2008 12:17:04 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 676C31AB2D7;
	Sun,  4 May 2008 12:17:02 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81163>

This patch renames the following documents and at the same time converts
them to the man format:

core-tutorial.txt -> gitcore-tutorial.txt
glossary.txt      -> gitglossary.txt

But as the glossary is included in the user manual and as the new
gitglossary man page cannot be included as a whole in the user manual,
the actual glossary content is now in its own "glossary-content.txt"
new file. And this file is included by both the user manual and the
gitglossary man page.

Other documents that reference the above ones are changed accordingly
and sometimes improved a little too.
---
 Documentation/Makefile                             |    7 ++---
 Documentation/git.txt                              |   13 +++++++--
 .../{core-tutorial.txt => gitcore-tutorial.txt}    |   26 ++++++++++++++++---
 Documentation/gitcvs-migration.txt                 |    6 +++-
 Documentation/giteveryday.txt                      |    5 ++-
 Documentation/gitglossary.txt                      |   25 +++++++++++++++++++
 Documentation/gittutorial-2.txt                    |   11 ++++----
 Documentation/gittutorial.txt                      |    5 ++-
 .../{glossary.txt => glossary-content.txt}         |    3 --
 Documentation/user-manual.txt                      |    5 +++-
 10 files changed, 80 insertions(+), 26 deletions(-)
 rename Documentation/{core-tutorial.txt => gitcore-tutorial.txt} (99%)
 create mode 100644 Documentation/gitglossary.txt
 rename Documentation/{glossary.txt => glossary-content.txt} (99%)


	This is another patch to convert some help documents to
	man pages. It should apply on top of the previous ones.


diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9a8043f..5ec7bd8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -4,7 +4,8 @@ MAN1_TXT= \
 	gitk.txt
 MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt
 MAN7_TXT=git.txt gitcli.txt gittutorial.txt gittutorial-2.txt \
-	gitcvs-migration.txt giteveryday.txt
+	gitcvs-migration.txt giteveryday.txt gitcore-tutorial.txt \
+	gitglossary.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
@@ -12,12 +13,10 @@ MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
 
 DOC_HTML=$(MAN_HTML)
 
-ARTICLES = core-tutorial
-ARTICLES += diffcore
+ARTICLES = diffcore
 ARTICLES += howto-index
 ARTICLES += repository-layout
 ARTICLES += git-tools
-ARTICLES += glossary
 # with their own formatting rules.
 SP_ARTICLES = howto/revert-branch-rebase howto/using-merge-subtree user-manual
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1c3c56e..855e90e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -172,7 +172,7 @@ See the references above to get started using git.  The following is
 probably more detail than necessary for a first-time user.
 
 The link:user-manual.html#git-concepts[git concepts chapter of the
-user-manual] and the link:core-tutorial.html[Core tutorial] both provide
+user-manual] and the linkgit:gitcore-tutorial[7][Core tutorial] both provide
 introductions to the underlying git architecture.
 
 See also the link:howto-index.html[howto] documents for some useful
@@ -372,7 +372,7 @@ Higher level SCMs may provide and manage additional information in the
 
 Terminology
 -----------
-Please see the link:glossary.html[glossary] document.
+Please see the linkgit:gitglossary[7][glossary] document.
 
 
 Environment Variables
@@ -516,7 +516,7 @@ Discussion[[Discussion]]
 
 More detail on the following is available from the
 link:user-manual.html#git-concepts[git concepts chapter of the
-user-manual] and the link:core-tutorial.html[Core tutorial].
+user-manual] and the linkgit:gitcore-tutorial[7][Core tutorial].
 
 A git project normally consists of a working directory with a ".git"
 subdirectory at the top level.  The .git directory contains, among other
@@ -577,6 +577,13 @@ The documentation for git suite was started by David Greaves
 <david@dgreaves.com>, and later enhanced greatly by the
 contributors on the git-list <git@vger.kernel.org>.
 
+SEE ALSO
+--------
+linkgit:gittutorial[7], linkgit:gittutorial-2[7],
+linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
+linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
+link:user-manual.html[The Git User's Manual]
+
 GIT
 ---
 Part of the linkgit:git[7] suite
diff --git a/Documentation/core-tutorial.txt b/Documentation/gitcore-tutorial.txt
similarity index 99%
rename from Documentation/core-tutorial.txt
rename to Documentation/gitcore-tutorial.txt
index b50b5dd..5995a2e 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1,8 +1,16 @@
-A git core tutorial for developers
-==================================
+gitcore-tutorial(7)
+===================
 
-Introduction
-------------
+NAME
+----
+gitcore-tutorial - A git core tutorial for developers
+
+SYNOPSIS
+--------
+git *
+
+DESCRIPTION
+-----------
 
 This tutorial explains how to use the "core" git programs to set up and
 work with a git repository.
@@ -1679,3 +1687,13 @@ merge two at a time, documenting how you resolved the conflicts,
 and the reason why you preferred changes made in one side over
 the other.  Otherwise it would make the project history harder
 to follow, not easier.
+
+SEE ALSO
+--------
+linkgit:gittutorial[7], linkgit:gittutorial-2[7],
+linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
+link:user-manual.html[The Git User's Manual]
+
+GIT
+---
+Part of the linkgit:git[7] suite.
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 4e5ea33..3eaf4b8 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -20,7 +20,7 @@ can synchronize with; this document explains how to do that.
 
 Some basic familiarity with git is required.  This
 linkgit:gittutorial[7][tutorial introduction to git] and the
-link:glossary.html[git glossary] should be sufficient.
+linkgit:gitglossary[7][git glossary] should be sufficient.
 
 Developing against a shared repository
 --------------------------------------
@@ -187,7 +187,9 @@ repositories without the need for a central maintainer.
 SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-linkgit:giteveryday[7], link:user-manual.html[The Git User's Manual]
+linkgit:giteveryday[7], linkgit:gitcore-tutorial[7],
+linkgit:gitglossary[7],
+link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index d7c3a35..6b33242 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -474,8 +474,9 @@ ftp> cp -r .git /home/user/myproject.git
 SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-linkgit:gitcvs-migration[7], link:user-manual.html[The Git User's
-Manual]
+linkgit:gitcvs-migration[7], linkgit:gitcore-tutorial[7],
+linkgit:gitglossary[7],
+link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.txt
new file mode 100644
index 0000000..e8475a0
--- /dev/null
+++ b/Documentation/gitglossary.txt
@@ -0,0 +1,25 @@
+gitglossary(7)
+==============
+
+NAME
+----
+gitglossary - A GIT Glossary
+
+SYNOPSIS
+--------
+*
+
+DESCRIPTION
+-----------
+
+include::glossary-content.txt[]
+
+SEE ALSO
+--------
+linkgit:gittutorial[7], linkgit:gittutorial-2[7],
+linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
+link:user-manual.html[The Git User's Manual]
+
+GIT
+---
+Part of the linkgit:git[7] suite.
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 4af9073..c7f59bd 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -390,7 +390,7 @@ in the index file is identical to the one in the working directory.
 In addition to being the staging area for new commits, the index file
 is also populated from the object database when checking out a
 branch, and is used to hold the trees involved in a merge operation.
-See the link:core-tutorial.html[core tutorial] and the relevant man
+See the linkgit:gitcore-tutorial[7][core tutorial] and the relevant man
 pages for details.
 
 What next?
@@ -400,7 +400,7 @@ At this point you should know everything necessary to read the man
 pages for any of the git commands; one good place to start would be
 with the commands mentioned in linkgit:giteveryday[7][Everyday git].
 You should be able to find any unknown jargon in the
-link:glossary.html[Glossary].
+linkgit:gitglossary[7][Glossary].
 
 The link:user-manual.html[Git User's Manual] provides a more
 comprehensive introduction to git.
@@ -412,15 +412,16 @@ CVS-like way.
 For some interesting examples of git use, see the
 link:howto-index.html[howtos].
 
-For git developers, the link:core-tutorial.html[Core tutorial] goes
+For git developers, the linkgit:gitcore-tutorial[7][Core tutorial] goes
 into detail on the lower-level git mechanisms involved in, for
 example, creating a new commit.
 
 SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:giteveryday[7],
-linkgit:gitcvs-migration[7], link:user-manual.html[The Git User's
-Manual]
+linkgit:gitcvs-migration[7], linkgit:gitcore-tutorial[7],
+linkgit:gitglossary[7],
+link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 470f7f7..34469be 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -598,8 +598,9 @@ digressions that may be interesting at this point are:
 SEE ALSO
 --------
 linkgit:gittutorial-2[7], linkgit:giteveryday[7],
-linkgit:gitcvs-migration[7], link:user-manual.html[The Git User's
-Manual]
+linkgit:gitcvs-migration[7], linkgit:gitcore-tutorial[7],
+linkgit:gitglossary[7],
+link:user-manual.html[The Git User's Manual]
 
 GIT
 ---
diff --git a/Documentation/glossary.txt b/Documentation/glossary-content.txt
similarity index 99%
rename from Documentation/glossary.txt
rename to Documentation/glossary-content.txt
index 51b6353..f981fee 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary-content.txt
@@ -1,6 +1,3 @@
-GIT Glossary
-============
-
 [[def_alternate_object_database]]alternate object database::
 	Via the alternates mechanism, a <<def_repository,repository>>
 	can inherit part of its <<def_object_database,object database>>
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index b2c4f2c..a99489e 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4252,7 +4252,10 @@ You see, Git is actually the best tool to find out about the source of Git
 itself!
 
 [[glossary]]
-include::glossary.txt[]
+GIT Glossary
+============
+
+include::glossary-content.txt[]
 
 [[git-quick-start]]
 Appendix A: Git Quick Reference
-- 
1.5.5.1.124.g7e5fa.dirty
