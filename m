Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1795356764
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781323598; cv=none; b=VXGeha1zBddPfXBbGs8unrw4ob+kelnNr2C5e3Lvv/hIYPvcX1id3QD38JwybENTVdKpqlOZR1SHbVe1DTyM5wmhZCsTfcQ8uXBYUQ7Yqn67j65ybzHKTZ2LYrXacC49IQgLgOJM8vkNmJRtfb+ribkAznBlZAXzi9x8cj1iSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781323598; c=relaxed/simple;
	bh=NQn39lOufj5lv3GiiVxYMilyGkc1IOAafzZChQCU9VM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=odHhcXWQxB9kPNe2OuLo5HeD4KME0254etFJQV1VV6fEmyYuaY5uVVezqjiidFvk26rRc6zF0ARe3RZOIX175nsAM6URLC6T40fPdoE9+68sun4HyitwvhB4pMY1rkeEJD2mq1L8aitQkw+qK0H4vX40Q+fNAJLFL48qyLdY7oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHIG4a3c; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHIG4a3c"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-13721dfd471so1903043c88.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781323595; x=1781928395; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnJhqE0m+g9p+yJG1LPucKI6dCdbh+8pIGhmZQrXRWM=;
        b=MHIG4a3cKzIMsfRe7hzQ4Las800BS4mNBYmLc/Eb9lluVNp+i4yQNJGeeWK2EYZT2A
         3YM6tV8h/7G8EPI+bpZT8iO+XyFeLi2C5TQiR3bE5aV5tVlYWJWwJeybQ+c90/SrZ8nv
         LpMAqNrwZCpZvJFDY7Z9OTOhlK/xr1//INIcrQDBk40zmgryIRvS81xc83CfNOcsDhom
         QI4y+k6u7Ex90g83KitWiGkQL9ctNvAD0sxupyRHB7btkfjA7rJzJP+d8GjkNTVMrcMA
         siDTTaakhC2q7gLloF++BZgpdsR75s4y4PJnhR19gS4UEWhH8tt+ujMK8L+CRhJ5E4Po
         0p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781323595; x=1781928395;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AnJhqE0m+g9p+yJG1LPucKI6dCdbh+8pIGhmZQrXRWM=;
        b=Mto3cuWXHVV0agMm79/JL05oS24YFNjh/5q6WudFXUiL3ggPcriNelXejau2A6EXaH
         Wf9/1EJwczamUt2MpX1HW4nVS+/NETFVPvlLZwgrK+BCiFP89wDAKTKHPvImKK9iTKsO
         AyQRKnn3x2PF0GvKTuk2yjCtbzAsS0Zd60jaN01kSWq4fqhkC3pUY1QI4Iisbr4IwmLy
         SaopXWNTGT65ximKvUepmcEkpvRbvsTjaFYukA9lPQu3+hy+wHElTheev662OQFyIxyj
         /1OTrhvl5NPB+zJINwHZatMHt7QPp3Ozjp/vDtdVpzmXX/7ZaJW5dnWZhWMLkcQi3Nqt
         ocMA==
X-Gm-Message-State: AOJu0Yy9qhbG2otu6slYqhY37lRdTBG4QkUFvnH9IAB7nBtJ0XeAzwFw
	qnqBgf8WRjUcCPdhvrj99Igh8wthJ3JK7jtDZMsVmQVhPkvb8PfTwqbLPU+jng==
X-Gm-Gg: Acq92OGXcD+wjeiKXS/IN1wLD5LqYg+A2jMRJzvBoiEN/bnfcXjc2Bkkg6hJZ0Dpdjd
	JEnkFchxjciygcxaL6ogbLl8d2QOajseo9PUrtP6VL3/fRUZ9pPQsfohEswPZ+CRZfakSoLD1jq
	vecEbbZcuz6s4f2ErisfY7Ok1FIr67w4pDT+SccE4hJDXUs0E0watxhzH4C1uSD8LUC5SYm+QJ7
	o+MdkvxT0E/XY2AP5yn2F2x7oRsD9CZCpEAhE0byPZEORZYnAJM5G9mzUNG+v9tpFrjVGNYaFZo
	DvqYIQorQ3R5xfjkS8NRQhm5qE6kG4KfBx/wD7E8sM6tMZ7DkZUApq32XOG3dg/+Xv6lscqpEjq
	Nw0tyPegpHs0Lvj6tbA+HhV2fRz2ZTrQ0aShwDX6Vtz1nSXEDtw8viTfVMgwa3VaYLqq/vnuc5P
	p2A9VHrUmTub0aq8b9wOJXkxrCq/q9xef3O3I=
X-Received: by 2002:a05:7022:1286:b0:12d:ca31:f1b4 with SMTP id a92af1059eb24-1386f395ce4mr1222150c88.24.1781323594588;
        Fri, 12 Jun 2026 21:06:34 -0700 (PDT)
