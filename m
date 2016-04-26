From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 4/4] hooks: Add ability to specify where the hook directory is
Date: Tue, 26 Apr 2016 18:13:22 +0000
Message-ID: <1461694402-9629-5-git-send-email-avarab@gmail.com>
References: <1461694402-9629-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:14:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7VM-0006ze-Am
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbcDZSOc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 14:14:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35011 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbcDZSOb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:14:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id e201so6512343wme.2
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wF1Y4lrPABdYoyb40BuKP1waO+34CRLKWccD0w1zRTY=;
        b=tIw0NIw9581XcJ3cl1zyqgQcKVXh5yfDLUS7RT3C0+Rf1YJdZfGGH3BnZfp5xnchnd
         6vshSyr0CFra43dS1H3g9mOBlJKJ6LhLaoQlJTsm/7BdPsHQkHratgYCFXAbcQIxLkPn
         8pXyRZvjSZZQ25fjp/T9sufmZG7yf/sTqpk7Ivu7znrNJD/m/ShdayPybta+AYHrOA3L
         v4TJAd2fUzDMzjwRd2XatQ7oiQnLBIRX6reGnG9Rx06ki/Fd3rAGBoWzF6e1EZJxV4F9
         ZhHZIQcOnUJmH9z3CYlpm+OflqcLnwSUPh6idbbfgYJIMa3aVa7wvvLr0x42By80ZCGV
         ATUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wF1Y4lrPABdYoyb40BuKP1waO+34CRLKWccD0w1zRTY=;
        b=JO3Cd3dAVXHMOKGeK5ECmII522ILk9enoAN+8te1NwfVCvmlkxUFLy5IcoFn8uozjI
         YXWleHhyHH2rq5wldZrZG/ItSYYSi7FIV9ebjWEvqTD2LA4tillg529kOYc4h1kYHx/d
         7j9znucxIzTQu6h1NLWNQGpR0mRz2MZoWEvqWcFFdYXdS3ZWUS0CXiRe9w9f2o0fHHa6
         9y0DlZJxo67q8jHuUhTLe/VCDaRUrQXj2fC/DLyadLgm9qTdQTmYiVsyP30TC/p3kzZ5
         IDT2VPHk7lbsjJxsRhTBwi0/CVhkot+oznBh0OTrZaVEDwNIRimJA3vMegmuCJCVKDgY
         KFEA==
X-Gm-Message-State: AOPr4FUZFeMo6HcXn2cUEcxG+e3XGnmgmuij6TQAAXQ5QyTLk2k71xU4UvM8YMxJ9E7EPQ==
X-Received: by 10.194.5.36 with SMTP id p4mr4711670wjp.167.1461694469866;
        Tue, 26 Apr 2016 11:14:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h8sm4392371wmd.2.2016.04.26.11.14.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2016 11:14:29 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1461694402-9629-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292639>

