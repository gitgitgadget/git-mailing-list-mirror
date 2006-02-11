From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-commit: Only call git-rerere if $GIT_DIR/rr-cache exists
Date: Sat, 11 Feb 2006 16:03:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602111602270.26560@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Feb 11 16:05:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7wJd-0003N3-VA
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 16:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWBKPDs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 10:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWBKPDp
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 10:03:45 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:24961 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932305AbWBKPDF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 10:03:05 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 754C413F0A9; Sat, 11 Feb 2006 16:03:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 66569895;
	Sat, 11 Feb 2006 16:03:04 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3A23813F0A9; Sat, 11 Feb 2006 16:03:04 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15947>


This makes an error go away if you do not have Digest.pm installed, but
do not intend to make use of git-rerere anyway.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

111b9e1abeb98a8009a457fe8e7dff5a91b30778
diff --git a/git-commit.sh b/git-commit.sh
index 073ec81..28ec7c3 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -638,7 +638,7 @@ else
 fi
 ret="$?"
 rm -f "$GIT_DIR/COMMIT_MSG" "$GIT_DIR/COMMIT_EDITMSG"
-git-rerere
+test -d "$GIT_DIR/rr-cache" && git-rerere
 
 if test -x "$GIT_DIR"/hooks/post-commit && test "$ret" = 0
 then
-- 
1.1.4.gaef2-dirty
