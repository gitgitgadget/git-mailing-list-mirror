From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] setup: add worktree.path to shadow core.worktree
Date: Sun,  8 Feb 2015 20:16:33 +0700
Message-ID: <1423401394-13675-3-git-send-email-pclouds@gmail.com>
References: <1423401394-13675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Max Kirillov <max@max630.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 14:16:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKRjE-0002Ra-K7
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 14:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbbBHNQo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 08:16:44 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:44313 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbBHNQn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 08:16:43 -0500
Received: by mail-pa0-f52.google.com with SMTP id ey11so3456029pad.11
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 05:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2qWdHbdkUwhdbKitJipaw/msW/L9knMDt/vNm8YIEDo=;
        b=SFrH7/4lygPegNI2TCd45F2b45PyxJI0fWkR7l5iixV2mEhM/eJjHLt0hwfpnoLX+M
         oJDS5LqwH9SeImetNGV4qR3nv5wBL6bUulpS5HGFuHANXPzURI9qaQUkGLnwX8M9Qt+g
         NFbX57znJuiPxev4OSXjPKv9ez6FuXVY3Ssy+YGt33SvnM8REfDXOz60+wTVUvr2JQ6x
         /PQcXTEcgKVV6KZ24Kba3hSA1w/D6KMcX99avDfLi0Hx0TD+mvGnc7+AQE2W5g8Cn5zV
         9NP/Bu7YTnJ82iR8lDoueHIgOYepQzavnk/Cz6Et0rHuaiXhUxuZAICgQlXEMtHIieDa
         h6og==
X-Received: by 10.70.88.231 with SMTP id bj7mr20427198pdb.168.1423401403436;
        Sun, 08 Feb 2015 05:16:43 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id in1sm13437836pbc.19.2015.02.08.05.16.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 05:16:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 20:16:50 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423401394-13675-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263511>

They have the same purpose. But they are located in different places:
core.worktree in $GIT_DIR/config while worktree.path in
$GIT_DIR/config.worktree

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt | 3 +++
 setup.c                  | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 26e4e07..b717881 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -410,6 +410,7 @@ false), while all other repositories are assumed to=
 be bare (bare
 =3D true).
=20
 core.worktree::
+worktree.path::
 	Set the path to the root of the working tree.
 	This can be overridden by the GIT_WORK_TREE environment
 	variable and the '--work-tree' command-line option.
@@ -430,6 +431,8 @@ still use "/different/path" as the root of the work=
 tree and can cause
 confusion unless you know what you are doing (e.g. you are creating a
 read-only snapshot of the same index to a location different from the
 repository's usual working tree).
++
+worktree.path takes precedence over core.worktree.
=20
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
diff --git a/setup.c b/setup.c
index 979b13f..bc27f8b 100644
--- a/setup.c
+++ b/setup.c
@@ -4,6 +4,7 @@
=20
 static int inside_git_dir =3D -1;
 static int inside_work_tree =3D -1;
+static int worktree_path_set;
=20
 /*
  * The input parameter must contain an absolute path, and it must alre=
ady be
@@ -807,12 +808,16 @@ int check_repository_format_version(const char *v=
ar, const char *value, void *cb
 		is_bare_repository_cfg =3D git_config_bool(var, value);
 		if (is_bare_repository_cfg =3D=3D 1)
 			inside_work_tree =3D -1;
-	} else if (strcmp(var, "core.worktree") =3D=3D 0) {
+	} else if (strcmp(var, "worktree.path") =3D=3D 0 ||
+		   (strcmp(var, "core.worktree") =3D=3D 0 &&
+		    !worktree_path_set)) {
 		if (!value)
 			return config_error_nonbool(var);
 		free(git_work_tree_cfg);
 		git_work_tree_cfg =3D xstrdup(value);
 		inside_work_tree =3D -1;
+		if (!strcmp(var, "worktree.path"))
+			worktree_path_set =3D 1;
 	}
 	return 0;
 }
--=20
2.3.0.rc1.137.g477eb31
