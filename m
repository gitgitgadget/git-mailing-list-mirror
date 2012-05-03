From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 6/9] archive-zip: remove uncompressed_size
Date: Thu,  3 May 2012 08:51:05 +0700
Message-ID: <1336009868-7411-7-git-send-email-pclouds@gmail.com>
References: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 04:00:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPlLg-00045D-0N
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 04:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab2ECCAr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 22:00:47 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57004 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab2ECCAr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 22:00:47 -0400
Received: by pbbrp8 with SMTP id rp8so1821426pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 19:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rHHOCSqyBH6dKu7Fxa6bGNkDqW3ByhNiqHPYCe2sagI=;
        b=e1T3WzbrXTL3bz+xNvy8/lNvrM0fT90yOdrqzvyFhrrL8pcsY4o3UkcFrXRXShxap6
         6hQAw06gRUh+zA8hruPNe6ae6isgaUDtvQgoHYs5rSL+cPCBCYTFAKYyjlDHx1a5jWew
         w2vUhBGe+ruSwYBug3cySOW54f8N5i0WOyZcxvzwGB5fuqbkkUX03m0T0I+s+hnDLZ7x
         GEu1TsGoEH4UKVlNdXmOuytPHAtfhVKNVpSMUhT0HLQgd8pIOXXaiNrrelufUjcKdT9b
         7K94EtTUh24B0XKCVPGV0jVJtU26njC+NTr02nkX+SPQNdFJ9QBMvrbL3ozsGI7Zgyw5
         xqcQ==
Received: by 10.68.134.37 with SMTP id ph5mr169095pbb.12.1336009981981;
        Wed, 02 May 2012 18:53:01 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id os8sm3626799pbc.14.2012.05.02.18.52.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 18:53:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 May 2012 08:52:05 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196884>

=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>

We only need size and compressed_size.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-zip.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 716cc42..400ba38 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -129,7 +129,6 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	struct zip_dir_header dirent;
 	unsigned long attr2;
 	unsigned long compressed_size;
-	unsigned long uncompressed_size;
 	unsigned long crc;
 	unsigned long direntsize;
 	int method;
@@ -149,7 +148,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 		method =3D 0;
 		attr2 =3D 16;
 		out =3D NULL;
-		uncompressed_size =3D 0;
+		size =3D 0;
 		compressed_size =3D 0;
 		buffer =3D NULL;
 		size =3D 0;
@@ -166,7 +165,6 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 			method =3D 8;
 		crc =3D crc32(crc, buffer, size);
 		out =3D buffer;
-		uncompressed_size =3D size;
 		compressed_size =3D size;
 	} else {
 		return error("unsupported file mode: 0%o (SHA1: %s)", mode,
@@ -204,7 +202,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	copy_le16(dirent.mdate, zip_date);
 	copy_le32(dirent.crc32, crc);
 	copy_le32(dirent.compressed_size, compressed_size);
-	copy_le32(dirent.size, uncompressed_size);
+	copy_le32(dirent.size, size);
 	copy_le16(dirent.filename_length, pathlen);
 	copy_le16(dirent.extra_length, 0);
 	copy_le16(dirent.comment_length, 0);
@@ -226,7 +224,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	copy_le16(header.mdate, zip_date);
 	copy_le32(header.crc32, crc);
 	copy_le32(header.compressed_size, compressed_size);
-	copy_le32(header.size, uncompressed_size);
+	copy_le32(header.size, size);
 	copy_le16(header.filename_length, pathlen);
 	copy_le16(header.extra_length, 0);
 	write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
--=20
1.7.3.1.256.g2539c.dirty
