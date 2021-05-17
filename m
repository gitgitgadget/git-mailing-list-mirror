Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9015FC43461
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D546117A
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhEQIEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 04:04:38 -0400
Received: from coleridge.oriole.systems ([89.238.76.34]:49804 "EHLO
        coleridge.oriole.systems" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEQIEi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 04:04:38 -0400
From:   =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
Subject: [PATCH v2 2/2] rev-parse: Mark die() messages for translation
Date:   Mon, 17 May 2021 10:02:43 +0200
Message-Id: <20210517080243.10191-3-wolf@oriole.systems>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517080243.10191-1-wolf@oriole.systems>
References: <20210516120449.661636-1-wolf@oriole.systems>
 <20210517080243.10191-1-wolf@oriole.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These error messages are intended for the user. Let's touch them up
since we're here from the previous commit.

Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
---
 builtin/rev-parse.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 7af8dab8bc..22c4e1a4ff 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -435,11 +435,11 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	/* get the usage up to the first line with a -- on it */
 	for (;;) {
 		if (strbuf_getline(&sb, stdin) == EOF)
-			die("premature end of input");
+			die(_("premature end of input"));
 		ALLOC_GROW(usage, unb + 1, usz);
 		if (!strcmp("--", sb.buf)) {
 			if (unb < 1)
-				die("no usage string given before the `--' separator");
+				die(_("no usage string given before the `--' separator"));
 			usage[unb] = NULL;
 			break;
 		}
@@ -545,7 +545,7 @@ static void die_no_single_rev(int quiet)
 	if (quiet)
 		exit(1);
 	else
-		die("Needed a single revision");
+		die(_("Needed a single revision"));
 }
 
 static const char builtin_rev_parse_usage[] =
@@ -709,10 +709,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			if (!strcmp(arg, "--resolve-git-dir")) {
 				const char *gitdir = argv[++i];
 				if (!gitdir)
-					die("--resolve-git-dir requires an argument");
+					die(_("--resolve-git-dir requires an argument"));
 				gitdir = resolve_gitdir(gitdir);
 				if (!gitdir)
-					die("not a gitdir '%s'", argv[i]);
+					die(_("not a gitdir '%s'"), argv[i]);
 				puts(gitdir);
 				continue;
 			}
@@ -736,7 +736,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		if (!seen_end_of_options && *arg == '-') {
 			if (!strcmp(arg, "--git-path")) {
 				if (!argv[i + 1])
-					die("--git-path requires an argument");
+					die(_("--git-path requires an argument"));
 				strbuf_reset(&buf);
 				print_path(git_path("%s", argv[i + 1]), prefix,
 						format,
@@ -746,7 +746,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg,"-n")) {
 				if (++i >= argc)
-					die("-n requires an argument");
+					die(_("-n requires an argument"));
 				if ((filter & DO_FLAGS) && (filter & DO_REVS)) {
 					show(arg);
 					show(argv[i]);
@@ -760,26 +760,26 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (opt_with_value(arg, "--path-format", &arg)) {
 				if (!arg)
-					die("--path-format requires an argument");
+					die(_("--path-format requires an argument"));
 				if (!strcmp(arg, "absolute")) {
 					format = FORMAT_CANONICAL;
 				} else if (!strcmp(arg, "relative")) {
 					format = FORMAT_RELATIVE;
 				} else {
-					die("unknown argument to --path-format: %s", arg);
+					die(_("unknown argument to --path-format: %s"), arg);
 				}
 				continue;
 			}
 			if (!strcmp(arg, "--default")) {
 				def = argv[++i];
 				if (!def)
-					die("--default requires an argument");
+					die(_("--default requires an argument"));
 				continue;
 			}
 			if (!strcmp(arg, "--prefix")) {
 				prefix = argv[++i];
 				if (!prefix)
-					die("--prefix requires an argument");
+					die(_("--prefix requires an argument"));
 				startup_info->prefix = prefix;
 				output_prefix = 1;
 				continue;
@@ -848,7 +848,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					else if (!strcmp(arg, "loose"))
 						abbrev_ref_strict = 0;
 					else
-						die("unknown mode for --abbrev-ref: %s",
+						die(_("unknown mode for --abbrev-ref: %s"),
 						    arg);
 				}
 				continue;
@@ -892,7 +892,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				if (work_tree)
 					print_path(work_tree, prefix, format, DEFAULT_UNMODIFIED);
 				else
-					die("this operation must be run in a work tree");
+					die(_("this operation must be run in a work tree"));
 				continue;
 			}
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
@@ -1020,7 +1020,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				if (strcmp(val, "storage") &&
 				    strcmp(val, "input") &&
 				    strcmp(val, "output"))
-					die("unknown mode for --show-object-format: %s",
+					die(_("unknown mode for --show-object-format: %s"),
 					    arg);
 				puts(the_hash_algo->name);
 				continue;
@@ -1058,7 +1058,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		if (verify)
 			die_no_single_rev(quiet);
 		if (has_dashdash)
-			die("bad revision '%s'", arg);
+			die(_("bad revision '%s'"), arg);
 		as_is = 1;
 		if (!show_file(arg, output_prefix))
 			continue;
-- 
2.31.1

