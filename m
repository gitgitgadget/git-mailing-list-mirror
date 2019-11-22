Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D089C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 01:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE02D2067D
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 01:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsiekMjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKVBQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 20:16:56 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41808 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKVBQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 20:16:56 -0500
Received: by mail-pg1-f202.google.com with SMTP id e6so2972632pgc.8
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 17:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2jtQB4Fw9PzV6oDhxokbCr4F7hJtKf4/IBA4xnYV4Cc=;
        b=nsiekMjkFO4uVApq5QO5wm+PxVSdLEYbn/7ZqLwCps60xUZsdlA/VNwgv12g5SvEnJ
         2wCw+B2BZtFp6UlENrVVFwKrdN5GcehVpmf+ClAg7DtIRmuoOtwrMRKHLi4EjjDNnAMU
         tlrsvFUCVLmlhoc6x9zoimh0df0w0M8N6Y/9XGCSXOm6hfN2Neajn/mumtcvW8VFC4Vj
         LSiAyZUfCdgfE0bVyvPQf8B6Oo88yVpUbVFah94ZyyPEIpqcO3gBelyrLEeBlW/2jjpf
         LHW+rWYTYvxvn+txjNrp3SC5hi0t66fiXgUy9/O7xG1uvT/m8XS/voamRF8L+nxi53F8
         qIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2jtQB4Fw9PzV6oDhxokbCr4F7hJtKf4/IBA4xnYV4Cc=;
        b=EIwb/k7VgiSKM/pyZnQEfj59J0Fyb4GbfdwXfsX+0qFuAWSZNbqCbIT/3deQVD8kY1
         HDn47c2/LljgATF3aDDD/zB/v2MspFU57MetR7e0g++5QqWVdgymfm/rlB8YkzhBpas5
         Scp09Zw7Z5vZnAOgAqAmEHsbknSnkZleeeeUDr0NiPw4i85ZCXwBtcidSmKnDdbvK1cp
         pD/wXI1LlFZGLUOuht7tA6VNhGH2TS/o8E5gwXkr+U7rqnM8L51TQ/iKCKGm++Nq7yc4
         K+qIERf2XtHt2uzqbzkn7KUxtitV2SzBL5PgjRlMN9zDfB2qz7ftEMW12w3gGQweFmon
         Uf1g==
X-Gm-Message-State: APjAAAWAr+Uqi8j3WLgVivwPQnuty5B9NkBN7C+nh7n8r5TwjSF3E71u
        SXtWQBl3CAERGoWueyy38s7v1lmXL1sng5rkKsATGz5pFT/Gz/9yQX9rdafGIEq7oekTS1KKFhn
        FaoEE7d8RRuee5BmxoKrNYIAP60dtOxg2YtMG/YKuBFSZ8axTWT5p8YANXM6OzwT25fVYVgTlCA
        ==
X-Google-Smtp-Source: APXvYqxRhZNh2/cEHJEfi2+xNMOu6/4aQ9UgO/wIaiq1hMp5Oj93jYmSj7AkLtjlBn7ybc0TBIubJrVX0uRb5XRnotc=
X-Received: by 2002:a65:6685:: with SMTP id b5mr12342741pgw.94.1574385415077;
 Thu, 21 Nov 2019 17:16:55 -0800 (PST)
Date:   Thu, 21 Nov 2019 17:16:46 -0800
Message-Id: <20191122011646.218346-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] grep: provide pathspecs/patterns via file or stdin
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git grep' how to receive pathspecs via file, and add convenience
flags for receiving pathspecs or patterns via stdin.

In some cases, the list of pathspecs to 'git grep' is longer than the
command line allows, or long enough that a user becomes fatigued reading
the command.  In other cases, a user may wish to write a script or
oneliner which generates a list of files to 'git grep' against. In both
scenarios, a reasonable workaround is to provide the list of pathspecs
via a file or stdin.

