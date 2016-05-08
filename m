From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 38/41] unpack-trees.c: use error_errno()
Date: Sun,  8 May 2016 16:47:58 +0700
Message-ID: <1462700881-25108-39-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:53:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLO3-0003Ni-4E
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbcEHJw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:52:28 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32957 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbcEHJw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:52:27 -0400
Received: by mail-pa0-f68.google.com with SMTP id gh9so13697937pac.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSKZULM5i2x7a9EZ9bG6nSVgKmZmoZilR3Am0oc6Lfo=;
        b=cBE8kmx0BLuckNb+Adm+NLU4t3LjQYw8TqStIDxhksQhwAlheUPVxqRvF6tSPamVWu
         3bsG5REjkryDgrkygT/65azmBUMC0pa+m+cXshldNqOaSFIpBKAd1Y+aUAQCSGEVoWp1
         er/cqb8XCrxBWzirPtU3nBfsBUDlMhKk2Ziu5gZcE02mCCXQBE6yRfDvqsnlTFhXTRxz
         HsVFy41LpfSLbI9n9wq86FcEaipAN8PqrWS3bJ/1brNNa0hp51Jx0Jx/t68ilTG3KbXy
         9JcsSxJg38YU6wOuIpD3jWqZ2bdV7UQD/o6awn7+WHnPebRDCA81QEMFwIg1RVWOPW+q
         K/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSKZULM5i2x7a9EZ9bG6nSVgKmZmoZilR3Am0oc6Lfo=;
        b=ClV5Ibk6N54upeflmkiaMUjbtLjb8fy0X5cdzdk0tANObrb7fOUk2Jj0XxqX4ZMNF/
         SS81lah8AjSCP4C+csDP1IKSgspvgn6JnXLPwwXicCbS0pHKP/xqOdQ0iK+gSUc2uy2i
         EDFyfSSUODuUj5v7gVxyQVuYxvhn0hLVQA87EB99xGwS60HoyxLh+meaTS7JKQxbE16i
         pgBuBM6w3TcGMaTdExeLj6Ew0Bqvvg0k+HNn22TDDWUqZV8mncv+WCrv38uCGQdKRzfL
         JqB43mk2hhXWvtC57DR/uQyF/2bErr9MYosqPNP8b1MH5/f7i8sy2R7RgZaXHQfJLr/i
         38tQ==
X-Gm-Message-State: AOPr4FWedKUQflU/rvtyuI930iLjF6jiuPSw02Vqejry1tTo/m9pSfSRAiN0sU3Tqpp7Sg==
X-Received: by 10.66.237.35 with SMTP id uz3mr35598514pac.145.1462701146578;
        Sun, 08 May 2016 02:52:26 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id y72sm24071413pfa.73.2016.05.08.02.52.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:52:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:52:26 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293950>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 9f55cc2..bb0d142 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1499,8 +1499,7 @@ static int verify_absent_1(const struct cache_ent=
ry *ce,
=20
 		path =3D xmemdupz(ce->name, len);
 		if (lstat(path, &st))
-			ret =3D error("cannot stat '%s': %s", path,
-					strerror(errno));
+			ret =3D error_errno("cannot stat '%s'", path);
 		else
 			ret =3D check_ok_to_remove(path, len, DT_UNKNOWN, NULL,
 						 &st, error_type, o);
@@ -1508,8 +1507,7 @@ static int verify_absent_1(const struct cache_ent=
ry *ce,
 		return ret;
 	} else if (lstat(ce->name, &st)) {
 		if (errno !=3D ENOENT)
-			return error("cannot stat '%s': %s", ce->name,
-				     strerror(errno));
+			return error_errno("cannot stat '%s'", ce->name);
 		return 0;
 	} else {
 		return check_ok_to_remove(ce->name, ce_namelen(ce),
--=20
2.8.0.rc0.210.gd302cd2
