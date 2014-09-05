From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: [PATCH 1/2] i18n: ambiguous refname message is not translated
Date: Fri,  5 Sep 2014 14:57:24 -0400
Message-ID: <1409943445-12283-2-git-send-email-sandy.carter@savoirfairelinux.com>
References: <1409943445-12283-1-git-send-email-sandy.carter@savoirfairelinux.com>
Cc: sandy.carter@savoirfairelinux.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 21:02:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPymA-0001R5-Vk
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 21:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbaIETCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 15:02:14 -0400
Received: from mail.savoirfairelinux.com ([209.172.62.77]:62599 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbaIETCN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 15:02:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F2193C96012
	for <git@vger.kernel.org>; Fri,  5 Sep 2014 14:54:01 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPewXqwGSpsL; Fri,  5 Sep 2014 14:54:01 -0400 (EDT)
Received: from scarter-X220.mtl.sfl (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 90C12C9600E;
	Fri,  5 Sep 2014 14:54:01 -0400 (EDT)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409943445-12283-1-git-send-email-sandy.carter@savoirfairelinux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256514>

Allow warning message about ambuiguous refname to be exported to .pot files
when checking out a refname which is the name of a tag and of a branch for
example.

Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
---
 sha1_name.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 63ee66f..6571287 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -434,7 +434,7 @@ static int interpret_nth_prior_checkout(const char *name, int namelen, struct st
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
-	static const char *warn_msg = "refname '%.*s' is ambiguous.";
+	static const char *warn_msg = N_("refname '%.*s' is ambiguous.");
 	static const char *object_name_msg = N_(
 	"Git normally never creates a ref that ends with 40 hex characters\n"
 	"because it will be ignored when you just specify 40-hex. These refs\n"
@@ -454,7 +454,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
 			refs_found = dwim_ref(str, len, tmp_sha1, &real_ref);
 			if (refs_found > 0) {
-				warning(warn_msg, len, str);
+				warning(_(warn_msg), len, str);
 				if (advice_object_name_warning)
 					fprintf(stderr, "%s\n", _(object_name_msg));
 			}
@@ -514,7 +514,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (warn_ambiguous_refs &&
 	    (refs_found > 1 ||
 	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY)))
-		warning(warn_msg, len, str);
+		warning(_(warn_msg), len, str);
 
 	if (reflog_len) {
 		int nth, i;
-- 
2.1.0
