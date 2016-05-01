From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 36/41] sha1_file.c: use {error,die,warning}_errno()
Date: Sun,  1 May 2016 18:14:52 +0700
Message-ID: <1462101297-8610-37-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:18:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpOU-0008Do-TS
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbcEALSb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:18:31 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36235 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbcEALSa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:18:30 -0400
Received: by mail-pa0-f66.google.com with SMTP id i5so16179629pag.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LC7Ig0u87qj5ftv6cb0hWXsDMxA+6eaGqVFB0F/YE5M=;
        b=f7oBKS/FOhAOjPdtEu11VF3nGWCYVeNoCwuzyVmE+zBj9C8XkWk22DsgdoUBDEnl1N
         rB1F6vAbsbFIxaASZRGjNSeyWGEjmCra4nzF5RNRRcndl1Ocm452kXlmG5vNJIJmHd0h
         vjnI+a3a2eJLmJP2irnB5WArf7A1tEz4leYYmGFC4gWCUlgimc+vggPR9oygQVUM35zg
         vmkNl/fK3PJdgzM8/YyfKqCVRSco2IxqXL6+tJV86ij/DdSdX/Ln8mNDD2kgW5TEPntz
         xqwxCMq74NyjadJZz1zgBY4fWP57IPl2aHRLieMO40H7G39qgDecgSRASQBBnwF6wixm
         bafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LC7Ig0u87qj5ftv6cb0hWXsDMxA+6eaGqVFB0F/YE5M=;
        b=GtHEdp7CXWgd+edH9c21f4G3Y4aWHDvXXuKcXd7NAgPHNY9mNNJa4FJW/By+0eXZfj
         WYmrG2rtNTmS8VKfjgu3nv7HYqhrMmvCYFItEdTwnsIfg8zujs/FaFaSbDn2WuoGFLu6
         Nno06LlnCLGWQj4xcrHyNiU3YtAlidxX/9fTHK9Fde/P5ZolMStae9eiEwncZHWQf3L0
         9melBLFHlOJ2/NntRFQMMF83Mm+f8xBD2JWCaAfX/aPROmGsidR3/SWB6giNAE+nw7QN
         uLBTjBPG8KoG7kIoZt6I7/RMWvZzlI4e8abevw2VkrrGLzv5tEjX/LTHEYQ2P1nSbkIY
         0Uuw==
X-Gm-Message-State: AOPr4FUXRVL6ebaBLK/P8sOK01MNT6WLWahGFR6Y1Nv3x0BzKn6NrW1Toy4FKtNTzhQ9UQ==
X-Received: by 10.66.65.169 with SMTP id y9mr43581419pas.102.1462101509774;
        Sun, 01 May 2016 04:18:29 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id b27sm37047726pfc.74.2016.05.01.04.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:18:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:18:25 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293186>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d0f2aa0..a7f45b3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1107,9 +1107,8 @@ unsigned char *use_pack(struct packed_git *p,
 				PROT_READ, MAP_PRIVATE,
 				p->pack_fd, win->offset);
 			if (win->base =3D=3D MAP_FAILED)
-				die("packfile %s cannot be mapped: %s",
-					p->pack_name,
-					strerror(errno));
+				die_errno("packfile %s cannot be mapped",
+					  p->pack_name);
 			if (!win->offset && win->len =3D=3D p->pack_size
 				&& !p->do_not_close)
 				close_pack_fd(p);
@@ -1279,8 +1278,8 @@ static void prepare_packed_git_one(char *objdir, =
int local)
 	dir =3D opendir(path.buf);
 	if (!dir) {
 		if (errno !=3D ENOENT)
-			error("unable to open object pack directory: %s: %s",
-			      path.buf, strerror(errno));
+			error_errno("unable to open object pack directory: %s",
+				    path.buf);
 		strbuf_release(&path);
 		return;
 	}
@@ -2984,7 +2983,7 @@ int finalize_object_file(const char *tmpfile, con=
st char *filename)
 	unlink_or_warn(tmpfile);
 	if (ret) {
 		if (ret !=3D EEXIST) {
-			return error("unable to write sha1 filename %s: %s", filename, stre=
rror(ret));
+			return error_errno("unable to write sha1 filename %s", filename);
 		}
 		/* FIXME!!! Collision check here ? */
 	}
@@ -2998,7 +2997,7 @@ out:
 static int write_buffer(int fd, const void *buf, size_t len)
 {
 	if (write_in_full(fd, buf, len) < 0)
-		return error("file write error (%s)", strerror(errno));
+		return error_errno("file write error");
 	return 0;
 }
=20
@@ -3081,7 +3080,7 @@ static int write_loose_object(const unsigned char=
 *sha1, char *hdr, int hdrlen,
 		if (errno =3D=3D EACCES)
 			return error("insufficient permission for adding an object to repos=
itory database %s", get_object_directory());
 		else
-			return error("unable to create temporary file: %s", strerror(errno)=
);
+			return error_errno("unable to create temporary file");
 	}
=20
 	/* Set it up */
@@ -3126,8 +3125,7 @@ static int write_loose_object(const unsigned char=
 *sha1, char *hdr, int hdrlen,
 		utb.actime =3D mtime;
 		utb.modtime =3D mtime;
 		if (utime(tmp_file.buf, &utb) < 0)
-			warning("failed utime() on %s: %s",
-				tmp_file.buf, strerror(errno));
+			warning_errno("failed utime() on %s", tmp_file.buf);
 	}
=20
 	return finalize_object_file(tmp_file.buf, filename);
@@ -3360,7 +3358,7 @@ static int index_core(unsigned char *sha1, int fd=
, size_t size,
 		if (size =3D=3D read_in_full(fd, buf, size))
 			ret =3D index_mem(sha1, buf, size, type, path, flags);
 		else
-			ret =3D error("short read %s", strerror(errno));
+			ret =3D error_errno("short read");
 		free(buf);
 	} else {
 		void *buf =3D xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -3425,18 +3423,14 @@ int index_path(unsigned char *sha1, const char =
*path, struct stat *st, unsigned
 	case S_IFREG:
 		fd =3D open(path, O_RDONLY);
 		if (fd < 0)
-			return error("open(\"%s\"): %s", path,
-				     strerror(errno));
+			return error_errno("open(\"%s\")", path);
 		if (index_fd(sha1, fd, st, OBJ_BLOB, path, flags) < 0)
 			return error("%s: failed to insert into database",
 				     path);
 		break;
 	case S_IFLNK:
-		if (strbuf_readlink(&sb, path, st->st_size)) {
-			char *errstr =3D strerror(errno);
-			return error("readlink(\"%s\"): %s", path,
-			             errstr);
-		}
+		if (strbuf_readlink(&sb, path, st->st_size))
+			return error_errno("readlink(\"%s\")", path);
 		if (!(flags & HASH_WRITE_OBJECT))
 			hash_sha1_file(sb.buf, sb.len, blob_type, sha1);
 		else if (write_sha1_file(sb.buf, sb.len, blob_type, sha1))
@@ -3492,7 +3486,7 @@ static int for_each_file_in_obj_subdir(int subdir=
_nr,
 	if (!dir) {
 		if (errno =3D=3D ENOENT)
 			return 0;
-		return error("unable to open %s: %s", path->buf, strerror(errno));
+		return error_errno("unable to open %s", path->buf);
 	}
=20
 	while ((de =3D readdir(dir))) {
--=20
2.8.0.rc0.210.gd302cd2
