From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/41] config.c: use error_errno()
Date: Sun,  1 May 2016 18:14:34 +0700
Message-ID: <1462101297-8610-19-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:16:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpMu-0007Lv-K2
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbcEALQx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:16:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33071 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALQw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:16:52 -0400
Received: by mail-pf0-f194.google.com with SMTP id e190so18855921pfe.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8lAtbkOkmTPBTZ3FX1NRx5i78FZmxgFryOCCy2Ocmk=;
        b=OzwRsTmCcB7n6v48Ny2pGZO7y95XiNJNCADUEeAaAkpJHizH+drblAXBwnUkh9L/NB
         paUOI1D77dPwyDveHT1arg2a07u2auBIKMFXBESKQAeW3WNYGc0wx/1FJtqH5cbhWPYn
         0X77+uxBpkXpV+7MieNWFOZk5g418zL9iP2kIApUu1kbaC17jp2D8LeKIpUmDy71IhGE
         4SarCwazolvdB1MU1FOtkdmAPiIZ9lNtrxUUdPa5avbqcB5AynSEV+KXiG24zPjbHiSh
         JThjRZDVeVkXuQDz0fnMgT9NbTWuAx7j4SfHOYcwAzvd/P49Cc+iP5FCY77w57ChvfBE
         oR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8lAtbkOkmTPBTZ3FX1NRx5i78FZmxgFryOCCy2Ocmk=;
        b=XNAAAzSc9BfEr35JM9Xjb+slfHuXhiKuGUz1nCHqU56FLZFKFsbZOJ+fQojyCOc7Vo
         NvqR3jAGXQGTCwHvjEmVJqBEdRg6Y6QPkNpWYW1d/QFH45/oaPSawyYU/qoNO3gYL4Hi
         LwCNeemAOBMwDPdgFT2mL290/KIY7wDNUI+6s8VTau9S/mBxt3Ak2T58BTck866Q14Zn
         nyzn+AotZJDKQo9ixXG99Jv+EjFDxgApvqlqNCee+pKhK9NW28tSuZe7vfZ9me2Zw5D/
         CYo1YzDNJcuxXyh4zKksD+w0/VxP2VTVUHazvKUlWNiVaHtX4Gb7TZ+n4in7EQ5xWW1L
         V+8w==
X-Gm-Message-State: AOPr4FWgF76BhaoJ9TJ6N2CN3zckID6c4TawIZh5/5si54pFjDQ3dVXB5IqDD7Ziqi9qZA==
X-Received: by 10.98.91.3 with SMTP id p3mr43394704pfb.64.1462101411986;
        Sun, 01 May 2016 04:16:51 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id d184sm17220454pfc.27.2016.05.01.04.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:16:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:16:46 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293168>

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
