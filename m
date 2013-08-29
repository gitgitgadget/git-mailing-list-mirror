From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/9] stash: add --stage to pop and apply
Date: Thu, 29 Aug 2013 13:14:36 -0500
Message-ID: <1377800080-5309-6-git-send-email-felipe.contreras@gmail.com>
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
	id 1VF6pq-00058J-0v
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756600Ab3H2SU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:20:29 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:58284 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283Ab3H2SU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:20:26 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so1068628oag.16
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qvWmDkidYZIMWV1mKIW8FgTz6Hk9UtU5HWtzFZVjluQ=;
        b=fU0BI2VqDgV4/QeJNDDqp8/+ZOD1x9mSo3upWjidi7y2rbPguwmduWRiAsu2qtV36/
         pHiQ0gcl3vLwhtI1b/JTmj3UibAoGALorZPd8uOWIayQuhmtnEelkrzI0zOJOeBuP267
         Ea1BgMdf05/O5QZZzmG/wzsq5OFJvjzVyVZIzH6AlWZ2peEE8UpRcOKcxkgvWB1eTQKe
         MHduL4ve8Qkoh3AqFOx4V20RBJYMdbSWADIx5HmzkPkiAUKg5zA22aObgMmNW8TZN6Ip
         7gTQMjiytb8ae82H1JTckGCa1t8UiaKonprlV31JOVeJ66PJXAkqnXTxGL0I21AwFJRe
         CiFg==
X-Received: by 10.60.40.67 with SMTP id v3mr3623226oek.16.1377800426373;
        Thu, 29 Aug 2013 11:20:26 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm32727913obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:20:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233314>

Synonym of --index.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stash.txt | 8 ++++----
 git-stash.sh                | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 75b4cc6..b4066fd 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git stash' list [<options>]
 'git stash' show [<stash>]
 'git stash' drop [-q|--quiet] [<stash>]
-'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
+'git stash' ( pop | apply ) [--index|--stage] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index|--[no-]stage] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
@@ -96,7 +96,7 @@ show [<stash>]::
 	it will accept any format known to 'git diff' (e.g., `git stash show
 	-p stash@{1}` to view the second most recent stash in patch form).
 
-pop [--index] [-q|--quiet] [<stash>]::
+pop [--index|--stage] [-q|--quiet] [<stash>]::
 
 	Remove a single stashed state from the stash list and apply it
 	on top of the current working tree state, i.e., do the inverse
@@ -110,12 +110,12 @@ and call `git stash drop` manually afterwards.
 If the `--index` option is used, then tries to reinstate not only the working
 tree's changes, but also the index's ones. However, this can fail, when you
 have conflicts (which are stored in the index, where you therefore can no
-longer apply the changes as they were originally).
+longer apply the changes as they were originally). `--stage` is a synonym.
 +
 When no `<stash>` is given, `stash@{0}` is assumed, otherwise `<stash>` must
 be a reference of the form `stash@{<revision>}`.
 
-apply [--index] [-q|--quiet] [<stash>]::
+apply [--index|--stage] [-q|--quiet] [<stash>]::
 
 	Like `pop`, but do not remove the state from the stash list. Unlike `pop`,
 	`<stash>` may be any commit that looks like a commit created by
diff --git a/git-stash.sh b/git-stash.sh
index 47220d0..e2eb8dc 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -5,7 +5,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="list [<options>]
    or: $dashless show [<stash>]
    or: $dashless drop [-q|--quiet] [<stash>]
-   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
+   or: $dashless ( pop | apply ) [--index|--stage] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless [save [--patch] [-k|--[no-]keep-index|--[no-]stage] [-q|--quiet]
 		       [-u|--include-untracked] [-a|--all] [<message>]]
@@ -373,7 +373,7 @@ parse_flags_and_rev()
 			-q|--quiet)
 				GIT_QUIET=-t
 			;;
-			--index)
+			--index|--stage)
 				INDEX_OPTION=--index
 			;;
 			-*)
-- 
1.8.4-fc
