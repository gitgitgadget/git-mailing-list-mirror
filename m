From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/3] cg-admin-rewritehist: catch git-rev-list returning no commit
Date: Sun, 11 Jun 2006 14:04:55 +0200
Message-ID: <20060611120455.12116.14042.stgit@gandelf.nowhere.earth>
References: <20060611120431.12116.74005.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 14:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpOgf-0002tE-9g
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 14:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWFKMEy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 08:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFKMEy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 08:04:54 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:34438 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751217AbWFKMEx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 08:04:53 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id DA46924857;
	Sun, 11 Jun 2006 14:04:52 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FpOgc-0002v5-Ex; Sun, 11 Jun 2006 14:04:58 +0200
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060611120431.12116.74005.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21649>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 cg-admin-rewritehist |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/cg-admin-rewritehist b/cg-admin-rewritehist
index 861c7f6..fe3f210 100755
--- a/cg-admin-rewritehist
+++ b/cg-admin-rewritehist
@@ -199,6 +199,10 @@ done
 git-rev-list --topo-order HEAD $startrev | tac >../revs
 commits=$(cat ../revs | wc -l)
 
+if [ $commits -eq 0 ]; then
+    die "Found nothing to rewrite"
+fi
+
 i=0
 while read commit; do
 	i=$((i+1))
