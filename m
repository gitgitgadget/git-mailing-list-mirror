From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-mv: fix off-by-one error
Date: Mon, 21 Aug 2006 22:22:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608212221500.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 21 22:22:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFGI3-0006yN-UX
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 22:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWHUUW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 16:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWHUUW2
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 16:22:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:39846 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750947AbWHUUW2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 16:22:28 -0400
Received: (qmail invoked by alias); 21 Aug 2006 20:22:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 21 Aug 2006 22:22:26 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25813>


Embarassing.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	This bug made t7001-mv.sh fail with the patch in
	http://article.gmane.org/gmane.comp.version-control.git/25647
	when XMALLOC_POISON was set, which was probably the reason it
	was not yet applied...

 builtin-mv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 6e7062b..ff882be 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -26,7 +26,7 @@ static const char **copy_pathspec(const 
 		if (length > 0 && result[i][length - 1] == '/') {
 			char *without_slash = xmalloc(length);
 			memcpy(without_slash, result[i], length - 1);
-			without_slash[length] = '\0';
+			without_slash[length - 1] = '\0';
 			result[i] = without_slash;
 		}
 		if (base_name) {
-- 
1.4.2.gc69d
