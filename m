From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/41] builtin/rm.c: use warning_errno()
Date: Sun,  1 May 2016 18:14:27 +0700
Message-ID: <1462101297-8610-12-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:16:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpMK-00074m-0E
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbcEALQQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:16:16 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36859 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbcEALQO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:16:14 -0400
Received: by mail-pa0-f65.google.com with SMTP id i5so16177474pag.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5bNkUU43Gwbkhqb0q+XXYlBHZE066u5+k++5y2pT1I=;
        b=To4KToScxZzxrXslp44PBSrMX5F9L2WfePkXRiUxw5qxlTB+CLR6ed2sxgPWLVbfbY
         6OeKeZ6QP7pusm3dENy0T1uQco3hKF5zi2BbRvG3zSRMlRY4GqJ/gDHowOsw7+Qlkvv1
         ExjUn+OB4fGm+0XLKH42wVDlz9GCE7MrWu1I3efYl8hQ2blWVEiCOXYbMk8G2xU0x8aE
         VKiOGJlSy47Tx/Gev2EQeLetBPjZwtUUhgfW8vrhkJMjeRhQsn6VwBU4u30eSqEDpY3u
         nXn6WJxB9USTUx+eU/vp81SvTLBj+BKg5jXOoazVbN8Jzh8U0VyZMsm28uV2lj9+NWn7
         I1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5bNkUU43Gwbkhqb0q+XXYlBHZE066u5+k++5y2pT1I=;
        b=UYzHScuZymYAXwjLsrr4iXJGeM+TiLhhc5kylvs/CuQiX16curFMsvX9vY1+gYnsvL
         9muNnCTtquJ0qBV2oBpUUEcJQXW1RRbidVyECBl50Dt076FcjjWrYzMlX9+8pZte2j8M
         yFVSSrpsvPuiQ8ebsNvlRulYl5oIC3tJ1q+zJR53jEiw1NSdDQrblO4VGTY2XO7mv3AE
         UB3GQyMpO3dcimvWNQS2fIpD5DFzdU+790Rfx/lki4v1xggRy9idaB2ucOWQe4y3DNxd
         pP0ZtGLU062CJ8mZ5rz1YuPqwPCoPXN6RA+KqVtLgdUoIe27ybnM+EL1GNJKarBzrtsD
         zWTQ==
X-Gm-Message-State: AOPr4FUZQopARM4KXiev2V8wNqBei1wslQRKm630n7OahI1+FAvuqHZyNo6hSDgUnX+uhw==
X-Received: by 10.66.153.174 with SMTP id vh14mr43813431pab.131.1462101374065;
        Sun, 01 May 2016 04:16:14 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id n10sm37087769pfj.14.2016.05.01.04.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:16:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:16:09 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293162>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 8829b09..13b9639 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -152,7 +152,7 @@ static int check_local_mod(unsigned char *head, int=
 index_only)
=20
 		if (lstat(ce->name, &st) < 0) {
 			if (errno !=3D ENOENT && errno !=3D ENOTDIR)
-				warning("'%s': %s", ce->name, strerror(errno));
+				warning_errno("'%s'", ce->name);
 			/* It already vanished from the working tree */
 			continue;
 		}
--=20
2.8.0.rc0.210.gd302cd2
