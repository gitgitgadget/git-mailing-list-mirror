Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCFDECAAD4
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiIAAaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIAAaD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B5125C4C
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w5so4092468wrn.12
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=qzKTWlJoINKQudyGiXVS/3T0blznJqjVaOqJ1HdYyfk=;
        b=F642mROJV4TYjqZnZQz00thpEq+uRs74AUok4sxRvtlXSzD2VhpHH2QL1ydFdDPjYW
         VGit6kcrlqkdrfAe4GSRWHup8N6k4zZm3eJlUCCVTRdY2kHsI3rx7RRSeoqvJOC/8LDL
         IuudfIQEi1gfC4GlzJ411GirOycvIJd2rCmyxMQv6EGZKhaZm+8Ffsi93fkvOrJw9rdB
         nZCk16S3/QaRGuo+/OgHkZBRwj7o7xHvwhkQtmUfIs3WUb+tjzedGFHHpEpVE6ac9TlU
         AlxM+5fwT+t9FhrEkCs0sHTkwRE0xVzXzpkjZntpCFIA97k0nn8+xVOdzTYlj9lDIHKC
         1pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=qzKTWlJoINKQudyGiXVS/3T0blznJqjVaOqJ1HdYyfk=;
        b=PZXDLGsuPgLNqW73LirjSSdDVn2icigqsWjA802gGfaoUJe2Ovq10bY4G4RuP6GrCY
         efBY9DqdtumsZNZ+vabHE29pXPERCFzMi62MG7EXOwI/wJt79N1m6mlTHXUPbMrMBwZV
         +t12VydAzwVdPy91Vm4k+d93EaiYVPKJB/mUapkgmIaLjHZiGFkCyWOvirva3W/nagbT
         sQlKoxEwM71F+17c6Z0IKsH93dXmgf7XWPfN4AeCM9+TiLwvxCbcf0f66CTiYOv7zEiz
         rHMa9+kIO8xxhoLMMSlGNhmrQzj+FDutWfWjoBXDTpdnOQC/LJXDnObzzM4O2AXUnZRR
         G8SA==
X-Gm-Message-State: ACgBeo1x04qlogWcQmNnQth7Tkc28lsRvNQkaihsWvMgOOBcnSbrOxT1
        BYdXm1vwGqDgCP6oyqm6Gngy27jmyd0=
X-Google-Smtp-Source: AA6agR767JjMPgT+lvC4e79oydVgzU4QQLlp9LP2yg4Sls9lQ6VfYg3zsMdawaKDijfnaUXVNRMaGQ==
X-Received: by 2002:a5d:6d85:0:b0:225:760f:1d50 with SMTP id l5-20020a5d6d85000000b00225760f1d50mr12659884wrs.608.1661992200032;
        Wed, 31 Aug 2022 17:30:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020adff752000000b0021e5adb92desm13121125wrp.60.2022.08.31.17.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:29:59 -0700 (PDT)
Message-Id: <3423df94bd6035640828a2508968cf8e1f5b4dda.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:39 +0000
Subject: [PATCH 01/18] t: add skeleton chainlint.pl
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Although chainlint.sed usefully identifies broken &&-chains in tests, it
has several shortcomings which include:

  * only detects &&-chain breakage in subshells (one-level deep)

  * does not check for broken top-level &&-chains; that task is left to
    the "magic exit code 117" checker built into test-lib.sh, however,
    that detection does not extend to `{...}` blocks, `$(...)`
    expressions, or compound statements such as `if...fi`,
    `while...done`, `case...esac`

  * uses heuristics, which makes it (potentially) fallible and difficult
    to tweak to handle additional real-world cases

  * written in `sed` and employs advanced `sed` operators which are
    probably not well-known to many programmers, thus the pool of people
    who can maintain it is likely small

  * manually simulates recursion into subshells which makes it much more
    difficult to reason about than, say, a traditional top-down parser

  * checks each test as the test is run, which can get expensive for
    tests which are run repeatedly by functions or loops since their
    bodies will be checked over and over (tens or hundreds of times)
    unnecessarily

To address these shortcomings, begin implementing a more functional and
precise test linter which understands shell syntax and semantics rather
than employing heuristics, thus is able to recognize structural problems
with tests beyond broken &&-chains.

The new linter is written in Perl, thus should be more accessible to a
wider audience, and is structured as a traditional top-down parser which
makes it much easier to reason about, and allows it to inspect compound
statements within test bodies to any depth.

Furthermore, it can check all test definitions in the entire project in
a single invocation rather than having to be invoked once per test, and
each test definition is checked only once no matter how many times the
test is actually run.

