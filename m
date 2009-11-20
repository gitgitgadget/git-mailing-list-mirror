From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] merge-recursive: point the user to commit when file would be overwritten.
Date: Fri, 20 Nov 2009 16:59:26 +0100
Message-ID: <1258732767-12741-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 17:03:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBVxO-0000zs-WA
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 17:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbZKTQDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 11:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbZKTQDF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 11:03:05 -0500
Received: from imag.imag.fr ([129.88.30.1]:41322 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887AbZKTQDC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 11:03:02 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nAKFxZt1006338
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Nov 2009 16:59:35 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NBVtW-0001Mf-Nu; Fri, 20 Nov 2009 16:59:34 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NBVtW-0003KO-Mp; Fri, 20 Nov 2009 16:59:34 +0100
X-Mailer: git-send-email 1.6.5.3.435.g5f2e3.dirty
In-Reply-To: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 20 Nov 2009 16:59:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133356>

The commit-before-pull is well accepted in the DVCS community, but is
confusing some new users. This should get them back in the right way when
the problem occurs.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 merge-recursive.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f55b7eb..d5e0819 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -172,9 +172,11 @@ static int git_merge_trees(int index_only,
 	struct unpack_trees_options opts;
 	static const struct unpack_trees_error_msgs msgs = {
 		/* would_overwrite */
-		"Your local changes to '%s' would be overwritten by merge.  Aborting.",
+		"Your local changes to '%s' would be overwritten by merge.  Aborting:\n"
+		"Please, commit your changes or stash them before you can merge.",
 		/* not_uptodate_file */
-		"Your local changes to '%s' would be overwritten by merge.  Aborting.",
+		"Your local changes to '%s' would be overwritten by merge.  Aborting:\n"
+		"Please, commit your changes or stash them before you can merge.",
 		/* not_uptodate_dir */
 		"Updating '%s' would lose untracked files in it.  Aborting.",
 		/* would_lose_untracked */
-- 
1.6.5.3.435.g5f2e3.dirty
