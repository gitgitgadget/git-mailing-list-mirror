From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] pretty: use starts_with() to check for a prefix
Date: Sat, 21 Feb 2015 20:53:09 +0100
Message-ID: <54E8E225.4070406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 21 20:53:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPG7N-000396-R0
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 20:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbbBUTxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 14:53:34 -0500
Received: from mout.web.de ([212.227.17.11]:61937 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbbBUTxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 14:53:33 -0500
Received: from [192.168.178.27] ([79.253.189.194]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M8Qpi-1XdDnX29Vy-00w09N; Sat, 21 Feb 2015 20:53:29
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Provags-ID: V03:K0:h1ngKinfahhQlEqkXRjTj83VvDmByEGpK9QQ8UInz5sqR3GTeQh
 jBpKBXTb/3XUGWWIXD50Awj4bERbiI8ynN202aDEKsWKAI3Stu2GrswUr4fZ+uw5m8EnABw
 suaMWIIAPl6iWo1FUMYnGfh+ke11iawXzBYevaI8OurFXAPKxchICLio8DvtxkyOmkwMpf9
 F97hK1P10o87hT5V0GkUQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264226>

Simplify the code and avoid duplication by using starts_with() instead
of strlen() and strncmp() to check if a line starts with "encoding ".

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 pretty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 9d34d02..7b49304 100644
--- a/pretty.c
+++ b/pretty.c
@@ -567,7 +567,7 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 	char *cp = buf;
 
 	/* guess if there is an encoding header before a \n\n */
-	while (strncmp(cp, "encoding ", strlen("encoding "))) {
+	while (!starts_with(cp, "encoding ")) {
 		cp = strchr(cp, '\n');
 		if (!cp || *++cp == '\n')
 			return buf;
-- 
2.3.0
