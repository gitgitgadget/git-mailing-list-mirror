From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] describe: fix off-by-one error in --abbrev=40 handling
Date: Fri, 25 Aug 2006 02:48:04 +0200
Message-ID: <20060825004804.GA4069@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 25 02:48:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGPs6-00015x-So
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 02:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbWHYAsO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 20:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWHYAsO
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 20:48:14 -0400
Received: from [130.225.96.91] ([130.225.96.91]:60320 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932243AbWHYAsO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 20:48:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 4EDA177007C
	for <git@vger.kernel.org>; Fri, 25 Aug 2006 02:48:06 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25670-03 for <git@vger.kernel.org>; Fri, 25 Aug 2006 02:48:05 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 2D825770076
	for <git@vger.kernel.org>; Fri, 25 Aug 2006 02:48:05 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 124066DF88D
	for <git@vger.kernel.org>; Fri, 25 Aug 2006 02:46:47 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 152D2629FB; Fri, 25 Aug 2006 02:48:05 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25983>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

Possible stupid fix, but shouldn't one be able to say --abbrev=40 if only
once in a life time?

 describe.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/describe.c b/describe.c
index 2b9301f..5dd8b2e 100644
--- a/describe.c
+++ b/describe.c
@@ -42,7 +42,7 @@ static void add_to_known_names(const cha
 	struct commit_name *name = xmalloc(sizeof(struct commit_name) + len);
 
 	name->commit = commit;
-	name->prio = prio; 
+	name->prio = prio;
 	memcpy(name->path, path, len);
 	idx = names;
 	if (idx >= allocs) {
@@ -154,7 +154,7 @@ int main(int argc, char **argv)
 			tags = 1;
 		else if (!strncmp(arg, "--abbrev=", 9)) {
 			abbrev = strtoul(arg + 9, NULL, 10);
-			if (abbrev < MINIMUM_ABBREV || 40 <= abbrev)
+			if (abbrev < MINIMUM_ABBREV || 40 < abbrev)
 				abbrev = DEFAULT_ABBREV;
 		}
 		else

-- 
Jonas Fonseca
