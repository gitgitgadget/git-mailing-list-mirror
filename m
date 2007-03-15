From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 05/10] Copy parentbranch setting on 'stg branch --clone'.
Date: Thu, 15 Mar 2007 01:26:55 +0100
Message-ID: <20070315002655.9094.26346.stgit@gandelf.nowhere.earth>
References: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:27:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdo7-00039o-5O
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422764AbXCOA05 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422768AbXCOA05
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:26:57 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59022 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422764AbXCOA04 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:26:56 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8C3D638F0;
	Thu, 15 Mar 2007 01:26:55 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 219961F095;
	Thu, 15 Mar 2007 01:26:55 +0100 (CET)
In-Reply-To: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42260>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index ec75507..d1b04ca 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -639,7 +639,7 @@ class Series(StgitObject):
         # fast forward the cloned series to self's top
         new_series.forward_patches(applied)
 
-        # Clone remote and merge settings
+        # Clone parent informations
         value = config.get('branch.%s.remote' % self.__name)
         if value:
             config.set('branch.%s.remote' % target_series, value)
@@ -648,6 +648,10 @@ class Series(StgitObject):
         if value:
             config.set('branch.%s.merge' % target_series, value)
 
+        value = config.get('branch.%s.stgit.parentbranch' % self.__name)
+        if value:
+            config.set('branch.%s.stgit.parentbranch' % target_series, value)
+
     def delete(self, force = False):
         """Deletes an stgit series
         """
