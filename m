From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 30/41] mailmap.c: use error_errno()
Date: Tue,  3 May 2016 19:04:03 +0700
Message-ID: <1462277054-5943-31-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:09:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ8n-00014K-UZ
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933098AbcECMJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:09:21 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33258 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbcECMJU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:09:20 -0400
Received: by mail-pf0-f174.google.com with SMTP id 206so9370710pfu.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CN35PeU9RhzK6gSqCLtNprGBO2u1QztOAktnyXOgtg0=;
        b=Ag2+3ZRrj2jbNrx8wHhoMxsg+AK1+36zPmUXCM2iPK2BZ5E4NnTyHuN44GNZt1+DxN
         VvXnE0PyguLj4Yy4sXQLSzFyXw8UFEcGC9ZGmur7tGKPNdimXYP3kv+3H7tsGrM5Kjai
         9XJ0nqsCk/hEbWvMvo2BtAB1t7vMmogO4se53AIDVoi2HRzngmSuCMMUwO/y+UAeIM7w
         hNVik+8VDA/GuPC8G3GsqeMlaLBfqhnIdbXkfVZ/2WgI1DgV36u4dphBFsiK7+m4eGKl
         DxTOkdtRX809UyI2taNn5v7koWwZsG26nWG4hovkbVYbVTV7pv3Zyf9DhfAxjsQTmCfQ
         lGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CN35PeU9RhzK6gSqCLtNprGBO2u1QztOAktnyXOgtg0=;
        b=DSyY1aI2lr0Bg4qqb0ms93TuMLNC3PNMSdENgK2zHv/WJJTH6fc2Ub9E+qL7adllCZ
         dGZyQuEYrUpc3AWC8GXlmM95gREbu15HCqweXeXLHSqb2BIem5PfxwNKtI7bitGGk9j8
         04lLo2ZR3YqpdLcBlzdLMOTBenSTzYVUHm2adQpEFYf/T8Tz6BhSI3OerNgx9UE3Mmp5
         pygXUfhQCVDmhuyK/gO6koSS/iiHUU+AdtLYFg7fAF/6iyFMpTODDaGH+B0NdBqNdni3
         1atgdcW+834ZqkYlJDZoStVcRRBTP4uRVSxgOwnTtfczE1X1gLI1TUtpDsamfTIQsuqm
         stfQ==
X-Gm-Message-State: AOPr4FWZ9eSEjs5gGp0qpKDKior1GJxXm5DOnQKxzOdP275OS6v+mggamZtuhJO9roYZ4Q==
X-Received: by 10.98.23.150 with SMTP id 144mr2949872pfx.96.1462277359252;
        Tue, 03 May 2016 05:09:19 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id ut1sm5469932pac.46.2016.05.03.05.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:09:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:09:15 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293383>

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
