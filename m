From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/32] Add $GIT_DIR/narrow check
Date: Wed, 25 Aug 2010 08:19:58 +1000
Message-ID: <1282688422-7738-9-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:22:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1sw-0001Xh-Tt
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327Ab0HXWVw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:21:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43052 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305Ab0HXWVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:21:49 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so50255pwi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=o0SakW99sZhIGD1OFB4HrsiMY15SUzXvCeReKEZ684g=;
        b=oZxvK0sWFYpAIHoFL+u2TQslQ9SDQ+ABD2M7YGgrs1O/ZLvwUo+bGb7V+lv2MBagc8
         26w8ROHLB5VxP5fQ46X1N+jFdtZcqrWhmAoW0tJSAsD43P7u0GKpA3J2fpE3b36OSKHk
         dHv12as1iXRqRw5ZS1pF5aBP6BP600MzoiE0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lefQ9bMPUFC8nWL1lN9Z1EkPFtJMJ2zlGBqt84wtnGI+GVElsKvDD/M0HZpuGnnDYj
         NOBAdE36zeiKyo06AkPV6Uzj3Ty1DfLcWPeLJsb+3E+PyWnyhLE4BugiybpcuHDIkuq+
         6yN0gss0YJ9fTXjN5vEAaYDtabnrs4hN8uqds=
Received: by 10.142.44.14 with SMTP id r14mr6359443wfr.76.1282688509435;
        Tue, 24 Aug 2010 15:21:49 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id z1sm643308wfd.3.2010.08.24.15.21.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:21:48 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:21:43 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154348>

This file contains the narrow prefix. With get_narrow_prefix() being
non-empty behavior of git may be totally different.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile      |    2 ++
 cache.h       |    3 +++
 environment.c |    2 ++
 narrow-tree.c |   31 +++++++++++++++++++++++++++++++
 narrow-tree.h |    1 +
 5 files changed, 39 insertions(+), 0 deletions(-)
 create mode 100644 narrow-tree.c
 create mode 100644 narrow-tree.h

diff --git a/Makefile b/Makefile
index 1f11618..54c435e 100644
--- a/Makefile
+++ b/Makefile
@@ -525,6 +525,7 @@ LIB_H +=3D sigchain.h
 LIB_H +=3D strbuf.h
 LIB_H +=3D string-list.h
 LIB_H +=3D submodule.h
+LIB_H +=3D narrow-tree.h
 LIB_H +=3D tag.h
 LIB_H +=3D transport.h
 LIB_H +=3D tree.h
@@ -629,6 +630,7 @@ LIB_OBJS +=3D sigchain.o
 LIB_OBJS +=3D strbuf.o
 LIB_OBJS +=3D string-list.o
 LIB_OBJS +=3D submodule.o
+LIB_OBJS +=3D narrow-tree.o
 LIB_OBJS +=3D symlinks.o
 LIB_OBJS +=3D tag.o
 LIB_OBJS +=3D trace.o
diff --git a/cache.h b/cache.h
index 37ef9d8..ff401ec 100644
--- a/cache.h
+++ b/cache.h
@@ -1101,4 +1101,7 @@ int split_cmdline(char *cmdline, const char ***ar=
gv);
 /* builtin/merge.c */
 int checkout_fast_forward(const unsigned char *from, const unsigned ch=
ar *to);
=20
+/* narrow-tree.c */
+extern const char *get_narrow_prefix();
+
 #endif /* CACHE_H */
diff --git a/environment.c b/environment.c
index 83d38d3..41fcbd4 100644
--- a/environment.c
+++ b/environment.c
@@ -8,6 +8,7 @@
  * are.
  */
 #include "cache.h"
+#include "narrow-tree.h"
=20
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
@@ -105,6 +106,7 @@ static void setup_git_env(void)
 		git_graft_file =3D git_pathdup("info/grafts");
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		read_replace_refs =3D 0;
+	check_narrow_prefix();
 }
=20
 int is_bare_repository(void)
diff --git a/narrow-tree.c b/narrow-tree.c
new file mode 100644
index 0000000..46e913d
--- /dev/null
+++ b/narrow-tree.c
@@ -0,0 +1,31 @@
+#include "cache.h"
+#include "narrow-tree.h"
+
+static const char *narrow_prefix;
+
+int check_narrow_prefix()
+{
+	int fd;
+	static char buf[PATH_MAX];
+	int ret;
+
+	fd =3D open(git_path("narrow"), O_RDONLY);
+	if (fd =3D=3D -1)
+		return 0;
+
+	ret =3D read(fd, buf, PATH_MAX);
+	if (ret > 0) {
+		/* $GIT_DIR/narrow is not meant for manual editing, anyway.. */
+		while (ret && buf[ret-1] =3D=3D '\n')
+			ret--;
+		buf[ret] =3D '\0';
+		narrow_prefix =3D buf;
+	}
+	close(fd);
+	return 0;
+}
+
+const char *get_narrow_prefix()
+{
+	return narrow_prefix;
+}
diff --git a/narrow-tree.h b/narrow-tree.h
new file mode 100644
index 0000000..aa8c94f
--- /dev/null
+++ b/narrow-tree.h
@@ -0,0 +1 @@
+extern int check_narrow_prefix();
--=20
1.7.1.rc1.69.g24c2f7
