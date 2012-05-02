From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] cmd_fetch_pack(): declare dest to be const
Date: Wed,  2 May 2012 21:38:08 +0700
Message-ID: <1335969490-9181-2-git-send-email-pclouds@gmail.com>
References: <4FA13835.7080204@alum.mit.edu>
 <1335969490-9181-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 16:41:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPakg-0005BP-Ar
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 16:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622Ab2EBOlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 10:41:55 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53835 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573Ab2EBOlx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 10:41:53 -0400
Received: by yenm10 with SMTP id m10so228398yen.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pFTpmj/owvBOy/ORlnsaxNDkOhXFUFvMi6N3U5/D6EE=;
        b=s1IvpfEBll4yKkTku9YORysQtck4LjN6zBR1ZSd7tIJ+1S6nN5uEUd364dVR/Qme82
         cKmleTy0cBYjTkCTU28iBZlwn5wpV3BPm1B5iANKLTkOhORLglinXl8k91kIk53VJKZN
         4G7wT/M6RUTVt+nb/xaAcZifXWJgWXKu/V6Q8N4xcTEv9+QZ0lLxo/sFVihQvKku8+oe
         5qaRPm/mSf3BJQapKzIho1nJY+wK7XYl4WvLiD7tv9bn+iDjiOXlhdUUPkZh4eD2LE+r
         nhE7BEwA7ozbsfrrg3JmLFN0+cwy5rmAy58mginibEfSa90SiaaIOCxW/dqpm9rB0v+p
         8FhQ==
Received: by 10.68.240.35 with SMTP id vx3mr26540338pbc.94.1335969712942;
        Wed, 02 May 2012 07:41:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id uu3sm2144845pbc.70.2012.05.02.07.41.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 07:41:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 21:38:22 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335969490-9181-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196828>

=46rom: Michael Haggerty <mhagger@alum.mit.edu>

There is no need for it to be non-const, and this avoids the need
for casting away constness of argv elements.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 10db15b..7e9d62f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -901,7 +901,8 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 {
 	int i, ret, nr_heads;
 	struct ref *ref =3D NULL;
-	char *dest =3D NULL, **heads;
+	const char *dest =3D NULL;
+	char **heads;
 	int fd[2];
 	char *pack_lockfile =3D NULL;
 	char **pack_lockfile_ptr =3D NULL;
@@ -971,7 +972,7 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 			}
 			usage(fetch_pack_usage);
 		}
-		dest =3D (char *)arg;
+		dest =3D arg;
 		heads =3D (char **)(argv + i + 1);
 		nr_heads =3D argc - i - 1;
 		break;
@@ -1018,7 +1019,7 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
 		fd[0] =3D 0;
 		fd[1] =3D 1;
 	} else {
-		conn =3D git_connect(fd, (char *)dest, args.uploadpack,
+		conn =3D git_connect(fd, dest, args.uploadpack,
 				   args.verbose ? CONNECT_VERBOSE : 0);
 	}
=20
--=20
1.7.8.36.g69ee2
