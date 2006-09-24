From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/2] git-tar-tree: Remove duplicate git_config() call
Date: Sun, 24 Sep 2006 17:30:44 +0200
Message-ID: <4516A4A4.6040200@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 24 17:30:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRVwP-0000iA-16
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 17:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWIXPao (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 11:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWIXPao
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 11:30:44 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:39819
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751186AbWIXPao (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 11:30:44 -0400
Received: from [10.0.1.3] (p508E7663.dip.t-dialin.net [80.142.118.99])
	by neapel230.server4you.de (Postfix) with ESMTP id 03FAA1B02F;
	Sun, 24 Sep 2006 17:30:42 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27669>

generate_tar() eventually calls write_tar_archive() which does all the
"real" work and which also calls git_config(git_tar_config).  We only
need to do this once.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 builtin-tar-tree.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 437eb72..82b4951 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -267,8 +267,6 @@ static int generate_tar(int argc, const 
 	int result;
 	char *base = NULL;
 
-	git_config(git_tar_config);
-
 	memset(&args, 0, sizeof(args));
 	if (argc != 2 && argc != 3)
 		usage(tar_tree_usage);
