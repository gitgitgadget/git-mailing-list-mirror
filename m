From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 06/14] stash: add --stage option to save
Date: Fri, 25 Apr 2014 13:12:39 -0500
Message-ID: <1398449567-16314-7-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:24:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdknA-00079k-Ry
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbaDYSXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:23:43 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:56243 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbaDYSXl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:23:41 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so4614088oag.14
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s4wiUQO/ZzXcyz3yBPEUDbgtnXWiRSEfMtSrfLdlPZc=;
        b=GxWWjvZbXYNMafynkfYVsIBc5TT3zD8rEHb1qyaVhu5HzvmEj5TuKkm/KS9Q/WMFmk
         39DMjfJ1DSTFsxsmKSZJILGbl4pCSaREb9iynxOhxE9QUWJ4NT4XmBkXaXNlyOB/TOng
         OyxbLq3ztYJV8UCw7oDjJcf6ycXj9fcQ3PpcpfBsc7eoW3RDg3FbXjTkZDROvCtYYCkA
         n2PbOc91RoRf6By2NyBWgHTWTjPE6iTa4riegR4oUdZl6BW8AZUSUxRehHn+hVXoASLA
         bg/ETwUcr8o8K4AOtOqJO1U9Bz+K3XtLM3UwXXqTJ34rycZ5S07gxU2JTCWDUXZdvhzq
         8PeA==
X-Received: by 10.60.78.165 with SMTP id c5mr1774618oex.83.1398450221577;
        Fri, 25 Apr 2014 11:23:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ii8sm17056554obb.11.2014.04.25.11.23.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:23:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247079>

--no-stage is synonym for --keep-index.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stash.txt | 6 +++---
 git-stash.sh                | 8 +++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index db7e803..21a01c2 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+'git stash' [save [-p|--patch] [-k|--[no-]keep-index|--[no-]stage] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
 'git stash' create [<message>]
@@ -44,7 +44,7 @@ is also possible).
 OPTIONS
 -------
 
-save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+save [-p|--patch] [--[no-]keep-index|--[no-]stage] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
@@ -54,7 +54,7 @@ save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--
 	subcommand from making an unwanted stash.
 +
 If the `--keep-index` option is used, all changes already added to the
-index are left intact.
+index are left intact. Same with `--no-stage`, which is a synonym.
 +
 If the `--include-untracked` option is used, all untracked files are also
 stashed and then cleaned up with `git clean`, leaving the working directory
diff --git a/git-stash.sh b/git-stash.sh
index f0a94ab..bff4ecc 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,7 +7,7 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+   or: $dashless [save [--patch] [-k|--[no-]keep-index|--[no-]stage] [-q|--quiet]
 		       [-u|--include-untracked] [-a|--all] [<message>]]
    or: $dashless clear"
 
@@ -204,6 +204,12 @@ save_stash () {
 		--no-keep-index)
 			keep_index=n
 			;;
+		--stage)
+			keep_index=n
+			;;
+		--no-stage)
+			keep_index=t
+			;;
 		-p|--patch)
 			patch_mode=t
 			# only default to keep if we don't already have an override
-- 
1.9.2+fc1.2.gfbaae8c
