From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 1/4] git.el: Run git-rerere on commits if the rr-cache directory exists.
Date: Sat, 22 Jul 2006 15:39:02 +0200
Message-ID: <877j25hi89.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 22 15:39:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4HhI-0004ps-Es
	for gcvg-git@gmane.org; Sat, 22 Jul 2006 15:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWGVNjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Jul 2006 09:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWGVNjI
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Jul 2006 09:39:08 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:23749 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751349AbWGVNjH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jul 2006 09:39:07 -0400
Received: from adsl-84-227-106-91.adslplus.ch ([84.227.106.91] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G4HhC-0003CL-1b
	for git@vger.kernel.org; Sat, 22 Jul 2006 08:39:06 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id B88234F904; Sat, 22 Jul 2006 15:39:02 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24068>

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 34c9950..7371d4b 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -584,6 +584,8 @@ (defun git-do-commit ()
                             (condition-case nil (delete-file ".git/MERGE_HEAD") (error nil))
                             (with-current-buffer buffer (erase-buffer))
                             (git-set-files-state files 'uptodate)
+                            (when (file-directory-p ".git/rr-cache")
+                              (git-run-command nil nil "rerere"))
                             (git-refresh-files)
                             (git-refresh-ewoc-hf git-status)
                             (message "Committed %s." commit))
-- 
1.4.2.rc1.ge7a0

-- 
Alexandre Julliard
julliard@winehq.org
