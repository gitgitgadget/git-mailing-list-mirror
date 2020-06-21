Return-Path: <SRS0=gxdb=AC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14697C433DF
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 18:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C003525227
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 18:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="yGaZtcSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgFUSq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Jun 2020 14:46:59 -0400
Received: from mr85p00im-zteg06011501.me.com ([17.58.23.182]:59830 "EHLO
        mr85p00im-zteg06011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728649AbgFUSq6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Jun 2020 14:46:58 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jun 2020 14:46:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1592764847; bh=wkk9OtWBFyLdV7Tnihsb2/2hFRm4FYlBRGiOFUjYJIs=;
        h=From:Content-Type:Subject:Message-Id:Date:To;
        b=yGaZtcSepIdkVb/j0N2kJUeh2mteMxihbAgDfdKXvujPflXNdfAb9g+2VxWRnXHbp
         vE6xqNN0MOqvEnyCK+rQN2M3Lh9voyj5UHc/C6dTggez74K/EA7rug1+xt/30zTcKw
         dOELXBoOfCIEckIBnFLIl7y4qOve0Zso84ShQ56WTOPYUHTZlakAUr930FJtdvf6m2
         14YlXNZ1IZ7v/VOvUgZ95+9TxI4Wv/wTxjgFznTewFd/9ibWTmrugdEx/Rg3LTn+Eo
         RcYnOMRNGdoDKiGD5muyKSOCq/8vdBU+VbzR0lHC3niJuivx0AYtLMkPEm18A/Fu6b
         Ls/kQ5cB7T4vw==
Received: from [192.168.1.103] (unknown [88.232.43.146])
        by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id A78932A03DD;
        Sun, 21 Jun 2020 18:40:46 +0000 (UTC)
From:   =?utf-8?Q?Emir_Y=C3=A2sin_SARI?= <bitigchi@me.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: [PATCH] haiku: add Haiku support
Message-Id: <35DF1103-EF57-446A-985F-051B2D3057BD@me.com>
Date:   Sun, 21 Jun 2020 21:40:42 +0300
Cc:     Adrien Destugues <pulkomandy@pulkomandy.tk>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-21_12:2020-06-19,2020-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=14 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2004280000 definitions=main-2006210147
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Below you can find the current Haiku patches for upstream approval.

Currently Haiku is built with this [1] make configuration. Therefore =
it=E2=80=99s not possible to build the Haiku version with just =
=E2=80=98make=E2=80=99 yet.
I need help in adapting this configuration to the current Git Makefile, =
I don=E2=80=99t have much experience in Makefiles.
Or if it=E2=80=99s trivial, any quick-fix help is appreciated :).

In the meantime, please find the patchset below for review.

[1] =
https://github.com/haikuports/haikuports/blob/02adc9b2c68a0ad51bc4db5699b4=
6adc15c24c5c/dev-vcs/git/git-2.27.0.recipe#L138

=46rom 2ac0c135d7c12a2581fe70ed1c8ffb4809950b55 Mon Sep 17 00:00:00 2001
From: Emir Sar=C4=B1 <bitigchi@me.com>
Date: Sun, 21 Jun 2020 21:02:23 +0300
Subject: [PATCH] haiku: add Haiku support
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

This commit is a collection of minor patches previously applied as a
Haikuports patchset at github.com/haikuports/haikuports repository for
Git Haiku port.

Patchset history:

=46rom 56acac1a903dcbdd37c3b57fc168ad20179596b1 Mon Sep 17 00:00:00 2001
From: Ingo Weinhold <ingo_weinhold@gmx.de>
Date: Tue, 13 Aug 2013 08:07:25 +0200
Subject: git-web--browse.sh: use "open" on Haiku

=46rom 0f557f23acaef82951851dc2165c9a9a4065703e Mon Sep 17 00:00:00 2001
From: Ingo Weinhold <ingo_weinhold@gmx.de>
Date: Mon, 19 Jan 2015 15:37:16 -0500
Subject: On Haiku use the user settings directory instead of HOME

=46rom 2df42bd79662a4db16c91348283c22bddd728523 Mon Sep 17 00:00:00 2001
From: Oliver Tappe <zooey@hirschkaefer.de>
Date: Mon, 19 Jan 2015 15:50:09 -0500
Subject: Ensure config-directory exists before using it.

=46rom e2d721e9456e591cd467759a5b8fa6a9102df0b7 Mon Sep 17 00:00:00 2001
From: Adrien Destugues <pulkomandy@pulkomandy.tk>
Date: Sun, 14 Feb 2016 10:32:12 +0100
Subject: Move credential cache to the config directory.

=46rom 5841649bb9d07c614031f95dc211e066b9f4650a Mon Sep 17 00:00:00 2001
From: sfanxiang <sfanxiang@gmail.com>
Date: Mon, 1 Jan 2018 13:26:28 +0000
Subject: builtin: config: use xdg_config even if it does not exist

