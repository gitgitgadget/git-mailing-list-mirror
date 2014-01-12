From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2] Make 'git help everyday' work
Date: Sun, 12 Jan 2014 22:57:24 +0000
Message-ID: <1389567444-3776-1-git-send-email-philipoakley@iee.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Nwe <stefan.naewe@atlas-elektronik.com>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 12 23:57:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2TyC-0005cW-DL
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 23:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbaALW5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jan 2014 17:57:00 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:7599 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750899AbaALW46 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jan 2014 17:56:58 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsINADkd01ICYJmg/2dsb2JhbABagwsBNxADgm+wD4ctC3wXdIMCIxiBAiQBEogIxCoXjiNkNYQJBKosgy08gSw
X-IPAS-Result: AsINADkd01ICYJmg/2dsb2JhbABagwsBNxADgm+wD4ctC3wXdIMCIxiBAiQBEogIxCoXjiNkNYQJBKosgy08gSw
X-IronPort-AV: E=Sophos;i="4.95,648,1384300800"; 
   d="scan'208";a="432595131"
Received: from host-2-96-153-160.as13285.net (HELO localhost) ([2.96.153.160])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 12 Jan 2014 22:56:55 +0000
X-Mailer: git-send-email 1.8.3.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240354>

The "Everyday GIT With 20 Commands Or So" is not accessible via the
Git help system. Fix that.

Move everyday.txt to giteveryday.txt.
Update giteveryday.txt to fit man page formatting.
Add standard man page section titles.
Also adjust anchor text markup for man page format.
Add giteveryday to the manpages make list.
Deprecate the old everyday.txt as *.txto in the same manner
as bd4a3d61 (Rename {git- => git}remote-helpers.txt,
2013-01-31), including a link to the new man page.

Add 'everyday' to the help --guides list.
Update git(1) and 5 other links to giteveryday.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

The series has been squashed into a single complete patch as
suggested by Jonathan Nieder, and now uses the same deprecation
techniques as the old remote-helpers as pointed out by Junio.

The diff is now smaller because of the shift to '.txto' for the
obsolete old file, so there is no longer a bulk deletion listed.

---
 Documentation/Makefile                          |  3 +-
 Documentation/everyday.txto                     |  9 ++++++
 Documentation/git.txt                           |  4 +--
 Documentation/gitcore-tutorial.txt              |  2 +-
 Documentation/gitcvs-migration.txt              |  2 +-
 Documentation/{everyday.txt => giteveryday.txt} | 39 +++++++++++++++++--------
 Documentation/gitglossary.txt                   |  2 +-
 Documentation/gittutorial-2.txt                 |  4 +--
 Documentation/gittutorial.txt                   |  4 +--
 README                                          |  2 +-
 builtin/help.c                                  |  1 +
 11 files changed, 49 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/everyday.txto
 rename Documentation/{everyday.txt => giteveryday.txt} (94%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 91a12c7..861560b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -23,6 +23,7 @@ MAN7_TXT += gitcore-tutorial.txt
 MAN7_TXT += gitcredentials.txt
 MAN7_TXT += gitcvs-migration.txt
 MAN7_TXT += gitdiffcore.txt
+MAN7_TXT += giteveryday.txt
 MAN7_TXT += gitglossary.txt
 MAN7_TXT += gitnamespaces.txt
 MAN7_TXT += gitrevisions.txt
@@ -35,10 +36,10 @@ MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))
 MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))
 
 OBSOLETE_HTML = git-remote-helpers.html
+OBSOLETE_HTML += everyday.html
 DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
 
 ARTICLES = howto-index
-ARTICLES += everyday
 ARTICLES += git-tools
 ARTICLES += git-bisect-lk2009
 # with their own formatting rules.
diff --git a/Documentation/everyday.txto b/Documentation/everyday.txto
new file mode 100644
index 0000000..3f8a4ea
--- /dev/null
+++ b/Documentation/everyday.txto
@@ -0,0 +1,9 @@
+Everyday Git With 20 Commands Or So
+===================================
+
+This document has been moved to linkgit:giteveryday[1].
+
+Please let the owners of the referring site know so that they can update the
+link you clicked to get here.
+
+Thanks.
\ No newline at end of file
diff --git a/Documentation/git.txt b/Documentation/git.txt
index aec3726..bf06dcc 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -22,7 +22,7 @@ unusually rich command set that provides both high-level operations
 and full access to internals.
 
 See linkgit:gittutorial[7] to get started, then see
