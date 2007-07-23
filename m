From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] Add glossary that can be converted into a po file for each language.
Date: Mon, 23 Jul 2007 22:16:39 +0200
Message-ID: <200707232216.40300.stimming@tuhh.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707212150.49351.stimming@tuhh.de> <7vabtpv43d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4NH-0000Ch-IQ
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935124AbXGWUTB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Jul 2007 16:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935120AbXGWUTA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:19:00 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:41676 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935102AbXGWUS6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 16:18:58 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6NKGRR0002054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 23 Jul 2007 22:16:27 +0200
Received: from [192.168.2.102] (p5490052D.dip0.t-ipconnect.de [84.144.5.45])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6NKGP72027285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 22:16:26 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <7vabtpv43d.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53471>

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---

Am Samstag, 21. Juli 2007 23:28 schrieb Junio C Hamano:
> >> I would suggest having one glossary file per language.
> >
> > Agreed. I propose to throw away the "add glossary" patch and I'll
> > resubmit, this time in a separate po/glossary/ directory, where eac=
h
> > language will get a po file for the glossary.
>
> Actually, I would even suggest that we should NOT have a
> separate glossary file at all, if gettext suite allows what I
> outline below.
>
> How about having it as a part of header comment in each of the
> xx.po file?

As I already wrote: Having a glossary in the header of the po file has=20
some (IMHO serious) drawbacks. For that reason I've pushed this patch
to the mob branch: It contains one tab-separated text file with the rel=
evant
terms *plus their definition* (for now, pulled from=20
git/Documentation/glossary.txt). As an example, you also see the German
glossary translation - and having the definition available there as wel=
l (and=20
having it updated by running make update-po) is indeed a huge advantage=
=2E

 po/glossary/Makefile             |    9 ++
 po/glossary/de.po                |  151 ++++++++++++++++++++++++++++++=
++++++++
 po/glossary/git-gui-glossary.txt |   34 +++++++++
 po/glossary/txt-to-pot.sh        |   48 ++++++++++++
 4 files changed, 242 insertions(+), 0 deletions(-)
 create mode 100644 po/glossary/Makefile
 create mode 100644 po/glossary/de.po
 create mode 100644 po/glossary/git-gui-glossary.txt
 create mode 100755 po/glossary/txt-to-pot.sh

diff --git a/po/glossary/Makefile b/po/glossary/Makefile
new file mode 100644
index 0000000..749aa2e
--- /dev/null
+++ b/po/glossary/Makefile
@@ -0,0 +1,9 @@
+PO_TEMPLATE =3D git-gui-glossary.pot
+
+ALL_POFILES =3D $(wildcard *.po)
+
+$(PO_TEMPLATE): $(subst .pot,.txt,$(PO_TEMPLATE))
+	./txt-to-pot.sh $< > $@
+
+update-po:: git-gui-glossary.pot
+	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_T=
EMPLATE) ; )
diff --git a/po/glossary/de.po b/po/glossary/de.po
new file mode 100644
index 0000000..0d07f68
--- /dev/null
+++ b/po/glossary/de.po
@@ -0,0 +1,151 @@
+# Translation of git-gui glossary to German
+# Copyright (C) 2007 Shawn Pearce, et al.
+# This file is distributed under the same license as the git package.
+# Christian Stimming <stimming@tuhh.de>, 2007
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui glossary\n"
+"PO-Revision-Date: 2007-07-23 22:07+0200\n"
+"Last-Translator: Christian Stimming <stimming@tuhh.de>\n"
+"Language-Team: German \n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#. "English Definition (Dear translator: This file will never be visib=
le to the user! It should only serve as a tool for you, the translator.=
 Nothing more.)"
+msgid ""
+"English Term (Dear translator: This file will never be visible to the=
 user!)"
