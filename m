From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] remove #!interpreter line from shell libraries
Date: Thu, 8 Mar 2012 06:14:04 -0600
Message-ID: <20120308121403.GA16493@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 13:14:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5cEc-0008ID-8W
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 13:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab2CHMOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 07:14:14 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:65074 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751011Ab2CHMON convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 07:14:13 -0500
Received: by obbuo6 with SMTP id uo6so578351obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 04:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Um9OiE1Ykp3qBYILi+svcXndhYD4U6yGgAvG4R//zrM=;
        b=v+5gOyFdH28vzk7c1Hfs7E2h26EKtfEccQT+kFznvLmnvhjV4OS7L6HavlQUOE9v4T
         /0uS/eNbOUaJxh0hJ9SAxoUa3NWhL4JxbtC2b8My7Z+HqMUNVz2/uvTQZqvtJYfQZgCy
         9DuSH9ihdbFOdvl51+OntJnNe8+qhcePkPejoC2Aao1FZbGtMef45XPvD8T4rZw/p1X+
         H0B3Mt5O+FzmrqaPGLw6FIQFSPHrYO7SHoRhO/K9cZooDNpx3Rhj/5Z2FRdj3GQ7rSVP
         a+a3FHkTN/W+JxkWOViJFOldgEaT16HHExVtMu/OCueRJjlX9r5KDpf+K6QVTAx0REB6
         2zfw==
Received: by 10.182.147.106 with SMTP id tj10mr2199358obb.71.1331208852464;
        Thu, 08 Mar 2012 04:14:12 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a18sm2325208obu.15.2012.03.08.04.14.11
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 04:14:11 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192582>

As explained in v1.7.0-rc1~9 (2009-11-25), even when a script is
expected to be sourced instead of executed on its own, a #!/bin/sh
shebang line can provide useful documentation about what format the
file is in.  However, it is even clearer to include a comment and no
shebang at all, to avoid creating the illusion that the indicated
choice of shell will have any effect at runtime.

Add some text to each of git's shell libraries explaining in what
context the fragment is meant to be sourced and remove the shebangs.

Because these files are not marked executable, removing the #! lines
would not confuse the valgrind support of our test scripts, so this
should be safe.  Noticed by lintian.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

This patch has only an aesthetic justification but I think it is
basically good.  Last took a brief visit to the list at [1].  More
context at [2].  I'd be happy for any thoughts you have.

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/185079/focus=
=3D185106
[2] http://bugs.debian.org/368792
    http://thread.gmane.org/gmane.comp.version-control.git/138253/focus=
=3D138560

 git-mergetool--lib.sh      |    3 +--
 git-parse-remote.sh        |    4 +++-
 git-rebase--am.sh          |    3 ++-
 git-rebase--interactive.sh |    8 +++-----
 git-rebase--merge.sh       |    4 +++-
 git-sh-i18n.sh             |    5 ++---
 git-sh-setup.sh            |    9 +++------
 7 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index ed630b20..7a0f499b 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -1,5 +1,4 @@
-#!/bin/sh
-# git-mergetool--lib is a library for common merge tool functions
+# git-mergetool--lib is a shell library for common merge tool function=
s
 diff_mode() {
 	test "$TOOL_MODE" =3D diff
 }
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index b24119d6..739ff772 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -1,4 +1,6 @@
-#!/bin/sh
+# This is a shell library to calculate the remote repository and
+# upstream branch that should be pulled by "git pull" from the current
+# branch.
=20
 # git-ls-remote could be called from outside a git managed repository;
 # this would fail in that case and would issue an error message.
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index c815a241..5d8d451b 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -1,4 +1,5 @@
-#!/bin/sh
+# This shell script fragment is sourced by git-rebase to implement
+# its default, fast, patch-based, non-interactive mode.
 #
 # Copyright (c) 2010 Junio C Hamano.
 #
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5812222e..ff00b094 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1,11 +1,9 @@
-#!/bin/sh
 #
 # Copyright (c) 2006 Johannes E. Schindelin
=20
-# SHORT DESCRIPTION
-#
-# This script makes it easy to fix up commits in the middle of a serie=
s,
-# and rearrange commits.
+# This shell script fragment is sourced by git-rebase to implement
+# its interactive mode.  "git rebase --interactive" makes it easy
+# to fix up commits in the middle of a series and rearrange commits.
 #
 # The original idea comes from Eric W. Biederman, in
 # http://article.gmane.org/gmane.comp.version-control.git/22407
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index dc599077..0fa0e491 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -1,4 +1,6 @@
-#!/bin/sh
+# This shell script fragment is sourced by git-rebase to implement
+# its merge-based non-interactive mode that copes well with renamed
+# files.
 #
 # Copyright (c) 2010 Junio C Hamano.
 #
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index b4575fb3..eff20a08 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -1,9 +1,8 @@
-#!/bin/sh
+# This shell library is Git's interface to gettext.sh. See po/README
+# for usage instructions.
 #
 # Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
 #
-# This is Git's interface to gettext.sh. See po/README for usage
-# instructions.
=20
 # Export the TEXTDOMAIN* data that we need for Git
 TEXTDOMAIN=3Dgit
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 5d8e4e6c..51362d60 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -1,9 +1,6 @@
-#!/bin/sh
-#
-# This is included in commands that either have to be run from the top=
level
-# of the repository, or with GIT_DIR environment variable properly.
-# If the GIT_DIR does not look like the right correct git-repository,
-# it dies.
+# This shell scriplet is meant to be included by other shell scripts
+# to set up some variables pointing at the normal git directories and
+# a few helper shell functions.
=20
 # Having this variable in your environment would break scripts because
 # you would cause "cd" to be taken to unexpected places.  If you
--=20
1.7.9.2.792.g4ea66.dirty
