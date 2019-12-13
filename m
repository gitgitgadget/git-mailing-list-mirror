Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7603EC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 04:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF0B2073B
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 04:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H6lMw6T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbfLMEND (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 23:13:03 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37343 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfLMEND (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 23:13:03 -0500
Received: by mail-pf1-f202.google.com with SMTP id 13so709418pfj.4
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 20:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=2ia8KrmSX/4G3AUGHCb3qNglKHkZSTtXRI0s4fDbaJw=;
        b=H6lMw6T8hYNb7Sqz3CIqzxu6EJL1GNMIXQHThxbzpPiXGv6F552Q00Pboua0hpeEEM
         pxxoh7d7y8M0AwuJ7CuQlmf1a54G3lwZJVLSHK3tfkrb4VQVamHOpVWEZ9Tc+JfIcc6G
         67SqwodL+ruunPwjxBlBv49inSotWG6lOHOoe5tTRtDekaoNyg4qUOWFFbDmcaPw3czm
         kvj2opdLdbTSkHQP5UCs/QCG1WXxSJqZLni6Sj1R4nKtvYGih1Eb3C5ZHJ06gC3z5ek/
         D+AuxWAq5VCAPbJHOeCmoHF/bq76jDBy7mIwuUU0l9afLLzJWEp885Tq7BgJwKzBFkiI
         F7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=2ia8KrmSX/4G3AUGHCb3qNglKHkZSTtXRI0s4fDbaJw=;
        b=cnVn6TYF88tFiYlrUgSMMl/r/o3mI1VPO6biD3hg4WrFF9YD48oP1nnUgAIZ24yw+G
         QnKN6n7ngzyDnhVvgAd5iY87vclfpUu5nnryb4FPifDQgft0RUTCz9b+8LqqrLfvWM7W
         U7VmIImJmO97eOXb1c8KfgFx7SEvpCqsy/Qqv3+G2LgLncEPG3NY/9Eh5SiBpoIWOdTw
         EyQNAkA04I10UuE7Tg9pv9VtgKcLJNYyRLC4A76I1CqSz+FBuqwQTQ6uAx0ecg8wJmFe
         uBeoLx9CQWr3c4PYLJ/l1y/wAHgzmyO1Ghdd2tZc+w0byTS5lhJ1jSmD0waMv956RGv/
         7phg==
X-Gm-Message-State: APjAAAV30IFxfGipVrD0U9W96rxeOqeE1q4aXN+nnBskHe1OPSayA/EO
        df05+QaQkRAIBcQoWsTFxKq7yWzx3IiZexBcD4DD0J65sieZgQjZbtBFUDkv/C5UWIPs3WYO0E/
        41Rsp3Ng9j+EBHkY5IxSjGTjx6AZ0rZWMtxyGYA8AbZastiDIRlWwf9wj+5HqApCPUFM0OALH0g
        ==
X-Google-Smtp-Source: APXvYqzD57kf/Nmk3Wt4fxFuuy3f/C+pAEt6zOSwtfXZnjrTXlE+tu5L/m3Su4WHTCNF0KSd99zRFvbZmKY3EJQQhYE=
X-Received: by 2002:a63:5f45:: with SMTP id t66mr14185855pgb.198.1576210380704;
 Thu, 12 Dec 2019 20:13:00 -0800 (PST)
Date:   Thu, 12 Dec 2019 20:12:54 -0800
In-Reply-To: <20191204203911.237056-1-emilyshaffer@google.com>
Message-Id: <20191213041254.13202-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3] grep: support the --pathspec-from-file option
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git grep' to use OPT_PATHSPEC_FROM_FILE and update the
documentation accordingly.

This changes enables 'git grep' to receive the pathspec from a file by
specifying the path, or from stdin by specifying '-' as the path. This
matches the previous functionality of '-f', so the documentation of '-f'
has been expanded to describe this functionality. To let '-f' match the
new '--pathspec-from-file' option, also teach a '--patterns-from-file'
long name to '-f'.

Since there are now two arguments which can attempt to read from stdin,
add a safeguard to check whether the user specified '-' for both of
them. It is still possible for a user to pass '/dev/stdin' to one or
both arguments at present; we do not explicitly check.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
I built this on 'next' locally, but it does require 'am/pathspec-from-file'
(which was merged to 'next').

Thanks all who caught the OSX/GfW CI failures; the test suite passed for me
in Linux and so I completely missed the uninitialized variables. Not a
great look for me...

Since v2, I got rid of the callback for -f arg and am now running it
directly; this means we can check for stdin in only one place, instead
of two, and get rid of some of the globals which were added elsewhere.
The test suite still passes for me (but still on Linux) so here's hoping
for a more favorable result with the rest of the CI.

 - Emily

 Documentation/git-grep.txt | 22 ++++++++++++++++--
 builtin/grep.c             | 43 ++++++++++++++++++++++++++--------
 t/t7810-grep.sh            | 47 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 98 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index c89fb569e3..56b1c5a302 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -24,7 +24,8 @@ SYNOPSIS
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-W | --function-context]
 	   [--threads <num>]
