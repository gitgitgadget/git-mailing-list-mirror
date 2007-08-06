From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitk - enable selected patch text on Windows
Date: Mon, 06 Aug 2007 18:45:51 -0400
Message-ID: <1186440352826-git-send-email-mdl123@verizon.net>
Cc: Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 00:46:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIBKy-0005ci-UL
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 00:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761397AbXHFWqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 18:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761171AbXHFWqF
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 18:46:05 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:37558 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761144AbXHFWqE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 18:46:04 -0400
Received: from fal-l07294-lp.us.ray.com ([72.66.124.87])
 by vms040.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JMD00I35J8HNVI1@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 06 Aug 2007 17:45:54 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.rc4.5.g4f0b5
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55180>

On windows, mouse input follows the keyboard focus, so to allow selecting
text from the patch canvas we must not shift focus back to the top level.
This change has no negative impact on X, so we don't explicitly test
for Win32 on this change. This provides similar selection capability
as already available using X-Windows.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index f74ce51..08ff5df 100755
--- a/gitk
+++ b/gitk
@@ -955,8 +955,8 @@ proc bindkey {ev script} {
 # set the focus back to the toplevel for any click outside
 # the entry widgets
 proc click {w} {
-    global entries
-    foreach e $entries {
+    global ctext entries
+    foreach e [concat $entries $ctext] {
 	if {$w == $e} return
     }
     focus .
-- 
1.5.3.rc4.5.g4f0b5
