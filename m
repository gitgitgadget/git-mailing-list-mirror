From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 20/27] init: allow alternate ref strorage to be set for new repos
Date: Thu, 18 Feb 2016 00:17:43 -0500
Message-ID: <1455772670-21142-21-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:20:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWH0T-0002Eo-Gl
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425012AbcBRFT5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2016 00:19:57 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36356 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424911AbcBRFSz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:55 -0500
Received: by mail-qg0-f46.google.com with SMTP id y9so29819927qgd.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=A8P5kdfMio6CJz4ErZhk1bEjo4G1idFKI0RqRbdF6nQ=;
        b=KRiDN2FyoXYs5Uw6SfrdZK1VT9OUtkZ8V2YrjyxOlJPpiEvw0lL1AX5HC3cxAKc/17
         dQvo93ffQPt9XK45TGYwEUfZrwnDMYAIlLwZLmoVul5lJ6xkvC1fNcNgNFcsdLnZwbUj
         xg0nGKTnY3PdSOJKR5ZyLlZMKoWiKiO6Gl7SYZhyudLd18RVwDPhGDR8SLtM5DQNvQuT
         Fi9VjUhRIjA42D1wmxYbOLyNsRXA7zxm5YXZ3IlYh7el5bRaLuRsMi9FVFHhnrmWo6pW
         54HluHBl+MxAcyJ7SeUFlIHtK+NAZQXZjgwqeg3cBGHzGYxYqTixyAErXWInArnktWgx
         kVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=A8P5kdfMio6CJz4ErZhk1bEjo4G1idFKI0RqRbdF6nQ=;
        b=DrgGRU8PFjh7zbWKHLs6mUEOajjXeQFG9jyax9zXYRSPvJiGJU+yUVQTaqq50x9Z1w
         URJlTzUQa3zV5M9qC/0EZjciHv089zBk9bLev3zFfI+xMd3CvglHRd+Iz3L1qMD1JesD
         xUEGpQndPPSDkTTzyssU7nqHITS8RE/ILB9QvMOCJaCHo1tZJzjLlglxtnPJQ1pw0eu7
         vdS63jSxYz/LWT9w/dMGa4Vs7g9zsE0MipsoVoM9UrHG0g2HAm51QIyGydxT3pOXnfN5
         fYw2ZRbEGDSnF1M7mp84cGWNrt4EEWgztNVV9ToAMuX88fE6OTvZNeP68MqGYfVa/spC
         60dA==
X-Gm-Message-State: AG10YOT4sW1ClaGQJEkFD/YXsPulCJvX1wKL5/Wkl4VlqhkzwflKe+aG1WahIIdL59IyJQ==
X-Received: by 10.140.86.85 with SMTP id o79mr6659212qgd.3.1455772735064;
        Wed, 17 Feb 2016 21:18:55 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:54 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286595>

git init learns a new argument --ref-storage.  Presently, only
"files" is supported, but later we will add other storage backends.

When this argument is used, the repository's extensions.refStorage
configuration value is set (as well as core.repositoryformatversion),
and the ref storage backend's initdb function is used to set up the
ref database.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-init-db.txt          |  2 +-
 Documentation/git-init.txt             |  7 +++++-
 builtin/init-db.c                      | 44 ++++++++++++++++++++++++++=
+-------
 cache.h                                |  2 ++
 contrib/completion/git-completion.bash |  3 ++-
 path.c                                 | 29 ++++++++++++++++++++--
 refs.c                                 |  8 +++++++
 refs.h                                 |  8 +++++++
 setup.c                                | 12 ++++++++++
 t/t0001-init.sh                        | 25 +++++++++++++++++++
 10 files changed, 127 insertions(+), 13 deletions(-)

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
index 0c8f4ac..753cb1c 100644
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
index 4307174..a54c97b 100644
--- a/cache.h
+++ b/cache.h
@@ -734,6 +734,8 @@ extern enum object_creation_mode object_creation_mo=
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
index 45ec47f..0138d03 100644
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
index 85e1793..64d4150 100644
--- a/refs.c
+++ b/refs.c
@@ -23,6 +23,14 @@ static struct ref_storage_be *the_refs_backend =3D &=
refs_be_files;
  */
 static struct ref_storage_be *refs_backends =3D &refs_be_files;
=20
+const char *ref_storage_backend =3D "files";
+
+void register_ref_storage_backend(struct ref_storage_be *be)
+{
+	be->next =3D refs_backends;
+	refs_backends =3D be;
+}
+
 int set_ref_storage_backend(const char *name)
 {
 	struct ref_storage_be *be;
diff --git a/refs.h b/refs.h
index feff82e..4992aa4 100644
--- a/refs.h
+++ b/refs.h
@@ -511,10 +511,18 @@ extern int reflog_expire(const char *refname, con=
st unsigned char *sha1,
 			 void *policy_cb_data);
=20
 /*
+ * Read the refdb storage backend name out of the config file
+ */
+int ref_storage_backend_config(const char *var, const char *value, voi=
d *ptr);
+
+struct ref_storage_be;
+/*
  * Switch to an alternate ref storage backend.
  */
 int set_ref_storage_backend(const char *name);
=20
 int ref_storage_backend_exists(const char *name);
=20
+void register_ref_storage_backend(struct ref_storage_be *be);
+
 #endif /* REFS_H */
diff --git a/setup.c b/setup.c
index 0deb022..1a62277 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "refs.h"
 #include "string-list.h"
=20
 static int inside_git_dir =3D -1;
@@ -263,6 +264,15 @@ int get_common_dir_noenv(struct strbuf *sb, const =
char *gitdir)
 	return ret;
 }
=20
+int ref_storage_backend_config(const char *var, const char *value, voi=
d *ptr)
+{
+	char **cdata =3D ptr;
+
+	if (!strcmp(var, "extensions.refstorage"))
+		*cdata =3D xstrdup(value);
+	return 0;
+}
+
 /*
  * Test if it looks like we're at a git directory.
  * We want to see:
@@ -390,6 +400,8 @@ static int check_repo_format(const char *var, const=
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