Before this change, it was already possible to receive patterns via
stdin by using the argument '-f -'. Now that there are two arguments
which could both use stdin, help safeguard the user from doing so by
providing convenience '--stdin-patterns' and '--stdin-pathspecs' which
are mutually exclusive.  (It is still possible to ask for '-f -
--pathspecs-file -', though.)

Finally, in order to match '--pathspecs-file', give '-f' a long form
'--patterns-file' too.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Providing too many pathspecs for the argument list to handle is causing
some gore out in the wild with git-secrets:
https://github.com/awslabs/git-secrets/issues/78

A short arg for --pathspecs-file didn't occur to me because grep has
many short args already, but if anyone has a suggestion I'll happily add
it.

The pathspec list is gathered into an argv_array because parse_pathspec
is only called once, against the entire list of pathspecs. Perhaps it
makes sense to concatenate the paths given on the command line with the
paths given via file, but since it was nontrivial to merge two
argv_arrays and I wasn't certain it was the right choice, I didn't do
so. I'd probably implement that by adding a utility function to
argv-array. ('-f somepatterns.txt -e otherpattern' concatenates the
patterns, by the way.)

 - Emily

 Documentation/git-grep.txt | 18 ++++++++++-
 builtin/grep.c             | 61 +++++++++++++++++++++++++++++++++-----
 t/t7810-grep.sh            | 52 ++++++++++++++++++++++++++++++--
 3 files changed, 121 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index c89fb569e3..fb588a3846 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -24,7 +24,8 @@ SYNOPSIS
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-W | --function-context]
 	   [--threads <num>]
-	   [-f <file>] [-e] <pattern>
+	   [--pathspecs-file <file>] [--stdin-pathspecs]
+	   [-f | --patterns-file <file>] [--stdin-patterns] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [--recurse-submodules] [--parent-basename <basename>]
 	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
@@ -270,7 +271,22 @@ providing this option will cause it to die.
 	See `grep.threads` in 'CONFIGURATION' for more information.
 
 -f <file>::
+--patterns-file <file>::
 	Read patterns from <file>, one per line.
+
+--stdin-patterns::
+	Read patterns from stdin, one per line. Equivalent to `-f -`. Cannot be
+	combined with `--stdin-pathspecs`.
+
+--pathspecs-file <file>::
+	Read pathspecs from <file>, one per line. Pathspecs passed in the
+	argument list will be ignored in this mode.
+
+--stdin-pathspecs::
+	Read pathspecs from stdin, one per line. Pathspecs passed in the
+	argument list will be ignored in this mode. Equivalent to
+	`--pathspecs-file -`.
+
 +
 Passing the pattern via <file> allows for providing a search pattern
 containing a \0.
