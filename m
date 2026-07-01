Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2943C196F
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941100; cv=none; b=J5hSnW/yk7Pj227VWG6OzI6T+OpECTzZlbhBEI06s7n4DUjxbn5FQqeMNWtQ9j0XgQqWcRF2X2s9cJpiku+5nTyXJxSZlr78FieRNdaN0J8r5SBmOPy03spZDPGzEXTCcmPDc596b9qh6AFPOdHWE7+9E5z8Xoh1JK/o9KR8z/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941100; c=relaxed/simple;
	bh=20ii3wmb2YWYOgemIe8AxN1PiRdmZ5S2IQP8Eh05tZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbbXnQtfamP9caKXX62RjLcpVPOAj8aN1WtI7gKecDZzTAl1N4TNUYbRnVb5Co7uIMl+dNSb3nGZG3WfXgkingW2vbQciotItlq9xMeaPeP0wVXzwqkKxIco68Lnzc21DfnV2AdiJGpjInZRGjeI7CZ9MkmcIDKY8rbWw0/oxfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=LLugxxD+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LLugxxD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1782941093;
	bh=20ii3wmb2YWYOgemIe8AxN1PiRdmZ5S2IQP8Eh05tZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=LLugxxD+e9syh6tp3lgvVoD3tzi0GlYSMWzy6HWULdgeYiMnimHmkoFwXUpdGFIXy
	 Z+6iWz/ztdPN+Y+WoJa5aj6biBkcHt1575fyT3No++103MebEYH0J6QEaGnoCgHoey
	 BaCtLZXTf9FD8FGJUuzkGMt4BwXEAnaatJNEs/pOVG8d3e1MqI9vznZYlP5xtynB8N
	 0Xyi1eCxfqkngSZS1VS7D9W22zAB4/mCjiqzeps1eugX9WswN2To87wDIlCBRxsSxL
	 9KxV7iU/g1gMiro5jTdLZPxhO2DrOfbz5xc9LcO0K7ZFgOTioRxAxUW21IWoQuxogR
	 VG4SYdKts2MMdZVvQmI1CxYbS79Oaiugt5UpzpRFbcC6f/11NWGN5wAseQpoH+7Y+H
	 BW8DtZPfpjSx4yWPSYQkU7TFtqjXB68sxDpBIsOpIea/41b2LRkVnm39+B1G7yweAq
	 HK/JP6bf3tdO/RAYCJea0tMKIR7xJQXmygFnKeEzWKHEYDxzZka
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:cd97:af94:901e:255d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2774B201F7;
	Wed,  1 Jul 2026 21:24:53 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 4/4] parse-options: exit 0 on -h
Date: Wed,  1 Jul 2026 21:24:42 +0000
Message-ID: <20260701212442.1430084-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260701212442.1430084-1-sandals@crustytoothpaste.net>
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <20260701212442.1430084-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The standard philosophy for Unix software when a help option (such as
--help) is specified is that the software should exit 0, printing the
help output to standard output, since the standard output is for
user-requested output and the program performed the requested task
successfully.  If the user specifies an incorrect option, then the help
output should be printed to standard error (since the user has made a
mistake) and it should exit unsuccessfully.

Most of our commands currently exit 129 on receiving the -h option to
print the short help, which does not line up with the standard
philosophy above.  Let's change that to exit 0 instead.

This requires changes to a variety of tests which previously wanted the
129 exit code, so update them.  Note that because git diff does its own
option parsing, it still exits with 129, so update some of the tests to
expect either exit status.

