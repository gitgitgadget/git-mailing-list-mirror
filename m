From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] vc-git.el: Switch to using git-blame instead of git-annotate.
Date: Thu, 05 Oct 2006 11:30:44 +0200
Message-ID: <87k63f9kjf.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 05 11:30:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVPZ4-0005US-As
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 11:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWJEJar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 05:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWJEJar
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 05:30:47 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:1504 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751271AbWJEJar (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 05:30:47 -0400
Received: from adsl-89-217-6-110.adslplus.ch ([89.217.6.110] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GVPZ0-0007EN-57
	for git@vger.kernel.org; Thu, 05 Oct 2006 04:30:46 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 252AD4F8E1; Thu,  5 Oct 2006 11:30:44 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28351>


Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/vc-git.el |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 4a8f790..4189c4c 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -119,10 +119,10 @@ (defun vc-git-checkout (file &optional e
 (defun vc-git-annotate-command (file buf &optional rev)
   ; FIXME: rev is ignored
   (let ((name (file-relative-name file)))
-    (call-process "git" nil buf nil "annotate" name)))
+    (call-process "git" nil buf nil "blame" name)))
 
 (defun vc-git-annotate-time ()
-  (and (re-search-forward "[0-9a-f]+\t(.*\t\\([0-9]+\\)-\\([0-9]+\\)-\\([0-9]+\\) \\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\) \\([-+0-9]+\\)\t[0-9]+)" nil t)
+  (and (re-search-forward "[0-9a-f]+ (.* \\([0-9]+\\)-\\([0-9]+\\)-\\([0-9]+\\) \\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\) \\([-+0-9]+\\) +[0-9]+)" nil t)
        (vc-annotate-convert-time
         (apply #'encode-time (mapcar (lambda (match) (string-to-number (match-string match))) '(6 5 4 3 2 1 7))))))
 
-- 
1.4.2.3.g1723

-- 
Alexandre Julliard
julliard@winehq.org
