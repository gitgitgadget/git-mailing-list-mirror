From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 06/15] contrib/git-credential-gnome-keyring.c: strlen() returns size_t, not ssize_t
Date: Sun, 22 Sep 2013 22:08:02 -0700
Message-ID: <1379912891-12277-7-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyOa-0001yp-3k
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab3IWFJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:11 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35067 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab3IWFJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:09 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so2761802pdi.14
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DRbXMsuevCdusaeeDy/Lt2KZCyssfuLXhnxpHCyIlxo=;
        b=CrXzc27AfCBjRlDPo/3g8m3SN0b1VjBDLncHwC+gMfzKYjei1OxCNAbq1txkQsnDi7
         i8v5T+BEQ0NlfmYptq1GMAwT6NjTNX4eQ6mU+xODNeU5bMsYpJPQNuHk4qRVkVVkDEk8
         ql6QiNVe0V+l3YpaNixlgANX5hljit5DFXf4bqldLeEu4DWkrR8btANo00ZKq7XZnc0Q
         aOKINfOMaYgCUlB9CIVZe8+QCBahn2UioRFwsv5oLkRM2rFCbvWMQd1xRnnDfKrXQahN
         nXcnO3XsuG2uoxTmidc/tMj5ku73e3aUMX2DALxSsx/nH7ab2y+xk5DXzzDrvIJUT2D+
         vFhQ==
X-Received: by 10.68.218.163 with SMTP id ph3mr11934578pbc.19.1379912949334;
        Sun, 22 Sep 2013 22:09:09 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235188>

Also, initialization is not necessary since it is assigned before it is
used.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 contrib/credential/gnome-keyring/git-credential-gnome-keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 5779770..1081224 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -307,7 +307,7 @@ static void credential_clear(struct credential *c)
 static int credential_read(struct credential *c)
 {
 	char    buf[1024];
-	ssize_t line_len = 0;
+	size_t line_len;
 	char   *key      = buf;
 	char   *value;
 
-- 
1.8.4.489.g545bc72
