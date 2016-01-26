From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 6/6] worktree add: switch to worktree version 1
Date: Tue, 26 Jan 2016 18:44:45 +0700
Message-ID: <1453808685-21235-7-git-send-email-pclouds@gmail.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, max@max630.net,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 12:45:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO24J-0005b2-Cw
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 12:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934331AbcAZLpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 06:45:52 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33609 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933850AbcAZLpu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 06:45:50 -0500
Received: by mail-pf0-f193.google.com with SMTP id e65so8226183pfe.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 03:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YUjAvmaYX7t0A12ARPhmofw12HxW4l2O1ZCjJ53vFT8=;
        b=QLYQUGCoARZWr4Y7jARRAWKNdqt/G7APFr20nb6RxeR8g0CpN1vcFgv672RY2q2ze2
         6UvNXS9pVn38GH0rSIhA3y14miHSJ01lYIIovRXTfsOSeGR3vswBKwh9BPwUYA1sZ57E
         1DIU+/UcGOzescH2Vbj+9FsrCLYGlS/t70zKhlsR6x13DPIQiwosQ4/O5xiqdXPRymsR
         DJ+LX4NzmQSYeq2q9BPLZu7G9SBKvAVrrpf+RQwnFymNQ7iDTjp3yUdMow+q7vdFgIlv
         quDFeY6ijS+d8E5F2Zo721j3HrpnsoGbQ5pI7KoRwnZ8KoR7DfIpTlFacsoXX/WMhrkV
         nDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=YUjAvmaYX7t0A12ARPhmofw12HxW4l2O1ZCjJ53vFT8=;
        b=V6sA2r1tr9hl41Sj5daVtO38OuBlVYoMBivTrVPBsbAl84SLhXkzKNMaKmLOQFHAD5
         18h/VscfNqQHHKhPpxDfLHKpFO2k6EgM16RfM7nHvgvlBY5IZ210sOCwmerzVVvbxEaI
         fLz+zBe3Ni5yDQl/aFAys1WDGJEWF1UqXfp0m7LkXc/6jQSA0OGPpHnKrnHeWHskDiaz
         XZ4eCUMUDYGP01xJ1dD1LmZiHudDpFpb/tT++To5pbx9W8ewvWLfOVybWvIyY8w+/Qcz
         B4dvcaPd0D5QLkqfzvgxyY+XyMX2c94gy6KRDiOm7Xg6sDmYmyLWl5YF/63r7twlkKl+
         2yKw==
X-Gm-Message-State: AG10YOSPx6UNBFmHakY/RalfQGnBeIz9gqCPYxz9ssZ10t3Gu8fI0o5YH8JZDTLumXBR4A==
X-Received: by 10.98.72.156 with SMTP id q28mr32983785pfi.161.1453808750331;
        Tue, 26 Jan 2016 03:45:50 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id lq10sm1445226pab.36.2016.01.26.03.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 03:45:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 26 Jan 2016 18:45:52 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453808685-21235-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284808>

The most obvious use case is, "git worktree add" creates the first
linked worktree. In this case, we should be able to move to latest
worktree version. The following happens:

 - common/config is created with extensions.worktree 1 and
   core.repositoryformatversion 1

 - all config keys except a few per-worktree are moved to
   common/config

 - per-worktree keys stay with the main worktree's config file

 - the main worktree config file also has worktree version explicitly
   set to 1. This is to prevent older Git binaries from reading it.

What if the repo already has another linked worktree and the user
wants to stay at version 0, maybe because multiple git binaries can
access this repo? "worktree add --version=3D0" can be used, but it's
really not recommended to stay at lower (and buggy) version.

A note about core.bare staying per-worktree. On the surface it does
not make sense for core.bare to be worktree specific. It's made so in
order to "grow" new worktrees from a bare repo. In these new linked
worktrees, core.bare will be hidden away and worktree-related commands
won't complain about bare repository.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt |  9 +++-
 builtin/worktree.c             | 95 ++++++++++++++++++++++++++++++++++=
