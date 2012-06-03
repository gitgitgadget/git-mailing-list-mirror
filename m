From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 1/2] i18n: Extract msgs marked by sh gettext wrappers
Date: Mon,  4 Jun 2012 07:09:26 +0800
Message-ID: <1338764967-30103-1-git-send-email-worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 01:09:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbJve-0006aL-G0
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 01:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab2FCXJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 19:09:42 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39685 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab2FCXJl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 19:09:41 -0400
Received: by dady13 with SMTP id y13so5049393dad.19
        for <git@vger.kernel.org>; Sun, 03 Jun 2012 16:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=it2HnW/rSpQwWbXtbLTrwqS7SmdTF7iTCsYB+dZmuDU=;
        b=LdgyeZKLGDBezHuGSU4nPrsYohTnVx4rZS0ptggTKQgLrXEiDdLzDO+/T37VISCJCI
         cq/d5CN6C7NVpInTPLpqJiX79vJyFUbzXib4tRnTWRxpKjsWXnj1Z8YYKMcoFuSg5rdK
         bIAQeVkbfr0FucJGmMqomHuhIyCQx/f0IclNGgXBk1HAnI7KWcx/JN0WK55w+GDTGiNw
         jNmAaPMvoqecpRK41aRAKCl3f+nNQbN7HVs32F5a2TZzU2YXHF6SMeERCgsodWQ5G2PK
         cz+YM3Z09c4I31o94vq1MwY0FGeaQme21Cu4f/LHeNW1kfKoEt0Xw2rWau4Qfyk34z88
         jsDQ==
Received: by 10.68.222.197 with SMTP id qo5mr18045883pbc.72.1338764981366;
        Sun, 03 Jun 2012 16:09:41 -0700 (PDT)
Received: from localhost.localdomain (li381-10.members.linode.com. [106.187.38.10])
        by mx.google.com with ESMTPS id ph1sm11041070pbb.45.2012.06.03.16.09.38
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Jun 2012 16:09:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.559.g0ba0f00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199112>

Since we have additional shell wrappers (gettextln and eval_gettextln)
for gettext, we need to take into account these wrapers when run
'make pot' to extract messages from shell scripts.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4592f..dc3fd 100644
--- a/Makefile
+++ b/Makefile
@@ -2333,7 +2333,8 @@ XGETTEXT_FLAGS = \
 	--from-code=UTF-8
 XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
-XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell
+XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
+	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
 LOCALIZED_C := $(C_OBJ:o=c) $(LIB_H) $(XDIFF_H) $(VCSSVN_H) $(MISC_H)
 LOCALIZED_SH := $(SCRIPT_SH)
-- 
1.7.10.2.559.g0ba0f00
