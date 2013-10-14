From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/14] stash: add --stage option to save
Date: Mon, 14 Oct 2013 17:29:29 -0500
Message-ID: <1381789769-9893-15-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Oct 15 00:36:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqkk-0007Zn-BV
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279Ab3JNWg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:36:29 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:62485 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249Ab3JNWg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:36:27 -0400
Received: by mail-ob0-f177.google.com with SMTP id wm4so5238665obc.22
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KilhTAXOI8ZmMUomhC7OyvRhoTg0uHxG0nBUwRz2EcE=;
        b=prjYrYWZ9z0nXV9wHrR7HHV2YiqiSSfmjpDU9ZEPi/DDe7kW3CblgvRCz+dYF/KTrS
         Z2EIGvWBFrnh9z4SPGANTjKldineg2Hqgg62HJJhhx7giLYIKlx09c5dzVhvzJ84pWu/
         hz6tKrLl0Vu+lWj2P/0VGsZO9rP0N7nIHn/R7Qkxp1Fcax0IYT4hgpbqEvCk+JRVuRbz
         beqccg82RMjOoPaHrQsrZuM4SjUZCEkf0QTYfQ/R7+HqKvRWBA32Ym4ObbEBJY12sFuO
         8Wf9oTGcgyYqlQ58rpCnfNk0WLu6zXy5G8vY76MuH1wcOK0pgclvezNBMam2cPiyJZUi
         JlSA==
X-Received: by 10.182.73.136 with SMTP id l8mr2692644obv.53.1381790187124;
        Mon, 14 Oct 2013 15:36:27 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id j9sm121884438oef.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 15:36:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236142>

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
