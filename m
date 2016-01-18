From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/6] setup.c: record the location of .git file
Date: Mon, 18 Jan 2016 18:21:33 +0700
Message-ID: <1453116094-4987-6-git-send-email-pclouds@gmail.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 12:04:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aL7bb-00048i-28
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 12:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbcARLEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2016 06:04:09 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33496 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479AbcARLEF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 06:04:05 -0500
Received: by mail-pf0-f196.google.com with SMTP id e65so11653007pfe.0
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 03:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dtyfn1AQeU4w7Jf3L1JZ43qQQwTB4d1ZDQLBWjHA0HE=;
        b=OcWy73XHXHdVhUJ3/KrMeFo1YyLURDZoofRqPkjbz/hg4RGQP2tfg5B1kUqPP+4Skl
         xd+TTl5R6FKKqGVSH/nRhH8nMcs/vudoA1MF4hPxaSJHITQNW5fiV8oJgjg0z2WrzKPi
         1cpz5KcRBOmVzDbv1in91MiXQSkOwBOu5r1ZYvv5SThxCfgYX7Y8G2akUkxGF0oyS6Du
         v14fvu2p9BGgX+3n5S+s+Xys1xbNzdUWVLSdYKHCV0NbSbeWwQQ9eUyGKh8nA5Vrv06q
         GVpWzWktFJD0uAmeSxQGm1NoVt+xZEVNLlRUu1PSXW2CJMYRz/r/Efkj0pdx8kzQ+ySu
         GwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=dtyfn1AQeU4w7Jf3L1JZ43qQQwTB4d1ZDQLBWjHA0HE=;
        b=IwlZ7IsgTI8uK8BCJHXP3bzs1KSodWeaF4+ftnmhJ0tRfoZquoVoa1kErr8GfhXMAn
         81UmgshytCl0cAWeYpQJUxTHshsZIc7/FBy5W2PfAtAF7wh1Vo68b3/1sx4nrra/qWPq
         PZmkCNTyldksevNqjbr9WkUg7GIAJtc15Q4r/K8sp/NCpLMljUA8AnALJbu/ssHB2zXN
         CViXY6F2Zw4alw9fK0M5ALroRQeeFGy6XIZvYfhSUTRsZ9UHnZ11z3gs7cPvR/BItb2H
         IJGuICYxk1SbCY+RsDNW22U3lhIweQ8FY8vSByDHOPK0ODbFeD5CDTTf6JZS5tppr5py
         xKCQ==
X-Gm-Message-State: AG10YOTOHPYac7wJXVF/wohzbs4GQrvb8dWYJHg2XU03BxdFRn7NPhX/cAKN0orZrkLODQ==
X-Received: by 10.98.40.131 with SMTP id o125mr14928716pfo.83.1453115045200;
        Mon, 18 Jan 2016 03:04:05 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id g87sm33258054pfj.1.2016.01.18.03.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 03:04:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 18 Jan 2016 18:22:07 +0700
X-Mailer: git-send-email 2.7.0.96.g5373197
In-Reply-To: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284289>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |  1 +
 setup.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index fbe29ac..c912afb 100644
--- a/cache.h
+++ b/cache.h
@@ -1728,6 +1728,7 @@ const char *split_cmdline_strerror(int cmdline_er=
rno);
 struct startup_info {
 	int have_repository;
 	const char *prefix;
+	const char *first_gitfile;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/setup.c b/setup.c
index 8b02429..0489f54 100644
--- a/setup.c
+++ b/setup.c
@@ -550,6 +550,8 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
 	gitfile =3D (char*)read_gitfile(gitdirenv);
 	if (gitfile) {
 		gitfile =3D xstrdup(gitfile);
+		if (startup_info && !startup_info->first_gitfile)
+			startup_info->first_gitfile =3D real_path_dup(gitdirenv);
 		gitdirenv =3D gitfile;
 	}
=20
@@ -834,9 +836,12 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 		current_device =3D get_device_or_die(".", NULL, 0);
 	for (;;) {
 		gitfile =3D (char*)read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
-		if (gitfile)
+		if (gitfile) {
 			gitdirenv =3D gitfile =3D xstrdup(gitfile);
-		else {
+			if (startup_info && !startup_info->first_gitfile)
+				startup_info->first_gitfile =3D
+					real_path_dup(DEFAULT_GIT_DIR_ENVIRONMENT);
+		} else {
 			if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
 				gitdirenv =3D DEFAULT_GIT_DIR_ENVIRONMENT;
 		}
@@ -885,6 +890,9 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 {
 	const char *prefix;
=20
+	if (startup_info)
+		startup_info->first_gitfile =3D NULL;
+
 	prefix =3D setup_git_directory_gently_1(nongit_ok);
 	if (prefix)
 		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
--=20
2.7.0.96.g5373197
