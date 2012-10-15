From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/12] Add git-check-ignore sub-command
Date: Mon, 15 Oct 2012 13:28:06 +0700
Message-ID: <1350282486-4646-12-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:30:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeBl-0001vF-H5
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab2JOG36 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:29:58 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55849 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab2JOG35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:29:57 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4544170pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VwZ7FHFsRW6lTp00UODK4M9eF0nI97htDDRpytvw43c=;
        b=hQB5TY0LAwFXUZ4CGfqskQqiUswZuZzjlCq141nioeNcrmYk0eLUJ+JxloePv197rX
         tysqC8fP+dukyGbIpVL5roN1BfH30b8a7CZbjd+WcWNydg0yw/vDeRQ+AzQFLplepDRL
         q36vSfVaJ8BdxfQnMfvJUyJdZBE1wOhAgca6bp7C9xC1MMoxoA8xC4YFQkCM7c6c/9vT
         NC7tBnmedOZ3poFRCML9SqxudESyISRkToSc3Y2bpjhvZ/7KZu5OKMruYEC/cSS6r9sS
         CUiFO7A2T0iELuyfmFPGrdvhXZbKMdIbv14mR3VVxD0SMP3FwKzhywv84vkIHxO22hBA
         1QPQ==
Received: by 10.66.78.231 with SMTP id e7mr30298013pax.44.1350282597447;
        Sun, 14 Oct 2012 23:29:57 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id rw5sm8576887pbc.54.2012.10.14.23.29.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:29:56 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:29:46 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207723>

=46rom: Adam Spiers <git@adamspiers.org>

This works in a similar manner to git-check-attr.  Some code
was reused from add.c by refactoring out into pathspec.c.

Thanks to Jeff King and Junio C Hamano for the idea:
http://thread.gmane.org/gmane.comp.version-control.git/108671/focus=3D1=
08815

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                             |   1 +
 Documentation/git-check-ignore.txt     |  85 +++++
 Documentation/gitignore.txt            |   6 +-
 Makefile                               |   1 +
 builtin.h                              |   1 +
 builtin/check-ignore.c                 | 170 ++++++++++
 command-list.txt                       |   1 +
 contrib/completion/git-completion.bash |   1 +
 git.c                                  |   1 +
 t/t0007-ignores.sh                     | 587 +++++++++++++++++++++++++=
++++++++
 10 files changed, 852 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/git-check-ignore.txt
 create mode 100644 builtin/check-ignore.c
 create mode 100755 t/t0007-ignores.sh

diff --git a/.gitignore b/.gitignore
index f1acd3e..20ef4e8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -19,6 +19,7 @@
 /git-bundle
 /git-cat-file
 /git-check-attr
