From: Xidorn Quan <quanxunzhen@gmail.com>
Subject: [PATCH] credential-osxkeychain: support more protocols
Date: Mon, 27 May 2013 15:57:11 +0800
Message-ID: <1369641431-44504-1-git-send-email-quanxunzhen@gmail.com>
Cc: Xidorn Quan <quanxunzhen@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 27 09:57:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgsJR-0001ZW-Dk
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 09:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768Ab3E0H5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 03:57:42 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:37675 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab3E0H5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 03:57:41 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so6529960pbc.4
        for <git@vger.kernel.org>; Mon, 27 May 2013 00:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=L9Fz95jGedybD85wb8i63GsP1yA/fn5HNDJtM2ivzJw=;
        b=sx6+PcIFbK4dJmIQtogCU7xE1Yt6+r74RtcxoEOfzpdPu/QAp5CiHe+DUT6Drm6CcV
         ZiQ/fOeyEbpaTEcv7/uKvkmCE2G1J6rej5VG6dOBRoerCS/g6wNIiu6dsQT3ltHiOZuo
         dzOWZGaf/1gQ5f7AJ7iIsST7e6z02Iem3zvtBX/F7iM+2PjAIvKXoLMjX1CnLAiHaHYI
         2fL6xjFXTkfyvBKNtTO/+3O2Og/jx2KsxMhWjMTiDj7jwtSShFhgcCcDi4KVnUInctkz
         +XO4jDc7gzKtLKQ0XSKqCiv5NYZICV4hcn/ib40GfpOQsZ+SxG41NThK0R78nwe8XzP1
         hZkA==
X-Received: by 10.66.253.74 with SMTP id zy10mr28596948pac.123.1369641460615;
        Mon, 27 May 2013 00:57:40 -0700 (PDT)
Received: from localhost.localdomain ([221.239.196.216])
        by mx.google.com with ESMTPSA id zo4sm27611611pbc.21.2013.05.27.00.57.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 27 May 2013 00:57:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225579>

Add protocol ftp, smtp, and ssh for credential-osxkeychain.
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 3940202..4ddcfb3 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -127,10 +127,16 @@ static void read_credential(void)
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
+			else if (!strcmp(v, "ssh"))
+				protocol = kSecProtocolTypeSSH;
 			else /* we don't yet handle other protocols */
 				exit(0);
 		}
-- 
1.8.3
