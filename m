From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/24] untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
Date: Sun,  8 Feb 2015 15:55:41 +0700
Message-ID: <1423385748-19825-18-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:57:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNgK-0003Fv-J5
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbbBHI52 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:57:28 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:43905 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452AbbBHI51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:57:27 -0500
Received: by pdev10 with SMTP id v10so1802941pde.10
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zq+cgr85ykyaiiLO3HHaR2QgogjUyTAXjJMyfqKincs=;
        b=0/uegw45thVzaiRxVVYro0el/etSFrNcNf6qcgNTr+vvCrJhxPHs21sxFEmiNh79+S
         LQ2Zxj0rVS/I3UtfTwt+V+w3lnwNUK6PmutAeZecijeEd1egJ86KA91aqdtGuMXCgLv3
         vZZCv+cLuxOS9bFSOG9xqmwBvUGWm56saZE1rzoqn9Oavk3lyAVMiylBTzqLDXymVCyq
         3MnqJZKMICdCTIC659IwkJ8W/QH7573bEVuiu4V8M5yaY3D4kGHZw7XNtJgJ6M2UcoET
         b7/Ep0D2mKuW3Q+3uUp+r/L4y7U2TaNjfZNhu6Y5HEjmDKGjaBmtLWezBLdQeSwtghPb
         hOpA==
X-Received: by 10.67.8.2 with SMTP id dg2mr19647941pad.15.1423385847429;
        Sun, 08 Feb 2015 00:57:27 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id l3sm12949092pdc.46.2015.02.08.00.57.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:57:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:57:34 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263479>

This can be used to double check if results with untracked cache are
correctly, compared to vanilla version. Untracked cache remains in
index, but not used.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 1c3db0b..5b9dd5d 100644
--- a/dir.c
+++ b/dir.c
@@ -1800,7 +1800,7 @@ static struct untracked_cache_dir *validate_untra=
cked_cache(struct dir_struct *d
 	struct untracked_cache_dir *root;
 	int i;
=20
-	if (!dir->untracked)
+	if (!dir->untracked || getenv("GIT_DISABLE_UNTRACKED_CACHE"))
 		return NULL;
=20
 	/*
--=20
2.3.0.rc1.137.g477eb31
