From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH] GIT: Fix compilation error in connect.c
Date: Tue, 22 Nov 2005 12:18:23 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20051122.121823.46966877.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Tue Nov 22 05:19:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EePbx-0006o7-63
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 05:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVKVESA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 23:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVKVESA
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 23:18:00 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:36622 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932154AbVKVER7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 23:17:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 9E95B33CC2; Tue, 22 Nov 2005 12:18:24 +0900 (JST)
To: junkio@cox.net
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12520>

Fix compilation error for gcc-2.95.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

diff --git a/connect.c b/connect.c
index a4d6d35..7a417e5 100644
--- a/connect.c
+++ b/connect.c
@@ -455,6 +455,10 @@ static int rhost_len;
 static int git_proxy_command_options(const char *var, const char *value)
 {
 	if (!strcmp(var, "core.gitproxy")) {
+		const char *for_pos;
+		int matchlen = -1;
+		int hostlen;
+
 		if (git_proxy_command)
 			return 0;
 		/* [core]
@@ -463,10 +467,7 @@ static int git_proxy_command_options(con
 		 * gitproxy = netcatter-2 for sample.xz
 		 * gitproxy = netcatter-default
 		 */
-		const char *for_pos = strstr(value, " for ");
-		int matchlen = -1;
-		int hostlen;
-
+		for_pos = strstr(value, " for ");
 		if (!for_pos)
 			/* matches everybody */
 			matchlen = strlen(value);

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
