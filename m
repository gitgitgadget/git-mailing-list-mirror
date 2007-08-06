From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] (Really) Fix install-doc-quick target
Date: Mon, 06 Aug 2007 18:43:14 -0400
Message-ID: <11864401942772-git-send-email-mdl123@verizon.net>
References: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
Cc: Ren Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 00:43:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIBII-0004p2-LX
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 00:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759861AbXHFWnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 18:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757585AbXHFWnT
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 18:43:19 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:37731 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbXHFWnS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 18:43:18 -0400
Received: from fal-l07294-lp.us.ray.com ([72.66.124.87])
 by vms048.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JMD007SSJ44BCO1@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 06 Aug 2007 17:43:17 -0500 (CDT)
In-reply-to: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: git-send-email 1.5.3.rc4.5.g4f0b5
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55179>

Commit 00d8c51 caused git-ls-tree to be invoked from a directory where
GIT_DIR cannot be found and without that variable being set.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 Documentation/install-doc-quick.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/install-doc-quick.sh b/Documentation/install-doc-quick.sh
index 07d227f..a0164fb 100755
--- a/Documentation/install-doc-quick.sh
+++ b/Documentation/install-doc-quick.sh
@@ -25,7 +25,7 @@ git checkout-index -a -f --prefix="$mandir"/
 
 if test -n "$GZ"; then
 	cd "$mandir"
-	for i in `git ls-tree -r --name-only $head`
+	for i in `git --git-dir="$GIT_DIR" ls-tree -r --name-only $head`
 	do
 		gzip < $i > $i.gz && rm $i
 	done
-- 
1.5.3.rc4.5.g4f0b5