+/git-check-ignore
 /git-check-ref-format
 /git-checkout
 /git-checkout-index
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-che=
ck-ignore.txt
new file mode 100644
index 0000000..96fa7bc
--- /dev/null
+++ b/Documentation/git-check-ignore.txt
@@ -0,0 +1,85 @@
+git-check-ignore(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-check-ignore - Debug gitignore / exclude files
+
+
+SYNOPSIS
+--------
+[verse]
+'git check-ignore' [options] pathname...
+'git check-ignore' [options] --stdin < <list-of-paths>
+
+DESCRIPTION
+-----------
+
+For each pathname given via the command-line or from a file via
+`--stdin`, this command will list the first exclude pattern found (if
+any) which explicitly excludes or includes that pathname.  Note that
+within any given exclude file, later patterns take precedence over
+earlier ones, so any matching pattern which this command outputs may
+not be the one you would immediately expect.
+
+OPTIONS
+-------
+-q, --quiet::
+	Don't output anything, just set exit status.  This is only
+	valid with a single pathname.
+
+-v, --verbose::
+	Also output details about the matching pattern (if any)
+	for each given pathname.
+
+--stdin::
+	Read file names from stdin instead of from the command-line.
+
+-z::
+	The output format is modified to be machine-parseable (see
+	below).  If `--stdin` is also given, input paths are separated
+	with a NUL character instead of a linefeed character.
+
+OUTPUT
+------
+
+By default, any of the given pathnames which match an ignore pattern
+will be output, one per line.  If no pattern matches a given path,
+nothing will be output for that path; this means that path will not be
+ignored.
+
+If `--verbose` is specified, the output is a series of lines of the fo=
rm:
+
+<source> <COLON> <linenum> <COLON> <pattern> <HT> <pathname>
+
+<pathname> is the path of a file being queried, <pattern> is the
+matching pattern, <source> is the pattern's source file, and <linenum>
+is the line number of the pattern within that source.  If the pattern
+contained a `!` prefix or `/` suffix, it will be preserved in the
+output.  <source> will be an absolute path when referring to the file
+configured by `core.excludesfile`, or relative to the repository root
+when referring to `.git/info/exclude` or a per-directory exclude file.
+
+If `-z` is specified, the output is a series of lines of the form:
+
+EXIT STATUS
+-----------
+
+0::
+	One or more of the provided paths is ignored.
+
+1::
+	None of the provided paths are ignored.
+
+128::
+	A fatal error was encountered.
+
+SEE ALSO
+--------
+linkgit:gitignore[5]
+linkgit:gitconfig[5]
+linkgit:git-ls-files[5]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 2e7328b..f401b8c 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -153,8 +153,10 @@ The second .gitignore prevents git from ignoring
=20
 SEE ALSO
 --------
-linkgit:git-rm[1], linkgit:git-update-index[1],
-linkgit:gitrepository-layout[5]
+linkgit:git-rm[1],
+linkgit:git-update-index[1],
+linkgit:gitrepository-layout[5],
+linkgit:git-check-ignore[1]
=20
 GIT
 ---
diff --git a/Makefile b/Makefile
index 48facad..8476fc8 100644
--- a/Makefile
+++ b/Makefile
@@ -822,6 +822,7 @@ BUILTIN_OBJS +=3D builtin/branch.o
 BUILTIN_OBJS +=3D builtin/bundle.o
 BUILTIN_OBJS +=3D builtin/cat-file.o
 BUILTIN_OBJS +=3D builtin/check-attr.o
+BUILTIN_OBJS +=3D builtin/check-ignore.o
 BUILTIN_OBJS +=3D builtin/check-ref-format.o
 BUILTIN_OBJS +=3D builtin/checkout-index.o
 BUILTIN_OBJS +=3D builtin/checkout.o
diff --git a/builtin.h b/builtin.h
index dffb34e..d57faf4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -58,6 +58,7 @@ extern int cmd_cat_file(int argc, const char **argv, =
const char *prefix);
 extern int cmd_checkout(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_checkout_index(int argc, const char **argv, const char =
*prefix);
 extern int cmd_check_attr(int argc, const char **argv, const char *pre=
fix);
+extern int cmd_check_ignore(int argc, const char **argv, const char *p=
refix);
 extern int cmd_check_ref_format(int argc, const char **argv, const cha=
r *prefix);
 extern int cmd_cherry(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_cherry_pick(int argc, const char **argv, const char *pr=
efix);
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
new file mode 100644
index 0000000..d446ade
--- /dev/null
+++ b/builtin/check-ignore.c
@@ -0,0 +1,170 @@
+#include "builtin.h"
+#include "cache.h"
+#include "dir.h"
+#include "quote.h"
+#include "pathspec.h"
+#include "parse-options.h"
+
+static int quiet, verbose, stdin_paths;
+static const char * const check_ignore_usage[] =3D {
+"git check-ignore [options] pathname...",
+"git check-ignore [options] --stdin < <list-of-paths>",
+NULL
+};
+
+static int null_term_line;
+
+static const struct option check_ignore_options[] =3D {
+	OPT__QUIET(&quiet, N_("suppress progress reporting")),
+	OPT__VERBOSE(&verbose, N_("be verbose")),
+	OPT_GROUP(""),
+	OPT_BOOLEAN(0, "stdin", &stdin_paths,
+		    N_("read file names from stdin")),
+	OPT_BOOLEAN('z', NULL, &null_term_line,
+		    N_("input paths are terminated by a null character")),
+	OPT_END()
+};
+
+static void output_exclude(const char *path, struct exclude *exclude)
+{
+	char *bang =3D exclude->flags & EXC_FLAG_NEGATIVE ? "!" : "";
+	char *dir  =3D (exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
+	if (!null_term_line) {
+		if (!verbose) {
+			write_name_quoted(path, stdout, '\n');
+		} else {
+			quote_c_style(exclude->src, NULL, stdout, 0);
+			printf(":%d:%s%s%s\t",
+			       exclude->srcpos,
+			       bang, exclude->pattern, dir);
+			quote_c_style(path, NULL, stdout, 0);
+			fputc('\n', stdout);
+		}
+	} else {
+		if (!verbose) {
+			printf("%s%c", path, '\0');
+		} else {
+			printf("%s%c%d%c%s%s%s%c%s%c",
+			       exclude->src, '\0',
+			       exclude->srcpos, '\0',
+			       bang, exclude->pattern, dir, '\0',
+			       path, '\0');
+		}
+	}
+}
+
+static int check_ignore(const char *prefix, const char **pathspec)
+{
+	struct dir_struct dir;
+	const char *path;
+	char *seen =3D NULL;
+	int num_ignored =3D 0;
+
+	/* read_cache() is only necessary so we can watch out for submodules.=
 */
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	memset(&dir, 0, sizeof(dir));
+	dir.flags |=3D DIR_COLLECT_IGNORED;
+	setup_standard_excludes(&dir);
+
+	if (pathspec) {
+		int i;
+		struct path_exclude_check check;
+		struct exclude *exclude;
+
+		path_exclude_check_init(&check, &dir);
+		if (!seen)
+			seen =3D find_used_pathspec(pathspec);
+		for (i =3D 0; pathspec[i]; i++) {
+			const char *full_path;
+			path =3D pathspec[i];
+			full_path =3D prefix_path(prefix, prefix
+						? strlen(prefix) : 0, path);
+			full_path =3D treat_gitlink(full_path);
+			validate_path(prefix, full_path);
+			if (!seen[i] && path[0]) {
+				int dtype =3D DT_UNKNOWN;
+				exclude =3D last_exclude_matching_path(&check, full_path,
+								     -1, &dtype);
+				if (exclude) {
+					if (!quiet)
+						output_exclude(path, exclude);
+					num_ignored++;
+				}
+			}
+		}
+		free(seen);
+		free_directory(&dir);
+		path_exclude_check_clear(&check);
+	} else {
+		printf("no pathspec\n");
+	}
+	return num_ignored;
+}
+
+static int check_ignore_stdin_paths(const char *prefix)
+{
+	struct strbuf buf, nbuf;
+	char **pathspec =3D NULL;
+	size_t nr =3D 0, alloc =3D 0;
+	int line_termination =3D null_term_line ? 0 : '\n';
+	int num_ignored;
+
+	strbuf_init(&buf, 0);
+	strbuf_init(&nbuf, 0);
+	while (strbuf_getline(&buf, stdin, line_termination) !=3D EOF) {
+		if (line_termination && buf.buf[0] =3D=3D '"') {
+			strbuf_reset(&nbuf);
+			if (unquote_c_style(&nbuf, buf.buf, NULL))
+				die("line is badly quoted");
+			strbuf_swap(&buf, &nbuf);
+		}
+		ALLOC_GROW(pathspec, nr + 1, alloc);
+		pathspec[nr] =3D xcalloc(strlen(buf.buf) + 1, sizeof(*buf.buf));
+		strcpy(pathspec[nr++], buf.buf);
+	}
+	ALLOC_GROW(pathspec, nr + 1, alloc);
+	pathspec[nr] =3D NULL;
+	num_ignored =3D check_ignore(prefix, (const char **)pathspec);
+	maybe_flush_or_die(stdout, "attribute to stdout");
+	strbuf_release(&buf);
+	strbuf_release(&nbuf);
+	free(pathspec);
+	return num_ignored;
+}
+
+int cmd_check_ignore(int argc, const char **argv, const char *prefix)
+{
+	int num_ignored =3D 0;
+
+	git_config(git_default_config, NULL);
+
+	argc =3D parse_options(argc, argv, prefix, check_ignore_options,
+			     check_ignore_usage, 0);
+
+	if (stdin_paths) {
+		if (0 < argc)
+			die(_("cannot specify pathnames with --stdin"));
+	} else {
+		if (null_term_line)
+			die(_("-z only makes sense with --stdin"));
+		if (argc =3D=3D 0)
+			die(_("no path specified"));
+	}
+	if (quiet) {
+		if (argc > 1)
+			die(_("--quiet is only valid with a single pathname"));
+		if (verbose)
+			die(_("cannot have both --quiet and --verbose"));
+	}
+
+	if (stdin_paths) {
+		num_ignored =3D check_ignore_stdin_paths(prefix);
+	} else {
+		num_ignored =3D check_ignore(prefix, argv);
+		maybe_flush_or_die(stdout, "ignore to stdout");
+	}
+
+	return num_ignored > 0 ? 0 : 1;
+}
diff --git a/command-list.txt b/command-list.txt
index 14ea67a..ef7f39c 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -12,6 +12,7 @@ git-branch                              mainporcelain=
 common
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
+git-check-ignore                        purehelpers
 git-checkout                            mainporcelain common
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 2e1b5e1..1fb896b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -842,6 +842,7 @@ __git_list_porcelain_commands ()
 		archimport)       : import;;
 		cat-file)         : plumbing;;
 		check-attr)       : plumbing;;
+		check-ignore)     : plumbing;;
 		check-ref-format) : plumbing;;
 		checkout-index)   : plumbing;;
 		commit-tree)      : plumbing;;
