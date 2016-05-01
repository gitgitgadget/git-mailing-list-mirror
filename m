From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/41] builtin/am.c: use error_errno()
Date: Sun,  1 May 2016 18:14:20 +0700
Message-ID: <1462101297-8610-5-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:15:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpLm-0006mi-Aw
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbcEALPg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:15:36 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36729 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbcEALPg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:15:36 -0400
Received: by mail-pa0-f68.google.com with SMTP id i5so16176775pag.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7fvNnb9gxgZfZjWR257dn6XDZM7uRE9FtdXu37UAgI=;
        b=D8LIlHr2dEP95EQrQ0oCONRDhwu2q7p4KPqGdan2FDDLR244D2NehVFpbzSLsUIGWn
         hceuCiagagFLl/7dRmPc1stMTZNVqU86mAA/PpE+RDrmJcngcmce7sZWVz2da50rW1xf
         QKr0X6Fw6cLsERmbGSQjoUe99Pk9jq5p9bdei1ooAa7KSwNnQKI6dWqdCTg87FB8zPLE
         fcEm6ki6jnKdx0KxDTlvNq/s1AWO0/ZxoZDRy8rENYqUDVeiwCpgaEoI7lYspIRnQzv1
         m82hPFRbLYmr3wg/Umy2J+Xiw4XOhz622qiRQyKBWo23Rop7IT/vsi/IqQpeEhSxlBu/
         EOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7fvNnb9gxgZfZjWR257dn6XDZM7uRE9FtdXu37UAgI=;
        b=dsXt9TbFA14dYvUxYS7a6wGCna6ZGqenvilB4gj5IIPONR+P5zwYY6iPw62HT1Y/3t
         Ny5FSPyEn4UZ+MAVoM9823xaeSSTRnGuIu2HUqd/7w663DLMtCRVky10uU0KKOLRGI2N
         x44wj4VVP2LtzUVUOerZio+MdeOA7lmh7xvAUsmXh2V2+15Q59pH6KHhWh0a3dvsbsdc
         YawTiSnDg4VPFrCnGEhumWLOSJz8WpMEY76e5DV3iihlOkOpbALM6FoTbWzgO+ar06GD
         trivPP1UPmvs2KsVCWbqCBciZ1M6UJtmBDXViqiTV2feX1AMWINXkpmftqIwKO816u4P
         24Zw==
X-Gm-Message-State: AOPr4FW0ejg2QL2/UZxu70jWM8DE8e6RlnoOFNaen9Zn58tM7In8yIwubZsF4NFnXcbMLQ==
X-Received: by 10.66.149.194 with SMTP id uc2mr43935357pab.116.1462101335316;
        Sun, 01 May 2016 04:15:35 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id g84sm37063025pfj.42.2016.05.01.04.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:15:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:15:30 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293154>

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
