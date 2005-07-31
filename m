From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] add NO_CURL option to the Makefile
Date: Sun, 31 Jul 2005 02:14:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507310213110.13590@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jul 31 02:18:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz1XG-0007hd-En
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 02:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbVGaARa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 20:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbVGaAPF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 20:15:05 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:31424 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S263128AbVGaAOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 20:14:23 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 54F48E1C29
	for <git@vger.kernel.org>; Sun, 31 Jul 2005 02:14:23 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 39F21A88BF
	for <git@vger.kernel.org>; Sun, 31 Jul 2005 02:14:23 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 1CD77A8835
	for <git@vger.kernel.org>; Sun, 31 Jul 2005 02:14:23 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 0B0C9E1C29
	for <git@vger.kernel.org>; Sun, 31 Jul 2005 02:14:23 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch implements Linus' idea that if you are not interested in
pulling by HTTP, you can now say

	NO_CURL=1 make

to compile everything except git-http-pull (thus not needing curl at all).
---

 Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

b2e1e7eb6876b5f385bc52bf78e9551d1457215b
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -69,7 +69,7 @@ PROG=   git-update-cache git-diff-files
 	git-checkout-cache git-diff-tree git-rev-tree git-ls-files \
 	git-check-files git-ls-tree git-merge-base git-merge-cache \
 	git-unpack-file git-export git-diff-cache git-convert-cache \
-	git-http-pull git-ssh-push git-ssh-pull git-rev-list git-mktag \
+	git-ssh-push git-ssh-pull git-rev-list git-mktag \
 	git-diff-helper git-tar-tree git-local-pull git-hash-object \
 	git-get-tar-commit-id git-apply git-stripspace \
 	git-diff-stages git-rev-parse git-patch-id git-pack-objects \
@@ -78,6 +78,10 @@ PROG=   git-update-cache git-diff-files
 	git-show-index git-daemon git-var git-peek-remote \
 	git-update-server-info git-show-rev-cache git-build-rev-cache

+ifndef NO_CURL
+PROG+= git-http-pull
+endif
+
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h csum-file.h \
 	pack.h pkt-line.h refs.h
