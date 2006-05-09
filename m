From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Fix cg-object-id to lookup parents in the Right Way
Date: Wed, 10 May 2006 00:49:24 +0200
Message-ID: <20060509224924.7400.93511.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 00:46:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fdaxl-0006Go-L2
	for gcvg-git@gmane.org; Wed, 10 May 2006 00:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWEIWpu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 18:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWEIWpu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 18:45:50 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:39809 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751331AbWEIWpu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 18:45:50 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 29B0F9A99A;
	Wed, 10 May 2006 00:45:49 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1Fdb8b-0007Rz-MM; Wed, 10 May 2006 00:57:05 +0200
To: Petr Baudis <pasky@suse.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19860>


This causes grafts to not be ignored any more, allowing
cg-admin-rewritehist to work as expected on grafted commits.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 cg-object-id |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-object-id b/cg-object-id
index ee23082..71c72e5 100755
--- a/cg-object-id
+++ b/cg-object-id
@@ -147,7 +147,7 @@ fi
 
 
 if [ "$show_parent" ]; then
-	git-cat-file commit "$normid" | sed -ne 's/^parent //p;/^$/q'
+	git-rev-list --parents -n 1 "$normid"| tr ' ' '\n'|tail +2
 	exit 0
 fi
 
