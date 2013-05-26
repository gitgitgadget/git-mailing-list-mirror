From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] archive-zip:write_zip_entry: Remove second reset of size variable to zero.
Date: Sun, 26 May 2013 21:11:35 +0200
Message-ID: <1369595495-8306-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 21:11:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UggMH-0007ww-31
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 21:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab3EZTLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 15:11:48 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:55861 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab3EZTLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 15:11:36 -0400
Received: by mail-ee0-f44.google.com with SMTP id b57so3703922eek.31
        for <git@vger.kernel.org>; Sun, 26 May 2013 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ndYxrP4Ksm2W30dLOCtKxWR6TpSoeDyAzuiupcLrZRc=;
        b=QPTytywqKgdZ6k8z8aDNdNSjb9dj3tzGaMUk/HBVAkaBQ6iyBR3xcgSHjn0IqTYm6F
         D42d4zQI/X5V17KdFqLW8r4Dvbyp7Kh1dI0OS3NWZIfB2xqq2a9Tx+DqAoGHOpPBTm3W
         zuGGloic/ucVtRcDXl3uiXDfViVJdb2214vKZrzVShoMASEpTTE46dfI4lzrxfiva+6k
         J3czRvJ+t9wRByckYsfVK4FGTQeoyKbbPKsLP5dNiHBk4npk+1kjYTd4y3kPtAh2K6Ww
         IdZD6gHrk18qXei+RF6KlBwTBnENbFtKlM1ZvnqL+/4BN14RrwJvPSpIjSuRIgAHYP7+
         bjJQ==
X-Received: by 10.15.111.75 with SMTP id ci51mr51377688eeb.7.1369595494469;
        Sun, 26 May 2013 12:11:34 -0700 (PDT)
Received: from localhost (ip-109-90-70-123.unitymediagroup.de. [109.90.70.123])
        by mx.google.com with ESMTPSA id c5sm21451093eeu.8.2013.05.26.12.11.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 26 May 2013 12:11:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225564>

It is set to zero just 3 lines before.
Reported by cppcheck.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 archive-zip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/archive-zip.c b/archive-zip.c
index b2c4fe0..4bde019 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -232,7 +232,6 @@ static int write_zip_entry(struct archiver_args *args,
 		size = 0;
 		compressed_size = 0;
 		buffer = NULL;
-		size = 0;
 	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
 		enum object_type type = sha1_object_info(sha1, &size);
 
-- 
1.8.3
