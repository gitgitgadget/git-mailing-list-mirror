From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH 2/2] help.c: use SHELL_PATH instead of hard-coded "/bin/sh"
Date: Sat,  7 Mar 2015 21:08:00 -0800
Message-ID: <0ebc0373b21c75fa88adb5aefd098e9@74d39fa044aa309eaea14b9f57fe79c>
References: <38be9195b966a027cb050e5a1b47526@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 06:08:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUTRp-0008Mt-4I
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 06:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbbCHFIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 00:08:09 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:40350 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbbCHFIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 00:08:06 -0500
Received: by pdbfp1 with SMTP id fp1so49042497pdb.7
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 21:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ebToOgMW6oFQwUpwuBB9cOZYTgH3on+ZIDeMN+mBdNA=;
        b=duI4OFME5Vmbg9ksKWGQF4NYQwJ/KLav38vTdSnyAPe1gX/qkDyANb8iND1Rv8ypbC
         ttPtMAjn+DBqzSedTXzWed+3GtVldjtvnJI0cIrfIawaHvChE3YCzrsYNxAgFiVm5xnb
         IxktypFkmmSz+CmiWclQLo6sSfjJlSNOy7BIX6aBKhnbur7MV1QAiLUR2K6h8Q2RqWLP
         t/Gm0BQqHNjM06gTG//V/RRSMPxOdpEDIM/dqxUxtseLvRZ1D/VX+hYKdMLtTiEZj3ck
         kS1ufreYkPX0Obv9Tb/dzhMZLP4wRXEdXYAvB+kJ6jmX7hRX6MLnnFCKrpkXBa6y9+Wo
         gTEA==
X-Received: by 10.68.142.169 with SMTP id rx9mr39088214pbb.41.1425791286047;
        Sat, 07 Mar 2015 21:08:06 -0800 (PST)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id om9sm13762729pbb.34.2015.03.07.21.08.04
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 07 Mar 2015 21:08:05 -0800 (PST)
In-Reply-To: <38be9195b966a027cb050e5a1b47526@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265029>

If the user has set SHELL_PATH in the Makefile then we
should respect that value and use it.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 builtin/help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index 6133fe49..2ae8a1e9 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -171,7 +171,7 @@ static void exec_man_cmd(const char *cmd, const char *page)
 {
 	struct strbuf shell_cmd = STRBUF_INIT;
 	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
-	execl("/bin/sh", "sh", "-c", shell_cmd.buf, (char *)NULL);
+	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
 	warning(_("failed to exec '%s': %s"), cmd, strerror(errno));
 }
 
---
