From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 2/3] stgit.el: Added numeric prefix argument to push and
	pop commands.
Date: Thu, 30 Oct 2008 10:52:54 +0100
Message-ID: <20081030095253.10290.43869.stgit@krank>
References: <20081030095221.10290.58637.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kha@treskal.com, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 30 11:15:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvUYT-0007zW-Nc
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 11:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbYJ3KNq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2008 06:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495AbYJ3KNp
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 06:13:45 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:41497 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbYJ3KNp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 06:13:45 -0400
X-Greylist: delayed 1259 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Oct 2008 06:13:44 EDT
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 1AFBC4006E;
	Thu, 30 Oct 2008 10:52:56 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 0FC3840078; Thu, 30 Oct 2008 10:52:56 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from krank (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 586D34006E;
	Thu, 30 Oct 2008 10:52:53 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 033F3DC0A4;
	Thu, 30 Oct 2008 10:52:54 +0100 (CET)
In-Reply-To: <20081030095221.10290.58637.stgit@krank>
User-Agent: StGIT/0.14.3.278.g6f7d
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99453>

By using a numerical prefix (or simply C-u) it is possible to push or
pop more than one patch.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/stgit.el |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/contrib/stgit.el b/contrib/stgit.el
index e6b7d70..9907952 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -276,16 +276,19 @@ Commands:
   (stgit-capture-output nil (stgit-run "uncommit" "-n" (number-to-stri=
ng arg)))
   (stgit-refresh))
=20
-(defun stgit-push-next ()
-  "Push the first unapplied patch"
-  (interactive)
-  (stgit-capture-output nil (stgit-run "push"))
+(defun stgit-push-next (npatches)
+  "Push the first unapplied patch.
+With numeric prefix argument, push that many patches."
+  (interactive "p")
+  (stgit-capture-output nil (stgit-run "push" "-n"
+                                       (number-to-string npatches)))
   (stgit-refresh))
=20
-(defun stgit-pop-next ()
-  "Pop the topmost applied patch"
-  (interactive)
-  (stgit-capture-output nil (stgit-run "pop"))
+(defun stgit-pop-next (npatches)
+  "Pop the topmost applied patch.
+With numeric prefix argument, pop that many patches."
+  (interactive "p")
+  (stgit-capture-output nil (stgit-run "pop" "-n" (number-to-string np=
atches)))
   (stgit-refresh))
=20
 (defun stgit-applied-at-point ()
