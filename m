From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/18] merge-file: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:56:07 +0700
Message-ID: <1267937767-12504-19-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8bg-0003VZ-7n
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083Ab0CGFAn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:00:43 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab0CGFAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:00:41 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3156711pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lqoLpnLe60BD5DyFsnH475wZ8OF1Q8iFEsZ4cjpPSVk=;
        b=Z1o9LG7pdmFQcPC7uOX0DQR+MLBGkvicZnX5MaZ9Md9DxrmktGwXfz1hmOMUWggsb0
         87wt6dlNM5arLROy+xfwKfjV485t8rS0j3MnxzwaT2bYtA3hnUY6HQYz9pcoN8QhtY4l
         G1Im9xxRfDHXaGoN/9rMkVQi2TwAXKbT/ogk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=P2yn2wQOkIfnRBIMgoaWBwaIEIkDRXH+al6KgvTLd3h/jAnKZWjTjeADU5ISCJckr3
         OCjkv1xXe+tapeVfls0+c/fuud22hYjgqMVJTAA28rrKA1TqtFkbhvVghIsL3TZkInfo
         X4Jn6WZeKzWBa26JNbwMrZ/wqo0luWY80mJc0=
Received: by 10.140.248.7 with SMTP id v7mr1978016rvh.237.1267938041449;
        Sat, 06 Mar 2010 21:00:41 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 23sm3222805pzk.10.2010.03.06.21.00.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 21:00:40 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:57:26 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141661>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge-file.c |    4 +---
 git.c                |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 1e70073..474c6c2 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -30,7 +30,6 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 	int level =3D XDL_MERGE_ZEALOUS_ALNUM;
 	int style =3D 0, quiet =3D 0;
 	int favor =3D 0;
-	int nongit;
=20
 	struct option options[] =3D {
 		OPT_BOOLEAN('p', "stdout", &to_stdout, "send results to standard out=
put"),
@@ -45,8 +44,7 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 		OPT_END(),
 	};
=20
-	prefix =3D setup_git_directory_gently(&nongit);
-	if (!nongit) {
+	if (startup_info->have_repository) {
 		/* Read the configuration file */
 		git_config(git_xmerge_config, NULL);
 		if (0 <=3D git_xmerge_style)
diff --git a/git.c b/git.c
index 3292627..88408c8 100644
--- a/git.c
+++ b/git.c
@@ -343,7 +343,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
-		{ "merge-file", cmd_merge_file },
+		{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 		{ "merge-index", cmd_merge_index, RUN_SETUP },
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE=
 },
--=20
1.7.0.195.g637a2
