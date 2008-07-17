From: Lars Noschinski <lars@public.noschinski.de>
Subject: [PATCH] testsuite for cvs co -c
Date: Thu, 17 Jul 2008 12:01:17 +0200
Message-ID: <1216288877-12140-6-git-send-email-lars@public.noschinski.de>
References: <1216288877-12140-1-git-send-email-lars@public.noschinski.de>
 <1216288877-12140-2-git-send-email-lars@public.noschinski.de>
 <1216288877-12140-3-git-send-email-lars@public.noschinski.de>
 <1216288877-12140-4-git-send-email-lars@public.noschinski.de>
 <1216288877-12140-5-git-send-email-lars@public.noschinski.de>
Cc: fabian.emmes@rwth-aachen.de,
	Lars Noschinski <lars@public.noschinski.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 12:07:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJQOj-0005sE-Im
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 12:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbYGQKGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 06:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbYGQKGm
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 06:06:42 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:57178 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbYGQKGl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 06:06:41 -0400
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jul 2008 06:06:41 EDT
Received: from [137.226.194.201] (helo=localhost.localdomain)
	by smtprelay11.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KJQIc-0007y9-8B; Thu, 17 Jul 2008 12:01:22 +0200
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216288877-12140-5-git-send-email-lars@public.noschinski.de>
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88824>

From: Fabian Emmes <fabian.emmes@rwth-aachen.de>

Check that all branches are displayed.

Signed-off-by: Fabian Emmes <fabian.emmes@rwth-aachen.de>
Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
---
 t/t9400-git-cvsserver-server.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index d181b5b..3a59b9f 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -484,4 +484,15 @@ test_expect_success 'cvs status (no subdirs in header)' '
     ! grep / <../out
 '
 
+#------------
+# CVS CHECKOUT
+#------------
+
+cd "$WORKDIR"
+test_expect_success 'cvs co -c (shows module database)' '
+    GIT_CONFIG="$git_config" cvs co -c > out &&
+    grep "^master[	 ]\+master$" < out &&
+    ! grep -v "^master[	 ]\+master$" < out
+'
+
 test_done
-- 
1.5.6.2
