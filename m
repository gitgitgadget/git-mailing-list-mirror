From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/4] Documentation: explain push.default option a bit more
Date: Fri, 20 Apr 2012 16:59:01 +0200
Message-ID: <1334933944-13446-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
 <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 20 17:01:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLFKZ-0007if-Mn
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 17:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab2DTPA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 11:00:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34545 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756767Ab2DTPA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 11:00:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3KEr6tv032168
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2012 16:53:06 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SLFIp-0008Mi-Px; Fri, 20 Apr 2012 16:59:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SLFIp-0003W6-Oo; Fri, 20 Apr 2012 16:59:15 +0200
X-Mailer: git-send-email 1.7.10.140.g8c333
In-Reply-To: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 20 Apr 2012 16:53:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3KEr6tv032168
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335538388.27472@Hv0xeF/Ib1FaxcgeM4CggQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196001>

The previous documentation was explaining _what_ the options were doing,
but were of little help explaining _why_ a user should set his default to
either of the options.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fb386ab..368a770 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1682,10 +1682,21 @@ push.default::
 * `nothing` - do not push anything.
 * `matching` - push all matching branches.
   All branches having the same name in both ends are considered to be
-  matching. This is the default.
-* `upstream` - push the current branch to its upstream branch.
+  matching. This is well suited when pushing to a non-shared
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
+  This option allows publishing a branch to a remote repository using
+  the same naming convention locally and remotely, in a more
+  conservative and safer way than `matching`.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
-- 
1.7.10.140.g8c333
