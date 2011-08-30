From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Symlink mergetools scriptlets into valgrind wrappers
Date: Tue, 30 Aug 2011 02:47:36 +0200
Message-ID: <e11fd4c98faf1fc4f970bd1570fe931e078f436e.1314665234.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 02:47:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyCUT-0002Sj-Ms
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 02:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab1H3Arj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 20:47:39 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:57904 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab1H3Arj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 20:47:39 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 30 Aug
 2011 02:47:37 +0200
Received: from localhost.localdomain (188.155.176.28) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 30 Aug
 2011 02:47:37 +0200
X-Mailer: git-send-email 1.7.7.rc0.370.gdcae57
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180380>

Since bc7a96a (mergetool--lib: Refactor tools into separate files,
2011-08-18) the mergetools and difftools related tests fail under
--valgrind because the mergetools/* scriptlets are not in the exec
path.

For now, symlink the mergetools subdir into the t/valgrind/bin
directory as a whole, since it does not contain anything of interest
to the valgrind wrappers.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/test-lib.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d7dfc8b..bdd9513 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -950,6 +950,8 @@ then
 	do
 		make_valgrind_symlink $file
 	done
+	# special-case the mergetools loadables
+	make_symlink "$GIT_BUILD_DIR"/mergetools "$GIT_VALGRIND/bin/mergetools"
 	OLDIFS=$IFS
 	IFS=:
 	for path in $PATH
-- 
1.7.7.rc0.370.gdcae57
