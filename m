From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] git-gui/Makefile - Don't convert gg_libdir on Cygwin
Date: Sat, 05 Jan 2008 17:32:35 -0500
Message-ID: <1199572355-2720-1-git-send-email-mdl123@verizon.net>
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jan 05 23:33:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBHZt-0008Co-5v
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 23:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbYAEWcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 17:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbYAEWcs
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 17:32:48 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:59203 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYAEWcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 17:32:47 -0500
Received: from localhost.localdomain ([71.163.17.196])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JU600GPIZYC5AXD@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 05 Jan 2008 16:32:37 -0600 (CST)
X-Mailer: git-send-email 1.5.4.rc2.50.gcfa92
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69689>

gg_libdir was converted to an absolute Windows path as a remnant of
logic to check for relative / absolute location of libraries, but that
does not work on Cygwin. Converting gg_libdir to a Windows path has the
nasty side-effect that it cannot be prefixed with $DESTDIR, and this
precludes installing to a staging directory. So, don't convert it.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
(resend, mistyped the git list address)
 git-gui/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index c109eab..8eb9e05 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -119,7 +119,6 @@ GITGUI_MACOSXAPP :=

 ifeq ($(uname_O),Cygwin)
 	GITGUI_SCRIPT := `cygpath --windows --absolute "$(GITGUI_SCRIPT)"`
-	gg_libdir := $(shell cygpath --windows --absolute "$(gg_libdir)")
 else
 	ifeq ($(exedir),$(gg_libdir))
 		GITGUI_RELATIVE := 1
--
1.5.4.rc2.50.gcfa92
