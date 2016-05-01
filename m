From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 28/41] http.c: use error_errno() and warning_errno()
Date: Sun,  1 May 2016 18:14:44 +0700
Message-ID: <1462101297-8610-29-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:17:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpNn-0007oo-F3
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbcEALRs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:17:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34059 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALRr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:17:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id 145so16226546pfz.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pV6RZ1p+1oq/fdJUjZaS/3RUhTIAvJqDLyZISrvbfVM=;
        b=HkfOdzmF3F/0SGyC24+YXachyEkiPNYjL4NO3yC16rVB4J4zMcFD6Z/rtAmeagdKTE
         4i8/o14vyRKJJrTvb1/WrifXSzUNKSYgC9LJKk8xaNPK0Dgr6u/ywYf0dh+mSz8rhIFo
         DV8RcnhruGCQuxczYn0MtsRp2MB2FLKJ96j0uJEoLCNRpZj0IuNy1m7O5bQuoVDd6yri
         9Y8lpkemBq3aHTpabtghBMPR28EaVOr31WQUoPj+CVnlKYPB2KtvrYaa6SvYNVX4M2bI
         KFytDftSkkkaO/H+PwRB6VSO1DojuxaIltOUGhETrDyVq0yAcVmy6jBhgh7jgFTjQQRW
         WUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pV6RZ1p+1oq/fdJUjZaS/3RUhTIAvJqDLyZISrvbfVM=;
        b=FZ1K84s41cdAAxQZ2kuy4vX4niHfBcEw5DUxiDcaWPOahmRkEiRVQeLoeRkUIPr/aw
         aphR71eDIyb+l3Q3lY9QN7C0pQmTbmf/vdgYtOpI9I3MV77M0cQZJ7PSY547AryldKjU
         aj7JtD9WuEH1DHL4+01HomM5DGbZvn92ueohJer98geLasmK3zDTbp3uNkB7oF1tZw7E
         ITcBYENIOKSeuzPsdXOx22FFV/3MdN/GJJxogM+UUORLc6UiHeK3ekQTcETKE3lIuWAl
         q3Z9zvPekhfWThWacH7ei0dIddwlOvVXTmXh/55yDCJf/Fxd0c5FDmd6u7NN+We2VwcX
         4UsA==
X-Gm-Message-State: AOPr4FX7a2Eh8OipcAfzKxH3WMUwadRY6i0rEEdiU37szjMKc+cbcPmR5Q20fYewA+yMzg==
X-Received: by 10.98.28.65 with SMTP id c62mr43752122pfc.61.1462101466510;
        Sun, 01 May 2016 04:17:46 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id lz5sm37376244pab.34.2016.05.01.04.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:17:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:17:42 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293178>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 http.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index 4304b80..7565c93 100644
--- a/http.c
+++ b/http.c
@@ -446,8 +446,7 @@ static int sockopt_callback(void *client, curl_sock=
et_t fd, curlsocktype type)
=20
 	rc =3D setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, (void *)&ka, len);
 	if (rc < 0)
-		warning("unable to set SO_KEEPALIVE on socket %s",
-			strerror(errno));
+		warning_errno("unable to set SO_KEEPALIVE on socket");
=20
 	return 0; /* CURL_SOCKOPT_OK only exists since curl 7.21.5 */
 }
@@ -1894,8 +1893,7 @@ struct http_object_request *new_http_object_reque=
st(const char *base_url,
 	}
=20
 	if (freq->localfile < 0) {
-		error("Couldn't create temporary file %s: %s",
-		      freq->tmpfile, strerror(errno));
+		error_errno("Couldn't create temporary file %s", freq->tmpfile);
 		goto abort;
 	}
=20
@@ -1940,8 +1938,8 @@ struct http_object_request *new_http_object_reque=
st(const char *base_url,
 			prev_posn =3D 0;
 			lseek(freq->localfile, 0, SEEK_SET);
 			if (ftruncate(freq->localfile, 0) < 0) {
-				error("Couldn't truncate temporary file %s: %s",
-					  freq->tmpfile, strerror(errno));
+				error_errno("Couldn't truncate temporary file %s",
+					    freq->tmpfile);
 				goto abort;
 			}
 		}
--=20
2.8.0.rc0.210.gd302cd2