Some commands also now pass with -h but not --help-all, so handle those
cases differently for those commands.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/blame.c                    |  1 +
 builtin/shortlog.c                 |  1 +
 builtin/update-index.c             |  1 +
 contrib/subtree/t/t7900-subtree.sh |  2 +-
 parse-options.c                    | 13 +++++++---
 t/for-each-ref-tests.sh            |  2 +-
 t/t0012-help.sh                    |  2 +-
 t/t0040-parse-options.sh           |  2 +-
 t/t0450-txt-doc-vs-help.sh         |  2 +-
 t/t0610-reftable-basics.sh         |  4 +--
 t/t1403-show-ref.sh                |  2 +-
 t/t1410-reflog.sh                  |  4 +--
 t/t1418-reflog-exists.sh           |  2 +-
 t/t1502-rev-parse-parseopt.sh      | 14 +++++------
 t/t1517-outside-repo.sh            | 39 ++++++++++++++++++------------
 t/t1800-hook.sh                    |  4 +--
 t/t1900-repo-info.sh               |  2 +-
 t/t1901-repo-structure.sh          |  2 +-
 t/t2006-checkout-index-basic.sh    |  6 ++---
 t/t2107-update-index-basic.sh      |  2 +-
 t/t3004-ls-files-basic.sh          |  6 ++---
 t/t3200-branch.sh                  |  2 +-
 t/t3903-stash.sh                   |  4 +--
 t/t4200-rerere.sh                  |  2 +-
 t/t5200-update-server-info.sh      |  2 +-
 t/t5304-prune.sh                   |  2 +-
 t/t5400-send-pack.sh               |  4 +--
 t/t5512-ls-remote.sh               |  2 +-
 t/t6300-for-each-ref.sh            |  4 +--
 t/t6500-gc.sh                      |  2 +-
 t/t7030-verify-tag.sh              |  4 +--
 t/t7508-status.sh                  |  4 +--
 t/t7510-signed-commit.sh           |  4 +--
 t/t7600-merge.sh                   |  2 +-
 t/t7800-difftool.sh                |  3 +--
 t/t7900-maintenance.sh             |  2 +-
 usage.c                            |  2 +-
 37 files changed, 86 insertions(+), 72 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 65d43c7d48..38749f79c2 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1013,6 +1013,7 @@ int cmd_blame(int argc,
 		case PARSE_OPT_UNKNOWN:
 			break;
 		case PARSE_OPT_HELP:
+			exit(0);
 		case PARSE_OPT_HELP_ERROR:
 		case PARSE_OPT_ERROR:
 		case PARSE_OPT_SUBCOMMAND:
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index cd262bd376..4c78d2e5ba 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -433,6 +433,7 @@ int cmd_shortlog(int argc,
 		case PARSE_OPT_UNKNOWN:
 			break;
 		case PARSE_OPT_HELP:
+			exit(0);
 		case PARSE_OPT_HELP_ERROR:
 		case PARSE_OPT_ERROR:
 		case PARSE_OPT_SUBCOMMAND:
diff --git a/builtin/update-index.c b/builtin/update-index.c
index ac4610ec94..6810327209 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1133,6 +1133,7 @@ int cmd_update_index(int argc,
 			break;
 		switch (parseopt_state) {
 		case PARSE_OPT_HELP:
+			exit(0);
 		case PARSE_OPT_HELP_ERROR:
 		case PARSE_OPT_ERROR:
 			exit(129);
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 4194687cfb..c10f283b38 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -99,7 +99,7 @@ test_create_subtree_add () {
 }
 
 test_expect_success 'shows short help text for -h' '
-	test_expect_code 129 git subtree -h >out 2>err &&
+	git subtree -h >out 2>err &&
 	test_must_be_empty err &&
 	grep -e "^ *or: git subtree pull" out &&
 	grep -F -e "--[no-]annotate" out
diff --git a/parse-options.c b/parse-options.c
index 67a2d372d0..742444eead 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1135,8 +1135,9 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 		case PARSE_OPT_UNKNOWN:
 			goto unknown;
 		case PARSE_OPT_HELP:
-		case PARSE_OPT_HELP_ERROR:
 			goto show_usage;
+		case PARSE_OPT_HELP_ERROR:
+			goto show_usage_stderr;
 		case PARSE_OPT_NON_OPTION:
 		case PARSE_OPT_SUBCOMMAND:
 		case PARSE_OPT_COMPLETE:
@@ -1170,6 +1171,9 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
  show_usage:
 	return usage_with_options_internal(ctx, usagestr, options,
 					   USAGE_NORMAL, USAGE_TO_STDOUT);
+ show_usage_stderr:
+	return usage_with_options_internal(ctx, usagestr, options,
+					   USAGE_NORMAL, USAGE_TO_STDERR);
 }
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
@@ -1201,6 +1205,7 @@ int parse_options(int argc, const char **argv,
 	parse_options_start_1(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
+		exit(0);
 	case PARSE_OPT_HELP_ERROR:
 	case PARSE_OPT_ERROR:
 		exit(129);
@@ -1481,7 +1486,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
 		fputs("EOF\nexit 0\n", outfile);
 
-	return PARSE_OPT_HELP;
+	return err ? PARSE_OPT_HELP_ERROR : PARSE_OPT_HELP;
 }
 
 void NORETURN usage_with_options(const char * const *usagestr,
@@ -1500,11 +1505,11 @@ void show_usage_with_options_if_asked(int ac, const char **av,
 		if (!strcmp(av[1], "-h")) {
 			usage_with_options_internal(NULL, usagestr, opts,
 						    USAGE_NORMAL, USAGE_TO_STDOUT);
-			exit(129);
+			exit(0);
 		} else if (!strcmp(av[1], "--help-all")) {
 			usage_with_options_internal(NULL, usagestr, opts,
 						    USAGE_FULL, USAGE_TO_STDOUT);
-			exit(129);
+			exit(0);
 		}
 	}
 }
diff --git a/t/for-each-ref-tests.sh b/t/for-each-ref-tests.sh
index bd2d45c971..b95e5b6ca0 100644
--- a/t/for-each-ref-tests.sh
+++ b/t/for-each-ref-tests.sh
@@ -522,7 +522,7 @@ test_expect_success 'Verify descending sort' '
 '
 
 test_expect_success 'Give help even with invalid sort atoms' '
-	test_expect_code 129 ${git_for_each_ref} --sort=bogus -h >actual 2>&1 &&
+	${git_for_each_ref} --sort=bogus -h >actual 2>&1 &&
 	grep "^usage: ${git_for_each_ref}" actual
 '
 
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index c33501bdcd..7815ff14f2 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -260,7 +260,7 @@ do
 		(
 			GIT_CEILING_DIRECTORIES=$(pwd) &&
 			export GIT_CEILING_DIRECTORIES &&
-			test_expect_code 129 git -C sub $builtin -h >output 2>err
+			git -C sub $builtin -h >output 2>err
 		) &&
 		test_must_be_empty err &&
 		test_grep usage output
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ca55ea8228..30895ad6d2 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -68,7 +68,7 @@ Alias
 EOF
 
 test_expect_success 'test help' '
-	test_must_fail test-tool parse-options -h >output 2>output.err &&
+	test-tool parse-options -h >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 822b0d55a5..d2844368e4 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -29,7 +29,7 @@ help_to_synopsis () {
 		return 0
 	fi &&
 	mkdir -p "$out_dir" &&
-	test_expect_code 129 git $builtin -h >"$out.raw" 2>&1 &&
+	test_might_fail git $builtin -h >"$out.raw" 2>&1 &&
 	sed -n \
 		-e '1,/^$/ {
 			/^$/d;
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index e19e036898..4135db95ed 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -15,9 +15,9 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 INVALID_OID=$(test_oid 001)
 
 test_expect_success 'pack-refs does not crash with -h' '
-	test_expect_code 129 git pack-refs -h >usage &&
+	git pack-refs -h >usage &&
 	test_grep "[Uu]sage: git pack-refs " usage &&
-	test_expect_code 129 nongit git pack-refs -h >usage &&
+	nongit git pack-refs -h >usage &&
 	test_grep "[Uu]sage: git pack-refs " usage
 '
 
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 36c903ca19..db4300da44 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -165,7 +165,7 @@ test_expect_success 'show-ref --branches, --tags, --head, pattern' '
 '
 
 test_expect_success 'show-ref --heads is deprecated and hidden' '
-	test_expect_code 129 git show-ref -h >short-help &&
+	git show-ref -h >short-help &&
 	test_grep ! -e --heads short-help &&
 	git show-ref --heads >actual 2>warning &&
 	test_grep ! deprecated warning &&
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ce71f9a30a..6e921bc167 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -107,12 +107,12 @@ test_expect_success setup '
 '
 
 test_expect_success 'correct usage on sub-command -h' '
-	test_expect_code 129 git reflog expire -h >err &&
+	git reflog expire -h >err &&
 	grep "git reflog expire" err
 '
 
 test_expect_success 'correct usage on "git reflog show -h"' '
-	test_expect_code 129 git reflog show -h >err &&
+	git reflog show -h >err &&
 	grep -F "git reflog [show]" err
 '
 
diff --git a/t/t1418-reflog-exists.sh b/t/t1418-reflog-exists.sh
index d51ecd5e92..10387792e3 100755
--- a/t/t1418-reflog-exists.sh
+++ b/t/t1418-reflog-exists.sh
@@ -12,7 +12,7 @@ test_expect_success 'setup' '
 
 test_expect_success 'usage' '
 	test_expect_code 129 git reflog exists &&
-	test_expect_code 129 git reflog exists -h
+	git reflog exists -h
 '
 
 test_expect_success 'usage: unknown option' '
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 455608c429..fa97591b9f 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -75,7 +75,7 @@ EOF
 '
 
 test_expect_success 'test --parseopt help output' '
-	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec &&
+	git rev-parse --parseopt -- -h > output < optionspec &&
 	test_cmp "$TEST_DIRECTORY/t1502/optionspec.help" output
 '
 
@@ -89,7 +89,7 @@ test_expect_success 'test --parseopt help output no switches' '
 |EOF
 |exit 0
 END_EXPECT
-	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec_no_switches &&
+	git rev-parse --parseopt -- -h > output < optionspec_no_switches &&
 	test_cmp expect output
 '
 
@@ -103,7 +103,7 @@ test_expect_success 'test --parseopt help output hidden switches' '
 |EOF
 |exit 0
 END_EXPECT
-	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec_only_hidden_switches &&
+	git rev-parse --parseopt -- -h > output < optionspec_only_hidden_switches &&
 	test_cmp expect output
 '
 
@@ -119,7 +119,7 @@ test_expect_success 'test --parseopt help-all output hidden switches' '
 |EOF
 |exit 0
 END_EXPECT
-	test_expect_code 129 git rev-parse --parseopt -- --help-all > output < optionspec_only_hidden_switches &&
+	git rev-parse --parseopt -- --help-all > output < optionspec_only_hidden_switches &&
 	test_cmp expect output
 '
 
@@ -258,7 +258,7 @@ test_expect_success 'test --parseopt help output: "wrapped" options normal "or:"
 	|exit 0
 	END_EXPECT
 
-	test_must_fail git rev-parse --parseopt -- -h <spec >actual &&
+	git rev-parse --parseopt -- -h <spec >actual &&
 	test_cmp expect actual
 '
 
@@ -296,12 +296,12 @@ test_expect_success 'test --parseopt help output: multi-line blurb after empty l
 	|exit 0
 	END_EXPECT
 
-	test_must_fail git rev-parse --parseopt -- -h <spec >actual &&
+	git rev-parse --parseopt -- -h <spec >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'test --parseopt help output for optionspec-neg' '
-	test_expect_code 129 git rev-parse --parseopt -- \
+	git rev-parse --parseopt -- \
 		-h >output <"$TEST_DIRECTORY/t1502/optionspec-neg" &&
 	test_cmp "$TEST_DIRECTORY/t1502/optionspec-neg.help" output
 '
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 99bda36d17..b45c52bd02 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -130,18 +130,25 @@ do
 	archimport | citool | credential-netrc | credential-libsecret | \
 	credential-osxkeychain | cvsexportcommit | cvsimport | cvsserver | \
 	daemon | \
-	difftool--helper | filter-branch | format-rev | fsck-objects | \
-	get-tar-commit-id | \
+	difftool--helper | format-rev | fsck-objects |  get-tar-commit-id | \
 	gui | gui--askpass | \
-	http-backend | http-fetch | http-push | init-db | instaweb | \
-	merge-octopus | merge-one-file | merge-resolve | mergetool | \
-	mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-ftps | \
-	remote-http | remote-https | replay | request-pull | send-email | \
-	sh-i18n--envsubst | shell | show | stage | submodule | svn | \
-	upload-archive--writer | upload-pack | web--browse | whatchanged)
-		expect_outcome=expect_failure ;;
+	http-backend | http-fetch | http-push | init-db | \
+	mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
+	remote-http | remote-https | replay | send-email | \
+	sh-i18n--envsubst | shell | show | stage | \
+	upload-archive--writer | upload-pack | whatchanged)
+		h_expect_outcome=expect_failure
+		all_expect_outcome=expect_failure
+		;;
+	filter-branch | merge-octopus | merge-one-file | merge-resolve | \
+	mergetool | submodule | svn | web--browse)
+		h_expect_outcome=expect_success
+		all_expect_outcome=expect_failure
+		;;
 	*)
-		expect_outcome=expect_success ;;
+		h_expect_outcome=expect_success
+		all_expect_outcome=expect_success
+		;;
 	esac
 	case "$cmd" in
 	instaweb)