+msgstr "Deutsche =DCbersetzung"
+
+#. ""
+msgid "amend"
+msgstr "nachbessern (erg=E4nzen)"
+
+#. ""
+msgid "annotate"
+msgstr "annotieren"
+
+#. "A 'branch' is an active line of development."
+msgid "branch [noun]"
+msgstr "Zweig"
+
+#. ""
+msgid "branch [verb]"
+msgstr "verzweigen"
+
+#. ""
+msgid "checkout [noun]"
+msgstr "Auscheck? Ausspielung? Abruf?"
+
+#. "The action of updating the working tree to a revision which was st=
ored in the object database."
+msgid "checkout [verb]"
+msgstr "auschecken? ausspielen? abrufen?"
+
+#. "A single point in the git history."
+msgid "commit [noun]"
+msgstr "=DCbertragung (Sendung?, =DCbergabe?, Einspielung?, Ablagevorg=
ang?)"
+
+#. "The action of storing a new snapshot of the project's state in the=
 git history."
+msgid "commit [verb]"
+msgstr "=FCbertragen (senden?, =FCbergeben?, einspielen?, einpflegen?,=
 ablegen?)"
+
+#. ""
+msgid "diff [noun]"
+msgstr "Vergleich"
+
+#. ""
+msgid "diff [verb]"
+msgstr "vergleichen"
+
+#. "A fast-forward is a special typ of merge where you have a revision=
 and you are merging another branch's changes that happen to be a desce=
ndant of what you have."
+msgid "fast forward merge"
+msgstr "Schnellzusammenf=FChrung"
+
+#. "Fetching a branch means to get the branch's head from a remote rep=
ository, to find out which objects are missing from the local object da=
tabase, and to get them, too."
+msgid "fetch"
+msgstr "anfordern (holen?)"
+
+#. "A collection of files. The index is a stored version of your worki=
ng tree."
+msgid "index (in git-gui: staging area)"
+msgstr "Bereitstellung"
+
+#. "A successful merge results in the creation of a new commit represe=
nting the result of the merge."
+msgid "merge [noun]"
+msgstr "Zusammenf=FChrung"
+
+#. "To bring the contents of another branch into the current branch."
+msgid "merge [verb]"
+msgstr "zusammenf=FChren"
+
+#. ""
+msgid "message"
+msgstr "Meldung (Nachricht?)"
+
+#. "Pulling a branch means to fetch it and merge it."
+msgid "pull"
+msgstr "=FCbernehmen (ziehen?)"
+
+#. "Pushing a branch means to get the branch's head ref from a remote =
repository, and ... (well, can someone please explain it for mere morta=
ls?)"
+msgid "push"
+msgstr "ausliefern (hochladen? verschicken? schieben?)"
+
+#. ""
+msgid "redo"
+msgstr "wiederholen"
+
+#. "A collection of refs (?) together with an object database containi=
ng all objects which are reachable from the refs... (oops, you've lost =
me here. Again, please an explanation for mere mortals?)"
+msgid "repository"
+msgstr "Projektarchiv"
+
+#. ""
+msgid "reset"
+msgstr "zur=FCcksetzen"
+
+#. ""
+msgid "revert"
+msgstr "revidieren (aufheben?, zur=FCckkehren?)"
+
+#. "A particular state of files and directories which was stored in th=
e object database."
+msgid "revision"
+msgstr "Version? Revision?"
+
+#. ""
+msgid "sign off"
+msgstr "abzeichnen (gegenzeichnen?, freizeichnen?, absegnen?)"
+
+#. ""
+msgid "staging area"
+msgstr "Bereitstellung"
+
+#. ""
+msgid "status"
+msgstr "Status"
+
+#. "A ref pointing to a tag or commit object"
+msgid "tag [noun]"
+msgstr "Markierung"
+
+#. ""
+msgid "tag [verb]"
+msgstr "markieren"
+
+#. "A regular git branch that is used to follow changes from another r=
epository."
+msgid "tracking branch"
+msgstr "? Entfernter Zweig? Folgezweig?"
+
+#. ""
+msgid "undo"
+msgstr "r=FCckg=E4ngig"
+
+#. ""
+msgid "update"
+msgstr "aktualisieren"
+
+#. ""
+msgid "verify"
+msgstr "=FCberpr=FCfen"
+
+#. "The tree of actual checked out files."
+msgid "working copy, working tree"
+msgstr "Arbeitskopie"
diff --git a/po/glossary/git-gui-glossary.txt b/po/glossary/git-gui-glo=
ssary.txt
new file mode 100644
index 0000000..e079bb2
--- /dev/null
+++ b/po/glossary/git-gui-glossary.txt
@@ -0,0 +1,34 @@
+"English Term (Dear translator: This file will never be visible to the=
 user!)"	"English Definition (Dear translator: This file will never be =
visible to the user! It should only serve as a tool for you, the transl=
ator. Nothing more.)"
+"amend"	""
+"annotate"	""
+"branch [noun]"	"A 'branch' is an active line of development."
+"branch [verb]"	""
+"checkout [noun]"	""
+"checkout [verb]"	"The action of updating the working tree to a revisi=
on which was stored in the object database."
+"commit [noun]"	"A single point in the git history."
+"commit [verb]"	"The action of storing a new snapshot of the project's=
 state in the git history."
