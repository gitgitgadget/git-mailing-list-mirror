From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] debian/ binary package dependency fix.
Date: Sun, 24 Jul 2005 23:27:54 -0700
Message-ID: <7vackbz9g5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 08:32:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwwVt-00057M-Pb
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 08:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVGYGbr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 02:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVGYG3W
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 02:29:22 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39135 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261526AbVGYG15 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 02:27:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050725062752.CJJC1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Jul 2005 02:27:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Make sure that the binary debian package depends on shlibs it
uses.  This point was raised by Alexey Nezhdanov.

The "Depends:" line in debian/control lacked ${shlibs:Depends},
which caused the resulting binary package not to depend on
libcurl3 nor even libc6 ;-).

Signed-off-by: Junio C Hamano <junkio@cox.net>
Acked-by: Ryan Anderson <ryan@michonline.com>
---

diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -7,7 +7,7 @@ Standards-Version: 3.6.1
 
 Package: git-core
 Architecture: any
-Depends: ${misc:Depends}, shellutils, diff, rsync, rcs
+Depends: ${shlibs:Depends}, ${misc:Depends}, shellutils, diff, rsync, rcs
 Description: The git content addressable filesystem
  GIT comes in two layers. The bottom layer is merely an extremely fast
  and flexible filesystem-based database designed to store directory trees
