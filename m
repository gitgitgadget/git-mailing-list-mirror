From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 06/15] Add glossary that can be converted into a po file for
 each language.
Date: Sun, 2 Sep 2007 17:32:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021731560.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:32:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsNW-00054c-Hp
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894AbXIBQcq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbXIBQcq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:32:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:51569 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932753AbXIBQcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:32:45 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:32:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 02 Sep 2007 18:32:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xDAgnxh3xJLoAN7KyW/cHO7qY0JpIQdv22tk2UQ
	jcTPKg82cdMzC7
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57353>


From: Christian Stimming <stimming@tuhh.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/glossary/Makefile             |    9 +++++++
 po/glossary/git-gui-glossary.txt |   34 ++++++++++++++++++++++++++
 po/glossary/txt-to-pot.sh        |   48 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 po/glossary/Makefile
 create mode 100644 po/glossary/git-gui-glossary.txt
 create mode 100755 po/glossary/txt-to-pot.sh

diff --git a/po/glossary/Makefile b/po/glossary/Makefile
new file mode 100644
index 0000000..749aa2e
--- /dev/null
+++ b/po/glossary/Makefile
@@ -0,0 +1,9 @@
+PO_TEMPLATE = git-gui-glossary.pot
+
+ALL_POFILES = $(wildcard *.po)
+
+$(PO_TEMPLATE): $(subst .pot,.txt,$(PO_TEMPLATE))
+	./txt-to-pot.sh $< > $@
+
+update-po:: git-gui-glossary.pot
+	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
diff --git a/po/glossary/git-gui-glossary.txt b/po/glossary/git-gui-glossary.txt
new file mode 100644
index 0000000..bb55aa8
--- /dev/null
+++ b/po/glossary/git-gui-glossary.txt
@@ -0,0 +1,34 @@
+"English Term (Dear translator: This file will never be visible to the user!)"	"English Definition (Dear translator: This file will never be visible to the user! It should only serve as a tool for you, the translator. Nothing more.)"
+"amend"	""
+"annotate"	""
+"branch [noun]"	"A 'branch' is an active line of development."
+"branch [verb]"	""
+"checkout [noun]"	""
+"checkout [verb]"	"The action of updating the working tree to a revision which was stored in the object database."
+"commit [noun]"	"A single point in the git history."
+"commit [verb]"	"The action of storing a new snapshot of the project's state in the git history."
+"diff [noun]"	""
+"diff [verb]"	""
+"fast forward merge"	"A fast-forward is a special type of merge where you have a revision and you are merging another branch's changes that happen to be a descendant of what you have."
+"fetch"	"Fetching a branch means to get the branch's head from a remote repository, to find out which objects are missing from the local object database, and to get them, too."
+"index (in git-gui: staging area)"	"A collection of files. The index is a stored version of your working tree."
+"merge [noun]"	"A successful merge results in the creation of a new commit representing the result of the merge."
+"merge [verb]"	"To bring the contents of another branch into the current branch."
+"message"	""
+"pull"	"Pulling a branch means to fetch it and merge it."
+"push"	"Pushing a branch means to get the branch's head ref from a remote repository, and ... (well, can someone please explain it for mere mortals?)"
+"redo"	""
+"repository"	"A collection of refs (?) together with an object database containing all objects which are reachable from the refs... (oops, you've lost me here. Again, please an explanation for mere mortals?)"
+"reset"	""
+"revert"	""
+"revision"	"A particular state of files and directories which was stored in the object database."
+"sign off"	""
+"staging area"	""
+"status"	""
+"tag [noun]"	"A ref pointing to a tag or commit object"
+"tag [verb]"	""
+"tracking branch"	"A regular git branch that is used to follow changes from another repository."
+"undo"	""
+"update"	""
+"verify"	""
+"working copy, working tree"	"The tree of actual checked out files."
diff --git a/po/glossary/txt-to-pot.sh b/po/glossary/txt-to-pot.sh
new file mode 100755
index 0000000..49bf7c5
--- /dev/null
+++ b/po/glossary/txt-to-pot.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+# This is a very, _very_, simple script to convert a tab-separated
+# .txt file into a .pot/.po.
+# Its not clever but it took me 2 minutes to write :)
+# Michael Twomey <michael.twomey@ireland.sun.com>
+# 23 March 2001
+# with slight GnuCash modifications by Christian Stimming <stimming@tuhh.de>
+# 19 Aug 2001, 23 Jul 2007
+
+#check args
+if [ $# -eq 0 ]
+then
+	cat <<!
+Usage: `basename $0` git-gui-glossary.txt > git-gui-glossary.pot
+!
+	exit 1;
+fi
+
+GLOSSARY_CSV="$1";
+
+if [ ! -f "$GLOSSARY_CSV" ]
+then
+	echo "Can't find $GLOSSARY_CSV.";
+	exit 1;
+fi
+
+cat <<!
+# SOME DESCRIPTIVE TITLE.
+# Copyright (C) YEAR Free Software Foundation, Inc.
+# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
+#
+#, fuzzy
+msgid ""
+msgstr ""
+"Project-Id-Version: PACKAGE VERSION\n"
+"POT-Creation-Date: `date +'%Y-%m-%d %H:%M%z'`\n"
+"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
+"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
+"Language-Team: LANGUAGE <LL@li.org>\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=CHARSET\n"
+"Content-Transfer-Encoding: ENCODING\n"
+
+!
+
+#Yes this is the most simple awk script you've ever seen :)
+awk -F'\t' '{if ($2 != "") print "#. "$2; print "msgid "$1; print "msgstr \"\"\n"}' \
+$GLOSSARY_CSV
-- 
1.5.3.2.g46909