diff --git a/git.c b/git.c
index d232de9..0b31e66 100644
--- a/git.c
+++ b/git.c
@@ -340,6 +340,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "check-attr", cmd_check_attr, RUN_SETUP },
+		{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 		{ "checkout-index", cmd_checkout_index,
diff --git a/t/t0007-ignores.sh b/t/t0007-ignores.sh
new file mode 100755
index 0000000..7fd7e53
--- /dev/null
+++ b/t/t0007-ignores.sh
@@ -0,0 +1,587 @@
+#!/bin/sh
+
+test_description=3Dcheck-ignore
+
+. ./test-lib.sh
+
+init_vars () {
+	global_excludes=3D"$HOME/global-excludes"
+}
+
+enable_global_excludes () {
+	init_vars
+	git config core.excludesfile "$global_excludes"
+}
+
+expect_in () {
+	dest=3D"$HOME/expected-$1" text=3D"$2"
+	if test -z "$text"
+	then
+		>"$dest" # avoid newline
+	else
+		echo "$text" >"$dest"
+	fi
+}
+
+expect () {
+	expect_in stdout "$1"
+}
+
+expect_from_stdin () {
+	cat >"$HOME/expected-stdout"
+}
+
+test_stderr () {
+	expected=3D"$1"
+	expect_in stderr "$1" &&
+	test_cmp "$HOME/expected-stderr" "$HOME/stderr"
+}
+
+stderr_contains () {
+	regexp=3D"$1"
+	if grep -q "$regexp" "$HOME/stderr"
+	then
+		return 0
+	else
+		echo "didn't find /$regexp/ in $HOME/stderr"
+		cat "$HOME/stderr"
+		return 1
+	fi
+}
+
+stderr_empty_on_success () {
+	expect_code=3D"$1"
+	if test $expect_code =3D 0
+	then
+		test_stderr ""
+	else
+		# If we expect failure then stderr might or might not be empty
+		# due to --quiet - the caller can check its contents
+		return 0
+	fi
+}
+
+test_check_ignore () {
+	args=3D"$1" expect_code=3D"${2:-0}" global_args=3D"$3"
+
+	init_vars &&
+	rm -f "$HOME/stdout" "$HOME/stderr" "$HOME/cmd" &&
+	echo $(which git) $global_args check-ignore $quiet_opt $verbose_opt $=
args \
+		>"$HOME/cmd" &&
+	pwd >"$HOME/pwd" &&
+	test_expect_code "$expect_code" \
+		git $global_args check-ignore $quiet_opt $verbose_opt $args \
+		>"$HOME/stdout" 2>"$HOME/stderr" &&
+	test_cmp "$HOME/expected-stdout" "$HOME/stdout" &&
+	stderr_empty_on_success "$expect_code"
+}
+
+test_expect_success_multi () {
+	testname=3D"$1" expect_verbose=3D"$2" code=3D"$3"
+
+	expect=3D$( echo "$expect_verbose" | sed -e 's/.*	//' )
+
+	test_expect_success "$testname" "
+		expect '$expect' &&
+		$code
+	"
+
+	for quiet_opt in '-q' '--quiet'
+	do
+		test_expect_success "$testname${quiet_opt:+ with $quiet_opt}" "
+			expect '' &&
+			$code
+		"
+	done
+	quiet_opt=3D
+
+	for verbose_opt in '-v' '--verbose'
+	do
+		test_expect_success "$testname${verbose_opt:+ with $verbose_opt}" "
+			expect '$expect_verbose' &&
+			$code
+		"
+	done
+	verbose_opt=3D
+}
+
+test_expect_success 'setup' '
+	init_vars
+	mkdir -p a/b/ignored-dir a/submodule b &&
+	ln -s b a/symlink &&
+	(
+		cd a/submodule &&
+		git init &&
+		echo a > a &&
+		git add a &&
+		git commit -m"commit in submodule"
+	) &&
+	git add a/submodule &&
+	cat <<-\EOF >.gitignore &&
+		one
+	EOF
+	cat <<-\EOF >a/.gitignore &&
+		two*
+		*three
+	EOF
+	cat <<-\EOF >a/b/.gitignore &&
+		four
+		five
+		# this comment should affect the line numbers
+		six
+		ignored-dir/
+		# and so should this blank line:
+
+		!on*
+		!two
+	EOF
+	echo "seven" >a/b/ignored-dir/.gitignore &&
+	test -n "$HOME" &&
+	cat <<-\EOF >"$global_excludes" &&
+		globalone
+		!globaltwo
+		globalthree
+	EOF
+	cat <<-\EOF >>.git/info/exclude
+		per-repo
+	EOF
+'
+
+######################################################################=
######
+#
+# test invalid inputs
+
+test_expect_success_multi 'empty command line' '' '
+	test_check_ignore "" 128 &&
+	stderr_contains "fatal: no path specified"
+'
+
+test_expect_success '-q with multiple args' '
+	expect "" &&
+	test_check_ignore "-q one two" 128 &&
+	stderr_contains "fatal: --quiet is only valid with a single pathname"
+'
+
+test_expect_success '--quiet with multiple args' '
+	expect "" &&
+	test_check_ignore "--quiet one two" 128 &&
+	stderr_contains "fatal: --quiet is only valid with a single pathname"
+'
+
+for verbose_opt in '-v' '--verbose'
+do
+	for quiet_opt in '-q' '--quiet'
+	do
+		test_expect_success "$quiet_opt $verbose_opt" "
+			expect '' &&
+			test_check_ignore '$quiet_opt $verbose_opt foo' 128 &&
+			stderr_contains 'fatal: cannot have both --quiet and --verbose'
+		"
+	done
+done
+
+test_expect_success '--quiet with multiple args' '
+	expect "" &&
+	test_check_ignore "--quiet one two" 128 &&
+	stderr_contains "fatal: --quiet is only valid with a single pathname"
+'
+
+test_expect_success_multi 'erroneous use of --' '' '
+	test_check_ignore "--" 128 &&
+	stderr_contains "fatal: no path specified"
+'
+
+test_expect_success_multi '--stdin with superfluous arg' '' '
+	test_check_ignore "--stdin foo" 128 &&
+	stderr_contains "fatal: cannot specify pathnames with --stdin"
+'
+
+test_expect_success_multi '--stdin -z with superfluous arg' '' '
+	test_check_ignore "--stdin -z foo" 128 &&
+	stderr_contains "fatal: cannot specify pathnames with --stdin"
+'
+
+test_expect_success_multi '-z without --stdin' '' '
+	test_check_ignore "-z" 128 &&
+	stderr_contains "fatal: -z only makes sense with --stdin"
+'
+
+test_expect_success_multi '-z without --stdin and superfluous arg' '' =
'
+	test_check_ignore "-z foo" 128 &&
+	stderr_contains "fatal: -z only makes sense with --stdin"
+'
+
+test_expect_success_multi 'needs work tree' '' '
+	(
+		cd .git &&
+		test_check_ignore "foo" 128
+	) &&
+	stderr_contains "fatal: This operation must be run in a work tree"
+'
+
+######################################################################=
######
+#
+# test standard ignores
+
+test_expect_success_multi "top-level not ignored" '' '
+	test_check_ignore "foo" 1
+'
+
+test_expect_success_multi "top-level ignored" \
+	'.gitignore:1:one	one' '
+	test_check_ignore "one"
+'
+
+test_expect_success_multi 'sub-directory ignore from top' \
+	'.gitignore:1:one	a/one' '
+	test_check_ignore "a/one"
+'
+
+test_expect_success 'sub-directory local ignore' '
+	expect "a/3-three" &&
+	test_check_ignore "a/3-three a/three-not-this-one"
+'
+
+test_expect_success 'sub-directory local ignore with --verbose'  '
+	expect "a/.gitignore:2:*three	a/3-three" &&
+	test_check_ignore "--verbose a/3-three a/three-not-this-one"
+'
+
+test_expect_success 'local ignore inside a sub-directory' '
+	expect "3-three" &&
+	(
+		cd a &&
+		test_check_ignore "3-three three-not-this-one"
+	)
+'
+test_expect_success 'local ignore inside a sub-directory with --verbos=
e' '
+	expect "a/.gitignore:2:*three	3-three" &&
+	(
+		cd a &&
+		test_check_ignore "--verbose 3-three three-not-this-one"
+	)
+'
+
+test_expect_success_multi 'nested include' \
+	'a/b/.gitignore:8:!on*	a/b/one' '
+	test_check_ignore "a/b/one"
+'
+
+######################################################################=
######
+#
+# test ignored sub-directories
+
+test_expect_success_multi 'ignored sub-directory' \
+	'a/b/.gitignore:5:ignored-dir/	a/b/ignored-dir' '
+	test_check_ignore "a/b/ignored-dir"
+'
+
+test_expect_success 'multiple files inside ignored sub-directory' '
+	expect_from_stdin <<-\EOF &&
+		a/b/ignored-dir/foo
+		a/b/ignored-dir/twoooo
+		a/b/ignored-dir/seven
+	EOF
+	test_check_ignore "a/b/ignored-dir/foo a/b/ignored-dir/twoooo a/b/ign=
ored-dir/seven"
+'
+
+test_expect_success 'multiple files inside ignored sub-directory with =
-v' '
+	expect_from_stdin <<-\EOF &&
+		a/b/.gitignore:5:ignored-dir/	a/b/ignored-dir/foo
+		a/b/.gitignore:5:ignored-dir/	a/b/ignored-dir/twoooo
+		a/b/.gitignore:5:ignored-dir/	a/b/ignored-dir/seven
+	EOF
+	test_check_ignore "-v a/b/ignored-dir/foo a/b/ignored-dir/twoooo a/b/=
ignored-dir/seven"
+'
+
+test_expect_success 'cd to ignored sub-directory' '
+	expect_from_stdin <<-\EOF &&
+		foo
+		twoooo
+		../one
+		seven
+		../../one
+	EOF
+	(
+		cd a/b/ignored-dir &&
+		test_check_ignore "foo twoooo ../one seven ../../one"
+	)
+'
+
+test_expect_success 'cd to ignored sub-directory with -v' '
+	expect_from_stdin <<-\EOF &&
+		a/b/.gitignore:5:ignored-dir/	foo
+		a/b/.gitignore:5:ignored-dir/	twoooo
+		a/b/.gitignore:8:!on*	../one
+		a/b/.gitignore:5:ignored-dir/	seven
+		.gitignore:1:one	../../one
+	EOF
+	(
+		cd a/b/ignored-dir &&
+		test_check_ignore "-v foo twoooo ../one seven ../../one"
+	)
+'
+
+######################################################################=
######
+#
+# test handling of symlinks
+
+test_expect_success_multi 'symlink' '' '
+	test_check_ignore "a/symlink" 1
+'
+
+test_expect_success_multi 'beyond a symlink' '' '
+	test_check_ignore "a/symlink/foo" 128 &&
+	test_stderr "fatal: '\''a/symlink/foo'\'' is beyond a symbolic link"
+'
+
+test_expect_success_multi 'beyond a symlink from subdirectory' '' '
+	(
+		cd a &&
+		test_check_ignore "symlink/foo" 128
+	) &&
+	test_stderr "fatal: '\''symlink/foo'\'' is beyond a symbolic link"
+'
+
+######################################################################=
######
+#
+# test handling of submodules
+
+test_expect_success_multi 'submodule' '' '
+	test_check_ignore "a/submodule/one" 128 &&
+	test_stderr "fatal: Path '\''a/submodule/one'\'' is in submodule '\''=
a/submodule'\''"
+'
+
+test_expect_success_multi 'submodule from subdirectory' '' '
+	(
+		cd a &&
+		test_check_ignore "submodule/one" 128
+	) &&
+	test_stderr "fatal: Path '\''a/submodule/one'\'' is in submodule '\''=
a/submodule'\''"
+'
+
+######################################################################=
######
+#
+# test handling of global ignore files
+
+test_expect_success 'global ignore not yet enabled' '
+	expect_from_stdin <<-\EOF &&
+		.git/info/exclude:7:per-repo	per-repo
+		a/.gitignore:2:*three	a/globalthree
+		.git/info/exclude:7:per-repo	a/per-repo
+	EOF
+	test_check_ignore "-v globalone per-repo a/globalthree a/per-repo not=
-ignored a/globaltwo"
+'
+
+test_expect_success 'global ignore' '
+	enable_global_excludes &&
+	expect_from_stdin <<-\EOF &&
+		globalone
+		per-repo
+		globalthree
+		a/globalthree
+		a/per-repo
+		globaltwo
+	EOF
+	test_check_ignore "globalone per-repo globalthree a/globalthree a/per=
-repo not-ignored globaltwo"
+'
+
+test_expect_success 'global ignore with -v' '
+	enable_global_excludes &&
+	expect_from_stdin <<-EOF &&
+		$global_excludes:1:globalone	globalone
+		.git/info/exclude:7:per-repo	per-repo
+		$global_excludes:3:globalthree	globalthree
+		a/.gitignore:2:*three	a/globalthree
+		.git/info/exclude:7:per-repo	a/per-repo
+		$global_excludes:2:!globaltwo	globaltwo
+	EOF
+	test_check_ignore "-v globalone per-repo globalthree a/globalthree a/=
per-repo not-ignored globaltwo"
+'
+
+######################################################################=
######
+#
+# test --stdin
+
+cat <<-\EOF >stdin
+	one
+	not-ignored
+	a/one
+	a/not-ignored
+	a/b/on
+	a/b/one
+	a/b/one one
+	"a/b/one two"
+	"a/b/one\"three"
+	a/b/not-ignored
+	a/b/two
+	a/b/twooo
+	globaltwo
+	a/globaltwo
+	a/b/globaltwo
+	b/globaltwo
+EOF
+cat <<-\EOF >expected-default
+	one
+	a/one
+	a/b/on
+	a/b/one
+	a/b/one one
+	a/b/one two
+	"a/b/one\"three"
+	a/b/two
+	a/b/twooo
+	globaltwo
+	a/globaltwo
+	a/b/globaltwo
+	b/globaltwo
+EOF
+cat <<-EOF >expected-verbose
+	.gitignore:1:one	one
+	.gitignore:1:one	a/one
+	a/b/.gitignore:8:!on*	a/b/on
+	a/b/.gitignore:8:!on*	a/b/one
+	a/b/.gitignore:8:!on*	a/b/one one
+	a/b/.gitignore:8:!on*	a/b/one two
+	a/b/.gitignore:8:!on*	"a/b/one\"three"
+	a/b/.gitignore:9:!two	a/b/two
+	a/.gitignore:1:two*	a/b/twooo
+	$global_excludes:2:!globaltwo	globaltwo
+	$global_excludes:2:!globaltwo	a/globaltwo
+	$global_excludes:2:!globaltwo	a/b/globaltwo
+	$global_excludes:2:!globaltwo	b/globaltwo
+EOF
+
+sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
+	tr "\n" "\0" >stdin0
+sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
+	tr "\n" "\0" >expected-default0
+sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' expected-verbose | \
+	tr ":\t\n" "\0" >expected-verbose0
+
+test_expect_success '--stdin' '
+	expect_from_stdin <expected-default &&
+	test_check_ignore "--stdin" <stdin
+'
+
+test_expect_success '--stdin -q' '
+	expect "" &&
+	test_check_ignore "-q --stdin" <stdin
+'
+
+test_expect_success '--stdin -v' '
+	expect_from_stdin <expected-verbose &&
+	test_check_ignore "-v --stdin" <stdin
+'
+
+for opts in '--stdin -z' '-z --stdin'
+do
+	test_expect_success "$opts" "
+		expect_from_stdin <expected-default0 &&
+		test_check_ignore '$opts' <stdin0
+	"
+
+	test_expect_success "$opts -q" "
+		expect "" &&
+		test_check_ignore '-q $opts' <stdin0
+	"
+
+	test_expect_success "$opts -v" "
+		expect_from_stdin <expected-verbose0 &&
+		test_check_ignore '-v $opts' <stdin0
+	"
+done
+
+cat <<-\EOF >stdin
+	../one
+	../not-ignored
+	one
+	not-ignored
+	b/on
+	b/one
+	b/one one
+	"b/one two"
+	"b/one\"three"
+	b/two
+	b/not-ignored
+	b/twooo
+	../globaltwo
+	globaltwo
+	b/globaltwo
+	../b/globaltwo
+EOF
+cat <<-\EOF >expected-default
+	../one
+	one
+	b/on
+	b/one
+	b/one one
+	b/one two
+	"b/one\"three"
+	b/two
+	b/twooo
+	../globaltwo
+	globaltwo
+	b/globaltwo
+	../b/globaltwo
+EOF
+cat <<-EOF >expected-verbose
+	.gitignore:1:one	../one
+	.gitignore:1:one	one
+	a/b/.gitignore:8:!on*	b/on
+	a/b/.gitignore:8:!on*	b/one
+	a/b/.gitignore:8:!on*	b/one one
+	a/b/.gitignore:8:!on*	b/one two
+	a/b/.gitignore:8:!on*	"b/one\"three"
+	a/b/.gitignore:9:!two	b/two
+	a/.gitignore:1:two*	b/twooo
+	$global_excludes:2:!globaltwo	../globaltwo
+	$global_excludes:2:!globaltwo	globaltwo
+	$global_excludes:2:!globaltwo	b/globaltwo
+	$global_excludes:2:!globaltwo	../b/globaltwo
+EOF
+
+sed -e 's/^"//' -e 's/\\//' -e 's/"$//' stdin | \
+	tr "\n" "\0" >stdin0
+sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
+	tr "\n" "\0" >expected-default0
+sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' expected-verbose | \
+	tr ":\t\n" "\0" >expected-verbose0
+
+test_expect_success '--stdin from subdirectory' '
+	expect_from_stdin <expected-default &&
+	(
+		cd a &&
+		test_check_ignore "--stdin" <../stdin
+	)
+'
+
+test_expect_success '--stdin from subdirectory with -v' '
+	expect_from_stdin <expected-verbose &&
+	(
+		cd a &&
+		test_check_ignore "--stdin -v" <../stdin
+	)
+'
+
+for opts in '--stdin -z' '-z --stdin'
+do
+	test_expect_success "$opts from subdirectory" '
+		expect_from_stdin <expected-default0 &&
+		(
+			cd a &&
+			test_check_ignore "'"$opts"'" <../stdin0
+		)
+	'
+
+	test_expect_success "$opts from subdirectory with -v" '
+		expect_from_stdin <expected-verbose0 &&
+		(
+			cd a &&
+			test_check_ignore "'"$opts"' -v" <../stdin0
+		)
+	'
+done
+
+
+test_done
--=20
1.8.0.rc0.29.g1fdd78f
