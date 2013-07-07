From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 1/3] merge-recursive: remove dead conditional in update_stages()
Date: Sun, 7 Jul 2013 20:02:38 +0200
Message-ID: <ed085382b2966c91b59234537564e881ea9e6e4d.1373219466.git.trast@inf.ethz.ch>
References: <cover.1373219466.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 07 20:03:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvtIc-0000Tt-WE
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 20:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab3GGSCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 14:02:50 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:25399 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab3GGSCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 14:02:49 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 7 Jul
 2013 20:02:42 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 7 Jul
 2013 20:02:46 +0200
X-Mailer: git-send-email 1.8.3.2.908.gbd0dbd0
In-Reply-To: <cover.1373219466.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229788>

650467c (merge-recursive: Consolidate different update_stages
functions, 2011-08-11) changed the former argument 'clear' to always
be true.  Remove the useless conditional.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 merge-recursive.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ea9dbd3..0b9cafb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -544,11 +544,9 @@ static int update_stages(const char *path, const struct diff_filespec *o,
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
1.8.3.2.908.gbd0dbd0
