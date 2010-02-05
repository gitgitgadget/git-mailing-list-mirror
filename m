From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH] fix an error message in git-push so it goes to stderr
Date: Thu, 4 Feb 2010 19:41:40 -0500
Message-ID: <20100205004140.GA2841@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 01:41:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdCGh-00006z-Ci
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 01:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757685Ab0BEAlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 19:41:42 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:54141 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757677Ab0BEAll (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 19:41:41 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 9961E82205F; Thu,  4 Feb 2010 19:41:40 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139014>

Having it go to standard output interferes with git-push --porcelain.
---
 builtin-push.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 5633f0a..0a27072 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -124,9 +124,9 @@ static int push_with_options(struct transport *transport, int flags)
 		return 0;
 
 	if (nonfastforward && advice_push_nonfastforward) {
-		printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
-		       "Merge the remote changes before pushing again.  See the 'Note about\n"
-		       "fast-forwards' section of 'git push --help' for details.\n");
+		fprintf(stderr, "To prevent you from losing history, non-fast-forward updates were rejected\n"
+				"Merge the remote changes before pushing again.  See the 'Note about\n"
+				"fast-forwards' section of 'git push --help' for details.\n");
 	}
 
 	return 1;
-- 
1.7.0.rc1.33.g07cf0f.dirty