-	   [-f <file>] [-e] <pattern>
+	   [-f | --patterns-from-file <file>] [-e] <pattern>
+	   [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [--recurse-submodules] [--parent-basename <basename>]
 	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
@@ -270,7 +271,10 @@ providing this option will cause it to die.
 	See `grep.threads` in 'CONFIGURATION' for more information.
 
 -f <file>::
-	Read patterns from <file>, one per line.
+--patterns-from-file <file>::
+	Read patterns from <file>, one per line. If `<file>` is exactly `-` then
+	standard input is used; standard input cannot be used for both
+	--patterns-from-file and --pathspec-from-file.
 +
 Passing the pattern via <file> allows for providing a search pattern
 containing a \0.
@@ -289,6 +293,20 @@ In future versions we may learn to support patterns containing \0 for
 more search backends, until then we'll die when the pattern type in
 question doesn't support them.
 
+--pathspec-from-file <file>::
+	Read pathspec from <file> instead of the command line. If `<file>` is
+	exactly `-` then standard input is used; standard input cannot be used
+	for both --patterns-from-file and --pathspec-from-file. Pathspec elements
+	are separated by LF or CR/LF. Pathspec elements can be quoted as
+	explained for the configuration variable `core.quotePath` (see
+	linkgit:git-config[1]). See also `--pathspec-file-nul` and global
+	`--literal-pathspecs`.
+
+--pathspec-file-nul::
+	Only meaningful with `--pathspec-from-file`. Pathspec elements are
+	separated with NUL character and all other characters are taken
+	literally (including newlines and quotes).
+
 -e::
 	The next parameter is the pattern. This option has to be
 	used for patterns starting with `-` and should be used in
diff --git a/builtin/grep.c b/builtin/grep.c
index 50ce8d9461..28b9f99d4c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -720,26 +720,23 @@ static int context_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static int file_callback(const struct option *opt, const char *arg, int unset)
+static int read_pattern_file(struct grep_opt *grep_opt, const char *path)
 {
-	struct grep_opt *grep_opt = opt->value;
 	int from_stdin;
 	FILE *patterns;
 	int lno = 0;
 	struct strbuf sb = STRBUF_INIT;
 
-	BUG_ON_OPT_NEG(unset);
-
-	from_stdin = !strcmp(arg, "-");
-	patterns = from_stdin ? stdin : fopen(arg, "r");
+	from_stdin = !strcmp(path, "-");
+	patterns = from_stdin ? stdin : fopen(path, "r");
 	if (!patterns)
-		die_errno(_("cannot open '%s'"), arg);
+		die_errno(_("cannot open '%s'"), path);
 	while (strbuf_getline(&sb, patterns) == 0) {
 		/* ignore empty line like grep does */
 		if (sb.len == 0)
 			continue;
 
-		append_grep_pat(grep_opt, sb.buf, sb.len, arg, ++lno,
+		append_grep_pat(grep_opt, sb.buf, sb.len, path, ++lno,
 				GREP_PATTERN);
 	}
 	if (!from_stdin)
@@ -809,6 +806,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int use_index = 1;
 	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
 	int allow_revs;
+	char *patterns_from_file = NULL;
+	char *pathspec_from_file = NULL;
+	int pathspec_file_nul = 0;
 
 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
@@ -896,8 +896,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('W', "function-context", &opt.funcbody,
 			N_("show the surrounding function")),
 		OPT_GROUP(""),
-		OPT_CALLBACK('f', NULL, &opt, N_("file"),
-			N_("read patterns from file"), file_callback),
+		OPT_STRING('f', "patterns-from-file", &patterns_from_file, N_("file"),
+			N_("read patterns from file")),
+		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
+		OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 		{ OPTION_CALLBACK, 'e', NULL, &opt, N_("pattern"),
 			N_("match <pattern>"), PARSE_OPT_NONEG, pattern_callback },
 		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
@@ -949,6 +951,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	grep_commit_pattern_type(pattern_type_arg, &opt);
 
+	if (patterns_from_file && pathspec_from_file &&
+	    !strcmp(pathspec_from_file, "-") &&
+	    !strcmp(patterns_from_file, "-"))
+		die(_("cannot specify both patterns and pathspec via stdin"));
+
+	if (patterns_from_file)
+		read_pattern_file(&opt, patterns_from_file);
+
+
 	if (use_index && !startup_info->have_repository) {
 		int fallback = 0;
 		git_config_get_bool("grep.fallbacktonoindex", &fallback);
@@ -1062,6 +1073,18 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.recursive = 1;
 	pathspec.recurse_submodules = !!recurse_submodules;
 
+	if (pathspec_from_file) {
+		if (pathspec.nr)
+			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+
+		parse_pathspec_file(&pathspec, 0, PATHSPEC_PREFER_CWD |
+				    (opt.max_depth != -1 ? PATHSPEC_MAXDEPTH_VALID : 0),
+				    prefix, pathspec_from_file,
+				    pathspec_file_nul);
+	} else if (pathspec_file_nul) {
+		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+	}
+
 	if (list.nr || cached || show_in_pager) {
 		if (num_threads > 1)
 			warning(_("invalid option combination, ignoring --threads"));
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 7d7b396c23..3ace2dfdac 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -549,6 +549,10 @@ test_expect_success 'grep -f, non-existent file' '
 	test_must_fail git grep -f patterns
 '
 
+text_expect_success 'grep --pathspec-from-file, non-existent file' '
+	test_must_fail git grep --pathspec-from-file pathspecs
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
+test_expect_success 'grep --patterns-from-file, multiple patterns' '
+	git grep --patterns-from-file patterns >actual &&
 	test_cmp expected actual
 '
 
@@ -1125,6 +1129,45 @@ test_expect_success 'grep --no-index descends into repos, but not .git' '
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
+test_expect_success 'grep --pathspec-from-file with file' '
+	git grep --pathspec-from-file pathspecs "bar" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --pathspec-file with stdin' '
+	git grep --pathspec-from-file - "bar" <pathspecs >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep with two stdin inputs fails' '
+	test_must_fail git grep --pathspec-from-file - --patterns-from-file - <pathspecs 2>err &&
+	test_i18ngrep "cannot specify both patterns and pathspec via stdin" err
+'
+
 test_expect_success 'setup double-dash tests' '
 cat >double-dash <<EOF &&
 --
-- 
2.24.1.735.g03f4e72817-goog

