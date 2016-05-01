From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/41] reachable.c: use error_errno()
Date: Sun,  1 May 2016 18:14:47 +0700
Message-ID: <1462101297-8610-32-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:18:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpO5-0007yw-CH
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbcEALSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:18:05 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36789 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbcEALSD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:18:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id p185so18817037pfb.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sptAnTVgqTWhli92LdRfu18uo8C7gDdNccorqSAaOVE=;
        b=h+c9M+/y5N9JY7uzqcPhSq7TQLw/vDffxdHN+6m/wciysspLsjtiqE4g6zkiS9kvhZ
         6ERnvYp7sGxJ3OkhHOsXobKiQOd5uc6rsNRjsCXGzYev2PeEZQRxovoA1AlTSlyYCDIu
         AzfJ7Dsobvpnq39x952qWz0idxUZVp/FBh+a/wSTRBliCnVtuktVg9fh/E17eWojHZHX
         NB84AHQumj9bmcM48oBmFNjODhOWshEIMV60PL/WXvlrgqfLfcr5sfdiQ5FRMc74AiCh
         oFj0Ll22BENvi5yBB2pFfWEcPtIi1ejX/prhMIrAkkWRz+/RMKznXV1w8Mum4U8L2IR9
         Fk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sptAnTVgqTWhli92LdRfu18uo8C7gDdNccorqSAaOVE=;
        b=Ghm952Zb7R0viBhq3dHqYMPwRSfKCj8c77w1gqdDW5yWRf0aPhGUckLHis6GwABacl
         13CsAvSyNvN7BeNCxBaQ5zrx+Bawaqg3rcbwS+x4kIh90fRkbAIqOp3SA0CZ5TCSDaSj
         tSoawdL24jxmM/o8A225HzuOMrcOvoTmPUS4GEmpsgSsMT/z3HaQuMdJEPmXtZDriP3x
         E8NXGLMn/tdcmFSGSIq9ABYWk//im4ir4dkJ2gBChEcJYTdQyd92gS7FXufLZzVIkVvj
         MXXIybuos6xSRPr7r/QauuSUKygsWEZy7ETMMIMsBm0BpVO4vmib6EGwpo7daEavSc6F
         SfDw==
X-Gm-Message-State: AOPr4FW7uhIHe5xMTsSru9cb5mlEfQwBrUP1Zcs25Pu6r+XUSEIB0qXKXKhX/7y/HZAEXA==
X-Received: by 10.98.93.138 with SMTP id n10mr43208943pfj.43.1462101482500;
        Sun, 01 May 2016 04:18:02 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id i6sm36479407pfc.65.2016.05.01.04.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:18:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:17:57 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293181>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 reachable.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/reachable.c b/reachable.c
index ed35201..d0199ca 100644
--- a/reachable.c
+++ b/reachable.c
@@ -119,8 +119,7 @@ static int add_recent_loose(const unsigned char *sh=
a1,
 		 */
 		if (errno =3D=3D ENOENT)
 			return 0;
-		return error("unable to stat %s: %s",
-			     sha1_to_hex(sha1), strerror(errno));
+		return error_errno("unable to stat %s", sha1_to_hex(sha1));
 	}
=20
 	add_recent_object(sha1, st.st_mtime, data);
--=20
2.8.0.rc0.210.gd302cd2
