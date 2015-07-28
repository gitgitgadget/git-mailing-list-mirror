From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/4] get_remote_group(): rename local variable "space" to "wordlen"
Date: Tue, 28 Jul 2015 23:08:19 +0200
Message-ID: <3cb456d351a8af61a3ba894ba47aa5d7f32ed246.1438117334.git.mhagger@alum.mit.edu>
References: <cover.1438117334.git.mhagger@alum.mit.edu>
Cc: =?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 23:08:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKC71-0002ui-So
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 23:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbbG1VIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 17:08:32 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57219 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752603AbbG1VIb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2015 17:08:31 -0400
X-AuditID: 1207440d-f79136d00000402c-1e-55b7ef4ef0e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D7.51.16428.E4FE7B55; Tue, 28 Jul 2015 17:08:30 -0400 (EDT)
Received: from michael.fritz.box (p4FC97CAD.dip0.t-ipconnect.de [79.201.124.173])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6SL8PUC021490
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 28 Jul 2015 17:08:29 -0400
X-Mailer: git-send-email 2.4.6
In-Reply-To: <cover.1438117334.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqOv3fnuowdJmKYv5xxYzW3Rd6Way
	aOi9wmxxe8V8ZgcWj7/vPzB57Jx1l93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M5q/XmQv
	WMde8fb2TLYGxpusXYycHBICJhJ9r/oZIWwxiQv31rN1MXJxCAlcZpS4P3shM0hCSOAkk8Tc
	BhkQm01AV2JRTzMTiC0ioCYxse0QC0gDs0Abo8SFNbvAGoQFgiWObH3FBmKzCKhKvJy5lwXE
	5hWIkti5dScLxDY5iWtnt4JdwSlgIXH5ewtQnANombnEt71eExh5FzAyrGKUS8wpzdXNTczM
	KU5N1i1OTszLSy3SNdLLzSzRS00p3cQICR/eHYz/18kcYhTgYFTi4X2xYVuoEGtiWXFl7iFG
	SQ4mJVHeGfe2hwrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4W14CJTjTUmsrEotyodJSXOwKInz
	qi1R9xMSSE8sSc1OTS1ILYLJynBwKEnw8r4DahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0kt
	SiwtyYgHRUZ8MTA2QFI8QHu1Qdp5iwsSc4GiEK2nGHU5Fvy4vZZJiCUvPy9VSpz33VugIgGQ
	oozSPLgVsGTxilEc6GNh3jSQUTzARAM36RXQEiagJZ49W0CWlCQipKQaGBMrJdj82K3fz5u/
	ZfHBmzzT3CosGvpmCLtLr/2zbM9Wlmm3bDzjT2XOXepybckFy7/fP8yfcNH+mOrXWV51Kluj
	H6Uv3vD5/ipDtv6rEfm1f7dt/c4txTDv0l3W3l3Oto5TpyvbH9C5aiTZd1dguoPt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274845>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 98f9048..d0d267b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -978,13 +978,13 @@ static int get_remote_group(const char *key, const char *value, void *priv)
 	if (starts_with(key, "remotes.") &&
 			!strcmp(key + 8, g->name)) {
 		/* split list by white space */
-		int space = strcspn(value, " \t\n");
+		size_t wordlen = strcspn(value, " \t\n");
 		while (*value) {
-			if (space >= 1)
+			if (wordlen >= 1)
 				string_list_append(g->list,
-						   xstrndup(value, space));
-			value += space + (value[space] != '\0');
-			space = strcspn(value, " \t\n");
+						   xstrndup(value, wordlen));
+			value += wordlen + (value[wordlen] != '\0');
+			wordlen = strcspn(value, " \t\n");
 		}
 	}
 
-- 
2.4.6
