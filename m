X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 2/4] git.el: Added a function to open the current file in another window.
Date: Fri, 03 Nov 2006 17:41:46 +0100
Message-ID: <878xis32k5.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 16:42:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30863>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg277-0003k7-Cj for gcvg-git@gmane.org; Fri, 03 Nov
 2006 17:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753334AbWKCQlu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 11:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbWKCQlu
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 11:41:50 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:29879 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S1753334AbWKCQlt
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 11:41:49 -0500
Received: from adsl-84-227-158-29.adslplus.ch ([84.227.158.29]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1Gg272-0004Tm-Ie for
 git@vger.kernel.org; Fri, 03 Nov 2006 10:41:49 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id AB78C109EB7; Fri,
  3 Nov 2006 17:41:46 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Bound to 'o' by default, compatible with pcl-cvs and
buffer-mode. Suggested by Han-Wen Nienhuys.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index e283df2..08d6404 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -910,6 +910,15 @@ and returns the process output as a stri
     (when (eq 'unmerged (git-fileinfo->state info))
       (smerge-mode))))
 
+(defun git-find-file-other-window ()
+  "Visit the current file in its own buffer in another window."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (let ((info (ewoc-data (ewoc-locate git-status))))
+    (find-file-other-window (git-fileinfo->name info))
+    (when (eq 'unmerged (git-fileinfo->state info))
+      (smerge-mode))))
+
 (defun git-find-file-imerge ()
   "Visit the current file in interactive merge mode."
   (interactive)
@@ -994,6 +1003,7 @@ and returns the process output as a stri
     (define-key map "M"   'git-mark-all)
     (define-key map "n"   'git-next-file)
     (define-key map "N"   'git-next-unmerged-file)
+    (define-key map "o"   'git-find-file-other-window)
     (define-key map "p"   'git-prev-file)
     (define-key map "P"   'git-prev-unmerged-file)
     (define-key map "q"   'git-status-quit)
-- 
1.4.3.3.gf3240

-- 
Alexandre Julliard
