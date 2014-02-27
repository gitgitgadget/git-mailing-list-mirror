From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] Rewrite git-compat-util.h:skip_prefix() as a loop
Date: Thu, 27 Feb 2014 20:13:17 +0800
Message-ID: <1393503197-29669-1-git-send-email-sunheehnus@gmail.com>
Cc: Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 13:15:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIzrk-0000i1-NI
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 13:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbaB0MOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 07:14:46 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:35950 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbaB0MOp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 07:14:45 -0500
Received: by mail-pb0-f43.google.com with SMTP id um1so687489pbc.30
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 04:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vP7ksgkHqVYIBJFUgR5Z57y9FSdaKiupx8InD1pqShM=;
        b=gHfd+qSM/KEkY2nwRtHiEo3ftCXIJ4a6bp4b+rANn9+jXgK5c0vW5cCcYcmKuvIurV
         zpkYLdUNWbAyhpyUfvPA2LetgcuHYWsQpUyUkSqEXCYulMq8aSKoCdUjqzrwtXamDh7A
         Z0uYxl2TqO7k4G7cgt4MfksnEQVVnL/IJBUkjSQt/Hnnn3MzqmzqImxPC+fVQ1t9SwQ+
         NUL64FUiPBm3T3na0nQiSuIaMDmQRdFhGup1E3X91GrEjqMxkADioUyMdFsdGWF6Bci8
         DatA6AYghOVmmXO4kxGXYOUwT8vFOKHoqLAvcBX12mWPRic4+LCH+dWIEDDzVrvtg7ku
         K/yQ==
X-Received: by 10.68.202.230 with SMTP id kl6mr13041136pbc.55.1393503284780;
        Thu, 27 Feb 2014 04:14:44 -0800 (PST)
Received: from localhost.localdomain ([61.150.43.99])
        by mx.google.com with ESMTPSA id yz5sm30005161pac.9.2014.02.27.04.14.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2014 04:14:43 -0800 (PST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242813>


Signed-off-by: Sun He <sunheehnus@gmail.com>
---
 git-compat-util.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index cbd86c3..4daa6cf 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -357,8 +357,8 @@ extern int suffixcmp(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
 {
-	size_t len = strlen(prefix);
-	return strncmp(str, prefix, len) ? NULL : str + len;
+    while( *prefix != '\0' && *str++ == *prefix++ );
+    return *prefix == '\0' ? str : NULL;
 }
 
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
-- 
1.7.1