@@ -151,20 +158,20 @@ do
 	*)
 		prereq= ;;
 	esac
-	test_$expect_outcome $prereq "'git $cmd -h' outside a repository" '
-		test_expect_code 129 nongit git $cmd -h >usage &&
+	test_$h_expect_outcome $prereq "'git $cmd -h' outside a repository" '
+		nongit git $cmd -h >usage &&
 		test_grep "[Uu]sage: git $cmd " usage
 	'
-	test_$expect_outcome $prereq "'git $cmd --help-all' outside a repository" '
-		test_expect_code 129 nongit git $cmd --help-all >usage &&
+	test_$all_expect_outcome $prereq "'git $cmd --help-all' outside a repository" '
+		nongit git $cmd --help-all >usage &&
 		test_grep "[Uu]sage: git $cmd " usage
 	'
 done
 
 test_expect_success 'fmt-merge-msg does not crash with -h' '
-	test_expect_code 129 git fmt-merge-msg -h >usage &&
+	git fmt-merge-msg -h >usage &&
 	test_grep "[Uu]sage: git fmt-merge-msg " usage &&
-	test_expect_code 129 nongit git fmt-merge-msg -h >usage &&
+	nongit git fmt-merge-msg -h >usage &&
 	test_grep "[Uu]sage: git fmt-merge-msg " usage
 '
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 0132e772e4..2ea9fa13c5 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -75,10 +75,10 @@ sentinel_detector () {
 test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook &&
 	test_expect_code 129 git hook run &&
-	test_expect_code 129 git hook run -h &&
+	git hook run -h &&
 	test_expect_code 129 git hook run --unknown 2>err &&
 	test_expect_code 129 git hook list &&
-	test_expect_code 129 git hook list -h &&
+	git hook list -h &&
 	grep "unknown option" err
 '
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 39bb77dda0..826686955d 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -150,7 +150,7 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
 '
 
 test_expect_success 'git repo info -h shows only repo info usage' '
-	test_must_fail git repo info -h >actual &&
+	git repo info -h >actual &&
 	test_grep "git repo info" actual &&
 	test_grep ! "git repo structure" actual
 '
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 10050abd70..02cc2b594a 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -225,7 +225,7 @@ test_expect_success 'progress meter option' '
 '
 
 test_expect_success 'git repo structure -h shows only repo structure usage' '
-	test_must_fail git repo structure -h >actual &&
+	git repo structure -h >actual &&
 	test_grep "git repo structure" actual &&
 	test_grep ! "git repo info" actual
 '
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-basic.sh
index fedd2cc097..6538a24c95 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -16,15 +16,15 @@ test_expect_success 'checkout-index -h in broken repository' '
 		cd broken &&
 		git init &&
 		>.git/index &&
-		test_expect_code 129 git checkout-index -h >usage 2>&1
+		git checkout-index -h >usage 2>&1
 	) &&
 	test_grep "[Uu]sage" broken/usage
 '
 
 test_expect_success 'checkout-index does not crash with -h' '
