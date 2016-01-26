From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 5/6] config: select .git/common/config with --repo
Date: Tue, 26 Jan 2016 18:44:44 +0700
Message-ID: <1453808685-21235-6-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Jan 26 12:45:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO24D-0005YT-IY
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 12:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934328AbcAZLpq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 06:45:46 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34776 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933850AbcAZLpo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 06:45:44 -0500
Received: by mail-pf0-f195.google.com with SMTP id 65so8134633pfd.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 03:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dq1TnuZEcDE9GolusjGjjT95DRDAe4KDgnT/Sd6n+Ek=;
        b=s1gNaR6IOcge1aNFnWZY93Qng88JVqxok7ZJH+o2gJDQiL4egzNqmP3N50uCko1TjK
         8ESf2nuWS4Tkv3wl/tm7z4Wm8AH5JnYZR/LkZgEoTyOMcNn5qcuEezCdlc1hna5NJa0D
         5HQ14/CNeXz0J5ozG8jWR831QgTUmp0hw1eODkmCBTSmi/bDjm7LYMqyON4heOjT6Qbe
         uyYrg6u6Dbecxpj6Ye2a472OMwBZAjwkyZ6vMSw39S6hSxOy7wWoi90Kj1TgEgQXX8t+
         rSyhY008AocSaHTcE2i+NycETZZFlVaQTmshUejwUJtjLrMuQr4tq5uXIS5hwrR2D8HR
         9BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=dq1TnuZEcDE9GolusjGjjT95DRDAe4KDgnT/Sd6n+Ek=;
        b=eKJrZVfyOaVbpGGnBVAw/pxNszT5PsoqWPZxlPwyEL35AQg/f7igET+UmQX5x9HH5J
         K1S5RK8aiVT1sBYjRpSntX2uM+1Eh/nviQ6KeaWDJVsk3rJJDUykt5C0FLOjyZ1H7JeE
         qABprpJ/GKVKeCt/8vdG48tTDomZ2aet3gK46liMWgBRrfpVqTWYQtEWjt7/eoTrE4JB
         VyafaHWRrMJchgauzPEQh6mXCmCD78See4nyAdknnnp8usAJY73/l0OBHBNwhsr2FbXT
         aROCWTrUOxFYCLXcGCTA9YlCfyWEQCsSFdnqOdIKml6LowyNSAkRMyfHRDpYGBN1kawv
         +9oA==
X-Gm-Message-State: AG10YOQAxl2jLQ8Q62Ihi4925S2QcTZbUgaiSe1c25438GE3kF6jHEeLxtspJi462blPzw==
X-Received: by 10.98.72.87 with SMTP id v84mr32818272pfa.15.1453808744326;
        Tue, 26 Jan 2016 03:45:44 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id 17sm1467754pfq.51.2016.01.26.03.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 03:45:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 26 Jan 2016 18:45:45 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453808685-21235-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284809>

This new option allows the user to write to or read from
=2Egit/common/config in worktree v1. In worktree v0, --repo is an alias
of --local.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-config.txt           | 14 +++++++++++++-
 Documentation/git-worktree.txt         |  4 ++++
 Documentation/gitrepository-layout.txt | 10 +++++-----
 builtin/config.c                       | 19 ++++++++++++++-----
 t/t2028-worktree-config.sh             | 23 ++++++++++++++++++++++-
 5 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.tx=
t
index 2608ca7..79fd453 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -47,7 +47,7 @@ checks or transformations are performed on the value.
=20
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
-'--system', '--global', '--local' and '--file <filename>' can be
+'--system', '--global', '--repo', '--local' and '--file <filename>' ca=
n be
 used to tell the command to read from only that location (see <<FILES>=
>).
=20
 When writing, the new value is written to the repository local
@@ -125,6 +125,18 @@ rather than from all available files.
 +
 See also <<FILES>>.
=20
+--repo::
+
+	For writing options: write to the repository file
+	`.git/config` if the configuration variable extensions.worktree
+	is not specified or has the value zero, `.git/worktrees/config`
+	otherwise.
++
+For reading options: read only from the same file rather than from all
+available files.
++
+See also <<FILES>>.
+
 --local::
 	For writing options: write to the repository `.git/config` file.
 	This is	the default behavior.
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 0846f2a..6082d4d 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -119,6 +119,10 @@ In this version, the repository config file `.git/=
config` is not
 shared anymore. A new file, `.git/common/config`, read for all
 worktrees. Shared configuration should be stored here.
=20
+Use "git config --repo" to store shared configuration variables. Use
+"git config --local" to store per-worktree ones. This works even in
+single-worktree mode.
+
 Version 0
 ~~~~~~~~~
 This is the first release. Version 0 is implied if extensions.worktree
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index d65345d..56175f0 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -254,6 +254,11 @@ common::
 	This directory is seen from all working directories. It is
 	meant to share files that all working directories can see.
