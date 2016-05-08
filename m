From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 04/41] builtin/am.c: use error_errno()
Date: Sun,  8 May 2016 16:47:24 +0700
Message-ID: <1462700881-25108-5-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:50:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLKf-0008Fg-CM
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbcEHJs4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:48:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32872 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbcEHJsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:48:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so13781524pfb.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7fvNnb9gxgZfZjWR257dn6XDZM7uRE9FtdXu37UAgI=;
        b=xl0Y1ioHpWtKR0uCw62kehssLHuLoUEHcjZLxnRXgMjhiSMb8LW/8gSHX78AoEG9kt
         QTfjcmempKYWVyezBdGLZJK4KPA5vAxjJOo452TPr+sEi7S+wapZxrCM7Tk+Y1mJVaBN
         6/IbH9eL3A6Emn6HC9arPst06x3HPCpfTVwHSJot3lWGvw37IvfxzOBATcr38GbatLio
         Pm1yH0S2Hq0lGwjb/E0iBqjpKCL9ckU8drGlc5/G81HCocb4A+YlvLIUUbB0BkJKHXI8
         vcT6phluZXei0i73IHJvaAM1c7OEnkw5UI8CrQobSrBWSrmtlFQ7kkM62cWLYgLHoMng
         vEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7fvNnb9gxgZfZjWR257dn6XDZM7uRE9FtdXu37UAgI=;
        b=hZhRVzpwqXAND3PNYrG8yeY5Sdfa7h2K6wZ9D6W1IzyUf5txrOKS0dmhF740HSG+z2
         e5/rrxF72pAIG0b81Vb7OvurGp8klyFQBrMBSMVIaIEchEmhRuoNA18MD0M48ELnvbda
         LjNQJSNUsBk21sKqp6tiW8x0uEJW8+U+aqC9d0xgTuGxbumxMzbuC0rSMLj19ONDdjqt
         pF9B1qOURS/w86XLAhwttwolF4uSs9ByEL2o5m6aO7cE5lL45ZjM2qQHkYP4d3SQ/hxJ
         NlljhdH87sNyn3Pv2WRYhguDkGGTyrXiCpK8t9KTsxBDWQDvki4TsfZYGm8w1JgVvCCJ
         EUTQ==
X-Gm-Message-State: AOPr4FVuRzz/kXLqGLATN5kEjZsQrPmonqj2ZWqNLYcKYfMONF2HOB4hMgD2RAKmrnttJg==
X-Received: by 10.98.10.202 with SMTP id 71mr41544609pfk.143.1462700934831;
        Sun, 08 May 2016 02:48:54 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id f187sm32713304pfb.60.2016.05.08.02.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:48:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:48:54 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293921>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/am.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d003939..3dfe70b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -769,15 +769,15 @@ static int split_mail_conv(mail_conv_fn fn, struc=
t am_state *state,
 			in =3D fopen(*paths, "r");
=20
 		if (!in)
-			return error(_("could not open '%s' for reading: %s"),
-					*paths, strerror(errno));
+			return error_errno(_("could not open '%s' for reading"),
+					   *paths);
=20
 		mail =3D mkpath("%s/%0*d", state->dir, state->prec, i + 1);
=20
 		out =3D fopen(mail, "w");
 		if (!out)
-			return error(_("could not open '%s' for writing: %s"),
-					mail, strerror(errno));
+			return error_errno(_("could not open '%s' for writing"),
+					   mail);
=20
 		ret =3D fn(out, in, keep_cr);
=20
@@ -857,8 +857,7 @@ static int split_mail_stgit_series(struct am_state =
*state, const char **paths,
=20
 	fp =3D fopen(*paths, "r");
 	if (!fp)
-		return error(_("could not open '%s' for reading: %s"), *paths,
-				strerror(errno));
+		return error_errno(_("could not open '%s' for reading"), *paths);
=20
 	while (!strbuf_getline_lf(&sb, fp)) {
 		if (*sb.buf =3D=3D '#')
--=20
2.8.0.rc0.210.gd302cd2
