From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/7] git-shortlog.txt: make SYNOPSIS match log, update OPTIONS
Date: Sun, 21 Apr 2013 14:20:52 +0530
Message-ID: <1366534252-12099-8-git-send-email-artagnon@gmail.com>
References: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:51:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpzb-0008Nr-Mb
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab3DUIvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:51:21 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:53238 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab3DUIvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:51:14 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so99137dal.40
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=G4BjButZQO7o7RPtWlQtmWB6zWNe8WsQZPW6jPA363M=;
        b=jBWhFI84TF84Khrqg6+jpV7TGFHxsrjkh70+XuAI/MsWiBe8twZW1ChhP4Ap2doTil
         9rquAdmzpjgfPLiRNJrXHA5r3jZekiXsS3LMO/ZMvuV5wFFofLLSC/tuxPrgCCVul1DB
         Ak5DTwc/edjl62FALw+Xmh57Puxuuotl0cyoGiCf9dm7r+layLL3AWG/kIHiqVULhIJk
         Jo2iF8BLcoyS8BQyXHFNp1JOgrbgRvv75zouZACKMYZijMNs92KziKW2C06ydCchGdo8
         YhRMJRk2egvNQEqhw/8ckPCLT+9cH1vXfiSsY7lOY+WdpiYsnhVKTZvmDdYgWXEhvHEp
         0OHA==
X-Received: by 10.68.134.36 with SMTP id ph4mr26642211pbb.181.1366534274315;
        Sun, 21 Apr 2013 01:51:14 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id mm9sm20241909pbc.43.2013.04.21.01.51.12
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 01:51:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221934>

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
 Documentation/git-shortlog.txt | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index c7f7f51..2a66518 100644
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
@@ -56,6 +56,23 @@ OPTIONS
 If width is `0` (zero) then indent the lines of the output without wrapping
 them.
 
+<revision range>::
+	Consider only commits in the specified revision range.  When no
+	<revision range> is specified, it defaults to 'HEAD' (ie. the
+	whole history leading to the current commit).  master..next
+	specifies all the commits reachable from 'next, but not from
+	'master'. For a complete list of ways to spell
+	<revision range>, see the "Specifying Ranges" section of
+	linkgit:gitrevisions[7].
+
+[\--] <path>...::
+	Consider only commits that are enough to explain how the files
+	that match the specified paths came to be.  See "History
+	Simplification" below for details and other simplification
+	modes.
++
+Paths may need to be prefixed with "\-- " to separate them from
+options or the revision range, when confusion arises.
 
 MAPPING AUTHORS
 ---------------
-- 
1.8.2.1.501.gd2949c7
