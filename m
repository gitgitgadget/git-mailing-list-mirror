From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 1/3] merge-recursive: remove dead conditional in update_stages()
Date: Sat, 26 Oct 2013 16:43:16 +0200
Message-ID: <262a408fc2f55df92eb2754eb1475c1af6fec19e.1382798450.git.tr@thomasrast.ch>
References: <87ob6cm6y1.fsf@linux-k42r.v.cablecom.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 26 16:43:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va55k-00057C-PP
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 16:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131Ab3JZOns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 10:43:48 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:50886 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785Ab3JZOnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 10:43:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id CE5E04D659B;
	Sat, 26 Oct 2013 16:43:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id J77gdBGyVmWd; Sat, 26 Oct 2013 16:43:36 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 1D62E4D6414;
	Sat, 26 Oct 2013 16:43:36 +0200 (CEST)
X-Mailer: git-send-email 1.8.4.1.841.gb1dcd95
In-Reply-To: <87ob6cm6y1.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236755>

From: Thomas Rast <trast@inf.ethz.ch>

650467c (merge-recursive: Consolidate different update_stages
functions, 2011-08-11) changed the former argument 'clear' to always
be true.  Remove the useless conditional.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

Unchanged.

 merge-recursive.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index dbb7104..bdf69cb 100644
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
1.8.4.1.841.gb1dcd95
