From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/4] Replace "GIT_DIR" with GIT_DIR_ENVIRONMENT.
Date: Sat, 30 Dec 2006 23:29:11 -0500
Message-ID: <20061231042911.GB5823@spearce.org>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 05:29:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0sJz-0003B9-82
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 05:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWLaE3Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 23:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWLaE3P
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 23:29:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42981 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932725AbWLaE3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 23:29:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0sJg-0008SR-I9; Sat, 30 Dec 2006 23:29:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E0CCA20FB65; Sat, 30 Dec 2006 23:29:11 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35663>

We tend to use the nice constant GIT_DIR_ENVIRONMENT when we
are referring to the "GIT_DIR" constant, but git.c didn't do
so.  Now it does.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index ec897dc..c82ca45 100644
--- a/git.c
+++ b/git.c
@@ -63,14 +63,14 @@ static int handle_options(const char*** argv, int* argc)
 				fprintf(stderr, "No directory given for --git-dir.\n" );
 				usage(git_usage_string);
 			}
-			setenv("GIT_DIR", (*argv)[1], 1);
+			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
 			(*argv)++;
 			(*argc)--;
 		} else if (!strncmp(cmd, "--git-dir=", 10)) {
-			setenv("GIT_DIR", cmd + 10, 1);
+			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 		} else if (!strcmp(cmd, "--bare")) {
 			static char git_dir[PATH_MAX+1];
-			setenv("GIT_DIR", getcwd(git_dir, sizeof(git_dir)), 1);
+			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 1);
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
-- 
1.5.0.rc0.g6bb1
