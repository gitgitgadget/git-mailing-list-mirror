From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH 6/7] git-blame.el: Doc fixes and cleanup
Date: Fri, 09 Feb 2007 09:21:51 +0100
Message-ID: <87irebpwps.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 09:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFR8z-0006qQ-2c
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 09:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946215AbXBIIaF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 9 Feb 2007 03:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946213AbXBIIaF
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 03:30:05 -0500
Received: from main.gmane.org ([80.91.229.2]:56898 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946215AbXBIIaD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 03:30:03 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HFR8s-0006NS-7A
	for git@vger.kernel.org; Fri, 09 Feb 2007 09:30:02 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:30:02 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:30:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:lvIKr8fLqd9rsig+BUHDBGv+m6w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39161>


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/emacs/git-blame.el |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index f183964..7daa4e6 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -123,6 +123,7 @@
=20
 ;;;###autoload
 (defun git-blame-mode (&optional arg)
+  "Minor mode for displaying Git blame"
   (interactive "P")
   (if arg
       (setq git-blame-mode (eq arg 1))
@@ -170,20 +171,25 @@
       (process-send-region git-blame-proc (point-min) (point-max))
       (process-send-eof git-blame-proc))))
=20
+(defun remove-git-blame-text-properties (start end)
+  (let ((modified (buffer-modified-p))
+        (inhibit-read-only t))
+    (remove-text-properties start end '(point-entered nil))
+    (set-buffer-modified-p modified)))
+
 (defun git-blame-cleanup ()
   "Remove all blame properties"
     (mapcar 'delete-overlay git-blame-overlays)
     (setq git-blame-overlays nil)
-    (let ((modified (buffer-modified-p)))
-      (remove-text-properties (point-min) (point-max) '(point-entered =
nil))
-      (set-buffer-modified-p modified)))
+    (remove-git-blame-text-properties (point-min) (point-max)))
=20
 (defun git-blame-sentinel (proc status)
   (with-current-buffer (process-buffer proc)
     (with-current-buffer git-blame-file
       (setq git-blame-proc nil)))
   ;;(kill-buffer (process-buffer proc))
-  (message "git blame finished"))
+  ;;(message "git blame finished")
+  )
=20
 (defvar in-blame-filter nil)
=20
--=20
1.5.0.rc3.204.g93c76


--=20
David K=C3=A5gedal
