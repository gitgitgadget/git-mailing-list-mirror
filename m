From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/41] builtin/mailsplit.c: use error_errno()
Date: Sun,  1 May 2016 18:14:24 +0700
Message-ID: <1462101297-8610-9-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:16:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpM3-0006up-3L
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbcEALP7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:15:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34828 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbcEALP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:15:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so19009518pfr.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l7fguItTeRU64mb16Vtb6GT23zIscchs0Mh01Ss9lC8=;
        b=s5064IZoYhVPiOzURCgf69GO9Q6N3ttMWm0E7j+Sm93Xdistso2VVdJtQJuU+Pghiw
         p9n7LXJmskiKKep384SD1PlQnOX8v/hR82QOvzMCUJ/YwBXn4gSwxhJRrfXWdv1OieUP
         LRppKgWoW8cjnDhdvbygAUcKKzKOYGwj/RTFCVK2Rbqr5Pe7MVRyousPUYv5lDNwUSS+
         kujOdBaIWRZJHGZg7IR4TtOyqd7GHN5F3djqNQlzJv5IF0gX6DaEadrViB7whlswV7eL
         /J3fVPvA3RfUh4zrlaVnVVfQVvKO/tqTQI3RuwZD+BgZrX0QJEj+nFbLq0OOzK2E6R1z
         9+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l7fguItTeRU64mb16Vtb6GT23zIscchs0Mh01Ss9lC8=;
        b=Wo96gWbvkDoEYctO4bYM/JjqH10Ml2/3zmuKGoZbg2g3ZoIh9CHEJfh+Di3h+nfBAW
         2GISGGGQ5LHwMQY0CzrDLsLKbWMxZ9ch5D6rb2pPbgmrENEV69wQPYURy2Glgkl6gAH/
         Vq+BDcm6ip4NUY/c+9HciYJYjDnI5Cv+D+qaDUj2zKqCrl4zbH7MDOOpewP9tDi76NWy
         JZfOO5izJpiZEOaQQtvQUUPc67V2K7iE4rYPEfROs/RkQvwcBktXRZ+i3yOm8GGs6xAA
         79gPDviJQGe/PXsq7twCT+plTg+7ckGYdDwpigNIfhp3g2kYee51RJwCIzrvGcEzfyDQ
         4BeQ==
X-Gm-Message-State: AOPr4FXU3+oLKc1UJfRNnGIqPVlMoagaeYDKdCx0tQz2XTYDieM9U29LZ1fHRdl/E3N/rA==
X-Received: by 10.98.86.24 with SMTP id k24mr43478811pfb.87.1462101357536;
        Sun, 01 May 2016 04:15:57 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id e7sm30127179pfa.28.2016.05.01.04.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:15:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:15:53 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293157>

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
