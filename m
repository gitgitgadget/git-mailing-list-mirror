From: Mischa POSLAWSKY <git@shiar.nl>
Subject: [PATCH] git-jump: ignore (custom) prefix in diff mode
Date: Mon, 17 Sep 2012 03:21:55 +0200
Message-ID: <1347844915-4130-1-git-send-email-git@shiar.nl>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 03:48:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDQS3-0003NF-IS
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 03:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157Ab2IQBrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 21:47:53 -0400
Received: from shiar.demon.nl ([83.160.32.6]:36548 "EHLO shiar.demon.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065Ab2IQBrx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 21:47:53 -0400
X-Greylist: delayed 1554 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Sep 2012 21:47:53 EDT
Received: from shiar by shiar.demon.nl with local (Exim 4.77)
	(envelope-from <shiar@shiar.demon.nl>)
	id 1TDQ27-00015E-DO; Mon, 17 Sep 2012 03:21:55 +0200
X-Mailer: git-send-email 1.7.12.165.g8cb9d9c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205638>

Matching the default file prefix b/ does not yield any results if config
option diff.noprefix or diff.mnemonicprefix is enabled.

Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
---
Very useful script otherwise; thanks.

 contrib/git-jump/git-jump | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git contrib/git-jump/git-jump contrib/git-jump/git-jump
index a33674e..dc90cd6 100755
--- contrib/git-jump/git-jump
+++ contrib/git-jump/git-jump
@@ -21,9 +21,9 @@ open_editor() {
 }
 
 mode_diff() {
-	git diff --relative "$@" |
+	git diff --no-prefix --relative "$@" |
 	perl -ne '
-	if (m{^\+\+\+ b/(.*)}) { $file = $1; next }
+	if (m{^\+\+\+ (.*)}) { $file = $1; next }
 	defined($file) or next;
 	if (m/^@@ .*\+(\d+)/) { $line = $1; next }
 	defined($line) or next;
-- 
1.7.12.165.g8cb9d9c
