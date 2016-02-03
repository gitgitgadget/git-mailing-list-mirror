From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/20] path.c: add git_common_path() and strbuf_git_common_path()
Date: Wed,  3 Feb 2016 16:35:33 +0700
Message-ID: <1454492150-10628-4-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:36:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtrL-00056C-Ji
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbcBCJgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:36:13 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35617 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbcBCJgL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:36:11 -0500
Received: by mail-pa0-f51.google.com with SMTP id ho8so10749042pac.2
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RxMMDY3ibe8L3OmtBLqh1mhDXTGunUI6X3XqDrukk/w=;
        b=BQA/5OCzS8uLWo6Vsh/HHcBCi0CdPU2IkX47crPyVFBVMY2cadzg9CL3elChL6qZgi
         uDMdTnyHZ0x+B9mKzv9YViz4PSEIDw0gHzKSY5v5Vgw8HXOHw6qiiCoLsAlcOe8GQ+XK
         wbe4h5pmaatUeb/iEYYKOSBGfjZtlp5dnUCHJ0imfyzfPrSRCuxxXCvoZnKD9YozuaWQ
         zI/DPFj5II99yaJP3ceBs5LJLXJzFNmW2SFlBv+nBZFg5gr3KiBMnUpi+ee35LvRq0gL
         /QmHaEo0RD4J48uPAdNj3nmskQt4aP47Ni/e6UXm0VO+mKHVnVNY0dD3cwJWNtFZN6ex
         k3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=RxMMDY3ibe8L3OmtBLqh1mhDXTGunUI6X3XqDrukk/w=;
        b=J9TDTI82BvuvIXVVwODeHlFnil/Z+xEFBcPWqUPhjJWNBRcNfM3/1EYiZx5yXSJSTp
         PYyiulrxVeEvfgFOoT4B68uVX4QyzWlseDB/eXVTMZ8JMagGzVoKyb/OArdc+0vcyaxH
         HDDIckAVdEtvYY8ZgBMwZF8nJ9H4HOASLCQmT6M7u6x6AIjKrp7M7ySS6Mqss9PXDEAC
         ZEjAwp1Jzt4FGUyiB7pQFwwHp0LJwxhWHdSIk3QveFNfvwkOzxRgGMCygV78lrTZexdV
         DSvremgLQJCTB2nZCiLeziZzvgz/eED9qSjvEAIsiJWd45yExK3TM2IpRqN0eRP53O/y
         pFFg==
X-Gm-Message-State: AG10YORFPX/kUxvZZyzx8yzJ9gYdiH7t+N+01AenJWqzNsr6t1F4aR66WruIYoWVkw6QFg==
X-Received: by 10.66.101.3 with SMTP id fc3mr769803pab.2.1454492170414;
        Wed, 03 Feb 2016 01:36:10 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 76sm8387740pft.44.2016.02.03.01.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:36:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:36:21 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285347>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |  3 +++
 path.c  | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/cache.h b/cache.h
index dfc459c..ec71181 100644
--- a/cache.h
+++ b/cache.h
@@ -747,11 +747,14 @@ extern int check_repository_format(void);
  */
 extern const char *mkpath(const char *fmt, ...) __attribute__((format =
(printf, 1, 2)));
 extern const char *git_path(const char *fmt, ...) __attribute__((forma=
t (printf, 1, 2)));
+extern const char *git_common_path(const char *fmt, ...) __attribute__=
((format (printf, 1, 2)));
=20
 extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
+extern void strbuf_git_common_path(struct strbuf *sb, const char *fmt,=
 ...)
+	__attribute__((format (printf, 2, 3)));
 extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 extern void strbuf_git_path_submodule(struct strbuf *sb, const char *p=
ath,
diff --git a/path.c b/path.c
index 3cd155e..08ff346 100644
--- a/path.c
+++ b/path.c
@@ -503,6 +503,35 @@ void strbuf_git_path_submodule(struct strbuf *buf,=
 const char *path,
 	va_end(args);
 }
=20
+static void do_git_common_path(struct strbuf *buf,
+			       const char *fmt,
+			       va_list args)
+{
+	strbuf_addstr(buf, get_git_common_dir());
+	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
+		strbuf_addch(buf, '/');
+	strbuf_vaddf(buf, fmt, args);
+	strbuf_cleanup_path(buf);
+}
+
+const char *git_common_path(const char *fmt, ...)
+{
+	struct strbuf *pathname =3D get_pathname();
+	va_list args;
+	va_start(args, fmt);
+	do_git_common_path(pathname, fmt, args);
+	va_end(args);
+	return pathname->buf;
+}
+
+void strbuf_git_common_path(struct strbuf *sb, const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	do_git_common_path(sb, fmt, args);
+	va_end(args);
+}
+
 int validate_headref(const char *path)
 {
 	struct stat st;
--=20
2.7.0.377.g4cd97dd
