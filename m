From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: use "clear_commit_marks" after checking ancestors
Date: Thu, 28 May 2009 23:24:43 +0200
Message-ID: <20090528212444.4034.68662.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 23:30:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9nB1-0004td-Oz
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 23:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758711AbZE1VaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 17:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758267AbZE1VaE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 17:30:04 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:47465 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758079AbZE1VaC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 17:30:02 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 6CFE24C80FF;
	Thu, 28 May 2009 23:29:57 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 75C654C80D9;
	Thu, 28 May 2009 23:29:55 +0200 (CEST)
X-git-sha1: 00ac3e0514e45403b31e57cba264cf349ff27bf9 
X-Mailer: git-mail-commits v0.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120236>

instead of "unparse_commit", as it is enough to just clear flags.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

	As the patch series where "unparse_commit" is added and
	used is already in "next". Here is a patch to use
	"clear_commit_marks" instead. The patch that adds
	"unparse_commit" can be reverted from "next" after this
	one.

diff --git a/bisect.c b/bisect.c
index c43c120..18f9fa4 100644
--- a/bisect.c
+++ b/bisect.c
@@ -771,7 +771,7 @@ static int check_ancestors(const char *prefix)
 	/* Clean up objects used, as they will be reused. */
 	for (i = 0; i < pending_copy.nr; i++) {
 		struct object *o = pending_copy.objects[i].item;
-		unparse_commit((struct commit *)o);
+		clear_commit_marks((struct commit *)o, ALL_REV_FLAGS);
 	}
 
 	return res;
-- 
1.6.3.GIT
