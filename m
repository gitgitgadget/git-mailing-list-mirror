From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] rev-list: accept --format without argument
Date: Wed, 28 Jul 2010 11:42:00 +0200
Message-ID: <1280310120-16852-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 28 11:49:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe3G6-0001Qy-Nw
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 11:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab0G1JtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 05:49:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58716 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753896Ab0G1JtA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 05:49:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6S9eHg5010079
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 11:40:17 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe39G-0000MY-NA; Wed, 28 Jul 2010 11:42:02 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe39G-0004OM-Lo; Wed, 28 Jul 2010 11:42:02 +0200
X-Mailer: git-send-email 1.7.2.25.g9ebe3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Jul 2010 11:40:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6S9eHg5010079
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280914819.57108@JSMpSETbYOxeh8eb+0WmHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152066>

The documentation says the syntax is --format[='<format>'], match it in
the implementation.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Not that it's terribly usefull, but better be consistant ...
 revision.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 33fa0b5..4b64757 100644
--- a/revision.c
+++ b/revision.c
@@ -1300,10 +1300,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->combine_merges = 1;
 	} else if (!strcmp(arg, "-v")) {
 		revs->verbose_header = 1;
-	} else if (!strcmp(arg, "--pretty")) {
+	} else if (!strcmp(arg, "--pretty") || !strcmp(arg, "--format")) {
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
-		get_commit_format(arg+8, revs);
+		get_commit_format("", revs);
 	} else if (!prefixcmp(arg, "--pretty=") || !prefixcmp(arg, "--format=")) {
 		/*
 		 * Detached form ("--pretty X" as opposed to "--pretty=X")
-- 
1.7.2.25.g9ebe3
