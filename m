From: Xidorn Quan <quanxunzhen@gmail.com>
Subject: [PATCH v2] credential-osxkeychain: support more protocols
Date: Mon, 27 May 2013 22:35:59 +0800
Message-ID: <1369665359-48242-1-git-send-email-quanxunzhen@gmail.com>
References: <1369641431-44504-1-git-send-email-quanxunzhen@gmail.com>
Cc: Xidorn Quan <quanxunzhen@gmail.com>,
	John Szakmeister <john@szakmeister.net>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 27 16:37:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgyXq-0007nD-6F
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 16:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932826Ab3E0Og6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 10:36:58 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:55529 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932587Ab3E0Og4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 10:36:56 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so6949105pad.36
        for <git@vger.kernel.org>; Mon, 27 May 2013 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yDxtLCTTYWHBfVP48w5kDbQodSe0DF2+3EwoAlbU/1M=;
        b=yTs3DQNm0srBVjZocntmN6D7Ckv7UhMY9ATdeE+53k0B/jY6nbHvwQeZxXc7O/XWnm
         vBJkn33nJwOWsfoY+2IaJ8+U2QlKzDIey2z1nd7rShJz+LLayPlgs2/WmZBXGwWJIbk6
         JImLuaVOC1polcTzN+ryNIrF8Syhfxr7X3Kx8K1pQYb0Oc7J0hbJDoP5tTBOw+RjTXXv
         +hQpHnNQ0dWY0tb/AR4mQGpzazMgd5J4W/cuM3Pkq3bsNHyRCdHoT0vH99SRU7zDlrMQ
         tk0PojJTC3i6rpgHaHPSlv4hbkPA4Q2V+R5vyayJ8PFG8OKtcAOagK+CnR5ctLRYm0HR
         vC4Q==
X-Received: by 10.68.178.66 with SMTP id cw2mr22006550pbc.47.1369665415515;
        Mon, 27 May 2013 07:36:55 -0700 (PDT)
Received: from localhost.localdomain ([221.239.196.216])
        by mx.google.com with ESMTPSA id ri8sm28851810pbc.3.2013.05.27.07.36.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 27 May 2013 07:36:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1369641431-44504-1-git-send-email-quanxunzhen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225594>

Add protocol ftp and smtp for credential-osxkeychain.

Acked-by: John Szakmeister <john@szakmeister.net>

Signed-off-by: Xidorn Quan <quanxunzhen@gmail.com>
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 3940202..648fadd 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -127,10 +127,14 @@ static void read_credential(void)
 		*v++ = '\0';
 
 		if (!strcmp(buf, "protocol")) {
-			if (!strcmp(v, "https"))
+			if (!strcmp(v, "ftp"))
+				protocol = kSecProtocolTypeFTP;
+			else if (!strcmp(v, "https"))
 				protocol = kSecProtocolTypeHTTPS;
 			else if (!strcmp(v, "http"))
 				protocol = kSecProtocolTypeHTTP;
+			else if (!strcmp(v, "smtp"))
+				protocol = kSecProtocolTypeSMTP;
 			else /* we don't yet handle other protocols */
 				exit(0);
 		}
-- 
1.8.3
