From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 38/41] unpack-trees.c: use error_errno()
Date: Sun,  1 May 2016 18:14:54 +0700
Message-ID: <1462101297-8610-39-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:18:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpOf-0008J2-Qi
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbcEALSl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:18:41 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35775 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbcEALSk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:18:40 -0400
Received: by mail-pa0-f68.google.com with SMTP id zy2so19088311pac.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSKZULM5i2x7a9EZ9bG6nSVgKmZmoZilR3Am0oc6Lfo=;
        b=UeQEd/rsV7Zvm7/KWW2Gi9xX5wWaao60kMfqHY0+XE68hJ0XjIRhdNsy8d0IbeAA25
         f2N+qb3pbjzL4bxAfmr5jCZ8RFsute8jBvk2MeOlochCtcmZ1CY1BoYxzjSy7OIVoBrI
         itmZqZymEM5jNOm/nSvygMmkT+Z9VKoCytFHtJFgWqqUizpMQCOyh9Q3smQZK0bTMHPp
         Yt8P0tg0wyiRDZjWsUHixD1HalRj8zNxMbhpz3xyK1U79rzo5THelhRsEDj2xq2D+uqj
         W0CE8bFYt3ZDbuAvqrH7VGOUeOz/Yt9AjnM0C8EnCqGZ4qSy3DUGksvI2CjcX8TV7Auc
         99Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSKZULM5i2x7a9EZ9bG6nSVgKmZmoZilR3Am0oc6Lfo=;
        b=aDch/JbLdY4cAA5CVL7gL9Am01kO9QzxpzOsA9jVjn4IBr5pCSdTszLD4x5OOWwXzO
         jrHQWerzQGJ0gTuOspM/Iy3ESgu62oKzcyrDTReLOIvhOVvUAsyF3kd5I/fGGamWUAhw
         y3wDDIH1bn3xplS5dZjpy70XJpJJWZOlrQr4TjVFLmt4pQRAqivM/L4uxRe+NQ68sXWc
         dNIJ0nfEDDUJcA9ZRbBuLyuoNEdPRDbgObGbDHqptdGlgtLp7b6cNTMk1xqX2B9vyyg3
         Bn/Durjy+6AeAZgbdiCarw0gyR0UZWsi5CY6kxC04/TQ9xqFF/82C3V8jkUU6+rTMJCo
         PHCA==
X-Gm-Message-State: AOPr4FXSsNc6Fo8O/C0T1kk+/t8VwxPG2wbbfxONYp6KVfBuXPC8ErEIC/gQs69Z8TWbaA==
X-Received: by 10.66.251.132 with SMTP id zk4mr43605265pac.50.1462101520285;
        Sun, 01 May 2016 04:18:40 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id c2sm37103980pfc.40.2016.05.01.04.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:18:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:18:35 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293188>

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