-	test_expect_code 129 git checkout-index -h >usage &&
+	git checkout-index -h >usage &&
 	test_grep "[Uu]sage: git checkout-index " usage &&
-	test_expect_code 129 nongit git checkout-index -h >usage &&
+	nongit git checkout-index -h >usage &&
 	test_grep "[Uu]sage: git checkout-index " usage
 '
 
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index 3bffe5da8a..004878322e 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -23,7 +23,7 @@ test_expect_success 'update-index -h with corrupt index' '
 		cd broken &&
 		git init &&
 		>.git/index &&
-		test_expect_code 129 git update-index -h >usage 2>&1
+		git update-index -h >usage 2>&1
 	) &&
 	test_grep "[Uu]sage: git update-index" broken/usage
 '
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 4034a5a59f..c57afcb841 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -29,15 +29,15 @@ test_expect_success 'ls-files -h in corrupt repository' '
 		cd broken &&
 		git init &&
 		>.git/index &&
-		test_expect_code 129 git ls-files -h >usage 2>&1
+		git ls-files -h >usage 2>&1
 	) &&
 	test_grep "[Uu]sage: git ls-files " broken/usage
 '
 
 test_expect_success 'ls-files does not crash with -h' '
-	test_expect_code 129 git ls-files -h >usage &&
+	git ls-files -h >usage &&
 	test_grep "[Uu]sage: git ls-files " usage &&
