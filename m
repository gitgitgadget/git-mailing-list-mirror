From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 10/10] Cleanup parent information on stgit branch deletion.
Date: Thu, 15 Mar 2007 01:27:20 +0100
Message-ID: <20070315002720.9094.44659.stgit@gandelf.nowhere.earth>
References: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:27:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdoU-0003MN-FX
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422774AbXCOA1X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbXCOA1X
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:27:23 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59052 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422774AbXCOA1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:27:22 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 21A29395B;
	Thu, 15 Mar 2007 01:27:21 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id AAD9F1F095;
	Thu, 15 Mar 2007 01:27:20 +0100 (CET)
In-Reply-To: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42265>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index c3dab68..c6f338d 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -700,6 +700,13 @@ class Series(StgitObject):
             remove_file_and_dirs(
                 os.path.join(self.__base_dir, 'refs', 'bases'), self.__name)
 
+        # Cleanup parent informations
+        # FIXME: should one day make use of git-config --section-remove,
+        # scheduled for 1.5.1
+        config.unset('branch.%s.remote' % self.__name)
+        config.unset('branch.%s.merge' % self.__name)
+        config.unset('branch.%s.stgit.parentbranch' % self.__name)
+
     def refresh_patch(self, files = None, message = None, edit = False,
                       show_patch = False,
                       cache_update = True,
