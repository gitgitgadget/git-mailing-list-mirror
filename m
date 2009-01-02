From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [CLEANUP PATCH RESEND] git wrapper: Make while loop more
 reader-friendly
Date: Fri, 2 Jan 2009 19:07:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021240270.27818@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 02 19:09:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIoS5-0002Vo-LY
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 19:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759275AbZABSHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 13:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759272AbZABSH2
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 13:07:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:43811 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759106AbZABSHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 13:07:25 -0500
Received: (qmail invoked by alias); 02 Jan 2009 18:07:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 02 Jan 2009 19:07:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ubMEIAV2utLAH4/R2c5NYviWJy0q0z/ILT+p6S2
	XBjnmlmHM+mqq1
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104393>


It is not a good practice to prefer performance over readability in
something as performance uncritical as finding the trailing slash
of argv[0].

So avoid head-scratching by making the loop user-readable, and not
hyper-performance-optimized.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 940a498..e0d9071 100644
--- a/git.c
+++ b/git.c
@@ -428,9 +428,8 @@ int main(int argc, const char **argv)
 	 * name, and the dirname as the default exec_path
 	 * if we don't have anything better.
 	 */
-	do
-		--slash;
-	while (cmd <= slash && !is_dir_sep(*slash));
+	while (cmd <= slash && !is_dir_sep(*slash))
+		slash--;
 	if (cmd <= slash) {
 		*slash++ = 0;
 		git_set_argv0_path(cmd);
-- 
1.6.1.rc3.224.g95ac9