++++++++
 t/t2028-worktree-config.sh     | 47 ++++++++++++++++++++-
 3 files changed, 148 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 6082d4d..0d7d523 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
+'git worktree add' [-f] [--detach] [-b <new-branch>] [--version=3D<N>]=
 <path> [<branch>]
 'git worktree prune' [-n] [-v] [--expire <expire>]
 'git worktree list' [--porcelain]
=20
@@ -89,6 +89,13 @@ OPTIONS
 	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
=20
+--version=3D<N>::
+	By default when a new working directory is added, worktree
+	layout is automatically migrated to latest version. This
+	option can be used to specify only migrate to the specified
+	version, or no migrate at all if it's already current worktree
+	version.
+
 -n::
 --dry-run::
 	With `prune`, do not remove anything; just report what it would
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 475b958..551fe37 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -140,6 +140,7 @@ static char *junk_work_tree;
 static char *junk_git_dir;
 static int is_junk;
 static pid_t junk_pid;
+static int target_version =3D 1;
=20
 static void remove_junk(void)
 {
@@ -184,6 +185,93 @@ static const char *worktree_basename(const char *p=
ath, int *olen)
 	return name;
 }
=20
+struct key_data {
+	const char *key;
+	char *value;
+};
+
+static int get_one_key(const char *key, const char *value, void *cb)
+{
+	struct key_data *kd =3D cb;
+
+	if (!strcmp(key, kd->key))
+		kd->value =3D xstrdup(value);
+
+	return 0;
+}
+
+static char *get_key(const char *file, const char *key)
+{
+	struct key_data kd;
+
+	kd.key =3D key;
+	kd.value =3D NULL;
+	if (git_config_from_file(get_one_key, file, &kd))
+		return NULL;
+	return kd.value;
+}
+
+static void migrate_worktree_layout(void)
+{
+	const char *per_wortree_keys[] =3D {
+		"core.bare",
+		"core.ignorestat",
+		"core.sparsecheckout",
+		"core.worktree",
+		NULL
+	};
+	struct strbuf sb =3D STRBUF_INIT;
+	const char **key_p;
+
+	switch (repository_format_worktree_version) {
+	case 0:
+		strbuf_addf(&sb, "%s/common", get_git_common_dir());
+		if (mkdir_in_gitdir(sb.buf))
+			die_errno(_("failed to create directory %s"), sb.buf);
+		if (repository_format_version < 1 &&
+		    git_config_set("core.repositoryformatversion", "1"))
+			die(_("failed to set core.repositoryformatversion to one"));
+		if (git_config_set("extensions.worktree", "1"))
+			die(_("failed to set extensions.worktree to one"));
+		strbuf_addstr(&sb, "/config");
+		if (rename(git_path("config"), sb.buf))
+			die_errno(_("failed to set move config file to %s"),
+				  sb.buf);
+		for (key_p =3D per_wortree_keys; *key_p; key_p++) {
+			const char *key =3D *key_p;
+			char *value =3D get_key(sb.buf, key);
+
+			if (value) {
+				if (git_config_set(key, value))
+					die(_("failed to keep %s in main worktree's config file"), key);
+				if (git_config_set_in_file(sb.buf, key, NULL))
+					die(_("failed to delete %s in shared config file"), key);
+				free(value);
+			}
+		}
+
+		/*
+		 * we're still in version 0 in this process, this will
+		 * create a new file $GIT_COMMON_DIR/config with only
+		 * one key, extensions.worktree. This will force old
+		 * git binaries that do not understand v1 to bail out.
+		 */
+		if (repository_format_version < 1 &&
+		    git_config_set("core.repositoryformatversion", "1"))
+			die(_("failed to set core.repositoryformatversion to one"));
+		if (git_config_set("extensions.worktree", "1"))
+			die(_("failed to set extensions.worktree to one"));
+
+		repository_format_worktree_version =3D 1;
+		break;
+	case 1:
+		break;
+	default:
+		die(_("unsupported worktree format version %d"),
+		    repository_format_worktree_version);
+	}
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -297,6 +385,9 @@ static int add_worktree(const char *path, const cha=
r *refname,
 		free(junk_git_dir);
 		junk_work_tree =3D NULL;
 		junk_git_dir =3D NULL;
+
+		while (repository_format_worktree_version < target_version)
+			migrate_worktree_layout();
 	}
 done:
 	strbuf_reset(&sb);
@@ -322,6 +413,8 @@ static int add(int ac, const char **av, const char =
*prefix)
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 			   N_("create or reset a branch")),
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit"=
)),
+		OPT_INTEGER(0, "version", &target_version,
+			   N_("stay at this worktree version")),
 		OPT_END()
 	};
