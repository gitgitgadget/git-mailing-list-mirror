From: Andrew Ruder <andy@aeruder.net>
Subject: [TRIVIAL PATCH 1/1] Make git-annotate use RUN_SETUP
Date: Sun, 20 May 2007 22:11:11 -0500
Message-ID: <56fecbfb5ee82e2f8fdccca6b3f275c43e2b03cd.1179716754.git.andy@aeruder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 05:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpyLl-00083J-0W
	for gcvg-git@gmane.org; Mon, 21 May 2007 05:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbXEUDOP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 23:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754540AbXEUDOO
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 23:14:14 -0400
Received: from www.aeruder.net ([65.254.53.245]:2513 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508AbXEUDOO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 23:14:14 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 6707040BEF;
	Sun, 20 May 2007 22:14:13 -0500 (CDT)
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47959>

The USE_PAGER was unnecessary as git-blame/git-annotate specifically
setup the pager when --incremental is not specified.

Prior to this patch git annotate somefileinasubdirectory.c would fail
(while git blame somefileinasubdirectory.c would succeed).

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index f200907..eeb2c0c 100644
--- a/git.c
+++ b/git.c
@@ -225,7 +225,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		int option;
 	} commands[] = {
 		{ "add", cmd_add, RUN_SETUP | NOT_BARE },
-		{ "annotate", cmd_annotate, USE_PAGER },
+		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
 		{ "blame", cmd_blame, RUN_SETUP },
-- 
1.5.2.14.g45bde-dirty
