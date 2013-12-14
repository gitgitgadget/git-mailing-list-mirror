From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 02/21] path.c: rename vsnpath() to git_vsnpath()
Date: Sat, 14 Dec 2013 17:54:48 +0700
Message-ID: <1387018507-21999-3-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:51:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmor-0000qe-G2
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab3LNKvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:51:32 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:51007 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab3LNKvV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:51:21 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so3596512pbc.21
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bNXIDep0rr7L1wjmWwnhkQ6g8j98zYvDPWf/oG6cbQg=;
        b=BVwkHw4BHJw3E7Gh5KYjyyCmD2Rg077+/d5K3qTZDXVLN57W6MDFFJSE6l25omRQjC
         Uwdce6mwR/T5LBslk3qYyXr9j8FXOGkY+lhBFAmYNVZ9m8UEM+febh0Op9/oaF1iW9J6
         ehFa4BH6YCHKwc935ewDPY57tDS5/1igSqB9e/RARJn0ySV4+5oPaCWdRZcaF4tIyj0S
         xkNCcql4WZ0RYtHnO0gIq6rfuDIHafjidDJxAJQKmf1R8vc7TZ/a5+NvH7TovH8MU9NU
         ep+cRkajMLqJu9ABsTpJ7pObBxDxI0drRXOfHblwpuxy05E3VE9qvqhB3EQmoISdeHVi
         uvmA==
X-Received: by 10.68.189.5 with SMTP id ge5mr8844889pbc.42.1387018281047;
        Sat, 14 Dec 2013 02:51:21 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id om6sm11388848pbc.43.2013.12.14.02.51.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:51:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:56:13 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239283>

This is the underlying implementation of git_path(), git_pathdup() and
git_snpath() which will prefix $GIT_DIR in the result string. Put git_
prefix in front of it to avoid the confusion that this is a generic
path handling function.#

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/path.c b/path.c
index 4c1c144..06863b7 100644
--- a/path.c
+++ b/path.c
@@ -50,7 +50,7 @@ char *mksnpath(char *buf, size_t n, const char *fmt, =
=2E..)
 	return cleanup_path(buf);
 }
=20
-static char *vsnpath(char *buf, size_t n, const char *fmt, va_list arg=
s)
+static char *git_vsnpath(char *buf, size_t n, const char *fmt, va_list=
 args)
 {
 	const char *git_dir =3D get_git_dir();
 	size_t len;
@@ -75,7 +75,7 @@ char *git_snpath(char *buf, size_t n, const char *fmt=
, ...)
 	char *ret;
 	va_list args;
 	va_start(args, fmt);
-	ret =3D vsnpath(buf, n, fmt, args);
+	ret =3D git_vsnpath(buf, n, fmt, args);
 	va_end(args);
 	return ret;
 }
@@ -85,7 +85,7 @@ char *git_pathdup(const char *fmt, ...)
 	char path[PATH_MAX], *ret;
 	va_list args;
 	va_start(args, fmt);
-	ret =3D vsnpath(path, sizeof(path), fmt, args);
+	ret =3D git_vsnpath(path, sizeof(path), fmt, args);
 	va_end(args);
 	return xstrdup(ret);
 }
@@ -128,7 +128,7 @@ char *git_path(const char *fmt, ...)
 	char *ret;
=20
 	va_start(args, fmt);
-	ret =3D vsnpath(pathname, len, fmt, args);
+	ret =3D git_vsnpath(pathname, len, fmt, args);
 	va_end(args);
 	return ret;
 }
--=20
1.8.5.1.77.g42c48fa
