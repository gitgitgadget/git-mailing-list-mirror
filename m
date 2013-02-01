From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] docs: convert "concept" manpages to git-*
Date: Fri, 1 Feb 2013 03:27:45 -0500
Message-ID: <20130201082744.GB25783@sigill.intra.peff.net>
References: <20130201082538.GA25674@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 09:28:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Byr-0000oc-TA
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 09:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900Ab3BAI1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 03:27:54 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55292 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639Ab3BAI1t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 03:27:49 -0500
Received: (qmail 19301 invoked by uid 107); 1 Feb 2013 08:29:12 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 03:29:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 03:27:45 -0500
Content-Disposition: inline
In-Reply-To: <20130201082538.GA25674@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215217>

The manpages for commands have always been spelled
"git-cmd". But "concept" manpages, like "gitrevisions" were
spelled without the dash. This is complex, and does not
actually buy anything. You might think it creates a separate
namespace for concepts and commands, but "git help foo" will
prefer the command form, meaning we must avoid such
conflicts anyway.

Let's just call everything git-*, which is simpler. This
patch renames the documentation files, updates the Makefile
to find them, and updates internal linkgit references to the
pages. It updates builtin/help.c so that users of "git help
foo" will not even notice the difference.

Users of external html links, or users who have trained
their fingers to type "man gitfoo" will notice the missing
pages. This patch does not install a "this page has moved"
placeholder, but that can easily be done on top.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/Makefile                             | 27 +++++++++--------
 Documentation/config.txt                           |  8 ++---
 Documentation/diff-options.txt                     |  4 +--
 Documentation/git-cat-file.txt                     |  2 +-
 Documentation/git-check-ref-format.txt             |  2 +-
 Documentation/git-cherry-pick.txt                  |  2 +-
 Documentation/{gitcli.txt => git-cli.txt}          |  8 ++---
 Documentation/git-commit.txt                       |  4 +--
 ...{gitcore-tutorial.txt => git-core-tutorial.txt} | 20 ++++++-------
 Documentation/git-credential-cache.txt             |  2 +-
 Documentation/git-credential-store.txt             |  4 +--
 .../{gitcredentials.txt => git-credentials.txt}    |  6 ++--
 ...{gitcvs-migration.txt => git-cvs-migration.txt} | 22 +++++++-------
 Documentation/git-cvsimport.txt                    |  2 +-
 Documentation/git-cvsserver.txt                    |  2 +-
 Documentation/git-diff.txt                         |  6 ++--
 .../{gitdiffcore.txt => git-diffcore.txt}          |  6 ++--
 Documentation/git-fast-import.txt                  |  2 +-
 Documentation/git-format-patch.txt                 |  2 +-
 Documentation/git-gc.txt                           |  2 +-
 .../{gitglossary.txt => git-glossary.txt}          | 12 ++++----
 Documentation/{githooks.txt => git-hooks.txt}      |  6 ++--
 Documentation/git-http-backend.txt                 |  2 +-
 Documentation/git-log.txt                          |  2 +-
 .../{gitnamespaces.txt => git-namespaces.txt}      |  6 ++--
 Documentation/git-push.txt                         |  2 +-
 Documentation/git-rebase.txt                       |  4 +--
 Documentation/git-receive-pack.txt                 |  2 +-
 Documentation/git-reflog.txt                       |  2 +-
 ...sitory-layout.txt => git-repository-layout.txt} | 10 +++----
 Documentation/git-rev-parse.txt                    |  2 +-
 Documentation/git-revert.txt                       |  2 +-
 .../{gitrevisions.txt => git-revisions.txt}        |  6 ++--
 Documentation/git-show-branch.txt                  |  2 +-
 Documentation/git-show-ref.txt                     |  2 +-
 Documentation/git-show.txt                         |  2 +-
 .../{gittutorial-2.txt => git-tutorial-2.txt}      | 24 +++++++--------
 .../{gittutorial.txt => git-tutorial.txt}          | 24 +++++++--------
 Documentation/git-update-server-info.txt           |  2 +-
 Documentation/git-upload-pack.txt                  |  2 +-
 .../{gitworkflows.txt => git-workflows.txt}        |  8 ++---
 Documentation/git.txt                              | 35 +++++++++++-----------
 Documentation/gitignore.txt                        |  2 +-
 Documentation/gitk.txt                             |  2 +-
 Documentation/gitweb.conf.txt                      |  2 +-
 Documentation/technical/api-credentials.txt        |  2 +-
 Documentation/user-manual.txt                      | 14 ++++-----
 builtin/help.c                                     |  4 +--
 48 files changed, 159 insertions(+), 159 deletions(-)
 rename Documentation/{gitcli.txt => git-cli.txt} (98%)
 rename Documentation/{gitcore-tutorial.txt => git-core-tutorial.txt} (99%)
 rename Documentation/{gitcredentials.txt => git-credentials.txt} (98%)
 rename Documentation/{gitcvs-migration.txt => git-cvs-migration.txt} (94%)
 rename Documentation/{gitdiffcore.txt => git-diffcore.txt} (99%)
 rename Documentation/{gitglossary.txt => git-glossary.txt} (61%)
 rename Documentation/{githooks.txt => git-hooks.txt} (99%)
 rename Documentation/{gitnamespaces.txt => git-namespaces.txt} (97%)
 rename Documentation/{gitrepository-layout.txt => git-repository-layout.txt} (97%)
 rename Documentation/{gitrevisions.txt => git-revisions.txt} (88%)
 rename Documentation/{gittutorial-2.txt => git-tutorial-2.txt} (96%)
 rename Documentation/{gittutorial.txt => git-tutorial.txt} (97%)
 rename Documentation/{gitworkflows.txt => git-workflows.txt} (99%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 8e7939f..552cc37 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,28 +1,29 @@ MAN5_TXT += gitweb.conf.txt
 MAN1_TXT += $(filter-out \
+		$(MAN5_TXT) $(MAN7_TXT) \
 		$(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt))
 MAN1_TXT += git.txt
 MAN1_TXT += gitk.txt
 MAN1_TXT += gitweb.txt
 
+MAN5_TXT += git-hooks.txt
+MAN5_TXT += git-repository-layout.txt
 MAN5_TXT += gitattributes.txt
-MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
 MAN5_TXT += gitmodules.txt
-MAN5_TXT += gitrepository-layout.txt
 MAN5_TXT += gitweb.conf.txt
 
-MAN7_TXT += gitcli.txt
-MAN7_TXT += gitcore-tutorial.txt
-MAN7_TXT += gitcredentials.txt
-MAN7_TXT += gitcvs-migration.txt
-MAN7_TXT += gitdiffcore.txt
-MAN7_TXT += gitglossary.txt
-MAN7_TXT += gitnamespaces.txt
-MAN7_TXT += gitrevisions.txt
-MAN7_TXT += gittutorial-2.txt
-MAN7_TXT += gittutorial.txt
-MAN7_TXT += gitworkflows.txt
+MAN7_TXT += git-cli.txt
+MAN7_TXT += git-core-tutorial.txt
+MAN7_TXT += git-credentials.txt
+MAN7_TXT += git-cvs-migration.txt
+MAN7_TXT += git-diffcore.txt
+MAN7_TXT += git-glossary.txt
+MAN7_TXT += git-namespaces.txt
+MAN7_TXT += git-revisions.txt
+MAN7_TXT += git-tutorial-2.txt
+MAN7_TXT += git-tutorial.txt
+MAN7_TXT += git-workflows.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
diff --git a/Documentation/config.txt b/Documentation/config.txt
index d7ec507..666c6ed 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -952,23 +952,23 @@ credential.<url>.*::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
 	storage to avoid prompting the user for the credentials. See
-	linkgit:gitcredentials[7] for details.
+	linkgit:git-credentials[7] for details.
 
 credential.useHttpPath::
 	When acquiring credentials, consider the "path" component of an http
 	or https URL to be important. Defaults to false. See
-	linkgit:gitcredentials[7] for more information.
+	linkgit:git-credentials[7] for more information.
 
 credential.username::
 	If no username is set for a network authentication, use this username
 	by default. See credential.<context>.* below, and
-	linkgit:gitcredentials[7].
+	linkgit:git-credentials[7].
 
 credential.<url>.*::
 	Any of the credential.* options above can be applied selectively to
 	some credentials. For example "credential.https://example.com.username"
 	would set the default username only for https connections to
-	example.com. See linkgit:gitcredentials[7] for details on how URLs are
+	example.com. See linkgit:git-credentials[7] for details on how URLs are
 	matched.
 
 include::diff-config.txt[]
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 39f2c50..562b0d4 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -366,7 +366,7 @@ ifndef::git-format-patch[]
 	Look for differences that introduce or remove an instance of
 	<string>. Note that this is different than the string simply
 	appearing in diff output; see the 'pickaxe' entry in
-	linkgit:gitdiffcore[7] for more details.
+	linkgit:git-diffcore[7] for more details.
 
 -G<regex>::
 	Look for differences whose added or removed line matches
@@ -481,4 +481,4 @@ For more detailed explanation on these common options, see also
 	Do not show any source or destination prefix.
 
 For more detailed explanation on these common options, see also
-linkgit:gitdiffcore[7].
+linkgit:git-diffcore[7].
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 2fb95bb..0f5b23a 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -27,7 +27,7 @@ OPTIONS
 <object>::
 	The name of the object to show.
 	For a more complete list of ways to spell object names, see
-	the "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
+	the "SPECIFYING REVISIONS" section in linkgit:git-revisions[7].
 
 -t::
 	Instead of the content, show the object type identified by
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 98009d1..d598044 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -59,7 +59,7 @@ unquoted (by mistake), and also avoids ambiguities in certain
 These rules make it easy for shell script based tools to parse
 reference names, pathname expansion by the shell when a reference name is used
 unquoted (by mistake), and also avoids ambiguities in certain
-reference name expressions (see linkgit:gitrevisions[7]):
+reference name expressions (see linkgit:git-revisions[7]):
 
 . A double-dot `..` is often used as in `ref1..ref2`, and in some
   contexts this notation means `^ref1 ref2` (i.e. not in
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index c205d23..c2822b4 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -44,7 +44,7 @@ OPTIONS
 <commit>...::
 	Commits to cherry-pick.
 	For a more complete list of ways to spell commits, see
-	linkgit:gitrevisions[7].
+	linkgit:git-revisions[7].
 	Sets of commits can be passed but no traversal is done by
 	default, as if the '--no-walk' option was specified, see
 	linkgit:git-rev-list[1]. Note that specifying a range will
diff --git a/Documentation/gitcli.txt b/Documentation/git-cli.txt
similarity index 98%
rename from Documentation/gitcli.txt
rename to Documentation/git-cli.txt
index 3bc1500..f59f3b6 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/git-cli.txt
@@ -1,13 +1,13 @@ SYNOPSIS
-gitcli(7)
-=========
+git-cli(7)
+==========
 
 NAME
 ----
-gitcli - git command line interface and conventions
+git-cli - git command line interface and conventions
 
 SYNOPSIS
 --------
-gitcli
+git *
 
 
 DESCRIPTION
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 41b27da..d8a5143 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -157,7 +157,7 @@ OPTIONS
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
-	See also linkgit:githooks[5].
+	See also linkgit:git-hooks[5].
 
 --allow-empty::
 	Usually recording a commit that has the exact same tree as its
@@ -420,7 +420,7 @@ This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
 HOOKS
 -----
 This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
-and `post-commit` hooks.  See linkgit:githooks[5] for more
+and `post-commit` hooks.  See linkgit:git-hooks[5] for more
 information.
 
 FILES
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/git-core-tutorial.txt
similarity index 99%
rename from Documentation/gitcore-tutorial.txt
rename to Documentation/git-core-tutorial.txt
index 5325c5a..1a07c92 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/git-core-tutorial.txt
@@ -1,9 +1,9 @@ NAME
-gitcore-tutorial(7)
-===================
+git-core-tutorial(7)
+====================
 
 NAME
 ----
-gitcore-tutorial - A git core tutorial for developers
+git-core-tutorial - A git core tutorial for developers
 
 SYNOPSIS
 --------
@@ -16,7 +16,7 @@ If you just need to use git as a revision control system you may prefer
 work with a git repository.
 
 If you just need to use git as a revision control system you may prefer
-to start with "A Tutorial Introduction to GIT" (linkgit:gittutorial[7]) or
+to start with "A Tutorial Introduction to GIT" (linkgit:git-tutorial[7]) or
 link:user-manual.html[the GIT User Manual].
 
 However, an understanding of these low-level tools can be helpful if
@@ -116,7 +116,7 @@ populating your tree.
 populating your tree.
 
 [NOTE]
-An advanced user may want to take a look at linkgit:gitrepository-layout[5]
+An advanced user may want to take a look at linkgit:git-repository-layout[5]
 after finishing this tutorial.
 
 You have now created your first git repository. Of course, since it's
@@ -970,7 +970,7 @@ are branch heads.  'master^' is the first parent of 'master'
 before the commit log message is a short name you can use to
 name the commit.  In the above example, 'master' and 'mybranch'
 are branch heads.  'master^' is the first parent of 'master'
-branch head.  Please see linkgit:gitrevisions[7] if you want to
+branch head.  Please see linkgit:git-revisions[7] if you want to
 see more complex cases.
 
 [NOTE]
@@ -1595,7 +1595,7 @@ cooperation you are probably more familiar with as well.
 have to worry. git supports "shared public repository" style of
 cooperation you are probably more familiar with as well.
 
-See linkgit:gitcvs-migration[7] for the details.
+See linkgit:git-cvs-migration[7] for the details.
 
 Bundling your work together
 ---------------------------
@@ -1696,9 +1696,9 @@ SEE ALSO
 
 SEE ALSO
 --------
-linkgit:gittutorial[7],
-linkgit:gittutorial-2[7],
-linkgit:gitcvs-migration[7],
+linkgit:git-tutorial[7],
+linkgit:git-tutorial-2[7],
+linkgit:git-cvs-migration[7],
 linkgit:git-help[1],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index eeff5fa..4a1c101 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -21,7 +21,7 @@ be used as a credential helper by other parts of git. See
 
 You probably don't want to invoke this command directly; it is meant to
 be used as a credential helper by other parts of git. See
-linkgit:gitcredentials[7] or `EXAMPLES` below.
+linkgit:git-credentials[7] or `EXAMPLES` below.
 
 OPTIONS
 -------
diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index b27c03c..6761191 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -24,7 +24,7 @@ be used as a credential helper by other parts of git. See
 
 You probably don't want to invoke this command directly; it is meant to
 be used as a credential helper by other parts of git. See
-linkgit:gitcredentials[7] or `EXAMPLES` below.
+linkgit:git-credentials[7] or `EXAMPLES` below.
 
 OPTIONS
 -------
@@ -67,7 +67,7 @@ username (if we already have one) match, then the password is returned
 credential-store will consider that context a pattern to match against
 each entry in the credentials file.  If the protocol, hostname, and
 username (if we already have one) match, then the password is returned
-to git. See the discussion of configuration in linkgit:gitcredentials[7]
+to git. See the discussion of configuration in linkgit:git-credentials[7]
 for more information.
 
 GIT
diff --git a/Documentation/gitcredentials.txt b/Documentation/git-credentials.txt
similarity index 98%
rename from Documentation/gitcredentials.txt
rename to Documentation/git-credentials.txt
index 7dfffc0..85aa1b6 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/git-credentials.txt
@@ -1,9 +1,9 @@ NAME
-gitcredentials(7)
-=================
+git-credentials(7)
+==================
 
 NAME
 ----
-gitcredentials - providing usernames and passwords to git
+git-credentials - providing usernames and passwords to git
 
 SYNOPSIS
 --------
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/git-cvs-migration.txt
similarity index 94%
rename from Documentation/gitcvs-migration.txt
rename to Documentation/git-cvs-migration.txt
index aeb0cdc..6adc45a 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/git-cvs-migration.txt
@@ -1,9 +1,9 @@ NAME
-gitcvs-migration(7)
-===================
+git-cvs-migration(7)
+====================
 
 NAME
 ----
-gitcvs-migration - git for CVS users
+git-cvs-migration - git for CVS users
 
 SYNOPSIS
 --------
@@ -20,8 +20,8 @@ Some basic familiarity with git is required. Having gone through
 this document explains how to do that.
 
 Some basic familiarity with git is required. Having gone through
-linkgit:gittutorial[7] and
-linkgit:gitglossary[7] should be sufficient.
+linkgit:git-tutorial[7] and
+linkgit:git-glossary[7] should be sufficient.
 
 Developing against a shared repository
 --------------------------------------
@@ -83,7 +83,7 @@ possibly created from scratch or from a tarball (see
 
 We assume you have already created a git repository for your project,
 possibly created from scratch or from a tarball (see
-linkgit:gittutorial[7]), or imported from an already existing CVS
+linkgit:git-tutorial[7]), or imported from an already existing CVS
 repository (see the next section).
 
 Assume your existing repo is at /home/alice/myproject.  Create a new "bare"
@@ -154,7 +154,7 @@ points.  You can use these, for example, to send all commits to the shared
 
 Git allows you to specify scripts called "hooks" to be run at certain
 points.  You can use these, for example, to send all commits to the shared
-repository to a mailing list.  See linkgit:githooks[5].
+repository to a mailing list.  See linkgit:git-hooks[5].
 
 You can enforce finer grained permissions using update hooks.  See
 link:howto/update-hook-example.txt[Controlling access to branches using
@@ -190,10 +190,10 @@ SEE ALSO
 
 SEE ALSO
 --------
-linkgit:gittutorial[7],
-linkgit:gittutorial-2[7],
-linkgit:gitcore-tutorial[7],
-linkgit:gitglossary[7],
+linkgit:git-tutorial[7],
+linkgit:git-tutorial-2[7],
+linkgit:git-core-tutorial[7],
+linkgit:git-glossary[7],
 link:everyday.html[Everyday Git],
 link:user-manual.html[The Git User's Manual]
 
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 9d5353e..ac2cfbf 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -38,7 +38,7 @@ and use the clone as the shared repository.
 read/write, or if you want to use linkgit:git-cvsserver[1], then you
 probably want to make a bare clone of the imported repository,
 and use the clone as the shared repository.
-See linkgit:gitcvs-migration[7].
+See linkgit:git-cvs-migration[7].
 
 
 OPTIONS
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 940c2ba..895c191 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -163,7 +163,7 @@ You also need to ensure that each repository is "bare" (without a git index
 SSH, the users of course also need write access to the git repository itself.
 
 You also need to ensure that each repository is "bare" (without a git index
-file) for `cvs commit` to work. See linkgit:gitcvs-migration[7].
+file) for `cvs commit` to work. See linkgit:git-cvs-migration[7].
 
 [[configaccessmethod]]
 All configuration variables can also be overridden for a specific method of
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index f8c0601..7c89f0d 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -81,11 +81,11 @@ and the range notations ("<commit>..<commit>" and
 <tree>.
 
 For a more complete list of ways to spell <commit>, see
-"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
+"SPECIFYING REVISIONS" section in linkgit:git-revisions[7].
 However, "diff" is about comparing two _endpoints_, not ranges,
 and the range notations ("<commit>..<commit>" and
 "<commit>\...<commit>") do not mean a range as defined in the
-"SPECIFYING RANGES" section in linkgit:gitrevisions[7].
+"SPECIFYING RANGES" section in linkgit:git-revisions[7].
 
 OPTIONS
 -------
@@ -175,7 +175,7 @@ linkgit:git-log[1],
 diff(1),
 linkgit:git-difftool[1],
 linkgit:git-log[1],
-linkgit:gitdiffcore[7],
+linkgit:git-diffcore[7],
 linkgit:git-format-patch[1],
 linkgit:git-apply[1]
 
diff --git a/Documentation/gitdiffcore.txt b/Documentation/git-diffcore.txt
similarity index 99%
rename from Documentation/gitdiffcore.txt
rename to Documentation/git-diffcore.txt
index daf1782..9dfdce8 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/git-diffcore.txt
@@ -1,9 +1,9 @@ NAME
-gitdiffcore(7)
+git-diffcore(7)
 ==============
 
 NAME
 ----
-gitdiffcore - Tweaking diff output
+git-diffcore - Tweaking diff output
 
 SYNOPSIS
 --------
@@ -274,7 +274,7 @@ linkgit:git-log[1],
 linkgit:git-diff-tree[1],
 linkgit:git-format-patch[1],
 linkgit:git-log[1],
-linkgit:gitglossary[7],
+linkgit:git-glossary[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index bf1a02a..6b7d33a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -481,7 +481,7 @@ Marks must be declared (via `mark`) before they can be used.
 * A complete 40 byte or abbreviated commit SHA-1 in hex.
 
 * Any valid Git SHA-1 expression that resolves to a commit.  See
-  ``SPECIFYING REVISIONS'' in linkgit:gitrevisions[7] for details.
+  ``SPECIFYING REVISIONS'' in linkgit:git-revisions[7] for details.
 
 The special case of restarting an incremental import from the
 current branch value should be written as:
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 9a914d0..70d7cbf 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -39,7 +39,7 @@ There are two ways to specify which commits to operate on.
    that leads to the <since> to be output.
 
 2. Generic <revision range> expression (see "SPECIFYING
-   REVISIONS" section in linkgit:gitrevisions[7]) means the
+   REVISIONS" section in linkgit:git-revisions[7]) means the
    commits in the specified range.
 
 The first rule takes precedence in the case of a single <commit>.  To
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index b370b02..f54f8c4 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -142,7 +142,7 @@ The 'git gc --auto' command will run the 'pre-auto-gc' hook.  See
 -----
 
 The 'git gc --auto' command will run the 'pre-auto-gc' hook.  See
-linkgit:githooks[5] for more information.
+linkgit:git-hooks[5] for more information.
 
 
 SEE ALSO
diff --git a/Documentation/gitglossary.txt b/Documentation/git-glossary.txt
similarity index 61%
rename from Documentation/gitglossary.txt
rename to Documentation/git-glossary.txt
index d77a45a..c8157fe 100644
--- a/Documentation/gitglossary.txt
+++ b/Documentation/git-glossary.txt
@@ -1,9 +1,9 @@ NAME
-gitglossary(7)
-==============
+git-glossary(7)
+===============
 
 NAME
 ----
-gitglossary - A GIT Glossary
+git-glossary - A GIT Glossary
 
 SYNOPSIS
 --------
@@ -16,9 +16,9 @@ SEE ALSO
 
 SEE ALSO
 --------
-linkgit:gittutorial[7],
-linkgit:gittutorial-2[7],
-linkgit:gitcvs-migration[7],
+linkgit:git-tutorial[7],
+linkgit:git-tutorial-2[7],
+linkgit:git-cvs-migration[7],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
 
diff --git a/Documentation/githooks.txt b/Documentation/git-hooks.txt
similarity index 99%
rename from Documentation/githooks.txt
rename to Documentation/git-hooks.txt
index d839233..7a3bc3b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/git-hooks.txt
@@ -1,9 +1,9 @@ NAME
-githooks(5)
-===========
+git-hooks(5)
+============
 
 NAME
 ----
-githooks - Hooks used by git
+git-hooks - Hooks used by git
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index f4e0741..a0ffb25 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -120,7 +120,7 @@ ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ----------------------------------------------------------------
 +
-To serve multiple repositories from different linkgit:gitnamespaces[7] in a
+To serve multiple repositories from different linkgit:git-namespaces[7] in a
 single repository:
 +
 ----------------------------------------------------------------
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 22c0d6e..79000d4 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -29,7 +29,7 @@ OPTIONS
 	either <since> or <until> is omitted, it defaults to
 	`HEAD`, i.e. the tip of the current branch.
 	For a more complete list of ways to spell <since>
-	and <until>, see linkgit:gitrevisions[7].
+	and <until>, see linkgit:git-revisions[7].
 
 --follow::
 	Continue listing the history of a file beyond renames
diff --git a/Documentation/gitnamespaces.txt b/Documentation/git-namespaces.txt
similarity index 97%
rename from Documentation/gitnamespaces.txt
rename to Documentation/git-namespaces.txt
index c6713cf..a031ee7 100644
--- a/Documentation/gitnamespaces.txt
+++ b/Documentation/git-namespaces.txt
@@ -1,9 +1,9 @@ NAME
-gitnamespaces(7)
-================
+git-namespaces(7)
+=================
 
 NAME
 ----
-gitnamespaces - Git namespaces
+git-namespaces - Git namespaces
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index c964b79..c78469c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -43,7 +43,7 @@ it can be any arbitrary "SHA-1 expression", such as `master~4` or
 +
 The <src> is often the name of the branch you would want to push, but
 it can be any arbitrary "SHA-1 expression", such as `master~4` or
-`HEAD` (see linkgit:gitrevisions[7]).
+`HEAD` (see linkgit:git-revisions[7]).
 +
 The <dst> tells which ref on the remote side is updated with this
 push. Arbitrary expressions cannot be used here, an actual ref must
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index da067ec..ee5837c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -295,11 +295,11 @@ which makes little sense.
 	Do not show a diffstat as part of the rebase process.
 
 --no-verify::
-	This option bypasses the pre-rebase hook.  See also linkgit:githooks[5].
+	This option bypasses the pre-rebase hook.  See also linkgit:git-hooks[5].
 
 --verify::
 	Allows the pre-rebase hook to run, which is the default.  This option can
-	be used to override --no-verify.  See also linkgit:githooks[5].
+	be used to override --no-verify.  See also linkgit:git-hooks[5].
 
 -C<n>::
 	Ensure at least <n> lines of surrounding context match before
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index b1f7dc6..905a186 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -150,7 +150,7 @@ SEE ALSO
 
 SEE ALSO
 --------
-linkgit:git-send-pack[1], linkgit:gitnamespaces[7]
+linkgit:git-send-pack[1], linkgit:git-namespaces[7]
 
 GIT
 ---
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 7fe2d22..a12f63b 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -41,7 +41,7 @@ two moves ago", `master@{one.week.ago}` means "where master used to
 The reflog is useful in various git commands, to specify the old value
 of a reference. For example, `HEAD@{2}` means "where HEAD used to be
 two moves ago", `master@{one.week.ago}` means "where master used to
-point to one week ago", and so on. See linkgit:gitrevisions[7] for
+point to one week ago", and so on. See linkgit:git-revisions[7] for
 more details.
 
 To delete single entries from the reflog, use the subcommand "delete"
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git-repository-layout.txt
similarity index 97%
rename from Documentation/gitrepository-layout.txt
rename to Documentation/git-repository-layout.txt
index 9f62886..7602980 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/git-repository-layout.txt
@@ -1,9 +1,9 @@ NAME
-gitrepository-layout(5)
-=======================
+git-repository-layout(5)
+========================
 
 NAME
 ----
-gitrepository-layout - Git Repository Layout
+git-repository-layout - Git Repository Layout
 
 SYNOPSIS
 --------
@@ -136,7 +136,7 @@ hooks::
 	'git init' is run, but all of them are disabled by
 	default.  To enable, the `.sample` suffix has to be
 	removed from the filename by renaming.
-	Read linkgit:githooks[5] for more details about
+	Read linkgit:git-hooks[5] for more details about
 	each hook.
 
 index::
@@ -203,7 +203,7 @@ linkgit:git-checkout[1],
 linkgit:git-pack-refs[1],
 linkgit:git-gc[1],
 linkgit:git-checkout[1],
-linkgit:gitglossary[7],
+linkgit:git-glossary[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 3c63561..ce9cee4 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -236,7 +236,7 @@ Each line of options has this format:
 
 	* Use `*` to mean that this option should not be listed in the usage
 	  generated for the `-h` argument. It's shown for `--help-all` as
-	  documented in linkgit:gitcli[7].
+	  documented in linkgit:git-cli[7].
 
 	* Use `!` to not make the corresponding negated long option available.
 
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 70152e8..b6e3a48 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -35,7 +35,7 @@ OPTIONS
 <commit>...::
 	Commits to revert.
 	For a more complete list of ways to spell commit names, see
-	linkgit:gitrevisions[7].
+	linkgit:git-revisions[7].
 	Sets of commits can also be given but no traversal is done by
 	default, see linkgit:git-rev-list[1] and its '--no-walk'
 	option.
diff --git a/Documentation/gitrevisions.txt b/Documentation/git-revisions.txt
similarity index 88%
rename from Documentation/gitrevisions.txt
rename to Documentation/git-revisions.txt
index fc4789f..3bf4531 100644
--- a/Documentation/gitrevisions.txt
+++ b/Documentation/git-revisions.txt
@@ -1,13 +1,13 @@ SYNOPSIS
-gitrevisions(7)
+git-revisions(7)
 ================
 
 NAME
 ----
-gitrevisions - specifying revisions and ranges for git
+git-revisions - specifying revisions and ranges for git
 
 SYNOPSIS
 --------
-gitrevisions
+git-revisions
 
 
 DESCRIPTION
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index a8e77b5..d5c27f7 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -31,7 +31,7 @@ OPTIONS
 OPTIONS
 -------
 <rev>::
-	Arbitrary extended SHA1 expression (see linkgit:gitrevisions[7])
+	Arbitrary extended SHA1 expression (see linkgit:git-revisions[7])
 	that typically names a branch head or a tag.
 
 <glob>::
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 5dbcd47..ca28bc7 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -175,7 +175,7 @@ linkgit:git-update-ref[1],
 --------
 linkgit:git-ls-remote[1],
 linkgit:git-update-ref[1],
-linkgit:gitrepository-layout[5]
+linkgit:git-repository-layout[5]
 
 GIT
 ---
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index ae4edcc..81bd45e 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -37,7 +37,7 @@ OPTIONS
 <object>...::
 	The names of objects to show.
 	For a more complete list of ways to spell object names, see
-	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
+	"SPECIFYING REVISIONS" section in linkgit:git-revisions[7].
 
 include::pretty-options.txt[]
 
diff --git a/Documentation/gittutorial-2.txt b/Documentation/git-tutorial-2.txt
similarity index 96%
rename from Documentation/gittutorial-2.txt
rename to Documentation/git-tutorial-2.txt
index e00a4d2..8ca2912 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/git-tutorial-2.txt
@@ -1,9 +1,9 @@ NAME
-gittutorial-2(7)
-================
+git-tutorial-2(7)
+=================
 
 NAME
 ----
-gittutorial-2 - A tutorial introduction to git: part two
+git-tutorial-2 - A tutorial introduction to git: part two
 
 SYNOPSIS
 --------
@@ -13,7 +13,7 @@ DESCRIPTION
 DESCRIPTION
 -----------
 
-You should work through linkgit:gittutorial[7] before reading this tutorial.
+You should work through linkgit:git-tutorial[7] before reading this tutorial.
 
 The goal of this tutorial is to introduce two fundamental pieces of
 git's architecture--the object database and the index file--and to
@@ -395,7 +395,7 @@ branch, and is used to hold the trees involved in a merge operation.
 In addition to being the staging area for new commits, the index file
 is also populated from the object database when checking out a
 branch, and is used to hold the trees involved in a merge operation.
-See linkgit:gitcore-tutorial[7] and the relevant man
+See linkgit:git-core-tutorial[7] and the relevant man
 pages for details.
 
 What next?
@@ -404,28 +404,28 @@ SEE ALSO
 At this point you should know everything necessary to read the man
 pages for any of the git commands; one good place to start would be
 with the commands mentioned in link:everyday.html[Everyday git].  You
-should be able to find any unknown jargon in linkgit:gitglossary[7].
+should be able to find any unknown jargon in linkgit:git-glossary[7].
 
 The link:user-manual.html[Git User's Manual] provides a more
 comprehensive introduction to git.
 
-linkgit:gitcvs-migration[7] explains how to
+linkgit:git-cvs-migration[7] explains how to
 import a CVS repository into git, and shows how to use git in a
 CVS-like way.
 
 For some interesting examples of git use, see the
 link:howto-index.html[howtos].
 
-For git developers, linkgit:gitcore-tutorial[7] goes
+For git developers, linkgit:git-core-tutorial[7] goes
 into detail on the lower-level git mechanisms involved in, for
 example, creating a new commit.
 
 SEE ALSO
 --------
-linkgit:gittutorial[7],
-linkgit:gitcvs-migration[7],
-linkgit:gitcore-tutorial[7],
-linkgit:gitglossary[7],
+linkgit:git-tutorial[7],
+linkgit:git-cvs-migration[7],
+linkgit:git-core-tutorial[7],
+linkgit:git-glossary[7],
 linkgit:git-help[1],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
diff --git a/Documentation/gittutorial.txt b/Documentation/git-tutorial.txt
similarity index 97%
rename from Documentation/gittutorial.txt
rename to Documentation/git-tutorial.txt
index f1cb6f3..189d01f 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/git-tutorial.txt
@@ -1,9 +1,9 @@ NAME
-gittutorial(7)
-==============
+git-tutorial(7)
+===============
 
 NAME
 ----
-gittutorial - A tutorial introduction to git (for version 1.5.1 or newer)
+git-tutorial - A tutorial introduction to git (for version 1.5.1 or newer)
 
 SYNOPSIS
 --------
@@ -455,7 +455,7 @@ that various users push changes to; see linkgit:git-push[1] and
 
 Git can also be used in a CVS-like mode, with a central repository
 that various users push changes to; see linkgit:git-push[1] and
-linkgit:gitcvs-migration[7].
+linkgit:git-cvs-migration[7].
 
 Exploring history
 -----------------
@@ -636,7 +636,7 @@ database, the index file, and a few other odds and ends that you'll
 
 Part two of this tutorial explains the object
 database, the index file, and a few other odds and ends that you'll
-need to make the most of git. You can find it at linkgit:gittutorial-2[7].
+need to make the most of git. You can find it at linkgit:git-tutorial-2[7].
 
 If you don't want to continue with that right away, a few other
 digressions that may be interesting at this point are:
@@ -653,21 +653,21 @@ linkgit:git-help[1],
     smart enough to perform a close-to-optimal search even in the
     case of complex non-linear history with lots of merged branches.
 
-  * linkgit:gitworkflows[7]: Gives an overview of recommended
+  * linkgit:git-workflows[7]: Gives an overview of recommended
     workflows.
 
   * link:everyday.html[Everyday GIT with 20 Commands Or So]
 
-  * linkgit:gitcvs-migration[7]: Git for CVS users.
+  * linkgit:git-cvs-migration[7]: Git for CVS users.
 
 SEE ALSO
 --------
-linkgit:gittutorial-2[7],
-linkgit:gitcvs-migration[7],
-linkgit:gitcore-tutorial[7],
-linkgit:gitglossary[7],
+linkgit:git-tutorial-2[7],
+linkgit:git-cvs-migration[7],
+linkgit:git-core-tutorial[7],
+linkgit:git-glossary[7],
 linkgit:git-help[1],
-linkgit:gitworkflows[7],
+linkgit:git-workflows[7],
 link:everyday.html[Everyday git],
 link:user-manual.html[The Git User's Manual]
 
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index bd0e364..800ab5e 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -32,7 +32,7 @@ Currently the command updates the following files.  Please see
 ------
 
 Currently the command updates the following files.  Please see
-linkgit:gitrepository-layout[5] for description of
+linkgit:git-repository-layout[5] for description of
 what they are for:
 
 * objects/info/packs
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 71f1608..44b9219 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -36,7 +36,7 @@ SEE ALSO
 
 SEE ALSO
 --------
-linkgit:gitnamespaces[7]
+linkgit:git-namespaces[7]
 
 GIT
 ---
diff --git a/Documentation/gitworkflows.txt b/Documentation/git-workflows.txt
similarity index 99%
rename from Documentation/gitworkflows.txt
rename to Documentation/git-workflows.txt
index 8b8c6ae..8fe1c95 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/git-workflows.txt
@@ -1,9 +1,9 @@ NAME
-gitworkflows(7)
-===============
+git-workflows(7)
+================
 
 NAME
 ----
-gitworkflows - An overview of recommended workflows with git
+git-workflows - An overview of recommended workflows with git
 
 SYNOPSIS
 --------
@@ -466,7 +466,7 @@ SEE ALSO
 
 SEE ALSO
 --------
-linkgit:gittutorial[7],
+linkgit:git-tutorial[7],
 linkgit:git-push[1],
 linkgit:git-pull[1],
 linkgit:git-merge[1],
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 555250d..d9d7755 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -21,14 +21,14 @@ page to learn what commands git offers.  You can learn more about
 unusually rich command set that provides both high-level operations
 and full access to internals.
 
-See linkgit:gittutorial[7] to get started, then see
+See linkgit:git-tutorial[7] to get started, then see
 link:everyday.html[Everyday Git] for a useful minimum set of
 commands.  The link:user-manual.html[Git User's Manual] has a more
 in-depth introduction.
 
 After you mastered the basic concepts, you can come back to this
 page to learn what commands git offers.  You can learn more about
-individual git commands with "git help command".  linkgit:gitcli[7]
+individual git commands with "git help command".  linkgit:git-cli[7]
 manual page gives you an overview of the command line command syntax.
 
 Formatted and hyperlinked version of the latest git documentation
@@ -416,7 +416,7 @@ help ...`.
 	more detailed discussion).
 
 --namespace=<path>::
-	Set the git namespace.  See linkgit:gitnamespaces[7] for more
+	Set the git namespace.  See linkgit:git-namespaces[7] for more
 	details.  Equivalent to setting the `GIT_NAMESPACE` environment
 	variable.
 
@@ -611,15 +611,15 @@ Please see the linkgit:gitrepository-layout[5] document.
 	(i.e. a `refs/heads/<head>` reference).
 
 For a more complete list of ways to spell object names, see
-"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
+"SPECIFYING REVISIONS" section in linkgit:git-revisions[7].
 
 
 File/Directory Structure
 ------------------------
 
-Please see the linkgit:gitrepository-layout[5] document.
+Please see the linkgit:git-repository-layout[5] document.
 
-Read linkgit:githooks[5] for more details about each hook.
+Read linkgit:git-hooks[5] for more details about each hook.
 
 Higher level SCMs may provide and manage additional information in the
 `$GIT_DIR`.
@@ -627,7 +627,7 @@ Terminology
 
 Terminology
 -----------
-Please see linkgit:gitglossary[7].
+Please see linkgit:git-glossary[7].
 
 
 Environment Variables
@@ -672,7 +672,7 @@ git so take care if using Cogito etc.
 	option and the core.worktree configuration variable.
 
 'GIT_NAMESPACE'::
-	Set the git namespace; see linkgit:gitnamespaces[7] for details.
+	Set the git namespace; see linkgit:git-namespaces[7] for details.
 	The '--namespace' command-line option also sets this value.
 
 'GIT_CEILING_DIRECTORIES'::
@@ -825,7 +825,7 @@ link:user-manual.html#git-concepts[git concepts chapter of the
 
 More detail on the following is available from the
 link:user-manual.html#git-concepts[git concepts chapter of the
-user-manual] and linkgit:gitcore-tutorial[7].
+user-manual] and linkgit:git-core-tutorial[7].
 
 A git project normally consists of a working directory with a ".git"
 subdirectory at the top level.  The .git directory contains, among other
@@ -881,10 +881,10 @@ introductions to the underlying git architecture.
 for a first-time user.
 
 The link:user-manual.html#git-concepts[git concepts chapter of the
-user-manual] and linkgit:gitcore-tutorial[7] both provide
+user-manual] and linkgit:git-core-tutorial[7] both provide
 introductions to the underlying git architecture.
 
-See linkgit:gitworkflows[7] for an overview of recommended workflows.
+See linkgit:git-workflows[7] for an overview of recommended workflows.
 
 See also the link:howto-index.html[howto] documents for some useful
 examples.
@@ -893,7 +893,7 @@ Users migrating from CVS may also want to
 link:technical/api-index.html[GIT API documentation].
 
 Users migrating from CVS may also want to
-read linkgit:gitcvs-migration[7].
+read linkgit:git-cvs-migration[7].
 
 
 Authors
@@ -916,12 +916,13 @@ Part of the linkgit:git[1] suite
 
 SEE ALSO
 --------
-linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-link:everyday.html[Everyday Git], linkgit:gitcvs-migration[7],
-linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
-linkgit:gitcli[7], link:user-manual.html[The Git User's Manual],
-linkgit:gitworkflows[7]
+linkgit:git-tutorial[7], linkgit:git-tutorial-2[7],
+link:everyday.html[Everyday Git], linkgit:git-cvs-migration[7],
+linkgit:git-glossary[7], linkgit:git-core-tutorial[7],
+linkgit:git-cli[7], link:user-manual.html[The Git User's Manual],
+linkgit:git-workflows[7]
 
 GIT
 ---
 Part of the linkgit:git[1] suite
+
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 0da205f..5b6d396 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -186,7 +186,7 @@ linkgit:git-update-index[1],
 --------
 linkgit:git-rm[1],
 linkgit:git-update-index[1],
-linkgit:gitrepository-layout[5],
+linkgit:git-repository-layout[5],
 linkgit:git-check-ignore[1]
 
 GIT
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index a17a354..a931cb2 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -70,7 +70,7 @@ frequently used options.
 	the form "'<from>'..'<to>'" to show all revisions between '<from>' and
 	back to '<to>'. Note, more advanced revision selection can be applied.
 	For a more complete list of ways to spell object names, see
-	linkgit:gitrevisions[7].
+	linkgit:git-revisions[7].
 
 <path>...::
 
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 4947455..05a2384 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -676,7 +676,7 @@ description of `-S<string>` option, which refers to pickaxe entry in
 +
 The pickaxe search is described in linkgit:git-log[1] (the
 description of `-S<string>` option, which refers to pickaxe entry in
-linkgit:gitdiffcore[7] for more details).
+linkgit:git-diffcore[7] for more details).
 +
 This feature can be configured on a per-repository basis by setting
 repository's `gitweb.pickaxe` configuration variable (boolean).
diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 5977b58..642d570 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -263,6 +263,6 @@ See also
 See also
 --------
 
-linkgit:gitcredentials[7]
+linkgit:git-credentials[7]
 
 linkgit:git-config[5] (See configuration variables `credential.*`)
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1b377dc..0bde9b7 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -408,7 +408,7 @@ references with the same shorthand name, see the "SPECIFYING
 For the complete list of paths which git checks for references, and
 the order it uses to decide which to choose when there are multiple
 references with the same shorthand name, see the "SPECIFYING
-REVISIONS" section of linkgit:gitrevisions[7].
+REVISIONS" section of linkgit:git-revisions[7].
 
 [[Updating-a-repository-With-git-fetch]]
 Updating a repository with git fetch
@@ -579,7 +579,7 @@ There are many more; see the "SPECIFYING REVISIONS" section of the
 	- HEAD: refers to the head of the current branch
 
 There are many more; see the "SPECIFYING REVISIONS" section of the
-linkgit:gitrevisions[7] man page for the complete list of ways to
+linkgit:git-revisions[7] man page for the complete list of ways to
 name revisions.  Some examples:
 
 -------------------------------------------------
@@ -920,7 +920,7 @@ $ gitk $( git show-ref --heads ) --not  $( git show-ref --tags )
 $ gitk $( git show-ref --heads ) --not  $( git show-ref --tags )
 -------------------------------------------------
 
-(See linkgit:gitrevisions[7] for explanations of commit-selecting
+(See linkgit:git-revisions[7] for explanations of commit-selecting
 syntax such as `--not`.)
 
 [[making-a-release]]
@@ -1651,7 +1651,7 @@ how to control this pruning, and see the "SPECIFYING REVISIONS"
 The reflogs are kept by default for 30 days, after which they may be
 pruned.  See linkgit:git-reflog[1] and linkgit:git-gc[1] to learn
 how to control this pruning, and see the "SPECIFYING REVISIONS"
-section of linkgit:gitrevisions[7] for details.
+section of linkgit:git-revisions[7] for details.
 
 Note that the reflog history is very different from normal git history.
 While normal history is shared by every repository that works on the
@@ -1949,7 +1949,7 @@ $ mv hooks/post-update.sample hooks/post-update
 -------------------------------------------------
 
 (For an explanation of the last two lines, see
-linkgit:git-update-server-info[1] and linkgit:githooks[5].)
+linkgit:git-update-server-info[1] and linkgit:git-hooks[5].)
 
 Advertise the URL of proj.git.  Anybody else should then be able to
 clone or pull from that URL, for example with a command line like:
@@ -2061,7 +2061,7 @@ pull, or by a fetch followed by a rebase; see the
 solution is to retry the push after first updating your work: either by a
 pull, or by a fetch followed by a rebase; see the
 <<setting-up-a-shared-repository,next section>> and
-linkgit:gitcvs-migration[7] for more.
+linkgit:git-cvs-migration[7] for more.
 
 [[setting-up-a-shared-repository]]
 Setting up a shared repository
@@ -2070,7 +2070,7 @@ all push to and pull from a single shared repository.  See
 Another way to collaborate is by using a model similar to that
 commonly used in CVS, where several developers with special rights
 all push to and pull from a single shared repository.  See
-linkgit:gitcvs-migration[7] for instructions on how to
+linkgit:git-cvs-migration[7] for instructions on how to
 set this up.
 
 However, while there is nothing wrong with git's support for shared
diff --git a/builtin/help.c b/builtin/help.c
index 6067a61..1eca4ea 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -308,10 +308,8 @@ static const char *cmd_to_page(const char *git_cmd)
 		return "git";
 	else if (!prefixcmp(git_cmd, "git"))
 		return git_cmd;
-	else if (is_git_command(git_cmd))
-		return prepend("git-", git_cmd);
 	else
-		return prepend("git", git_cmd);
+		return prepend("git-", git_cmd);
 }
 
 static void setup_man_path(void)
-- 
1.8.1.2.11.g1a2f572
