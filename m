From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] clone: don't clone the info/alternates file
Date: Sun, 7 May 2006 20:19:33 +0200
Message-ID: <20060507181933.GD23738@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 07 20:20:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcnri-0004Bx-90
	for gcvg-git@gmane.org; Sun, 07 May 2006 20:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWEGSTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 14:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWEGSTf
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 14:19:35 -0400
Received: from admingilde.org ([213.95.32.146]:37583 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1750883AbWEGSTe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 14:19:34 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Fcnqv-0000pv-Go
	for git@vger.kernel.org; Sun, 07 May 2006 20:19:33 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19713>

Now that the cloned alternates file is parsed, too we don't need to
copy it into our new repository, we just reference it.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

 git-clone.sh |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

4dc26b7a15c0778459f2ccf85aad1c03d1b3a3cc
diff --git a/git-clone.sh b/git-clone.sh
index b785247..227245c 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -261,11 +261,7 @@ yes,yes)
 	    ;;
 	yes)
 	    mkdir -p "$GIT_DIR/objects/info"
-	    {
-		test -f "$repo/objects/info/alternates" &&
-		cat "$repo/objects/info/alternates";
-		echo "$repo/objects"
-	    } >>"$GIT_DIR/objects/info/alternates"
+	    echo "$repo/objects" >> "$GIT_DIR/objects/info/alternates"
 	    ;;
 	esac
 	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD"
-- 
1.3.1.g6ef7