Received: from [127.0.0.1] ([40.65.56.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b910c51sm4222762c88.4.2026.06.12.21.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 21:06:33 -0700 (PDT)
Message-Id: <e5ecb37401502ddcdee4249a9e6ce783a4a7a487.1781323575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
	<pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jun 2026 04:06:15 +0000
Subject: [PATCH v2 6/6] t: add greplint to detect bare grep assertions
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Without a lint guard, bare grep assertions will creep back into
tests over time, defeating the previous commit's conversion.

Add greplint.pl to catch bare 'grep' used as a test assertion
(where 'test_grep' should be used) and '! test_grep' (where
'test_grep !' should be used).

greplint.pl reuses the shared shell parser from lib-shell-parser.pl
to tokenize test bodies.  The Lexer collapses heredocs, command
substitutions, and quoted strings into single tokens, so 'grep'
appearing inside these contexts is not flagged.  A flat walk over
the token stream tracks command position and pipeline state to
distinguish assertion greps from filter greps.

For double-quoted test bodies, a source-line walk counts
backslash-continuation lines that the Lexer consumes without
emitting into the body text, adjusting the reported line number
accordingly.

Add test fixtures in greplint/ (modeled on chainlint/) covering
detection of bare grep assertions, correct skipping of filters,
pipelines, redirects, command substitutions, and lint-ok annotations.

Wire into the Makefile as:
  - test-greplint: runs greplint.pl on $(T) $(THELPERS) $(TPERF)
  - check-greplint: runs greplint.pl on fixtures, diffs against expected
  - clean-greplint: removes temp dir

Add eol=lf entries in t/.gitattributes for greplint fixtures,
matching chainlint, so that check-greplint passes on Windows
where core.autocrlf would otherwise cause CRLF mismatches
between expected and actual output.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/.gitattributes                              |   2 +
 t/Makefile                                    |  29 ++-
 t/greplint-cat.pl                             |  27 ++
 t/greplint.pl                                 | 241 ++++++++++++++++++
 t/greplint/bare-grep-after-and.expect         |   1 +
 t/greplint/bare-grep-after-and.test           |   4 +
 t/greplint/bare-grep-after-semicolon.expect   |   1 +
 t/greplint/bare-grep-after-semicolon.test     |   4 +
 t/greplint/bare-grep-compound-body.expect     |   3 +
 t/greplint/bare-grep-compound-body.test       |  17 ++
 t/greplint/bare-grep-count-mode.expect        |   1 +
 t/greplint/bare-grep-count-mode.test          |   3 +
 t/greplint/bare-grep-explicit-pattern.expect  |   1 +
 t/greplint/bare-grep-explicit-pattern.test    |   3 +
 t/greplint/bare-grep-flags.expect             |   1 +
 t/greplint/bare-grep-flags.test               |   3 +
 t/greplint/bare-grep-lint-ok.expect           |   0
 t/greplint/bare-grep-lint-ok.test             |   4 +
 t/greplint/bare-grep-negated.expect           |   1 +
 t/greplint/bare-grep-negated.test             |   3 +
 t/greplint/bare-grep-pattern-file.expect      |   1 +
 t/greplint/bare-grep-pattern-file.test        |   3 +
 t/greplint/bare-grep-simple.expect            |   1 +
 t/greplint/bare-grep-simple.test              |   3 +
 t/greplint/bare-grep-subshell.expect          |   1 +
 t/greplint/bare-grep-subshell.test            |   5 +
 .../dqstring-continuation-offset.expect       |   1 +
 t/greplint/dqstring-continuation-offset.test  |  11 +
 t/greplint/filter-command-substitution.expect |   0
 t/greplint/filter-command-substitution.test   |   3 +
 t/greplint/filter-pipe-input.expect           |   0
 t/greplint/filter-pipe-input.test             |   3 +
 t/greplint/filter-pipe-output.expect          |   0
 t/greplint/filter-pipe-output.test            |   3 +
 t/greplint/filter-redirect-output.expect      |   0
 t/greplint/filter-redirect-output.test        |   3 +
 t/greplint/filter-stdin-redirect.expect       |   0
 t/greplint/filter-stdin-redirect.test         |   3 +
 t/greplint/grep-as-argument.expect            |   0
 t/greplint/grep-as-argument.test              |   3 +
 t/greplint/grep-as-value.expect               |   0
 t/greplint/grep-as-value.test                 |   6 +
 t/greplint/wrong-negation.expect              |   1 +
 t/greplint/wrong-negation.test                |   3 +
 44 files changed, 398 insertions(+), 5 deletions(-)
 create mode 100644 t/greplint-cat.pl
 create mode 100644 t/greplint.pl
 create mode 100644 t/greplint/bare-grep-after-and.expect
 create mode 100644 t/greplint/bare-grep-after-and.test
 create mode 100644 t/greplint/bare-grep-after-semicolon.expect
 create mode 100644 t/greplint/bare-grep-after-semicolon.test
 create mode 100644 t/greplint/bare-grep-compound-body.expect
 create mode 100644 t/greplint/bare-grep-compound-body.test
 create mode 100644 t/greplint/bare-grep-count-mode.expect
 create mode 100644 t/greplint/bare-grep-count-mode.test
 create mode 100644 t/greplint/bare-grep-explicit-pattern.expect
 create mode 100644 t/greplint/bare-grep-explicit-pattern.test
 create mode 100644 t/greplint/bare-grep-flags.expect
 create mode 100644 t/greplint/bare-grep-flags.test
 create mode 100644 t/greplint/bare-grep-lint-ok.expect
 create mode 100644 t/greplint/bare-grep-lint-ok.test
 create mode 100644 t/greplint/bare-grep-negated.expect
 create mode 100644 t/greplint/bare-grep-negated.test
 create mode 100644 t/greplint/bare-grep-pattern-file.expect
 create mode 100644 t/greplint/bare-grep-pattern-file.test
 create mode 100644 t/greplint/bare-grep-simple.expect
 create mode 100644 t/greplint/bare-grep-simple.test
 create mode 100644 t/greplint/bare-grep-subshell.expect
 create mode 100644 t/greplint/bare-grep-subshell.test
 create mode 100644 t/greplint/dqstring-continuation-offset.expect
 create mode 100644 t/greplint/dqstring-continuation-offset.test
 create mode 100644 t/greplint/filter-command-substitution.expect
 create mode 100644 t/greplint/filter-command-substitution.test
 create mode 100644 t/greplint/filter-pipe-input.expect
 create mode 100644 t/greplint/filter-pipe-input.test
 create mode 100644 t/greplint/filter-pipe-output.expect
 create mode 100644 t/greplint/filter-pipe-output.test
 create mode 100644 t/greplint/filter-redirect-output.expect
 create mode 100644 t/greplint/filter-redirect-output.test
 create mode 100644 t/greplint/filter-stdin-redirect.expect
 create mode 100644 t/greplint/filter-stdin-redirect.test
 create mode 100644 t/greplint/grep-as-argument.expect
 create mode 100644 t/greplint/grep-as-argument.test
 create mode 100644 t/greplint/grep-as-value.expect
 create mode 100644 t/greplint/grep-as-value.test
 create mode 100644 t/greplint/wrong-negation.expect
 create mode 100644 t/greplint/wrong-negation.test

diff --git a/t/.gitattributes b/t/.gitattributes
index 7664c6e027..e867f38c71 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1,5 +1,7 @@
 t[0-9][0-9][0-9][0-9]/* -whitespace
 /chainlint/*.expect eol=lf -whitespace
+/greplint/*.expect eol=lf -whitespace
+/greplint/*.test eol=lf -whitespace
 /t0110/url-* binary
 /t3206/* eol=lf
 /t3900/*.txt eol=lf
diff --git a/t/Makefile b/t/Makefile
index ab8a5b54aa..e3249879c4 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -27,9 +27,11 @@ TEST_LINT ?= test-lint
 ifdef TEST_OUTPUT_DIRECTORY
 TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
 CHAINLINTTMP = $(TEST_OUTPUT_DIRECTORY)/chainlinttmp
+GREPLINTTMP = $(TEST_OUTPUT_DIRECTORY)/greplinttmp
 else
 TEST_RESULTS_DIRECTORY = test-results
 CHAINLINTTMP = chainlinttmp
+GREPLINTTMP = greplinttmp
 endif
 
 # Shell quote;
@@ -38,6 +40,7 @@ TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
 CHAINLINTTMP_SQ = $(subst ','\'',$(CHAINLINTTMP))
+GREPLINTTMP_SQ = $(subst ','\'',$(GREPLINTTMP))
 
 T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
 THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
@@ -45,6 +48,7 @@ TLIBS = $(sort $(wildcard lib-*.sh)) annotate-tests.sh
 TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
+GREPLINTTESTS = $(sort $(patsubst greplint/%.test,%,$(wildcard greplint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
 UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
 UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
@@ -63,8 +67,8 @@ test: pre-clean check-meson $(TEST_LINT)
 	$(CHAINLINTSUPPRESS) $(MAKE) aggregate-results-and-cleanup
 
 ifneq ($(PERL_PATH),)
-test: check-chainlint
-prove: check-chainlint
+test: check-chainlint check-greplint
+prove: check-chainlint check-greplint
 endif
 
 failed:
@@ -102,7 +106,7 @@ unit-tests-test-tool:
 pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
-clean-except-prove-cache: clean-chainlint
+clean-except-prove-cache: clean-chainlint clean-greplint
 	$(RM) -r 'trash directory'.*
 	$(RM) -r valgrind/bin
 
@@ -120,6 +124,17 @@ check-chainlint:
 	{ $(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests >'$(CHAINLINTTMP_SQ)'/actual || true; } && \
 	diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
 
+clean-greplint:
+	$(RM) -r '$(GREPLINTTMP_SQ)'
+
+check-greplint:
+	@mkdir -p '$(GREPLINTTMP_SQ)' && \
+	'$(PERL_PATH_SQ)' greplint-cat.pl '$(GREPLINTTMP_SQ)' $(GREPLINTTESTS) && \
+	{ '$(PERL_PATH_SQ)' greplint.pl \
+		$(patsubst %,greplint/%.test,$(GREPLINTTESTS)) \
+		>'$(GREPLINTTMP_SQ)'/actual 2>&1 || true; } && \
+	diff -u '$(GREPLINTTMP_SQ)'/expect '$(GREPLINTTMP_SQ)'/actual
+
 check-meson:
 	@# awk acts up when trying to match single quotes, so we use \047 instead.
 	@mkdir -p mesontmp && \
@@ -139,7 +154,7 @@ check-meson:
 test-lint: test-lint-duplicates test-lint-executable \
 	test-lint-filenames
 ifneq ($(PERL_PATH),)
-test-lint: test-lint-shell-syntax
+test-lint: test-lint-shell-syntax test-greplint
 else
 GIT_TEST_CHAIN_LINT = 0
 endif
@@ -160,6 +175,9 @@ test-lint-executable:
 test-lint-shell-syntax:
 	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS) $(TPERF)
 
+test-greplint:
+	@'$(PERL_PATH_SQ)' greplint.pl $(T) $(THELPERS) $(TPERF)
+
 test-lint-filenames:
 	@# We do *not* pass a glob to ls-files but use grep instead, to catch
 	@# non-ASCII characters (which are quoted within double-quotes)
@@ -185,7 +203,8 @@ perf:
 	$(MAKE) -C perf/ all
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
-	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
+	check-chainlint clean-chainlint test-chainlint \
+	check-greplint clean-greplint test-greplint $(UNIT_TESTS)
 
 .PHONY: libgit-sys-test libgit-rs-test
 libgit-sys-test:
diff --git a/t/greplint-cat.pl b/t/greplint-cat.pl
new file mode 100644
index 0000000000..fa9c3b8aab
--- /dev/null
+++ b/t/greplint-cat.pl
@@ -0,0 +1,27 @@
+#!/usr/bin/env perl
+
+use strict;
+use warnings;
+
+# Assemble expected output for check-greplint target.
+# Usage: greplint-cat.pl <outdir> <test-name> ...
+#
+# For each <test-name>, reads greplint/<test-name>.expect and
+# prepends "greplint/<test-name>.test:" to every non-empty line,
+# matching the output format of greplint.pl.  Writes combined
+# expected output to <outdir>/expect.
+
+my $outdir = shift;
+open(my $expect, '>', "$outdir/expect")
+	or die "unable to open $outdir/expect: $!";
+
+for my $name (@ARGV) {
+	open(my $fh, '<', "greplint/$name.expect")
+		or die "unable to open greplint/$name.expect: $!";
+	while (<$fh>) {
+		print $expect "greplint/$name.test:$_";
+	}
+	close $fh;
+}
+
+close $expect;
diff --git a/t/greplint.pl b/t/greplint.pl
new file mode 100644
index 0000000000..553bdbdf9a
--- /dev/null
+++ b/t/greplint.pl
@@ -0,0 +1,241 @@
+#!/usr/bin/env perl
+
+# Detect bare 'grep' used as a test assertion where 'test_grep'
+# should be used, and '! test_grep' where 'test_grep !' should
+# be used.
+#
+# The shared shell parser tokenizes test bodies so that 'grep'
+# inside heredocs, command substitutions like $(grep ...), and
+# quoted strings is collapsed into a single token and never seen
+# by our check.  A line-oriented approach would need to track
+# heredoc delimiters, nested $() depth, and cross-line pipe
+# state to avoid false positives on patterns like:
+#
+#   write_script foo.sh <<-\EOF
+#   grep pattern file    # data, not an assertion
+#   EOF
+#
+# The Lexer already handles these.
+
+use warnings;
+use strict;
+use File::Basename;
+do(dirname($0) . "/lib-shell-parser.pl")
+	or die "$0: failed to load lib-shell-parser.pl: $@$!\n";
+
+my $exit_code = 0;
+
+# GrepLintParser inherits ScriptParser's ability to find
+# test_expect_success/failure blocks and call check_test()
+# on each body.  We override check_test() to walk the token
+# stream looking for bare grep assertions.
+package GrepLintParser;
+
+our @ISA = ('ScriptParser');
+
+# After these tokens, the next token is a command word.
+# For example, in 'echo foo && grep bar file', the 'grep'
+# after '&&' is at command position and should be flagged.
+my %cmd_start = map { $_ => 1 } qw(&& || ; ;; do then else elif), "\n", '{', '(';
+
+# Tokens indicating grep's output is piped or redirected.
+my %filter_op = map { $_ => 1 } qw(| > >> <);
+
+# A token is at "command word" position if the shell would
+# interpret it as a program name rather than an argument.
+# Only 'grep' at command position is an assertion we should
+# flag; 'grep' as an argument ('test_must_fail grep') or
+# value ('for cmd in grep sed') is not.
+sub is_command_word {
+	my ($tokens, $pos) = @_;
+	return 1 if $pos == 0;
+	for (my $j = $pos - 1; $j >= 0; $j--) {
+		my $t = $tokens->[$j]->[0];
+		# After a separator or pipe, a new command starts.
+		return 1 if $cmd_start{$t} || $t eq '|';
+		# After '}' or ')', what follows is a separator or
+		# redirect on the compound command, not a new command.
+		return 0 if $t eq '}' || $t eq ')';
+		# '!' is a prefix that does not consume command
+		# position; keep scanning to find what precedes it.
+		next if $t eq '!';
+		# Any other word means we are past the command word.
+		return 0;
+	}
+	return 1;
+}
+
+# Some bare greps are intentional (e.g. file may not exist,
+# data filter).  A '# lint-ok' annotation on the source line
+# suppresses the warning.
+sub lint_ok {
+	my ($raw_lines, $ln) = @_;
+	if ($ln < 1 || $ln > @$raw_lines) {
+		warn "lint_ok: line number $ln out of range (1.." .
+		    scalar(@$raw_lines) . ")\n";
+		return 0;
+	}
+	return $raw_lines->[$ln - 1] =~ /lint-ok/;
+}
+
+# Grep is a filter (not an assertion) if it receives piped
+# input or sends its output to a pipe or redirect.  Check
+# both directions from grep's position in the token stream.
+sub is_filter {
+	my ($tokens, $pos) = @_;
+	# Backward: is grep receiving piped input?
+	# Newlines don't break pipes ('cmd |\n grep' is one
+	# pipeline), so skip past them.
+	for (my $j = $pos - 1; $j >= 0; $j--) {
+		my $t = $tokens->[$j]->[0];
+		return 1 if $t eq '|';
+		next if $t eq "\n";
+		last if $cmd_start{$t} || $t eq '}' || $t eq ')';
+	}
+	# Forward: is grep piping or redirecting output?
+	# Unlike the backward scan, we do not skip newlines here:
+	# a bare newline is a command boundary, and redirects or
+	# pipes must appear on the same line as grep (or after a
+	# line continuation, which the Lexer consumes).
+	for (my $j = $pos + 1; $j < @$tokens; $j++) {
+		my $t = $tokens->[$j]->[0];
+		return 0 if $cmd_start{$t};
+		return 1 if $filter_op{$t};
+	}
+	return 0;
+}
+
+# Map a body-relative line number to a file line number.
+# For double-quoted bodies, backslash-continuation lines
+# (\<newline>) are consumed by the Lexer without appearing
+# in the body text, so the inner parser sees fewer lines
+# than the source file has.  We walk the source lines to
+# count continuations and adjust accordingly.
+sub body_to_file_line {
+	my ($body_lineno, $body_token, $raw_lines, $body_start) = @_;
+	my $body_text = $body_token->[0];
+	my $body_end_line = $body_token->[4];
+	unless ($body_start && $body_start >= 1) {
+		warn "body_start is not a positive integer\n";
+		return $body_lineno;
+	}
+	my $file_lineno = $body_lineno + $body_start - 1;
+	# Only double-quoted bodies have line splices.
+	return $file_lineno unless $body_text =~ /^"/;
+	my $adj = 0;
+	my $lines_seen = 0;
+	unless ($body_end_line && $body_end_line >= $body_start) {
+		warn "body_end_line is not set for double-quoted body\n";
+		return $file_lineno;
+	}
+	my $end = $body_end_line;
+	if ($end > @$raw_lines) {
+		warn "body_end_line ($end) exceeds file length (" .
+		    scalar(@$raw_lines) . ")\n";
+		return $file_lineno;
+	}
+	my $src_ln = $body_start;
+	while ($src_ln <= $end && $lines_seen < $body_lineno) {
+		my $line = $raw_lines->[$src_ln - 1];
+		# Odd trailing backslashes = continuation (\<nl>).
+		# Even = escaped backslashes (\\), not a continuation.
+		if ($line =~ /(\\*)$/ && length($1) % 2 == 1) {
+			$adj++;
+		} else {
+			$lines_seen++;
+		}
+		$src_ln++;
+	}
+	if ($lines_seen < $body_lineno) {
+		warn "body_lineno ($body_lineno) not found within body range " .
+		    "($body_start..$end)\n";
+	}
+	return $file_lineno + $adj;
+}
+
+# ScriptParser calls this for each test body found in the script.
+sub check_test {
+	my $self = shift @_;
+	my $title = ScriptParser::unwrap(shift @_);
+	my $body_token = shift @_;
+	my $body_start = $body_token->[3];
+	my $body = ScriptParser::unwrap($body_token);
+	# Handle heredoc-style test bodies:
+	#   test_expect_success 'title' - <<\EOF
+	#   grep pattern file
+	#   EOF
+	# The '-' signals that the body follows as a heredoc.
+	if ($body eq '-') {
+		my $herebody = shift @_;
+		if ($herebody) {
+			$body = $herebody->{content};
+			$body_start = $herebody->{start_line};
+		}
+	}
+	return unless $body;
+
+	my $raw_lines = $self->{raw_lines};
+
+	# The outer parser gives us the body as an opaque string.
+	# Parse it to get individual tokens with command boundaries.
+	my $parser = ShellParser->new(\$body);
+	my @tokens = $parser->parse();
+
+	my $file = $self->{file};
+
+	for (my $i = 0; $i < @tokens; $i++) {
+		my $text = $tokens[$i]->[0];
+		next unless is_command_word(\@tokens, $i);
+
+		my $token_lineno = $tokens[$i]->[3];
+		unless (defined($token_lineno) && $token_lineno >= 1) {
+			warn "token has no line number\n";
+			next;
+		}
+		my $file_lineno = body_to_file_line(
+			$token_lineno,
+			$body_token, $raw_lines, $body_start);
+
+		# '!' negates the exit code without consuming command
+		# position.  '! test_grep' is an anti-pattern because
+		# test_grep only prints diagnostics on grep failure,
+		# and '!' inverts after that decision is already made.
+		if ($text eq '!') {
+			if ($i + 1 < @tokens &&
+			    $tokens[$i + 1]->[0] eq 'test_grep' &&
+			    !lint_ok($raw_lines, $file_lineno)) {
+				print "$file:$file_lineno: error: ",
+				    'use "test_grep !" instead of ',
+				    '"! test_grep"', "\n";
+				$exit_code = 1;
+			}
+			next;
+		}
+
+		# Bare grep as a command (not a filter) is a test
+		# assertion that should use test_grep for better
+		# failure diagnostics.
+		if ($text eq 'grep' &&
+		    !is_filter(\@tokens, $i) &&
+		    !lint_ok($raw_lines, $file_lineno)) {
+			print "$file:$file_lineno: error: ",
+			    "bare grep outside pipeline ",
+			    "(use test_grep)\n";
+			$exit_code = 1;
+		}
+	}
+}
+
+package main;
+
+for my $file (@ARGV) {
+	open(my $fh, '<:unix:crlf', $file) or die "$0: $file: $!\n";
+	my @raw_lines = <$fh>;
+	close $fh;
+	my $s = join('', @raw_lines);
+	my $parser = GrepLintParser->new(\$s);
+	$parser->{file} = $file;
+	$parser->{raw_lines} = \@raw_lines;
+	$parser->parse();
+}
+exit $exit_code;
diff --git a/t/greplint/bare-grep-after-and.expect b/t/greplint/bare-grep-after-and.expect
new file mode 100644
index 0000000000..7da1b21aa8
--- /dev/null
+++ b/t/greplint/bare-grep-after-and.expect
@@ -0,0 +1 @@
+3: error: bare grep outside pipeline (use test_grep)
diff --git a/t/greplint/bare-grep-after-and.test b/t/greplint/bare-grep-after-and.test
new file mode 100644
index 0000000000..c5b26e4572
--- /dev/null
+++ b/t/greplint/bare-grep-after-and.test
@@ -0,0 +1,4 @@
+test_expect_success 'grep after && is flagged' '
+	cmd &&
+	grep pattern file
+'
diff --git a/t/greplint/bare-grep-after-semicolon.expect b/t/greplint/bare-grep-after-semicolon.expect
new file mode 100644
index 0000000000..7da1b21aa8
--- /dev/null
+++ b/t/greplint/bare-grep-after-semicolon.expect
@@ -0,0 +1 @@
+3: error: bare grep outside pipeline (use test_grep)
diff --git a/t/greplint/bare-grep-after-semicolon.test b/t/greplint/bare-grep-after-semicolon.test
new file mode 100644
index 0000000000..c1e468ddf8
--- /dev/null
+++ b/t/greplint/bare-grep-after-semicolon.test
@@ -0,0 +1,4 @@
+test_expect_success 'grep after semicolon is flagged' '
+	echo hello;
+	grep pattern file
+'
diff --git a/t/greplint/bare-grep-compound-body.expect b/t/greplint/bare-grep-compound-body.expect
new file mode 100644
index 0000000000..eb6210f0c9
--- /dev/null
+++ b/t/greplint/bare-grep-compound-body.expect
@@ -0,0 +1,3 @@
+4: error: bare grep outside pipeline (use test_grep)
+8: error: bare grep outside pipeline (use test_grep)
+15: error: bare grep outside pipeline (use test_grep)
diff --git a/t/greplint/bare-grep-compound-body.test b/t/greplint/bare-grep-compound-body.test
new file mode 100644
index 0000000000..72472edcf6
--- /dev/null
+++ b/t/greplint/bare-grep-compound-body.test
@@ -0,0 +1,17 @@
+test_expect_success 'grep after then/do/else is flagged' '
+	if true
+	then
+		grep pattern file
+	fi &&
+	while true
+	do
+		grep pattern file &&
+		break
+	done &&
+	if true
+	then
+		echo yes
+	else
+		grep pattern file
+	fi
+'
diff --git a/t/greplint/bare-grep-count-mode.expect b/t/greplint/bare-grep-count-mode.expect
new file mode 100644
index 0000000000..8922d35b42
--- /dev/null
+++ b/t/greplint/bare-grep-count-mode.expect
@@ -0,0 +1 @@
+2: error: bare grep outside pipeline (use test_grep)
diff --git a/t/greplint/bare-grep-count-mode.test b/t/greplint/bare-grep-count-mode.test
new file mode 100644
index 0000000000..b9c0f18783
--- /dev/null
+++ b/t/greplint/bare-grep-count-mode.test
@@ -0,0 +1,3 @@
+test_expect_success 'grep -c is flagged (not special-cased)' '
+	grep -c pattern file
+'
diff --git a/t/greplint/bare-grep-explicit-pattern.expect b/t/greplint/bare-grep-explicit-pattern.expect
new file mode 100644
index 0000000000..8922d35b42
--- /dev/null
+++ b/t/greplint/bare-grep-explicit-pattern.expect
@@ -0,0 +1 @@
+2: error: bare grep outside pipeline (use test_grep)
diff --git a/t/greplint/bare-grep-explicit-pattern.test b/t/greplint/bare-grep-explicit-pattern.test
new file mode 100644
index 0000000000..69d8651019
--- /dev/null
+++ b/t/greplint/bare-grep-explicit-pattern.test
@@ -0,0 +1,3 @@
+test_expect_success 'grep -e is flagged' '
+	grep -e pattern file
+'
diff --git a/t/greplint/bare-grep-flags.expect b/t/greplint/bare-grep-flags.expect
new file mode 100644
index 0000000000..8922d35b42
--- /dev/null
+++ b/t/greplint/bare-grep-flags.expect
@@ -0,0 +1 @@
+2: error: bare grep outside pipeline (use test_grep)
diff --git a/t/greplint/bare-grep-flags.test b/t/greplint/bare-grep-flags.test
new file mode 100644
index 0000000000..9ca0e10233
--- /dev/null
+++ b/t/greplint/bare-grep-flags.test
@@ -0,0 +1,3 @@
+test_expect_success 'grep -E is flagged' '
+	grep -E "pat+ern" file
+'
diff --git a/t/greplint/bare-grep-lint-ok.expect b/t/greplint/bare-grep-lint-ok.expect
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/greplint/bare-grep-lint-ok.test b/t/greplint/bare-grep-lint-ok.test
new file mode 100644
index 0000000000..335b902a42
--- /dev/null
+++ b/t/greplint/bare-grep-lint-ok.test
@@ -0,0 +1,4 @@
+test_expect_success 'grep with lint-ok annotation is not flagged' '
+	grep pattern file && # lint-ok
+	echo done
+'
diff --git a/t/greplint/bare-grep-negated.expect b/t/greplint/bare-grep-negated.expect
new file mode 100644
index 0000000000..8922d35b42
--- /dev/null
+++ b/t/greplint/bare-grep-negated.expect
@@ -0,0 +1 @@
+2: error: bare grep outside pipeline (use test_grep)
diff --git a/t/greplint/bare-grep-negated.test b/t/greplint/bare-grep-negated.test
new file mode 100644
index 0000000000..ef789bc8b7
--- /dev/null
+++ b/t/greplint/bare-grep-negated.test
@@ -0,0 +1,3 @@
+test_expect_success 'negated grep is flagged' '
+	! grep pattern file
+'
diff --git a/t/greplint/bare-grep-pattern-file.expect b/t/greplint/bare-grep-pattern-file.expect
new file mode 100644
index 0000000000..8922d35b42
--- /dev/null
+++ b/t/greplint/bare-grep-pattern-file.expect
@@ -0,0 +1 @@
+2: error: bare grep outside pipeline (use test_grep)
diff --git a/t/greplint/bare-grep-pattern-file.test b/t/greplint/bare-grep-pattern-file.test
new file mode 100644
index 0000000000..d70035e449
--- /dev/null
+++ b/t/greplint/bare-grep-pattern-file.test
@@ -0,0 +1,3 @@
+test_expect_success 'grep -f is flagged' '
+	grep -f patterns.txt file
+'
diff --git a/t/greplint/bare-grep-simple.expect b/t/greplint/bare-grep-simple.expect
new file mode 100644
index 0000000000..8922d35b42
--- /dev/null
+++ b/t/greplint/bare-grep-simple.expect
@@ -0,0 +1 @@
+2: error: bare grep outside pipeline (use test_grep)
diff --git a/t/greplint/bare-grep-simple.test b/t/greplint/bare-grep-simple.test
new file mode 100644
index 0000000000..3a8d5f9bbd
--- /dev/null
+++ b/t/greplint/bare-grep-simple.test
@@ -0,0 +1,3 @@
+test_expect_success 'bare grep is flagged' '
+	grep pattern file
+'
diff --git a/t/greplint/bare-grep-subshell.expect b/t/greplint/bare-grep-subshell.expect
new file mode 100644
index 0000000000..7da1b21aa8
--- /dev/null
+++ b/t/greplint/bare-grep-subshell.expect
@@ -0,0 +1 @@
+3: error: bare grep outside pipeline (use test_grep)
diff --git a/t/greplint/bare-grep-subshell.test b/t/greplint/bare-grep-subshell.test
new file mode 100644
index 0000000000..1fab2d3363
--- /dev/null
+++ b/t/greplint/bare-grep-subshell.test
@@ -0,0 +1,5 @@
+test_expect_success 'grep in subshell is flagged' '
+	(
+		grep pattern file
+	)
+'
diff --git a/t/greplint/dqstring-continuation-offset.expect b/t/greplint/dqstring-continuation-offset.expect
new file mode 100644
index 0000000000..8185bfdca4
--- /dev/null
+++ b/t/greplint/dqstring-continuation-offset.expect
@@ -0,0 +1 @@
+10: error: bare grep outside pipeline (use test_grep)
diff --git a/t/greplint/dqstring-continuation-offset.test b/t/greplint/dqstring-continuation-offset.test
new file mode 100644
index 0000000000..b332bd8f3b
--- /dev/null
+++ b/t/greplint/dqstring-continuation-offset.test
@@ -0,0 +1,11 @@
+# Double-quoted test bodies with backslash-continuation lines:
+# the splice adjustment in check_test compensates for \<newline>
+# lines that the lexer consumes without emitting into the body
+# text, so the reported line number matches the source.
+test_expect_success 'dqstring continuation offset' "
+	x=\$(echo \
+		hello) &&
+	y=\$(echo \
+		world) &&
+	grep pattern file
+"
diff --git a/t/greplint/filter-command-substitution.expect b/t/greplint/filter-command-substitution.expect
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/greplint/filter-command-substitution.test b/t/greplint/filter-command-substitution.test
new file mode 100644
index 0000000000..bd9a100a5d
--- /dev/null
+++ b/t/greplint/filter-command-substitution.test
@@ -0,0 +1,3 @@
+test_expect_success 'grep in command substitution is not flagged' '
+	x=$(grep pattern file)
+'
diff --git a/t/greplint/filter-pipe-input.expect b/t/greplint/filter-pipe-input.expect
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/greplint/filter-pipe-input.test b/t/greplint/filter-pipe-input.test
new file mode 100644
index 0000000000..cb5c0d9e23
--- /dev/null
+++ b/t/greplint/filter-pipe-input.test
@@ -0,0 +1,3 @@
+test_expect_success 'grep receiving pipe input is not flagged' '
+	cmd | grep pattern
+'
diff --git a/t/greplint/filter-pipe-output.expect b/t/greplint/filter-pipe-output.expect
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/greplint/filter-pipe-output.test b/t/greplint/filter-pipe-output.test
new file mode 100644
index 0000000000..01340086d7
--- /dev/null
+++ b/t/greplint/filter-pipe-output.test
@@ -0,0 +1,3 @@
+test_expect_success 'grep piping to another command is not flagged' '
+	grep pattern file | wc -l
+'
diff --git a/t/greplint/filter-redirect-output.expect b/t/greplint/filter-redirect-output.expect
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/greplint/filter-redirect-output.test b/t/greplint/filter-redirect-output.test
new file mode 100644
index 0000000000..ee70ba7cde
--- /dev/null
+++ b/t/greplint/filter-redirect-output.test
@@ -0,0 +1,3 @@
+test_expect_success 'grep with output redirect is not flagged' '
+	grep pattern file >output
+'
diff --git a/t/greplint/filter-stdin-redirect.expect b/t/greplint/filter-stdin-redirect.expect
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/greplint/filter-stdin-redirect.test b/t/greplint/filter-stdin-redirect.test
new file mode 100644
index 0000000000..292db7766e
--- /dev/null
+++ b/t/greplint/filter-stdin-redirect.test
@@ -0,0 +1,3 @@
+test_expect_success 'grep reading from stdin redirect is not flagged' '
+	grep pattern <input
+'
diff --git a/t/greplint/grep-as-argument.expect b/t/greplint/grep-as-argument.expect
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/greplint/grep-as-argument.test b/t/greplint/grep-as-argument.test
new file mode 100644
index 0000000000..7157228b60
--- /dev/null
+++ b/t/greplint/grep-as-argument.test
@@ -0,0 +1,3 @@
+test_expect_success 'grep as argument to another command is not flagged' '
+	test_must_fail grep pattern file
+'
diff --git a/t/greplint/grep-as-value.expect b/t/greplint/grep-as-value.expect
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/greplint/grep-as-value.test b/t/greplint/grep-as-value.test
new file mode 100644
index 0000000000..92926f6378
--- /dev/null
+++ b/t/greplint/grep-as-value.test
@@ -0,0 +1,6 @@
+test_expect_success 'grep as value in for-loop is not flagged' '
+	for cmd in grep sed awk
+	do
+		echo $cmd
+	done
+'
diff --git a/t/greplint/wrong-negation.expect b/t/greplint/wrong-negation.expect
new file mode 100644
index 0000000000..7dc52f65a8
--- /dev/null
+++ b/t/greplint/wrong-negation.expect
@@ -0,0 +1 @@
+2: error: use "test_grep !" instead of "! test_grep"
diff --git a/t/greplint/wrong-negation.test b/t/greplint/wrong-negation.test
new file mode 100644
index 0000000000..542fbd9b28
--- /dev/null
+++ b/t/greplint/wrong-negation.test
@@ -0,0 +1,3 @@
+test_expect_success 'wrong negation of test_grep is flagged' '
+	! test_grep pattern file
+'
-- 
gitgitgadget