+"diff [noun]"	""
+"diff [verb]"	""
+"fast forward merge"	"A fast-forward is a special typ of merge where y=
ou have a revision and you are merging another branch's changes that ha=
ppen to be a descendant of what you have."
+"fetch"	"Fetching a branch means to get the branch's head from a remot=
e repository, to find out which objects are missing from the local obje=
ct database, and to get them, too."
+"index (in git-gui: staging area)"	"A collection of files. The index i=
s a stored version of your working tree."
+"merge [noun]"	"A successful merge results in the creation of a new co=
mmit representing the result of the merge."
+"merge [verb]"	"To bring the contents of another branch into the curre=
nt branch."
+"message"	""
+"pull"	"Pulling a branch means to fetch it and merge it."
+"push"	"Pushing a branch means to get the branch's head ref from a rem=
ote repository, and ... (well, can someone please explain it for mere m=
ortals?)"
+"redo"	""
+"repository"	"A collection of refs (?) together with an object databas=
e containing all objects which are reachable from the refs... (oops, yo=
u've lost me here. Again, please an explanation for mere mortals?)"
+"reset"	""
+"revert"	""
+"revision"	"A particular state of files and directories which was stor=
ed in the object database."
+"sign off"	""
+"staging area"	""
+"status"	""
+"tag [noun]"	"A ref pointing to a tag or commit object"
+"tag [verb]"	""
+"tracking branch"	"A regular git branch that is used to follow changes=
 from another repository."
+"undo"	""
+"update"	""
+"verify"	""
+"working copy, working tree"	"The tree of actual checked out files."
diff --git a/po/glossary/txt-to-pot.sh b/po/glossary/txt-to-pot.sh
new file mode 100755
index 0000000..8a8f976
--- /dev/null
+++ b/po/glossary/txt-to-pot.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+# This is a very, _very_, simple script to convert a tab-separated
+# .txt file into a .pot/.po.
+# Its not clever but it took me 2 minutes to write :)
+# Michael Twomey <michael.twomey@ireland.sun.com>
+# 23 March 2001
+# with slight GnuCash modifications by Christian Stimming <stimming@tu=
hh.de>=20
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
+GLOSSARY_CSV=3D"$1";
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
+"Content-Type: text/plain; charset=3DCHARSET\n"
+"Content-Transfer-Encoding: ENCODING\n"
+
+!
+
+#Yes this is the most simple awk script you've ever seen :)
+awk -F'\t' '{if ($2 !=3D "") print "#. "$2; print "msgid "$1; print "m=
sgstr \"\"\n"}' \
+$GLOSSARY_CSV
--=20
1.5.2
