From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/16] Add test-column for testing column layout
Date: Wed,  9 Feb 2011 19:24:33 +0700
Message-ID: <1297254284-3729-6-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:52:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn9X5-0000x3-6r
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332Ab1BIMw0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:52:26 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37601 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab1BIMwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:52:25 -0500
Received: by iyj8 with SMTP id 8so114311iyj.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=eAa3eS3G+0CgoKwpWeeE057G1UybnFZTpv2x4jpMf8k=;
        b=OC2Y2NG0GrS062s7/uUhsUq9IFnnlbq7Or84HbpsKWkhoEDgYOq39kFkKImDqPBYv/
         dn/gy0EqFgWqm+cWyXntEZefNnQ+FpVJ2TpAf8qPmbgSGoeo/dhvf8AukjDa08M/+8RS
         TICyWkXMMDkyNHsEjae+V6DF3zxIfwKlkHRH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=V98dk2RGvLrVUAlux+PfDUFnFPdPTsloy0TkisKfk0/pZwye7/5aW6bT1mUvN/0B4H
         hHUJuht45A5NLF1hBfAQQCLz2Ke6sUKbnLNLmk9cxwDbday/G4JDFoz7afZy8EoyMU8r
         t+XC9uu6cU1co/cRWay9rcg+ceYyKCeP040Dg=
Received: by 10.42.179.67 with SMTP id bp3mr22011085icb.57.1297254414467;
        Wed, 09 Feb 2011 04:26:54 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id t14sm205915icd.22.2011.02.09.04.26.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:26:53 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:25:24 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166421>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore        |    1 +
 Makefile          |    1 +
 t/t9002-column.sh |  108 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 test-column.c     |   57 ++++++++++++++++++++++++++++
 4 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100755 t/t9002-column.sh
 create mode 100644 test-column.c

diff --git a/.gitignore b/.gitignore
index 3dd6ef7..a1a1202 100644
--- a/.gitignore
+++ b/.gitignore
@@ -162,6 +162,7 @@
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.min.*
 /test-chmtime
+/test-column
 /test-ctype
 /test-date
 /test-delta
diff --git a/Makefile b/Makefile
index 88e20de..a687e73 100644
--- a/Makefile
+++ b/Makefile
@@ -417,6 +417,7 @@ PROGRAM_OBJS +=3D http-backend.o
 PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
=20
 TEST_PROGRAMS_NEED_X +=3D test-chmtime
+TEST_PROGRAMS_NEED_X +=3D test-column
 TEST_PROGRAMS_NEED_X +=3D test-ctype
 TEST_PROGRAMS_NEED_X +=3D test-date
 TEST_PROGRAMS_NEED_X +=3D test-delta
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
new file mode 100755
index 0000000..1d030b0
--- /dev/null
+++ b/t/t9002-column.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+
+test_description=3D'git column'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	cat >lista <<\EOF
+one
+two
+three
+four
+five
+six
+seven
+eight
+nine
+ten
+eleven
+EOF
+'
+
+test_expect_success '80 columns' '
+	cat >expected <<\EOF &&
+one    two    three  four   five   six    seven  eight  nine   ten    =
eleven
+EOF
+	COLUMNS=3D80 test-column < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'COLUMNS =3D 1' '
+	cat >expected <<\EOF &&
+one
+two
+three
+four
+five
+six
+seven
+eight
+nine
+ten
+eleven
+EOF
+	COLUMNS=3D1 test-column < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'width =3D 1' '
+	test-column --width=3D1 < lista > actual &&
+	test_cmp expected actual
+'
+
+COLUMNS=3D20
+export COLUMNS
+
+test_expect_success '20 columns' '
+	cat >expected <<\EOF &&
+one    seven
+two    eight
+three  nine
+four   ten
+five   eleven
+six
+EOF
+	test-column < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, densed' '
+	cat >expected <<\EOF &&
+one   seven
+two   eight
+three nine
+four  ten
+five  eleven
+six
+EOF
+	test-column --mode=3Dcolumn,dense < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, padding 2' '
+	cat >expected <<\EOF &&
+one     seven
+two     eight
+three   nine
+four    ten
+five    eleven
+six
+EOF
+	test-column --padding 2 < lista > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '20 columns, left indented' '
+	cat >expected <<\EOF &&
+  one    seven
+  two    eight
+  three  nine
+  four   ten
+  five   eleven
+  six
+EOF
+	test-column --left=3D2 < lista > actual &&
+	test_cmp expected actual
+'
+
+test_done
diff --git a/test-column.c b/test-column.c
new file mode 100644
index 0000000..b9a5d4b
--- /dev/null
+++ b/test-column.c
@@ -0,0 +1,57 @@
+#include "cache.h"
+#include "strbuf.h"
+#include "parse-options.h"
+#include "string-list.h"
+#include "column.h"
+
+static const char * const builtin_column_usage[] =3D {
+	"git column [--mode=3D<mode>] [--width=3D<width>] [--left-space=3D<N>=
] [--right-space=3D<N>]",
+	NULL
+};
+
+int main(int argc, const char **argv)
+{
+	struct string_list list =3D STRING_LIST_INIT_DUP;
+	const char *modestr =3D NULL;
+	int mode =3D 0;
+	struct strbuf sb =3D STRBUF_INIT;
+	int left_space =3D 0, right_space =3D 0, padding =3D 1;
+	int term_width =3D term_columns();
+	struct option options[] =3D {
+		OPT_INTEGER(0, "width", &term_width, "Maximum width"),
+		OPT_INTEGER(0, "left", &left_space, "Padding space on left border"),
+		OPT_INTEGER(0, "right", &right_space, "Padding space on right border=
"),
+		OPT_INTEGER(0, "padding", &padding, "Padding space between columns")=
,
+		OPT_STRING(0, "mode", &modestr, "mode", "Which layout mode to use"),
+		OPT_END()
+	};
+
+	argc =3D parse_options(argc, argv, "", options, builtin_column_usage,=
 0);
+
+	while (modestr && *modestr) {
+		int len =3D strcspn(modestr, ",");
+		if (len =3D=3D 6 && !strncmp(modestr, "column", len))
+			mode |=3D COL_MODE_COLUMN;
+		else if (len =3D=3D 5 && !strncmp(modestr, "dense", len))
+			mode |=3D COL_DENSE;
+		else if (len =3D=3D 4 && !strncmp(modestr, "ansi", len))
+			mode |=3D COL_ANSI;
+		else
+			die("Unknown modestr %s", modestr);
+		modestr +=3D len;
+		while (*modestr =3D=3D ',')
+			modestr++;
+	}
+	if (!mode)
+		mode =3D COL_MODE_COLUMN;
+	if ((mode & COL_MODE) =3D=3D 0)
+		die("Invalid mode '%s'", modestr);
+
+	while (!strbuf_getline(&sb, stdin, '\n'))
+		string_list_append(&list, sb.buf);
+
+	strbuf_setlen(&sb, left_space);
+	memset(sb.buf, ' ', left_space);
+	display_columns(&list, mode, term_width - right_space - left_space, p=
adding, sb.buf);
+	return 0;
+}
--=20
1.7.2.2
