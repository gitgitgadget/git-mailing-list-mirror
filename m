From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/41] builtin/help.c: use warning_errno()
Date: Tue,  3 May 2016 19:03:40 +0700
Message-ID: <1462277054-5943-8-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:07:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ6e-0008NB-VO
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035AbcECMHD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:07:03 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36652 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932897AbcECMHB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:07:01 -0400
Received: by mail-pf0-f169.google.com with SMTP id c189so9660612pfb.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hq/pO5wKM7a6zps/TIbbtOi8YUVnNsZVAgYTX2cnbiA=;
        b=aQgxRZKUxsX429HlNmWuZ4yffcBGueBpPo2bPASN+/j4TzOM5/qyQwBAXUoV9xfik1
         yVfxS4lbI6PpEKS0I8cBJr3wzyj/WJ1ZlJnIl2+QvsG3lW1gYJo8RN+EW3WqNWQqPbGV
         ihOtX+v1lP09aLEsAbbfHu5gcuDTBd1njFTBmKrV/pcftRoYxPGihjiM1o39evS1k5/9
         vqUrlYGICM2VxCiHVOTdBMtPW6Hjh09Wx8kQQGCzKVVfSWjsudpfKW2hWWWEVjyIIiTl
         1RvN4Dum7bOrSmzxKibNYDNcJftXnU23n88E8UNZOm078fC5k6BEcSDp+Mwe0BeiM+I0
         a3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hq/pO5wKM7a6zps/TIbbtOi8YUVnNsZVAgYTX2cnbiA=;
        b=GxwnydHJSPXkzKu9skcOc4wDJ4ZNE0Ygos/5TkFkiut01EXIC2CuWDgANYGG0BYh1+
         /2LeuT6YdS5xhk2M7aiFd4msHkzjbeWzNhH4n33Alfe14KcuKnP4NYAKewJSFLlbZXwW
         S8dUx8te0T6b4WvcQ/Zt2DbNqIWDDGueDQBnqAfu6kq8zNpvV4y+FJDbGo0f4U3M33HF
         aXC97d/x4zGtV+BNonBsC9YhGsrChJV/LJFDjkOJOVUkUisVpuWQ7JAh2Eetb0W/Cdxl
         7SE9EiPnE7Tlcnu22uEwI49f+Cz9CAjcoHZvoyyWcKkcn+JHu39URbveKVSLt4VeRHvO
         SMhw==
X-Gm-Message-State: AOPr4FXVOlAIRnvcBciOpiMqhLPaRyi7scruXfSwr/f9c4VZlRtEJatuWkM2+fpJgnah8g==
X-Received: by 10.98.92.66 with SMTP id q63mr2898758pfb.21.1462277215601;
        Tue, 03 May 2016 05:06:55 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id k77sm732029pfb.52.2016.05.03.05.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:06:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:06:51 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293361>

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
