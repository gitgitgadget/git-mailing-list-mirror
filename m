From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] notes: allow --dry-run for -n and --verbose for -v
Date: Fri, 06 Aug 2010 22:28:09 +0200
Message-ID: <4C5C7059.10203@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 06 22:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhTWi-0000bA-7K
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 22:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762019Ab0HFU2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 16:28:21 -0400
Received: from india601.server4you.de ([85.25.151.105]:52180 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab0HFU2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 16:28:19 -0400
Received: from [10.0.1.100] (p57B7F69B.dip.t-dialin.net [87.183.246.155])
	by india601.server4you.de (Postfix) with ESMTPSA id E67072F8126;
	Fri,  6 Aug 2010 22:28:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152809>

For consistency with other git commands, let the prune subcommand of
git notes accept the long options --dry-run and --verbose for the
respective short ones -n and -v.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-notes.txt |    2 ++
 builtin/notes.c             |    5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 5540af5..2981d8c 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -129,10 +129,12 @@ OPTIONS
 	is taken to be in `refs/notes/` if it is not qualified.
 
 -n::
+--dry-run::
 	Do not remove anything; just report the object names whose notes
 	would be removed.
 
 -v::
+--verbose::
 	Report all object names whose notes are removed.
 
 
diff --git a/builtin/notes.c b/builtin/notes.c
index 190005f..fbc347c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -798,8 +798,9 @@ static int prune(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	int show_only = 0, verbose = 0;
 	struct option options[] = {
-		OPT_BOOLEAN('n', NULL, &show_only, "do not remove, show only"),
-		OPT_BOOLEAN('v', NULL, &verbose, "report pruned notes"),
+		OPT_BOOLEAN('n', "dry-run", &show_only,
+			    "do not remove, show only"),
+		OPT_BOOLEAN('v', "verbose", &verbose, "report pruned notes"),
 		OPT_END()
 	};
 
-- 
1.7.2
