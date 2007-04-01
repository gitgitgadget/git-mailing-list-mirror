From: Sloof Lirpa <sitemaster@cox.net>
Subject: [PATCH 2/3] Human friendly git: accept human readable options.
Date: Sun, 1 Apr 2007 00:00:00 +0000
Message-ID: <7vlkhd557f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamamo <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 01 02:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXnxo-0007mg-CT
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 02:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbXDAAaU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 20:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbXDAAaT
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 20:30:19 -0400
Received: from fed1rmmtai108.cox.net ([68.230.241.52]:63180 "EHLO
	fed1rmmtai108.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbXDAAaS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 20:30:18 -0400
X-Greylist: delayed 1470 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Mar 2007 20:30:12 EDT
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070401000557.YPHL28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 31 Mar 2007 20:05:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hc5w1W0051kojtg0000000; Sat, 31 Mar 2007 20:05:57 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43576>

In kindergarten, we were taught to say "please" when asking
another person to do something for us.  With this, git
understands:

	$ git, please commit

Signed-off-by: Sloof Lirpa <sitemaster@cox.net>
---
 git.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 5b1bc2a..7909fd3 100644
--- a/git.c
+++ b/git.c
@@ -34,7 +34,15 @@ static int handle_options(const char*** argv, int* argc)
 
 	while (*argc > 0) {
 		const char *cmd = (*argv)[0];
-		if (cmd[0] != '-')
+
+		/*
+		 * Additional "human friendly" options do not begin
+		 * with '-'.
+		 */
+		if (!strcmp(cmd, "please"))
+			; /* no-op */
+
+		else if (cmd[0] != '-')
 			break;
 
 		/*
@@ -42,13 +50,13 @@ static int handle_options(const char*** argv, int* argc)
 		 * commands can be written with "--" prepended
 		 * to make them look like flags.
 		 */
-		if (!strcmp(cmd, "--help") || !strcmp(cmd, "--version"))
+		else if (!strcmp(cmd, "--help") || !strcmp(cmd, "--version"))
 			break;
 
 		/*
 		 * Check remaining flags.
 		 */
-		if (!prefixcmp(cmd, "--exec-path")) {
+		else if (!prefixcmp(cmd, "--exec-path")) {
 			cmd += 11;
 			if (*cmd == '=')
 				git_set_exec_path(cmd + 1);
-- 
1.5.1.rc3.26.g4f01
