From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 07/15] contrib/git-credential-gnome-keyring.c: ensure buffer is non-empty before accessing
Date: Sun, 22 Sep 2013 22:08:03 -0700
Message-ID: <1379912891-12277-8-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyP6-0002D3-OG
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345Ab3IWFJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:42 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:39848 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab3IWFJL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:11 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so2722973pbb.6
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jz6f26h8d07oPrRmFddwutpZgHCsYTHJMXjsRC/xbCk=;
        b=TC20ZRXH73EVnPSQ8Y2klVHV8s5NpEQjQZcUNYbW+isBvdEapEWDSB+uOHHjqW/nU8
         caIfwIDfWH7IwMrHzMuoPhFU/4vv/jznKjCmf8UNs6r0R1+qE71Ocgq6LYlZeglqek35
         yp4Y5vim02QHoj2Mt9goj+8ZV6djzon/ryqkxBV2YDMbFc6sBckeM0vFnoxuCcdDecXy
         5+MlVIOk8Zf6tsDXFR5IIlYytyljsXPcIJijWTCmcPzKUkgzQqxp64dYf7mmVa9sfZAL
         b0MOPvt+TEwxJwp7W25XiS/pLtfmAoR9mKEn9N2PEEc3jwFe6RoE5nPfjzIhY0Pefy1J
         csYw==
X-Received: by 10.66.66.161 with SMTP id g1mr11348pat.175.1379912950885;
        Sun, 22 Sep 2013 22:09:10 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235199>

Ensure buffer length is non-zero before attempting to access the last
element.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 contrib/credential/gnome-keyring/git-credential-gnome-keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 1081224..8ae2eab 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -315,7 +315,7 @@ static int credential_read(struct credential *c)
 	{
 		line_len = strlen(buf);
 
-		if(buf[line_len-1]=='\n')
+		if(line_len && buf[line_len-1] == '\n')
 			buf[--line_len]='\0';
 
 		if(!line_len)
-- 
1.8.4.489.g545bc72
