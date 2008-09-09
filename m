From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH] Add support for initializing a branch for stgit from Emacs.
Date: Tue, 09 Sep 2008 10:47:22 +0200
Message-ID: <878wu1904l.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Karl =?utf-8?Q?Hasselstr?= =?utf-8?Q?=C3=B6m?= 
	<kha@treskal.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 10:48:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcytl-0002Em-8D
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbYIIIr1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Sep 2008 04:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbYIIIr0
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:47:26 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:50914 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbYIIIr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:47:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 30426200A24C;
	Tue,  9 Sep 2008 10:47:25 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 25814-01-20; Tue, 9 Sep 2008 10:47:24 +0200 (CEST)
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id D4F16200A24B;
	Tue,  9 Sep 2008 10:47:24 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 6D7707B4089; Tue,  9 Sep 2008 10:47:22 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95359>

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/stgit.el |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

This diff was taken against kha/experimental, but I don't think the
file has changed there.

diff --git a/contrib/stgit.el b/contrib/stgit.el
index 5aaf311..aafefaf 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -130,7 +130,10 @@ Argument DIR is the repository path."
                                     'face 'stgit-description-face)
                  (when (memq patchsym stgit-marked-patches)
                    (replace-match "*" nil nil nil 2)
-                   (setq marked (cons patchsym marked))))))
+                   (setq marked (cons patchsym marked)))))
+              ((looking-at "stg series: Branch \".*\" not initialised"=
)
+               (forward-line 1)
+               (insert "Run M-x stgit-init to initialise")))
         (forward-line 1))
       (setq stgit-marked-patches (nreverse marked)))))
=20
@@ -218,6 +221,13 @@ Commands:
       (goto-char p)
       nil)))
=20
+(defun stgit-init ()
+  "Run stg init"
+  (interactive)
+  (stgit-capture-output nil
+   (stgit-run "init"))
+  (stgit-refresh))
+
 (defun stgit-mark ()
   "Mark the patch under point"
   (interactive)
--=20
1.6.0.rc2.7.gbf8a


--=20
David K=C3=A5gedal
