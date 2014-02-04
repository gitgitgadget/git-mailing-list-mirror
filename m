From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 1/9] merge-recursive: remove dead conditional in update_stages()
Date: Tue,  4 Feb 2014 23:17:30 +0100
Message-ID: <37f625c87b3d0fd61988ee9e8e31f4c227093f5e.1391549294.git.tr@thomasrast.ch>
References: <cover.1391549294.git.tr@thomasrast.ch>
Cc: Thomas Rast <trast@inf.ethz.ch>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 23:19:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoKV-0002Bf-Ax
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbaBDWSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:18:38 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:54774 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934307AbaBDWRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:17:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id C3F394D65A6;
	Tue,  4 Feb 2014 23:17:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bp85iwzzschH; Tue,  4 Feb 2014 23:17:40 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 39D744D658C;
	Tue,  4 Feb 2014 23:17:40 +0100 (CET)
X-Mailer: git-send-email 1.9.rc2.232.gdd31389
In-Reply-To: <cover.1391549294.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241575>

From: Thomas Rast <trast@inf.ethz.ch>

650467c (merge-recursive: Consolidate different update_stages
functions, 2011-08-11) changed the former argument 'clear' to always
be true.  Remove the useless conditional.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8400a8e..c36dc79 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -545,11 +545,9 @@ static int update_stages(const char *path, const struct diff_filespec *o,
 	 * would_lose_untracked).  Instead, reverse the order of the calls
 	 * (executing update_file first and then update_stages).
 	 */
-	int clear = 1;
 	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
-	if (clear)
-		if (remove_file_from_cache(path))
-			return -1;
+	if (remove_file_from_cache(path))
+		return -1;
 	if (o)
 		if (add_cacheinfo(o->mode, o->sha1, path, 1, 0, options))
 			return -1;
-- 
1.9.rc2.232.gdd31389
