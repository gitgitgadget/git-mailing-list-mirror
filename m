From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 38/41] unpack-trees.c: use error_errno()
Date: Tue,  3 May 2016 19:04:11 +0700
Message-ID: <1462277054-5943-39-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:10:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ9c-0001Qq-V4
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933203AbcECMKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:10:10 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33442 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930AbcECMKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:10:09 -0400
Received: by mail-pf0-f179.google.com with SMTP id 206so9380210pfu.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSKZULM5i2x7a9EZ9bG6nSVgKmZmoZilR3Am0oc6Lfo=;
        b=NaLPt33R92Ly2oGJ4DszvyUnva35q5yG+rmvovVAdpmjOHL3qN0tk16qEtFOHkGVAH
         26Hcbs4xsEzxThdSBVROrg64JaSV7w8OevsMggoGMzveUpVjCihlgieeTHYLPZmN0GH9
         8YrAWE1O22qSESsTyOX6Ey3nhq/MKHWc1uO2d/sK+F4fq0a60AM7Wc1PtTvECQ2MV6EB
         qeKUmxqtfXI7oXbtPTkV8xlZjlHmsxJYMxUUXlUW4PG/mrG4CNimkgSD0SJUsZFY69Dh
         44A7fqhKz1KrTCU57/dGUIBEfWk45PZ06tbPj4ynOxjl8l6B0xYd7zDy/gYpY96nwY/Q
         arNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSKZULM5i2x7a9EZ9bG6nSVgKmZmoZilR3Am0oc6Lfo=;
        b=VlxZBiUEoCAt2THwVvftNdK+tPKLApreu/3Z/0qTlHyMyHr5YNoceVPkQxbZQwikPh
         b7tRckRmwEiJWSmZ7umMKX+O88jiMWSS9vjdjHL3Xt0PQjuyIei7ItX4NybJKzX4b0YI
         bExbi5pi8ZGgjgN4wUkqFl9TM26uurQbJYK4cnvRlTwwVT3bJvNHHKuPa/8vsLFJmEv+
         sIkqw/1xCOih0sA+ke8MjPSsLLBVeGQgQ/E3k+fidkqV3zKPxS7bIp11ECItSjjB4Q6+
         9QES6JGg7TYgqhLkYRkKy/F1binEX1fkjt5qJFbjX/EpIp3WAIw63+dIBWgLumVz06Dy
         aHJw==
X-Gm-Message-State: AOPr4FWkPsig9EDWg4zcwYwklJDDgpFeE4ObQzDca30tBjdbxsTANL+hvnKv1uOVVhUTNA==
X-Received: by 10.98.99.66 with SMTP id x63mr2922500pfb.132.1462277408456;
        Tue, 03 May 2016 05:10:08 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id h1sm5517917pfh.49.2016.05.03.05.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:10:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:10:04 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293392>

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
