From: Scott R Parish <srp@srparish.net>
Subject: [PATCH 7/7] shell should call setup_path() instead of manually setting up its path
Date: Wed, 24 Oct 2007 20:44:51 -0700
Message-ID: <1193283892-26167-1-git-send-email-srp@srparish.net>
Cc: Scott R Parish <srp@srparish.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 05:45:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iktee-000519-11
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 05:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061AbXJYDox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 23:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757026AbXJYDox
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 23:44:53 -0400
Received: from smtp-gw51.mailanyone.net ([208.70.128.77]:36067 "EHLO
	smtp-gw51.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756956AbXJYDow (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 23:44:52 -0400
Received: from mailanyone.net
	by smtp-gw51.mailanyone.net with esmtp (MailAnyone extSMTP quinn@srparish.net)
	id 1IkteN-0007Qa-Lg; Wed, 24 Oct 2007 22:44:51 -0500
Received: by maple.srparish.net (Postfix, from userid 501)
	id 23C1F4ECEF1; Wed, 24 Oct 2007 20:44:52 -0700 (PDT)
X-Mailer: git-send-email gitgui.0.8.4.11178.g9a1bf-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62266>

Signed-off-by: Scott R Parish <srp@srparish.net>
---
 shell.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/shell.c b/shell.c
index cfe372b..9826109 100644
--- a/shell.c
+++ b/shell.c
@@ -24,17 +24,11 @@ static int do_cvs_cmd(const char *me, char *arg)
 	const char *cvsserver_argv[3] = {
 		"cvsserver", "server", NULL
 	};
-	const char *oldpath = getenv("PATH");
-	struct strbuf newpath = STRBUF_INIT;
 
 	if (!arg || strcmp(arg, "server"))
 		die("git-cvsserver only handles server: %s", arg);
 
-	strbuf_addstr(&newpath, git_exec_path());
-	strbuf_addch(&newpath, ':');
-	strbuf_addstr(&newpath, oldpath);
-
-	setenv("PATH", strbuf_detach(&newpath, NULL), 1);
+	setup_path(NULL);
 
 	return execv_git_cmd(cvsserver_argv);
 }
-- 
gitgui.0.8.4.11176.gd9205-dirty
