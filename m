From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] submodule: make 'show' an alias for 'summary'
Date: Sat, 29 Sep 2012 19:13:14 +0530
Message-ID: <1348926195-4788-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 15:44:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THxLB-0008Eh-PJ
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 15:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab2I2NoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 09:44:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35042 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359Ab2I2NoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 09:44:09 -0400
Received: by pbbrr4 with SMTP id rr4so6234562pbb.19
        for <git@vger.kernel.org>; Sat, 29 Sep 2012 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=+YwpunhtIFplLeAIthHb7IMUUCOn9dKooXvWLGhqWLA=;
        b=Q508UwcBz4j9iFEEwafGXYIv6goMrkaOfW6EbeI+ZHlvrW6pgoMj5dH5NOC42/jUF8
         dGcqDalYbXAPPKbkEpGnz641VPdRyr/6Yic6pEUWnWTGiTM6RHQ8xIyCaHcDK2FvjktW
         yNA1wMvInnxShAZkAmBX3Ot2kaOnC/HhiJDL2WzsY+kVPw8R7lLQSihEEsEdAK2Kboqr
         s0eeJfXcRq+wAyfcT3grE5uGhjMvxaXQxtjr1OwgCk5B9ThjRX3fKPU1WI3V3VfFIjkU
         /Vb2ALPUdOnr9ihhjCr4y9nV8C6AUmDURdByNefE491akRGDc4O0StEXIraHvakUdF3L
         udLw==
Received: by 10.66.86.133 with SMTP id p5mr24578811paz.35.1348926248951;
        Sat, 29 Sep 2012 06:44:08 -0700 (PDT)
Received: from localhost.localdomain ([122.174.75.44])
        by mx.google.com with ESMTPS id qq9sm7248569pbb.24.2012.09.29.06.44.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 29 Sep 2012 06:44:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206647>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Like 'git remote show', 'git stash show'.

 Documentation/git-submodule.txt |    3 ++-
 git-submodule.sh                |    9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index fbbbcb2..498bb5c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
 	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
-'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
+'git submodule' [--quiet] summary|show [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--] [<path>...]
@@ -151,6 +151,7 @@ If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 
 summary::
+show::
 	Show commit summary between the given commit (defaults to HEAD) and
 	working tree/index. For a submodule in question, a series of commits
 	in the submodule between the given super project commit and the
diff --git a/git-submodule.sh b/git-submodule.sh
index 9210f3a..1d61ebd 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -889,6 +889,13 @@ cmd_summary() {
 	fi
 }
 #
+# Alias for cmd_summary
+#
+cmd_show()
+{
+    cmd_summary "$@"
+}
+#
 # List all submodules, prefixed with:
 #  - submodule not initialized
 #  + different revision checked out
@@ -1049,7 +1056,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | update | status | summary | sync)
+	add | foreach | init | update | status | summary | show | sync)
 		command=$1
 		;;
 	-q|--quiet)
-- 
1.7.10.4
