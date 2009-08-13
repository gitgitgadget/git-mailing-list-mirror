From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5 7/6] DWIM 'git stash save -p' for 'git stash -p'
Date: Thu, 13 Aug 2009 14:29:45 +0200
Message-ID: <b82a94299ffc996da68a678419371dac74919b48.1250164190.git.trast@student.ethz.ch>
References: <200908101136.34660.trast@student.ethz.ch> <cover.1250164190.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 14:30:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZSA-0002tc-94
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbZHMMa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 08:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbZHMMaX
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:30:23 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54458 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754372AbZHMMaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 08:30:16 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 14:30:10 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 14:30:02 +0200
X-Mailer: git-send-email 1.6.4.262.gbda8
In-Reply-To: <cover.1250164190.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125814>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-stash.txt |    2 +-
 git-stash.sh                |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 7af1840..ada16a0 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
-'git stash' [-k|--keep-index]
+'git stash' [-p|--patch|-k|--keep-index]
 'git stash' clear
 'git stash' create
 
diff --git a/git-stash.sh b/git-stash.sh
index 81a72f6..9fd7289 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -406,8 +406,8 @@ branch)
 	apply_to_branch "$@"
 	;;
 *)
-	case $#,"$1" in
-	0,|1,-k|1,--keep-index)
+	case $#,"$1","$2" in
+	0,,|1,-k,|1,--keep-index,|1,-p,|1,--patch,|2,-p,--no-keep-index|2,--patch,--no-keep-index)
 		save_stash "$@" &&
 		say '(To restore them type "git stash apply")'
 		;;
-- 
1.6.4.262.gbda8
