From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 40/41] vcs-svn: use error_errno()
Date: Sun,  1 May 2016 18:14:56 +0700
Message-ID: <1462101297-8610-41-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:18:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpOq-0008Ou-HF
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbcEALSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:18:52 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33499 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbcEALSv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:18:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id e190so18858214pfe.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wLZ2g7Vvl8XEXPTkq0kZVRVXHInPczRJGbkgSvTvEpI=;
        b=gNI4ymD2/AZV994kme6+lrbhKCdStT5cKr/mylDhfMLGxtc631noS8YWN1foDEBg/a
         Wj1WtXbupSPjhe08W/SLGEPgtEjYsjkAvfEoIyTyBkCyppc6+HYqaaJTqacAlFRkhuf9
         0o3XUtgnHU6FvAGxCHzLMFM297CyaJhtcL9Uq3ZVI7yhOSI4i5uHrAXQAKRMNlJUTA3U
         bHEQK8X3rTqPzLMYxbIoJDU3P21rJIBh3snSZqprCk/GQXtxSCBJXvvubBBGeXrw8VxD
         gRIRpDvdmbtnxe6eo7KLl9gjHFVPkFsiyDbpW51mK7h6bzJ317+0USBnjsu8+78QDLdt
         IREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLZ2g7Vvl8XEXPTkq0kZVRVXHInPczRJGbkgSvTvEpI=;
        b=P+sS33zxe69DdXg2ZS3dHcRZhmm3Z3shKXEn2AoSjNsINjOrQACc2y6AJKB3jE9KWu
         MJQbbuq7yJTrSpzv1rSNfYN115BGiRVwWma4bov3pjQQi6jLjpZq9NmQV341LpPPt3rJ
         qMjukHViEn1zu3k5YGnPDM+XP7qwJxdAhgZCBHT+oI7JN6mWHMy3ZDDtwU2OGCj2A6gF
         HN7vqIkJ9pcaxp6NaTqaT3FF4oz2I6TT/DExRXaV92CHjg/8BJU/IeVq0IBQRJvmDCoj
         6I9GV7zMLbUoGUO0CPfn5ZocmSJ+4t74BzuAFBq1FLnOM8r62lUijd9klF3eRH94+v4C
         4wMg==
X-Gm-Message-State: AOPr4FUqN5G5XOSACqU4Ampt32Mwn10dbQHlJ/Q4rLmrrUX+j2unPq7skAUpdWVfFonKnw==
X-Received: by 10.98.38.66 with SMTP id m63mr42914389pfm.57.1462101531209;
        Sun, 01 May 2016 04:18:51 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id qm10sm37311697pac.33.2016.05.01.04.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:18:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:18:46 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293190>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 vcs-svn/line_buffer.c    | 4 ++--
 vcs-svn/sliding_window.c | 2 +-
 vcs-svn/svndiff.c        | 4 ++--
 vcs-svn/svndump.c        | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 57cc1ce..e416caf 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -53,9 +53,9 @@ long buffer_tmpfile_prepare_to_read(struct line_buffe=
r *buf)
 {
 	long pos =3D ftell(buf->infile);
 	if (pos < 0)
-		return error("ftell error: %s", strerror(errno));
+		return error_errno("ftell error");
 	if (fseek(buf->infile, 0, SEEK_SET))
-		return error("seek error: %s", strerror(errno));
+		return error_errno("seek error");
 	return pos;
 }
=20
diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
index f11d490..06d273c 100644
--- a/vcs-svn/sliding_window.c
+++ b/vcs-svn/sliding_window.c
@@ -12,7 +12,7 @@ static int input_error(struct line_buffer *file)
 {
 	if (!buffer_ferror(file))
 		return error("delta preimage ends early");
-	return error("cannot read delta preimage: %s", strerror(errno));
+	return error_errno("cannot read delta preimage");
 }
=20
 static int skip_or_whine(struct line_buffer *file, off_t gap)
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 74c97c4..75c7531 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -64,13 +64,13 @@ static int write_strbuf(struct strbuf *sb, FILE *ou=
t)
 {
 	if (fwrite(sb->buf, 1, sb->len, out) =3D=3D sb->len)	/* Success. */
 		return 0;
-	return error("cannot write delta postimage: %s", strerror(errno));
+	return error_errno("cannot write delta postimage");
 }
=20
 static int error_short_read(struct line_buffer *input)
 {
 	if (buffer_ferror(input))
-		return error("error reading delta: %s", strerror(errno));
+		return error_errno("error reading delta");
 	return error("invalid delta: unexpected end of file");
 }
=20
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 31d1d83..e4b3959 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -501,7 +501,7 @@ static void init(int report_fd)
 int svndump_init(const char *filename)
 {
 	if (buffer_init(&input, filename))
-		return error("cannot open %s: %s", filename ? filename : "NULL", str=
error(errno));
+		return error_errno("cannot open %s", filename ? filename : "NULL");
 	init(REPORT_FILENO);
 	return 0;
 }
@@ -509,7 +509,7 @@ int svndump_init(const char *filename)
 int svndump_init_fd(int in_fd, int back_fd)
 {
 	if(buffer_fdinit(&input, xdup(in_fd)))
-		return error("cannot open fd %d: %s", in_fd, strerror(errno));
+		return error_errno("cannot open fd %d", in_fd);
 	init(xdup(back_fd));
 	return 0;
 }
--=20
2.8.0.rc0.210.gd302cd2
