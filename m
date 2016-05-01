From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/41] usage.c: add warning_errno() and error_errno()
Date: Sun,  1 May 2016 18:14:18 +0700
Message-ID: <1462101297-8610-3-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:15:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpLW-0006dd-0V
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbcEALP0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:15:26 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33263 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbcEALPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:15:25 -0400
Received: by mail-pa0-f66.google.com with SMTP id vv3so18834114pab.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuVh7A7yZKFE86SLKVdP7OsOaJ4YjMFW4wgFe1ZCUCg=;
        b=qZGuv5HP+t2/cls917B8CgbZuYQEJF2rxO3/728I8ZJcg9E3CyB8WFJJ43G3ye5i61
         fEFxObpRFsiSZC7mrUqHs/8xqsn7pXdESQx6Zkummq3ZIB7kQiy7HAAKcqb2v45aNJYn
         WiohTq7vCVI4ZybL2FavoAMioOfGK5YyeNAD7h4mwj+jk+YqRNlcQYNiJBZSzkO9XT8Q
         +oC9hI8XLc8BA362R+gILirWQW8tjpklctO3ftzVfeDDPn94VkIj25avgqGouOtopQ1g
         ui6tYD2hQXugDuxy4Bbnm0MAKw8CqT+cHrY6hjqznv5kT7IB2MolmxAndWt3f0WLymKJ
         a1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cuVh7A7yZKFE86SLKVdP7OsOaJ4YjMFW4wgFe1ZCUCg=;
        b=AEtfysQFW+lJnEPuRszspRj97VXXsjaEerlJSRtFE6kpVsjrJSgTt+H9DbXCJdysLg
         AWmmZt6oqpfyOnBLsQxK47jcd2HXXLqLs4hW5yXoeZXtHwIqwGPfeAF//M7GpJ2qyTVO
         gfl9HTCsvO5RWlTzkDgiWXsbAU3zQbo7rqHV5wV8pP7X7uMz/5KFPqjRptyCyo+gjIO8
         YCa63T6QLz4nlOYVMJ+AiQRyYFxTLlJzo89re1AJtgZvvO8CC8YoFrYOOs/4X+Q5ydQr
         k1xNEkq5/xgtgXWKBWs2Owz4E6z0ZtvT0K1+KXCs4VYBBFQawDvwv4PjCiMvkK5QOm+W
         KaBw==
X-Gm-Message-State: AOPr4FXAaJ6hTBMyL16M4BAmUxylJLkxlEq75rZvgtsFcKTH0q1rsDE6mR3eMa3zHY0oOw==
X-Received: by 10.66.78.73 with SMTP id z9mr42798527paw.4.1462101324322;
        Sun, 01 May 2016 04:15:24 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id b27sm37032591pfc.74.2016.05.01.04.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:15:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:15:19 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293152>

Similar to die_errno(), these functions will append strerror()
automatically.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-compat-util.h |  2 ++
 usage.c           | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 1f8b5f3..49d4029 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -409,7 +409,9 @@ extern NORETURN void usagef(const char *err, ...) _=
_attribute__((format (printf,
 extern NORETURN void die(const char *err, ...) __attribute__((format (=
printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((fo=
rmat (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, =
1, 2)));
+extern int error_errno(const char *err, ...) __attribute__((format (pr=
intf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (print=
f, 1, 2)));
+extern void warning_errno(const char *err, ...) __attribute__((format =
(printf, 1, 2)));
=20
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
diff --git a/usage.c b/usage.c
index 0dba0c5..af1b7d1 100644
--- a/usage.c
+++ b/usage.c
@@ -148,6 +148,16 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
=20
+int error_errno(const char *fmt, ...)
+{
+	va_list params;
+
+	va_start(params, fmt);
+	error_routine(fmt_with_err(fmt), params);
+	va_end(params);
+	return -1;
+}
+
 #undef error
 int error(const char *err, ...)
 {
@@ -159,6 +169,15 @@ int error(const char *err, ...)
 	return -1;
 }
=20
+void warning_errno(const char *warn, ...)
+{
+	va_list params;
+
+	va_start(params, warn);
+	warn_routine(fmt_with_err(warn), params);
+	va_end(params);
+}
+
 void warning(const char *warn, ...)
 {
 	va_list params;
--=20
2.8.0.rc0.210.gd302cd2