-link:everyday.html[Everyday Git] for a useful minimum set of
+linkgit:giteveryday[7] for a useful minimum set of
 commands.  The link:user-manual.html[Git User's Manual] has a more
 in-depth introduction.
 
@@ -1037,7 +1037,7 @@ subscribed to the list to send a message there.
 SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-link:everyday.html[Everyday Git], linkgit:gitcvs-migration[7],
+linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
 linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
 linkgit:gitcli[7], link:user-manual.html[The Git User's Manual],
 linkgit:gitworkflows[7]
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 058a352..ccf31dd 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1667,7 +1667,7 @@ linkgit:gittutorial[7],
 linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
 linkgit:git-help[1],
-link:everyday.html[Everyday git],
+linkgit:giteveryday[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 5ea94cb..da8688d 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -194,7 +194,7 @@ linkgit:gittutorial[7],
 linkgit:gittutorial-2[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
-link:everyday.html[Everyday Git],
+linkgit:giteveryday[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/everyday.txt b/Documentation/giteveryday.txt
similarity index 94%
rename from Documentation/everyday.txt
rename to Documentation/giteveryday.txt
index 2a18c1f..2939458 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/giteveryday.txt
@@ -1,22 +1,33 @@
+giteveryday(7)
+===============
+
+NAME
+----
+giteveryday - A useful minimum set of commands for Everyday Git 
+
+SYNOPSIS
+--------
+
 Everyday Git With 20 Commands Or So
-===================================
 
-<<Individual Developer (Standalone)>> commands are essential for
+DESCRIPTION
+-----------
+<<STANDALONE,Individual Developer (Standalone)>> commands are essential for
 anybody who makes a commit, even for somebody who works alone.
 
 If you work with other people, you will need commands listed in
-the <<Individual Developer (Participant)>> section as well.
+the <<PARTICIPANT,Individual Developer (Participant)>> section as well.
 
-People who play the <<Integrator>> role need to learn some more
+People who play the <<INTEGRATOR,Integrator>> role need to learn some more
 commands in addition to the above.
 
-<<Repository Administration>> commands are for system
+<<ADMINISTRATION,Repository Administration>> commands are for system
 administrators who are responsible for the care and feeding
 of Git repositories.
 
 
-Individual Developer (Standalone)[[Individual Developer (Standalone)]]
-----------------------------------------------------------------------
+Individual Developer (Standalone)[[STANDALONE]]
+-----------------------------------------------
 
 A standalone individual developer does not exchange patches with
 other people, and works alone in a single repository, using the
@@ -104,8 +115,8 @@ combined and include `--max-count=10` (show 10 commits),
 directory, since `v2.43` tag.
 
 
-Individual Developer (Participant)[[Individual Developer (Participant)]]
-------------------------------------------------------------------------
+Individual Developer (Participant)[[PARTICIPANT]]
+-------------------------------------------------
 
 A developer working as a participant in a group project needs to
 learn how to communicate with others, and uses these commands in
@@ -205,7 +216,7 @@ tag.
 without a formal "merging".
 
 
-Integrator[[Integrator]]
+Integrator[[INTEGRATOR]]
 ------------------------
 
 A fairly central person acting as the integrator in a group
@@ -292,8 +303,8 @@ everything `ko-next` has.
 <13> push the tag out, too.
 
 
-Repository Administration[[Repository Administration]]
-------------------------------------------------------
+Repository Administration[[ADMINISTRATION]]
+-------------------------------------------
 
 A repository administrator uses the following tools to set up
 and maintain access to the repository by developers.
@@ -411,3 +422,7 @@ ftp> cp -r .git /home/user/myproject.git
 +
 <1> make sure your info/refs and objects/info/packs are up-to-date
 <2> upload to public HTTP server hosted by your ISP.
+
+GIT
+---
+Part of the linkgit:git[1] suite
\ No newline at end of file
diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.txt
index e52de7d..212e254 100644
--- a/Documentation/gitglossary.txt
+++ b/Documentation/gitglossary.txt
@@ -19,7 +19,7 @@ SEE ALSO
 linkgit:gittutorial[7],
 linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
-link:everyday.html[Everyday Git],
+linkgit:giteveryday[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 3109ea8..f6fbf81 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -403,7 +403,7 @@ What next?
 
 At this point you should know everything necessary to read the man
 pages for any of the git commands; one good place to start would be
-with the commands mentioned in link:everyday.html[Everyday Git].  You
+with the commands mentioned in linkgit:giteveryday[7].  You
 should be able to find any unknown jargon in linkgit:gitglossary[7].
 
 The link:user-manual.html[Git User's Manual] provides a more
@@ -427,7 +427,7 @@ linkgit:gitcvs-migration[7],
 linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
 linkgit:git-help[1],
-link:everyday.html[Everyday Git],
+linkgit:giteveryday[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 8262196..af9f709 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -656,7 +656,7 @@ digressions that may be interesting at this point are:
   * linkgit:gitworkflows[7]: Gives an overview of recommended
     workflows.
 
-  * link:everyday.html[Everyday Git with 20 Commands Or So]
+  * linkgit:giteveryday[7]: Everyday Git with 20 Commands Or So.
 
   * linkgit:gitcvs-migration[7]: Git for CVS users.
 
@@ -668,7 +668,7 @@ linkgit:gitcore-tutorial[7],
 linkgit:gitglossary[7],
 linkgit:git-help[1],
 linkgit:gitworkflows[7],
-link:everyday.html[Everyday Git],
+linkgit:giteveryday[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/README b/README
index 15a8e23..1083735 100644
--- a/README
+++ b/README
@@ -27,7 +27,7 @@ Torvalds with help of a group of hackers around the net.
 Please read the file INSTALL for installation instructions.
 
 See Documentation/gittutorial.txt to get started, then see
-Documentation/everyday.txt for a useful minimum set of commands, and
+Documentation/giteveryday.txt for a useful minimum set of commands, and
 Documentation/git-commandname.txt for documentation of each command.
 If git has been correctly installed, then the tutorial can also be
 read with "man gittutorial" or "git help tutorial", and the
diff --git a/builtin/help.c b/builtin/help.c
index cc17e67..45509ce 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -418,6 +418,7 @@ static struct {
 	const char *help;
 } common_guides[] = {
 	{ "attributes", N_("Defining attributes per path") },
+	{ "everyday", N_("Everyday Git With 20 Commands Or So") },
 	{ "glossary", N_("A Git glossary") },
 	{ "ignore", N_("Specifies intentionally untracked files to ignore") },
 	{ "modules", N_("Defining submodule properties") },
-- 
1.8.3.msysgit.0
