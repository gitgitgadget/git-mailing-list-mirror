From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 18/41] config.c: use error_errno()
Date: Sun,  8 May 2016 16:47:38 +0700
Message-ID: <1462700881-25108-19-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:52:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLM5-0001Au-CR
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbcEHJuW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:50:22 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35564 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcEHJuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:50:21 -0400
Received: by mail-pa0-f65.google.com with SMTP id zy2so16126366pac.2
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8lAtbkOkmTPBTZ3FX1NRx5i78FZmxgFryOCCy2Ocmk=;
        b=sF+ncxaTT6P33Fdgper465133nZHCU/vGB0NseZheFyAXGLBOGWvAReWuXslumYnwv
         b/h5x5Jp+iy6ZO3cDW8LqMmaaLCPfTdo4AW2TfpenITZiHkP5oEJGfvRFCO9FEAhc6I5
         ndGvERYvnXOK1TNKbs5pIi/r0yzvHINwIk8sY8V41lmCyj/f1CZsmkZ06K1ULwk3FhdV
         sJr61Hlvvm7emC9BbsrFNpsQRf1UH8tP6jCA4R/dkmk/Gzu7KN7IR2vzLOrhpA5E65F9
         j1yRs8IcZi70xO9AJAau34IAFPSUZzbVvrolju4byPXbswiyxpJWPgsTqOVwx0H+4lR5
         nAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8lAtbkOkmTPBTZ3FX1NRx5i78FZmxgFryOCCy2Ocmk=;
        b=l5pL28Y8vJxLWSsLQqOy/skniFM4xyab3HGh7xfuNIvKDhmd+LubM1lm6AnuTd5oRx
         rROrKyS7Dk3jR6SMuM6Mj8k+Ukf4Q8Ui36COXzMCSFKAmgczLAsaDPLqCC7A2Jq0GKz2
         G6pwDBAOzhRbjWdiwmActk0AKjwQv+XVkgKvzGoC8Z58mf/q3fWMvGiCQFB66UvP2Kg8
         pPzGo1FrQOZwenJX9xIw0ElhvvygD4xhGgEc/85d8Q4BBvestxtYDm5wPfGSiCFF8UTx
         EzQLd/nHcBWPjDLKOEF02HjZS8kOanrKKUmODjJ74fpZ1plgLdwog2Wh2IkptFJ4Z6VK
         rNGg==
X-Gm-Message-State: AOPr4FUY3M/DmjpDyyeqPrpefOnMhzXK6I/bHygmOLdu7HodcKrbht6uQ8yVfM4LvI/XaA==
X-Received: by 10.66.26.43 with SMTP id i11mr42185707pag.58.1462701020436;
        Sun, 08 May 2016 02:50:20 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id c2sm32742130pfc.40.2016.05.08.02.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:50:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:50:20 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293936>

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
