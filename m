From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v6 4/4] hooks: Add ability to specify where the hook directory is
Date: Wed,  4 May 2016 22:58:12 +0000
Message-ID: <1462402692-24712-5-git-send-email-avarab@gmail.com>
References: <xmqqa8k5eakb.fsf@gitster.mtv.corp.google.com>
 <1462402692-24712-1-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu May 05 00:58:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay5kj-0002YE-GN
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090AbcEDW6l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 18:58:41 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38013 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbcEDW6k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:58:40 -0400
Received: by mail-wm0-f48.google.com with SMTP id g17so578549wme.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gg+GKdBkJUzaH1kPrj6TrmzBNe8w4hQbNUb3cXeDYas=;
        b=iIqpxnUcgrUDglZ7u3HW0on3tuIO0GzF5HZKR7YcBEXTB6Cm8mleVYJ0KqX+U9bFJ8
         ctAVPvxnhvmd4+eminzWhO17NEkIzDbQ0FgeTP/o/UH+YfmK9jhO+x38PjH91YM/iCIU
         0EkPPzoqHAmTvXfWqfqn0zDOvxu1ES93TnZkYIR0Cd613CN/Zcbr+NPeKTxlbseVPMG1
         4H+FjLstExi4/K/fTx8CJ9RwaGMuCqZwAUu74rk/GfcgRILK+XSsdxYuGgApMwZkZsn2
         Hn+PJ5Opg6+0Kp0RyfrwdoJ3LGUKGXTCjMfwPY3VGLi8KLsQ4mVftXFpf3CNxCX415GR
         91UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gg+GKdBkJUzaH1kPrj6TrmzBNe8w4hQbNUb3cXeDYas=;
        b=WeUTqZjAbF/1xm1/WESzDF3uRYqVMZaYbehP0nAbK/ARedUfZMTJFz6FZq7CMXBEMR
         WO5ovf3Cb2Ou7SnS/zpvkjPw5MqgwjFhFWE7eOH6Cd0ByKGvq1pEuR+5BGRUtl6Nxyaf
         eGxhV7OXTA0eY6Uiz2MD8u/NbFmBEFGqZyrpBDOukI4OvTJW8rc16UieYOYmUFd6o/LA
         g7RuOVYpWfvqndPxMlcYIYrm8egbDv9FN3WWVzMbwpyjGlqJzU5f92pbeud/cTUktzBG
         6xCB0IeDZzoxICDak/+xHFySDyHAZpTcGX1x2q2grGMkZH1kS/anzMq2G5N9BkvTYECD
         Co+g==
X-Gm-Message-State: AOPr4FUJaSFu1jAblrwahAu6qj8Oww/nJGmQrDXT7Gzd2Vkv+N7XA+LaCQdy+krjMirweg==
X-Received: by 10.194.75.197 with SMTP id e5mr4156565wjw.154.1462402713881;
        Wed, 04 May 2016 15:58:33 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id us3sm6557967wjc.41.2016.05.04.15.58.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2016 15:58:33 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1462402692-24712-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293618>

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
 Documentation/config.txt     | 17 +++++++++++++++++
 Documentation/githooks.txt   | 12 ++++++++----
 cache.h                      |  1 +
 config.c                     |  3 +++
 environment.c                |  1 +
 run-command.c                |  5 ++++-
 t/t1350-config-hooks-path.sh | 37 ++++++++++++++++++++++++++++++++++++=
+
 7 files changed, 71 insertions(+), 5 deletions(-)
 create mode 100755 t/t1350-config-hooks-path.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..6cc069f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -618,6 +618,23 @@ core.attributesFile::
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
+The path can be either absolute or relative. A relative path is
+taken as relative to the directory where the hooks are run (see
+the "DESCRIPTION" section of linkgit:githooks[5]).
++
+This configuration variable is useful in cases where you'd like to
+centrally configure your Git hooks instead of configuring them on a
+per-repository basis, or as a more flexible and centralized
+alternative to having an `init.templateDir` where you've changed
+default hooks.
+
 core.editor::
 	Commands such as `commit` and `tag` that lets you edit
 	messages by launching an editor uses the value of this
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 3049574..d82e912 100644
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
 Before Git invokes a hook, it changes its working directory to either
 the root of the working tree in a non-bare repository, or to the
diff --git a/cache.h b/cache.h
index fd728f0..c071f5d 100644
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
index e4593cd..f5c57a5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -825,7 +825,10 @@ const char *find_hook(const char *name)
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
index 0000000..5e3fb3a
--- /dev/null
+++ b/t/t1350-config-hooks-path.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description=3D'Test the core.hooksPath configuration variable'
+
+. ./test-lib.sh
+
+test_expect_success 'set up a pre-commit hook in core.hooksPath' '
+	mkdir -p .git/custom-hooks .git/hooks &&
+	write_script .git/custom-hooks/pre-commit <<-\EOF &&
+	echo CUSTOM >>actual
+	EOF
+	write_script .git/hooks/pre-commit <<-\EOF
+	echo NORMAL >>actual
+	EOF
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
+	cat >expect <<-\EOF &&
+	NORMAL
+	CUSTOM
+	CUSTOM
+	CUSTOM
+	CUSTOM
+	EOF
+	test_cmp expect actual
+'
+
+test_done
--=20
2.1.3
