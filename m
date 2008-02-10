From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 5/5] Emacs mode: use "stg new --file"
Date: Sun, 10 Feb 2008 21:46:04 +0100
Message-ID: <20080210204434.17683.61684.stgit@yoghurt>
References: <20080210203846.17683.43153.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJ4W-0005pG-3v
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527AbYBJUqJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 15:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbYBJUqJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:46:09 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2844 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755186AbYBJUqH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:46:07 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JOJ3r-0005DX-00; Sun, 10 Feb 2008 20:46:03 +0000
In-Reply-To: <20080210203846.17683.43153.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73409>

Creating a new patch is a great deal easier now that "stg new" has a
--file flag.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

David, will you sanity-check this? I don't really speak elisp, so I
might have done something insane without knowing it. But it does seem
to work. :-)

 contrib/stgit.el |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index bef41c7..30c1cd1 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -316,16 +316,10 @@ Commands:
=20
 (defun stgit-confirm-new ()
   (interactive)
-  (let ((file (make-temp-file "stgit-edit-"))
-        (patch (stgit-create-patch-name
-                (buffer-substring (point-min)
-                                  (save-excursion (goto-char (point-mi=
n))
-                                                  (end-of-line)
-                                                  (point))))))
+  (let ((file (make-temp-file "stgit-edit-")))
     (write-region (point-min) (point-max) file)
     (stgit-capture-output nil
-      (stgit-run "new" "-m" "placeholder" patch)
-      (stgit-run "edit" "-f" file patch))
+      (stgit-run "new" "-f" file))
     (with-current-buffer log-edit-parent-buffer
       (stgit-refresh))))
=20
