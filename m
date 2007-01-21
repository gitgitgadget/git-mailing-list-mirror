From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] apply --cached: fix crash in subdirectory
Date: Sun, 21 Jan 2007 02:17:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701210212410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070120014851.GF5231@admingilde.org>
 <Pine.LNX.4.63.0701200312000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070120183615.GA6459@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Jan 21 02:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8RKx-0000fp-K0
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 02:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbXAUBRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 20:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbXAUBRW
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 20:17:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:43658 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751057AbXAUBRW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 20:17:22 -0500
Received: (qmail invoked by alias); 21 Jan 2007 01:17:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 21 Jan 2007 02:17:20 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20070120183615.GA6459@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37300>


The static variable "prefix" was shadowed by an unused parameter
of the same name. In case of execution in a subdirectory, the
static variable was accessed, leading to a crash.

Signed-off-by: Knoppix User <knoppix@zweitrechner.(none)>
---

	On Sat, 20 Jan 2007, Martin Waitz wrote:
	
	> git-apply inside the "src" directory segfaulted.

	Well, that was not the complete truth now, was it? Cannily, you 
	avoided mentioning the use of the "--cached" argument...

	But as you see, your evil plan failed ;-)

 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 54fd2cb..ef927f8 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2589,7 +2589,7 @@ static int git_apply_config(const char *var, const char *value)
 }
 
 
-int cmd_apply(int argc, const char **argv, const char *prefix)
+int cmd_apply(int argc, const char **argv, const char *prefix2)
 {
 	int i;
 	int read_stdin = 1;
-- 
1.5.0.rc1.gd85c
