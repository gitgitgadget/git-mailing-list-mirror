From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix crash when reading the empty tree
Date: Sun, 7 May 2006 17:42:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605071742240.5906@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun May 07 17:42:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FclP8-000154-FK
	for gcvg-git@gmane.org; Sun, 07 May 2006 17:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWEGPmj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 11:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWEGPmj
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 11:42:39 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:50384 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932189AbWEGPmi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 11:42:38 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id B18B91CAC;
	Sun,  7 May 2006 17:42:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id A5D7E1C9D;
	Sun,  7 May 2006 17:42:37 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 87DF11C94;
	Sun,  7 May 2006 17:42:37 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19705>


cvsimport needs to call git-read-tree without arguments to create an empty
tree.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 read-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-tree.c b/read-tree.c
index 067fb95..a060a97 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -881,7 +881,7 @@ int main(int argc, char **argv)
 	 * valid cache-tree because the index must match exactly
 	 * what came from the tree.
 	 */
-	if (trees->item && (!merge || (stage == 2))) {
+	if (trees && trees->item && (!merge || (stage == 2))) {
 		cache_tree_free(&active_cache_tree);		
 		prime_cache_tree();
 	}
-- 
1.3.2.g5131-dirty
