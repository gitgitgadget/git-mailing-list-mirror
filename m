From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/21] list-files: make alias 'ls' default to 'list-files'
Date: Sun,  8 Feb 2015 16:01:28 +0700
Message-ID: <1423386099-19994-11-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:03:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNm0-00067Q-1T
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583AbbBHJDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:03:17 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:64765 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbbBHJDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:03:14 -0500
Received: by mail-pa0-f48.google.com with SMTP id eu11so5066020pac.7
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ckPEgfl5VwxWJijr8vZAAiQl4sf3mNwTy3IJjtGNiKY=;
        b=zDxonPS3zS5s8dcD4vbfIe67Ox9jWXfdJ/bzjiE4CEV00kNg7mKVRvm2xLOyXR4BAl
         1vQd7RMpimeIxRcgE5/jThiunD4tWbSvQECIZyF7royhOgI3Q5JW/Sy6/QX2HVTwbqOd
         JsOsBY0bVKpvLZZcZ+5Iq9Kc5IbLp+9kK6kl5eBrZRDx+/ZuffQzD4/QO4sO9VyVjFcx
         b9v+albuI33d60gS0itd46m/hCHsNB6krme4gNjW2SU/l54FA752Vq9TDlq31JblJ4EZ
         c/vK2sarJgQZZae3AzYFUz9Mu8FwkoBkS4K/jBugyLtcbURSfsoCcEEGOxMxVndlOHwW
         Vu+Q==
X-Received: by 10.68.132.103 with SMTP id ot7mr9930615pbb.0.1423386193952;
        Sun, 08 Feb 2015 01:03:13 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id c9sm12958072pdm.51.2015.02.08.01.03.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:03:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:03:21 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263497>

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
2.3.0.rc1.137.g477eb31
