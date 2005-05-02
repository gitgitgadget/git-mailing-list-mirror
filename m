From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] typo fixes to git-apply-patch-script
Date: Sun, 01 May 2005 20:19:41 -0700
Message-ID: <7vvf62pb5e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 05:14:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSRNQ-0007wb-Lt
	for gcvg-git@gmane.org; Mon, 02 May 2005 05:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVEBDTp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 23:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVEBDTp
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 23:19:45 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:18309 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261413AbVEBDTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 23:19:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050502031941.FQVL23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 23:19:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When git-apply-patch-script creates a new file without
executable mode set, a typo caused it not to report that
activity to the user.  Also it was mistakenly running
git-update-cache twice for newly created or deleted paths.  This
patch fixes these problems.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

****************************************************************
Linus, please do not forget to make this script EXECUTABLE this
time.
****************************************************************

jit-diff linus-mirror: git-apply-patch-script
# - Fix missing '\n' at end of git-cat-file -t output.
# + working-tree
Mode changed: git-apply-patch-script (100644->100755)

--- k/git-apply-patch-script
+++ l/git-apply-patch-script
@@ -31,7 +31,7 @@ test -f "$name.rej" || {
 	    echo >&2 "created $name with mode +x."
 	    chmod "$mode2" "$name"
 	    ;;
-	-)
+	-x)
 	    echo >&2 "created $name."
 	    ;;
 	esac
@@ -52,9 +52,7 @@ test -f "$name.rej" || {
 	    chmod "$mode2" "$name"
 	    ;;
 	esac
+	git-update-cache -- "$name"
     esac
-    # This bit is debatable---the SCM may not want to keep
-    # cache in sync with the work tree (JIT does want to).
-    git-update-cache -- "$name"
 }
 exit 0

