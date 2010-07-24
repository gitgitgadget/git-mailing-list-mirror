From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] Documentation/git-push: Explain status output in more detail
Date: Sat, 24 Jul 2010 18:03:15 +0200
Message-ID: <10aba8f15aea6cff0d90ab4fbea023d7187f575c.1279986834.git.trast@student.ethz.ch>
References: <ab7b73ce593846b083bf0f4c4c7de08fb6008a5e.1279986834.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, bill lam <cbill.lam@gmail.com>,
	<Eric@cybersprocket.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 24 18:03:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OchCR-0006AY-PT
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 18:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349Ab0GXQDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 12:03:39 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:7318 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754819Ab0GXQDi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 12:03:38 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 24 Jul
 2010 18:03:36 +0200
Received: from localhost.localdomain (217.162.250.31) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sat, 24 Jul
 2010 18:03:15 +0200
X-Mailer: git-send-email 1.7.2.278.g76edd.dirty
In-Reply-To: <ab7b73ce593846b083bf0f4c4c7de08fb6008a5e.1279986834.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151659>

Mention the effects of the receive.deny* family of options for the
"remote rejected" case.  While there, also split up the explanation
into an easier-to-parse list format.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I considered instead patching receive-pack to have more verbose
messages, but decided not to, because it's already very verbose (by
git standards anyway) and because a doc update has the advantage of
immediately showing up in the kernel.org-hosted copies instead of
appearing in two years when hosting providers update their gits.


 Documentation/git-push.txt |   33 +++++++++++++++++++++++----------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index b68abff..658ff2f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -200,16 +200,29 @@ summary::
 	For a successfully pushed ref, the summary shows the old and new
 	values of the ref in a form suitable for using as an argument to
 	`git log` (this is `<old>..<new>` in most cases, and
-	`<old>...<new>` for forced non-fast-forward updates). For a
-	failed update, more details are given for the failure.
-	The string `rejected` indicates that git did not try to send the
-	ref at all (typically because it is not a fast-forward). The
-	string `remote rejected` indicates that the remote end refused
-	the update; this rejection is typically caused by a hook on the
-	remote side. The string `remote failure` indicates that the
-	remote end did not report the successful update of the ref
-	(perhaps because of a temporary error on the remote side, a
-	break in the network connection, or other transient error).
+	`<old>...<new>` for forced non-fast-forward updates).
++
+For a failed update, more details are given:
++
+--
+rejected::
+	Git did not try to send the ref at all, typically because it
+	is not a fast-forward and you did not force the update.
+
+remote rejected::
+	The remote end refused the update.  Usually caused by a hook
+	on the remote side, or because the remote repository has one
+	of the following safety options in effect:
+	`receive.denyCurrentBranch` (for pushes to the checked out
+	branch), `receive.denyNonFastForwards` (for forced
+	non-fast-forward updates), `receive.denyDeletes` or
+	`receive.denyDeleteCurrent`.  See linkgit:git-config[1].
+
+remote failure::
+	The remote end did not report the successful update of the ref,
+	perhaps because of a temporary error on the remote side, a
+	break in the network connection, or other transient error.
+--
 
 from::
 	The name of the local ref being pushed, minus its
-- 
1.7.2.278.g76edd.dirty