=20
+common/config::
+	Repository specific configuration file. Note that if this file
+	is present, it must contain the variable extensions.worktree
+	whose value must be one or above.
+
 worktrees::
 	Contains administrative data for linked
 	working trees. Each subdirectory contains the working tree-related
@@ -261,11 +266,6 @@ worktrees::
 	$GIT_COMMON_DIR is set, in which case
 	"$GIT_COMMON_DIR/worktrees" will be used instead.
=20
-common/config::
-	Repository specific configuration file. Note that if this file
-	is present, it must contain the variable extensions.worktree
-	whose value must be one or above.
-
 worktrees/<id>/gitdir::
 	A text file containing the absolute path back to the .git file
 	that points to here. This is used to check if the linked
diff --git a/builtin/config.c b/builtin/config.c
index adc7727..6aecd13 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -21,7 +21,7 @@ static char delim =3D '=3D';
 static char key_delim =3D ' ';
 static char term =3D '\n';
=20
-static int use_global_config, use_system_config, use_local_config;
+static int use_global_config, use_system_config, use_local_config, use=
_repo_config;
 static struct git_config_source given_config_source;
 static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
@@ -54,7 +54,8 @@ static struct option builtin_config_options[] =3D {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file"=
)),
 	OPT_BOOL(0, "system", &use_system_config, N_("use system config file"=
)),
-	OPT_BOOL(0, "local", &use_local_config, N_("use repository config fil=
e")),
+	OPT_BOOL(0, "repo", &use_repo_config, N_("use per-repository config f=
ile")),
+	OPT_BOOL(0, "local", &use_local_config, N_("use per-worktree config f=
ile")),
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("us=
e given config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("r=
ead config from given blob object")),
 	OPT_GROUP(N_("Action")),
@@ -460,7 +461,8 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
 	if (use_global_config + use_system_config + use_local_config +
-	    !!given_config_source.file + !!given_config_source.blob > 1) {
+	    !!given_config_source.file + !!given_config_source.blob > 1 +
+	    use_repo_config) {
 		error("only one config file at a time.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
@@ -492,9 +494,16 @@ int cmd_config(int argc, const char **argv, const =
char *prefix)
 	}
 	else if (use_system_config)
 		given_config_source.file =3D git_etc_gitconfig();
-	else if (use_local_config)
+	else if (use_local_config ||
+		 (use_repo_config &&
+		  repository_format_worktree_version =3D=3D 0))
 		given_config_source.file =3D git_pathdup("config");
-	else if (given_config_source.file) {
+	else if (use_repo_config) {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		strbuf_addf(&sb, "%s/common/config", get_git_common_dir());
+		given_config_source.file =3D strbuf_detach(&sb, NULL);
+	} else if (given_config_source.file) {
 		if (!is_absolute_path(given_config_source.file) && prefix)
 			given_config_source.file =3D
 				xstrdup(prefix_filename(prefix,
diff --git a/t/t2028-worktree-config.sh b/t/t2028-worktree-config.sh
index 5561788..d11b2ce 100755
--- a/t/t2028-worktree-config.sh
+++ b/t/t2028-worktree-config.sh
@@ -19,6 +19,15 @@ test_expect_success 'main config is shared in versio=
n 0' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'config --repo on v0' '
+	git config --global new.var old-value &&
+	git config --repo new.var new-value &&
+	test_path_is_missing .git/common/config &&
+	git config --repo new.var >actual &&
+	echo new-value >expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'main config is for main worktree only (v1)' '
 	mkdir .git/common &&
 	git config -f .git/common/config extensions.worktree 1 &&
@@ -28,7 +37,7 @@ test_expect_success 'main config is for main worktree=
 only (v1)' '
 	test_must_fail git -C wt1 config wt.name
 '
=20
-test_expect_success 'worktrees/config is shared (v1)' '
+test_expect_success 'common/config is shared (v1)' '
 	git config -f .git/common/config some.thing is-shared &&
 	echo is-shared >expected &&
 	git config some.thing >actual &&
@@ -37,4 +46,16 @@ test_expect_success 'worktrees/config is shared (v1)=
' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'config --repo on v1' '
+	git config --global new.var1 old-value &&
+	git config --repo new.var1 new-value &&
+	grep var1 .git/common/config >/dev/null &&
+	git config --repo new.var1 >actual &&
+	echo new-value >expected &&
+	test_cmp expected actual &&
+	git -C wt2 config --repo new.var1 >actual &&
+	echo new-value >expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.7.0.288.g1d8ad15
