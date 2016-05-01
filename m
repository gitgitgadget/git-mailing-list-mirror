From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/41] builtin/merge-file.c: use error_errno()
Date: Sun,  1 May 2016 18:14:25 +0700
Message-ID: <1462101297-8610-10-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:16:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpMA-0006z1-Km
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbcEALQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:16:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34779 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbcEALQE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:16:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id 145so16224931pfz.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8n8e5obNaheWOFTACXc1S60e/ZpEkj2Kn4uPIGdZ5lc=;
        b=vvv9VMbx+zrTZ7ZT8V0ZlrChA3w++pgaZaYXHkPjvxEIfYUgtExAL8TxRPEG71SE6e
         FuEjI+kfdHl/7YKGJgKGawovUOM+MVhTcorm+V72TPiGaalcfN8Wj9EWZdns9+mNXgcg
         vkfmkg5ab7wl8jTp6RW9cL4KjcDM24EcLWp39Qt7ppwUNg0UUW0heMd/9l/MLtyFXHJi
         BYif+/jcMRQpcWT1Yhi6p2AlRAQlCE4dTYTLyOPPDDbaZPafOktolyxySdhs9lOJJI65
         9z0RF8ZeZ1eILL5V+Z0OmQIRQsZOG6P2vl/HLanQAtKn4195WXfCoSDLn+EXaNWgrkU8
         pc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8n8e5obNaheWOFTACXc1S60e/ZpEkj2Kn4uPIGdZ5lc=;
        b=e1w99fLC7UQmHHjA6w9LIcD12KbPtlENt38RncNbZSHPHCTFHZNntvRKB4TQbu+xSA
         aXVVTitPuz2CrzfpueaOexuWwQoURDqDIcuoewQ3ST3g/jF/yU4lkh1bijYI3OBm2yVn
         U0M6dOQaVuwPNGdrjHh9JFVoFDb7G5GFbcM73xpCg4c1uOHOCv1XdrTnxYEPg2b87HWW
         wap1n6B/vWleKVbd4HjAF9ZkcWMjFomDm4E33Uiq4v0OORzT5XWOdWGA72vK2E4laEt9
         grljv5htgRk6LRBOFfCFq4nE/MI7jxphEeqyYw8SIMVDLHwfZZsqHpqMvGD3IObnd8Z6
         yW4g==
X-Gm-Message-State: AOPr4FVLi9SHHfTAXnvIl5tKdFbXBhSN4fEZahTvBN2nOhcyoj37jfVUIYDmX8283/UGDQ==
X-Received: by 10.98.18.80 with SMTP id a77mr42854509pfj.27.1462101363387;
        Sun, 01 May 2016 04:16:03 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id eh9sm37322445pad.47.2016.05.01.04.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:16:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:15:58 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293159>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge-file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 5544705..13e22a2 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -62,8 +62,7 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 		usage_with_options(merge_file_usage, options);
 	if (quiet) {
 		if (!freopen("/dev/null", "w", stderr))
-			return error("failed to redirect stderr to /dev/null: "
-				     "%s", strerror(errno));
+			return error_errno("failed to redirect stderr to /dev/null");
 	}
=20
 	if (prefix)
@@ -95,12 +94,13 @@ int cmd_merge_file(int argc, const char **argv, con=
st char *prefix)
 		FILE *f =3D to_stdout ? stdout : fopen(fpath, "wb");
=20
 		if (!f)
-			ret =3D error("Could not open %s for writing", filename);
+			ret =3D error_errno("Could not open %s for writing",
+					  filename);
 		else if (result.size &&
 			 fwrite(result.ptr, result.size, 1, f) !=3D 1)
-			ret =3D error("Could not write to %s", filename);
+			ret =3D error_errno("Could not write to %s", filename);
 		else if (fclose(f))
-			ret =3D error("Could not close %s", filename);
+			ret =3D error_errno("Could not close %s", filename);
 		free(result.ptr);
 	}
=20
--=20
2.8.0.rc0.210.gd302cd2
