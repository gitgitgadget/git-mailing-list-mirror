From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/4] Use PATH_MAX constant for --bare.
Date: Sat, 30 Dec 2006 23:28:53 -0500
Message-ID: <20061231042853.GA5823@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 05:29:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0sJk-0003AC-L7
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 05:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWLaE26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 23:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWLaE26
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 23:28:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42972 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932722AbWLaE25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 23:28:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0sJO-0008S0-S1; Sat, 30 Dec 2006 23:28:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B875C20FB65; Sat, 30 Dec 2006 23:28:53 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35662>

For easier portability we prefer PATH_MAX over seemingly random
constants like 1024.  Make it so.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 50ebd86..ec897dc 100644
--- a/git.c
+++ b/git.c
@@ -69,8 +69,8 @@ static int handle_options(const char*** argv, int* argc)
 		} else if (!strncmp(cmd, "--git-dir=", 10)) {
 			setenv("GIT_DIR", cmd + 10, 1);
 		} else if (!strcmp(cmd, "--bare")) {
-			static char git_dir[1024];
-			setenv("GIT_DIR", getcwd(git_dir, 1024), 1);
+			static char git_dir[PATH_MAX+1];
+			setenv("GIT_DIR", getcwd(git_dir, sizeof(git_dir)), 1);
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
-- 
1.5.0.rc0.g6bb1
