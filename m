From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 06/11] git: browsing paths with spaces when using the start command
Date: Sun, 31 May 2009 18:15:20 +0200
Message-ID: <1243786525-4493-7-git-send-email-prohaska@zib.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
 <1243786525-4493-2-git-send-email-prohaska@zib.de>
 <1243786525-4493-3-git-send-email-prohaska@zib.de>
 <1243786525-4493-4-git-send-email-prohaska@zib.de>
 <1243786525-4493-5-git-send-email-prohaska@zib.de>
 <1243786525-4493-6-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 18:16:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAniL-0001nG-Rl
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758846AbZEaQQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 12:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758134AbZEaQQP
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:16:15 -0400
Received: from mailer.zib.de ([130.73.108.11]:58623 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756801AbZEaQQG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 12:16:06 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4VGFVux006799;
	Sun, 31 May 2009 18:15:36 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4VGFPVD021220;
	Sun, 31 May 2009 18:15:31 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243786525-4493-6-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120411>

From: Pat Thoyts <patthoyts@users.sourceforge.net>

msysGit issue 258 tracks a problem opening a browser onto file
paths that contain spaces or parentheses when calling the
web--browse script. This patch modifies how the start command is
called to solve this.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-web--browse.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 7ed0fad..4f5c740 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -161,9 +161,12 @@ case "$browser" in
 		;;
 	esac
 	;;
-    w3m|links|lynx|open|start)
+    w3m|links|lynx|open)
 	eval "$browser_path" "$@"
 	;;
+    start)
+        exec "$browser_path" '"web-browse"' "$@"
+        ;;
     dillo)
 	"$browser_path" "$@" &
 	;;
-- 
1.6.3.1.54.g99dd
