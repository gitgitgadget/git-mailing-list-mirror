From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 24/33] init: allow alternate ref strorage to be set for new repos
Date: Mon, 29 Feb 2016 19:52:57 -0500
Message-ID: <1456793586-22082-25-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZd-00078C-5r
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbcCAAx6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 19:53:58 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33266 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbcCAAxz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:55 -0500
Received: by mail-qk0-f182.google.com with SMTP id s5so63750875qkd.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O5K3vtSDRGsCZXj5hJ10Vv4+kmt/R6WCP94ggra/WkU=;
        b=ur+qK7zTeQtr97G5qPrJVqL5UaCPBBncT3a51yCtDdq32y0hwEyp/8a2iLY/1Z/iZM
         vFmQGenmsFlXf5CdrstzeRBv+q+qW5IaK1B7xTM3xBDHhk+1DDNsZQY2cvBxitZWGVr5
         3PVbTAHAbwWh+XZwDeDUrRE/e/UCPfCK+EwZyQpziOB/eOve/FjRQqdlCQVWReGZTgKB
         ZJOWvcZPQl528zYp3y1Ly/ztdY8QYph0key32hX8SRV00W8N1dIa75sm3kqRN2aXsy5L
         5zp1S+ZSmcXThB506Q3rW1CFdtcHy90jlZJcFR7ylLdMlzC5IzICGSeuKq/vm9g2DKS0
         AoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O5K3vtSDRGsCZXj5hJ10Vv4+kmt/R6WCP94ggra/WkU=;
        b=EpDdRytHOHDSY/7rBsBmwlfHmoigWtniJHv2NCi3b0iWDs62dI8vEAzX/yj+1dOBSV
         yyovZUsSVekrFML6Z+ZKVUxF9IReqc8fEZCqgqUAtSuEH9gkCK9OO8URtD5liMsSuBUc
         xtjzXyq1JhPF2YMKzSCRLsz50HOWlQZ1AsmrJm6SPFzYikKJW3YvP2aHhemWuWDITteu
         XW0/pXaoq8qK1bEnC6PK2nzK/O+HkI3r3Hppc/+e87sDFKO+J9Pk5u0LgcBBL1ni7idw
         EodAjkTUmRqVIv6Owwg36AgjlrZfaTUiHUYOTcNjuWYFai2cDqSLkND/9KhxO4L7QcNi
         1OBw==
X-Gm-Message-State: AD7BkJI6cY2YMFpqIYOBdK2nt0P41a7Q4G79j6MN/naT1jKCtN/MKdBXwZFOugE+TriNBg==
X-Received: by 10.55.48.80 with SMTP id w77mr23323816qkw.7.1456793634791;
        Mon, 29 Feb 2016 16:53:54 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:54 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287960>

git init learns a new argument --ref-storage.  Presently, only
"files" is supported, but later we will add other storage backends.

When this argument is used, the repository's extensions.refStorage
configuration value is set (as well as core.repositoryformatversion),
and the ref storage backend's initdb function is used to set up the
ref database.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-init-db.txt          |  2 +-
 Documentation/git-init.txt             |  7 +++++-
 builtin/init-db.c                      | 44 ++++++++++++++++++++++++++=
+-------
 cache.h                                |  2 ++
 contrib/completion/git-completion.bash |  3 ++-
 path.c                                 | 29 ++++++++++++++++++++--
 refs.c                                 |  2 ++
 refs.h                                 |  5 ++++
 setup.c                                | 12 ++++++++++
 t/t0001-init.sh                        | 25 +++++++++++++++++++
 10 files changed, 118 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.=
txt
index 648a6cd..d03fb69 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -9,7 +9,7 @@ git-init-db - Creates an empty Git repository
 SYNOPSIS
 --------
 [verse]
-'git init-db' [-q | --quiet] [--bare] [--template=3D<template_director=
y>] [--separate-git-dir <git dir>] [--shared[=3D<permissions>]]
+'git init-db' [-q | --quiet] [--bare] [--template=3D<template_director=
y>] [--separate-git-dir <git dir>] [--shared[=3D<permissions>]] [--ref-=
storage=3D<name>]
=20
=20
 DESCRIPTION
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 8174d27..93f8d0c 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git init' [-q | --quiet] [--bare] [--template=3D<template_directory>]
 	  [--separate-git-dir <git dir>]
 	  [--shared[=3D<permissions>]] [directory]
-
+	  [--ref-storage=3D<name>]
=20
 DESCRIPTION
 -----------
@@ -113,6 +113,11 @@ does not exist, it will be created.
=20
 --
=20
+--ref-storage=3D<name>::
+Type of refs storage backend. Default is to use the original "files"
+storage, which stores ref data in files in `$GIT_DIR/refs` and
+`$GIT_DIR/packed-refs`.
+
 TEMPLATE DIRECTORY
 ------------------
