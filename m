From: Yakov Lerner <iler.ml@gmail.com>
Subject: [PATCH] Problem: 'trap...exit' causes error message when /bin/sh is
 ash.
Date: Mon, 22 May 2006 22:34 +0300
Message-ID: <0IZO00LS9MBV0SF0@mxout5.netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: iler.ml@gmail.com
X-From: git-owner@vger.kernel.org Mon May 22 21:33:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiG9w-0002lD-AA
	for gcvg-git@gmane.org; Mon, 22 May 2006 21:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWEVTde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 15:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWEVTde
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 15:33:34 -0400
Received: from mxout5.netvision.net.il ([194.90.9.29]:41008 "EHLO
	mxout5.netvision.net.il") by vger.kernel.org with ESMTP
	id S1751152AbWEVTdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 15:33:33 -0400
Received: from main ([85.250.144.108]) by mxout5.netvision.net.il
 (Sun Java System Messaging Server 6.2-4.03 (built Sep 22 2005))
 with ESMTPA id <0IZO00LS8MBV0SF0@mxout5.netvision.net.il> for
 git@vger.kernel.org; Mon, 22 May 2006 22:33:32 +0300 (IDT)
To: git@vger.kernel.org
X-Mailer: Mail::SendEasy/1.2 Perl/5.008005-cygwin
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20524>

Problem: 'trap...exit' causes error message when /bin/sh is ash.
Fix: Change 'trap...exit' to 'trap...0' like in other scripts.

Signed-off-by: Yakov Lerner <iler.ml@gmail.com>

---

 git-clone.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

954e49bc242cacd27e002f194d54a6895e64f88c
diff --git a/git-clone.sh b/git-clone.sh
index 227245c..d96894d 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -199,7 +199,7 @@ # Try using "humanish" part of source re
 [ -e "$dir" ] && echo "$dir already exists." && usage
 mkdir -p "$dir" &&
 D=$(cd "$dir" && pwd) &&
-trap 'err=$?; cd ..; rm -r "$D"; exit $err' exit
+trap 'err=$?; cd ..; rm -r "$D"; exit $err' 0
 case "$bare" in
 yes) GIT_DIR="$D" ;;
 *) GIT_DIR="$D/.git" ;;
@@ -407,5 +407,5 @@ Pull: refs/heads/$head_points_at:$origin
 fi
 rm -f "$GIT_DIR/CLONE_HEAD" "$GIT_DIR/REMOTE_HEAD"
 
-trap - exit
+trap - 0
 
-- 
1.3.GIT
