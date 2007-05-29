From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] diff-delta: use realloc instead of xrealloc
Date: Tue, 29 May 2007 21:08:35 +0200
Message-ID: <1180465715346-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 29 21:08:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht73o-0008Vp-T7
	for gcvg-git@gmane.org; Tue, 29 May 2007 21:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbXE2TIk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 15:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbXE2TIk
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 15:08:40 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:57450 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbXE2TIj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 15:08:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D49957CE6998;
	Tue, 29 May 2007 21:08:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0B+mTEvLvu-X; Tue, 29 May 2007 21:08:35 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 764887094194; Tue, 29 May 2007 21:08:35 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48706>

Commit 83572c1a914d3f7a8dd66d954c11bbc665b7b923 changed many
realloc to xrealloc. This change was made in diff-delta.c too,
although the code can handle an out of memory failure.

This patch reverts this change in diff-delta.c.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 diff-delta.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 17757d2..faf96e4 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -388,7 +388,7 @@ create_delta(const struct delta_index *index,
 				outsize = max_size + MAX_OP_SIZE + 1;
 			if (max_size && outpos > max_size)
 				break;
-			out = xrealloc(out, outsize);
+			out = realloc(out, outsize);
 			if (!out) {
 				free(tmp);
 				return NULL;
-- 
1.5.2.846.g9a144
