From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/17] contrib: remove 'git-shell-commands'
Date: Fri,  9 May 2014 14:11:35 -0500
Message-ID: <1399662703-355-10-git-send-email-felipe.contreras@gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 21:12:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqDh-0001Rg-MP
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211AbaEITM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:12:29 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:48601 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757195AbaEITMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:12:25 -0400
Received: by mail-yk0-f174.google.com with SMTP id 9so3811140ykp.19
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KOKQ9Yp8BVzjL9WtQsIokMS01aBvI8D0VI1fb0dPvMo=;
        b=T/0ymEeYOTtguLc/5hRU7H24yt9BZ0Vkk873VpPpfnRD55eYvUKJlxYYgGJE13/uRY
         97v/aqVsFEwKasRuve2EEbWnosU+V4CTK/H9Pg+ymEwpkCNSONkCIxHmwF07tsJeBGON
         e3+t5o0cLAYVT+Kyn6mFTkObPs7sqY810R3MjG7nyiIjcmMcZPt/1ar/LgmjpHGcoAZm
         mS6K/Kmr74ELk/2yEwUoQxAnEKvhjDDOxm8koBeD0HnyuUaHpgxPlJ6q0XIrA67OzrGn
         lq0PRn92IjWQxZ+5GmNn2SnhMWw1Rx1x19Chy8QPsghPOxpKeG0RG3pQ1dJIzllmeZuX
         6+uQ==
X-Received: by 10.236.44.132 with SMTP id n4mr17422149yhb.161.1399662744113;
        Fri, 09 May 2014 12:12:24 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c25sm7425603yhn.3.2014.05.09.12.12.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 12:12:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.28.g12374c0
In-Reply-To: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248620>

No activity, no tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/git-shell-commands/README | 18 ------------------
 contrib/git-shell-commands/help   | 18 ------------------
 contrib/git-shell-commands/list   | 10 ----------
 3 files changed, 46 deletions(-)
 delete mode 100644 contrib/git-shell-commands/README
 delete mode 100755 contrib/git-shell-commands/help
 delete mode 100755 contrib/git-shell-commands/list

diff --git a/contrib/git-shell-commands/README b/contrib/git-shell-commands/README
deleted file mode 100644
index 438463b..0000000
--- a/contrib/git-shell-commands/README
+++ /dev/null
@@ -1,18 +0,0 @@
-Sample programs callable through git-shell.  Place a directory named
-'git-shell-commands' in the home directory of a user whose shell is
-git-shell.  Then anyone logging in as that user will be able to run
-executables in the 'git-shell-commands' directory.
-
-Provided commands:
-
-help: Prints out the names of available commands.  When run
-interactively, git-shell will automatically run 'help' on startup,
-provided it exists.
-
-list: Displays any bare repository whose name ends with ".git" under
-user's home directory.  No other git repositories are visible,
-although they might be clonable through git-shell.  'list' is designed
-to minimize the number of calls to git that must be made in finding
-available repositories; if your setup has additional repositories that
-should be user-discoverable, you may wish to modify 'list'
-accordingly.
diff --git a/contrib/git-shell-commands/help b/contrib/git-shell-commands/help
deleted file mode 100755
index 535770c..0000000
--- a/contrib/git-shell-commands/help
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/sh
-
-if tty -s
-then
-	echo "Run 'help' for help, or 'exit' to leave.  Available commands:"
-else
-	echo "Run 'help' for help.  Available commands:"
-fi
-
-cd "$(dirname "$0")"
-
-for cmd in *
-do
-	case "$cmd" in
-	help) ;;
-	*) [ -f "$cmd" ] && [ -x "$cmd" ] && echo "$cmd" ;;
-	esac
-done
diff --git a/contrib/git-shell-commands/list b/contrib/git-shell-commands/list
deleted file mode 100755
index 6f89938..0000000
--- a/contrib/git-shell-commands/list
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-
-print_if_bare_repo='
-	if "$(git --git-dir="$1" rev-parse --is-bare-repository)" = true
-	then
-		printf "%s\n" "${1#./}"
-	fi
-'
-
-find -type d -name "*.git" -exec sh -c "$print_if_bare_repo" -- \{} \; -prune 2>/dev/null
-- 
1.9.2+fc1.28.g12374c0
