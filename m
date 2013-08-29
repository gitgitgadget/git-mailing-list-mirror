From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/9] submodule: add --staged options
Date: Thu, 29 Aug 2013 13:14:37 -0500
Message-ID: <1377800080-5309-7-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
 <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:20:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6pq-00058J-Ht
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518Ab3H2SUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:20:38 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:62582 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746Ab3H2SUg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:20:36 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so1060842oag.7
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hAjGQSQhk6Y1wUNJYc6c3YrDF/lZDa73MDGwQc0EhJ0=;
        b=Jm2Fet6NZWQ75jD3bBKSj4v5N+P5o+80cSPikO5+EAUcI7XdlHNThidYOUsLLcDq0K
         4qiVrNRelEMebRB2keD5JXGA+TMVn+DYSoEA/dj5ERU5vOfvEGyDCMS1lcczqh/lhvH3
         0TU2vpWi8iRnvYq5KD8Mk7a2FlhkrNnb+rauPDS8r31N3592iz7kI+qeFJL9MAwMdwB0
         ohPSTqdVXPis5cCyjOohv1Js2z/KPKXA2y1QCGY672XSFrevVjUCwkW1USuXs6q6sYMz
         3ViBZVBDlxKblkkLoC2Io5WYrCaMpF9eGKjansYk7qqeaBsMGLpC30o1OBTDrUuhnyRU
         eW6g==
X-Received: by 10.182.233.198 with SMTP id ty6mr3573227obc.31.1377800435904;
        Thu, 29 Aug 2013 11:20:35 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id b5sm32695018obj.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:20:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233315>

Synonym for --cached.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-submodule.txt |  8 ++++++--
 git-submodule.sh                | 10 +++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bfef8a0..904e007 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -11,13 +11,13 @@ SYNOPSIS
 [verse]
 'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
 	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
-'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
+'git submodule' [--quiet] status [--cached|--staged] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase] [--reference <repository>] [--depth <depth>]
 	      [--merge] [--recursive] [--] [<path>...]
-'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
+'git submodule' [--quiet] summary [--cached|--staged|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--] [<path>...]
@@ -248,6 +248,10 @@ OPTIONS
 	commands typically use the commit found in the submodule HEAD, but
 	with this option, the commit stored in the index is used instead.
 
+
+--staged::
+	Synonym for `--cached`.
+
 --files::
 	This option is only valid for the summary command. This command
 	compares the commit in the index with that in the submodule HEAD
diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..823b783 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,11 +6,11 @@
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
-   or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] status [--cached|--staged] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
    or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
-   or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
+   or: $dashless [--quiet] summary [--cached|--staged|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
 OPTIONS_SPEC=
@@ -972,7 +972,7 @@ cmd_summary() {
 	while test $# -ne 0
 	do
 		case "$1" in
-		--cached)
+		--cached|--staged)
 			cached="$1"
 			;;
 		--files)
@@ -1181,7 +1181,7 @@ cmd_status()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
-		--cached)
+		--cached|--staged)
 			cached=1
 			;;
 		--recursive)
@@ -1348,7 +1348,7 @@ do
 		esac
 		branch="$2"; shift
 		;;
-	--cached)
+	--cached|--staged)
 		cached="$1"
 		;;
 	--)
-- 
1.8.4-fc
