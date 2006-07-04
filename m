From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 1/2] annotate: Support annotation of files on other revisions.
Date: Mon, 03 Jul 2006 21:30:01 -0400
Message-ID: <11519766033852-git-send-email-ryan@michonline.com>
References: <11519766021208-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Tue Jul 04 03:32:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxZla-0000Gi-0w
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 03:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWGDBbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 21:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWGDBbt
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 21:31:49 -0400
Received: from h4x0r5.com ([70.85.31.202]:51469 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751158AbWGDBbt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 21:31:49 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythical)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FxZkI-0004EL-LX; Mon, 03 Jul 2006 18:30:35 -0700
Received: from ryan by mythical with local (Exim 4.62)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FxZjn-00042g-7O; Mon, 03 Jul 2006 21:30:03 -0400
To: junkio@cox.net
X-Mailer: git-send-email 1.4.1.g8fced
In-Reply-To: <11519766021208-git-send-email-ryan@michonline.com>
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23231>

This is a bug fix, and cleans up one or two other things spotted during the
course of tracking down the main bug here.

Also, the test-suite is updated to reflect this case.

Signed-off-by: Ryan Anderson <ryan@michonline.com>
(cherry picked from 2f7554b4db3ab2c2d3866b160245c91c9236fc9a commit)
---
 t/t8001-annotate.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index 2496397..70e2ad2 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -6,4 +6,10 @@ test_description='git-annotate'
 PROG='git annotate'
 . ../annotate-tests.sh
 
+test_expect_success \
+    'Annotating an old revision works' \
+    '[ $(git annotate file master | awk "{print \$3}" | grep -c "^A$") == 2 ] && \
+     [ $(git annotate file master | awk "{print \$3}" | grep -c "^B$") == 2 ]'
+
+
 test_done
-- 
1.4.1.g8fced
