From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] Fix removal of series to nuke the formatversion config
	item.
Date: Wed, 06 Jun 2007 23:05:22 +0200
Message-ID: <20070606210522.7657.13508.stgit@gandelf.nowhere.earth>
References: <20070606205852.7657.69286.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:05:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw2hM-0003gu-4M
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 23:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934842AbXFFVFY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 17:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbXFFVFX
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 17:05:23 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:44518 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964881AbXFFVFV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 17:05:21 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 6ED115A21A;
	Wed,  6 Jun 2007 23:05:20 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id E3CAF1F019;
	Wed,  6 Jun 2007 23:05:22 +0200 (CEST)
In-Reply-To: <20070606205852.7657.69286.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49312>


Since this parameter is now used to decide if the branch has already
been initialised, not removing it forbids to create a stack with the
same name as one that was deleted.

Signed-off-by: Yann Dirson <ydirson@altern.org>

---

 stgit/stack.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 30fcca7..e2bf6ac 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -718,6 +718,7 @@ class Series(StgitObject):
         config.unset('branch.%s.remote' % self.__name)
         config.unset('branch.%s.merge' % self.__name)
         config.unset('branch.%s.stgit.parentbranch' % self.__name)
+        config.unset('branch.%s.stgitformatversion' % self.__name)
 
     def refresh_patch(self, files = None, message = None, edit = False,
                       show_patch = False,
