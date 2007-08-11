From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Always set the current directory in the git-diff buffer.
Date: Sat, 11 Aug 2007 12:23:21 +0200
Message-ID: <87fy2qwesm.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 12:23:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJo80-0002Bq-BY
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 12:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317AbXHKKXZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 06:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753950AbXHKKXZ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 06:23:25 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:39406 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbXHKKXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 06:23:24 -0400
Received: from adsl-89-217-132-200.adslplus.ch ([89.217.132.200] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IJo7v-0000Dh-P7
	for git@vger.kernel.org; Sat, 11 Aug 2007 05:23:24 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 98B961E7174; Sat, 11 Aug 2007 12:23:21 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55603>

This allows jumping to the correct file with the diff-mode commands.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 214b75c..be44e06 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -912,10 +912,12 @@ Return the list of files that haven't been handled."
 
 (defun git-setup-diff-buffer (buffer)
   "Setup a buffer for displaying a diff."
-  (with-current-buffer buffer
-    (diff-mode)
-    (goto-char (point-min))
-    (setq buffer-read-only t))
+  (let ((dir default-directory))
+    (with-current-buffer buffer
+      (diff-mode)
+      (goto-char (point-min))
+      (setq default-directory dir)
+      (setq buffer-read-only t)))
   (display-buffer buffer)
   (shrink-window-if-larger-than-buffer))
 
-- 
1.5.3.rc4.70.gf909

-- 
Alexandre Julliard
julliard@winehq.org
