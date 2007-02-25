From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Correctly raise exception on unknown pull-policy.
Date: Sun, 25 Feb 2007 20:27:14 +0100
Message-ID: <20070225192714.15658.33532.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 25 20:27:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLP1q-0003iy-AR
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 20:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbXBYT1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 14:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbXBYT1W
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 14:27:22 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:52997 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390AbXBYT1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 14:27:21 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 46C2459C99;
	Sun, 25 Feb 2007 20:27:20 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 304361F084;
	Sun, 25 Feb 2007 20:27:15 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40568>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pull.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index e4a2b62..7b3c90c 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -20,6 +20,7 @@ from optparse import OptionParser, make_option
 
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.config import GitConfigException
 from stgit import stack, git
 
 
@@ -73,7 +74,7 @@ def func(parser, options, args):
     elif policy == 'rebase':
         must_rebase = 1
     else:
-        raise config.ConfigException, 'Unsupported pull-policy "%s"' % policy
+        raise GitConfigException, 'Unsupported pull-policy "%s"' % policy
 
     applied = prepare_rebase(real_rebase=must_rebase, force=options.force)
 