=46rom 82d3fea48bc155df46881f065349b3408c4ac75b Mon Sep 17 00:00:00 2001
From: Adrien Destugues <pulkomandy@pulkomandy.tk>
Date: Sun, 18 Nov 2018 11:56:26 +0100
Subject: Fix detection of Haiku for git web browse

Plus final code formatting and modifying existing patches to coexist
with the current code: Myself.

Signed-off-by: Emir Sar=C4=B1 <bitigchi@me.com>
---
 builtin/config.c   |  9 +++++++++
 config.c           |  7 +++++++
 credential-cache.c |  4 ++++
 git-web--browse.sh |  5 +++++
 path.c             | 14 ++++++++++++--
 5 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ee4aef6..f9dfd08 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -645,6 +645,14 @@ int cmd_config(int argc, const char **argv, const =
char *prefix)
 		char *user_config =3D expand_user_path("~/.gitconfig", =
0);
 		char *xdg_config =3D xdg_config_home("config");
=20
+		#ifdef __HAIKU__
+		if (!xdg_config) {
+			given_config_source.file =3D user_config;
+		} else {
+			given_config_source.file =3D xdg_config;
+			if (user_config) free(user_config);
+		}
+		#else
 		if (!user_config)
 			/*
 			 * It is unknown if HOME/.gitconfig exists, so
@@ -664,6 +672,7 @@ int cmd_config(int argc, const char **argv, const =
char *prefix)
 			given_config_source.file =3D user_config;
 			free(xdg_config);
 		}
+		#endif
 	}
 	else if (use_system_config) {
 		given_config_source.file =3D git_etc_gitconfig();
diff --git a/config.c b/config.c
index 8db9c77..b956ff9 100644
--- a/config.c
+++ b/config.c
@@ -2745,6 +2745,7 @@ int git_config_set_multivar_in_file_gently(const =
char *config_filename,
 	int ret;
 	struct lock_file lock =3D LOCK_INIT;
 	char *filename_buf =3D NULL;
+	char *config_dir =3D NULL;
 	char *contents =3D NULL;
 	size_t contents_sz;
 	struct config_store_data store;
@@ -2761,6 +2762,12 @@ int git_config_set_multivar_in_file_gently(const =
char *config_filename,
 	if (!config_filename)
 		config_filename =3D filename_buf =3D =
git_pathdup("config");
=20
+	config_dir =3D xstrdup(config_filename);
+	* find_last_dir_sep(config_dir) =3D '\0';
+	if (access(config_dir, F_OK) !=3D 0)
+		mkdir(config_dir, 0755);
+	free(config_dir);
+
 	/*
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
diff --git a/credential-cache.c b/credential-cache.c
index 1cccc3a..fe0d94c 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -87,7 +87,11 @@ static char *get_socket_path(void)
 {
 	struct stat sb;
 	char *old_dir, *socket;
+	#ifdef __HAIKU__
+	old_dir =3D xdg_config_home("credential-cache");
+	#else
 	old_dir =3D expand_user_path("~/.git-credential-cache", 0);
+	#endif
 	if (old_dir && !stat(old_dir, &sb) && S_ISDIR(sb.st_mode))
 		socket =3D xstrfmt("%s/socket", old_dir);
 	else
diff --git a/git-web--browse.sh b/git-web--browse.sh
index ae15253..bf9135c 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -133,6 +133,11 @@ if test -z "$browser" ; then
 		browser_candidates=3D"cygstart $browser_candidates"
 	fi
=20
+	# BEINCLUDES indicates Haiku
+	if test -f $BEINCLUDES; then
+		browser_candidates=3D"open $browser_candidates"
+	fi
+
 	for i in $browser_candidates; do
 		init_browser_path $i
 		if type "$browser_path" > /dev/null 2>&1; then
diff --git a/path.c b/path.c
index 8b2c753..2fa8c56 100644
--- a/path.c
+++ b/path.c
@@ -12,6 +12,10 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "lockfile.h"
+#ifdef __HAIKU__
+#include <FindDirectory.h>
+#include <StorageDefs.h>
+#endif
=20
 static int get_st_mode_bits(const char *path, int *mode)
 {
@@ -1500,16 +1504,22 @@ int looks_like_command_line_option(const char =
*str)
=20
 char *xdg_config_home(const char *filename)
 {
+	#ifdef __HAIKU__
+	char settingsPath[B_PATH_NAME_LENGTH];
+	assert(filename);
+	if (find_directory(B_USER_SETTINGS_DIRECTORY, -1, true, =
settingsPath,
+		sizeof(settingsPath)) =3D=3D B_OK)
+		return mkpathdup("%s/git/%s", settingsPath, filename);
+	#else
 	const char *home, *config_home;
-
 	assert(filename);
 	config_home =3D getenv("XDG_CONFIG_HOME");
 	if (config_home && *config_home)
 		return mkpathdup("%s/git/%s", config_home, filename);
-
 	home =3D getenv("HOME");
 	if (home)
 		return mkpathdup("%s/.config/git/%s", home, filename);
+	#endif
 	return NULL;
 }
=20
--=20
2.27.0


