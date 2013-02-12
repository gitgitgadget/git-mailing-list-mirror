From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] Replace filepattern with pathspec for consistency
Date: Tue, 12 Feb 2013 10:24:44 +0100
Message-ID: <1360661084-8678-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 12 10:25:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5C7Q-0005hR-Ol
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 10:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932960Ab3BLJZP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2013 04:25:15 -0500
Received: from mx1.imag.fr ([129.88.30.5]:38137 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758445Ab3BLJZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 04:25:12 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1C9P4Lm001557
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2013 10:25:04 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U5C6q-0002an-Rp; Tue, 12 Feb 2013 10:25:04 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U5C6q-0002HS-Nb; Tue, 12 Feb 2013 10:25:04 +0100
X-Mailer: git-send-email 1.8.1.2.548.g956380a.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Feb 2013 10:25:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1C9P4Lm001557
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1361265907.12365@mq/MdlHa2ZC18nc/6mEgMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216122>

pathspec is the most widely used term, and is the one defined in
gitglossary.txt. <filepattern> was used only in the synopsys for git-ad=
d
and git-commit, and in git-add.txt. Get rid of it.

This patch is obtained with by running:

  perl -pi -e 's/filepattern/pathspec/' `git grep -l filepattern`

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I'm a bit unsure about the changes to the .po files, but I guess doing
the substitution there too does the right thing.

 Documentation/git-add.txt | 12 ++++++------
 builtin/add.c             |  2 +-
 builtin/commit.c          |  4 ++--
 po/de.po                  |  6 +++---
 po/git.pot                |  6 +++---
 po/sv.po                  |  6 +++---
 po/vi.po                  |  6 +++---
 po/zh_CN.po               |  6 +++---
 8 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 5333559..388a225 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--all | [--update | -u]] [--intent-to-add | -N]
 	  [--refresh] [--ignore-errors] [--ignore-missing] [--]
-	  [<filepattern>...]
+	  [<pathspec>...]
=20
 DESCRIPTION
 -----------
@@ -49,7 +49,7 @@ commit.
=20
 OPTIONS
 -------
