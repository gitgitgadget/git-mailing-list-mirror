From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 07/14] stash: add --stage to pop and apply
Date: Sat, 12 Oct 2013 02:04:36 -0500
Message-ID: <1381561488-20294-3-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtLr-0003v3-C4
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab3JLHK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:10:58 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:53326 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab3JLHK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:10:56 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so3442119obc.41
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qvWmDkidYZIMWV1mKIW8FgTz6Hk9UtU5HWtzFZVjluQ=;
        b=PfIJ+2+6PNk7L/71/cM8BeHBk4sK85iASldkvTMUsuJNB9M3Utym3caaNCQ587bl1s
         ZPAfihtZffSpkZJ/S0rzH8kkOVdOLYtoqE5CRobsfnlEqo61XCjVv2BtCDuanWiK7fWF
         WxxmDgq/aFLPUSDlKu1pImVonVDWPBXZM2VV6JCiAWW2wGWP2bectUB9nndUrextZ9Zd
         ISygnYf40CZl4gY8YMNsoLH2NdwV0HNXvu3x0SP2ymps8IJhotor8pyCk2c3ohIKnucM
         jsf8HULRmIp8JMI29F23YHYQxBOZNru+F3EkMctXOsah86Q8IgfdugC2Lo8WLqD9s0Gb
         fnrA==
X-Received: by 10.60.52.244 with SMTP id w20mr17843279oeo.30.1381561855618;
        Sat, 12 Oct 2013 00:10:55 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm101356768oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:10:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235966>

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
