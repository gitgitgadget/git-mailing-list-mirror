From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] Cleanup variable names in pick.
Date: Sat, 05 May 2007 16:00:23 +0200
Message-ID: <20070505140023.5194.8083.stgit@gandelf.nowhere.earth>
References: <20070505135830.5194.90861.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 18:01:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkMhO-0007qT-NY
	for gcvg-git@gmane.org; Sat, 05 May 2007 18:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423325AbXEEQBH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 12:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423283AbXEEQBG
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 12:01:06 -0400
Received: from postfix1-g20.free.fr ([212.27.60.42]:49934 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423325AbXEEQBA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 12:01:00 -0400
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 93BCCF27B8B
	for <git@vger.kernel.org>; Sat,  5 May 2007 16:02:05 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B65385E063;
	Sat,  5 May 2007 16:01:04 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 986C51F15F;
	Sat,  5 May 2007 16:00:23 +0200 (CEST)
In-Reply-To: <20070505135830.5194.90861.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46259>


I'm going to need patch objects there, so avoid using variable "patch"
to store only a patchname.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pick.py |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index edd614d..4eb79a3 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -71,11 +71,11 @@ def func(parser, options, args):
     else:
         patch_branch = commit_str.split('@')
         if options.name:
-            patch = options.name
+            patchname = options.name
         elif len(patch_branch) == 2:
-            patch = patch_branch[0]
+            patchname = patch_branch[0]
         else:
-            patch = make_patch_name(commit.get_log(), crt_series.patch_exists)
+            patchname = make_patch_name(commit.get_log(), crt_series.patch_exists)
 
     if options.parent:
         parent = git_id(options.parent)
@@ -118,17 +118,17 @@ def func(parser, options, args):
         print 'Importing commit %s...' % commit_id,
         sys.stdout.flush()
 
-        crt_series.new_patch(patch, message = message, can_edit = False,
+        crt_series.new_patch(patchname, message = message, can_edit = False,
                              unapplied = True, bottom = bottom, top = top,
                              author_name = author_name,
                              author_email = author_email,
                              author_date = author_date)
         if not options.unapplied:
-            modified = crt_series.push_patch(patch)
+            modified = crt_series.push_patch(patchname)
         else:
             modified = False
 
-        if crt_series.empty_patch(patch):
+        if crt_series.empty_patch(patchname):
             print 'done (empty patch)'
         elif modified:
             print 'done (modified)'
