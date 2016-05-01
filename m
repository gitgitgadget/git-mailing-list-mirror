From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/41] entry.c: use error_errno()
Date: Sun,  1 May 2016 18:14:40 +0700
Message-ID: <1462101297-8610-25-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:17:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpNR-0007dW-PB
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbcEALR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:17:26 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34714 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:17:25 -0400
Received: by mail-pa0-f68.google.com with SMTP id yl2so16152606pac.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+FQuRGc8rqkhVhmp5Ax5z+iMJbnz2uN3otK7AnJ6WQ=;
        b=g2TlRUKFx8AfKWXmbx8C7HYtceEfgG4VivrkeNLS+NeqeNdurQNRDooEem/Uvx/FE7
         rouIvO0RufXOSZc58iyDHsMR9lJgJKoRIYk4QO5iC+H15XEE0MqnE46GOw+4QEPrc21b
         t0kANkxkntbvyjkGSJTjSc/pGX7OPUHTEEfYFea+tJ6u+6Cc8FNgWRj7G7z1xM5II1Sl
         Z7U2pNeVphOZG9IMnhErmul9DjUa2IVrRW/SS8Hii8/3juvVhwH3fNS6T5a+ywi0CJW5
         TkyTHjxg0A1W+RzaPuo+DQ1HN3KknvC/zO0ZG2K0AWlASK0qHD/EbCJbsiMZFqpfFEGX
         SkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+FQuRGc8rqkhVhmp5Ax5z+iMJbnz2uN3otK7AnJ6WQ=;
        b=DxAP9Wy3QEiUBOff1xNRA578WjO42jvY9fkcmpzap5Fqhrn9x0QsAONRdGScZmMIwU
         BBlnbr7fxoPDNS3aQMjFdIpNXV1Wibr5rCtpea0+bMeahm9nIjUrVjpNBRmO8QW1VUp7
         2T6PCogT1jNEsZbLrlXbDvYIjhJgOHBfEysr+i4rRb6SrUfJVgkRhxSnH9BWaGQugGUa
         XtLQTptW294chxUkKivIgf6s6mJtBGV9nLH99eM8xlaFRmLQs5IqYiI5htSAq70DuTxc
         qZmRjDG86OszE5JRWN/dbt8o2+JDQhzmy1Xz5UmfK0ByPHNreQvbvxb8UoHeMGm6F1f+
         EPRA==
X-Gm-Message-State: AOPr4FV90GoEsHZOKqRtJGMIcFgUAlfYZgOLGSfyNaFCSXr50ByXwbYeY7JrHWBsiVbBjg==
X-Received: by 10.66.148.42 with SMTP id tp10mr43743889pab.159.1462101444917;
        Sun, 01 May 2016 04:17:24 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id lz5sm37374450pab.34.2016.05.01.04.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:17:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:17:20 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293174>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 entry.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/entry.c b/entry.c
index a410957..519e042 100644
--- a/entry.c
+++ b/entry.c
@@ -168,8 +168,8 @@ static int write_entry(struct cache_entry *ce,
 			ret =3D symlink(new, path);
 			free(new);
 			if (ret)
-				return error("unable to create symlink %s (%s)",
-					     path, strerror(errno));
+				return error_errno("unable to create symlink %s",
+						   path);
 			break;
 		}
=20
@@ -186,8 +186,7 @@ static int write_entry(struct cache_entry *ce,
 		fd =3D open_output_fd(path, ce, to_tempfile);
 		if (fd < 0) {
 			free(new);
-			return error("unable to create file %s (%s)",
-				path, strerror(errno));
+			return error_errno("unable to create file %s", path);
 		}
=20
 		wrote =3D write_in_full(fd, new, size);
@@ -284,8 +283,7 @@ int checkout_entry(struct cache_entry *ce,
 				return error("%s is a directory", path.buf);
 			remove_subtree(&path);
 		} else if (unlink(path.buf))
-			return error("unable to unlink old '%s' (%s)",
-				     path.buf, strerror(errno));
+			return error_errno("unable to unlink old '%s'", path.buf);
 	} else if (state->not_new)
 		return 0;
=20
--=20
2.8.0.rc0.210.gd302cd2
