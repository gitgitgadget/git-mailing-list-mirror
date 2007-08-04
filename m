From: Jeff King <peff@peff.net>
Subject: [PATCH] git-clone: use cpio's --quiet flag
Date: Sat, 4 Aug 2007 03:03:08 -0400
Message-ID: <20070804070308.GA6493@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 09:03:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHDfV-00040h-Aa
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 09:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbXHDHDL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 03:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753728AbXHDHDL
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 03:03:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1469 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbXHDHDK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 03:03:10 -0400
Received: (qmail 26503 invoked from network); 4 Aug 2007 07:03:13 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 4 Aug 2007 07:03:13 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2007 03:03:08 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54803>

Without this flag, cpio prints the number of blocks copied,
leading to the somewhat confusing git-clone output:

$ git-clone foo bar
Initialized empty Git repository in ...
0 blocks

Signed-off-by: Jeff King <peff@peff.net>
---
This is obviously on top of the jc/clone topic in next.

 git-clone.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 4c9b1c9..ccfc316 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -281,7 +281,8 @@ yes)
 			fi
 		fi &&
 		cd "$repo" &&
-		find objects -depth -print | cpio -pumd$l "$GIT_DIR/" || exit 1
+		find objects -depth -print | cpio --quiet -pumd$l "$GIT_DIR/" \
+			|| exit 1
 	fi
 	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
 	;;
-- 
1.5.3.rc3.942.g536b2
