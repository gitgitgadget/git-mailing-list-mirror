From: George Papanikolaou <g3orge.app@gmail.com>
Subject: [PATCH] builtin/apply.c: use iswspace() to detect line-ending-like chars
Date: Thu, 20 Mar 2014 21:39:44 +0200
Message-ID: <1395344384-7975-1-git-send-email-g3orge.app@gmail.com>
Cc: git@vger.kernel.org, George Papanikolaou <g3orge.app@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 20 20:37:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQimZ-0000WO-HR
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 20:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759830AbaCTThY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 15:37:24 -0400
Received: from poseidon.ceid.upatras.gr ([150.140.141.169]:59414 "EHLO
	poseidon.ceid.upatras.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759824AbaCTThV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 15:37:21 -0400
Received: from mail.ceid.upatras.gr (mta.ceid.upatras.gr [10.1.0.174])
	by poseidon.ceid.upatras.gr (Postfix) with ESMTP id 2388280315;
	Thu, 20 Mar 2014 21:37:16 +0200 (EET)
Received: from localhost (ppp089210130219.access.hol.gr [89.210.130.219])
	(Authenticated sender: papanikge)
	by mail.ceid.upatras.gr (Postfix) with ESMTPSA id 7C81F20040;
	Thu, 20 Mar 2014 21:37:14 +0200 (EET)
X-Mailer: git-send-email 1.9.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,UNPARSEABLE_RELAY autolearn=no version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mtax.ceid.upatras.gr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244576>

Removing the bloat of checking for both '\r' and '\n' with the prettier
iswspace() function which checks for other characters as well. (read: \f \t \v)
---

This is one more try to clean up this fuzzy_matchlines() function as part of a
microproject for GSOC. The rest more clarrified microprojects were taken.
I'm obviously planning on applying.

Thanks

Signed-of-by: George 'papanikge' Papanikolaou <g3orge.app@gmail.com>

 builtin/apply.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b0d0986..912a53a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -295,9 +295,9 @@ static int fuzzy_matchlines(const char *s1, size_t n1,
 	int result = 0;
 
 	/* ignore line endings */
-	while ((*last1 == '\r') || (*last1 == '\n'))
+	while (iswspace(*last1))
 		last1--;
-	while ((*last2 == '\r') || (*last2 == '\n'))
+	while (iswspace(*last2))
 		last2--;
 
 	/* skip leading whitespace */
-- 
1.9.0
