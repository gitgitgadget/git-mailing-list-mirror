From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 1/2] log-tree: simplify digit_in_number
Date: Sun, 25 Jul 2010 19:36:20 +0200
Message-ID: <1280079381-4548-1-git-send-email-ralf.thielow@googlemail.com>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 19:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od57u-0003zr-Sp
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 19:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab0GYRgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 13:36:32 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61661 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab0GYRgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 13:36:31 -0400
Received: by ewy23 with SMTP id 23so627380ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fjlokKMge65j8VC/r+WWVyJVBo9X3Q/nWOXQWfn8yt8=;
        b=Ta+52spPQUygJjoDn3id3O2r0pmEPJuwUt9SmSISoJ3q0BJnCLwCUZBQyAkj/xtQlM
         XEBRwYMx2YOnibMpBnHpDvClUlhuIw4/MhXv1DXAip7kfOti45NAsyiC6aXr5DFfn5HD
         kL2nj8aKcfjkWZSfpFIizN3J9YzjU3qHxT2TE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=lp994xfBlt0IxFz1pcO4fR+dZ3zBD/6tyogdKV6os/up+tGkDRoODY7TNY3o6/o0Yf
         7L5CSHN2prN27g9pBIPJ/mkOxqLFpVWOgU0lnn8lz1576l0K5WUgPdInA0qyvG5AM9eI
         MJ8BM7SGkus9L8Z17XTiKCUJPWjiJvXFV/chM=
Received: by 10.213.20.4 with SMTP id d4mr2667527ebb.83.1280079387940;
        Sun, 25 Jul 2010 10:36:27 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-159-075.pools.arcor-ip.net [94.222.159.75])
        by mx.google.com with ESMTPS id v59sm4202286eeh.10.2010.07.25.10.36.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 10:36:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151767>

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
