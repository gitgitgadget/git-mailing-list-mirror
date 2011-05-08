From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/4] git-sh-i18n.sh: add no-op gettext() and eval_gettext() wrappers
Date: Sun,  8 May 2011 12:10:57 +0000
Message-ID: <1304856659-10672-3-git-send-email-avarab@gmail.com>
References: <1304856659-10672-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:11:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2pk-0007gR-5D
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646Ab1EHMLc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:11:32 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34772 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab1EHMLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:11:31 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1326170ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=dQk8KldWMBh112qQgR2UdY+ItdTzlKyeRJD7Q0lAdKk=;
        b=JwOk0776nB1grAkzbIOuk++RSgKSxYV1jd+xxJmyFwBzFbeNkNClSU5ulG8FvUNmQr
         nzLWar2X6kJ656CRlRGLKqY91D4TS2UHl6eRrqbJXc8Kptfn4JDIKoPjTuDXfPUDtJlP
         c1ihVByU3JPtH+RHzwtaaCRz7pz4Uaur5baxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZtQqX6cLcidvFqDObBCXlGA+u6rqAnSugISJx7vEuKEZ9Y8j0m7KVpB2SGDELCzYJt
         tPZnnwf1uRW61M36UwmmXV7NLm//OXyfKU0779u8KnH+Jd+bsa77u8yiHW0bdbRRKc07
         fJ+MM4/58BsYxtxzjI+968gbMwNABiwirnnrE=
Received: by 10.14.124.76 with SMTP id w52mr2625922eeh.201.1304856690499;
        Sun, 08 May 2011 05:11:30 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id s62sm2713947eea.24.2011.05.08.05.11.25
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:11:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304856659-10672-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173100>

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
index 87c83cb..83889f3 100644
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
