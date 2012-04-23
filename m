From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/7] Documentation: explain push.default option a bit more
Date: Mon, 23 Apr 2012 10:37:58 +0200
Message-ID: <1335170284-30768-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 23 10:38:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMEnG-00034n-K5
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 10:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350Ab2DWIio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 04:38:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55580 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343Ab2DWIin (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 04:38:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3N8VnUM029932
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Apr 2012 10:31:50 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMEmd-0004mo-NZ; Mon, 23 Apr 2012 10:38:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMEmd-00081P-KM; Mon, 23 Apr 2012 10:38:07 +0200
X-Mailer: git-send-email 1.7.10.234.ge65dd.dirty
In-Reply-To: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 23 Apr 2012 10:31:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3N8VnUM029932
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335774714.31148@0YZUjbHMvBsq1ZlK5XU4+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196103>

The previous documentation was explaining _what_ the options were doing,
but were of little help explaining _why_ a user should set his default to
either of the options.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fb386ab..e38fab1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1680,12 +1680,26 @@ push.default::
 	line. Possible values are:
 +
 * `nothing` - do not push anything.
-* `matching` - push all matching branches.
-  All branches having the same name in both ends are considered to be
-  matching. This is the default.
-* `upstream` - push the current branch to its upstream branch.
+* `matching` - push all branches having the same name in both ends.
+  This allows those who prepare all the branches into a publishable
+  shape to push them out to a non-shared repository with a single
+  command. This is well suited when pushing to a non-shared
+  repository, but may give surprising results when used on a
+  repository shared by multiple users, since locally stalled
+  branches will attempt a non-fast forward push if other users
+  updated the branch remotely. This is the default.
+* `upstream` - push the current branch to its upstream branch. See
+  "branch.<name>.merge" for how to configure the upstream branch. This
+  makes `git push` and `git pull` symmetrical in the sense that `push`
+  will update the same remote ref as the one which is merged by
+  `git pull`.
 * `tracking` - deprecated synonym for `upstream`.
 * `current` - push the current branch to a branch of the same name.
+  +
+  The `current` and `upstream` modes are for those who want to
+  push out a single branch after finishing work, even when the other
+  branches are not yet ready to be pushed out. They are safe when
+  pushing to a shared repository.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
-- 
1.7.10.234.ge65dd.dirty
