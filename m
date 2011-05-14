From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 2/4] git-sh-i18n.sh: add no-op gettext() and eval_gettext() wrappers
Date: Sat, 14 May 2011 13:47:43 +0000
Message-ID: <1305380865-21339-3-git-send-email-avarab@gmail.com>
References: <1305380865-21339-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 15:48:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLFCU-0007GJ-Af
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 15:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806Ab1ENNsD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2011 09:48:03 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56391 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757565Ab1ENNr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 09:47:58 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so914469ewy.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ru+BS5QEDiWmc4wiIYqvwOe6ck2zKjvR90B5WQT75NE=;
        b=j/3hPw5tjoI3RovtgeQmNiG+14FFSxhHXMLVfITH8LujNtMHUkgNyIauRjlQjXhTEl
         L5U5IK64dyi2XXq2VAc4OriwjtTCMaMiJG+3gxsi60qt153OSOY4Fq6C89agpmv935/A
         b4ktoifFS5Q8egcXnOvQpYRv9vKhkHo3toReE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ChM44bVgvbVmKNeN3wwsdczjYVattx6XWj5CfWy7X3vgsFfPJKYxurWBW/YULqJc+i
         OLhBb0rc9WEg4Hzsxq9m5NiU2hqhzsccSSKJM/bbo/BQxe+eEHt5BWnzEXmi91oYZCeV
         qWCkcpQwZlT8vXKrL9ocQhEKfuB56gAf0qDo4=
Received: by 10.213.8.76 with SMTP id g12mr206554ebg.111.1305380877538;
        Sat, 14 May 2011 06:47:57 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y9sm2110298eeh.8.2011.05.14.06.47.56
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 06:47:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1305380865-21339-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173587>

Add a no-op wrapper library for Git's shell scripts. To split up the
gettext series I'm first submitting patches to gettextize the source
tree before I add any of the Makefile and Shell library changes needed
to actually use them.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore                    |    1 +
 Documentation/git-sh-i18n.txt |   42 +++++++++++++++++++++++++++++++++=
++++++++
 Makefile                      |    1 +
 git-sh-i18n.sh                |   17 ++++++++++++++++
 4 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-sh-i18n.txt
 create mode 100644 git-sh-i18n.sh

diff --git a/.gitignore b/.gitignore
index 1ccf797..4bdb839 100644
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
index 0000000..8b86e5f
--- /dev/null
+++ b/Documentation/git-sh-i18n.txt
@@ -0,0 +1,42 @@
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
+	Currently a dummy fall-through function implemented as a wrapper
+	around `printf(1)`. Will be replaced by a real gettext
+	implementation in a later version.
+   =20
+eval_gettext::
+	Currently a dummy fall-through function implemented as a wrapper
+	around `printf(1)` with variables expanded by the
+	linkgit:git-sh-i18n--envsubst[1] helper. Will be replaced by a
+	real gettext implementation in a later version.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 56944c6..854fe69 100644
--- a/Makefile
+++ b/Makefile
@@ -381,6 +381,7 @@ SCRIPT_LIB +=3D git-rebase--am
 SCRIPT_LIB +=3D git-rebase--interactive
 SCRIPT_LIB +=3D git-rebase--merge
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
1.7.4.4
