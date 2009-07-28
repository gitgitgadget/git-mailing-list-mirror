From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 6/5] DWIM 'git stash save -p' for 'git stash -p'
Date: Tue, 28 Jul 2009 23:20:12 +0200
Message-ID: <73e749442329242681f24ce4786708b982c0c243.1248815580.git.trast@student.ethz.ch>
References: <200907271210.40001.trast@student.ethz.ch> <cover.1248815580.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 23:20:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVu6J-0001P2-3T
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 23:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbZG1VUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 17:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbZG1VUf
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 17:20:35 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:28959 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754975AbZG1VU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 17:20:26 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 23:20:23 +0200
Received: from localhost.localdomain ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 23:20:22 +0200
X-Mailer: git-send-email 1.6.4.rc3.215.gd714f
In-Reply-To: <cover.1248815580.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 28 Jul 2009 21:20:23.0000 (UTC) FILETIME=[37A6C580:01CA0FC9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124282>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-stash.txt |    2 +-
 git-stash.sh                |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 3dc16a1..1c4ed41 100644
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
1.6.4.rc3.215.g18405
