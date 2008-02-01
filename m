From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/3] It's possible to edit unapplied patches now
Date: Fri, 01 Feb 2008 08:50:57 +0100
Message-ID: <20080201075041.7905.78693.stgit@yoghurt>
References: <20080201074708.7905.98305.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 09:23:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKrBc-0005El-Iv
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 09:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbYBAIXG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Feb 2008 03:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYBAIXG
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 03:23:06 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3635 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415AbYBAIXD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 03:23:03 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JKqfn-0008Jd-00; Fri, 01 Feb 2008 07:50:55 +0000
In-Reply-To: <20080201074708.7905.98305.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72156>

With the rewrite, "stg edit" gained the ability to edit unapplied
patches, so the emacs mode no longer has to check that a patch is
applied before trying to edit it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 contrib/stgit.el |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index e8bbb2c..bef41c7 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -290,9 +290,7 @@ Commands:
 (defun stgit-edit ()
   "Edit the patch on the current line"
   (interactive)
-  (let ((patch (if (stgit-applied-at-point)
-                   (stgit-patch-at-point)
-                 (error "This patch is not applied")))
+  (let ((patch (stgit-patch-at-point))
         (edit-buf (get-buffer-create "*StGit edit*"))
         (dir default-directory))
     (log-edit 'stgit-confirm-edit t nil edit-buf)
