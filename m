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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BFCC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 17:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B9C64D92
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 17:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhA2RT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 12:19:28 -0500
Received: from mout.web.de ([212.227.17.11]:37871 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232335AbhA2RRX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 12:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1611940513;
        bh=yiYAd8pzN7cRf/eCAeiqj3As6+S3XqwkVMsIV1EqJMQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=S2UHWH1VQymP7rpvpA/YEEssTcCNdqS3AvAx260bORR5Qvh5CLCEaySSqovpq3ghO
         3+vie3kbJM4/LEugIta7ckPhfelyfE03VW/h0/CPPsNAER1vL8gtcjWxdS6nT+Mp5k
         DcEsFKg5Nvm01vH+KdszwmEnCfvrfPhPa/adFM/4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([195.198.252.176]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Md4l4-1lNcDD29g2-00IGq6; Fri, 29 Jan 2021 18:15:13 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, random_n0body@icloud.com,
        levraiphilippeblain@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] MacOS: precompose_argv_prefix()
Date:   Fri, 29 Jan 2021 18:15:12 +0100
Message-Id: <20210129171512.28167-1-tboegi@web.de>
X-Mailer: git-send-email 2.30.0.155.g66e871b664
In-Reply-To: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
References: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BMot970r0XmFXLxYaMHvnO1gHHirYHyPeouFgXH7v0FwxEOFZbP
 Jq11L2bFl1u27iTuAI3mj9AJ1KI3rqDIHk5yPytcGKUp0+yc7FM9wQKceMOME3R6Gk3Pi6q
 QHdpPL28Q1MbDIkmEHfNxHIhpZVAApgveZ5ioN4ChTfobi9Zhm1VCf/r8ivh03lB7VNdrpA
 4YIZvg57cLT0KtD7MOc7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t0zH0AaOW9g=:A6vhwUIQre4CpuapaYmPkD
 VAq88WVXYbwx/3PhUMAf4PGyEkd3nW2MtZkm/t+T5+ORqmLIutDSbtiFQyOsEH6GLpAGKsLNR
 T9aeIQ1hTd6XY38M/epEJQfjnamGMZ6j81cABg40BMKW32IVw9w/cb5JKoTXekMh/Qx+MWKu3
 U1HIzxkr9wgnwTreBYCEc3IZWbaoT8ggzI/4EBGMtUkYwIRWWUbBOlCE0AEtS7Q4db+oFoG9L
 +tdNEtIJlIWMAhIcaLJX1ugtIFv893+3Av/KQM5saizgTgC6Kj74l3TZdKl7E3rklIY8iq/aK
 mrX8AP3RDfAAAaBzInu4DrmOAcxf43jnazaa9PCz+HWPbWlMa/p8o0piweEJcH2alx4ot31U/
 aX8l2racMKuZpktZsgz+H54D8VEZwHw7iU9ktWJW04jpf2niabB1eAnMEn3EL0HGvFgqe/jII
 +fvsLHpcpuqLPTnXIzS44y1igTS777dIBbIHWypu7RWsVGeiBC+q+tzPD16vBKcWLJQ53FOEj
 DPHAUAxqYpsOFP/ScSzcZCkuk0HTKVaFO5vRlHI2pRuIcxOskl0bCDdQBbebirVgZ1YfJXNcy
 EbMRytsbIiwf4clCcReWkn6GzCbIJq4rQLwGxltFTGC6zwAQsJbaoxHo9Q6lMlvqeM+1b6gtJ
 tyrtY0N8Pbs5QqZEElLk6H1qFiaWO+olypCYed6dl5+250aLLmq4Pk7kQTF/zxhJZSvC00n5U
 czEISq8+Z66KNfhwAsvjfkPyilW+r5hQTKardFGrI9xr5y6R9fjLn02Xlrn3E8Y1CpIWiVTRM
 3AmXk2SyWwMvxM8MNQZBckcOA0Q3EVo0OqTXMBVRDOpgl78LoKQFxbzQGx/b0acT5i74E7Rj5
 l9j9SA5fW3dr+8JnoZYg==
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

The rest becomes the prefix ("dir-inside-rep=C3=A5"), from where the paths=
pec
machinery expands the ".", more about this later.
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
Now move it into git.c .
As a cleanup, remove it from parse-options.c and diff*.c

There may be room for more cleanups.
This change intends to be a bug fix.
It does cleanup for the Git commands that have test cases in
t/t3910-mac-os-precompose.sh, more cleanup needs more tests and done
in future commits.

[1] git-bugreport-2021-01-06-1209.txt (git can't deal with special charact=
ers)
[2] https://lore.kernel.org/git/A102844A-9501-4A86-854D-E3B387D378AA@iclou=
d.com/

Reported-by: Daniel Troger <random_n0body@icloud.com>
Helped-By: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

Changes since V1:
 - major rework of the commit message
 - Use precompose_argv_prefix().
   I changed the suggestion precompose_argv(int argc, char **argv, char **=
prefix)
   to pass the string, and not char **, which probably should have been co=
nst char **
   Small details.
 - The function precompose_read_config_gently(void) is integrated into
   precompose_argv_prefix(). The changes in git.c look much nicer now.
 - > "I am *not* hinting that other commands need to be tested"
   I am not sure how to read this - I do think that more test could be goo=
d.
   And more setups that use decomposed unicode for $CWD and branch names.
   However, this patch should be a bugfix.
   The mild cleanup that is done turns it already into a not-only-bugfix-p=
atch.

=2D--
 builtin/diff-files.c         |  2 --
 builtin/diff-index.c         |  1 -
 builtin/diff-tree.c          |  1 -
 builtin/diff.c               |  2 +-
 builtin/submodule--helper.c  |  2 +-
 compat/precompose_utf8.c     | 36 ++++++++++++++++++++++++------------
 compat/precompose_utf8.h     |  2 +-
 git-compat-util.h            |  4 ++--
 git.c                        |  2 +-
 parse-options.c              |  1 -
 t/t3910-mac-os-precompose.sh | 16 ++++++++++++++++
 11 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 1e352dd8f7..454872e8fb 100644
=2D-- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -35,8 +35,6 @@ int cmd_diff_files(int argc, const char **argv, const ch=
ar *prefix)
 	 */
 	rev.diffopt.ita_invisible_in_index =3D 1;

-	precompose_argv(argc, argv);
-
 	argc =3D setup_revisions(argc, argv, &rev, NULL);
 	while (1 < argc && argv[1][0] =3D=3D '-') {
 		if (!strcmp(argv[1], "--base"))
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 7f5281c461..1c63965123 100644
=2D-- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -25,7 +25,6 @@ int cmd_diff_index(int argc, const char **argv, const ch=
ar *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev =3D 0;
-	precompose_argv(argc, argv);

 	argc =3D setup_revisions(argc, argv, &rev, NULL);
 	for (i =3D 1; i < argc; i++) {
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 9fc95e959f..104e9a844d 100644
=2D-- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -126,7 +126,6 @@ int cmd_diff_tree(int argc, const char **argv, const c=
har *prefix)
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.tweak =3D diff_tree_tweak_rev;

-	precompose_argv(argc, argv);
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
index 136250fbf6..780a557148 100644
=2D-- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -60,32 +60,44 @@ void probe_utf8_pathname_composition(void)
 	strbuf_release(&path);
 }

+static inline const char *precompose_string_if_needed(const char *in,
+						      iconv_t ic_precompose)
+{
+	size_t inlen;
+	size_t outlen;
+	if (has_non_ascii(in, (size_t)-1, &inlen)) {
+		char *out =3D reencode_string_iconv(in, inlen, ic_precompose,
+						  0, &outlen);
+		if (out && outlen =3D=3D inlen && !memcmp(in, out, outlen))
+			free(out); /* identical: no need to return a new one */
+		else
+			in =3D out;
+	}
+	return in;
+}

-void precompose_argv(int argc, const char **argv)
+const char *precompose_argv_prefix(int argc, const char **argv, const cha=
r *prefix)
 {
 	int i =3D 0;
-	const char *oldarg;
-	char *newarg;
 	iconv_t ic_precompose;

+	git_config_get_bool("core.precomposeunicode", &precomposed_unicode);
 	if (precomposed_unicode !=3D 1)
-		return;
+		return NULL;

 	ic_precompose =3D iconv_open(repo_encoding, path_encoding);
 	if (ic_precompose =3D=3D (iconv_t) -1)
-		return;
+		return NULL;

 	while (i < argc) {
-		size_t namelen;
-		oldarg =3D argv[i];
-		if (has_non_ascii(oldarg, (size_t)-1, &namelen)) {
-			newarg =3D reencode_string_iconv(oldarg, namelen, ic_precompose, 0, NU=
LL);
-			if (newarg)
-				argv[i] =3D newarg;
-		}
+		argv[i] =3D precompose_string_if_needed(argv[i], ic_precompose);
 		i++;
 	}
+	if (prefix) {
+		prefix =3D precompose_string_if_needed(prefix, ic_precompose);
+	}
 	iconv_close(ic_precompose);
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
index f0507432ee..1de404bdba 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -869,7 +869,6 @@ int parse_options(int argc, const char **argv, const c=
har *prefix,
 		usage_with_options(usagestr, options);
 	}

-	precompose_argv(argc, argv);
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

