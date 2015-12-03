From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] git.c: make it clear save_env() is for alias handling only
Date: Thu,  3 Dec 2015 19:17:55 +0100
Message-ID: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
References: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
	asottile@umich.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 03 19:18:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4YSd-0001fd-6V
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 19:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbbLCSSZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Dec 2015 13:18:25 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36724 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbbLCSSW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 13:18:22 -0500
Received: by wmww144 with SMTP id w144so32653973wmw.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 10:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=z57PT8Qk5fBAAxW51FjaQTHktwl6ZDzJGLoCi4n44L0=;
        b=uRA8SupkGc590jISvc6jmn7tcd2HyvT7LaXBdAUg8HC6cmwnViuKXyrZ4fbAlPKgNQ
         /dabsnhhhSsVhWdLHIAyCGIVRZxoE6bHUuWayGnQyDIq9ndWNQESfMTiDKVjG8MBGwh1
         pEaCCryJ+qVaGymjnTCpDKJ/N+/XWm8/LoOjt+5/taiMIk+KrS9PEBF9DTFEHeSatwS4
         iCgqxpB3e33Db/AqAfiVlIgl7zP+Sc0IYBlt9FMySaogj4zhh3jguOnHsBP2WGVPxXst
         PHwj3lHADN2MGfW7Q5Z3bEG17nScXAjDwSLmesKJUfzC8MndhKzul814ztzey2wweHLf
         plZA==
X-Received: by 10.28.210.74 with SMTP id j71mr81430wmg.96.1449166701550;
        Thu, 03 Dec 2015 10:18:21 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id e83sm52672wmc.23.2015.12.03.10.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Dec 2015 10:18:20 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281961>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index 6ed824c..6ce7043 100644
--- a/git.c
+++ b/git.c
@@ -25,14 +25,14 @@ static const char *env_names[] =3D {
 	GIT_PREFIX_ENVIRONMENT
 };
 static char *orig_env[4];
-static int saved_environment;
+static int saved_env_before_alias;
=20
-static void save_env(void)
+static void save_env_before_alias(void)
 {
 	int i;
-	if (saved_environment)
+	if (saved_env_before_alias)
 		return;
-	saved_environment =3D 1;
+	saved_env_before_alias =3D 1;
 	orig_cwd =3D xgetcwd();
 	for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
 		orig_env[i] =3D getenv(env_names[i]);
@@ -233,6 +233,7 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 	char *alias_string;
 	int unused_nongit;
=20
+	save_env_before_alias();
 	subdir =3D setup_git_directory_gently(&unused_nongit);
=20
 	alias_command =3D (*argv)[0];
@@ -530,7 +531,7 @@ static void handle_builtin(int argc, const char **a=
rgv)
=20
 	builtin =3D get_builtin(cmd);
 	if (builtin) {
-		if (saved_environment && (builtin->option & NO_SETUP))
+		if (saved_env_before_alias && (builtin->option & NO_SETUP))
 			restore_env();
 		else
 			exit(run_builtin(builtin, argc, argv));
@@ -590,7 +591,6 @@ static int run_argv(int *argcp, const char ***argv)
 		 */
 		if (done_alias)
 			break;
-		save_env();
 		if (!handle_alias(argcp, argv))
 			break;
 		done_alias =3D 1;
--=20
2.2.0.513.g477eb31
