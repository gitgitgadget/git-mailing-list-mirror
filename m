From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] git.__remotes_from_dir() should only return lists
Date: Wed, 05 Sep 2007 12:57:22 -0400
Message-ID: <20070905165722.17744.56584.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@gmail.com>, kha@treskal.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 18:57:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISyC2-00048x-1y
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 18:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbXIEQ5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 12:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752803AbXIEQ5Y
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 12:57:24 -0400
Received: from c60.cesmail.net ([216.154.195.49]:1789 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbXIEQ5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 12:57:24 -0400
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 05 Sep 2007 12:57:23 -0400
Received: from dv.roinet.com (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id 2C614618FE1;
	Wed,  5 Sep 2007 12:57:23 -0400 (EDT)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57721>

If there are no remotes, return empty list, not None.  The later doesn't
work with builtin set().

This fixes t1001-branch-rename.sh

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/stgit/git.py b/stgit/git.py
index 4b4c626..f847cce 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -953,7 +953,7 @@ def __remotes_from_dir(dir):
     if os.path.exists(d):
         return os.listdir(d)
     else:
-        return None
+        return []
 
 def remotes_list():
     """Return the list of remotes in the repository
