From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 1/7] remote: Make "-" an alias for the current remote
Date: Mon,  9 Mar 2009 23:35:45 +0100
Message-ID: <1236638151-6465-2-git-send-email-finnag@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 00:22:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgonQ-0003Hb-50
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 00:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbZCIXUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 19:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbZCIXUk
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 19:20:40 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:36502 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbZCIXUj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 19:20:39 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1Lgo51-0002Lo-0t
	for git@vger.kernel.org; Mon, 09 Mar 2009 23:36:17 +0100
X-Mailer: git-send-email 1.6.2.99.g52e77
In-Reply-To: <1236638151-6465-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112758>

This creates a handy alias "-" for the remote of the current branch
(or origin if no such remote exists), which can be used in both
push, pull, fetch and remote to make many tasks easier. E.g.:
git push - HEAD  : push the current branch
git remote prune - : prune the current remote
git fetch - next : get the next branch from the current remote

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index d7079c6..3a6d002 100644
--- a/remote.c
+++ b/remote.c
@@ -645,7 +645,7 @@ struct remote *remote_get(const char *name)
 	struct remote *ret;
 
 	read_config();
-	if (!name)
+	if (!name || !strcmp(name, "-"))
 		name = default_remote_name;
 	ret = make_remote(name, 0);
 	if (valid_remote_nick(name)) {
-- 
1.6.2.105.g6ff1f.dirty
