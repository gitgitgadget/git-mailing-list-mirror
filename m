From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/41] copy.c: use error_errno()
Date: Sun,  1 May 2016 18:14:36 +0700
Message-ID: <1462101297-8610-21-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:17:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpN7-0007Sj-MF
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbcEALRF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:17:05 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36586 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALRD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:17:03 -0400
Received: by mail-pf0-f196.google.com with SMTP id p185so18815915pfb.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9gdftNInvYkBsfXxTpXaj8uI5t5aQ7m0JqFwg6BLLAk=;
        b=VlLFftP2pGX3be/nNzjREGiXvDMF48WTUt6VphgfDcleYysXZMjl8hRZ8qMTURnSee
         uCP8QciHhAwpUoNm8JZemKN9Z+C5advePtdGgsudPCWJmysLkQeWwfwo08RW4vscz+ZS
         5TbfyDyIkEtvzsG9RuhF/L19uF0taxncpKRwPt3qgiyt1QmQLbm2gFoFeN8q8bIb3CTr
         JBHoWL5GsFF+KNppVAm15XxqeXpcJ1V9pOk3ttee3rH2p2+9mhcjLTyXabs5cZc4un6E
         GqkMvltRJ8I4kqCYbIsm+oDZUx4L2UyV0pDYHF/dfPb0hjZUC1pcPZnL93peVrnH9xNC
         oquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gdftNInvYkBsfXxTpXaj8uI5t5aQ7m0JqFwg6BLLAk=;
        b=Lit+rfD59y1vKbmZvo7GyRlFE19DmNuBd8PdValUeGxDoCYQkEXkq1fB3drFh8g84N
         yqbwh+KOuAhVmiIiqY/At1H8xVcmjnUqO7n0KxgVjQTSzsGSIUhRGyYgYHqyhdYm5TvK
         hb4J9HS9/C7YmABVlE5ViJBxHOFMYVKBqHfhIvJwhiOU7TVNDo6AsXGYtlw7/3OzLvNn
         FaGi/Q3lNGGFam5aF02kK/UYOldvV72QRta/DUycCvqDI+6xJfiCwTXp+rw/OXEAXHb9
         adCcFBLFsmKG6BmR3eqZU/oEnTFpvOjXdnzSUmNxYlzAl6akKTtHIB+ejhla7YaTpsly
         FSmw==
X-Gm-Message-State: AOPr4FVzqod+7YsSjQII/3VBOiUa4RPq7R+KK4ISsCCGo+LoEAwqKEFy47ia95bcmP6WWQ==
X-Received: by 10.98.2.16 with SMTP id 16mr43420722pfc.148.1462101423062;
        Sun, 01 May 2016 04:17:03 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id to9sm37378063pab.27.2016.05.01.04.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:17:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:16:58 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293170>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 copy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/copy.c b/copy.c
index 574fa1f..4de6a11 100644
--- a/copy.c
+++ b/copy.c
@@ -42,15 +42,15 @@ int copy_file(const char *dst, const char *src, int=
 mode)
 	status =3D copy_fd(fdi, fdo);
 	switch (status) {
 	case COPY_READ_ERROR:
-		error("copy-fd: read returned %s", strerror(errno));
+		error_errno("copy-fd: read returned");
 		break;
 	case COPY_WRITE_ERROR:
-		error("copy-fd: write returned %s", strerror(errno));
+		error_errno("copy-fd: write returned");
 		break;
 	}
 	close(fdi);
 	if (close(fdo) !=3D 0)
-		return error("%s: close error: %s", dst, strerror(errno));
+		return error_errno("%s: close error", dst);
=20
 	if (!status && adjust_shared_perm(dst))
 		return -1;
--=20
2.8.0.rc0.210.gd302cd2