-<filepattern>...::
+<pathspec>...::
 	Files to add content from.  Fileglobs (e.g. `*.c`) can
 	be given to add all matching files.  Also a
 	leading directory name (e.g. `dir` to add `dir/file1`
@@ -100,21 +100,21 @@ apply to the index. See EDITING PATCHES below.
=20
 -u::
 --update::
-	Only match <filepattern> against already tracked files in
+	Only match <pathspec> against already tracked files in
 	the index rather than the working tree. That means that it
 	will never stage new files, but that it will stage modified
 	new contents of tracked files and that it will remove files
 	from the index if the corresponding files in the working tree
 	have been removed.
 +
-If no <filepattern> is given, the current version of Git defaults to
+If no <pathspec> is given, the current version of Git defaults to
 "."; in other words, update all tracked files in the current directory
 and its subdirectories. This default will change in a future version
-of Git, hence the form without <filepattern> should not be used.
+of Git, hence the form without <pathspec> should not be used.
=20
 -A::
 --all::
-	Like `-u`, but match <filepattern> against files in the
+	Like `-u`, but match <pathspec> against files in the
 	working tree in addition to the index. That means that it
 	will find new files as well as staging modified content and
 	removing files that are no longer in the working tree.
diff --git a/builtin/add.c b/builtin/add.c
index 7738025..0dd014e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -17,7 +17,7 @@
 #include "bulk-checkin.h"
=20
 static const char * const builtin_add_usage[] =3D {
-	N_("git add [options] [--] <filepattern>..."),
+	N_("git add [options] [--] <pathspec>..."),
 	NULL
 };
 static int patch_interactive, add_interactive, edit_interactive;
diff --git a/builtin/commit.c b/builtin/commit.c
index 1a0e5f1..3348aa1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -31,12 +31,12 @@
 #include "sequencer.h"
=20
 static const char * const builtin_commit_usage[] =3D {
-	N_("git commit [options] [--] <filepattern>..."),
+	N_("git commit [options] [--] <pathspec>..."),
 	NULL
 };
=20
 static const char * const builtin_status_usage[] =3D {
-	N_("git status [options] [--] <filepattern>..."),
+	N_("git status [options] [--] <pathspec>..."),
 	NULL
 };
=20
diff --git a/po/de.po b/po/de.po
index c8ad2f0..0183c28 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1410,7 +1410,7 @@ msgid "failed to unlink '%s'"
 msgstr "Konnte '%s' nicht entfernen"
=20
 #: builtin/add.c:19
-msgid "git add [options] [--] <filepattern>..."
+msgid "git add [options] [--] <pathspec>..."
 msgstr "git add [Optionen] [--] [<Dateimuster>...]"
=20
 #: builtin/add.c:62
@@ -3296,11 +3296,11 @@ msgid "--command must be the first argument"
 msgstr "Option --command muss zuerst angegeben werden"
=20
 #: builtin/commit.c:34
-msgid "git commit [options] [--] <filepattern>..."
+msgid "git commit [options] [--] <pathspec>..."
 msgstr "git commit [Optionen] [--] <Dateimuster>..."
=20
 #: builtin/commit.c:39
-msgid "git status [options] [--] <filepattern>..."
+msgid "git status [options] [--] <pathspec>..."
 msgstr "git status [Optionen] [--] <Dateimuster>..."
=20
 #: builtin/commit.c:44
diff --git a/po/git.pot b/po/git.pot
index 430d033..4941fd7 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -1328,7 +1328,7 @@ msgid "failed to unlink '%s'"
 msgstr ""
=20
 #: builtin/add.c:19
-msgid "git add [options] [--] <filepattern>..."
+msgid "git add [options] [--] <pathspec>..."
 msgstr ""
=20
 #: builtin/add.c:62
@@ -3128,11 +3128,11 @@ msgid "--command must be the first argument"
 msgstr ""
=20
 #: builtin/commit.c:34
-msgid "git commit [options] [--] <filepattern>..."
+msgid "git commit [options] [--] <pathspec>..."
 msgstr ""
=20
 #: builtin/commit.c:39
-msgid "git status [options] [--] <filepattern>..."
+msgid "git status [options] [--] <pathspec>..."
 msgstr ""
=20
 #: builtin/commit.c:44
diff --git a/po/sv.po b/po/sv.po
index ee6b0fc..c0ef050 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -1379,7 +1379,7 @@ msgid "failed to unlink '%s'"
 msgstr "misslyckades ta bort l=C3=A4nken \"%s\""
=20
 #: builtin/add.c:19
-msgid "git add [options] [--] <filepattern>..."
+msgid "git add [options] [--] <pathspec>..."
 msgstr "git add [flaggor] [--] <film=C3=B6nster>..."
=20
 #: builtin/add.c:62
@@ -3223,11 +3223,11 @@ msgid "--command must be the first argument"
 msgstr "--command m=C3=A5ste vara f=C3=B6rsta argument"
=20
 #: builtin/commit.c:34
-msgid "git commit [options] [--] <filepattern>..."
+msgid "git commit [options] [--] <pathspec>..."
 msgstr "git commit [flaggor] [--] <film=C3=B6ster>..."
=20
 #: builtin/commit.c:39
-msgid "git status [options] [--] <filepattern>..."
+msgid "git status [options] [--] <pathspec>..."
 msgstr "git status [flaggor] [--] <film=C3=B6nster>..."
=20
 #: builtin/commit.c:44
diff --git a/po/vi.po b/po/vi.po
index 2ccdf86..78c6326 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -1412,7 +1412,7 @@ msgid "failed to unlink '%s'"
 msgstr "b=E1=BB=8F li=C3=AAn k=E1=BA=BFt (unlink) %s kh=C3=B4ng th=C3=A0=
nh c=C3=B4ng"
=20
 #: builtin/add.c:19
-msgid "git add [options] [--] <filepattern>..."
+msgid "git add [options] [--] <pathspec>..."
 msgstr "git add [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] [--] <m=E1=BA=ABu-t=E1=
=BA=ADp-tin>..."
=20
 #: builtin/add.c:62
@@ -3281,11 +3281,11 @@ msgid "--command must be the first argument"
 msgstr "--command ph=E1=BA=A3i l=C3=A0 =C4=91=E1=BB=91i s=E1=BB=91 =C4=
=91=E1=BA=A7u ti=C3=AAn"
=20
 #: builtin/commit.c:34
-msgid "git commit [options] [--] <filepattern>..."
+msgid "git commit [options] [--] <pathspec>..."
 msgstr "git commit [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] [--] <m=E1=BA=ABu-=
t=E1=BA=ADp-tin>..."
=20
 #: builtin/commit.c:39
-msgid "git status [options] [--] <filepattern>..."
+msgid "git status [options] [--] <pathspec>..."
 msgstr "git status [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] [--] <m=E1=BA=ABu-=
t=E1=BA=ADp-tin>..."
=20
 #: builtin/commit.c:44
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 46d158f..79cce0e 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -1405,7 +1405,7 @@ msgstr "=E6=97=A0=E6=B3=95=E5=88=A0=E9=99=A4 '%s'=
"
=20
 #: builtin/add.c:19
 #, fuzzy
-msgid "git add [options] [--] <filepattern>..."
+msgid "git add [options] [--] <pathspec>..."
 msgstr "git apply [=E9=80=89=E9=A1=B9] [<=E8=A1=A5=E4=B8=81>...]"
=20
 #: builtin/add.c:62
@@ -3278,12 +3278,12 @@ msgstr "--command =E5=BF=85=E9=A1=BB=E6=98=AF=E7=
=AC=AC=E4=B8=80=E4=B8=AA=E5=8F=82=E6=95=B0"
=20
 #: builtin/commit.c:33
 #, fuzzy
-msgid "git commit [options] [--] <filepattern>..."
+msgid "git commit [options] [--] <pathspec>..."
 msgstr "git apply [=E9=80=89=E9=A1=B9] [<=E8=A1=A5=E4=B8=81>...]"
=20
 #: builtin/commit.c:38
 #, fuzzy
-msgid "git status [options] [--] <filepattern>..."
+msgid "git status [options] [--] <pathspec>..."
 msgstr "git apply [=E9=80=89=E9=A1=B9] [<=E8=A1=A5=E4=B8=81>...]"
=20
 #: builtin/commit.c:43
--=20
1.8.1.2.548.g956380a.dirty
