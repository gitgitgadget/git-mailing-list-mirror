From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/41] builtin/am.c: use error_errno()
Date: Tue,  3 May 2016 19:03:37 +0700
Message-ID: <1462277054-5943-5-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:06:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ6A-0008AA-W8
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbcECMGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:06:39 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36580 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462AbcECMGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:06:38 -0400
Received: by mail-pf0-f179.google.com with SMTP id c189so9657011pfb.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7fvNnb9gxgZfZjWR257dn6XDZM7uRE9FtdXu37UAgI=;
        b=NcxL/f/pI+Z3loWCXBbXoGxKGvghLFvMvBx77BOQrRmTKSP4KhbaRsq1tDq2o9K8l0
         nrfA8XwjVlH+MiEINEMmF1q4WiPbDBVCGuA/buw+yfVoLhWflluCtETL76ykcHy1z7yy
         PJ+S5eHsNvIlK4lDGRh1AYtcXIvxUkgK4JQc/q6gfJqEzYLNnQtKgdbcs0CuPDg0lPGk
         imahLdGeEb9Qq//QQc9+5X/kpb+DRhSZbdecMSW1GWADQMeV7mgZ4hkeq5Ptrm/3h9TE
         hu7akdHtbJzexGIPId4mj7k4B4z5Ynd9B0NX4qRi9Bsl07nZJkL3RSIwFFT+QUK1Oe5h
         CjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7fvNnb9gxgZfZjWR257dn6XDZM7uRE9FtdXu37UAgI=;
        b=Sj3n9lNmNcXQm5FLDShScED203vfOtJ78UKXOO1h8NVx07sIJi2ETOpHGUirl7kbr9
         LrC7xV2HKhnlPYX7zfvJ6Mag3XqRmtDd+v9jnoR5zjBEwCIucrBQ8UpkRhbcsDUElF9I
         dCx8loUeyIsRc823dFYW9Qlgs7xi4soUB3xqKL3xV6rJwfqbGWGa5d/H+uspPQmoK3pB
         NnqW6LCtdw8xERiHqNPuhvjTVDml/nHiFFfQYKDaAMNGPcyZkakR0YY2FOvqFscXtiyL
         +gFFmGc9a1cYYrMNVBi+ncA7p+EydXymdGppYxDW/Uph5uC/Z0ajZ9tueOG6wkH4X2z/
         xjdA==
X-Gm-Message-State: AOPr4FUwkhL7tNNdWzlTW9RpoXNX8/oDarV7Hub/Z8A3WRQHQOs4/OlquGBBlFlUtCemXw==
X-Received: by 10.98.22.193 with SMTP id 184mr2851241pfw.116.1462277197390;
        Tue, 03 May 2016 05:06:37 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id e7sm5510601pfa.28.2016.05.03.05.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:06:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:06:33 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293357>

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
