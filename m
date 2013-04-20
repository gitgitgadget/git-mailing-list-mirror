From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] git-shortlog.txt: make SYNOPSIS match log, update OPTIONS
Date: Sat, 20 Apr 2013 17:15:13 +0530
Message-ID: <1366458313-7186-6-git-send-email-artagnon@gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 20 13:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTWEp-0000g4-4p
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 13:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120Ab3DTLph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 07:45:37 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:54417 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab3DTLpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 07:45:33 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so2708360pdi.36
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 04:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UX2qhda7/25Fe/5BZnEQUNejIVjZr+GtduixO0OFIV4=;
        b=lzuybTXL3GBgdLl0yN6+SQf+/00G0LTFswVzsVaO+TxqakQxvOGOYAILM2YfWRAlTI
         rtXg7DC56+caOj9EtargDc71F5wyMD9KphWdJvU1hQmCBAFBHKiedOAhhTAlChiOaMpD
         nuCcj5MxnoiUuGqHXG62BkaU7cS/L8zEU0DKBrP/r8ebqWDUaXIfBbBVC2uCJCy58luA
         aTPg/CsLt6Ycqgb9DFusF4xX9Ayqy51Za7krhowCN+Px1wwxvNeqfeT698yktScg1i7M
         ZlhnDg09rCdSBOHA7j6w8WralFbE+f8M8Tdp7AOs33JtidGo2WXpc03wzlxsNj/Q3/Bb
         U1aA==
X-Received: by 10.66.150.165 with SMTP id uj5mr3562792pab.37.1366458332567;
        Sat, 20 Apr 2013 04:45:32 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id ag4sm629048pbc.20.2013.04.20.04.45.30
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 04:45:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.506.gbce9ff0
In-Reply-To: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221847>

There are broadly two problems with the current SYNOPSIS.  First, it
completely omits the detail that paths can be specified.  Second, it
attempts to list all the options: this is futile as, in addition to
the options unique to it, it accepts all the options that git-rev-list
accepts.  In fixing these problems, make the SYNOPSIS consistent with
that in git-log.txt.  Also add the corresponding sections to OPTIONS.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-shortlog.txt | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index c7f7f51..d02ac03 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,8 +8,8 @@ git-shortlog - Summarize 'git log' output
 SYNOPSIS
 --------
 [verse]
-git log --pretty=short | 'git shortlog' [-h] [-n] [-s] [-e] [-w]
-'git shortlog' [-n|--numbered] [-s|--summary] [-e|--email] [-w[<width>[,<indent1>[,<indent2>]]]] <commit>...
+git log --pretty=short | 'git shortlog' [<options>]
+'git shortlog' [<options>] [<since>..<until>] [[\--] <path>...]
 
 DESCRIPTION
 -----------
@@ -26,6 +26,13 @@ reference to the current repository.
 OPTIONS
 -------
 
+<since>..<until>::
+	Consider only commits between the named two revisions.  When
+	either <since> or <until> is omitted, it defaults to `HEAD`,
+	i.e. the tip of the current branch.  For a more complete list
+	of ways to spell <since>..<until>, see
+	linkgit:gitrevisions[7].
+
 -n::
 --numbered::
 	Sort output according to the number of commits per author instead
@@ -56,6 +63,16 @@ OPTIONS
 If width is `0` (zero) then indent the lines of the output without wrapping
 them.
 
+[\--] <path>...::
+	Consider only commits that are enough to explain how the files
+	that match the specified paths came to be.  See "History
+	Simplification" below for details and other simplification
+	modes.
++
+Paths may need to be prefixed with "\-- " to separate them from
+options or revisions, when confusion arises.
+
+include::rev-list-options.txt[]
 
 MAPPING AUTHORS
 ---------------
-- 
1.8.2.1.506.gbce9ff0
