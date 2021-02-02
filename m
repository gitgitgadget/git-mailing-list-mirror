Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AF0C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0318A64E58
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhBBPQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:16:26 -0500
Received: from mout.web.de ([212.227.17.11]:34491 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234892AbhBBPOF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 10:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1612278719;
        bh=ZA9VjkUTg0Hl91ozDR6mcPNRrT0c++bOMVedcrDjs1o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FpqLxsfvKjC4YblRU6IgKuEQrJ7HuTnwM+vGSAEIlbpgW/IuBYUWNeEJCq4YoRJps
         D47HIalUMag5mc8Nor5LCnKXaxwC4f9p47wzkPQb/OdljNByLsFYhiZ49MznJXOIM6
         WlSr06ybh+xPjLhQthjcMEsv7OW7bdKuo/jWyGj8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([195.198.252.176]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MYLmq-1lTPtl1Ax8-00VNmu; Tue, 02 Feb 2021 16:11:59 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, random_n0body@icloud.com,
        levraiphilippeblain@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/1] MacOS: precompose_argv_prefix()
Date:   Tue,  2 Feb 2021 16:11:58 +0100
Message-Id: <20210202151158.27028-1-tboegi@web.de>
X-Mailer: git-send-email 2.30.0.155.g66e871b664
In-Reply-To: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
References: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tEdhbhhHtRS/yXhfuWe25+4RK47RnfPqiQUbsx1rkwXeUVM42rA
 fbSlZOwJ57yLyFbnrqVVxOepPQRokui76YfgHLqqmmSVwGbLw1fAmjEzNjvqK9YcQSc+/jg
 heYIHN8LKNUNOzvr6lk7icjh/vhQg3XeWpluQhuEhqrCEEtZsy2LMfi1cZZTOJGC6F3gIb+
 j81XjwWrVkYiPGubhNeHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/42ltTC+P7I=:rPGnMhpObA6fNOL7F5Lmod
 3RUcjh9GRqaqqv0PH1KibFZpY6Hws4TPvWWGITgv0zqDHwU3AUGXHG5M8dUPyp6y4aGPN0Dlr
 nTCIEmyU5hUCE2WGaj0PRhaFuexpdCrOhxI9pWfJ6lTnWS0geWXpMAzNyWE6+ybucn23eUYav
 tF6uM4L8Ghdx/1IfNAIzhtRSgUUmS2JY1Eft06vKJO1rbMZ4vnWPy2twI1ulh1I1j8Ij6chTc
 KXcBYjlAj2jsZIWhy04fa9AumFMcwTVzvkL1IDiAMfbx5AIT+L2xQ9C4SJmuo5ehITjGe1NbE
 m6C5HrHELF53E+NuPKSlrSVEn/7/OBsyg6IO3KvkE166z36nNHGHaXbFsf7G9zoT1BRbpAeoX
 0kbenXAiO3hOPsuz53DmG095SIy2rk1/TLPRBDcJ4k87aSenRfmz92ZZjSFxMyXQoUbY81cVH
 UoE2He9eAov2vPd4n5XnQwtvXyZLOYh5YIMx7PryGOKbnZzkx5HaNYCgjL71qYEitXXZv+Zst
 HtiACTcAc/3f7Bo/T4dMtlGrCp4l9eDb/leygBHrEN7FGZS3R+7A1V9PG/ZZAjiYOyfJEHDYN
 LiVTrfVEEdd9hdVnegrJ2Y2Icx9WRXIb6nvIIeVRAmRlhRjvPPpNBG1n6e5s7mqEh8PsKwDT4
 9AxcJXTjiW7fOyD4J/CN8LBxVKKTOL5LWuAYMK8ekrSTxI03n+iIJw6ROn3kmRk1aF6YjzsEb
 aBJsNwJLO+JnZZswn4j7uYy1L2iqTusCp7jNPULivXdNItdEt2gu88rYXhFAisaW8Kch693Wi
 Lfm6rily8maeL8EOfNdmjfgSV/BpVTvUErCgbCvowOkfSr2cF/3JxxiNQ9Q0c8KffRzh8JfqC
 XM6vE1wp568AB8sAFXcQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The following sequence leads to a "BUG" assertion running under MacOS:

  DIR=3Dgit-test-restore-p
  Adiarnfd=3D$(printf 'A\314\210')
  DIRNAME=3Dxx${Adiarnfd}yy
  mkdir $DIR &&
  cd $DIR &&
  git init &&
  mkdir $DIRNAME &&
  cd $DIRNAME &&
  echo "Initial" >file &&
  git add file &&
  echo "One more line" >>file &&
  echo y | git restore -p .

 Initialized empty Git repository in /tmp/git-test-restore-p/.git/
 BUG: pathspec.c:495: error initializing pathspec_item
 Cannot close git diff-index --cached --numstat
 [snip]

The command `git restore` is run from a directory inside a Git repo.
Git needs to split the $CWD into 2 parts:
The path to the repo and "the rest", if any.
"The rest" becomes a "prefix" later used inside the pathspec code.

As an example, "/path/to/repo/dir-inside-rep=C3=A5" would determine
"/path/to/repo" as the root of the repo, the place where the
configuration file .git/config is found.

The rest becomes the prefix ("dir-inside-rep=C3=A5"), from where the
pathspec machinery expands the ".", more about this later.
If there is a decomposed form, (making the decomposing visible like this),
"dir-inside-rep=C2=B0a" doesn't match "dir-inside-rep=C3=A5".

Git commands need to:

 (a) read the configuration variable "core.precomposeunicode"
 (b) precocompose argv[]
 (c) precompose the prefix, if there was any

The first commit,
76759c7dff53 "git on Mac OS and precomposed unicode"
addressed (a) and (b).

The call to precompose_argv() was added into parse-options.c,
because that seemed to be a good place when the patch was written.

Commands that don't use parse-options need to do (a) and (b) themselfs.

The commands `diff-files`, `diff-index`, `diff-tree` and `diff`
learned (a) and (b) in
commit 90a78b83e0b8 "diff: run arguments through precompose_argv"

Branch names (or refs in general) using decomposed code points
resulting in decomposed file names had been fixed in
commit 8e712ef6fc97 "Honor core.precomposeUnicode in more places"

The bug report from above shows 2 things:
- more commands need to handle precomposed unicode
- (c) should be implemented for all commands using pathspecs

Solution:
precompose_argv() now handles the prefix (if needed), and is renamed into
precompose_argv_prefix().

Inside this function the config variable core.precomposeunicode is read
into the global variable precomposed_unicode, as before.
This reading is skipped if precomposed_unicode had been read before.

The original patch for preocomposed unicode, 76759c7dff53, placed
precompose_argv() into parse-options.c
Now add it into git.c (as well) for commands that don't use parse-options.

There is certainly room for cleanups.
This change intends to be a bug fix.
Cleanups needs more tests in e.g. t/t3910-mac-os-precompose.sh, and should
be done in future commits.

[1] git-bugreport-2021-01-06-1209.txt (git can't deal with special charact=
ers)
[2] https://lore.kernel.org/git/A102844A-9501-4A86-854D-E3B387D378AA@iclou=
d.com/

Reported-by: Daniel Troger <random_n0body@icloud.com>
Helped-By: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 Changes since V2:
 - reverted some of the cleanups done in V2, adjusted the commit message
 - found and fixed a major bug in compat/precompose_utf8.c, when non-unico=
de
   argv was send to Git, keep them "as is". That is the very old handling.
   If the original and precomposed string are identical, free() the new on=
e.

 builtin/diff-files.c         |  2 +-
 builtin/diff-index.c         |  2 +-
 builtin/diff-tree.c          |  2 +-
 builtin/diff.c               |  2 +-
 builtin/submodule--helper.c  |  2 +-
 compat/precompose_utf8.c     | 52 +++++++++++++++++++++++-------------
 compat/precompose_utf8.h     |  2 +-
 git-compat-util.h            |  4 +--
 git.c                        |  2 +-
 parse-options.c              |  2 +-
 t/t3910-mac-os-precompose.sh | 16 +++++++++++
 11 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 1e352dd8f7..e3851dd1c0 100644
=2D-- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -35,7 +35,7 @@ int cmd_diff_files(int argc, const char **argv, const ch=
ar *prefix)
 	 */
 	rev.diffopt.ita_invisible_in_index =3D 1;

-	precompose_argv(argc, argv);
+	prefix =3D precompose_argv_prefix(argc, argv, prefix);

 	argc =3D setup_revisions(argc, argv, &rev, NULL);
 	while (1 < argc && argv[1][0] =3D=3D '-') {
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 7f5281c461..c33d7af478 100644
=2D-- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -25,7 +25,7 @@ int cmd_diff_index(int argc, const char **argv, const ch=
ar *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev =3D 0;
-	precompose_argv(argc, argv);
+	prefix =3D precompose_argv_prefix(argc, argv, prefix);

 	argc =3D setup_revisions(argc, argv, &rev, NULL);
 	for (i =3D 1; i < argc; i++) {
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 9fc95e959f..178d12f07f 100644
=2D-- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -126,7 +126,7 @@ int cmd_diff_tree(int argc, const char **argv, const c=
har *prefix)
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.tweak =3D diff_tree_tweak_rev;

-	precompose_argv(argc, argv);
+	prefix =3D precompose_argv_prefix(argc, argv, prefix);
 	argc =3D setup_revisions(argc, argv, opt, &s_r_opt);

 	memset(&w, 0, sizeof(w));
diff --git a/builtin/diff.c b/builtin/diff.c
index 780c33877f..3c87c95967 100644
=2D-- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -452,7 +452,7 @@ int cmd_diff(int argc, const char **argv, const char *=
prefix)

 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
-	precompose_argv(argc, argv);
+	prefix =3D precompose_argv_prefix(argc, argv, prefix);

 	repo_init_revisions(the_repository, &rev, prefix);

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c2bd882d17..9d505a6329 100644
=2D-- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1257,7 +1257,7 @@ static int compute_summary_module_list(struct object=
_id *head_oid,
 	git_config(git_diff_basic_config, NULL);
 	init_revisions(&rev, info->prefix);
 	rev.abbrev =3D 0;
-	precompose_argv(diff_args.nr, diff_args.v);
+	precompose_argv_prefix(diff_args.nr, diff_args.v, NULL);
 	setup_revisions(diff_args.nr, diff_args.v, &rev, NULL);
 	rev.diffopt.output_format =3D DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBA=
CK;
 	rev.diffopt.format_callback =3D submodule_summary_callback;
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 136250fbf6..ec560565a8 100644
=2D-- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -60,32 +60,46 @@ void probe_utf8_pathname_composition(void)
 	strbuf_release(&path);
 }

-
-void precompose_argv(int argc, const char **argv)
+static inline const char *precompose_string_if_needed(const char *in)
 {
-	int i =3D 0;
-	const char *oldarg;
-	char *newarg;
-	iconv_t ic_precompose;
+	size_t inlen;
+	size_t outlen;
+	if (has_non_ascii(in, (size_t)-1, &inlen)) {
+		iconv_t ic_prec;
+		char *out;
+		if (precomposed_unicode < 0)
+			git_config_get_bool("core.precomposeunicode", &precomposed_unicode);
+		if (precomposed_unicode !=3D 1)
+			return in;
+		ic_prec =3D iconv_open(repo_encoding, path_encoding);
+		if (ic_prec =3D=3D (iconv_t) -1)
+			return in;
+
+		out =3D reencode_string_iconv(in, inlen, ic_prec, 0, &outlen);
+		if (out) {
+			if (outlen =3D=3D inlen && !memcmp(in, out, outlen))
+				free(out); /* no need to return indentical */
+			else
+				in =3D out;
+		}
+		iconv_close(ic_prec);

-	if (precomposed_unicode !=3D 1)
-		return;
+	}
+	return in;
+}

-	ic_precompose =3D iconv_open(repo_encoding, path_encoding);
-	if (ic_precompose =3D=3D (iconv_t) -1)
-		return;
+const char *precompose_argv_prefix(int argc, const char **argv, const cha=
r *prefix)
+{
+	int i =3D 0;

 	while (i < argc) {
-		size_t namelen;
-		oldarg =3D argv[i];
-		if (has_non_ascii(oldarg, (size_t)-1, &namelen)) {
-			newarg =3D reencode_string_iconv(oldarg, namelen, ic_precompose, 0, NU=
LL);
-			if (newarg)
-				argv[i] =3D newarg;
-		}
+		argv[i] =3D precompose_string_if_needed(argv[i]);
 		i++;
 	}
-	iconv_close(ic_precompose);
+	if (prefix) {
+		prefix =3D precompose_string_if_needed(prefix);
+	}
+	return prefix;
 }


diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index 6f843d3e1a..d70b84665c 100644
=2D-- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -28,7 +28,7 @@ typedef struct {
 	struct dirent_prec_psx *dirent_nfc;
 } PREC_DIR;

-void precompose_argv(int argc, const char **argv);
+const char *precompose_argv_prefix(int argc, const char **argv, const cha=
r *prefix);
 void probe_utf8_pathname_composition(void);

 PREC_DIR *precompose_utf8_opendir(const char *dirname);
diff --git a/git-compat-util.h b/git-compat-util.h
index 104993b975..93d9b4b7af 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -252,9 +252,9 @@ typedef unsigned long uintptr_t;
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
 #else
-static inline void precompose_argv(int argc, const char **argv)
+static inline const char *precompose_argv_prefix(int argc, const char **a=
rgv, const char *prefix)
 {
-	; /* nothing */
+	return prefix;
 }
 #define probe_utf8_pathname_composition()
 #endif
diff --git a/git.c b/git.c
index a00a0a4d94..16a485fbe7 100644
=2D-- a/git.c
+++ b/git.c
@@ -420,7 +420,7 @@ static int run_builtin(struct cmd_struct *p, int argc,=
 const char **argv)
 			int nongit_ok;
 			prefix =3D setup_git_directory_gently(&nongit_ok);
 		}
-
+		prefix =3D precompose_argv_prefix(argc, argv, prefix);
 		if (use_pager =3D=3D -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &=
&
 		    !(p->option & DELAY_PAGER_CONFIG))
 			use_pager =3D check_pager_config(p->cmd);
diff --git a/parse-options.c b/parse-options.c
index f0507432ee..fbea16eaf5 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -869,7 +869,7 @@ int parse_options(int argc, const char **argv, const c=
har *prefix,
 		usage_with_options(usagestr, options);
 	}

-	precompose_argv(argc, argv);
+	precompose_argv_prefix(argc, argv, NULL);
 	free(real_options);
 	free(ctx.alias_groups);
 	return parse_options_end(&ctx);
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index 54ce19e353..8f7b49221f 100755
=2D-- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -191,6 +191,22 @@ test_expect_failure 'handle existing decomposed filen=
ames' '
 	test_must_be_empty untracked
 '

+test_expect_success "unicode decomposed: git restore -p . " '
+	DIRNAMEPWD=3Ddir.Odiarnfc &&
+	DIRNAMEINREPO=3Ddir.$Adiarnfc &&
+	export DIRNAMEPWD DIRNAMEINREPO &&
+	git init $DIRNAMEPWD &&
+	(
+		cd $DIRNAMEPWD &&
+		mkdir $DIRNAMEINREPO &&
+		cd $DIRNAMEINREPO &&
+		echo "Initial" >file &&
+		git add file &&
+		echo "More stuff" >>file &&
+		echo y | git restore -p .
+	)
+'
+
 # Test if the global core.precomposeunicode stops autosensing
 # Must be the last test case
 test_expect_success "respect git config --global core.precomposeunicode" =
'
=2D-
2.30.0.155.g66e871b664

