From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/41] builtin/help.c: use warning_errno()
Date: Sun,  1 May 2016 18:14:23 +0700
Message-ID: <1462101297-8610-8-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:15:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpLx-0006t5-OY
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbcEALPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:15:54 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34434 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbcEALPx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:15:53 -0400
Received: by mail-pa0-f66.google.com with SMTP id yl2so16151077pac.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hq/pO5wKM7a6zps/TIbbtOi8YUVnNsZVAgYTX2cnbiA=;
        b=GPGdXAxSjc4FmXEoBqTsUAg0g6IwavLbA8Kirp4eRkmLuYU2ukq8YlURigXyj3dhfV
         VTKTIXH0c9NxAkjPANi+mvD6ZC40PdedH29CX6OaTzUCaRGpQbl1ONYvqtC14DYOXtwO
         3kT6t/E5P2xjf64+0j7ELYD0UzP0yR0X796x1Zyp7bYH+D4nfJVD/BrXBVWVuFbGodw4
         i+G8YyJY90izdxGbaa5k2pCB4Yno+8/GQRZskfEtOas5vvO5kKSbdby/SAwb1j6frW53
         dUCLoEut5HtLWbtvH9dXYYqTXqlKVukFq/9yfNEUerTyRllF5W2osexFvNcWY/vML7BM
         PJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hq/pO5wKM7a6zps/TIbbtOi8YUVnNsZVAgYTX2cnbiA=;
        b=kfMP1uodOJysjV48Hwmyk2uSM69Wv1Uredt2dp8RoRBpc2MheRX6BWIi47M0myjrOY
         rpRj1XxHmLEl3wR8hWaeU20YTNPeZm417cY3b57BHzSJvpeU/1nIR0DsqsJZlbGgfz0F
         dQpxdCcsO8X+ldUkcEERpcb1+p2Sm4XFdUQUZIjCRRLPIP7PCp5jY1ZZ3Mtbq59x7y/W
         Juct9mY9x1hBBSL0/iOXBDAQqbA/JipvkljHqL2PiMyZEirWgneto6hbD2SzsJx4E2bl
         FpbDSKaIFGZP5KktynA1r9q9kLu+4qgVJx7D1PTcUNgvtSC0MwLhb85NqVMgWC13QGv5
         cnjg==
X-Gm-Message-State: AOPr4FVvuoHa38+sBGHbU6Zm/5M012GFeisbHPPOgkXwgYDKEVdkGU4QCVpOU9jSb1/Jug==
X-Received: by 10.66.75.97 with SMTP id b1mr42980698paw.54.1462101352425;
        Sun, 01 May 2016 04:15:52 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id zn7sm37346797pac.41.2016.05.01.04.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:15:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:15:47 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293158>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/help.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 3c55ce4..8848013 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -127,7 +127,7 @@ static void exec_woman_emacs(const char *path, cons=
t char *page)
 			path =3D "emacsclient";
 		strbuf_addf(&man_page, "(woman \"%s\")", page);
 		execlp(path, "emacsclient", "-e", man_page.buf, (char *)NULL);
-		warning(_("failed to exec '%s': %s"), path, strerror(errno));
+		warning_errno(_("failed to exec '%s'"), path);
 	}
 }
=20
@@ -148,7 +148,7 @@ static void exec_man_konqueror(const char *path, co=
nst char *page)
 			path =3D "kfmclient";
 		strbuf_addf(&man_page, "man:%s(1)", page);
 		execlp(path, filename, "newTab", man_page.buf, (char *)NULL);
-		warning(_("failed to exec '%s': %s"), path, strerror(errno));
+		warning_errno(_("failed to exec '%s'"), path);
 	}
 }
=20
@@ -157,7 +157,7 @@ static void exec_man_man(const char *path, const ch=
ar *page)
 	if (!path)
 		path =3D "man";
 	execlp(path, "man", page, (char *)NULL);
-	warning(_("failed to exec '%s': %s"), path, strerror(errno));
+	warning_errno(_("failed to exec '%s'"), path);
 }
=20
 static void exec_man_cmd(const char *cmd, const char *page)
@@ -165,7 +165,7 @@ static void exec_man_cmd(const char *cmd, const cha=
r *page)
 	struct strbuf shell_cmd =3D STRBUF_INIT;
 	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
 	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
-	warning(_("failed to exec '%s': %s"), cmd, strerror(errno));
+	warning(_("failed to exec '%s'"), cmd);
 }
=20
 static void add_man_viewer(const char *name)
--=20
2.8.0.rc0.210.gd302cd2
