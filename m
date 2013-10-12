From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 06/14] stash: add --stage option to save
Date: Sat, 12 Oct 2013 02:04:48 -0500
Message-ID: <1381561488-20294-15-git-send-email-felipe.contreras@gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMa-0004MJ-9f
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab3JLHLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:35 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:43327 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab3JLHLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:31 -0400
Received: by mail-oa0-f52.google.com with SMTP id n2so3106425oag.39
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3LKQoqt6c9wcyKwxavDlNf6Zs5ainVLBM9c7zQ+Jw0M=;
        b=HgmZUC5w3tmz71Qz7aHNdxz+zqIhopdnRpUUHrVtZAC1tdgmal2uWPFjDweX9wzwdW
         aoZqu1DgPWYvOxekoCCi5hs+zM4BcEq53NE282hhAukEFLUBR0afWZTqgmW34NO+Wu3U
         DYQ9Tp9rETwrAVY6+OdU+8OdrSIw7LKj0zXp1tcVuY1Fzb/EilUCQ20sBkpRh/FIZebH
         iGUKomtE56r0LiWxZVezKHLqXNcotVhFtAz46waP30C99ZFwiiGOmTQpCHrA0boHX/kd
         OWTYe/e0s83QIR+utw+6K9JEh6dH8oNx1aJbaglJvH6rWtErlCAAqPX/Zg0yJJQCM7ed
         MjrA==
X-Received: by 10.182.40.134 with SMTP id x6mr17793184obk.31.1381561891192;
        Sat, 12 Oct 2013 00:11:31 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm28644848obc.10.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235975>

--no-stage is synonym for --keep-index.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stash.txt | 6 +++---
 git-stash.sh                | 8 +++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index db7e803..75b4cc6 100644
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
+index are left intact. Same with `--no-stage`, which is a snynonym.
 +
 If the `--include-untracked` option is used, all untracked files are also
 stashed and then cleaned up with `git clean`, leaving the working directory
diff --git a/git-stash.sh b/git-stash.sh
index 1e541a2..47220d0 100755
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
1.8.4-fc
