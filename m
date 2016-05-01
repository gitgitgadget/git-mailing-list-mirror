From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/41] builtin/upload-archive.c: use error_errno()
Date: Sun,  1 May 2016 18:14:29 +0700
Message-ID: <1462101297-8610-14-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:16:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpMT-00079L-Jg
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbcEALQZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:16:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32983 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbcEALQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:16:25 -0400
Received: by mail-pf0-f195.google.com with SMTP id e190so18855478pfe.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8jdWZmsUdmtOBkS5F/vUlz14XqOWbgdFAH22e0jkqc=;
        b=bZGdb4qmaEjmbwhhXGHQIXkAu6P7IGKlYofQVLuNxWLp4Tq+sl0TLeR3oOCyt6STd+
         vO0YOTgNMVa9YTKjeQ21f+3Ae56iA8OS48KZAV9b+ULgFX5XdEa9QOOLH1wYf4pxJPNR
         p2SNNhycgcIFGw8avq6P1k56VSL6+aALHigO4gJUL1M0R9UOnaU7zo3fn6y6f4dUN0xo
         iRZSCeRok+5UaCnErYbQmBaMeq5OgtsJDcrzrd5l6G1suhb+P4lijD8TzGlEA/+n9zOL
         hf60TwT5bZ52izMJKiqAJdcRba2XfwWQ7vl2n+SiswVmptkKvpZ/FO1ok5mN2b9iwdyh
         /jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8jdWZmsUdmtOBkS5F/vUlz14XqOWbgdFAH22e0jkqc=;
        b=Es9Y8g+16kK8z5+7qskSl+Xmv7lw1XAawSXDszjSxeoNKYiBopayxz3wb0k9Cuc7x2
         XpjGzgs5pkNzZQOkQmEW7KxPnExVAdyKruo8urQ1xPFoa63hTQ7RLsnu9ahQH8VDxkWq
         /e8S8CM8pWhgmOXYwkrWARWtOkw2e4IRQcVmMNW7pKq4qI38AZZj0o6px7wPOoF/JfbP
         +qPlSrYmhqP1c2FZq7BrJBqD6CuMExYHSOX9adYrbYZa1hrCe+tNrGRafhI0dxvuVkyp
         AQIrHh6xu7nsGslhbzUwwRskbXjBC8wgCjM/WWziGgfzZTQDQo/eAF5tnIuba9dC7ELS
         i9vQ==
X-Gm-Message-State: AOPr4FXcYH1fWBDIa4DohiGSbvBG/dmSukKEXdbxcQju4DWAjxpPjwFQlcaM2Jk3bzH8ag==
X-Received: by 10.98.69.1 with SMTP id s1mr43414239pfa.56.1462101384388;
        Sun, 01 May 2016 04:16:24 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id d78sm37033706pfb.59.2016.05.01.04.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:16:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:16:20 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293163>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/upload-archive.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index dbfe14f..2caedf1 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -104,8 +104,7 @@ int cmd_upload_archive(int argc, const char **argv,=
 const char *prefix)
 		pfd[1].events =3D POLLIN;
 		if (poll(pfd, 2, -1) < 0) {
 			if (errno !=3D EINTR) {
-				error("poll failed resuming: %s",
-				      strerror(errno));
+				error_errno("poll failed resuming");
 				sleep(1);
 			}
 			continue;
--=20
2.8.0.rc0.210.gd302cd2
