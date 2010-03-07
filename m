From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/18] apply: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:56:01 +0700
Message-ID: <1267937767-12504-13-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8bL-0002Hr-UZ
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795Ab0CGFAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:00:18 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0CGFAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:00:15 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3156711pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=P204nODAm3LGzVIs+dhgAkIGi/tYDRpQqDuG3a/xGVo=;
        b=lOzVJlkTclXUkaQ3j/1StRfKa2alPuPeEWWYXbtClwvJ+etHW5RvyvjXvrZQreNgsj
         FeUpeMr92PxMB+TeA66mDJFrBgTQy5H5CBEAljnNRC6ijjb/4IHciYFTYwofr9UQxqpl
         pER56UppAVdaelRK8iICaAVQ8dC2Vxx4XcyuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=i/iTVIMUrfg06UCKmtqb1UlSgLDZ/eu9mz+lg2GJYHA9kY3RZxTlNy1o9kOsi5xzPw
         2wobmg+V13tmK3NlQi9zTPWKoBGG9xK0MhBhVCr0qo6g6Sdbgao0lwnXqOENtocRUKyU
         buKS2wrHB8jvH9vpSq9o6XuGa94Zi3pPSVGl0=
Received: by 10.115.99.29 with SMTP id b29mr2112055wam.131.1267938014958;
        Sat, 06 Mar 2010 21:00:14 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 23sm3222464pzk.10.2010.03.06.21.00.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 21:00:14 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:56:59 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141655>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c |    7 +++----
 git.c           |    2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 3af4ae0..d27aac6 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3516,7 +3516,6 @@ int cmd_apply(int argc, const char **argv, const =
char *unused_prefix)
 {
 	int i;
 	int errs =3D 0;
-	int is_not_gitdir;
 	int binary;
 	int force_apply =3D 0;
=20
@@ -3589,7 +3588,7 @@ int cmd_apply(int argc, const char **argv, const =
char *unused_prefix)
 		OPT_END()
 	};
=20
-	prefix =3D setup_git_directory_gently(&is_not_gitdir);
+	prefix =3D startup_info->prefix;
 	prefix_length =3D prefix ? strlen(prefix) : 0;
 	git_config(git_apply_config, NULL);
 	if (apply_default_whitespace)
@@ -3604,10 +3603,10 @@ int cmd_apply(int argc, const char **argv, cons=
t char *unused_prefix)
 		apply =3D apply_verbosely =3D 1;
 	if (!force_apply && (diffstat || numstat || summary || check || fake_=
ancestor))
 		apply =3D 0;
-	if (check_index && is_not_gitdir)
+	if (check_index && !startup_info->have_repository)
 		die("--index outside a repository");
 	if (cached) {
-		if (is_not_gitdir)
+		if (!startup_info->have_repository)
 			die("--cached outside a repository");
 		check_index =3D 1;
 	}
diff --git a/git.c b/git.c
index 0e052c8..7820d22 100644
--- a/git.c
+++ b/git.c
@@ -294,7 +294,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
-		{ "apply", cmd_apply },
+		{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 		{ "archive", cmd_archive, RUN_SETUP_GENTLY },
 		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE }=
,
 		{ "blame", cmd_blame, RUN_SETUP },
--=20
1.7.0.195.g637a2
