From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 08/10] push: teach push to accept --verbose option
Date: Sun, 28 Oct 2007 18:46:19 +0100
Message-ID: <11935935821800-git-send-email-prohaska@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de>
 <11935935812741-git-send-email-prohaska@zib.de>
 <1193593581114-git-send-email-prohaska@zib.de>
 <1193593581486-git-send-email-prohaska@zib.de>
 <11935935812185-git-send-email-prohaska@zib.de>
 <11935935822846-git-send-email-prohaska@zib.de>
 <11935935821136-git-send-email-prohaska@zib.de>
 <11935935823045-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 18:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCI7-0000ou-Nc
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbXJ1RuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 13:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754427AbXJ1RuE
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:50:04 -0400
Received: from mailer.zib.de ([130.73.108.11]:63842 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456AbXJ1Rtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 13:49:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SHkMbX016201
	for <git@vger.kernel.org>; Sun, 28 Oct 2007 18:49:47 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SHkLsc019730;
	Sun, 28 Oct 2007 18:46:22 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11935935823045-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62584>

Before this commit, git push only knew '-v'.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-push.txt |    4 ++--
 builtin-push.c             |    4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 236898f..865f183 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-push' [--all] [--dry-run] [--create] [--tags] [--receive-pack=<git-receive-pack>]
-           [--repo=all] [-f | --force] [-v] [HEAD | <repository> <refspec>...]
+           [--repo=all] [-f | --force] [-v | --verbose] [HEAD | <repository> <refspec>...]
 
 DESCRIPTION
 -----------
@@ -105,7 +105,7 @@ the remote repository.
 	transfer spends extra cycles to minimize the number of
 	objects to be sent and meant to be used on slower connection.
 
--v::
+-v, \--verbose::
 	Run verbosely.
 
 include::urls-remotes.txt[]
diff --git a/builtin-push.c b/builtin-push.c
index 7c08e19..9103d57 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -112,6 +112,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			verbose=1;
 			continue;
 		}
+		if (!strcmp(arg, "--verbose")) {
+			verbose=1;
+			continue;
+		}
 		if (!prefixcmp(arg, "--repo=")) {
 			repo = arg+7;
 			continue;
-- 
1.5.3.4.439.ge8b49
