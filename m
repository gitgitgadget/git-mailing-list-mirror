From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 1/2] log-tree: simplify digit_in_number
Date: Sun, 25 Jul 2010 19:43:17 +0200
Message-ID: <1280079798-4993-1-git-send-email-ralf.thielow@googlemail.com>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 19:43:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od5El-0006TZ-Dt
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 19:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091Ab0GYRnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 13:43:31 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56050 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab0GYRn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 13:43:27 -0400
Received: by ewy23 with SMTP id 23so628268ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=syvZ/odyvJgxq6/RRJgbBTKDnf0dON1BqrP8ouIaMEk=;
        b=CNFlytmLxDPZoMMTIGRlO2WdtrB7Dd3PwFoLeZnJDdh4wUdLcPJPUUX7ECRXU6t3xb
         Oy3Ctf9mT5+tftD1twcINEeghtLyqF+P53I85fXPJkLyoGvCvzxUAW6Z2Sqwp8h/PD/8
         v2F5glVKmJRkKuwT+jQiMInWo9LNUIOn5uH8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SuPWadu7uwSX1oZJ6jQlad0XNFzoQSUgWADXYq05ObD8eDYQ65XF6lugXG7WxtB3M9
         4yGAelVzr4nwBJ959VpqpJwqFI18zpOAdgA4lZ15HEMrwy2ud8PeXohMxrVL297cOgdh
         3CIbGXmnepyN9pUNeEDu2Lo8sMs/42HrbcDd8=
Received: by 10.213.31.134 with SMTP id y6mr2723528ebc.49.1280079804584;
        Sun, 25 Jul 2010 10:43:24 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-159-075.pools.arcor-ip.net [94.222.159.75])
        by mx.google.com with ESMTPS id a48sm4218558eei.0.2010.07.25.10.43.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 10:43:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151769>

log-tree: simplify digit_in_number

Simplify the algorithm to resolve the digits in a number.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 log-tree.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index b46ed3b..95a00a4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -254,12 +254,10 @@ static void append_signoff(struct strbuf *sb, const char *signoff)
 
 static unsigned int digits_in_number(unsigned int number)
 {
-	unsigned int i = 10, result = 1;
-	while (i <= number) {
-		i *= 10;
-		result++;
-	}
-	return result;
+	int digits = 0;
+	while (number /= 10) 
+		digits++;
+	return digits++;
 }
 
 void get_patch_filename(struct commit *commit, int nr, const char *suffix,
-- 
1.7.0.4
