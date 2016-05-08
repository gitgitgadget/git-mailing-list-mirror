From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 07/41] builtin/help.c: use warning_errno()
Date: Sun,  8 May 2016 16:47:27 +0700
Message-ID: <1462700881-25108-8-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:50:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLKy-00005O-6S
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbcEHJtP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:49:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32931 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbcEHJtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:49:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so13781876pfb.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hq/pO5wKM7a6zps/TIbbtOi8YUVnNsZVAgYTX2cnbiA=;
        b=YppvoFd9qANBB5EbxUl2E3cokueGIM4cP4qrT9CklkaVrb0vJmeEP4bl88C30V+dsp
         DCQ/CEZEajXWeXuaBxoUIzNngFsHAVIZxM75+TTx+sKEp7B1myFR0VmjkkApq/LD5igi
         tp1np7bRvcJE1TJ9KrkhJKE5Kcq4sE7yKu+vSgl4gtumvavrr1bV9/uYhwb8U+CoVicw
         XutOBMJLZPGil2sKDp0IsvKNIJ/IUri3nPDjGY4ac5MfMtcywzilxvAdO3GwDl2+KHPw
         1BtUT/gCiBDkzYw7fNgXxdCMoZfoO4P22KqK9edZ4ZF/Xlnk+Tmg6CXNN2z2/SDZDZhe
         Yv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hq/pO5wKM7a6zps/TIbbtOi8YUVnNsZVAgYTX2cnbiA=;
        b=EKE/ZBIY3JbXC4XjMXC2f/d66TdxiFli9oZAvspnT1ttCZJIj+DfGhuuragDT+5HoD
         tc59qCtvaueGEeWAcEn0oCDvXuVeOSHOSU8f6RIub+8ndc5D4iHFlpfxvmhVIv840kHL
         viVpSeiQW28g/nTENex2WdNqd0SUzldcVMXbCbhxKTqg4oIkaC5ec8HJ7z0XtjUAq1vd
         tzjCAIjJm8Nlx1X9Lw3C1riqpLq6ceP+OLcZhvwsYGii19fyvbT3y8xcsV5MnbcXrWkm
         uuEw4yHcuhG7ce6hYvruI5oFgNXqT9PwgmeGrcd9PC46eG53KiQ1M3uspALzmF3vBoSL
         VzqQ==
X-Gm-Message-State: AOPr4FUW9tR6C2GrU6RZmkiXubTHIIQXaq6TJwQo9U8ursbN2/lFsMi2mblYZQvzIzNLnA==
X-Received: by 10.98.13.88 with SMTP id v85mr41668887pfi.150.1462700953553;
        Sun, 08 May 2016 02:49:13 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id m184sm32747682pfb.22.2016.05.08.02.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:49:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:49:13 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293923>

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
