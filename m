From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 24/41] entry.c: use error_errno()
Date: Tue,  3 May 2016 19:03:57 +0700
Message-ID: <1462277054-5943-25-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:08:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ8B-0000hW-NX
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932986AbcECMIn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:08:43 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33814 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932860AbcECMIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:08:42 -0400
Received: by mail-pa0-f49.google.com with SMTP id r5so9232036pag.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+FQuRGc8rqkhVhmp5Ax5z+iMJbnz2uN3otK7AnJ6WQ=;
        b=iAZM3KGrR7Id79WoSJ7rfby+CromnRWV7DuCdW8ox1yMsSLPOe0A0Ns9IMaeybrqYV
         Ju6dWv7Szicqh/4R6fQGBlwqrOXm3ouR2CUESr5KtGSkCx2MubG/c1Kygd8QD/LV17l6
         KA49/W9koeTbEvCW3H8ptBywL0QgDM6WNS3ekeU9p3BiPZs6m6iBA0E5LFSKqQYfNvQ8
         oQANM58w3FW461XU1bEDRBOBQ/9eBpQEWNUYLgTQ6qw836NSSB6LlTI59f1VZYVPATTZ
         3j0rcQRbgBzNat61bDFZ/AynkxHP6fp9myR7r7HdL3BGDFxC+ewB9hXtVr/+/T4pIGIp
         S4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+FQuRGc8rqkhVhmp5Ax5z+iMJbnz2uN3otK7AnJ6WQ=;
        b=FqCTHr3u7vHUQMspwyVy/TwDtE5U1Nr6xky2yFAdzC1yi/Kw8Iszr02IHZIS1YcAZT
         6CyBTh8uufnWYfFP9YsYheyNHrpiTrgBVmNfgbgtfS0DHID/oPLClyDRhE6kGseHnRUK
         oz+RTo+s5YsxAPDpW0+EZNjfAEmxkrclqCiMpqc9etEQEkb6VnLPhngGktKrlODtq2xP
         lsQmNxDDeorJUr9gRuO0l3VThiUOb4Cn5dhiAJGhBE9/rQD8qcVxDu9CNEICrh4EX0sR
         s3d9lYC2I6uNlbsjJHFAKX+NWxrnaj4526hbNXQvZ2OhTGNOU4xWcQjiFUXLZWgRjglD
         QN+A==
X-Gm-Message-State: AOPr4FVqEck1iuXrmdZugwyJ25yj9dxGW26ONTJpfBzglCkPNwdQf8Al+hdi3PVoPvjAJw==
X-Received: by 10.66.26.43 with SMTP id i11mr2944009pag.58.1462277321463;
        Tue, 03 May 2016 05:08:41 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 88sm5529426pfj.20.2016.05.03.05.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:08:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:08:36 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293376>

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
