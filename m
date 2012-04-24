From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/7] Documentation: explain push.default option a bit more
Date: Tue, 24 Apr 2012 09:50:00 +0200
Message-ID: <1335253806-9059-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335253806-9059-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 24 09:51:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMaWg-0001tS-6h
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 09:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab2DXHvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 03:51:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49102 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798Ab2DXHu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 03:50:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3O7iBYU018727
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 24 Apr 2012 09:44:13 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMaW9-0007JO-6M; Tue, 24 Apr 2012 09:50:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMaW9-0002NX-2X; Tue, 24 Apr 2012 09:50:33 +0200
X-Mailer: git-send-email 1.7.10.234.g365b0
In-Reply-To: <1335253806-9059-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 24 Apr 2012 09:44:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3O7iBYU018727
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335858256.25154@sr6jpM2NEHE1IBSK1v4DDQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196196>

The previous documentation was explaining _what_ the options were doing,
but were of little help explaining _why_ a user should set his default to
either of the options.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Should match exactly Junio's proposal. I like the wording.

 Documentation/config.txt |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fb386ab..5f14871 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1680,12 +1680,24 @@ push.default::
 	line. Possible values are:
 +
 * `nothing` - do not push anything.
-* `matching` - push all matching branches.
-  All branches having the same name in both ends are considered to be
-  matching. This is the default.
+* `matching` - push all branches having the same name in both ends.
+  This is for those who prepare all the branches into a publishable
+  shape and then push them out with a single command.  It is not
+  appropriate for pushing into a repository shared by multiple users,
+  since locally stalled branches will attempt a non-fast forward push
+  if other users updated the branch.  This is the default.
 * `upstream` - push the current branch to its upstream branch.
+  With this, `git push` will update the same remote ref as the one which
+  is merged by `git pull`, making `push` and `pull` symmetrical.
+  See "branch.<name>.merge" for how to configure the upstream branch.
 * `tracking` - deprecated synonym for `upstream`.
 * `current` - push the current branch to a branch of the same name.
+  +
+  The `current` and `upstream` modes are for those who want to
+  push out a single branch after finishing work, even when the other
+  branches are not yet ready to be pushed out. If you are working with
+  other people to push into the same shared repository, you would want
+  to use one of these.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
-- 
1.7.10.234.g365b0
