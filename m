From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/7] path.c: add git_common_path() and strbuf_git_common_path()
Date: Sun, 17 Apr 2016 19:59:19 +0700
Message-ID: <1460897965-486-2-git-send-email-pclouds@gmail.com>
References: <CACsJy8BOwzJSmS3PPeeRuaRwq=+kYLH8NX0i7P_wfDW9gLt6bA@mail.gmail.com>
 <1460897965-486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 15:00:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1armIz-00077f-4A
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 15:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbcDQM74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2016 08:59:56 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36620 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbcDQM7z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 08:59:55 -0400
Received: by mail-pa0-f68.google.com with SMTP id i5so82269pag.3
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKY2947agBC15nsjrXuvCOH0PwsY2VuRaiR6MK79+hM=;
        b=xmVcgFJTV6w93a9uHyzXSLi9j6PzriedxHIptz3sQ0TzWcY3uuuilyPtRV2Kp+5sr/
         5pZ8v2QcXLkTLhJNCDXU1Y1a0iBBH+S1LP7bk6PfEdP8wJ9pjksWHS3mZ75gbNYQv6TF
         EOxTyL0/QawDPJeuT+UGzI9SNT3+S0G3zHE9i6ge8rsGQj2kLfi4cv19ak8roYTw0O96
         rr5ZoCE6C3IDHfyo0YHvr+OmsDBOIElDrZnIuVNSAYiaXC228hUiTsPhziFcW9oONbun
         uI/wq7vxaBGTG7+UQj6DeDI6biaEwUcNmbc2PGSXgM9w72yB5xP/tns04gyYRV2WaVDQ
         EJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKY2947agBC15nsjrXuvCOH0PwsY2VuRaiR6MK79+hM=;
        b=cfixrdurmCJMJ6l39L+AbBt2QmaKHHjyQh3GSwKPVShDDFjA9fEzsEDqD2/3HwANnr
         i3i8OhaXxy3IDj8FGYxfbHMzsLIE7mlp5mjB8Uq+v0LCA7PebDmlGvxa0HOAWPe9wmHj
         Kla0ULInN28C+z6yBEuEtyieyt8LBKzdczDydP3wh8OJs2+sP5ioostyS7AndiRQmb+d
         TvzwqtcHnBNd0n8/Gjy7PNjgeFvKpEPl5kAtKwEI/CLtxd29sVIlVcajPE18lxJJ62Kj
         f4IuhYmtvB16rwuLi77bpt4MB6/10l/4YWRbBwyi1nzuxx1riVNFbKxoNUrDAmz3mzhl
         yQhg==
X-Gm-Message-State: AOPr4FXDpFwn0qLTeqwQwYWAlPRdiz/YUwN2+RCCNGiXgMCSRZlbi/+ZSDvodbAwwbBkTg==
X-Received: by 10.66.121.97 with SMTP id lj1mr42401495pab.51.1460897995084;
        Sun, 17 Apr 2016 05:59:55 -0700 (PDT)
Received: from lanh ([171.232.186.84])
        by smtp.gmail.com with ESMTPSA id p78sm17238418pfa.75.2016.04.17.05.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 05:59:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 17 Apr 2016 20:00:03 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460897965-486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291751>

These are mostly convenient functions to reduce code duplication. Most
of the time, we should be able to get by with git_path() which handles
$GIT_COMMON_DIR internally. However there are a few cases where we need
to construct paths manually, for example some paths from a specific
worktree. These functions will enable that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |  3 +++
 path.c  | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/cache.h b/cache.h
index 2711048..c04a17f 100644
--- a/cache.h
+++ b/cache.h
@@ -799,11 +799,14 @@ extern void check_repository_format(void);
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
index bbaea5a..2ebb23d 100644
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
2.8.0.rc0.210.gd302cd2
