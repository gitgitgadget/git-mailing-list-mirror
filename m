From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/25] usage.c: add sys_error() that prints strerror() automatically
Date: Wed, 13 Apr 2016 20:15:23 +0700
Message-ID: <1460553346-12985-3-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:16:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKeL-0003rZ-9u
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760548AbcDMNP7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:15:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34587 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760579AbcDMNP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:15:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id d184so4101902pfc.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzzJTqFZUfhAUKrOhqC8UHc3/4GrwtqwNXrClXyyHEk=;
        b=kfX7DdK9n+dYVJ/Tp8hK2rOJMkrgB6t4hpBu2/D2nxggXQHJnD9ZdwmRhn+fc3Ltx9
         zWpi9eXNVofUUZigbySMVZCvW/LOTJ7JXwdbftoW1WHE71Z6oMJzR0fc8yerLdpERc54
         LAKeWDeIGL6sXvQfsmEh4zumpTMygloFQDPO0LjU21Mn6yaKs7vipxJePnDSinhkI6To
         xCJnbbFOQrxW/2XQdYQSaVEPAiCz82Gg82e4i9KXlXUEBxSf+M62uScgX91MY3vVO2Lz
         M+IqTQO1xbTJKsW7X9ooHCkan/B6ublnpt6AMQqSFFMLhqhL8jWNV1UZnzmcquB3zYXg
         noWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzzJTqFZUfhAUKrOhqC8UHc3/4GrwtqwNXrClXyyHEk=;
        b=aeoN2vcJiYT5F9WWzNP3LCdaZ4Gv78kfg5jq9mohFtQg6YY155Boe2Aw85GDDGsRRl
         l4NBaZjHJCrUFQThGiygx2LaC+MhkSHX8glspMjJXrvvWiyVYiwH+vZftMTw2v/4qq8e
         4mtfTODZHcEie2JmQ1U0W3s3wGOCjGkSITJtCWpj9oHc6Yp7o/O/WZanko60qEcQd6fe
         YlHA8fh6ZtA2nTgKAiPfMEL0KhE4A61vcz0EtdUsdThLdmrmnidlOzNXUN+1B8xU1v7w
         CbcWZppn8BjLf9Y2J1TGysXhVxwgxoRE/+uOACmqVJhifI4bsfla+asZO81tPHTHD0lw
         jHEQ==
X-Gm-Message-State: AOPr4FXZW3dWmvdF4AcyChaQqJXbVZFK8qd+TB+qJSvSf/2W1EpqumFKa5ZOgutk4kFerA==
X-Received: by 10.98.65.203 with SMTP id g72mr13005512pfd.138.1460553357754;
        Wed, 13 Apr 2016 06:15:57 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id by3sm51313650pab.39.2016.04.13.06.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:15:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:16:04 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291423>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-compat-util.h |  1 +
 usage.c           | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 4743954..e8e7765 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -412,6 +412,7 @@ extern NORETURN void usagef(const char *err, ...) _=
_attribute__((format (printf,
 extern NORETURN void die(const char *err, ...) __attribute__((format (=
printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((fo=
rmat (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, =
1, 2)));
+extern int sys_error(const char *err, ...) __attribute__((format (prin=
tf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (print=
f, 1, 2)));
=20
 #ifndef NO_OPENSSL
diff --git a/usage.c b/usage.c
index 0dba0c5..e7c37f2 100644
--- a/usage.c
+++ b/usage.c
@@ -148,6 +148,16 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
=20
+int sys_error(const char *fmt, ...)
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
--=20
2.8.0.rc0.210.gd302cd2
