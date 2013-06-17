From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Documentation/git-push.txt: explain better cases where --force is dangerous
Date: Mon, 17 Jun 2013 19:52:41 +0200
Message-ID: <1371491561-19117-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: philipoakley@iee.org, artagnon@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 17 19:53:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uodbu-0004Bt-Ah
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 19:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688Ab3FQRww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 13:52:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40741 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754139Ab3FQRwt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 13:52:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5HHqfVj030552
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 17 Jun 2013 19:52:41 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Uodbf-0001b5-H4; Mon, 17 Jun 2013 19:52:43 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Uodbf-0004yz-4H; Mon, 17 Jun 2013 19:52:43 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 17 Jun 2013 19:52:41 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228089>

The behavior of "git push --force" is rather clear when it updates only
one remote ref, but running it when pushing several branches can really
be dangerous. Warn the users a bit more and give them the alternative to
push only one branch.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-push.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 938d1ee..9b9e7d1 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -136,6 +136,14 @@ already exists on the remote side.
 	not an ancestor of the local ref used to overwrite it.
 	This flag disables the check.  This can cause the
 	remote repository to lose commits; use it with care.
+	Note that `--force` applies to all the refs that are pushed,
+	hence using it with `push.default` set to `matching` or with
+	multiple push destination configured may override refs other
+	than the current branch (including local refs that are
+	strictly behind their remote counterpart). To force a push to
+	only one branch, use a `+` in front of the refspec to push
+	(e.g `git push origin +master` to force a push to the `master`
+	branch). See the `<refspec>...` section above for details.
 
 --repo=<repository>::
 	This option is only relevant if no <repository> argument is
-- 
1.8.3.1.495.g13f33cf.dirty