-	test_expect_code 129 nongit git ls-files -h >usage &&
+	nongit git ls-files -h >usage &&
 	test_grep "[Uu]sage: git ls-files " usage
 '
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..dec0e77e3c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -33,7 +33,7 @@ test_expect_success REFFILES 'branch -h in broken repository' '
 		cd broken &&
 		git init -b main &&
 		>.git/refs/heads/main &&
-		test_expect_code 129 git branch -h >usage 2>&1
+		git branch -h >usage 2>&1
 	) &&
 	test_grep "[Uu]sage" broken/usage
 '
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index ecc35aae82..bc07e2a6ec 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -27,13 +27,13 @@ test_expect_success 'usage on cmd and subcommand invalid option' '
 '
 
 test_expect_success 'usage on main command -h emits a summary of subcommands' '
-	test_expect_code 129 git stash -h >usage &&
+	git stash -h >usage &&
 	grep -F "usage: git stash list" usage &&
 	grep -F "or: git stash show" usage
 '
 
 test_expect_success 'usage for subcommands should emit subcommand usage' '
-	test_expect_code 129 git stash push -h >usage &&
+	git stash push -h >usage &&
 	grep -F "usage: git stash [push" usage
 '
 
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 1717f407c8..e1b474cc0f 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -438,7 +438,7 @@ test_expect_success 'rerere --no-no-rerere-autoupdate' '
 '
 
 test_expect_success 'rerere -h' '
