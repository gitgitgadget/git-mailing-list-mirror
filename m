From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 1/7] "git" calls help_unknown_cmd(""); "git help" and "git help -a" return 0
Date: Wed, 24 Oct 2007 20:37:11 -0700
Message-ID: <1193283437-1706-1-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 05:37:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IktXJ-0003WC-GI
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 05:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbXJYDhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 23:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756300AbXJYDhS
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 23:37:18 -0400
Received: from smtp-gw51.mailanyone.net ([208.70.128.77]:51490 "EHLO
	smtp-gw51.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380AbXJYDhR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 23:37:17 -0400
Received: from mailanyone.net
	by smtp-gw51.mailanyone.net with esmtp (MailAnyone extSMTP quinn@srparish.net)
	id 1IktX2-0003SK-Ix; Wed, 24 Oct 2007 22:37:16 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id 5D77A4EA8B4; Wed, 24 Oct 2007 20:37:17 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11178.g9a1bf-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62260>

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 git.c  |    5 ++---
 help.c |    4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index 853e66c..e1c99e3 100644
--- a/git.c
+++ b/git.c
@@ -445,9 +445,8 @@ int main(int argc, const char **argv)
 		if (!prefixcmp(argv[0], "--"))
 			argv[0] += 2;
 	} else {
-		/* Default command: "help" */
-		argv[0] = "help";
-		argc = 1;
+		/* The user didn't specify a command; give them help */
+		help_unknown_cmd("");
 	}
 	cmd = argv[0];
 
diff --git a/help.c b/help.c
index 1cd33ec..b0d2dd4 100644
--- a/help.c
+++ b/help.c
@@ -204,14 +204,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	if (!help_cmd) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
-		exit(1);
+		exit(0);
 	}
 
 	else if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
 		printf("usage: %s\n\n", git_usage_string);
 		if(exec_path)
 			list_commands(exec_path, "git-*");
-		exit(1);
+		exit(0);
 	}
 
 	else
-- 
gitgui.0.8.4.11176.gd9205-dirty
