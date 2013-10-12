From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/20] alias: trivial style fix
Date: Sat, 12 Oct 2013 02:07:13 -0500
Message-ID: <1381561636-20717-18-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOp-0005yB-2C
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab3JLHOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:14:03 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:37666 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab3JLHOB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:14:01 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so3113065oag.41
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HT/4WG1PTV7unMimdOw8HSJBha6QFUMErROL4Z2T1go=;
        b=h4BFvP7GiFP9QLiqVLVxIIBEjOSKdcM8DCl+fo9DQU9XjQUdaH7W59w0H+dyI6q/cP
         HRHZCWNWLwuNWQALydeC0BlN1W3q2C/iETeN3eWpSGMDUWBfufXY5WpcUcXvc0nq0vVN
         ncGOCOrijSHtkGHOu6wAI2B7x3Yntsi8OCgSA19MnqvMgZn/6yRVMpHdidPsNAPA01qu
         7WRuY+g1I6VoCeHSMP6Z4TQG1T8ukTHrCbfXP+x9rAC+0LLA3CvNKAeA38K85KNB0iP6
         gm9tfMyBh8iWvshIu3jLrRFM/W2AozbIeCC/8lSasEfuwYK8QsJEQcp7nrPt/L/YmSwU
         U4CA==
X-Received: by 10.182.121.137 with SMTP id lk9mr17893424obb.32.1381562040950;
        Sat, 12 Oct 2013 00:14:00 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm28656035obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:14:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236025>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 alias.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/alias.c b/alias.c
index eb9f08b..9938f03 100644
--- a/alias.c
+++ b/alias.c
@@ -5,7 +5,7 @@ static char *alias_val;
 
 static int alias_lookup_cb(const char *k, const char *v, void *cb)
 {
-	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
+	if (!prefixcmp(k, "alias.") && !strcmp(k + 6, alias_key)) {
 		if (!v)
 			return config_error_nonbool(k);
 		alias_val = xstrdup(v);
@@ -34,7 +34,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 	int src, dst, count = 0, size = 16;
 	char quoted = 0;
 
-	*argv = xmalloc(sizeof(char *) * size);
+	*argv = xmalloc(sizeof(**argv) * size);
 
 	/* split alias_string */
 	(*argv)[count++] = cmdline;
@@ -45,7 +45,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 			while (cmdline[++src]
 					&& isspace(cmdline[src]))
 				; /* skip */
-			ALLOC_GROW(*argv, count+1, size);
+			ALLOC_GROW(*argv, count + 1, size);
 			(*argv)[count++] = cmdline + dst;
 		} else if (!quoted && (c == '\'' || c == '"')) {
 			quoted = c;
@@ -76,12 +76,13 @@ int split_cmdline(char *cmdline, const char ***argv)
 		return -SPLIT_CMDLINE_UNCLOSED_QUOTE;
 	}
 
-	ALLOC_GROW(*argv, count+1, size);
+	ALLOC_GROW(*argv, count + 1, size);
 	(*argv)[count] = NULL;
 
 	return count;
 }
 
-const char *split_cmdline_strerror(int split_cmdline_errno) {
-	return split_cmdline_errors[-split_cmdline_errno-1];
+const char *split_cmdline_strerror(int split_cmdline_errno)
+{
+	return split_cmdline_errors[-split_cmdline_errno - 1];
 }
-- 
1.8.4-fc
