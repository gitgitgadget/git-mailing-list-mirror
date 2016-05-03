From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 40/41] vcs-svn: use error_errno()
Date: Tue,  3 May 2016 19:04:13 +0700
Message-ID: <1462277054-5943-41-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:10:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ9p-0001Zw-QV
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933211AbcECMKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:10:23 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33470 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930AbcECMKV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:10:21 -0400
Received: by mail-pa0-f50.google.com with SMTP id xk12so9008531pac.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wLZ2g7Vvl8XEXPTkq0kZVRVXHInPczRJGbkgSvTvEpI=;
        b=Lew23Htmr6p8fW71nbcgVhXYo61vdaGLTaEyxqolDne3UCLYXQJ7akSWG+BiFq3zNL
         a5JGnp38HC5DF0RQ1vfFLGtYyIu7cnrT6S4hg0aB6TxRrbLPuSONBYnUsC4JYhIC6OOH
         CRo5R9Xo2XM8QmhTZ/H3yr2M9ZP9vDJdPELQpu+mUaYbFUPQxs71PFAh6K+NXFtzzGKX
         qk4JTZDhjsKNAA+2WYwgdvEE3xgZb9xGzFD7ofKNsqUJVSGOqUCC5HeP5lhmK3mBtNa8
         XU4xH5DcMa+l5xDljN3W2z23UDUO5vI6FQ9agrMSbttH53+/5LQQwuNXDnjdXr8ImmFP
         pZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLZ2g7Vvl8XEXPTkq0kZVRVXHInPczRJGbkgSvTvEpI=;
        b=dcFB+xj71ahlxjSxmfcwtlxa3x7lahnRoLUg2n3ddmTp7mp5ptDslvOOghvwu6rsx8
         lH+ZUwyz20FGIqpGcLqD3GrI0UtEsdZURDNf6iMrtzaiRwM7UiVWpaWuCuNDEjTCwJdg
         AqZTzOLQgbztKQwwIqfAbB+3sARMIYs2TWE7FwXgxR+A6gyKN7WmpDqWflazA+7iYikQ
         sfvAHVq5KpdOvgKf0el9zzyzD+Oui2Da8djdWpGhS0rC8/OGB0ys97IyaghBeMHqf2Qo
         nhyKKcv9tdgRFdr2U8Vc+Cjxd3egMFOuY9NHE6W9YyKOiXmc1s4VbBbzwv783sor9Gxa
         QDPw==
X-Gm-Message-State: AOPr4FVO8Xv3J8y+LoCwGV7yhBZtCJvH052l7iXARHE41sXvepI5JkyBsxVVuLZi2v+cIg==
X-Received: by 10.66.175.110 with SMTP id bz14mr2917177pac.41.1462277420565;
        Tue, 03 May 2016 05:10:20 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id k78sm5505899pfk.70.2016.05.03.05.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:10:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:10:16 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293393>

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
