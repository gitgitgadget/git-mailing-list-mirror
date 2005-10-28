From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] make t5501 less annoying, was Re: [PATCH 4/8] Implement an
 interoperability test for fetch-pack/upload-pack
Date: Fri, 28 Oct 2005 05:59:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510280557071.5054@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510280447440.20516@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 05:59:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVLOw-0007dg-9j
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 05:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbVJ1D7b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 23:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVJ1D7b
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 23:59:31 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:53971 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965084AbVJ1D7a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 23:59:30 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E6B8813F30D; Fri, 28 Oct 2005 05:59:29 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CACF49EFCF; Fri, 28 Oct 2005 05:59:29 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9729D85CB1; Fri, 28 Oct 2005 05:59:29 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 885DF13F30D; Fri, 28 Oct 2005 05:59:29 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0510280447440.20516@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10755>


On Linux, "mktemp tmp-XXXX" will not work. Also, redirect stderr on which,
so it does not complain too loudly. After all, this test should only be
executed when old binaries are available.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

 t/t5501-old-fetch-and-upload.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: f961b5204f8ead99f2beb0b2dc9f1e662c47fd74
4462bf60f4fca1d7774f441b374943109083efd9
diff --git a/t/t5501-old-fetch-and-upload.sh b/t/t5501-old-fetch-and-upload.sh
index 86df785..ada5130 100755
--- a/t/t5501-old-fetch-and-upload.sh
+++ b/t/t5501-old-fetch-and-upload.sh
@@ -8,7 +8,7 @@
 
 cd $(dirname $0) || exit 1
 
-tmp=$(mktemp tmp-XXXX)
+tmp=$(mktemp /tmp/tmp-XXXXXXXX)
 
 retval=0
 
@@ -25,7 +25,7 @@ for i in $list; do
 	both) pgm="old-git-upload-pack"; replace="old-git-fetch-pack --exec=$pgm";;
 	esac
 
-	if which $pgm; then
+	if which $pgm 2>/dev/null; then
 		echo "Testing with $pgm"
 		sed -e "s/git-fetch-pack/$replace/g" \
 			-e "s/# old fails/warn/" < t5500-fetch-pack.sh > $tmp
---
0.99.8.GIT
