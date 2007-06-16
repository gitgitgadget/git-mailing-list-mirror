From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 9/9] Cleanup the use of the Series class.
Date: Sun, 17 Jun 2007 00:01:15 +0200
Message-ID: <20070616220115.14941.5072.stgit@gandelf.nowhere.earth>
References: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 00:01:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzgKw-0000H7-DZ
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 00:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447AbXFPWBJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 18:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756395AbXFPWBI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 18:01:08 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45590 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756173AbXFPWBH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 18:01:07 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7E8F57491;
	Sun, 17 Jun 2007 00:01:06 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id E5AC11F08A;
	Sun, 17 Jun 2007 00:01:15 +0200 (CEST)
In-Reply-To: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50317>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pick.py |    3 +--
 stgit/stack.py         |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 0fb7282..9dd49d2 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -21,7 +21,6 @@ from optparse import OptionParser, make_option
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit import stack, git
-from stgit.stack import Series
 
 
 class concreteCommand(Command):
@@ -133,7 +132,7 @@ class concreteCommand(Command):
                 if refbranchname:
                     # assume the refseries is OK, since we already resolved
                     # commit_str to a git_id
-                    refseries = Series(refbranchname)
+                    refseries = stack.Series(refbranchname)
                 else:
                     refseries = self.current_head()
                 patch = refseries.get_patch(refpatchname)
diff --git a/stgit/stack.py b/stgit/stack.py
index e33fe62..8acb308 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -629,8 +629,8 @@ class Series(PatchSet):
             base = self.get_base()
         except:
             base = git.get_head()
-        Series(target_series).init(create_at = base)
         new_series = Series(target_series)
+        new_series.init(create_at = base)
 
         # generate an artificial description file
         new_series.set_description('clone of "%s"' % self.get_name())
