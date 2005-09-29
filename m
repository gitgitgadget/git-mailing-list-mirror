From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Old curl does not know about CURLOPT_SSLKEY
Date: Thu, 29 Sep 2005 18:19:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509291819090.7007@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 29 18:22:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL18V-0003H1-FW
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 18:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVI2QTw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 12:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVI2QTw
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 12:19:52 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3773 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932229AbVI2QTv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 12:19:51 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id C52CE13C2D2
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 18:19:50 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id A829CB3D4D
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 18:19:50 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 91ADFB3D3E
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 18:19:50 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 535A313C2D2
	for <git@vger.kernel.org>; Thu, 29 Sep 2005 18:19:50 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9492>


... so try to set it only in later versions.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 http-fetch.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

d1d3438564c8407b916aa374fbac89a5aa902eb1
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -529,9 +529,11 @@ int main(int argc, char **argv)
 	if ((ssl_cert = getenv("GIT_SSL_CERT")) != NULL) {
 		curl_easy_setopt(curl, CURLOPT_SSLCERT, ssl_cert);
 	}
+#if LIBCURL_VERSION_NUM >= 0x070902
 	if ((ssl_key = getenv("GIT_SSL_KEY")) != NULL) {
 		curl_easy_setopt(curl, CURLOPT_SSLKEY, ssl_key);
 	}
+#endif
 #if LIBCURL_VERSION_NUM >= 0x070908
 	if ((ssl_capath = getenv("GIT_SSL_CAPATH")) != NULL) {
 		curl_easy_setopt(curl, CURLOPT_CAPATH, ssl_capath);