Change the hardcoded lookup for .git/hooks/* to optionally lookup in
$(git config core.hooksPath)/* instead.

This is essentially a more intrusive version of the git-init ability to
specify hooks on init time via init templates.

The difference between that facility and this feature is that this can
be set up after the fact via e.g. ~/.gitconfig or /etc/gitconfig to
apply for all your personal repositories, or all repositories on the
system.

I plan on using this on a centralized Git server where users can create
arbitrary repositories under /gitroot, but I'd like to manage all the
hooks that should be run centrally via a unified dispatch mechanism.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/config.txt     | 18 ++++++++++++++++++
 Documentation/githooks.txt   | 12 ++++++++----
 cache.h                      |  1 +
 config.c                     |  3 +++
 environment.c                |  1 +
 run-command.c                |  5 ++++-
 t/t1350-config-hooks-path.sh | 31 +++++++++++++++++++++++++++++++
 7 files changed, 66 insertions(+), 5 deletions(-)
 create mode 100755 t/t1350-config-hooks-path.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..c007b12 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -618,6 +618,24 @@ core.attributesFile::
 	$XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME is either not
 	set or empty, $HOME/.config/git/attributes is used instead.
=20
+core.hooksPath::
+	By default Git will look for your hooks in the
+	'$GIT_DIR/hooks' directory. Set this to different path,
+	e.g. '/etc/git/hooks', and Git will try to find your hooks in
+	that directory, e.g. '/etc/git/hooks/pre-receive' instead of
+	in '$GIT_DIR/hooks/pre-receive'.
++
+The path can either be absolute or relative. When specifying a
+relative path see the discussion in the "DESCRIPTION" section of
+linkgit:githooks[5] for what the relative relative path will be
+relative to.
++
+This configuration is useful in cases where you'd like to
+e.g. centrally configure your Git hooks instead of configuring them on
+a per-repository basis, or as a more flexible and centralized
+alterantive to having an `init.templateDir` where you've changed the
+'hooks' directory.
+
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
 	messages by launching an editor uses the value of this
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a214284..97ae78d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -7,15 +7,19 @@ githooks - Hooks used by Git
=20
 SYNOPSIS
 --------
-$GIT_DIR/hooks/*
+$GIT_DIR/hooks/* (or \`git config core.hooksPath`/*)
=20
=20
 DESCRIPTION
 -----------
=20
-Hooks are programs you can place in the `$GIT_DIR/hooks` directory to
-trigger actions at certain points in git's execution. Hooks that don't
-have the executable bit set are ignored.
+Hooks are programs you can place in a hooks directory to trigger
+actions at certain points in git's execution. Hooks that don't have
+the executable bit set are ignored.
+
+By default the hooks directory is `$GIT_DIR/hooks`, but that can be
+changed via the `core.hooksPath` configuration variable (see
+linkgit:git-config[1]).
=20
 When a hook is invoked, it is run at the root of the working tree in a
 non-bare repository, or in the $GIT_DIR in a bare
diff --git a/cache.h b/cache.h
index 2711048..4f7d222 100644
--- a/cache.h
+++ b/cache.h
@@ -654,6 +654,7 @@ extern int warn_on_object_refname_ambiguity;
 extern const char *apply_default_whitespace;
 extern const char *apply_default_ignorewhitespace;
 extern const char *git_attributes_file;
+extern const char *git_hooks_path;
 extern int zlib_compression_level;
 extern int core_compression_level;
 extern int core_compression_seen;
diff --git a/config.c b/config.c
index 10b5c95..51f80e4 100644
--- a/config.c
+++ b/config.c
@@ -717,6 +717,9 @@ static int git_default_core_config(const char *var,=
 const char *value)
 	if (!strcmp(var, "core.attributesfile"))
 		return git_config_pathname(&git_attributes_file, var, value);
=20
+	if (!strcmp(var, "core.hookspath"))
+		return git_config_pathname(&git_hooks_path, var, value);
+
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg =3D git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 57acb2f..2857e3f 100644
--- a/environment.c
+++ b/environment.c
@@ -31,6 +31,7 @@ const char *git_log_output_encoding;
 const char *apply_default_whitespace;
 const char *apply_default_ignorewhitespace;
 const char *git_attributes_file;
+const char *git_hooks_path;
 int zlib_compression_level =3D Z_BEST_SPEED;
 int core_compression_level;
 int core_compression_seen;
diff --git a/run-command.c b/run-command.c
index 8c7115a..39d7237 100644
--- a/run-command.c
+++ b/run-command.c
@@ -815,7 +815,10 @@ const char *find_hook(const char *name)
 	static struct strbuf path =3D STRBUF_INIT;
=20
 	strbuf_reset(&path);
-	strbuf_git_path(&path, "hooks/%s", name);
+	if (git_hooks_path)
+		strbuf_addf(&path, "%s/%s", git_hooks_path, name);
+	else
+		strbuf_git_path(&path, "hooks/%s", name);
 	if (access(path.buf, X_OK) < 0)
 		return NULL;
 	return path.buf;
diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.s=
h
new file mode 100755
index 0000000..f2f0aa9
--- /dev/null
+++ b/t/t1350-config-hooks-path.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description=3D'Test the core.hooksPath configuration variable'
+
+. ./test-lib.sh
+
+test_expect_success 'set up a pre-commit hook in core.hooksPath' '
+	mkdir -p .git/custom-hooks .git/hooks &&
+	write_script .git/custom-hooks/pre-commit <<-\EOF &&
+printf "%s" "CUST" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
+EOF
+	write_script .git/hooks/pre-commit <<-\EOF
+printf "%s" "NORM" >>.git/PRE-COMMIT-HOOK-WAS-CALLED
+EOF
+'
+
+test_expect_success 'Check that various forms of specifying core.hooks=
Path work' '
+	test_commit no_custom_hook &&
+	git config core.hooksPath .git/custom-hooks &&
+	test_commit have_custom_hook &&
+	git config core.hooksPath .git/custom-hooks/ &&
+	test_commit have_custom_hook_trailing_slash &&
+	git config core.hooksPath "$PWD/.git/custom-hooks" &&
+	test_commit have_custom_hook_abs_path &&
+	git config core.hooksPath "$PWD/.git/custom-hooks/" &&
+	test_commit have_custom_hook_abs_path_trailing_slash &&
+	printf "%s" "NORMCUSTCUSTCUSTCUST" >.git/PRE-COMMIT-HOOK-WAS-CALLED.e=
xpect &&
+	test_cmp .git/PRE-COMMIT-HOOK-WAS-CALLED.expect .git/PRE-COMMIT-HOOK-=
WAS-CALLED
+'
+
+test_done
--=20
2.1.3
