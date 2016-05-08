From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 37/41] transport-helper.c: use error_errno()
Date: Sun,  8 May 2016 16:47:57 +0700
Message-ID: <1462700881-25108-38-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:53:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLNx-0003EA-Ni
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbcEHJwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:52:22 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36667 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbcEHJwU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:52:20 -0400
Received: by mail-pa0-f65.google.com with SMTP id i5so13724751pag.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVMDjXB7MwRk56ezfUFvtUWFXZYtncTgl5sm5H4rVkU=;
        b=EdnCL4Vi6RPzsdCMIQXfcid91xPjb4M9Q+HNrvFsQHdNkmEyM/bE40tSz2H59RqBSG
         ZDm9LNRocu3TNlbjO6I2RGUrdjpWp1rbsCStjv+zuTXbGKwoUSphRWlGuFshR2LxDzGe
         NTqXCJBUWtPhJl5ss0bwNzGcOoQIQKqOrYfQoF4p09jy6WlY4GZHsOtEJSa22qmEk5qU
         eo7tmaUqJ6q4K7jH6Khy+p3tmFojffXxCUE5M5iTU7vEvjpnVPdAxytA3ES/ofBd+oKR
         4pQYh1eA0IhFS0E4gum6r35moGUiq1fgVLUbv1NWkrEFp18AZibnqSFxstyHcXawnisl
         R/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVMDjXB7MwRk56ezfUFvtUWFXZYtncTgl5sm5H4rVkU=;
        b=IvDkuAU42s/mlgpeagDYUT4it1SuTzz1t3UQRODCYrpx34pkxWaX1osK+iRcox+w61
         +Y5sU0/ThdoIuNeBl1elaLELgl7u3/Hu0MUriCbSEy0Z62kDIHPpeAKbiprLrge9PfmR
         zdb/QLud9qnpu0W7RlcenmK7Ueb+52/9IW174ypxMuVJbKt3v6oXEr+WGSaTRpVkJtAa
         Av5aE/YZ37E6OG2RFjJ5FbJIU+fxtrIQ9npbAT38Tlb+zhTmuVVxK+Cdytf2egykanPl
         gkyAqdmQnIS6iUnD2rGN3O2qKwU23jZEjyQvJYlQFGquxeGA6C3brR8m35ACBU6lgt2E
         OgYg==
X-Gm-Message-State: AOPr4FVv+7l8nU4pCLd3DE9Z8kW/+hMKOOGILH3G/YRNyX8ShwGgjQvMaCE1BX/o2MkgSQ==
X-Received: by 10.66.90.136 with SMTP id bw8mr41924606pab.52.1462701140352;
        Sun, 08 May 2016 02:52:20 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id z63sm32766090pfb.47.2016.05.08.02.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:52:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:52:19 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293947>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 transport-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b934183..f09fadc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1166,7 +1166,7 @@ static int udt_do_read(struct unidirectional_tran=
sfer *t)
 	bytes =3D read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
 	if (bytes < 0 && errno !=3D EWOULDBLOCK && errno !=3D EAGAIN &&
 		errno !=3D EINTR) {
-		error("read(%s) failed: %s", t->src_name, strerror(errno));
+		error_errno("read(%s) failed", t->src_name);
 		return -1;
 	} else if (bytes =3D=3D 0) {
 		transfer_debug("%s EOF (with %i bytes in buffer)",
@@ -1193,7 +1193,7 @@ static int udt_do_write(struct unidirectional_tra=
nsfer *t)
 	transfer_debug("%s is writable", t->dest_name);
 	bytes =3D xwrite(t->dest, t->buf, t->bufuse);
 	if (bytes < 0 && errno !=3D EWOULDBLOCK) {
-		error("write(%s) failed: %s", t->dest_name, strerror(errno));
+		error_errno("write(%s) failed", t->dest_name);
 		return -1;
 	} else if (bytes > 0) {
 		t->bufuse -=3D bytes;
@@ -1306,7 +1306,7 @@ static int tloop_join(pid_t pid, const char *name=
)
 {
 	int tret;
 	if (waitpid(pid, &tret, 0) < 0) {
-		error("%s process failed to wait: %s", name, strerror(errno));
+		error_errno("%s process failed to wait", name);
 		return 1;
 	}
 	if (!WIFEXITED(tret) || WEXITSTATUS(tret)) {
--=20
2.8.0.rc0.210.gd302cd2
