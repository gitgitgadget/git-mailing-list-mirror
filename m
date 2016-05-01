From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/41] rerere.c: use error_errno() and warning_errno()
Date: Sun,  1 May 2016 18:14:48 +0700
Message-ID: <1462101297-8610-33-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:18:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpOA-00082Y-TS
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbcEALSK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:18:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35304 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbcEALSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:18:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id r187so19012115pfr.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58ErpoAVMLSuG4Zu8bRhgSvY8+jH+m9A+GB4WeCWkiQ=;
        b=IYUm3lcwvNV1sVss6DAusPvvNS5FiDMeIovN5yecc+DdbkK3ty30Q7bMBAYbki0Gjj
         T1jVMIgv5uiPyLEsLlO145mnJFUan7jWwYtw7WMyIZWYMYuw5I4WSBm7bymdlZZVHXKv
         +C4vczhcSGcQmnHZAodWMpRWuB/Hdn6cAa1YhWqsf7ti0XDeDSesZdhyD16QeUR9YhMR
         rNYfURKLaM+d5iZYPpY8KK9cE37u7gqoDkvQGnMcCJJh1OyRkEorha34iGWz6vEVEFls
         A4kucDVY+/4u7BMuekSeubhHh3skNRhU5YorQe3Xbv/bk3vQJWbhM7f1Fr4CKr6c7l20
         3U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58ErpoAVMLSuG4Zu8bRhgSvY8+jH+m9A+GB4WeCWkiQ=;
        b=XdeG+Wk3ZzgYWjs35+mtf6xb6Jop0yDZmRf1FCSJvvCAIl2mMv1+YOwMM9Bi0T6kux
         qpidCbWiU10fTDSIfVlsw48dMgfc1vY5YKpIjM5oEdiX9r0GXrxtUjhIrDqOJEFtC7UI
         XatzABGtLtXtWE0YzXOKUs6v9evTW7uVuJFae79WXBJXNJRR/9dnuAuIS2W2XzPb8TjQ
         u2HfRYaZRGofOs5beh/P+HyCqLqLQN2JlHMvAarJVaRdeDC4q6QfwwQpjllrgVD9Frud
         NO0fFsW7/oHo3ILvdlv+0Oui6tewmkMt3rKHCvGTV0dmXb28T2zndRiVE3iFlOPkBuDG
         7sEw==
X-Gm-Message-State: AOPr4FXEr4hzN9eNB0jr3vrwYoeATKiJRe+kB0C597sw8FGUM6Y+S0uu73RPjP95V5TBNg==
X-Received: by 10.98.100.77 with SMTP id y74mr43377503pfb.101.1462101488404;
        Sun, 01 May 2016 04:18:08 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id r191sm37086945pfr.36.2016.05.01.04.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:18:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:18:03 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293182>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 rerere.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/rerere.c b/rerere.c
index c8b9f40..1810c04 100644
--- a/rerere.c
+++ b/rerere.c
@@ -501,8 +501,7 @@ static int handle_file(const char *path, unsigned c=
har *sha1, const char *output
 		error("There were errors while writing %s (%s)",
 		      path, strerror(io.io.wrerror));
 	if (io.io.output && fclose(io.io.output))
-		io.io.wrerror =3D error("Failed to flush %s: %s",
-				      path, strerror(errno));
+		io.io.wrerror =3D error_errno("Failed to flush %s", path);
=20
 	if (hunk_no < 0) {
 		if (output)
@@ -684,20 +683,17 @@ static int merge(const struct rerere_id *id, cons=
t char *path)
 	 * Mark that "postimage" was used to help gc.
 	 */
 	if (utime(rerere_path(id, "postimage"), NULL) < 0)
-		warning("failed utime() on %s: %s",
-			rerere_path(id, "postimage"),
-			strerror(errno));
+		warning_errno("failed utime() on %s",
+			      rerere_path(id, "postimage"));
=20
 	/* Update "path" with the resolution */
 	f =3D fopen(path, "w");
 	if (!f)
-		return error("Could not open %s: %s", path,
-			     strerror(errno));
+		return error_errno("Could not open %s", path);
 	if (fwrite(result.ptr, result.size, 1, f) !=3D 1)
-		error("Could not write %s: %s", path, strerror(errno));
+		error_errno("Could not write %s", path);
 	if (fclose(f))
-		return error("Writing %s failed: %s", path,
-			     strerror(errno));
+		return error_errno("Writing %s failed", path);
=20
 out:
 	free(cur.ptr);
@@ -1071,7 +1067,7 @@ static int rerere_forget_one_path(const char *pat=
h, struct string_list *rr)
 	if (unlink(filename))
 		return (errno =3D=3D ENOENT
 			? error("no remembered resolution for %s", path)
-			: error("cannot unlink %s: %s", filename, strerror(errno)));
+			: error_errno("cannot unlink %s", filename));
=20
 	/*
 	 * Update the preimage so that the user can resolve the
--=20
2.8.0.rc0.210.gd302cd2
