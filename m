From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git revert" (Re: pci_update_resource() getting called on sparc64)
Date: Tue, 9 Aug 2005 02:13:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508090213170.4025@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050808.103304.55507512.davem@davemloft.net>
 <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org> <20050808160846.GA7710@kroah.com>
 <20050808.123209.59463259.davem@davemloft.net> <20050808194249.GA6729@kroah.com>
 <Pine.LNX.4.58.0508081249110.3258@g5.osdl.org> <Pine.LNX.4.58.0508081257190.3258@g5.osdl.org>
 <7vd5oo40mq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508081357020.3258@g5.osdl.org>
 <7voe882kds.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508081444040.3258@g5.osdl.org>
 <7vd5oo11wj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508090202140.3860@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 02:14:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Hkr-0002i9-3u
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 02:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVHIANz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 20:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVHIANz
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 20:13:55 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:44946 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932381AbVHIANy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 20:13:54 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7E93EE32CF; Tue,  9 Aug 2005 02:13:53 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 66175992D4; Tue,  9 Aug 2005 02:13:53 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5201B99287; Tue,  9 Aug 2005 02:13:53 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 44179E32CF; Tue,  9 Aug 2005 02:13:53 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0508090202140.3860@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Adapt git-cherry and git-rebase-script to latest changes of git commit

Teach git-cherry and git-rebase-script to use the "-c" option, since
"-m" means something different to git-commit-script now.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-cherry        |    2 +-
 git-rebase-script |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

34d6840882e65109a17fa02bf2cefec269fd7637
diff --git a/git-cherry b/git-cherry
--- a/git-cherry
+++ b/git-cherry
@@ -23,7 +23,7 @@ The output is intended to be used as:
     while read commit
     do
         GIT_EXTERNAL_DIFF=git-apply-patch-script git-diff-tree -p "$commit" &&
-	git-commit-script -m "$commit"
+	git-commit-script -c "$commit"
     done
 '
 
diff --git a/git-rebase-script b/git-rebase-script
--- a/git-rebase-script
+++ b/git-rebase-script
@@ -37,7 +37,7 @@ do
 	esac
 	S=`cat "$GIT_DIR/HEAD"` &&
         GIT_EXTERNAL_DIFF=git-apply-patch-script git-diff-tree -p $commit &&
-	git-commit-script -m "$commit" || {
+	git-commit-script -c "$commit" || {
 		echo $commit >>$fail
 		git-read-tree --reset -u $S
 	}