At this stage, the new linter is just a skeleton containing boilerplate
which handles command-line options, collects and reports statistics, and
feeds its arguments -- paths of test scripts -- to a (presently)
do-nothing script parser for validation. Subsequent changes will flesh
out the functionality.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 115 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100755 t/chainlint.pl

diff --git a/t/chainlint.pl b/t/chainlint.pl
new file mode 100755
index 00000000000..e8ab95c7858
--- /dev/null
+++ b/t/chainlint.pl
@@ -0,0 +1,115 @@
+#!/usr/bin/env perl
+#
+# Copyright (c) 2021-2022 Eric Sunshine <sunshine@sunshineco.com>
+#
+# This tool scans shell scripts for test definitions and checks those tests for
+# problems, such as broken &&-chains, which might hide bugs in the tests
+# themselves or in behaviors being exercised by the tests.
+#
+# Input arguments are pathnames of shell scripts containing test definitions,
+# or globs referencing a collection of scripts. For each problem discovered,
+# the pathname of the script containing the test is printed along with the test
+# name and the test body with a `?!FOO?!` annotation at the location of each
+# detected problem, where "FOO" is a tag such as "AMP" which indicates a broken
+# &&-chain. Returns zero if no problems are discovered, otherwise non-zero.
+
+use warnings;
+use strict;
+use File::Glob;
+use Getopt::Long;
+
+my $show_stats;
+my $emit_all;
+
+package ScriptParser;
+
+sub new {
+	my $class = shift @_;
+	my $self = bless {} => $class;
+	$self->{output} = [];
+	$self->{ntests} = 0;
+	return $self;
+}
+
+sub parse_cmd {
+	return undef;
+}
+
+# main contains high-level functionality for processing command-line switches,
+# feeding input test scripts to ScriptParser, and reporting results.
+package main;
+
+my $getnow = sub { return time(); };
+my $interval = sub { return time() - shift; };
+if (eval {require Time::HiRes; Time::HiRes->import(); 1;}) {
+	$getnow = sub { return [Time::HiRes::gettimeofday()]; };
+	$interval = sub { return Time::HiRes::tv_interval(shift); };
+}
+
+sub show_stats {
+	my ($start_time, $stats) = @_;
+	my $walltime = $interval->($start_time);
+	my ($usertime) = times();
+	my ($total_workers, $total_scripts, $total_tests, $total_errs) = (0, 0, 0, 0);
+	for (@$stats) {
+		my ($worker, $nscripts, $ntests, $nerrs) = @$_;
+		print(STDERR "worker $worker: $nscripts scripts, $ntests tests, $nerrs errors\n");
+		$total_workers++;
+		$total_scripts += $nscripts;
+		$total_tests += $ntests;
+		$total_errs += $nerrs;
+	}
+	printf(STDERR "total: %d workers, %d scripts, %d tests, %d errors, %.2fs/%.2fs (wall/user)\n", $total_workers, $total_scripts, $total_tests, $total_errs, $walltime, $usertime);
+}
+
+sub check_script {
+	my ($id, $next_script, $emit) = @_;
+	my ($nscripts, $ntests, $nerrs) = (0, 0, 0);
+	while (my $path = $next_script->()) {
+		$nscripts++;
+		my $fh;
+		unless (open($fh, "<", $path)) {
+			$emit->("?!ERR?! $path: $!\n");
+			next;
+		}
+		my $s = do { local $/; <$fh> };
+		close($fh);
+		my $parser = ScriptParser->new(\$s);
+		1 while $parser->parse_cmd();
+		if (@{$parser->{output}}) {
+			my $s = join('', @{$parser->{output}});
+			$emit->("# chainlint: $path\n" . $s);
+			$nerrs += () = $s =~ /\?![^?]+\?!/g;
+		}
+		$ntests += $parser->{ntests};
+	}
+	return [$id, $nscripts, $ntests, $nerrs];
+}
+
+sub exit_code {
+	my $stats = shift @_;
+	for (@$stats) {
+		my ($worker, $nscripts, $ntests, $nerrs) = @$_;
+		return 1 if $nerrs;
+	}
+	return 0;
+}
+
+Getopt::Long::Configure(qw{bundling});
+GetOptions(
+	"emit-all!" => \$emit_all,
+	"stats|show-stats!" => \$show_stats) or die("option error\n");
+
+my $start_time = $getnow->();
+my @stats;
+
+my @scripts;
+push(@scripts, File::Glob::bsd_glob($_)) for (@ARGV);
+unless (@scripts) {
+	show_stats($start_time, \@stats) if $show_stats;
+	exit;
+}
+
+push(@stats, check_script(1, sub { shift(@scripts); }, sub { print(@_); }));
+show_stats($start_time, \@stats) if $show_stats;
+exit(exit_code(\@stats));
-- 
gitgitgadget

