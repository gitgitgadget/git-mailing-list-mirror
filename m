From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v2 1/3] fix an error message in git-push so it goes to stderr
Date: Fri,  5 Feb 2010 15:49:39 -0500
Message-ID: <c48cda45fbbc257debb737818137a5bd01a8bc5c.1265402797.git.larry@elder-gods.org>
References: <cover.1265402797.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 21:49:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdV7e-0004h4-89
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 21:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657Ab0BEUtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 15:49:45 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:54176 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab0BEUtn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 15:49:43 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id D413D822182; Fri,  5 Feb 2010 15:49:42 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <cover.1265402797.git.larry@elder-gods.org>
In-Reply-To: <cover.1265402797.git.larry@elder-gods.org>
References: <7v1vgz5ta7.fsf@alter.siamese.dyndns.org> <cover.1265402797.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139081>

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
