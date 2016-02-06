From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 08/11] gettext: add is_utf8_locale()
Date: Sat,  6 Feb 2016 09:03:07 +0700
Message-ID: <1454724190-14063-9-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 03:04:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRsET-0004Hg-H6
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 03:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbcBFCEN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 21:04:13 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34198 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbcBFCEL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 21:04:11 -0500
Received: by mail-pa0-f50.google.com with SMTP id uo6so43741157pac.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 18:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nHQ8hbRWITf3hclBmB90siyRvdFS02t/f4dPX1sLvto=;
        b=gwZwV6OHe07ZbaUNPmJ2/TWh7gE7pC/9/6oWMbvuC9shu73c1gqNwxHv6J8esOsu03
         SCvJaIUKYyIXLSGjDOBXi2P4vj+DpDFp0Nm+OgkJ1Epg7HbJHBuCfbwRRwHrO45jHH3O
         Dd7ME46LWkeUubZ3yk7SQAUnmFMaVhqWEU5lCwXuWM9KMNB/hceKnTyNAPkpgq91vgcm
         GAlIR9/Oghg4HiehG0vYl53dXfkf7g9EiWitrjbEixzat5DeslBtj/MayQOme+YN9IIO
         8fS0lMGY0Ohzz/DF7ox/dTDwcQ1h2I9mZw+Kz1F0CgOuqFxuxpoGQfE6rUaeoSbvv/v5
         J9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=nHQ8hbRWITf3hclBmB90siyRvdFS02t/f4dPX1sLvto=;
        b=Mgw3Y21sEwp1f+DDS+RGhzPELuQ6YSGLcyoJMx9BnGB7uBzqnNjnC5v4IXEmBr9Ees
         jClL1S6AOrI1xlej7rOsSxQZiuXYaaha3orT9M7eXI5/am3CvhHOd5gaZlY96BjqqZCh
         2KM9vxaaD4bFpDGCWxE+ey69iNlkAJTbXDNUEmo+aJtF7rTCOUquTu81axvH48TmoWnS
         /GSTz/HOcUo6G1V/rAWbiYRrRGyzMZ0h8kHJ/1HtCtly/GKRhEn/Z0S1/+Oc9kRy61iU
         VxrOMx0o1autSbF/7l6kJaamr6M9UOyTlRw0kFUrFdvSOr9teyneteWk+vHss60hLwlC
         dceg==
X-Gm-Message-State: AG10YOS+klb/QxsEPCebALkUujs5/BgRrEr99K/4H4gIRTs9n+xMDWv3KFnB+0vic0UFsQ==
X-Received: by 10.66.62.226 with SMTP id b2mr15380341pas.94.1454724250935;
        Fri, 05 Feb 2016 18:04:10 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id d65sm27155599pfb.74.2016.02.05.18.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 18:04:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 06 Feb 2016 09:04:25 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285672>

This function returns true if git is running under an UTF-8
locale. pcre in the next patch will need this.

is_encoding_utf8() is used instead of strcmp() to catch both "utf-8"
and "utf8" suffixes.

When built with no gettext support, we peek in several env variables
to detect UTF-8. pcre library might support utf-8 even if libc is
built without locale support.. The peeking code is a copy from
compat/regex/regcomp.c

Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 gettext.c | 24 ++++++++++++++++++++++--
 gettext.h |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/gettext.c b/gettext.c
index a268a2c..db727ea 100644
--- a/gettext.c
+++ b/gettext.c
@@ -18,6 +18,8 @@
 #	endif
 #endif
=20
+static const char *charset;
+
 /*
  * Guess the user's preferred languages from the value in LANGUAGE env=
ironment
  * variable and LC_MESSAGES locale category if NO_GETTEXT is not defin=
ed.
@@ -65,7 +67,6 @@ static int test_vsnprintf(const char *fmt, ...)
 	return ret;
 }
=20
-static const char *charset;
 static void init_gettext_charset(const char *domain)
 {
 	/*
@@ -172,8 +173,27 @@ int gettext_width(const char *s)
 {
 	static int is_utf8 =3D -1;
 	if (is_utf8 =3D=3D -1)
-		is_utf8 =3D !strcmp(charset, "UTF-8");
+		is_utf8 =3D is_utf8_locale();
=20
 	return is_utf8 ? utf8_strwidth(s) : strlen(s);
 }
 #endif
+
+int is_utf8_locale(void)
+{
+#ifdef NO_GETTEXT
+	if (!charset) {
+		const char *env =3D getenv("LC_ALL");
+		if (!env || !*env)
+			env =3D getenv("LC_CTYPE");
+		if (!env || !*env)
+			env =3D getenv("LANG");
+		if (!env)
+			env =3D "";
+		if (strchr(env, '.'))
+			env =3D strchr(env, '.') + 1;
+		charset =3D xstrdup(env);
+	}
+#endif
+	return is_encoding_utf8(charset);
+}
diff --git a/gettext.h b/gettext.h
index 33696a4..7eee64a 100644
--- a/gettext.h
+++ b/gettext.h
@@ -90,5 +90,6 @@ const char *Q_(const char *msgid, const char *plu, un=
signed long n)
 #endif
=20
 const char *get_preferred_languages(void);
+extern int is_utf8_locale(void);
=20
 #endif
--=20
2.7.0.377.g4cd97dd
