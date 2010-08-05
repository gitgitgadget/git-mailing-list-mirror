From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 18/18] Document line history browser
Date: Fri,  6 Aug 2010 00:11:57 +0800
Message-ID: <1281024717-7855-19-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:14:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh35L-0001XF-J5
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760088Ab0HEQNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:13:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55715 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756360Ab0HEQNn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:13:43 -0400
Received: by pzk26 with SMTP id 26so2533960pzk.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=iBR2PF7QRmE/t/PtqWhr+2IJFgsOKJf5OY3tWzqV5Vg=;
        b=kZOmxFHJEuJ+djowJFsf/UP0lcRSgIWvRwr4i6awL3ddXatwoui4Us9T1Z9i82WoTK
         n+pItmK+YQ09PBn2YGKE3oOdaTXSibXlEA67FhsYyLNgDrX7fwLkgHIYhENDXR3j3MzZ
         ZD3NKT475Ax2j0FM1t+e1Y5HjLXqSw8N6pPtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nM3vWKPwAkORDdxWm7id7D+3dhUv98lhJoVezep2tmzdJUHiqWgQNglaok6v/VJgA4
         4ZktnK3IbhXnTBSNYRbAcoMtNPQsRQeghKNiZs8UwWdNPkSOBbJSbR/4er2gWqgW6efG
         bBkwdoyXR7jcLdXDeW4ftQ7fX6uvCJoWFH6qI=
Received: by 10.142.103.14 with SMTP id a14mr28488wfc.245.1281024823165;
        Thu, 05 Aug 2010 09:13:43 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.13.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:13:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152678>

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
1.7.2.20.g388bbb
