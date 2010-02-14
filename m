From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/5] Move offset_1st_component() to path.c
Date: Sun, 14 Feb 2010 22:44:43 +0700
Message-ID: <1266162285-10955-3-git-send-email-pclouds@gmail.com>
References: <1266162285-10955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 16:55:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nggp1-0005BD-8V
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 16:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab0BNPzl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 10:55:41 -0500
Received: from mail-px0-f191.google.com ([209.85.216.191]:41102 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab0BNPzk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 10:55:40 -0500
Received: by mail-px0-f191.google.com with SMTP id 29so539920pxi.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 07:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Oik6LXssMpNGm83KYMcTS3yU8V+cyJb+2HfuOb8/p/Y=;
        b=kCmYUA8Sn1oehooQ6u2hTmHMX7GVd/OyRhEZzjosaHlddcAjT4jY0JdVMCEC+Rqr/w
         4/yaZthMP3PablY3e6V66zl+pqE+WJkVPy672Vgq69O1y7q0mA0cBQsmd6VbBZ5QwoDo
         gSIgB2eHA/M4wePMXJhKxCvJfgoGkzRO31vGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eNGLGpIwMWeF3mHi9XiIkrWMZ39uEVT0tOvjmo72FMlDL6v5IagbgBp/MM1K0yxCK8
         CaHRg0GrPaCVvIQIBnuh7l35RgN+CwhI/QgBZNhsBptlEZKvzsct8Vl8XFxIschS77ad
         UK3mK3cs0q7I7hwAfS+2M4sivHtzV+nCvEMVc=
Received: by 10.114.189.18 with SMTP id m18mr2668111waf.216.1266162457388;
        Sun, 14 Feb 2010 07:47:37 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.243.56])
        by mx.google.com with ESMTPS id 21sm397134pzk.3.2010.02.14.07.47.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 07:47:36 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Feb 2010 22:44:57 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266162285-10955-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139915>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     |    1 +
 path.c      |    7 +++++++
 sha1_file.c |    7 -------
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index d478eff..ff23cd1 100644
--- a/cache.h
+++ b/cache.h
@@ -675,6 +675,7 @@ int normalize_path_copy(char *dst, const char *src)=
;
 int longest_ancestor_length(const char *path, const char *prefix_list)=
;
 char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
+int offset_1st_component(const char *path);
=20
 /* Read and unpack a sha1 file into memory, write memory to a sha1 fil=
e */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index 0005df3..fd70e88 100644
--- a/path.c
+++ b/path.c
@@ -649,3 +649,10 @@ int daemon_avoid_alias(const char *p)
 		}
 	}
 }
+
+int offset_1st_component(const char *path)
+{
+	if (has_dos_drive_prefix(path))
+		return 2 + (path[2] =3D=3D '/');
+	return *path =3D=3D '/';
+}
diff --git a/sha1_file.c b/sha1_file.c
index 657825e..52052b9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -35,13 +35,6 @@ static size_t sz_fmt(size_t s) { return s; }
=20
 const unsigned char null_sha1[20];
=20
-static inline int offset_1st_component(const char *path)
-{
-	if (has_dos_drive_prefix(path))
-		return 2 + (path[2] =3D=3D '/');
-	return *path =3D=3D '/';
-}
-
 int safe_create_leading_directories(char *path)
 {
 	char *pos =3D path + offset_1st_component(path);
--=20
1.7.0.195.g637a2
