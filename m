From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 03/10] test-regex: expose full regcomp() to the command line
Date: Thu, 28 Jan 2016 18:56:16 +0700
Message-ID: <1453982183-24124-4-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 12:56:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlBy-0006lv-5R
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 12:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934632AbcA1L4r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 06:56:47 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33091 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcA1L4p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 06:56:45 -0500
Received: by mail-pa0-f66.google.com with SMTP id pv5so1894098pac.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 03:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BxehUYH9wB2auqqGUZpwCJQL4cXOVpJYSZ2715hIrds=;
        b=h8nCM7R3w97IcxnAb7RqvryNdIsuDMVBKrvKGUxfSKHIbNSkjy/ECrieJb4jYxuGax
         64sbpL1v0puK3P/RitZMyF/lyNbMHbsMDKZcmwxyMyElQcd0+rrF8IaQ6blKcGCiRllP
         9wqijo7JYPi/R2O26LxncgWIe6ehRuetknmedRWLM+1DuodmptXFdyQN5fo/jj+V6nlK
         0NFi5UASoEMtAR0UKdd2LJroZQx/98nK/xwPp1OfBQhWPCIh8ElEwQaYEVodElc62+aC
         veXFiUBVmnj4kPzkbKlOaZzc1GtECgUisoaSGAhUInq4aqPYUF0ZqG1NYu4wwDvDKGo0
         6vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=BxehUYH9wB2auqqGUZpwCJQL4cXOVpJYSZ2715hIrds=;
        b=XTKxvaqkVX0mTGpwb319iGC8X0GNtPR8Wv7f8Um//oJymlBhDkLXYO74i9M/T5TUe/
         DsYBp+Pv/FTh487anSOmxTQdx82cba9mFs4YmR0Y23L0sIEpK1G5swfFeKbHgCrE9LZ4
         nSg6kE/6oqsAPjpUCCWen7RVo2fbQmD0llGjJ6ORGr84bymmTZNNriy+8U8lc5vR+xRv
         L/vlBbv/H+YTiwUXKjhwdZ3jQxfn6UStqn7Pyzw0JzWZCVkS0FP7V7BdDDoF1uI6lsxG
         cJlBvvDWvj3jPn6mgwkBPQWW7tkmQ47mhSslL3lM5uE4BOw6e5S58eKhjy5phMB8kVaF
         N/6Q==
X-Gm-Message-State: AG10YORCdWJ3RDkKRpgxZ6XquKsoyu/oxy1aHju1FqYEeBqT9CDoby0PUw5iSpEZiWXrJg==
X-Received: by 10.66.232.202 with SMTP id tq10mr3956774pac.14.1453982205559;
        Thu, 28 Jan 2016 03:56:45 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id x18sm15920110pfa.65.2016.01.28.03.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 03:56:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 28 Jan 2016 18:56:50 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285009>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-regex.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/test-regex.c b/test-regex.c
index 0dc598e..3b5641c 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -1,19 +1,63 @@
 #include "git-compat-util.h"
+#include "gettext.h"
+
+struct reg_flag {
+	const char *name;
+	int flag;
+};
+
+static struct reg_flag reg_flags[] =3D {
+	{ "EXTENDED",	 REG_EXTENDED	},
+	{ "NEWLINE",	 REG_NEWLINE	},
+	{ "ICASE",	 REG_ICASE	},
+	{ "NOTBOL",	 REG_NOTBOL	},
+#ifdef REG_STARTEND
+	{ "STARTEND",	 REG_STARTEND	},
+#endif
+	{ NULL, 0 }
+};
=20
 int main(int argc, char **argv)
 {
-	char *pat =3D "[^=3D{} \t]+";
-	char *str =3D "=3D{}\nfred";
+	const char *pat;
+	const char *str;
+	int flags =3D 0;
 	regex_t r;
 	regmatch_t m[1];
=20
-	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
+	if (argc =3D=3D 1) {
+		/* special case, bug check */
+		pat =3D "[^=3D{} \t]+";
+		str =3D "=3D{}\nfred";
+		flags =3D REG_EXTENDED | REG_NEWLINE;
+	} else {
+		argv++;
+		pat =3D *argv++;
+		str =3D *argv++;
+		while (*argv) {
+			struct reg_flag *rf;
+			for (rf =3D reg_flags; rf->name; rf++)
+				if (!strcmp(*argv, rf->name)) {
+					flags |=3D rf->flag;
+					break;
+				}
+			if (!rf->name)
+				die("do not recognize %s", *argv);
+			argv++;
+		}
+		git_setup_gettext();
+	}
+
+	if (regcomp(&r, pat, flags))
 		die("failed regcomp() for pattern '%s'", pat);
-	if (regexec(&r, str, 1, m, 0))
-		die("no match of pattern '%s' to string '%s'", pat, str);
+	if (regexec(&r, str, 1, m, 0)) {
+		if (argc =3D=3D 1)
+			die("no match of pattern '%s' to string '%s'", pat, str);
+		return 1;
+	}
=20
 	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3D3957  */
-	if (m[0].rm_so =3D=3D 3) /* matches '\n' when it should not */
+	if (argc =3D=3D 1 && m[0].rm_so =3D=3D 3) /* matches '\n' when it sho=
uld not */
 		die("regex bug confirmed: re-build git with NO_REGEX=3D1");
=20
 	exit(0);
--=20
2.7.0.288.g1d8ad15
