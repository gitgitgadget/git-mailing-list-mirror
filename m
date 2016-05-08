From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 40/41] vcs-svn: use error_errno()
Date: Sun,  8 May 2016 16:48:00 +0700
Message-ID: <1462700881-25108-41-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:54:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLOF-0003ai-Lk
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbcEHJwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:52:39 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32991 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbcEHJwi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:52:38 -0400
Received: by mail-pa0-f66.google.com with SMTP id gh9so13698137pac.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wLZ2g7Vvl8XEXPTkq0kZVRVXHInPczRJGbkgSvTvEpI=;
        b=zqULnL1t9Vqxpj6NkwnX7NsE5JiU6ioM9+OwMkBaXjdC+uWq7ZsCwdNkYFx7ilMOyD
         vmulYs1hBjNsiZWZg/7VgToW/HAnRffbXfaeOv5oceKlpQiGKqUc5xg2gXIj6c23WFJW
         mL0kjalBcVF4+j7c15Mhha2IeQgxEuuehFoIe7Po0c9Hf9RR1pQBItwByjEBQrY9s5oG
         8dIi+jjbUgAoRGwm+9xe7y/cPMPL4pofOstRpnmy/dA9/F72nGLFbYXvU4+BuAANolCD
         bdLk0C/oaTvbqA/UF3CMUfFP1iYticCF6IGotcharBP8+LiSERBVv9zdW3rvE3Re24OK
         jtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLZ2g7Vvl8XEXPTkq0kZVRVXHInPczRJGbkgSvTvEpI=;
        b=Qu9aavaKJ1xPWXaLcPWaA7b6qTfKx5C1GjtPSr8oCgEEc8QSvtOU69H7AK8H6j1hOD
         7rOR35WUTi57U+CA6gPOcowRm5pdECF+ZxuV7Q2EJ9XTZ5QtFXlCPlpoC7LeYln3DRs2
         hidI5bDfnk4k7iwkoBPu1SwovewQavyOYgPLzwMDTMjkYFXiDDoLCjNvAkpRNbQc/CYX
         7L7QX5L4MjSrRJYxQV1tGJZcKlUhaH6YGPA+IVWylNAE127+S6pOGZ7eG9ClH67zC64c
         gVjKtsssprLiJGRjfCH33mEb3eVPrKy9i//99eEDzvyf6v9dPDbCVjezSFQMYQD2T+QY
         /+pA==
X-Gm-Message-State: AOPr4FX61yHfJBDLS8oTZiq4avUQ/OoW4ndVrZv2bJFhwBI15ioxtzWZRN1EW6eCNtYj+g==
X-Received: by 10.66.142.73 with SMTP id ru9mr41799632pab.51.1462701158411;
        Sun, 08 May 2016 02:52:38 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id lq10sm32847498pab.36.2016.05.08.02.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:52:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:52:38 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293954>

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