-	test_must_fail git rerere -h >help &&
+	git rerere -h >help &&
 	test_grep [Uu]sage help
 '
 
diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
index a551e955b5..a0630cc1fc 100755
--- a/t/t5200-update-server-info.sh
+++ b/t/t5200-update-server-info.sh
@@ -47,7 +47,7 @@ test_expect_success 'midx does not create duplicate pack entries' '
 '
 
 test_expect_success 'update-server-info does not crash with -h' '
-	test_expect_code 129 git update-server-info -h >usage &&
+	git update-server-info -h >usage &&
 	test_grep "[Uu]sage: git update-server-info " usage
 '
 
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 2be7cd30de..e26e833d89 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -365,7 +365,7 @@ test_expect_success 'gc.recentObjectsHook' '
 '
 
 test_expect_success 'prune does not crash with -h' '
-	test_expect_code 129 git prune -h >usage &&
+	git prune -h >usage &&
 	test_grep "[Uu]sage: git prune " usage
 '
 
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index b32a0a6aa7..6aa5838e2b 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -56,9 +56,9 @@ test_expect_success setup '
 	git log'
 
 test_expect_success 'send-pack does not crash with -h' '
-	test_expect_code 129 git send-pack -h >usage &&
+	git send-pack -h >usage &&
 	test_grep "[Uu]sage: git send-pack " usage &&
-	test_expect_code 129 nongit git send-pack -h >usage &&
+	nongit git send-pack -h >usage &&
 	test_grep "[Uu]sage: git send-pack " usage
 '
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 5930f55186..8345bc0b14 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -86,7 +86,7 @@ test_expect_success 'ls-remote -h is deprecated w/o warning' '
 '
 
 test_expect_success 'ls-remote --heads is deprecated and hidden w/o warning' '
-	test_expect_code 129 git ls-remote -h >short-help &&
+	git ls-remote -h >short-help &&
 	test_grep ! -e --head short-help &&
 	git ls-remote --heads self >actual 2>warning &&
 	test_cmp expected.branches actual &&
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 1d9809114d..6d27b42ff1 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -8,9 +8,9 @@ test_description='for-each-ref test'
 . ./test-lib.sh
 
 test_expect_success "for-each-ref does not crash with -h" '
-	test_expect_code 129 git for-each-ref -h >usage &&
+	git for-each-ref -h >usage &&
 	test_grep "[Uu]sage: git for-each-ref " usage &&
