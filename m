From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/41] builtin/mailsplit.c: use error_errno()
Date: Sun,  8 May 2016 16:47:28 +0700
Message-ID: <1462700881-25108-9-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:50:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLL2-00007x-O6
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbcEHJtV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:49:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33895 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbcEHJtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:49:20 -0400
Received: by mail-pf0-f196.google.com with SMTP id 145so13759700pfz.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWOXhURfzD5KY8Zyto09oNx9Ph/hoeKiwk/GSzU9l3g=;
        b=eOO0z8v7QNUfYGAG/aEItufBm7K7zKswrl4Jdoqldu8wq5oZ3anHn0nnzURP4uVNUM
         0h5IxKNMKpxQqYTHDFkR2CuHlIUB2mEIEb5kJJTeMC4uliehYbsdjFBlEFbUcZoxkMAe
         UAhAVOJ2ZFjZI0SJs52F3KjMfDY+x558cuD/gHk/IVogrIg6yftXIhLqCVY6qGSTqfmf
         2gNvA2MBJhrdrujEzl4k9F/a+PqtS/3l3selb5GbMfpkkPp4cHJUvTrZOqPxRSAv0Ynl
         /9JHc5s8sbNT3XSZ47V2Mw5Nb4eQKrZXYsIByZWrwb0OCsXZwkfYfsEGmEyeUmQMh/OQ
         9gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWOXhURfzD5KY8Zyto09oNx9Ph/hoeKiwk/GSzU9l3g=;
        b=OD8cn/jLCak07aWJwyFd8pd7sx/vm8wjH6i+fXJAtqyfWOMM9EudgBmt0bukrRnMr4
         oiHS5BMQoax7u8eoBPuquQSRD3kdzDoUIGNPY2TILiTP7sRWIccT4amy9F69rHHsv063
         IluCL+3XX7hfEfEhfTHSQqQJvp975s2zgbG29gtD+IsKrJc2gMEW6aVyD6qdZ53XIu7i
         RyDKGPHRr5N2UMgGbML2HiGs8lYXaMU/IG/Zl/SXN8o0f8LJxKgVWMF4Clp8BJm2D2lp
         ZGI1wyP8mzFPkixHvQuL1Kgd2x19N/ksR3n4n2uwVs9DCMCaVdsBu1Z9fylqGMoZaKCT
         qaIw==
X-Gm-Message-State: AOPr4FUbL6z7z2I+/am3H/AMFyfa/iRmHibwpg2tVT5FyYOHG52oVuwS30X87sso/S16Pw==
X-Received: by 10.98.0.203 with SMTP id 194mr41312526pfa.126.1462700959378;
        Sun, 08 May 2016 02:49:19 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id z17sm32729114pfi.61.2016.05.08.02.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:49:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:49:19 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293920>

There's one change, in split_mbox(), where an error() without strerror(=
)
as argument is converted to error_errno(). This is correct because the
previous call is fopen (not shown in the context lines), which should
set errno if it returns NULL.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mailsplit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 104277a..4859ede 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -109,7 +109,7 @@ static int populate_maildir_list(struct string_list=
 *list, const char *path)
 		if ((dir =3D opendir(name)) =3D=3D NULL) {
 			if (errno =3D=3D ENOENT)
 				continue;
-			error("cannot opendir %s (%s)", name, strerror(errno));
+			error_errno("cannot opendir %s", name);
 			goto out;
 		}
=20
@@ -174,12 +174,12 @@ static int split_maildir(const char *maildir, con=
st char *dir,
=20
 		f =3D fopen(file, "r");
 		if (!f) {
-			error("cannot open mail %s (%s)", file, strerror(errno));
+			error_errno("cannot open mail %s", file);
 			goto out;
 		}
=20
 		if (strbuf_getwholeline(&buf, f, '\n')) {
-			error("cannot read mail %s (%s)", file, strerror(errno));
+			error_errno("cannot read mail %s", file);
 			goto out;
 		}
=20
@@ -210,7 +210,7 @@ static int split_mbox(const char *file, const char =
*dir, int allow_bare,
 	int file_done =3D 0;
=20
 	if (!f) {
-		error("cannot open mbox %s", file);
+		error_errno("cannot open mbox %s", file);
 		goto out;
 	}
=20
@@ -318,7 +318,7 @@ int cmd_mailsplit(int argc, const char **argv, cons=
t char *prefix)
 		}
=20
 		if (stat(arg, &argstat) =3D=3D -1) {
-			error("cannot stat %s (%s)", arg, strerror(errno));
+			error_errno("cannot stat %s", arg);
 			return 1;
 		}
=20
--=20
2.8.0.rc0.210.gd302cd2
