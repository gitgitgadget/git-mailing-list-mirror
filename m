From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH] log-tree: simplify digit_in_number
Date: Sun, 25 Jul 2010 19:16:30 +0200
Message-ID: <1280078190-4010-1-git-send-email-ralf.thielow@googlemail.com>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 19:16:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od4of-0005TE-VS
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 19:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305Ab0GYRQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 13:16:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64960 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab0GYRQj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 13:16:39 -0400
Received: by eya25 with SMTP id 25so340191eya.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/Ygn4ZK0y8XaHLgSzRvEEAqrtDl9P7FnwbAddpnIyJQ=;
        b=VnzCekLY3C5KwgSkXDjU+SCWoCs3tZ1IFSdvh0EMmsrwHdb+sRZlVXqTfGiDzI9wBP
         dW7NwAF0/Dz8yyLDkGBFxnR1QrIg9E7b+CGo7zVrgW7y6gRAaHATSkz7euqKo9xqtJDu
         G2JcxUiI7tmwK9vA6DDdmrdt9RPfZqhIMjja4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iOuZj4wCuXxiYg/08ty2+N2AxnRzRf8bnFJJT9SQlYIE82ONr/USDts+VH2fMHkkdt
         c3CeUUOedZ5nDTdDiY98173Znmm/EdX5iSJVxTDwEqlYfDOXJJPB3qfTVcYluzhnm5ku
         EhzoI5yW1korfvZGaC3ke2TYllGMg4jt1GMys=
Received: by 10.213.47.76 with SMTP id m12mr5053819ebf.43.1280078197860;
        Sun, 25 Jul 2010 10:16:37 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-159-075.pools.arcor-ip.net [94.222.159.75])
        by mx.google.com with ESMTPS id z55sm4177144eeh.9.2010.07.25.10.16.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 10:16:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151761>

log-tree: simplify digit_in_number

Make the algorithm to resolve the digits of a number more
easily.

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
