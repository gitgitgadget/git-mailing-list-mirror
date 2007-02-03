From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] Warn the user when there is no parent information in the
	config.
Date: Sat, 03 Feb 2007 17:04:25 +0100
Message-ID: <20070203160425.32054.75599.stgit@gandelf.nowhere.earth>
References: <20070203160257.32054.17787.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 17:05:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDNOV-0007jj-JU
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 17:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946479AbXBCQFg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 11:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946480AbXBCQFg
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 11:05:36 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:40770 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946479AbXBCQFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 11:05:36 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 261DD4A0E7;
	Sat,  3 Feb 2007 17:05:35 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id D4F6B1F080;
	Sat,  3 Feb 2007 17:04:25 +0100 (CET)
In-Reply-To: <20070203160257.32054.17787.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38570>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 3960729..9609ed3 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -418,8 +418,7 @@ class Series(StgitObject):
         if value:
             return value
         elif 'origin' in git.remotes_list():
-            # FIXME: this is for compatibility only.  Should be
-            # dropped when all relevant commands record this info.
+            print "Notice: no parent remote declared for stack '%s', defaulting to 'origin'.  Consider setting 'branch.%s.remote' with 'git repo-config'." % (self.__name, self.__name)
             return 'origin'
         else:
             raise StackException, 'Cannot find a parent remote for "%s"' % self.__name
@@ -432,8 +431,7 @@ class Series(StgitObject):
         if value:
             return value
         elif git.rev_parse('heads/origin'):
-            # FIXME: this is for compatibility only.  Should be
-            # dropped when all relevant commands record this info.
+            print "Notice: no parent branch declared for stack '%s', defaulting to 'heads/origin'.  Consider setting 'branch.%s.merge' with 'git repo-config'." % (self.__name, self.__name)
             return 'heads/origin'
         else:
             raise StackException, 'Cannot find a parent branch for "%s"' % self.__name
