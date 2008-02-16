From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/6] diff.c: add "const" qualifier to "char *cmd" member of
 "struct ll_diff_driver"
Date: Sat, 16 Feb 2008 06:02:17 +0100
Message-ID: <20080216060217.c2ed3bb1.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 05:56:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQF6g-0004D9-BA
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 05:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbYBPE4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 23:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbYBPE4X
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 23:56:23 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:34857 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627AbYBPE4V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 23:56:21 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7296F1AB2AA;
	Sat, 16 Feb 2008 05:56:20 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 256391AB2A9;
	Sat, 16 Feb 2008 05:56:20 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74014>

Also use "git_config_string" to simplify code where "cmd" is set.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 diff.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 5640cbf..173bb61 100644
--- a/diff.c
+++ b/diff.c
@@ -57,7 +57,7 @@ static int parse_diff_color_slot(const char *var, int ofs)
 static struct ll_diff_driver {
 	const char *name;
 	struct ll_diff_driver *next;
-	char *cmd;
+	const char *cmd;
 } *user_diff, **user_diff_tail;
 
 /*
@@ -86,10 +86,7 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
 		user_diff_tail = &(drv->next);
 	}
 
-	if (!value)
-		return config_error_nonbool(var);
-	drv->cmd = xstrdup(value);
-	return 0;
+	return git_config_string(&(drv->cmd), var, value);
 }
 
 /*
-- 
1.5.4.1.129.gf12af-dirty
