From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/8] sh-tools: add a git-sh-tools shell helper script
Date: Sun, 29 Mar 2009 22:03:43 -0700
Message-ID: <1238389428-69328-4-git-send-email-davvid@gmail.com>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com>
 <1238389428-69328-2-git-send-email-davvid@gmail.com>
 <1238389428-69328-3-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 30 07:06:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9h8-0004he-76
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbZC3FEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbZC3FEP
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:04:15 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:39536 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002AbZC3FEM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 01:04:12 -0400
Received: by mail-qy0-f118.google.com with SMTP id 16so3307690qyk.33
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 22:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ETdZcLlHXYiXjaZWZXP4kneVYl3SsoIDqt6GsSUUHLw=;
        b=Jy57vjDIYcjIEofe6cLTkc4e9ycsbvAKZqbxGqLPpcc3ZgRdFMMaA0793VGgd9Tpfq
         7FSwNw26oo4fxRXrx1+JOQP/ZrFNs5my3nPM+kI4zSFYHGcz7oPmKO4F9mHXLGvtgHTw
         LRX+OZmXzZAzaqWwXLmZxyto81o4vJx/o9tbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UP7pOc2R1Op1Yh/MdPiDbRos8vkok7gKdgY03xBEvQ8DU9PWETYAe7c+Hl3X81ahU6
         hD06ScszjVR4St+69hmVaCNRifhpQ/Sq5CMDYDUJIvcgEpa6X8omkahGKYReFNWwoT6+
         +5YWBAOYcjmx8oFGkqYgQLfmoXxPz4Sl8ALBQ=
Received: by 10.224.45.72 with SMTP id d8mr5588703qaf.155.1238389451056;
        Sun, 29 Mar 2009 22:04:11 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm5257761qwe.45.2009.03.29.22.04.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 22:04:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.404.gb0085
In-Reply-To: <1238389428-69328-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115074>

git-sh-tools holds functions common to the git-*tool commands.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 .gitignore                     |    1 +
 Documentation/git-sh-tools.txt |   49 +++++++++++++++++++++++++++++++++++++++
 Makefile                       |    1 +
 command-list.txt               |    1 +
 git-sh-tools.sh                |   50 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-sh-tools.txt
 create mode 100644 git-sh-tools.sh

diff --git a/.gitignore b/.gitignore
index 966c886..cecf77e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -114,6 +114,7 @@ git-rm
 git-send-email
 git-send-pack
 git-sh-setup
+git-sh-tools
 git-shell
 git-shortlog
 git-show
diff --git a/Documentation/git-sh-tools.txt b/Documentation/git-sh-tools.txt
new file mode 100644
index 0000000..055a10c
--- /dev/null
+++ b/Documentation/git-sh-tools.txt
@@ -0,0 +1,49 @@
+git-sh-tool(1)
+==============
+
+NAME
+----
+git-sh-tools - Common git *tool shell script functions
+
+SYNOPSIS
+--------
+'. "$(git --exec-path)/git-sh-tools"'
+
+DESCRIPTION
+-----------
+
+This is not a command the end user would want to run.  Ever.
+This documentation is meant for people who are studying the
+Porcelain-ish scripts and/or are writing new ones.
+
+The 'git-sh-tools' scriptlet is designed to be sourced (using
+`.`) by other shell scripts to set up some functions for
+working with git merge/diff tools.
+
+Before sourcing it, your script should set up a few variables;
+`TOOL_MODE` is used to define the operation mode for various
+functions.  'diff' and 'merge' are valid values.
+
+FUNCTIONS
+---------
+valid_tool::
+	verifies that the specified merge tool is properly setup.
+
+valid_custom_tool::
+	verifies that a '(diff|merge)tool.<tool>.cmd' configuration exists.
+
+init_merge_tool_path::
+	sets up `$merge_tool_path` according to '(diff|merge)tool.<tool>.path'
+	configurations.
+
+Author
+------
+Written by David Aguilar <davvid@gmail.com>
+
+Documentation
+--------------
+Documentation by David Aguilar and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index d77fd71..3b7c20f 100644
--- a/Makefile
+++ b/Makefile
@@ -292,6 +292,7 @@ SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-sh-setup.sh
+SCRIPT_SH += git-sh-tools.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
diff --git a/command-list.txt b/command-list.txt
index fb03a2e..c3b6c87 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -109,6 +109,7 @@ git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-setup                            purehelpers
+git-sh-tools                            purehelpers
 git-stash                               mainporcelain
 git-status                              mainporcelain common
 git-stripspace                          purehelpers
diff --git a/git-sh-tools.sh b/git-sh-tools.sh
new file mode 100644
index 0000000..234bac7
--- /dev/null
+++ b/git-sh-tools.sh
@@ -0,0 +1,50 @@
+# Verifies that the chosen merge tool is properly setup.
+# Built-in merge tools are always valid.
+valid_tool() {
+	case "$1" in
+	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
+		;; # happy
+	*)
+		if ! valid_custom_tool "$1"; then
+			return 1
+		fi
+		;;
+	esac
+}
+
+# Verifies that (difftool|mergetool).<tool>.cmd exists
+# Requires $TOOL_MODE to be set.
+valid_custom_tool() {
+	if test "$TOOL_MODE" = "diff"; then
+		merge_tool_cmd="$(git config difftool.$1.cmd)"
+		test -z "$merge_tool_cmd" &&
+		merge_tool_cmd="$(git config mergetool.$1.cmd)"
+		test -n "$merge_tool_cmd"
+	elif test "$TOOL_MODE" = "merge"; then
+		merge_tool_cmd="$(git config mergetool.$1.cmd)"
+		test -n "$merge_tool_cmd"
+	fi
+}
+
+
+# Set up $merge_tool_path for (diff|merge)tool.<tool>.path configurations
+init_merge_tool_path() {
+	if test "$TOOL_MODE" = "diff"; then
+		merge_tool_path=$(git config difftool."$1".path)
+		test -z "$merge_tool_path" &&
+		merge_tool_path=$(git config mergetool."$1".path)
+	elif test "$TOOL_MODE" = "merge"; then
+		merge_tool_path=$(git config mergetool."$1".path)
+	fi
+
+	if test -z "$merge_tool_path" ; then
+		case "$1" in
+			emerge)
+				merge_tool_path=emacs
+				;;
+			*)
+				merge_tool_path=$1
+				;;
+		esac
+	fi
+}
-- 
1.6.1.3
