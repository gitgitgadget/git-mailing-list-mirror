From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 30/41] mailmap.c: use error_errno()
Date: Sun,  8 May 2016 16:47:50 +0700
Message-ID: <1462700881-25108-31-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:51:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLNF-0002PI-3S
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbcEHJvh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:51:37 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35826 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbcEHJvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:51:36 -0400
Received: by mail-pa0-f66.google.com with SMTP id zy2so16128143pac.2
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CN35PeU9RhzK6gSqCLtNprGBO2u1QztOAktnyXOgtg0=;
        b=iD5DYWcFM6n8qxq+NflaxHAUFUhLPaIyq1z2EjL/R4o16IMr04C8DbFYK5g9HD3BZs
         +MGfk1DFGFanUtIpLUUy1DIYeQ4+FjxT0Xt5p4IdXU5JHIOjE6ONk40633lCo/zzSWad
         DjfTlZ66c/TWkewpCqHYUoiKbgRc5OQFos3bJx72NZ4oSy6VM/GP5xpuJxRaD1XtoSYu
         0OLGo0x2Tg5vXKnZRMYT+by7xiJFWWt70eLSvzDwliVXOKGyfYP9oDWNjMdWO/H9sxW2
         ILQtDUl9HgW14eq2B7WjzXR9EBTJ5EK2Oorm73/4wb2BbDyg4Mj62yK3qwsEHIppWZ6K
         ilyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CN35PeU9RhzK6gSqCLtNprGBO2u1QztOAktnyXOgtg0=;
        b=BH2XoZzMvGu6Hig9w0Vs8RMybq1dm8gUCwQnQv5F4WmRTpwf78h9UHBWXWylHWLpW3
         JS06uXIl0B1W9wzr4BQFYfpAc9gxK0/l7rpf1cSsPYTpbCghzO4uQoWdMEJe3I/HW8Cu
         rRTttjFrf1q6f+bjoESyOhWkF+PEENMVY2ERKlN43G83KZP9CsGM7toIgLp5s6JIsWba
         bEAG/ORm0K3MiRlTqDLD+7HGAizErDQZ5RGABtXw1HayWNR0r0luiXUoaZWldy/56KR2
         zx5mrFiuKHfpRLjBYE+xk1Mz5FnfGhO3rhwjxY03nkNIFcpojYb3DOpNB1lHj1RAnhYo
         cPCQ==
X-Gm-Message-State: AOPr4FX4UTLIyzz55hmvYGjVNitkvX2Gk7WaH/D0dtpMLcEWVAd4n5o1hEpUwllE0V/pqQ==
X-Received: by 10.66.65.109 with SMTP id w13mr41484066pas.142.1462701096181;
        Sun, 08 May 2016 02:51:36 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id u2sm32817019pan.45.2016.05.08.02.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:51:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:51:35 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293932>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 mailmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 9726237..b5c521f 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -189,8 +189,7 @@ static int read_mailmap_file(struct string_list *ma=
p, const char *filename,
 	if (!f) {
 		if (errno =3D=3D ENOENT)
 			return 0;
-		return error("unable to open mailmap at %s: %s",
-			     filename, strerror(errno));
+		return error_errno("unable to open mailmap at %s", filename);
 	}
=20
 	while (fgets(buffer, sizeof(buffer), f) !=3D NULL)
--=20
2.8.0.rc0.210.gd302cd2
