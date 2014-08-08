From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/8] mv: no "Huh?" to the user
Date: Fri,  8 Aug 2014 20:10:56 +0700
Message-ID: <1407503462-32632-3-git-send-email-pclouds@gmail.com>
References: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 15:11:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFjx7-0000cE-6c
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 15:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670AbaHHNLT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2014 09:11:19 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:60090 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756661AbaHHNLS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 09:11:18 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so1080134pde.24
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 06:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xzue8ogD9RZSUwMAx/rImOBCj30mMfi7SJjK2oL0krs=;
        b=gA957owgwFMyDihdNuYAHNaonLrWEvoqLjhlljkgK+cIOigLDKXzBvhzs5JubEj49M
         QW1TRY0+HD43Zkg2ViAjq7NwSSuQrck2jLdH0Z+7/5eUeZTpK2uQ96E9QRAX2twdIyIa
         YlRdWtnqyIEbTTLwoKQtSVQq3mPsMy04cJ9P+9567u3ZfbTArtRgBSG4Pkag6T1arslx
         GWcJ9DOJ4bFUyjLPbpBksJxOKhcEm4ssvP4auN/A+e12h44Zbzxj12vjvrASRDiHiBTm
         VqAOqkBZWJd9gFVnHMv2fHdTekM56Cq9S+VNRqfH+ALXzyzEfLUsSO6gGf1Smr7Bo3D+
         bwJw==
X-Received: by 10.66.141.134 with SMTP id ro6mr24406674pab.0.1407503478255;
        Fri, 08 Aug 2014 06:11:18 -0700 (PDT)
Received: from lanh ([115.73.206.39])
        by mx.google.com with ESMTPSA id y1sm2973593pbw.87.2014.08.08.06.11.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Aug 2014 06:11:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 08 Aug 2014 20:11:21 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255008>

Although if we are frisky, this could do

   static NORETURN void die_builtin(const char *err, va_list params)
   {
  -	vreportf("fatal: ", err, params);
  +	vreportf("Huh? ", err, params);
   	exit(128);
   }

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index b892f63..a7e02c0 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -135,7 +135,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 			if (first >=3D 0) {
 				struct strbuf submodule_dotgit =3D STRBUF_INIT;
 				if (!S_ISGITLINK(active_cache[first]->ce_mode))
-					die (_("Huh? Directory %s is in index and no submodule?"), src);
+					die (_("Directory %s is in index and no submodule?"), src);
 				if (!is_staging_gitmodules_ok())
 					die (_("Please, stage your changes to .gitmodules or stash them t=
o proceed"));
 				strbuf_addf(&submodule_dotgit, "%s/.git", src);
@@ -153,8 +153,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
=20
 				first =3D cache_name_pos(src_w_slash, len_w_slash);
 				if (first >=3D 0)
-					die (_("Huh? %.*s is in index?"),
-							len_w_slash, src_w_slash);
+					die (_("%.*s is in index"), len_w_slash, src_w_slash);
=20
 				first =3D -1 - first;
 				for (last =3D first; last < active_nr; last++) {
--=20
2.1.0.rc0.78.gc0d8480
