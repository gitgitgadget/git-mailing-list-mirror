From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 18/41] config.c: use error_errno()
Date: Tue,  3 May 2016 19:03:51 +0700
Message-ID: <1462277054-5943-19-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:08:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ7h-0000Rd-IV
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929AbcECMIG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:08:06 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34693 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755759AbcECMIE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:08:04 -0400
Received: by mail-pa0-f44.google.com with SMTP id r5so9224736pag.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8lAtbkOkmTPBTZ3FX1NRx5i78FZmxgFryOCCy2Ocmk=;
        b=IJXmwv7UPHvW2Kq3Hg52HnXiZfPdqO7oC+AoCSvoykV5NnBbVijWQHz/UJUKSaCZJY
         I8LAylg4AWu96KR3ACEMfouMaOmMWbTYS/yRLYZCsN8B/VjJcB0ms0yLIqbtV6eidr77
         9dkSwlpQYqXMg2cdXZyj29tA1lUa6mdQnzvOJthZD/6AwDAF5sktd50fRrpeH8i5Gi+3
         dwcMVEMkTChdybx8KQ0971zpL4j7QN4xbvhT9+eBRXWwco+DZq1CBQlbBwoB6aGW1vxE
         u3MkqCOVxRE+wZ3tuVBrBiQJabD/Q3F8b1l0tav2aH5HxWTUbhk36zB/mzpeqPeKcw1p
         VjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8lAtbkOkmTPBTZ3FX1NRx5i78FZmxgFryOCCy2Ocmk=;
        b=LpAV+sR2wcuY086ooSRti8XSlQrOCzERT1kT6eKhSZ01Dp9smNtDPP4MsWPkEGoFiS
         rpADX9o6CHJPO+m6YIGvrX63iVllO4QZFN2ufcgQYABcs/Y8GWf0t+kxvH1nlV9TAyTw
         2SaTPCvGX0aBSOg3kWd6vUYkTPNYFvUuS9NEWXkADsjyxteApa1Jak+dFl3i/zMqfEmv
         wQrpDd6v+3bf07/AqnOdMSUdNq3IRbz6oRusWlP6qjUNlPoYwgN2QTHxvzU5XQYsqv7a
         AUg1mNyLajGCQfPy45+ZXDzy/MiKgRZK9W4DB4+qNJpzZVM1ooyKIMttmers1gm4UL97
         jcnQ==
X-Gm-Message-State: AOPr4FUBYL1o0kkbl+2CO7r5B8S5frcb4HjqoiNTBzoY1gtyERsUeWMUNh3yhKWW2wkDUA==
X-Received: by 10.66.175.110 with SMTP id bz14mr2898002pac.41.1462277283853;
        Tue, 03 May 2016 05:08:03 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 19sm5481529pfu.83.2016.05.03.05.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:08:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:07:59 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293371>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/config.c b/config.c
index 10b5c95..80411e4 100644
--- a/config.c
+++ b/config.c
@@ -2012,7 +2012,7 @@ int git_config_set_multivar_in_file_gently(const =
char *config_filename,
 	lock =3D xcalloc(1, sizeof(struct lock_file));
 	fd =3D hold_lock_file_for_update(lock, config_filename, 0);
 	if (fd < 0) {
-		error("could not lock config file %s: %s", config_filename, strerror=
(errno));
+		error_errno("could not lock config file %s", config_filename);
 		free(store.key);
 		ret =3D CONFIG_NO_LOCK;
 		goto out_free;
@@ -2026,8 +2026,7 @@ int git_config_set_multivar_in_file_gently(const =
char *config_filename,
 		free(store.key);
=20
 		if ( ENOENT !=3D errno ) {
-			error("opening %s: %s", config_filename,
-			      strerror(errno));
+			error_errno("opening %s", config_filename);
 			ret =3D CONFIG_INVALID_FILE; /* same as "invalid config file" */
 			goto out_free;
 		}
@@ -2111,8 +2110,7 @@ int git_config_set_multivar_in_file_gently(const =
char *config_filename,
 		if (contents =3D=3D MAP_FAILED) {
 			if (errno =3D=3D ENODEV && S_ISDIR(st.st_mode))
 				errno =3D EISDIR;
-			error("unable to mmap '%s': %s",
-			      config_filename, strerror(errno));
+			error_errno("unable to mmap '%s'", config_filename);
 			ret =3D CONFIG_INVALID_FILE;
 			contents =3D NULL;
 			goto out_free;
@@ -2121,8 +2119,7 @@ int git_config_set_multivar_in_file_gently(const =
char *config_filename,
 		in_fd =3D -1;
=20
 		if (chmod(get_lock_file_path(lock), st.st_mode & 07777) < 0) {
-			error("chmod on %s failed: %s",
-			      get_lock_file_path(lock), strerror(errno));
+			error_errno("chmod on %s failed", get_lock_file_path(lock));
 			ret =3D CONFIG_NO_WRITE;
 			goto out_free;
 		}
@@ -2178,8 +2175,7 @@ int git_config_set_multivar_in_file_gently(const =
char *config_filename,
 	}
=20
 	if (commit_lock_file(lock) < 0) {
-		error("could not write config file %s: %s", config_filename,
-		      strerror(errno));
+		error_errno("could not write config file %s", config_filename);
 		ret =3D CONFIG_NO_WRITE;
 		lock =3D NULL;
 		goto out_free;
@@ -2330,8 +2326,8 @@ int git_config_rename_section_in_file(const char =
*config_filename,
 	fstat(fileno(config_file), &st);
=20
 	if (chmod(get_lock_file_path(lock), st.st_mode & 07777) < 0) {
-		ret =3D error("chmod on %s failed: %s",
-			    get_lock_file_path(lock), strerror(errno));
+		ret =3D error_errno("chmod on %s failed",
+				  get_lock_file_path(lock));
 		goto out;
 	}
=20
@@ -2385,8 +2381,8 @@ int git_config_rename_section_in_file(const char =
*config_filename,
 	fclose(config_file);
 unlock_and_out:
 	if (commit_lock_file(lock) < 0)
-		ret =3D error("could not write config file %s: %s",
-			    config_filename, strerror(errno));
+		ret =3D error_errno("could not write config file %s",
+				  config_filename);
 out:
 	free(filename_buf);
 	return ret;
--=20
2.8.0.rc0.210.gd302cd2
