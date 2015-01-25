From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/21] list-files: make alias 'ls' default to 'list-files'
Date: Sun, 25 Jan 2015 19:37:45 +0700
Message-ID: <1422189476-7518-11-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:28:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMIO-0002eR-8b
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbbAYM2A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:28:00 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:41892 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbbAYM16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:27:58 -0500
Received: by mail-pd0-f169.google.com with SMTP id g10so6876618pdj.0
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fu/3QEy54MlMxB+/D/RFKPJBBxJnxC3ohkt40jdnmHQ=;
        b=Xfr1C1KiZqMqAlJ1rIVXEHbhk17HSABzgVook+wdU3JBp0K/0aqVqmHOI2KJltz0qK
         4RCCTLuyR6lbD9xRJeAoUwq3GtSKZ2pOnUI9Q2Q19xACK6fxFmyW6VaDFcMVM0l0FTm5
         RJKjqQPKxt/8oanm7EFtbWgdkmffOmEFWX1/BglpkKqTxbN+tNv7RZs64l2Gr+yTPTRM
         +ptkUGFXA2Hol9RqUoiLjoRh+05vIJdEmc0AUL2nvxDQRAPhVMbDAJEo/q4SRRvhrMge
         hblg1lBsWeYFmoSmF5VXDtdr6TwUaX0Z+s11AvZTwfgK0b93nci07S3VNAuQB9ndZbYI
         IWMQ==
X-Received: by 10.68.102.163 with SMTP id fp3mr2470445pbb.105.1422188878522;
        Sun, 25 Jan 2015 04:27:58 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id gx1sm7107773pbd.57.2015.01.25.04.27.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:27:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:39:22 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263007>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-list-files.txt | 3 ++-
 config.c                         | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 3039e1e..2182a38 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -14,7 +14,8 @@ DESCRIPTION
 -----------
 List files (by default in current working directory) that are in the
 index. Depending on the chosen options, maybe only modified files in
-working tree are shown, or untracked files...
+working tree are shown, or untracked files... The builtin alias "ls"
+is set to "list-files".
=20
 OPTIONS
 -------
diff --git a/config.c b/config.c
index 15a2983..16209c6 100644
--- a/config.c
+++ b/config.c
@@ -40,6 +40,10 @@ static struct config_source *cf;
=20
 static int zlib_compression_seen;
=20
+static const char *builtin_config =3D
+	"[alias]\n"
+	"	ls =3D list-files\n";
+
 /*
  * Default config_set that contains key-value pairs from the usual set=
 of config
  * config files (i.e repo specific .git/config, user wide ~/.gitconfig=
, XDG
@@ -1175,6 +1179,10 @@ int git_config_early(config_fn_t fn, void *data,=
 const char *repo_config)
=20
 	home_config_paths(&user_config, &xdg_config, "config");
=20
+	if (git_config_system())
+		git_config_from_buf(fn, "<builtin>", builtin_config,
+				    strlen(builtin_config), data);
+
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, =
0)) {
 		ret +=3D git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
--=20
2.2.0.84.ge9c7a8a