-	test_expect_code 129 nongit git for-each-ref -h >usage &&
+	nongit git for-each-ref -h >usage &&
 	test_grep "[Uu]sage: git for-each-ref " usage
 '
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index ea9aaad470..b40d13d7ff 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -35,7 +35,7 @@ test_expect_success 'gc -h with invalid configuration' '
 		cd broken &&
 		git init &&
 		echo "[gc] pruneexpire = CORRUPT" >>.git/config &&
-		test_expect_code 129 git gc -h >usage 2>&1
+		git gc -h >usage 2>&1
 	) &&
 	test_grep "[Uu]sage" broken/usage
 '
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 2c147072c1..3bc5d1e9a2 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -8,9 +8,9 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success GPG 'verify-tag does not crash with -h' '
-	test_expect_code 129 git verify-tag -h >usage &&
+	git verify-tag -h >usage &&
 	test_grep "[Uu]sage: git verify-tag " usage &&
-	test_expect_code 129 nongit git verify-tag -h >usage &&
+	nongit git verify-tag -h >usage &&
 	test_grep "[Uu]sage: git verify-tag " usage
 '
 
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c2057bc94c..de7d7beec3 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -16,7 +16,7 @@ test_expect_success 'status -h in broken repository' '
 		cd broken &&
 		git init &&
 		echo "[status] showuntrackedfiles = CORRUPT" >>.git/config &&
-		test_expect_code 129 git status -h >usage 2>&1
+		git status -h >usage 2>&1
 	) &&
 	test_grep "[Uu]sage" broken/usage
 '
@@ -28,7 +28,7 @@ test_expect_success 'commit -h in broken repository' '
 		cd broken &&
 		git init &&
 		echo "[status] showuntrackedfiles = CORRUPT" >>.git/config &&
-		test_expect_code 129 git commit -h >usage 2>&1
+		git commit -h >usage 2>&1
 	) &&
 	test_grep "[Uu]sage" broken/usage
 '
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index aa9108da54..e641f9e334 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -9,9 +9,9 @@ GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success GPG 'verify-commit does not crash with -h' '
-	test_expect_code 129 git verify-commit -h >usage &&
+	git verify-commit -h >usage &&
 	test_grep "[Uu]sage: git verify-commit " usage &&
-	test_expect_code 129 nongit git verify-commit -h >usage &&
+	nongit git verify-commit -h >usage &&
 	test_grep "[Uu]sage: git verify-commit " usage
 '
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index f877d9a433..fd3d1d67f9 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -173,7 +173,7 @@ test_expect_success 'merge -h with invalid index' '
 		cd broken &&
 		git init &&
 		>.git/index &&
-		test_expect_code 129 git merge -h >usage
+		git merge -h >usage
 	) &&
 	test_grep "[Uu]sage: git merge" broken/usage
 '
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 8a91ff3603..961de3efab 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -27,12 +27,11 @@ prompt_given ()
 }
 
 test_expect_success 'basic usage requires no repo' '
-	test_expect_code 129 git difftool -h >output &&
+	git difftool -h >output &&
 	test_grep ^usage: output &&
 	# create a ceiling directory to prevent Git from finding a repo
 	mkdir -p not/repo &&
 	test_when_finished rm -r not &&
-	test_expect_code 129 \
 	env GIT_CEILING_DIRECTORIES="$(pwd)/not" \
 	git -C not/repo difftool -h >output &&
 	test_grep ^usage: output
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d7f82e1bec..9886f641fc 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -35,7 +35,7 @@ test_systemd_analyze_verify () {
 }
 
 test_expect_success 'help text' '
-	test_expect_code 129 git maintenance -h >actual &&
+	git maintenance -h >actual &&
 	test_grep "usage: git maintenance <subcommand>" actual &&
 	test_expect_code 129 git maintenance barf 2>err &&
 	test_grep "unknown subcommand: \`barf'\''" err &&
diff --git a/usage.c b/usage.c
index 527edb1e79..3f0118ab2a 100644
--- a/usage.c
+++ b/usage.c
@@ -188,7 +188,7 @@ static void show_usage_if_asked_helper(const char *err, ...)
 	va_start(params, err);
 	vfreportf(stdout, _("usage: "), err, params);
 	va_end(params);
-	exit(129);
+	exit(0);
 }
 
 void show_usage_if_asked(int ac, const char **av, const char *err)
