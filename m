From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/43] builtin: introduce startup_info struct
Date: Mon,  5 Apr 2010 20:40:46 +0200
Message-ID: <1270492888-26589-2-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:42:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrFb-0005ZJ-K5
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab0DESlm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:41:42 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:61073 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864Ab0DESlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:41:40 -0400
Received: by gxk9 with SMTP id 9so3110488gxk.8
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LK5hsjaC8aFQ4SbTOW71syaqKhu42knuSpoWW8mFAvE=;
        b=yBRqS6J2KUy8e7Rq1MleHTRKl0qaVC8oFGN7M4ygGdZW/eVNF+DwdkumtsNj9McsMV
         JBxBW8RFsBgdMoDNuPFDTwAb7bAxYaFxag6Nq9iWEiArWfE33SQzB0rI2kD74VbfOwvN
         FXyVglPXj5WjD88AuIQ/apJXAZfkubmmfowQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZmTlmFMHKdnrfxoLrV8Dts7a3Elg5qQ9FgLkLlAAyy7JZH+ChGuz3i/hamBWTLgV20
         sRV/ehG9mdTFUpMpCfaq8XWok6laGmP0vYLeuCbA2fhKMYwa1eyLiQNCBjU8l3emw8EE
         2yayBEa3H4Q/sn48SjFh1AkoVpxMG719HuXEY=
Received: by 10.100.24.39 with SMTP id 39mr14212977anx.20.1270492898692;
        Mon, 05 Apr 2010 11:41:38 -0700 (PDT)
Received: from dektop ([72.14.241.38])
        by mx.google.com with ESMTPS id 13sm8306697gxk.0.2010.04.05.11.41.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:41:37 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:41:33 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144004>

The purpose of this struct is to make it easier to extend parameters
passed to builtin commands from run_builtin(), and let libgit aware of
some global states in future.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h       |    6 ++++++
 environment.c |    1 +
 git.c         |    9 +++++----
 setup.c       |   12 +++++++++++-
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 6dcb100..8d8f8ee 100644
--- a/cache.h
+++ b/cache.h
@@ -1061,4 +1061,10 @@ int split_cmdline(char *cmdline, const char ***a=
rgv);
 /* builtin/merge.c */
 int checkout_fast_forward(const unsigned char *from, const unsigned ch=
ar *to);
=20
+/* git.c */
+struct startup_info {
+	const char *prefix;
+};
+extern struct startup_info *startup_info;
+
 #endif /* CACHE_H */
diff --git a/environment.c b/environment.c
index 876c5e5..c36c902 100644
--- a/environment.c
+++ b/environment.c
@@ -52,6 +52,7 @@ enum object_creation_mode object_creation_mode =3D OB=
JECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
+struct startup_info *startup_info;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
diff --git a/git.c b/git.c
index 6bae305..4be34e4 100644
--- a/git.c
+++ b/git.c
@@ -13,6 +13,7 @@ const char git_usage_string[] =3D
 const char git_more_info_string[] =3D
 	"See 'git help COMMAND' for more information on a specific command.";
=20
+static struct startup_info git_startup_info;
 static int use_pager =3D -1;
 struct pager_config {
 	const char *cmd;
@@ -237,13 +238,13 @@ static int run_builtin(struct cmd_struct *p, int =
argc, const char **argv)
 {
 	int status, help;
 	struct stat st;
-	const char *prefix;
=20
-	prefix =3D NULL;
+	memset(&git_startup_info, 0, sizeof(git_startup_info));
+	startup_info =3D &git_startup_info;
 	help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
 	if (!help) {
 		if (p->option & RUN_SETUP)
-			prefix =3D setup_git_directory();
+			setup_git_directory();
=20
 		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
 			use_pager =3D check_pager_config(p->cmd);
@@ -257,7 +258,7 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const char **argv)
=20
 	trace_argv_printf(argv, "trace: built-in: git");
=20
-	status =3D p->fn(argc, argv, prefix);
+	status =3D p->fn(argc, argv, startup_info->prefix);
 	if (status)
 		return status;
=20
diff --git a/setup.c b/setup.c
index 5716d90..cf1b37d 100644
--- a/setup.c
+++ b/setup.c
@@ -315,7 +315,7 @@ const char *read_gitfile_gently(const char *path)
  * We cannot decide in this function whether we are in the work tree o=
r
  * not, since the config can only be read _after_ this function was ca=
lled.
  */
-const char *setup_git_directory_gently(int *nongit_ok)
+static const char *setup_git_directory_gently_1(int *nongit_ok)
 {
 	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRONME=
NT);
@@ -443,6 +443,16 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	return cwd + offset;
 }
=20
+const char *setup_git_directory_gently(int *nongit_ok)
+{
+	const char *prefix;
+
+	prefix =3D setup_git_directory_gently_1(nongit_ok);
+	if (startup_info)
+		startup_info->prefix =3D prefix;
+	return prefix;
+}
+
 int git_config_perm(const char *var, const char *value)
 {
 	int i;
--=20
1.7.0.rc1.541.g2da82.dirty
