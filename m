From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/14] stash: add --stage to pop and apply
Date: Mon, 14 Oct 2013 17:29:17 -0500
Message-ID: <1381789769-9893-3-git-send-email-felipe.contreras@gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 15 00:35:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqjw-00071V-4v
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757594Ab3JNWfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:35:47 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:64710 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756848Ab3JNWfr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:35:47 -0400
Received: by mail-ob0-f181.google.com with SMTP id va2so5191582obc.26
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9z8jveRY8CapATYYBBDg2VEIebv2kSqv/2WmaB6gn8Y=;
        b=e9CO5cSmj2iKoqdD5iWMvTVXIsNh/UYHODRyX13oJ0n+HWv641t08hjLPlhP1cw360
         fv+ZbyTQ6/Z01LamDCPjslo7KbHYRV2s2sYZQFH6QQeCvpTOg83J2ADtsaYuMLOeOq6E
         B9lRI2TJzTXCW9HtYTEVo9ApeJw/sHVttuG4s05SI0XyvhEbOBaFsOwc0X96v+cGRzcB
         d+ZXunYUjd6rw7iW/tS4h2N2aOFESp7wb2S86aeET52vNANmJfEfUxeBv9yJlkyAYVUp
         gU54yY9T8YefqNDIvQQF20Wwujz8uFM1P6Ai4IxMoxD+DBv03TrSy4sThgoDypkGGw+7
         OP8A==
X-Received: by 10.60.117.225 with SMTP id kh1mr30038047oeb.15.1381790146572;
        Mon, 14 Oct 2013 15:35:46 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm121854392oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 15:35:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236129>

Synonym of --index.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stash.txt | 8 ++++----
 git-stash.sh                | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 21a01c2..5fdaa35 100644
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
