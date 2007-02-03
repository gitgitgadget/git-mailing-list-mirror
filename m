From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] Correctly check the pull-does-rebase parameter in 'stg
	pull'.
Date: Sat, 03 Feb 2007 17:04:20 +0100
Message-ID: <20070203160420.32054.20462.stgit@gandelf.nowhere.earth>
References: <20070203160257.32054.17787.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 17:33:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDNp9-0004hD-VQ
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 17:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946485AbXBCQdH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 11:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946495AbXBCQdH
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 11:33:07 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:37478 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946485AbXBCQdG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 11:33:06 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 97F079B5B0;
	Sat,  3 Feb 2007 17:33:05 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id B95D61F07F;
	Sat,  3 Feb 2007 17:04:20 +0100 (CET)
In-Reply-To: <20070203160257.32054.17787.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38574>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pull.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 15bbed6..330cc25 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -72,7 +72,8 @@ def func(parser, options, args):
     # pull the remote changes
     print 'Pulling from "%s"...' % repository
     git.fetch(repository)
-    if (config.get('stgit.pull-does-rebase')):
+    if (config.get('stgit.pull-does-rebase') == 'yes'):
+        print "rebasing to '%s'..." % crt_series.get_parent_branch()
         git.reset(tree_id = git.rev_parse(crt_series.get_parent_branch()))
     print 'done'
 
