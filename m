From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t5400-send-pack relies on a working cpio
Date: Mon, 10 Oct 2005 17:37:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510101735530.6277@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 17:42:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOziS-0004KN-03
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 17:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVJJPhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 11:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbVJJPhP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 11:37:15 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:59336 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750870AbVJJPhN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 11:37:13 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7664A13F0EA; Mon, 10 Oct 2005 17:37:08 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5AC9CB4BA6; Mon, 10 Oct 2005 17:37:08 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 40895B4B98; Mon, 10 Oct 2005 17:37:08 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1E0E913F0EA; Mon, 10 Oct 2005 17:37:08 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9893>

Since cygwin does not install cpio by default, t5400 results in a very
cryptic failure. So, test for cpio explicitely.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

 t/t5400-send-pack.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

applies-to: c1b731620114e8b58054b944865e3bf361f941f5
d3bafb81a99406258cfb318344a176264c269427
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 1a4d2f2..7fc3bd7 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -8,6 +8,9 @@ test_description='See why rewinding head
 '
 . ./test-lib.sh
 
+touch cpio-test
+test_expect_success 'working cpio' 'echo cpio-test | cpio -o > /dev/null'
+
 cnt='1'
 test_expect_success setup '
 	tree=$(git-write-tree) &&
---
0.99.8.GIT
