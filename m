From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH next] test-lib: set $DIFF to diff if it is unset
Date: Thu, 10 Jun 2010 11:39:49 +0200
Message-ID: <06ffbe0ca6aac061336f6f595e89f75c09ab88ac.1276162629.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 11:40:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMeF1-0001xd-Pt
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 11:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab0FJJj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 05:39:56 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:23909 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361Ab0FJJjz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 05:39:55 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 11:39:54 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 11:39:50 +0200
X-Mailer: git-send-email 1.7.1.550.g553ab5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148849>

Since 7b3bdbb (fixup: do not unconditionally disable "diff -u",
2010-05-31), test-lib.sh depends on having $DIFF set in the
environment for the construction of $GIT_TEST_CMP.  While this works
when called from the main Makefile, it fails if the tests are called
on their own and the user does not have $DIFF set.

Set it to 'diff' if it is unset, like the Makefile does.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I have an uneasy feeling that I must be missing something, seeing as
this went unnoticed for 10 days...

 t/test-lib.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b23a61d..4d89049 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -78,6 +78,7 @@ export EDITOR
 
 if test -z "$GIT_TEST_CMP"
 then
+	DIFF=${DIFF:-diff}
 	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
 	then
 		GIT_TEST_CMP="$DIFF -c"
-- 
1.7.1.550.g553ab5
