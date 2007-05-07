From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Remove mention of -o|--only in SYNOPSYS of git-commit.
Date: Mon,  7 May 2007 10:21:54 +0200
Message-ID: <11785261143658-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 10:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkyTy-0002sQ-FW
	for gcvg-git@gmane.org; Mon, 07 May 2007 10:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbXEGIWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 04:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbXEGIWH
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 04:22:07 -0400
Received: from imag.imag.fr ([129.88.30.1]:58874 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154AbXEGIWG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 04:22:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l478LsjQ015522
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 May 2007 10:21:55 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HkyTi-0005fN-RW; Mon, 07 May 2007 10:21:54 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HkyTi-0003pz-Ok; Mon, 07 May 2007 10:21:54 +0200
X-Mailer: git-send-email 1.5.1.1
In-Reply-To: vpqd51duklo.fsf@bauges.imag.fr
References: vpqd51duklo.fsf@bauges.imag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 07 May 2007 10:21:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46432>

This flag is actually useless since it is the default behavior, and
was mentionned in the SYNOPSYS, but not actually documented. Better
just deprecate it.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-commit.txt |    4 ++--
 git-commit.sh                |    4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 53a7bb0..4324ca0 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git-commit' [-a | --interactive] [-s] [-v]
 	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
 	   [--no-verify] [-e] [--author <author>]
-	   [--] [[-i | -o ]<file>...]
+	   [--] [[-i] <files>...]
 
 DESCRIPTION
 -----------
@@ -91,7 +91,7 @@ OPTIONS
 
 	Used to amend the tip of the current branch. Prepare the tree
 	object you would want to replace the latest commit as usual
-	(this includes the usual -i/-o and explicit paths), and the
+	(this includes the usual -i and explicit paths), and the
 	commit log editor is seeded with the commit message from the
 	tip of the current branch. The commit you create replaces the
 	current tip -- if it was a merge, it will have the parents of
diff --git a/git-commit.sh b/git-commit.sh
index f28fc24..3913097 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
-USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i | -o] <path>...]'
+USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
@@ -138,6 +138,8 @@ do
 		shift
 		;;
 	-o|--o|--on|--onl|--only)
+                echo >&2 "Warning: --only option is now the default."
+                echo >&2 "It will be removed in a future version of git."
 		only=t
 		shift
 		;;
-- 
1.5.1.1
