From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 1/3] fix an error message in git-push so it goes to stderr
Date: Fri,  5 Feb 2010 14:34:20 -0500
Message-ID: <1265398462-17316-1-git-send-email-larry@elder-gods.org>
References: <20100205150638.GB14116@coredump.intra.peff.net>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 20:34:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdTwo-00041h-EC
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 20:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498Ab0BETe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 14:34:27 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:50487 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab0BETeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 14:34:25 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id DD4B982217D; Fri,  5 Feb 2010 14:34:23 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <20100205150638.GB14116@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139068>

Having it go to standard output interferes with git-push --porcelain.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
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
