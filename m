From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 2/5] git.el: Set default directory before running the status mode setup hooks.
Date: Sat, 04 Mar 2006 17:38:05 +0100
Message-ID: <87fylykvwy.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 04 17:38:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFZll-0007iK-Lh
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 17:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWCDQiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 11:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWCDQiL
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 11:38:11 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:12492 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932109AbWCDQiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 11:38:09 -0500
Received: from adsl-84-227-8-187.adslplus.ch ([84.227.8.187] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FFZlf-0000jJ-Nr
	for git@vger.kernel.org; Sat, 04 Mar 2006 10:38:09 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 98C494F90E; Sat,  4 Mar 2006 17:38:05 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 84.227.8.187
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17185>

Also set the list-buffers-directory variable for nicer buffer list
display.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 contrib/emacs/git.el |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

437d990348e13e6a4460cc445ec5d2b2077cf2fb
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 5828d4c..2363e48 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -943,6 +943,7 @@ Commands:
     (erase-buffer)
   (let ((status (ewoc-create 'git-fileinfo-prettyprint "" "")))
     (set (make-local-variable 'git-status) status))
+  (set (make-local-variable 'list-buffers-directory) default-directory)
   (run-hooks 'git-status-mode-hook)))
 
 (defun git-status (dir)
@@ -952,8 +953,8 @@ Commands:
   (if (file-directory-p (concat (file-name-as-directory dir) ".git"))
       (let ((buffer (create-file-buffer (expand-file-name "*git-status*" dir))))
         (switch-to-buffer buffer)
-        (git-status-mode)
         (cd dir)
+        (git-status-mode)
         (git-refresh-status)
         (goto-char (point-min)))
     (message "%s is not a git working tree." dir)))
-- 
1.2.4.g0040-dirty


-- 
Alexandre Julliard
julliard@winehq.org
