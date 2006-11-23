X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/4] Make Series::patch_applied public.
Date: Fri, 24 Nov 2006 00:16:44 +0100
Message-ID: <20061123231632.9769.72003.stgit@gandelf.nowhere.earth>
References: <20061123230721.9769.38403.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 23:17:58 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061123230721.9769.38403.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32171>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNpI-0001fQ-8U for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934250AbWKWXRr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934251AbWKWXRr
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:17:47 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:49628 "EHLO
 smtp5-g19.free.fr") by vger.kernel.org with ESMTP id S934250AbWKWXRq (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:17:46 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp5-g19.free.fr (Postfix) with ESMTP id CE0FF279D0;
 Fri, 24 Nov 2006 00:17:45 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch) by
 bylbo.nowhere.earth with esmtp (Exim 4.62) (envelope-from
 <ydirson@altern.org>) id 1GnNpF-0002sw-MW; Fri, 24 Nov 2006 00:17:49 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index a477e7d..49cfebb 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -417,7 +417,7 @@ class Series:
     def __patch_is_current(self, patch):
         return patch.get_name() == read_string(self.__current_file)
 
-    def __patch_applied(self, name):
+    def patch_applied(self, name):
         """Return true if the patch exists in the applied list
         """
         return name in self.get_applied()
@@ -430,7 +430,7 @@ class Series:
     def patch_exists(self, name):
         """Return true if there is a patch with the given name, false
         otherwise."""
-        return self.__patch_applied(name) or self.__patch_unapplied(name)
+        return self.patch_applied(name) or self.__patch_unapplied(name)
 
     def __begin_stack_check(self):
         """Save the current HEAD into .git/refs/heads/base if the stack
@@ -713,7 +713,7 @@ class Series:
                   before_existing = False, refresh = True):
         """Creates a new patch
         """
-        if self.__patch_applied(name) or self.__patch_unapplied(name):
+        if self.patch_applied(name) or self.__patch_unapplied(name):
             raise StackException, 'Patch "%s" already exists' % name
 
         if not message and can_edit:
@@ -773,7 +773,7 @@ class Series:
 
         if self.__patch_is_current(patch):
             self.pop_patch(name)
-        elif self.__patch_applied(name):
+        elif self.patch_applied(name):
             raise StackException, 'Cannot remove an applied patch, "%s", ' \
                   'which is not current' % name
