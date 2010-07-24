From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 13/22] Document line history browser
Date: Sat, 24 Jul 2010 23:13:45 +0800
Message-ID: <1279984434-28933-14-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:15:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgRr-00020D-G5
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101Ab0GXPPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:15:14 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64670 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab0GXPPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:15:11 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so3930617pvc.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Y8q1Urg9nn2tqp/gCB/Rcpx/aGEvYGAxBTInfaeiT0Q=;
        b=sMG408IBtijUByXFkm6Xyq+5UraR0RW7owHPITInFdb7pfUZ7t70bygkEvqPhWkY1l
         bcQd9hbNI75+aWbGtGUUM7koXL5+C4bD5qLs2xlB4YY43ja5KoYAgmA+ncTLB6Bl2Sgf
         LUo+RhQXvQOjRZ84DhV1iu7x9w3nbrXq2ruKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MrG4HB4Sf3+tdb3jCBCaWxmHb0iAP/QoU10ogIVPfaqtX5M++mfBLxtnUUnEk2BXfo
         3D14lWCME4pr3TFIklXUKtbYIWLi7Ganrn0Ua2WYGtFAjaYmoB24GOA1aVRfPLN8oOFS
         jTZGoJ36kOd1oqrY+KX9TznHxbZFrvODrWR48=
Received: by 10.142.225.8 with SMTP id x8mr5976028wfg.291.1279984511476;
        Sat, 24 Jul 2010 08:15:11 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.15.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:15:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151644>

Both 'git log' and 'git blame' support the same format
of '-L' arguments, so we refactor its description into
a new file.

And it is possible to use more than one '-L' option
for each path.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Documentation/blame-options.txt     |   19 +------------------
 Documentation/git-log.txt           |   15 +++++++++++++++
 Documentation/line-range-format.txt |   18 ++++++++++++++++++
 3 files changed, 34 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/line-range-format.txt

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 16e3c68..3526835 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -13,24 +13,7 @@
 	Annotate only the given line range.  <start> and <end> can take
 	one of these forms:
 
-	- number
-+
-If <start> or <end> is a number, it specifies an
-absolute line number (lines count from 1).
-+
-
-- /regex/
-+
-This form will use the first line matching the given
-POSIX regex.  If <end> is a regex, it will search
-starting at the line given by <start>.
-+
-
-- +offset or -offset
-+
-This is only valid for <end> and will specify a number
-of lines before or after the line given by <start>.
-+
+include::line-range-format.txt[]
 
 -l::
 	Show long rev (Default: off).
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index e970664..6f712e7 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -9,6 +9,7 @@ git-log - Show commit logs
 SYNOPSIS
 --------
 'git log' [<options>] [<since>..<until>] [[\--] <path>...]
+'git log' [<options>] -L n,m <path>
 
 DESCRIPTION
 -----------
@@ -19,6 +20,9 @@ command to control what is shown and how, and options applicable to
 the 'git diff-*' commands to control how the changes
 each commit introduces are shown.
 
+With '-L' option, the command will help to trace the history of user specified
+line ranges. It can trace multiple ranges coming from multiple files.
+
 
 OPTIONS
 -------
@@ -63,6 +67,17 @@ OPTIONS
 	Note that only message is considered, if also a diff is shown
 	its size is not included.
 
+-L <start>,<end>::
+	The line range.  <start> and <end> can take one of these forms:
+
+include::line-range-format.txt[]
+You can also specify this option more than once before each path.
+
+
+--full-line-diff::
+	Always print the interesting range even if the current commit
+	does not change any line of the range.
+
 [\--] <path>...::
 	Show only commits that affect any of the specified paths. To
 	prevent confusion with options and branch names, paths may need
diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
new file mode 100644
index 0000000..265bc23
--- /dev/null
+++ b/Documentation/line-range-format.txt
@@ -0,0 +1,18 @@
+- number
++
+If <start> or <end> is a number, it specifies an
+absolute line number (lines count from 1).
++
+
+- /regex/
++
+This form will use the first line matching the given
+POSIX regex.  If <end> is a regex, it will search
+starting at the line given by <start>.
++
+
+- +offset or -offset
++
+This is only valid for <end> and will specify a number
+of lines before or after the line given by <start>.
++
-- 
1.7.0.2.273.gc2413.dirty
