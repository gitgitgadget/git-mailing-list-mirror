From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/41] builtin/update-index.c: use error_errno()
Date: Sun,  1 May 2016 18:14:28 +0700
Message-ID: <1462101297-8610-13-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:16:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpMO-00075o-Rl
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbcEALQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:16:21 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32967 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbcEALQT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:16:19 -0400
Received: by mail-pf0-f193.google.com with SMTP id e190so18855391pfe.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=inhdDDHvJFRF0Fs8Eqpq2OHkC0O5JpvTlwGyZBTLumA=;
        b=HH/AgUu9Z83ZlUK2l9IWM4IQ03IXzREdhXUtEX0H0cIqn2cpsrHbJjfuADBeBf1bhd
         ckElvK1HqR/tamKYS+JGSCrfQ6mJWMP9EJkqnSKj0KhDguLtWR6gBlLpzJsWTx/Glql4
         9z5LgI/rEeN9rZIdpKkHTUF345o29AJfwo9LB1POmqyyeYi3GbIMxX+U1HHf1kdXjalI
         +VxHoBjN84wH7yfLPp81gNGmgEKEDgLVyx6I6A7ht59NCx4La2nVPcPNrcvIwNloFy+5
         BOaY6y2ad2DyNV4auYrHY77KMtVDH0J7XTTbTylbajaWsITHGP9xX/yUHIvJPOKnbTTJ
         uXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=inhdDDHvJFRF0Fs8Eqpq2OHkC0O5JpvTlwGyZBTLumA=;
        b=K227Uv50RbnNrfDwkRQCb04XMdhCXACq/W6SpKppIPRpd0jr247uaSqHf/rd19Ahjg
         K3pF4qhRbYdmpfY4kxQF2uTu4/0A4i/yD7vShbc8MNX6DabGsg8FwkuYlpqDtzCJS7OJ
         z5OX6rhVSKlj2/UJHnCpA6pCJTAheq+uBxArnecz0PPapRSiok2ZecTjwOUF0PJGWQI9
         kKN8XGI1y4wm27vZu11QVtLmIaPWB9Kg+1ECniay1muX8yGC50Nc0L57wEFQq2xX0vGU
         WtmlHui93/MGNWjpbiGMwTBO2H3iAozwxPHSkKv4LqUv2C3Dl8Fs++d3C2YRe/o8tGJq
         9mLA==
X-Gm-Message-State: AOPr4FWILjX5uO5vZrlERkr/K1ALp8bOd842zw5Tp9iph0rXPhbTaOSWkFblMCPFCtkImw==
X-Received: by 10.98.86.24 with SMTP id k24mr43480977pfb.87.1462101379239;
        Sun, 01 May 2016 04:16:19 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id g5sm44151813pac.1.2016.05.01.04.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:16:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:16:14 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293161>

"err" is deleted because it just causes confusion when "errno" is also
used directly in process_lstat_error().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1c94ca5..0c539ed 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -251,11 +251,11 @@ static int remove_one_path(const char *path)
  *    succeeds.
  *  - permission error. That's never ok.
  */
-static int process_lstat_error(const char *path, int err)
+static int process_lstat_error(const char *path)
 {
-	if (err =3D=3D ENOENT || err =3D=3D ENOTDIR)
+	if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR)
 		return remove_one_path(path);
-	return error("lstat(\"%s\"): %s", path, strerror(errno));
+	return error_errno("lstat(\"%s\")", path);
 }
=20
 static int add_one_path(const struct cache_entry *old, const char *pat=
h, int len, struct stat *st)
@@ -382,7 +382,7 @@ static int process_path(const char *path)
 	 * what to do about the pathname!
 	 */
 	if (lstat(path, &st) < 0)
-		return process_lstat_error(path, errno);
+		return process_lstat_error(path);
=20
 	if (S_ISDIR(st.st_mode))
 		return process_directory(path, len, &st);
--=20
2.8.0.rc0.210.gd302cd2
