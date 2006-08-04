From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix crash when GIT_DIR is invalid
Date: Fri, 4 Aug 2006 17:46:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608041745500.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Aug 04 17:47:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G91sW-0004uS-8N
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 17:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161260AbWHDPqV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 11:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbWHDPqV
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 11:46:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:30636 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161260AbWHDPqV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 11:46:21 -0400
Received: (qmail invoked by alias); 04 Aug 2006 15:46:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 04 Aug 2006 17:46:19 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24795>


We used to test if a pointer was NULL, and if it was, try to access it.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 358e139..2afdba4 100644
--- a/setup.c
+++ b/setup.c
@@ -184,7 +184,7 @@ const char *setup_git_directory_gently(i
 		}
 		return NULL;
 	bad_dir_environ:
-		if (!nongit_ok) {
+		if (nongit_ok) {
 			*nongit_ok = 1;
 			return NULL;
 		}
-- 
1.4.2.rc2.g0bca-dirty
