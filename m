From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 03/10] Make use exception raised by removedirs.
Date: Thu, 15 Mar 2007 01:26:44 +0100
Message-ID: <20070315002644.9094.83602.stgit@gandelf.nowhere.earth>
References: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:26:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdnz-00035L-4s
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422757AbXCOA0r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422760AbXCOA0q
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:26:46 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59002 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422757AbXCOA0q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:26:46 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 52ED938F0;
	Thu, 15 Mar 2007 01:26:45 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id E11C11F095;
	Thu, 15 Mar 2007 01:26:44 +0100 (CET)
In-Reply-To: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42258>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 8fdaf2c..ec75507 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -684,14 +684,14 @@ class Series(StgitObject):
             else:
                 print 'Patch directory %s is not empty.' % self.__patch_dir
 
-            if not os.listdir(self._dir()):
+            try:
                 os.removedirs(self._dir())
-            else:
+            except OSError:
                 raise StackException, 'Series directory %s is not empty.' % self._dir()
 
-            if not os.listdir(self.__refs_dir):
+            try:
                 os.removedirs(self.__refs_dir)
-            else:
+            except OSError:
                 print 'Refs directory %s is not empty.' % self.__refs_dir
 
         if os.path.exists(self.__base_file):
