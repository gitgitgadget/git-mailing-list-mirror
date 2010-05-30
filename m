From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v2 4/6] gettext: Add a Gettext interface for shell scripts
Date: Sun, 30 May 2010 20:54:15 +0000
Message-ID: <1275252857-21593-5-git-send-email-avarab@gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 30 22:55:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIpXP-0007nM-1b
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 22:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922Ab0E3Uyv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 16:54:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64466 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab0E3Uyu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 16:54:50 -0400
Received: by mail-fx0-f46.google.com with SMTP id 10so1964029fxm.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 13:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=f52vlLugK5NrGmZ5sFsLXUURjieoj4p0hxCS9MgQecQ=;
        b=RnJCzjWgul+TB1WVmyREi6fJNKx0UaCEdy4rXoa44KS6uNwsmX/ia67rgFFTUQKjJ2
         SFbtoHsvizSs7RgD85M6dmQ0tHOZ7FnvXexQNqias2bBAOPZ3rBORVVO9ejnBy6oW8KD
         KH5BRoIYOs98AYx9bzWrB/R6JFhVIOs2fMoi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lQEMJHsG8/b2cH9doXQsrCZHI9b0SxoIdnDRAoROiCwMxbVGoxzR+D2Jw+uZBEKkNG
         eP/sc1rlbY5+scZQmSe3aQMKLCsFipZ5QnGZLnUb9qlK6y2v/6NgVJT0xhTPvdpUX08B
         zvIkajlOYjBbN8SlH1+6G2KTJOuKhrQdhY/58=
Received: by 10.223.144.77 with SMTP id y13mr4279590fau.86.1275252889321;
        Sun, 30 May 2010 13:54:49 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id r12sm33459492fah.8.2010.05.30.13.54.47
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 13:54:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.242.gde05d
In-Reply-To: <1275173125-21010-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148021>

Use GNU's gettext.sh in git-sh-setup if it's available, otherwise
fallback on our own custom functions.

A couple of strings in git-pull.sh are now translatable as a proof of
concept, including a multiline string.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile        |    7 +++++--
 git-pull.sh     |   15 ++++++++-------
 git-sh-setup.sh |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 4de0627..dce2faa 100644
--- a/Makefile
+++ b/Makefile
@@ -272,6 +272,7 @@ mandir =3D share/man
 infodir =3D share/info
 gitexecdir =3D libexec/git-core
 sharedir =3D $(prefix)/share
+localedir =3D $(sharedir)/locale
 template_dir =3D share/git-core/templates
 htmldir =3D share/doc/git-doc
 ifeq ($(prefix),/usr)
@@ -285,7 +286,7 @@ lib =3D lib
 # DESTDIR=3D
 pathsep =3D :
=20
-export prefix bindir sharedir sysconfdir
+export prefix bindir sharedir localedir sysconfdir
=20
 CC =3D gcc
 AR =3D ar
@@ -1455,6 +1456,7 @@ htmldir_SQ =3D $(subst ','\'',$(htmldir))
 prefix_SQ =3D $(subst ','\'',$(prefix))
 sharedir_SQ =3D $(subst ','\'',$(sharedir))
=20
+LOCALEDIR_SQ =3D $(subst ','\'',$(localedir))
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
 PYTHON_PATH_SQ =3D $(subst ','\'',$(PYTHON_PATH))
@@ -1548,6 +1550,7 @@ $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+    -e 's|@@LOCALEDIR@@|$(LOCALEDIR_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e $(BROKEN_PATH_FIX) \
     $@.sh >$@+
@@ -1881,7 +1884,7 @@ cscope:
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
=20
 pot:
-	$(XGETTEXT) -k_ -o po/git.pot $(C_OBJ:o=3Dc)
+	$(XGETTEXT) -k_ -o po/git.pot $(C_OBJ:o=3Dc) $(SCRIPT_SH)
=20
 POFILES :=3D $(wildcard po/*.po)
 MOFILES :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git.mo,$(PO=
=46ILES))
diff --git a/git-pull.sh b/git-pull.sh
index 1a4729f..22a6da2 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -121,8 +121,8 @@ error_on_no_merge_candidates () {
 	do
 		case "$opt" in
 		-t|--t|--ta|--tag|--tags)
-			echo "Fetching tags only, you probably meant:"
-			echo "  git fetch --tags"
+			gettext "Fetching tags only, you probably meant:"; echo
+			gettext "  git fetch --tags"; echo
 			exit 1
 		esac
 	done
@@ -154,11 +154,12 @@ error_on_no_merge_candidates () {
 		echo "a branch. Because this is not the default configured remote"
 		echo "for your current branch, you must specify a branch on the comm=
and line."
 	elif [ -z "$curr_branch" ]; then
-		echo "You are not currently on a branch, so I cannot use any"
-		echo "'branch.<branchname>.merge' in your configuration file."
-		echo "Please specify which remote branch you want to use on the comm=
and"
-		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
-		echo "See git-pull(1) for details."
+        gettext "You are not currently on a branch, so I cannot use an=
y
+'branch.<branchname>.merge' in your configuration file.
+Please specify which remote branch you want to use on the command
+line and try again (e.g. 'git pull <repository> <refspec>').
+See git-pull(1) for details.";
+        echo
 	elif [ -z "$upstream" ]; then
 		echo "You asked me to pull without telling me which branch you"
 		echo "want to $op_type $op_prep, and 'branch.${curr_branch}.merge' i=
n"
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6131670..c8010f2 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -211,3 +211,36 @@ case $(uname -s) in
 	}
 	;;
 esac
+
+# Try to use libintl's gettext.sh, or fall back to English if we
+# can't.
+. gettext.sh
+if test $? -ne 0
+then
+    TEXTDOMAIN=3Dgit
+    export TEXDTOMAIN
+    TEXTDOMAINDIR=3D"@@LOCALEDIR@@"
+    export TEXTDOMAINDIR
+else
+    # Since GNU gettext.sh isn't available we'll have to define our
+    # own dummy functions.
+
+    # This code adapted from NessusClient-1.0.2's nessusclient-mkcert
+    # by Michel Arboi <arboi@alussinan.org>. The original code is
+    # under the GPLv2.
+
+    # Not everyone has echo -n
+    case $(echo -n) in
+        \-n)    Xn=3D   ; Xc=3D'\c' ;;
+        *)      Xn=3D-n ; Xc=3D
+    esac
+
+    gettext () {
+        echo $Xn "$1" $Xc
+    }
+
+    eval_gettext () {
+        eval_gettext_var=3D"echo $1"
+        echo $Xn `eval $eval_gettext_var` $Xc
+    }
+fi
--=20
1.7.1.248.gcd6d1
