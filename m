From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/41] builtin/fetch.c: use error_errno()
Date: Sun,  1 May 2016 18:14:22 +0700
Message-ID: <1462101297-8610-7-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:15:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpLs-0006pY-Cz
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbcEALPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:15:48 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35173 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbcEALPr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:15:47 -0400
Received: by mail-pa0-f67.google.com with SMTP id zy2so19084964pac.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHE3lpm+4jZj9KMYYuNEM1cMi3boqeb9aePEronky/4=;
        b=m8Szamu3FU9W6NUE61EyGcKMS+eA5te0jnoDnRH0x9OtqnDiblY43qMLIrmeqFGQ7X
         AGOjnQC/mJcviWDx0XRfHD+BmE04AsTSNNLKYaZy/N8Xp5yJKUNXH3Cuokie9ceMfHT1
         9NjGWkPXQATBv4C9Q0YSaYACBqk/a1P39M6NFhycBmyIlO/ynz96nq6O0PBKijimvIJE
         uke8R+Ct2JlRia4itVKDcbHV7yRPUCRMgcSRYYe1L3ySwDL18E0kYslruKgt5dNorcvK
         ZLQok8BPFLc9jy5Q1rTVQmiZWN1s9k0nA9XFQiNweInMOWtBuIAZUByzTqsjRjxRnxhj
         1McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHE3lpm+4jZj9KMYYuNEM1cMi3boqeb9aePEronky/4=;
        b=GajR050GIIVf3vVrFmSDbKxI3+MsmDK2EnUrMB0V1bwqNyeRF2DJsBUb0f14OZ4iA5
         6f7iq0b2LCksj65WpgPD5Rgual2iwhpl4frESN24lw08dWU9Nwgf/pu2bNd+8G437fa1
         lY2ENaV27L+QpRdDefrvd75fbliX6uLGQ3Z+n7+7Ytb8LfuaMj5/AGLUZe/w3ZuTKOPb
         LTGgUeB65DnByzwRzGEqg5bp84+g0q2UfS4H5xfIxd0YRoqlq9QTYGcatQ1468UKiv4N
         SY0Mo3Ab1x2iERBNrHQBXZK7IzX3nKJ2bru9OQRzArwIwzfI5lRmVOByO90cayciil6g
         27Eg==
X-Gm-Message-State: AOPr4FVnOdBv9l12ni/KDRDcjt+zHnBvzP+TM7D5omUQsT9msUUbqU+f9tTZRmy0YtIumA==
X-Received: by 10.66.63.104 with SMTP id f8mr43378813pas.109.1462101346915;
        Sun, 01 May 2016 04:15:46 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id bf4sm36885522pac.4.2016.05.01.04.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:15:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:15:41 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293156>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f8455bd..1582ca7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -607,7 +607,7 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
=20
 	fp =3D fopen(filename, "a");
 	if (!fp)
-		return error(_("cannot open %s: %s\n"), filename, strerror(errno));
+		return error_errno(_("cannot open %s"), filename);
=20
 	if (raw_url)
 		url =3D transport_anonymize_url(raw_url);
@@ -848,7 +848,7 @@ static int truncate_fetch_head(void)
 	FILE *fp =3D fopen_for_writing(filename);
=20
 	if (!fp)
-		return error(_("cannot open %s: %s\n"), filename, strerror(errno));
+		return error_errno(_("cannot open %s"), filename);
 	fclose(fp);
 	return 0;
 }
--=20
2.8.0.rc0.210.gd302cd2
