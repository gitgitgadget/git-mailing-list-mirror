From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/41] builtin/mailsplit.c: use error_errno()
Date: Tue,  3 May 2016 19:03:41 +0700
Message-ID: <1462277054-5943-9-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:07:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ6e-0008NB-DO
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933045AbcECMHF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:07:05 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36675 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932756AbcECMHC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:07:02 -0400
Received: by mail-pf0-f177.google.com with SMTP id c189so9661784pfb.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l7fguItTeRU64mb16Vtb6GT23zIscchs0Mh01Ss9lC8=;
        b=PHYGMKVgutYqkd9jFIEtkkhK0Vkj4PPlLTLzvI0Ay2vi5dBK9IfxR2Eqtey3Netf57
         aU67fF5/dr2gALoI06d3jZaBz3YMqHjj2WcFqgSJyQCnsZxNQFbkyhUns1lKn2PUxh0h
         kfwNHk+zm67HrMmygEL5odhJ9k0LxarjRDN/4WrW/UUphBWnaIJ2zHVF8F4YyfP5fPlC
         uJa2uR0CIwIOeWbU+QyKEPIlnrSfo8KjVkFncTvneaC0iJH+T1U1wrcac20sCq9Kqqwf
         Yru5HpfmObZ5PrdT2CsQ3UiGz5xLX/WAK4213/Ocq7oVJxTV3zchuwrtSnbgCOiDRjgY
         z/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l7fguItTeRU64mb16Vtb6GT23zIscchs0Mh01Ss9lC8=;
        b=L/e6Hx3h1OIgGyJoDMcPShJ5qGwts84fT/bE+8pqoP7mtPps02D0rbRsmRrVpl0f1D
         R15SOAGweU8d8O1PecjIhM7HD2qSiMkNmnd4A9Bwa2NoKdmpaj1PzZHqA5S4R6cyRKzv
         r5eMGhKK5C8PTPLRlzQeZ7E1BHX3xU0ypqtfr/rlKZBp61YzWWh9z1jqFTwuuhK2O3ba
         XsR5E1z+vAAEG/8cmWH/sjvC/ODzUNP/kmuzVHIlR6+ng9L/6FdVXG8ymBaWPl0lbnDX
         WXqAKUoEEjPk8zqRQaL9h5s8aSqVzJhtbOtUon++87rIdGIwf8TEF70AnaayxGmrIYKI
         +qFg==
X-Gm-Message-State: AOPr4FWwFjaYPkbMXvsYHs9J4NvWYFiA0qE4rAK+GBzuPLAmpsCO5/FnYVKO2eAtRg8zXg==
X-Received: by 10.98.51.2 with SMTP id z2mr2910391pfz.118.1462277221746;
        Tue, 03 May 2016 05:07:01 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id qm10sm5464903pac.33.2016.05.03.05.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:07:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:06:57 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293360>

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
