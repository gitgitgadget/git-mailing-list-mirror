From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 08/17] Emacs mode: show patches' short description
Date: Fri, 14 Dec 2007 11:57:55 +0100
Message-ID: <20071214105749.18066.43175.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 11:59:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38Fn-0001Hm-C7
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763490AbXLNK5j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763450AbXLNK5j
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:57:39 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51832 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763419AbXLNK5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:57:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 4CCF5200A238;
	Fri, 14 Dec 2007 11:57:37 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28143-01-53; Fri, 14 Dec 2007 11:57:37 +0100 (CET)
Received: from krank (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id F3055200A217;
	Fri, 14 Dec 2007 11:57:36 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 691047B406D;
	Fri, 14 Dec 2007 11:57:55 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68285>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 78e9520..ed2fc37 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -62,7 +62,7 @@ Argument DIR is the repository path."
     (erase-buffer)
     (insert "Branch: ")
     (stgit-run "branch")
-    (stgit-run "series")
+    (stgit-run "series" "--description")
     (if curpatch
         (stgit-goto-patch curpatch)
       (goto-line curline))))
@@ -97,13 +97,14 @@ Commands:
         goal-column 2)
   (use-local-map stgit-mode-map)
   (set (make-local-variable 'list-buffers-directory) default-directory=
)
+  (set-variable 'truncate-lines 't)
   (run-hooks 'stgit-mode-hook))
=20
 (defun stgit-patch-at-point ()
   "Return the patch name on the current line"
   (save-excursion
     (beginning-of-line)
-    (if (looking-at "[>+-] \\(.*\\)")
+    (if (looking-at "[>+-] \\([^ ]*\\)")
         (match-string 1)
       nil)))
=20
@@ -111,7 +112,7 @@ Commands:
   "Move point to the line containing PATCH"
   (let ((p (point)))
     (goto-char (point-min))
-    (if (re-search-forward (concat "[>+-] " (regexp-quote patch) "$") =
nil t)
+    (if (re-search-forward (concat "[>+-] " (regexp-quote patch) " ") =
nil t)
         (progn (move-to-column goal-column)
                t)
       (goto-char p)
