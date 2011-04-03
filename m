From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/2] git-sh-i18n.sh: add no-op gettext() and eval_gettext() wrappers
Date: Sun,  3 Apr 2011 16:42:33 +0000
Message-ID: <1301848953-31525-3-git-send-email-avarab@gmail.com>
References: <1301848953-31525-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:43:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QOH-0003Uz-CI
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab1DCQm7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:42:59 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48923 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab1DCQmp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:42:45 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502208eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=HkH5NGrSz2xYBZu0EhKsqFJjv3k7R9yRTlSdfK4CZGw=;
        b=HeJ/jSamdWNuuc0b7/5Uwrja0BKaZOcX74tyeRFeiW3FqK5Aux3kOdEQ3ciebWrEMg
         t7ky/JroXcHGXQNDtoFtOrJ5lge3T+Gp7IccIBT3ljYoPzyx0s3EDse12spm4+5BFu5W
         uqnPj/sV/HxuLYdIo2Utozq72bfibuUtGV6rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OZ23B12ZXgoog01F8dvmOcv3tmjiscUL8aBqdDNlH28kwWu3HLkHKw1OaT7KlYHiNU
         LfDPZIQHYvrUofg8wXxe4+HSuJQibEs/KqI7ScIB6rLa2kBaB0xfBIjhHue35/scYbIq
         xMYHKdIUpyY40L+Z6o7dN2SDTrcMOSjJsW2pg=
Received: by 10.14.17.15 with SMTP id i15mr2855653eei.90.1301848964892;
        Sun, 03 Apr 2011 09:42:44 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm2754455eei.22.2011.04.03.09.42.44
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:42:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301848953-31525-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170705>

Add a no-op wrapper library for Git's shell scripts. To split up the
gettext series I'm first submitting patches to gettextize the source
tree before I add any of the Makefile and Shell library changes needed
to actually use them.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore                    |    1 +
 Documentation/git-sh-i18n.txt |   57 +++++++++++++++++++++++++++++++++=
++++++++
 Makefile                      |    1 +
 git-sh-i18n.sh                |   17 ++++++++++++
 4 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-sh-i18n.txt
 create mode 100644 git-sh-i18n.sh

diff --git a/.gitignore b/.gitignore
index dad653d..e9ab0af 100644
--- a/.gitignore
+++ b/.gitignore
@@ -130,6 +130,7 @@
 /git-sh-i18n
 /git-sh-i18n--envsubst
 /git-sh-setup
+/git-sh-i18n
 /git-shell
 /git-shortlog
 /git-show
diff --git a/Documentation/git-sh-i18n.txt b/Documentation/git-sh-i18n.=
txt
new file mode 100644
index 0000000..b41b3af
--- /dev/null
+++ b/Documentation/git-sh-i18n.txt
@@ -0,0 +1,57 @@
+git-sh-i18n(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-sh-i18n - Git's i18n setup code for shell scripts
+
+SYNOPSIS
+--------
+'. "$(git --exec-path)/git-sh-i18n"'
+
+DESCRIPTION
+-----------
+
+This is not a command the end user would want to run.  Ever.
+This documentation is meant for people who are studying the
+Porcelain-ish scripts and/or are writing new ones.
+
+The 'git sh-i18n scriptlet is designed to be sourced (using
+`.`) by Git's porcelain programs implemented in shell
+script. It provides wrappers for the GNU `gettext` and
+`eval_gettext` functions accessible through the `gettext.sh`
+script, and provides pass-through fallbacks on systems
+without GNU gettext.
+
+FUNCTIONS
+---------
+
+gettext::
+	On GNU systems this will be the `gettext` function from
+	`gettext.sh`, on Solaris it`ll be the `gettext(1)`
+	command.
+
+	If neither of those implementations are available a
+	dummy fall-through function is provided.
+   =20
+eval_gettext::
+	On GNU systems this will be the `eval_gettext` function
+	from `gettext.sh`, on Solaris we provide an
+	`eval_gettext` using the
+	linkgit:git-sh-i18n--envsubst[1] helper.
+
+	If neither of those implementations are available a
+	dummy fall-through function is provided.
+
+Author
+------
+Written by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
+
+Documentation
+--------------
+Documentation by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason and the git-li=
st
+<git@vger.kernel.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 1f41812..e2dab69 100644
--- a/Makefile
+++ b/Makefile
@@ -381,6 +381,7 @@ SCRIPT_SH +=3D git-web--browse.sh
 SCRIPT_LIB +=3D git-mergetool--lib
 SCRIPT_LIB +=3D git-parse-remote
 SCRIPT_LIB +=3D git-sh-setup
+SCRIPT_LIB +=3D git-sh-i18n
=20
 SCRIPT_PERL +=3D git-add--interactive.perl
 SCRIPT_PERL +=3D git-difftool.perl
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
new file mode 100644
index 0000000..ea05e16
--- /dev/null
+++ b/git-sh-i18n.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+# This is a skeleton no-op implementation of gettext for Git. It'll be
+# replaced by something that uses gettext.sh in a future patch series.
+
+gettext () {
+	printf "%s" "$1"
+}
+
+eval_gettext () {
+	printf "%s" "$1" | (
+		export PATH $(git sh-i18n--envsubst --variables "$1");
+		git sh-i18n--envsubst "$1"
+	)
+}
--=20
1.7.4.1
