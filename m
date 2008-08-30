From: David Christensen <david@endpoint.com>
Subject: [PATCH] git.el: Add "git grep" functionality in a grep-style compilation buffer
Date: Sat, 30 Aug 2008 13:55:23 -0500
Message-ID: <1220122523-68561-1-git-send-email-david@endpoint.com>
Cc: julliard@winehq.org, David Christensen <david@endpoint.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 20:56:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZVcj-0008AZ-7k
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 20:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbYH3Szb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 14:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYH3Szb
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 14:55:31 -0400
Received: from smtp.sunflower.com ([24.124.0.128]:42747 "EHLO
	smtp.sunflower.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbYH3Szb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 14:55:31 -0400
Received: from localhost.localdomain (188.142.45.66.cm.sunflower.com [66.45.142.188])
	by smtp.sunflower.com (8.13.1/8.13.1) with ESMTP id m7UItOVr003028;
	Sat, 30 Aug 2008 13:55:24 -0500
X-Mailer: git-send-email 1.6.0.1.90.g27a6e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94405>


Signed-off-by: David Christensen <david@endpoint.com>
---
 contrib/emacs/git.el |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 279610f..46a9e49 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1395,6 +1395,15 @@ amended version of it."
   (let ((info (ewoc-data (ewoc-locate git-status))))
     (view-file (git-fileinfo->name info))))
 
+(defun git-grep (pat)
+  "Run git grep on the repository with the provided pattern;
+results are placed in a grep-compilation buffer."
+  (interactive "sgit grep regexp: ")
+  (unless git-status (error "Not in git-status buffer."))
+  (let ((null-device nil)
+        (git-grep-flags nil))           ; for future extension
+    (grep (concat "git --no-pager grep -n " git-grep-flags " -e " pat))))
+
 (defun git-refresh-status ()
   "Refresh the git status buffer."
   (interactive)
@@ -1446,6 +1455,7 @@ amended version of it."
     (suppress-keymap map)
     (define-key map "?"   'git-help)
     (define-key map "*"    mark-map)
+    (define-key map "%"   'git-grep)
     (define-key map "h"   'git-help)
     (define-key map " "   'git-next-file)
     (define-key map "a"   'git-add-file)
-- 
1.6.0.1.90.g27a6e.dirty
