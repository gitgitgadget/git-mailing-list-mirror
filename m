From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/7] git-shortlog.txt: make SYNOPSIS match log, update OPTIONS
Date: Mon, 22 Apr 2013 11:00:30 +0530
Message-ID: <1366608631-21734-7-git-send-email-artagnon@gmail.com>
References: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 07:30:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU9L4-0005j7-1X
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 07:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115Ab3DVFau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 01:30:50 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:43863 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab3DVFat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 01:30:49 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so3297193pdi.7
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nKNssWiKzHplTBv4WRLaCGr8cqZ7nCnovTNeRVbqL8Q=;
        b=AlrlLZH9d5UTbz/FvYSTD01MJBI0giqm9Zs056qtUaYA6egO0Y7XdptJAYyO+CvMR+
         rFIMEgq6GHtspSspgR8sxAOt85L9Zvf64ExujSrnAMxh2bcfK1j4dwW3xExn3q29H43c
         HNUa5B0V2VlDh6QrAhwPJoiLjHqoxMT+DEQkhaPehCmo24EYtYh7+JMn+FE3Qjfc4/Py
         YdjYJT+pVpHQNGycN0PsRRP1TxEUdz8nGzYGmsn9vkhGIYCbucKDK1SsCPTuKE0FX+Tj
         v5fmwYW/vRXdTaPmgvCaycXx9rIewS9VY7nVDCwrOcJwP/1JxjCmuXKIm9b4og9L5UBT
         jcYQ==
X-Received: by 10.66.248.40 with SMTP id yj8mr6378247pac.95.1366608648837;
        Sun, 21 Apr 2013 22:30:48 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id em2sm11144653pbb.0.2013.04.21.22.30.46
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 22:30:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221994>

There are broadly two problems with the current SYNOPSIS.  First, it
completely omits the detail that paths can be specified.  Second, it
attempts to list all the options: this is futile as, in addition to
the options unique to it, it accepts all the options that git-rev-list
accepts.  In fixing these problems, make the SYNOPSIS consistent with
that in git-log.txt.  Also add the corresponding sections to OPTIONS.
Save adding the options from rev-list-options.txt for a later patch,
as it requires some work to pick out the options that are relevant to
shortlog.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-shortlog.txt | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index c7f7f51..31af7f2 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,8 +8,8 @@ git-shortlog - Summarize 'git log' output
 SYNOPSIS
 --------
 [verse]
-git log --pretty=short | 'git shortlog' [-h] [-n] [-s] [-e] [-w]
-'git shortlog' [-n|--numbered] [-s|--summary] [-e|--email] [-w[<width>[,<indent1>[,<indent2>]]]] <commit>...
+git log --pretty=short | 'git shortlog' [<options>]
+'git shortlog' [<options>] [<revision range>] [[\--] <path>...]
 
 DESCRIPTION
 -----------
@@ -56,6 +56,21 @@ OPTIONS
 If width is `0` (zero) then indent the lines of the output without wrapping
 them.
 
+<revision range>::
+	Show only commits in the specified revision range.  When no
+	<revision range> is specified, it defaults to `HEAD` (i.e. the
+	whole history leading to the current commit).  `origin..HEAD`
+	specifies all the commits reachable from the current commit
+	(i.e. `HEAD`), but not from `origin`. For a complete list of
+	ways to spell <revision range>, see the "Specifying Ranges"
+	section of linkgit:gitrevisions[7].
+
+[\--] <path>...::
+	Consider only commits that are enough to explain how the files
+	that match the specified paths came to be.
++
+Paths may need to be prefixed with "\-- " to separate them from
+options or the revision range, when confusion arises.
 
 MAPPING AUTHORS
 ---------------
-- 
1.8.2.1.501.gd2949c7
