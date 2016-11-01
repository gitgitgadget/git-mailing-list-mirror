Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0939A20229
	for <e@80x24.org>; Tue,  1 Nov 2016 21:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbcKAViW (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 17:38:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54952 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752760AbcKAViV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 17:38:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90A1E4B701;
        Tue,  1 Nov 2016 17:38:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lleksrgx5WFRs3wkfw9GYPebBYE=; b=lcdOAa
        /jR6bobkpZ36c2TMWcwE4Tc/EzAwjYYb5GbT+MWEefQDcqJqSK6LCNpLhthtC/C5
        yMA9p2HBlHHUY6tgl7RF0XG9qo0KH5VOP5V+LzjEe0QyvH7/i1LStCsYWwk8Q+SI
        O0kRg827WYmcggmpi3Uno4THfAN9ssiaDm750=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BeOMDyaYrkFdKJoVnWS5qG6CLAyFhBJZ
        4Xkr8PkcbxgFRi9Gv0zjsoJsEHsKuHMPQJygMJFwcA1B677ikT0Qg2i2E7wdABIT
        P8KSbRpsVE7bpwaE/0ZS6f8lL62HC3TG7Uc60FLYNNWX8J1xDcCLIr+pYd25RDj4
        UN2ggoyn/Y0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 882E04B700;
        Tue,  1 Nov 2016 17:38:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8DB54B6FF;
        Tue,  1 Nov 2016 17:38:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
        <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net>
        <xmqqlgx2or5p.fsf@gitster.mtv.corp.google.com>
        <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
        <xmqqh97qoqq2.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 01 Nov 2016 14:38:18 -0700
In-Reply-To: <xmqqh97qoqq2.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 01 Nov 2016 14:05:57 -0700")
Message-ID: <xmqqzilinanp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81C0325A-A07B-11E6-812C-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If it involves renaming and swapping, however, we may be talking
> about a change that we cannot deliver with confidence in less than a
> week before -rc1, which sounds, eh, suboptimal.
>
> FWIW, here is how the removal of compaction without renaming looks
> like.

And here is _with_ renaming.  I think "compaction heuristics" is a
much better phrase to call "heuristics used during the diff hunk
compaction process" without specifying how that heuristics work
(like taking hints in the indentation levels).  If we are to retire
one while keeping the other, compaction-heuristics should be the
name we give and keep for the surviving one.

I have not much confidence in the conversion result, though.

 Documentation/diff-config.txt            |  1 -
 Documentation/diff-heuristic-options.txt |  2 --
 builtin/blame.c                          |  3 +--
 diff.c                                   | 25 ++++-----------------
 git-add--interactive.perl                |  5 +----
 t/t4061-diff-indent.sh                   | 38 ++++++++++++++++----------------
 xdiff/xdiff.h                            |  1 -
 xdiff/xdiffi.c                           | 17 +-------------
 8 files changed, 26 insertions(+), 66 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 58f4bd6afa..0c79e48d9d 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -171,7 +171,6 @@ diff.tool::
 
 include::mergetools-diff.txt[]
 
-diff.indentHeuristic::
 diff.compactionHeuristic::
 	Set one of these options to `true` to enable one of two
 	experimental heuristics that shift diff hunk boundaries to
diff --git a/Documentation/diff-heuristic-options.txt b/Documentation/diff-heuristic-options.txt
index 36cb549df9..3cb024aa22 100644
--- a/Documentation/diff-heuristic-options.txt
+++ b/Documentation/diff-heuristic-options.txt
@@ -1,5 +1,3 @@
---indent-heuristic::
---no-indent-heuristic::
 --compaction-heuristic::
 --no-compaction-heuristic::
 	These are to help debugging and tuning experimental heuristics
diff --git a/builtin/blame.c b/builtin/blame.c
index 4ddfadb71f..395d4011fb 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2596,7 +2596,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		 * and are only included here to get included in the "-h"
 		 * output:
 		 */
-		{ OPTION_LOWLEVEL_CALLBACK, 0, "indent-heuristic", NULL, NULL, N_("Use an experimental indent-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
 		{ OPTION_LOWLEVEL_CALLBACK, 0, "compaction-heuristic", NULL, NULL, N_("Use an experimental blank-line-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
 
 		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find better match"), XDF_NEED_MINIMAL),
@@ -2645,7 +2644,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	}
 parse_done:
 	no_whole_file_rename = !DIFF_OPT_TST(&revs.diffopt, FOLLOW_RENAMES);
-	xdl_opts |= revs.diffopt.xdl_opts & (XDF_COMPACTION_HEURISTIC | XDF_INDENT_HEURISTIC);
+	xdl_opts |= revs.diffopt.xdl_opts & XDF_COMPACTION_HEURISTIC;
 	DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
 	argc = parse_options_end(&ctx);
 
diff --git a/diff.c b/diff.c
index 8981477c43..f1b01f5b1e 100644
--- a/diff.c
+++ b/diff.c
@@ -27,7 +27,6 @@
 #endif
 
 static int diff_detect_rename_default;
-static int diff_indent_heuristic; /* experimental */
 static int diff_compaction_heuristic; /* experimental */
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
@@ -223,16 +222,8 @@ void init_diff_ui_defaults(void)
 
 int git_diff_heuristic_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "diff.indentheuristic")) {
-		diff_indent_heuristic = git_config_bool(var, value);
-		if (diff_indent_heuristic)
-			diff_compaction_heuristic = 0;
-	}
-	if (!strcmp(var, "diff.compactionheuristic")) {
+	if (!strcmp(var, "diff.compactionheuristic"))
 		diff_compaction_heuristic = git_config_bool(var, value);
-		if (diff_compaction_heuristic)
-			diff_indent_heuristic = 0;
-	}
 	return 0;
 }
 
@@ -3378,9 +3369,7 @@ void diff_setup(struct diff_options *options)
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
-	if (diff_indent_heuristic)
-		DIFF_XDL_SET(options, INDENT_HEURISTIC);
-	else if (diff_compaction_heuristic)
+	if (diff_compaction_heuristic)
 		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
@@ -3876,15 +3865,9 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
-	else if (!strcmp(arg, "--indent-heuristic")) {
-		DIFF_XDL_SET(options, INDENT_HEURISTIC);
-		DIFF_XDL_CLR(options, COMPACTION_HEURISTIC);
-	} else if (!strcmp(arg, "--no-indent-heuristic"))
-		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-	else if (!strcmp(arg, "--compaction-heuristic")) {
+	else if (!strcmp(arg, "--compaction-heuristic"))
 		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
-		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-	} else if (!strcmp(arg, "--no-compaction-heuristic"))
+	else if (!strcmp(arg, "--no-compaction-heuristic"))
 		DIFF_XDL_CLR(options, COMPACTION_HEURISTIC);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ee3d812695..642cce1ac6 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -45,7 +45,6 @@
 my $normal_color = $repo->get_color("", "reset");
 
 my $diff_algorithm = $repo->config('diff.algorithm');
-my $diff_indent_heuristic = $repo->config_bool('diff.indentheuristic');
 my $diff_compaction_heuristic = $repo->config_bool('diff.compactionheuristic');
 my $diff_filter = $repo->config('interactive.difffilter');
 
@@ -751,9 +750,7 @@ sub parse_diff {
 	if (defined $diff_algorithm) {
 		splice @diff_cmd, 1, 0, "--diff-algorithm=${diff_algorithm}";
 	}
-	if ($diff_indent_heuristic) {
-		splice @diff_cmd, 1, 0, "--indent-heuristic";
-	} elsif ($diff_compaction_heuristic) {
+	if ($diff_compaction_heuristic) {
 		splice @diff_cmd, 1, 0, "--compaction-heuristic";
 	}
 	if (defined $patch_mode_revision) {
diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 556450609b..30f809d0d3 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Test diff indent heuristic.
+test_description='Test diff compaction heuristic.
 
 '
 . ./test-lib.sh
@@ -157,28 +157,28 @@ test_expect_success 'diff: ugly spaces' '
 	compare_diff spaces-expect out
 '
 
-test_expect_success 'diff: nice spaces with --indent-heuristic' '
-	git diff --indent-heuristic old new -- spaces.txt >out-compacted &&
+test_expect_success 'diff: nice spaces with --compaction-heuristic' '
+	git diff --compaction-heuristic old new -- spaces.txt >out-compacted &&
 	compare_diff spaces-compacted-expect out-compacted
 '
 
-test_expect_success 'diff: nice spaces with diff.indentHeuristic' '
-	git -c diff.indentHeuristic=true diff old new -- spaces.txt >out-compacted2 &&
+test_expect_success 'diff: nice spaces with diff.compactionHeuristic' '
+	git -c diff.compactionHeuristic=true diff old new -- spaces.txt >out-compacted2 &&
 	compare_diff spaces-compacted-expect out-compacted2
 '
 
-test_expect_success 'diff: --no-indent-heuristic overrides config' '
-	git -c diff.indentHeuristic=true diff --no-indent-heuristic old new -- spaces.txt >out2 &&
+test_expect_success 'diff: --no-compaction-heuristic overrides config' '
+	git -c diff.compactionHeuristic=true diff --no-compaction-heuristic old new -- spaces.txt >out2 &&
 	compare_diff spaces-expect out2
 '
 
-test_expect_success 'diff: --indent-heuristic with --patience' '
-	git diff --indent-heuristic --patience old new -- spaces.txt >out-compacted3 &&
+test_expect_success 'diff: --compaction-heuristic with --patience' '
+	git diff --compaction-heuristic --patience old new -- spaces.txt >out-compacted3 &&
 	compare_diff spaces-compacted-expect out-compacted3
 '
 
-test_expect_success 'diff: --indent-heuristic with --histogram' '
-	git diff --indent-heuristic --histogram old new -- spaces.txt >out-compacted4 &&
+test_expect_success 'diff: --compaction-heuristic with --histogram' '
+	git diff --compaction-heuristic --histogram old new -- spaces.txt >out-compacted4 &&
 	compare_diff spaces-compacted-expect out-compacted4
 '
 
@@ -187,8 +187,8 @@ test_expect_success 'diff: ugly functions' '
 	compare_diff functions-expect out
 '
 
-test_expect_success 'diff: nice functions with --indent-heuristic' '
-	git diff --indent-heuristic old new -- functions.c >out-compacted &&
+test_expect_success 'diff: nice functions with --compaction-heuristic' '
+	git diff --compaction-heuristic old new -- functions.c >out-compacted &&
 	compare_diff functions-compacted-expect out-compacted
 '
 
@@ -197,18 +197,18 @@ test_expect_success 'blame: ugly spaces' '
 	compare_blame spaces-expect out-blame
 '
 
-test_expect_success 'blame: nice spaces with --indent-heuristic' '
-	git blame --indent-heuristic old..new -- spaces.txt >out-blame-compacted &&
+test_expect_success 'blame: nice spaces with --compaction-heuristic' '
+	git blame --compaction-heuristic old..new -- spaces.txt >out-blame-compacted &&
 	compare_blame spaces-compacted-expect out-blame-compacted
 '
 
-test_expect_success 'blame: nice spaces with diff.indentHeuristic' '
-	git -c diff.indentHeuristic=true blame old..new -- spaces.txt >out-blame-compacted2 &&
+test_expect_success 'blame: nice spaces with diff.compactionHeuristic' '
+	git -c diff.compactionHeuristic=true blame old..new -- spaces.txt >out-blame-compacted2 &&
 	compare_blame spaces-compacted-expect out-blame-compacted2
 '
 
-test_expect_success 'blame: --no-indent-heuristic overrides config' '
-	git -c diff.indentHeuristic=true blame --no-indent-heuristic old..new -- spaces.txt >out-blame2 &&
+test_expect_success 'blame: --no-compaction-heuristic overrides config' '
+	git -c diff.compactionHeuristic=true blame --no-compaction-heuristic old..new -- spaces.txt >out-blame2 &&
 	git blame old..new -- spaces.txt >out-blame &&
 	compare_blame spaces-expect out-blame2
 '
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 8db16d4ae6..7423f77fc8 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -42,7 +42,6 @@ extern "C" {
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
 
 #define XDF_COMPACTION_HEURISTIC (1 << 8)
-#define XDF_INDENT_HEURISTIC (1 << 9)
 
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 760fbb6db7..6cb96219cb 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -906,22 +906,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				if (group_previous(xdfo, &go))
 					xdl_bug("group sync broken sliding to match");
 			}
-		} else if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
-			/*
-			 * Compaction heuristic: if it is possible to shift the
-			 * group to make its bottom line a blank line, do so.
-			 *
-			 * As we already shifted the group forward as far as
-			 * possible in the earlier loop, we only need to handle
-			 * backward shifts, not forward ones.
-			 */
-			while (!is_blank_line(xdf->recs[g.end - 1], flags)) {
-				if (group_slide_up(xdf, &g, flags))
-					xdl_bug("blank line disappeared");
-				if (group_previous(xdfo, &go))
-					xdl_bug("group sync broken sliding to blank line");
-			}
-		} else if (flags & XDF_INDENT_HEURISTIC) {
+		} else if (flags & XDF_COMPACTION_HEURISTIC) {
 			/*
 			 * Indent heuristic: a group of pure add/delete lines
 			 * implies two splits, one between the end of the "before"
