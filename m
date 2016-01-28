From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 07/10] gettext: add is_utf8_locale()
Date: Thu, 28 Jan 2016 18:56:20 +0700
Message-ID: <1453982183-24124-8-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 12:57:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlCo-0007O1-JQ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 12:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935256AbcA1L5l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 06:57:41 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34863 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934954AbcA1L5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 06:57:09 -0500
Received: by mail-pf0-f194.google.com with SMTP id 66so1551645pfe.2
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 03:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HDeTqL322iG/mGNMW6ZO6UEoIfbnDubPPAYIDDadsm0=;
        b=AWRB3szPIPyBs/0LaslvHC+qP7ni8ciqXjNgahLlqIrvGn7igPWoSdxTYY7T/uCK12
         wPIRT530Uc4BCYRdtmPmgNvw3GcGYgT4sOfRG2osm4BoHD5qZZi85dCZW5+zL8BFQSWm
         ZNOptpdRqFpOBdzZFB3HhY+bTlWjaJRzSU8h/a8/Yxd08oYbyF+HcMurdB5voXaR7YGU
         Q2rT1HtzKi1lw555z3SnylVYoJ6KzTFffCJhU7xaNLkHepYBKTWTllWYiWsFiZZ0ffA3
         Tv9fW1saYIAqqH4k/ILlPJbVJBNyTBantXgQ9MpBA+bE+NiDSoqLP4QdZ2UZe6Km5yhx
         KsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=HDeTqL322iG/mGNMW6ZO6UEoIfbnDubPPAYIDDadsm0=;
        b=RZFhaZARlInFwt1fAiJQsebVmhId/jrcmUDLPKMLP2O5nvVqtnTX+KZ7l6AJhtOymM
         RfcNi0YeDvlN2bh9lq1z1E/PPf7o5c884cpw9k2De7cQeB80RjV7IfXKirRBnSif95As
         1EXJA8sY791M6zVxtwQK6HYmqmPHNJJe+9nE67BAYMtgtBA2vjVUFNEXmsnIkopfjzZi
         GSqDKXACLaVl6cUc5D527pfpNEDG20Ms/mPeeHA8KViWlySIdP39OcyF1vLHK5dnmneM
         UKjoSMURuLB0uWIq1zYaMQjr0yh/KLiB7WGaCrB9YXaSA/EESYeBkb8PXvddH9BCpiEJ
         V7Wg==
X-Gm-Message-State: AG10YOQcCXhb36xgw1aDOoI8nra6meLnayzKJUqv2j8LknY54jyJd9o1W0ZImKPFB0rLSw==
X-Received: by 10.98.68.211 with SMTP id m80mr3823256pfi.117.1453982229331;
        Thu, 28 Jan 2016 03:57:09 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id 76sm3718872pft.44.2016.01.28.03.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 03:57:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 28 Jan 2016 18:57:14 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285017>

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
2.7.0.288.g1d8ad15