=20
@@ -331,6 +424,8 @@ static int add(int ac, const char **av, const char =
*prefix)
 		die(_("-b, -B, and --detach are mutually exclusive"));
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
+	if (target_version < 0 || target_version > 1)
+		die(_("invalid worktree version %d"), target_version);
=20
 	path =3D prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : av=
[0];
 	branch =3D ac < 2 ? "HEAD" : av[1];
diff --git a/t/t2028-worktree-config.sh b/t/t2028-worktree-config.sh
index d11b2ce..0d4cb8e 100755
--- a/t/t2028-worktree-config.sh
+++ b/t/t2028-worktree-config.sh
@@ -6,8 +6,8 @@ test_description=3D"config file in multi worktree"
=20
 test_expect_success 'setup' '
 	test_commit start &&
-	git worktree add wt1 &&
-	git worktree add wt2
+	git worktree add --version=3D0 wt1 &&
+	git worktree add --version=3D0 wt2
 '
=20
 test_expect_success 'main config is shared in version 0' '
@@ -58,4 +58,47 @@ test_expect_success 'config --repo on v1' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'prepare worktree v0' '
+	test_create_repo repo-v0 &&
+	(
+		cd repo-v0 &&
+		test_commit v0 &&
+		git config core.sparsecheckout true &&
+		git config core.ignorestat true &&
+		git config core.worktree "$TEST_DIRECTORY" &&
+		git config share.key value
+	)
+'
+
+test_expect_success 'migrate v0 to v1' '
+	git -C repo-v0 worktree add --version=3D1 wt
+'
+
+test_expect_success 'after migration: main wortree has extensions.work=
tree' '
+	test "`git -C repo-v0 config core.repositoryformatversion`" =3D 1 &&
+	test "`git -C repo-v0 config extensions.worktree`" =3D 1
+'
+
+test_expect_success 'after migration: linked wortree has extensions.wo=
rktree' '
+	test "`git -C repo-v0/wt config core.repositoryformatversion`" =3D 1 =
&&
+	test "`git -C repo-v0/wt config extensions.worktree`" =3D 1
+'
+
+test_expect_success 'after migration: main wortree keeps per-worktree =
vars' '
+	test "`git -C repo-v0 config core.sparsecheckout`" =3D true &&
+	test "`git -C repo-v0 config core.ignorestat`" =3D true &&
+	test "`git -C repo-v0 config core.worktree`" =3D "$TEST_DIRECTORY"
+'
+
+test_expect_success 'after migration: linked wortree has no per-worktr=
ee vars' '
+	test_must_fail git -C repo-v0/wt config core.sparsecheckout &&
+	test_must_fail git -C repo-v0/wt config core.ignorestat &&
+	test_must_fail git -C repo-v0/wt config core.worktree
+'
+
+test_expect_success 'after migration: shared vars are shared' '
+	test "`git -C repo-v0 config share.key`" =3D value &&
+	test "`git -C repo-v0/wt config share.key`" =3D value
+'
+
 test_done
--=20
2.7.0.288.g1d8ad15