=20
diff --git a/builtin/init-db.c b/builtin/init-db.c
index e6d4e86..af7fe04 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -23,6 +23,7 @@ static int init_is_bare_repository =3D 0;
 static int init_shared_repository =3D -1;
 static const char *init_db_template_dir;
 static const char *git_link;
+static char *requested_ref_storage_backend;
=20
 static void copy_templates_1(struct strbuf *path, struct strbuf *templ=
ate,
 			     DIR *dir)
@@ -178,6 +179,7 @@ static int create_default_files(const char *templat=
e_path)
 	int reinit;
 	int filemode;
 	struct strbuf err =3D STRBUF_INIT;
+	int repo_version =3D 0;
=20
 	/* Just look for `init.templatedir` */
 	git_config(git_init_db_config, NULL);
@@ -204,6 +206,32 @@ static int create_default_files(const char *templa=
te_path)
 	}
=20
 	/*
+	 * Create the default symref from ".git/HEAD" to the "master"
+	 * branch, if it does not exist yet.
+	 */
+	path =3D git_path_buf(&buf, "HEAD");
+	reinit =3D (!access(path, R_OK)
+		  || readlink(path, junk, sizeof(junk)-1) !=3D -1);
+	if (reinit) {
+		if (requested_ref_storage_backend &&
+		    strcmp(ref_storage_backend, requested_ref_storage_backend))
+			die(_("You can't change the refs storage type (was %s; you requeste=
d %s)"),
+			      ref_storage_backend,
+			      requested_ref_storage_backend);
+	}
+
+	if (requested_ref_storage_backend)
+		ref_storage_backend =3D requested_ref_storage_backend;
+	if (strcmp(ref_storage_backend, "files")) {
+		git_config_set("extensions.refStorage", ref_storage_backend);
+		git_config_set("core.repositoryformatversion", ref_storage_backend);
+		if (set_ref_storage_backend(ref_storage_backend))
+			die(_("Unknown ref storage backend %s"),
+			    ref_storage_backend);
+		repo_version =3D 1;
+	}
+
+	/*
 	 * We need to create a "refs" dir in any case so that older
 	 * versions of git can tell that this is a repository.
 	 */
@@ -212,13 +240,6 @@ static int create_default_files(const char *templa=
te_path)
 	if (refs_init_db(shared_repository, &err))
 		die("failed to set up refs db: %s", err.buf);
=20
-	/*
-	 * Create the default symlink from ".git/HEAD" to the "master"
-	 * branch, if it does not exist yet.
-	 */
-	path =3D git_path_buf(&buf, "HEAD");
-	reinit =3D (!access(path, R_OK)
-		  || readlink(path, junk, sizeof(junk)-1) !=3D -1);
 	if (!reinit) {
 		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
 			exit(1);
@@ -226,7 +247,7 @@ static int create_default_files(const char *templat=
e_path)
=20
 	/* This forces creation of new config file */
 	xsnprintf(repo_version_string, sizeof(repo_version_string),
-		  "%d", GIT_REPO_VERSION);
+		  "%d", repo_version);
 	git_config_set("core.repositoryformatversion", repo_version_string);
=20
 	/* Check filemode trustability */
@@ -474,11 +495,18 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
+		OPT_STRING(0, "ref-storage", &requested_ref_storage_backend,
+			   N_("name"), N_("name of backend type to use")),
 		OPT_END()
 	};
=20
 	argc =3D parse_options(argc, argv, prefix, init_db_options, init_db_u=
sage, 0);
=20
+	if (requested_ref_storage_backend &&
+	    !ref_storage_backend_exists(requested_ref_storage_backend))
+		die(_("Unknown ref storage backend %s"),
+		    requested_ref_storage_backend);
+
 	if (real_git_dir && !is_absolute_path(real_git_dir))
 		real_git_dir =3D xstrdup(real_path(real_git_dir));
=20
diff --git a/cache.h b/cache.h
index 7ceb760..3979a70 100644
--- a/cache.h
+++ b/cache.h
@@ -736,6 +736,8 @@ extern enum object_creation_mode object_creation_mo=
de;
=20
 extern char *notes_ref_name;
=20
+extern const char *ref_storage_backend;
+
 extern int grafts_replace_parents;
=20
 /*
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index e3918c8..850afd0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1362,7 +1362,8 @@ _git_init ()
 		return
 		;;
 	--*)
-		__gitcomp "--quiet --bare --template=3D --shared --shared=3D"
+		__gitcomp "--quiet --bare --template=3D --shared --shared=3D
+			--ref-storage=3D"
 		return
 		;;
 	esac
diff --git a/path.c b/path.c
index 8b7e168..2e67a2b 100644
--- a/path.c
+++ b/path.c
@@ -2,6 +2,7 @@
  * Utilities for paths and pathnames
  */
 #include "cache.h"