diff --git a/builtin/grep.c b/builtin/grep.c
index 50ce8d9461..f6f9f84002 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -720,16 +720,38 @@ static int context_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static int file_callback(const struct option *opt, const char *arg, int unset)
+static int pathspec_file(struct argv_array *pathspec_argv, const char *arg)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!strcmp(arg, "-")) {
+		while (strbuf_getline(&sb, stdin) != EOF)
+			argv_array_push(pathspec_argv, sb.buf);
+	}
+	else {
+		if (!strbuf_read_file(&sb, arg, 0))
+			die_errno(_("cannot open '%s'"), arg);
+		argv_array_split(pathspec_argv, sb.buf);
+	}
+
+	strbuf_release(&sb);
+	return 0;
+}
+
+static int pathspec_file_callback(const struct option *opt,
+				  const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	return pathspec_file(opt->value, arg);
+}
+
+static int pattern_file(struct grep_opt *grep_opt, const char *arg)
 {
-	struct grep_opt *grep_opt = opt->value;
 	int from_stdin;
 	FILE *patterns;
 	int lno = 0;
 	struct strbuf sb = STRBUF_INIT;
 
-	BUG_ON_OPT_NEG(unset);
-
 	from_stdin = !strcmp(arg, "-");
 	patterns = from_stdin ? stdin : fopen(arg, "r");
 	if (!patterns)
@@ -748,6 +770,12 @@ static int file_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int pattern_file_callback(const struct option *opt, const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	return pattern_file(opt->value, arg);
+}
+
 static int not_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
@@ -803,12 +831,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct grep_opt opt;
 	struct object_array list = OBJECT_ARRAY_INIT;
 	struct pathspec pathspec;
+	struct argv_array pathspec_argv;
 	struct string_list path_list = STRING_LIST_INIT_NODUP;
 	int i;
 	int dummy;
 	int use_index = 1;
 	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
 	int allow_revs;
+	int stdin_patterns = 0;
+	int stdin_pathspecs = 0;
 
 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
@@ -896,8 +927,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('W', "function-context", &opt.funcbody,
 			N_("show the surrounding function")),
 		OPT_GROUP(""),
-		OPT_CALLBACK('f', NULL, &opt, N_("file"),
-			N_("read patterns from file"), file_callback),
+		OPT_CALLBACK('f', "patterns-file", &opt, N_("file"),
+			N_("read patterns from file"), pattern_file_callback),
+		OPT_BOOL(0, "stdin-patterns", &stdin_patterns,
+			 N_("read patterns from stdin")),
+		OPT_CALLBACK(0, "pathspecs-file", &pathspec_argv, N_("file"),
+			N_("read pathspecs from file"), pathspec_file_callback),
+		OPT_BOOL(0, "stdin-pathspecs", &stdin_pathspecs,
+			 N_("read pathspecs from stdin")),
 		{ OPTION_CALLBACK, 'e', NULL, &opt, N_("pattern"),
 			N_("match <pattern>"), PARSE_OPT_NONEG, pattern_callback },
 		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
@@ -949,6 +986,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	grep_commit_pattern_type(pattern_type_arg, &opt);
 
+	if (stdin_patterns && stdin_pathspecs)
+		die(_("cannot use stdin for both patterns and pathspecs"));
+
+	if (stdin_patterns)
+		pattern_file(&opt, "-");
+
+	if (stdin_pathspecs)
+		pathspec_file(&pathspec_argv, "-");
+
 	if (use_index && !startup_info->have_repository) {
 		int fallback = 0;
 		git_config_get_bool("grep.fallbacktonoindex", &fallback);
@@ -1057,7 +1103,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
-		       prefix, argv + i);
+		       prefix,
+		       (pathspec_argv.argc ? pathspec_argv.argv : argv) + i);
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
 	pathspec.recurse_submodules = !!recurse_submodules;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 7d7b396c23..be8e60cfa0 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -549,6 +549,10 @@ test_expect_success 'grep -f, non-existent file' '
 	test_must_fail git grep -f patterns
 '
 
+text_expect_success 'grep --pathspec-file, non-existent file' '
+	test_must_fail git grep --pathspecs-file pathspecs
+'
+
 cat >expected <<EOF
 file:foo mmap bar
 file:foo_mmap bar
@@ -582,8 +586,8 @@ mmap
 vvv
 EOF
 
-test_expect_success 'grep -f, multiple patterns' '
-	git grep -f patterns >actual &&
+test_expect_success 'grep --patterns-file, multiple patterns' '
+	git grep --patterns-file patterns >actual &&
 	test_cmp expected actual
 '
 
@@ -621,6 +625,11 @@ test_expect_success 'grep -f, ignore empty lines, read patterns from stdin' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep --stdin--patterns' '
+	git grep --stdin-patterns <patterns >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 y:y yy
 --
@@ -1125,6 +1134,45 @@ test_expect_success 'grep --no-index descends into repos, but not .git' '
 	)
 '
 
+test_expect_success 'setup pathspecs-file tests' '
+cat >excluded-file <<EOF &&
+bar
+EOF
+cat >pathspec-file <<EOF &&
+foo
+bar
+baz
+EOF
+cat >unrelated-file <<EOF &&
+xyz
+EOF
+git add excluded-file pathspec-file unrelated-file
+'
+
+cat >pathspecs <<EOF
+pathspec-file
+unrelated-file
+EOF
+
+cat >expected <<EOF
+pathspec-file:bar
+EOF
+
+test_expect_success 'grep --stdin-pathspecs' '
+	git grep --stdin-pathspecs "bar" <pathspecs >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --pathspecs-file with file' '
+	git grep --pathspecs-file pathspecs "bar" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --pathspec-file with stdin' '
+	git grep --pathspecs-file - "bar" <pathspecs >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'setup double-dash tests' '
 cat >double-dash <<EOF &&
 --
-- 
2.24.0.432.g9d3f5f5b63-goog

