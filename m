From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/41] builtin/rm.c: use warning_errno()
Date: Tue,  3 May 2016 19:03:44 +0700
Message-ID: <1462277054-5943-12-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:07:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ6z-000054-2F
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933137AbcECMH2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:07:28 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34541 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932646AbcECMH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:07:26 -0400
Received: by mail-pf0-f180.google.com with SMTP id y69so9183437pfb.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5bNkUU43Gwbkhqb0q+XXYlBHZE066u5+k++5y2pT1I=;
        b=t+djNVAwps8N/Y61XnJxCHxlgLKLMRCQqUGRXhvmcmobsQfgRC0LTb/yQcqsdslLe/
         4AKd494fjhB1TET+UOnHlQtdlH2X0ygjstx4ZMQc8ZplelG4fOzSqR3C1e3pYEfuRIFo
         GmQkaXcSpPgQrb/4FUaSTwJKjGLueG+pLXusoUeBOzjVQXNjp+2xQpeB0Jy7booqI3+X
         SBqo+IAZvrOtdskz5B1Zz/NbXXyTyiUt8iSZDS+lxU4InEZ1l0hlaGq98CDv/Mio6moN
         rRAO84v//vUEPldUISWz5G8v+VP2SrW1PiITdWDAdOgKZGqhbNteeLo4vP7rzEbuXS3g
         ATJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5bNkUU43Gwbkhqb0q+XXYlBHZE066u5+k++5y2pT1I=;
        b=PxKVNmHZHxNUHgug1FGGQkGnuz4kKwkgf4lKK+4Lqg8f8oGbNNdcT5P4/7ujlFMQY8
         4NdSZSDzT7FkX3rLlB5u+qze9JWTscDK5cLmmHfYOuSjFP08vS2E/Tj3u11tjkq3g9dG
         V93t5Um4WBAxI18Yag3ClTJE8ILiwaHDaj+FYB4Dx/kvd60W/EnAzsyFBCxkHJg4Mz7c
         CADAFjUqkoXuGObVD72C2NOXiU5ogNS0rjgQBQi++MPrsuuYLswpDrphW2VGTd5kuK6b
         fzZTxRv3QvD2ao+UY6dPfA/ycH1cRwaj9Xyt06fidwqYxS1gK3bNlIg+mrFPZSiY4AvD
         kcmA==
X-Gm-Message-State: AOPr4FVYwiuP0zqA1rmJwc5Aocka+XKOYC8vc+ylWcyZvYRXspA27DmdbgvvmHEKGaJquQ==
X-Received: by 10.98.85.194 with SMTP id j185mr2909309pfb.68.1462277240637;
        Tue, 03 May 2016 05:07:20 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id z2sm5466138pfa.90.2016.05.03.05.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:07:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:07:16 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293362>

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