+#include "refs.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "dir.h"
@@ -511,8 +512,32 @@ int validate_headref(const char *path)
 	int fd;
 	ssize_t len;
=20
-	if (lstat(path, &st) < 0)
-		return -1;
+	if (lstat(path, &st) < 0) {
+		int backend_type_set;
+		struct strbuf config_path =3D STRBUF_INIT;
+		char *pathdup =3D xstrdup(path);
+		char *git_dir =3D dirname(pathdup);
+		char *storage =3D NULL;
+
+		strbuf_addf(&config_path, "%s/%s", git_dir, "config");
+		free(pathdup);
+
+		if (git_config_from_file(ref_storage_backend_config,
+					 config_path.buf, &storage)) {
+			strbuf_release(&config_path);
+			return -1;
+		}
+
+		backend_type_set =3D !!storage;
+		free((void *)storage);
+		strbuf_release(&config_path);
+		/*
+		 * Alternate backends are assumed to keep HEAD
+		 * in a valid state, so there's no need to do
+		 * further validation.
+		 */
+		return backend_type_set ? 0 : -1;
+	}
=20
 	/* Make sure it is a "refs/.." symlink */
 	if (S_ISLNK(st.st_mode)) {
diff --git a/refs.c b/refs.c
index 6c05881..a18cb4d 100644
--- a/refs.c
+++ b/refs.c
@@ -23,6 +23,8 @@ static struct ref_storage_be *the_refs_backend =3D &r=
efs_be_files;
  */
 static struct ref_storage_be *refs_backends =3D &refs_be_files;
=20
+const char *ref_storage_backend =3D "files";
+
 static struct ref_storage_be *find_ref_storage_backend(const char *nam=
e)
 {
 	struct ref_storage_be *be;
diff --git a/refs.h b/refs.h
index 13ce2a0..09486b2 100644
--- a/refs.h
+++ b/refs.h
@@ -512,6 +512,11 @@ extern int reflog_expire(const char *refname, cons=
t unsigned char *sha1,
 			 void *policy_cb_data);
=20
 /*
+ * Read the refdb storage backend name out of the config file
+ */
+int ref_storage_backend_config(const char *var, const char *value, voi=
d *ptr);
+
+/*
  * Switch to an alternate ref storage backend.
  */
 int set_ref_storage_backend(const char *name);
diff --git a/setup.c b/setup.c
index de1a2a7..bd3a2cf 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "refs.h"
 #include "string-list.h"
=20
 static int inside_git_dir =3D -1;
@@ -261,6 +262,15 @@ int get_common_dir_noenv(struct strbuf *sb, const =
char *gitdir)
 	return ret;
 }
=20
+int ref_storage_backend_config(const char *var, const char *value, voi=
d *ptr)
+{
+	const char **cdata =3D ptr;
+
+	if (!strcmp(var, "extensions.refstorage"))
+		return git_config_string(cdata, var, value);
+	return 0;
+}
+
 /*
  * Test if it looks like we're at a git directory.
  * We want to see:
@@ -388,6 +398,8 @@ static int check_repo_format(const char *var, const=
 char *value, void *cb)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			repository_format_precious_objects =3D git_config_bool(var, value);
+		else if (!strcmp(ext, "refstorage"))
+			ref_storage_backend =3D xstrdup(value);
 		else
 			string_list_append(&unknown_extensions, ext);
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 295aa59..31c8279 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -174,6 +174,31 @@ test_expect_success 'reinit' '
 	test_i18ncmp again/empty again/err2
 '
=20
+test_expect_success 'init with bogus storage backend fails' '
+
+	(
+		mkdir again2 &&
+		cd again2 &&
+		test_must_fail git init --ref-storage=3Dtest >out2 2>err2 &&
+		test_i18ngrep "Unknown ref storage backend test" err2
+	)
+'
+
+test_expect_failure 'reinit with changed storage backend fails' '
+
+	(
+		mkdir again3 &&
+		cd again3 &&
+		git init >out1 2>err1 &&
+		git init --ref-storage=3Dtest >out2 2>err2
+	) &&
+	test_i18ngrep "Initialized empty" again3/out1 &&
+	test_i18ngrep "Reinitialized existing" again3/out2 &&
+	>again3/empty &&
+	test_i18ncmp again3/empty again3/err1 &&
+	test_i18ncmp again3/empty again3/err2
+'
+
 test_expect_success 'init with --template' '
 	mkdir template-source &&
 	echo content >template-source/file &&
--=20
2.4.2.767.g62658d5-twtrsrc
