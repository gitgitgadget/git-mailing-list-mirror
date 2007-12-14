From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 12/17] Emacs mode: added stgit-commit and stgit-uncommit
Date: Fri, 14 Dec 2007 11:58:51 +0100
Message-ID: <20071214105844.18066.69094.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 11:59:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38Fq-0001Hm-QX
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764172AbXLNK6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764061AbXLNK6f
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:58:35 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51844 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763679AbXLNK6e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:58:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 1F27E200A217;
	Fri, 14 Dec 2007 11:58:33 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28143-01-59; Fri, 14 Dec 2007 11:58:32 +0100 (CET)
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 9F786200A1E8;
	Fri, 14 Dec 2007 11:58:32 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 160737B406D;
	Fri, 14 Dec 2007 11:58:51 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68288>


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 20cb08f..4282585 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -90,6 +90,8 @@ Argument DIR is the repository path."
   (define-key stgit-mode-map "g"   'stgit-refresh)
   (define-key stgit-mode-map "r"   'stgit-rename)
   (define-key stgit-mode-map "\C-r"   'stgit-repair)
+  (define-key stgit-mode-map "C"   'stgit-commit)
+  (define-key stgit-mode-map "U"   'stgit-uncommit)
   (define-key stgit-mode-map ">"   'stgit-push-next)
   (define-key stgit-mode-map "<"   'stgit-pop-next)
   (define-key stgit-mode-map "P"   'stgit-push-or-pop)
@@ -146,6 +148,18 @@ Commands:
    (stgit-run "repair"))
   (stgit-refresh))
=20
+(defun stgit-commit ()
+  "Run stg commit."
+  (interactive)
+  (stgit-capture-output nil (stgit-run "commit"))
+  (stgit-refresh))
+
+(defun stgit-uncommit (arg)
+  "Run stg uncommit. Numeric arg determines number of patches to uncom=
mit."
+  (interactive "p")
+  (stgit-capture-output nil (stgit-run "uncommit" "-n" (number-to-stri=
ng arg)))
+  (stgit-refresh))
+
 (defun stgit-push-next ()
   "Push the first unapplied patch"
   (interactive)
