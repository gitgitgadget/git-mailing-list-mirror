From: Martin Storsjo <martin@martin.st>
Subject: [PATCH] Allow any HTTP authentication scheme, not only basic
Date: Tue, 31 Mar 2009 21:54:25 +0300
Message-ID: <1238525665-10776-1-git-send-email-martin@martin.st>
References: <1238520686-546-1-git-send-email-martin@martin.st>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 20:56:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loj87-0006G7-GD
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 20:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757374AbZCaSya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 14:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755752AbZCaSya
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 14:54:30 -0400
Received: from smtp2.abo.fi ([130.232.213.77]:55921 "EHLO smtp2.abo.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289AbZCaSy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 14:54:29 -0400
Received: from localhost.localdomain (albin.abo.fi [130.232.81.192])
	by smtp2.abo.fi (8.14.3/8.12.9) with ESMTP id n2VIsPAd017684
	for <git@vger.kernel.org>; Tue, 31 Mar 2009 21:54:25 +0300
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <1238520686-546-1-git-send-email-martin@martin.st>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (smtp2.abo.fi [130.232.213.77]); Tue, 31 Mar 2009 21:54:26 +0300 (EEST)
X-Virus-Scanned: by foxy.abo.fi (foxy.abo.fi: Tue Mar 31 21:54:26 2009)
X-Scanned-By: MIMEDefang 2.64 on 130.232.213.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115298>

Signed-off-by: Martin Storsjo <martin@martin.st>
---
Updated patch, enable only on libcurl versions new enough

 http.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 2fc55d6..eae74aa 100644
--- a/http.c
+++ b/http.c
@@ -165,6 +165,9 @@ static CURL *get_curl_handle(void)
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
+#if LIBCURL_VERSION_NUM >= 0x070a06
+	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
+#endif
 
 	init_curl_http_auth(result);
 
-- 
1.6.0.2
