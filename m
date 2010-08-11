From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 17/17] Document line history browser
Date: Wed, 11 Aug 2010 23:03:42 +0800
Message-ID: <1281539022-31616-18-git-send-email-struggleyb.nku@gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:06:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCst-0005tW-PF
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846Ab0HKPGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:06:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62685 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab0HKPGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:06:03 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so75417pvg.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RLe6NAi29zpxWiFjp7Kj7ggZPz2r0+8WWdGv5DoPw68=;
        b=qSOfHW/RcQGv7AXWKBXYq6VZYRetimAy1tApaOBdHjJU1AGt1N2eWrKn7P9d3QRtw5
         a4inEttXqINmlIK67684cjQbp5cyy6CN6p1geDqugb02zaY4AodlPfc1AlnePbr96tLt
         xnPEVEDO/Sbcg0hoUaj166B9mmasVcbikYx9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EDK3yRQ9RP/gEPEXs6TWsSqrQNWg+A99utCNhP4NHssE+TM81YlxpF+Jk19PKSGfJT
         60SUK3HPIeblnXpDd8oKYMaRN7c3M0cU5M2YVib/sB58WRzEUlh9+V3jJ85DSAEALwY7
         rTe61Oz3gWZ+dUtKugG7c2FER0DIF+3xxa3m4=
Received: by 10.114.79.1 with SMTP id c1mr22154754wab.1.1281539163604;
        Wed, 11 Aug 2010 08:06:03 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.05.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:06:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153256>

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
1.7.2.19.g79e5d
