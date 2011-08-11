From: Mike Crowe <mac@mcrowe.com>
Subject: [PATCH] post-receive-email: Fix handling of hooks.emailmaxlines configuration option
Date: Thu, 11 Aug 2011 18:13:31 +0100
Message-ID: <1313082811-1396-1-git-send-email-mac@mcrowe.com>
Cc: mac@mcrowe.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:42:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZGk-00010q-IG
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab1HKRmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:42:01 -0400
Received: from elite.brightsigndigital.co.uk ([81.142.160.137]:58742 "EHLO
	elite.roku" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752606Ab1HKRl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:41:58 -0400
X-Greylist: delayed 1685 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Aug 2011 13:41:57 EDT
Received: from lander.roku ([172.30.1.6])
	by elite.roku with esmtp (Exim 4.72)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1QrYpK-0002er-Mz; Thu, 11 Aug 2011 18:13:50 +0100
Received: from mac by lander.roku with local (Exim 4.72)
	(envelope-from <mac@lander.roku>)
	id 1QrYpK-0000N7-Ls; Thu, 11 Aug 2011 18:13:50 +0100
X-Mailer: git-send-email 1.7.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179111>

Make the hooks.emailmaxlines configuration option work correctly
again. It looks like this was broken by 53cad691.

Signed-off-by: Mike Crowe <mac@mcrowe.com>
---
 contrib/hooks/post-receive-email |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index fa6d41a..ab6d298 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -85,7 +85,6 @@ prep_for_email()
 	oldrev=$(git rev-parse $1)
 	newrev=$(git rev-parse $2)
 	refname="$3"
-	maxlines=$4
 
 	# --- Interpret
 	# 0000->1234 (create)
@@ -198,6 +197,8 @@ prep_for_email()
 generate_email()
 {
 	# Email parameters
+	maxlines=$1
+
 	# The email subject will contain the best description of the ref
 	# that we can build from the parameters
 	describe=$(git describe $rev 2>/dev/null)
-- 
1.7.2.5
