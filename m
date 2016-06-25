Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BFA61FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbcFYFYR (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:17 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36119 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbcFYFYO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:14 -0400
Received: by mail-lf0-f67.google.com with SMTP id a2so23667088lfe.3
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAxaui0iu007NHWdbv4DgTLXkiybkzQYgCtu2RpIaS8=;
        b=fpGzrqGvWx7hf+plnYxojosmlXF36Szbmr24rk/0+cU8hIFkjx8qRYjtrGfKFasYzD
         oZX5i0+l+4BqasfNBrf9turNGUSFOy+jHQq9YqYlRIYOqK4iVYBJQnnaSCVg6LkU1oL9
         fWjZIEGQBcPpJygamBuieDwgUjcWzwMWEiGgxoylcdiWkQE8kPtPXpx5zISB/A5hEVtQ
         V4e1Zfp2BXqY+lXMZk6xwK+La+YGznE8DJOPir6bcTsIafct307RFJFy/C5qHYEckk/P
         c4bECzdVJ1djKQS5FtLG9KtnRMAPTWCs8RMORK1QkfPX6CH8c7Ps141AhGCovs+N5U/g
         H4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAxaui0iu007NHWdbv4DgTLXkiybkzQYgCtu2RpIaS8=;
        b=RDPIKhjgNSxhz3aoa+p7swsTE2iQ44/6nroVQv5Cc4qL+ZBsvAI3rE4CVj6jzcmVJA
         ERnERBrTu0nwq6mDZRVVC/HQM/EDvRu88rL/TWsM6po6FwFJwdfA04JwpjhULqfbF5E7
         WeY0MITSnodHpxJxHikQzkjqJwMRqDXSzUSViZE+H8Yd8YFhJXZeOX6alJg58iojgkiO
         9L7uK9LUv3NgmTwm9Myk10onVBwK9c0MxfXkFhDrTwBnCZ/TfmjV0HuKEOPaKlKmqjFe
         dXV2Bbds2uppFDDFauX0JqRVEW4umUdylXfXjRLo5mryT+3qwQyAZX4yX0mqckld230t
         gtdA==
X-Gm-Message-State: ALyK8tIgyOXYS7JBXIkp1c/HbfGnTZ4OwP1Yc3FRYXwoIpEv60ROL9J028QxEiLj/O12ow==
X-Received: by 10.46.71.83 with SMTP id u80mr2178814lja.15.1466832252687;
        Fri, 24 Jun 2016 22:24:12 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:12 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/12] gettext: add is_utf8_locale()
Date:	Sat, 25 Jun 2016 07:22:34 +0200
Message-Id: <20160625052238.13615-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625052238.13615-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
 <20160625052238.13615-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This function returns true if git is running under an UTF-8
locale. pcre in the next patch will need this.

is_encoding_utf8() is used instead of strcmp() to catch both "utf-8"
and "utf8" suffixes.

When built with no gettext support, we peek in several env variables
to detect UTF-8. pcre library might support utf-8 even if libc is
built without locale support.. The peeking code is a copy from
compat/regex/regcomp.c

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
 
+static const char *charset;
+
 /*
  * Guess the user's preferred languages from the value in LANGUAGE environment
  * variable and LC_MESSAGES locale category if NO_GETTEXT is not defined.
@@ -65,7 +67,6 @@ static int test_vsnprintf(const char *fmt, ...)
 	return ret;
 }
 
-static const char *charset;
 static void init_gettext_charset(const char *domain)
 {
 	/*
@@ -172,8 +173,27 @@ int gettext_width(const char *s)
 {
 	static int is_utf8 = -1;
 	if (is_utf8 == -1)
-		is_utf8 = !strcmp(charset, "UTF-8");
+		is_utf8 = is_utf8_locale();
 
 	return is_utf8 ? utf8_strwidth(s) : strlen(s);
 }
 #endif
+
+int is_utf8_locale(void)
+{
+#ifdef NO_GETTEXT
+	if (!charset) {
+		const char *env = getenv("LC_ALL");
+		if (!env || !*env)
+			env = getenv("LC_CTYPE");
+		if (!env || !*env)
+			env = getenv("LANG");
+		if (!env)
+			env = "";
+		if (strchr(env, '.'))
+			env = strchr(env, '.') + 1;
+		charset = xstrdup(env);
+	}
+#endif
+	return is_encoding_utf8(charset);
+}
diff --git a/gettext.h b/gettext.h
index 33696a4..7eee64a 100644
--- a/gettext.h
+++ b/gettext.h
@@ -90,5 +90,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 #endif
 
 const char *get_preferred_languages(void);
+extern int is_utf8_locale(void);
 
 #endif
-- 
2.8.2.526.g02eed6d

