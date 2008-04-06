From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] test suite: remove useless TERM cruft in "t7005-editor.sh"
Date: Sun, 6 Apr 2008 19:08:50 +0200
Message-ID: <20080406190850.e7a13c3c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 06 19:04:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiYI8-0000Z4-8l
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 19:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbYDFRDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 13:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754190AbYDFRDe
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 13:03:34 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:57032 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539AbYDFRDd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 13:03:33 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A1ECB1AB331;
	Sun,  6 Apr 2008 19:03:32 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 47F801AB2FA;
	Sun,  6 Apr 2008 19:03:32 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78900>

In commit 15387e32ff5116b82d3fe53df55b8c87eec83e01 I added some cruft
to reset TERM to its previous value before the "test_done" at the end
of "t7005-editor.sh" because otherwise "test_done" would have printed
the test result with a bad TERM env variable (this resulted in output
with no color on konsole).

But since commit c2116a1783a3d555d41892ae7db0dd0934d4ddf1 colored
output is printed in a subshell with TERM reset to its original value
so the cruft added in my patch above is now useless.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7005-editor.sh |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 6a74b3a..2d919d6 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -4,8 +4,6 @@ test_description='GIT_EDITOR, core.editor, and stuff'
 
 . ./test-lib.sh
 
-OLD_TERM="$TERM"
-
 for i in GIT_EDITOR core_editor EDITOR VISUAL vi
 do
 	cat >e-$i.sh <<-EOF
@@ -116,6 +114,4 @@ test_expect_success 'core.editor with a space' '
 
 '
 
-TERM="$OLD_TERM"
-
 test_done
-- 
1.5.5.rc2.20.g03f57.dirty
