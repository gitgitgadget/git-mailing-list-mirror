From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/11] sha1_name: remove no-op
Date: Tue,  7 May 2013 16:55:06 -0500
Message-ID: <1367963711-8722-7-git-send-email-felipe.contreras@gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 23:57:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpss-0008Tb-25
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab3EGV5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:57:00 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:37853 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab3EGV46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:56:58 -0400
Received: by mail-yh0-f46.google.com with SMTP id v1so276406yhn.19
        for <git@vger.kernel.org>; Tue, 07 May 2013 14:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=R/7DaxVRYqoNSLiTv0dQsf5mQQQ/zihW1VTJ6i2+RP4=;
        b=o9z6++igQLbsjsg22Xp6TYa/6jdxjUmV4RX4GPW03dpVCzfy7kWBPeGHeirjslGQuS
         TKBYtNAvYo4IgJVSxp2X/zbzzIbRXFGQfzkN58ojP4ocMrmXg07i6es/6kkrINeukMUF
         tPzqKVk79HU1n+w8MGYYKZ7H0KlgClPnKxUsmB3nA2hu1V2lbAfKmFSrwdwige6oykgR
         I7TQ8NaN+khVMMHdouJFtwrUKpfNaWrFRsGrsQNsb346W5ZrYznA524/zDq+5SdMnLyV
         E2SluuoDIJ0dLQcBfH7TnpmXj/B6q/omLNNPqKXuN48Rs2Z9Nb+5BEXqLgMp6ae0XVaB
         n9YQ==
X-Received: by 10.236.23.67 with SMTP id u43mr796000yhu.8.1367963817894;
        Tue, 07 May 2013 14:56:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w62sm58171102yhd.27.2013.05.07.14.56.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 14:56:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223611>

'at' is always 0, since we can reach this point only if
!len && reflog_len, and len=at when reflog is assigned.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..01e49a9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -464,7 +464,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		struct strbuf buf = STRBUF_INIT;
 		int ret;
 		/* try the @{-N} syntax for n-th checkout */
-		ret = interpret_branch_name(str+at, &buf);
+		ret = interpret_branch_name(str, &buf);
 		if (ret > 0) {
 			/* substitute this branch name and restart */
 			return get_sha1_1(buf.buf, buf.len, sha1, 0);
-- 
1.8.3.rc0.401.g45bba44
