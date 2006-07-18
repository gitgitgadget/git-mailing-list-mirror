From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix t4114 on cygwin
Date: Tue, 18 Jul 2006 19:46:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607181946090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jul 18 19:47:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2tei-0007vM-Rj
	for gcvg-git@gmane.org; Tue, 18 Jul 2006 19:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWGRRqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Jul 2006 13:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWGRRqh
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Jul 2006 13:46:37 -0400
Received: from mail.gmx.de ([213.165.64.21]:61851 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932328AbWGRRqg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jul 2006 13:46:36 -0400
Received: (qmail invoked by alias); 18 Jul 2006 17:46:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 18 Jul 2006 19:46:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23997>


On cygwin, when you try to create a symlink over a directory, you do
not get EEXIST, but EACCES.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 8f7cf44..d924ac3 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2034,7 +2034,7 @@ static void create_one_file(char *path, 
 			return;
 	}
 
-	if (errno == EEXIST) {
+	if (errno == EEXIST || errno == EACCES) {
 		/* We may be trying to create a file where a directory
 		 * used to be.
 		 */
-- 
1.4.2.rc1.gaf40
