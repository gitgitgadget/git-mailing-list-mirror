From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git_config: access() returns 0 on success, not > 0
Date: Tue, 20 Jun 2006 09:51:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606200950460.26329@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jun 20 09:51:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsb18-0003qr-Fi
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 09:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbWFTHvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 03:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWFTHvL
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 03:51:11 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51161 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965016AbWFTHvK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 03:51:10 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 776AA20C5;
	Tue, 20 Jun 2006 09:51:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 6BEB020C0;
	Tue, 20 Jun 2006 09:51:09 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 502CB2087;
	Tue, 20 Jun 2006 09:51:09 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22177>


Another late-night bug. Sorry again.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 config.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index d064f42..3e077d4 100644
--- a/config.c
+++ b/config.c
@@ -335,7 +335,7 @@ int git_config(config_fn_t fn)
 
 	if (home) {
 		char *user_config = strdup(mkpath("%s/.gitconfig", home));
-		if (access(user_config, R_OK) > 0)
+		if (!access(user_config, R_OK))
 			ret = git_config_from_file(fn, user_config);
 		free(user_config);
 	}
-- 
1.4.0.g59268-dirty
