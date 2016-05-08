From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 09/41] builtin/merge-file.c: use error_errno()
Date: Sun,  8 May 2016 16:47:29 +0700
Message-ID: <1462700881-25108-10-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:51:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLL8-0000Ep-GS
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbcEHJt0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:49:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36071 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbcEHJtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:49:25 -0400
Received: by mail-pf0-f195.google.com with SMTP id p185so16152483pfb.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZbH0aj/1QMxDJipoMrBAot73gdiLnciGm+cDjSxZB0=;
        b=qtgvQD/dD4CP49PRyYwBw6EsyHcCvrNOTTI+cKH/oJDcYSzRkiMvnpm6BdTLwXaL4o
         zkr2pK2VJ/2P7Ohjas6NYbRocde2dQ5gcq7EwkMxsE1BifABq7LGy/Zzmf0/9DAR4Jks
         mnHG8PM5BXTrAD2Au8qfr3HB3ad5i36iYuOhWIvGm+GaNwNQ2XmgtgoEqV0PIu2hh1Oj
         p1axr4UsublEQp1vzrC4FX1toTWO3LucdqJ+U3TA0lkMeM1LSVbzi7sGMV3qIaCayBbv
         Ir022vUHF4m4fSTbwkpLOtSkYQnyBEPDLvldwtC06go2v/nERgXN48yjhSqQBRTLpfhx
         S8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZbH0aj/1QMxDJipoMrBAot73gdiLnciGm+cDjSxZB0=;
        b=PDltU3onWokTurqtKnderii2p3Ks0WZAuwhlLKN/syz+vKIK4PtT+1hCUU4d6pAC1I
         QzKav7fBeZa+XXJXGxS4ELbUc3I9AauWWvyZByRcLDeK0J/Ck9C+yM2FZBPp9Lvr3QPD
         X9q3bkr/UyP8JJdM7RMF9uv7mUzeCNd4JSFiXLZcOn2NoERYm9RmTLUBfkqHEn8xiuAB
         4hwWwWwaYaYNswWxdTcbFIDt7kQfdoCwYvUOy9YcD6X44NAg6KJzyB7JKRcCrBYFj4NJ
         199sjL04WPH5S142JReGrFziw9Mkol3uTHl2Q9lhs2lCfmVwvqtNyvg1Q4w/64tNzT+1
         ssdg==
X-Gm-Message-State: AOPr4FW4XbnY1QQQnJY8mLQ9b4UuFcJq1vYeHaur+GGiWcRvO/B+rT2fbwis7KKfEQNGQw==
X-Received: by 10.98.53.65 with SMTP id c62mr10742044pfa.47.1462700965305;
        Sun, 08 May 2016 02:49:25 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id vg9sm32825680pab.35.2016.05.08.02.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:49:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:49:25 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293924>

All these error() calls do not print error message previously, but
because when they are called, errno should be set. Use error_errno()
instead to give more information.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge-file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 5544705..13e22a2 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -62,8 +62,7 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 		usage_with_options(merge_file_usage, options);
 	if (quiet) {
 		if (!freopen("/dev/null", "w", stderr))
-			return error("failed to redirect stderr to /dev/null: "
-				     "%s", strerror(errno));
+			return error_errno("failed to redirect stderr to /dev/null");
 	}
=20
 	if (prefix)
@@ -95,12 +94,13 @@ int cmd_merge_file(int argc, const char **argv, con=
st char *prefix)
 		FILE *f =3D to_stdout ? stdout : fopen(fpath, "wb");
=20
 		if (!f)
-			ret =3D error("Could not open %s for writing", filename);
+			ret =3D error_errno("Could not open %s for writing",
+					  filename);
 		else if (result.size &&
 			 fwrite(result.ptr, result.size, 1, f) !=3D 1)
-			ret =3D error("Could not write to %s", filename);
+			ret =3D error_errno("Could not write to %s", filename);
 		else if (fclose(f))
-			ret =3D error("Could not close %s", filename);
+			ret =3D error_errno("Could not close %s", filename);
 		free(result.ptr);
 	}
=20
--=20
2.8.0.rc0.210.gd302cd2
