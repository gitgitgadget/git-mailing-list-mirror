From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/18] bundle: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:56:02 +0700
Message-ID: <1267937767-12504-14-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8bd-0003VZ-AV
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847Ab0CGFAX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:00:23 -0500
Received: from mail-px0-f188.google.com ([209.85.216.188]:64840 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0CGFAT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:00:19 -0500
Received: by pxi26 with SMTP id 26so1738408pxi.1
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LK0OIT8PYL8SYJhsgO7kYPSb3t46fAixo018GayBx78=;
        b=N5Fa304Pmoz8FpKwYI62dfaa2jzY8ZNoaNV5VoRsBB2I7Up/6Zzjag/h+bqpCN4vjl
         PRz9zM2P5c938zHjjPzS3zxaKiYWNFVgP3VdB2dSPu/4TZjXkV9WMOjea0HkBA1ocnmQ
         LZ6bC+NhTKzaBL2X43QfWEp67jTW8DRiyiAA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Xc/YMLgrlZXn6/0o4N0ynarJT5TdnOoBNwKFoYC56SFJDRH27t4auyn+YGAR8snRP7
         HH7CRA6ekMVqEqpTHifHTsYViB3sOatsAAiQebcg7AcHFvaNCdPvHZl+T7tgD27hjUhZ
         lh6QFeyh4VB0DhC9+Y+gwdlcezDjA8vIXMKB0=
Received: by 10.114.21.17 with SMTP id 17mr1059637wau.168.1267938019120;
        Sat, 06 Mar 2010 21:00:19 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 21sm3263914pzk.0.2010.03.06.21.00.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 21:00:18 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:57:03 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141656>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/bundle.c |    6 ++----
 git.c            |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 2006cc5..80649ba 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -18,7 +18,6 @@ static const char builtin_bundle_usage[] =3D
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
 	struct bundle_header header;
-	int nongit;
 	const char *cmd, *bundle_file;
 	int bundle_fd =3D -1;
 	char buffer[PATH_MAX];
@@ -31,7 +30,6 @@ int cmd_bundle(int argc, const char **argv, const cha=
r *prefix)
 	argc -=3D 2;
 	argv +=3D 2;
=20
-	prefix =3D setup_git_directory_gently(&nongit);
 	if (prefix && bundle_file[0] !=3D '/') {
 		snprintf(buffer, sizeof(buffer), "%s/%s", prefix, bundle_file);
 		bundle_file =3D buffer;
@@ -54,11 +52,11 @@ int cmd_bundle(int argc, const char **argv, const c=
har *prefix)
 		return !!list_bundle_refs(&header, argc, argv);
 	}
 	if (!strcmp(cmd, "create")) {
-		if (nongit)
+		if (!startup_info->have_repository)
 			die("Need a repository to create a bundle.");
 		return !!create_bundle(&header, bundle_file, argc, argv);
 	} else if (!strcmp(cmd, "unbundle")) {
-		if (nongit)
+		if (!startup_info->have_repository)
 			die("Need a repository to unbundle.");
 		return !!unbundle(&header, bundle_fd) ||
 			list_bundle_refs(&header, argc, argv);
diff --git a/git.c b/git.c
index 7820d22..a90e0c3 100644
--- a/git.c
+++ b/git.c
@@ -299,7 +299,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE }=
,
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
-		{ "bundle", cmd_bundle },
+		{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 		{ "checkout-index", cmd_checkout_index,
--=20
1.7.0.195.g637a2
