Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73DEC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 12:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241819AbiCBMlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiCBMlg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 07:41:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74B6FA1A
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 04:40:53 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p15so3467362ejc.7
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 04:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0dgD3/lZ+ypJA9QaAyntBM5z0L7w5xY4InkYJmwM7/0=;
        b=Rz3W1qolUA8JppMz3ihfHVMnIeAWmBTu7H70HbK+3lx2TR9XZchDsYlhNT5Pn2aUg7
         +qCpZuGnE1Hjc6uIpce4NTn9c8gMFX3BocDVxqavLORKADqC+4eogH8CKCZTU7hM4MuM
         gJ3/HmMqWf3ZhEN4t12xmjCM1S6E2R0HWG4fRY+1sjQ80nKYajzwnEVXzmoqCG4PBbS/
         GYJ0c2WagzO+d7FKn+VaHfBt9z8bgO0QqutxnCPGfYCHb7wdMDbpXGLf3itDgGD0SyCA
         1WiITyX7IpmCRTrL8OGYjFVdb9Dqo1U52mB0d3DxgC8ySBJrmaYOxVwAbO/oeofaS6VZ
         y5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0dgD3/lZ+ypJA9QaAyntBM5z0L7w5xY4InkYJmwM7/0=;
        b=RpObaPFxR02XuSg3+U8Pl1FN+dXCJuuURhNv1yL8u0+abDDVCYOlZVn3lqZA0nX8Sg
         S3LrlelVlZQZDN0JnAZyI6vpVELPkJ9JwNJyh1RI0oGJS8qtqKgCNy7vCZ6bfi1oQVg5
         iUVNhm/gB5J+xxyXym7p7jMhYUEzClj5FjgBZDTGRfcTBm/3mlCji131Hhm0wjQtwN1I
         oJSxR2zPWIgwXffm4MzfaAhjMFYe53YtRCVrvWP++FezIKlpJ1TcT1A3MIVD5qZfbCfz
         uDQvwVIgca3yUnicqmhfH2Q9vaztjJ14UhBj5zm8Da6tiP5DRgffB1bivQxa94G1JI0s
         ip4Q==
X-Gm-Message-State: AOAM531gY9shrEUWXreMhjxhzcBcvr0Rstyik+OE6zMJSPFNC4H+7dG8
        2TjLmgUnH9a2NKC26VZYpvs=
X-Google-Smtp-Source: ABdhPJxgPvzp15bEFp9zKLsowliQ+rLvh7T+6HMLLDZhM+/QshunbBq0a9yujU9rizC/aX2ys56kSg==
X-Received: by 2002:a17:907:9626:b0:6da:6c6f:9825 with SMTP id gb38-20020a170907962600b006da6c6f9825mr1330158ejc.600.1646224851243;
        Wed, 02 Mar 2022 04:40:51 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906688a00b006ce29973bafsm6303429ejr.211.2022.03.02.04.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:40:50 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPOHh-0007Gi-Du;
        Wed, 02 Mar 2022 13:40:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Wed, 02 Mar 2022 13:22:24 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
Message-ID: <220302.86mti87cj2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Johannes Schindelin via GitGitGadget wrote:

> Changes since v1:
>
>  * In the patch that removed MAKE_TARGETS, a stale comment about that
>    variable is also removed.
>  * The comment about set -x has been adjusted because it no longer applies
>    as-is.
>  * The commit message of "ci: make it easier to find failed tests' logs in
>    the GitHub workflow" has been adjusted to motivate the improvement
>    better.

Just briefly: Much of the feedback I had on v1 is still unanswered, or
in the case of the performance issues I think just saying that this
output is aimed at non-long-time-contributors doesn't really justify the
large observed slowdowns.

I've been clicking around on the various "seen" links you posted, and
while some of the output is improved it's *much* slower, to the point
where I don't find those gains worth it.

For the early part of this series teaching the "ci/" this GitHub
markdown that's something that's unnecessary in my alternate approach in
[1]. This series is is obviously a relatively shorter way to get there,
but knowing that you *can* do it in a simpler way now it's odd that the
v2 doesn't discuss why getting from "A" to that "B" is still desirable
with this method.

As for the later parts:

>   5:  94dcbe1bc43 =  5:  9eda6574313 tests: refactor --write-junit-xml code
>   6:  41230100091 =  6:  c8b240af749 test(junit): avoid line feeds in XML attributes
>   7:  98b32630fcd =  7:  15f199e810e ci: optionally mark up output in the GitHub workflow
>   8:  1a6bd1846bc =  8:  91ea54f36c5 ci: use `--github-workflow-markup` in the GitHub workflow
>   9:  992b1575889 =  9:  be2a83f5da3 ci: call `finalize_test_case_output` a little later

I think (and I pointed out to you before) that I really don't see why
teaching the test-lib.sh N output formats when we already have a
machine-readable output format with TAP *and* are in fact running code
with "prove" that is parsing that output format into nicely arranged
objects/structures makes sense.

So as a demo for how that can work, here's a quick POC I hacked up a
while ago to use "prove" output plugins for this sort of thing.

First we intentionally break a test:

	$ git -P diff
	diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
	index 76052cb5620..f085188baf9 100755
	--- a/t/t0002-gitfile.sh
	+++ b/t/t0002-gitfile.sh
	@@ -44,7 +44,7 @@ test_expect_success 'check hash-object' '
	 
	 test_expect_success 'check cat-file' '
	        git cat-file blob $SHA >actual &&
	-       test_cmp bar actual
	+       test_cmp /dev/null actual
	 '
	 
	 test_expect_success 'check update-index' '
	@@ -67,7 +67,7 @@ test_expect_success 'check commit-tree' '
	 
	 test_expect_success 'check rev-list' '
	        git update-ref "HEAD" "$SHA" &&
	-       test "$SHA" = "$(git rev-list HEAD)"
	+       test "$SHA" = "$(xgit rev-list HEAD)"
	 '

And here's the resulting output, which is the same as the existing
"prove" summary output, but then followed by nicely formatted details
about just the failing tests:

	$ PERL5LIB=$PWD prove --formatter Fmt t0002-gitfile.sh :: -vx
	 
	 test_expect_success 'setup_git_dir twice in subdir' '
	t0002-gitfile.sh .. Dubious, test returned 1 (wstat 256, 0x100)
	Failed 2/14 subtests 
	
	Test Summary Report
	-------------------
	t0002-gitfile.sh (Wstat: 256 Tests: 14 Failed: 2)
	  Failed tests:  6, 10
	  Non-zero exit status: 1
	Files=1, Tests=14,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.13 cusr  0.05 csys =  0.20 CPU)
	Result: FAIL
	Failed in t0002-gitfile.sh#6:
	 ==> test   => not ok 6 - check cat-file
	 ==> source => #
	 ==> source => #        git cat-file blob $SHA >actual &&
	 ==> source => #        test_cmp /dev/null actual
	 ==> source => #
	 ==> trace  => + git cat-file blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99
	 ==> trace  => + test_cmp /dev/null actual
	 ==> trace  => + test 2 -ne 2
	 ==> trace  => + eval diff -u "$@"
	 ==> trace  => + diff -u /dev/null actual
	 ==> output => --- /dev/null    2022-01-25 04:40:50.187529644 +0000
	 ==> output => +++ actual       2022-03-02 12:29:28.217960535 +0000
	 ==> output => @@ -0,0 +1 @@
	 ==> output => +foo
	 ==> output => error: last command exited with $?=1
	 ==> output => 
	Failed in t0002-gitfile.sh#10:
	 ==> test   => not ok 10 - check rev-list
	 ==> source => #
	 ==> source => #        git update-ref "HEAD" "$SHA" &&
	 ==> source => #        test "$SHA" = "$(xgit rev-list HEAD)"
	 ==> source => #
	 ==> trace  => + git update-ref HEAD f2e10ff57e8c01fe514c650d9de97e913257ba0c
	 ==> trace  => + xgit rev-list HEAD
	 ==> trace  => + test f2e10ff57e8c01fe514c650d9de97e913257ba0c = 
	 ==> output => t0002-gitfile.sh: 5: eval: xgit: not found
	 ==> output => error: last command exited with $?=1
	 ==> output => 

Now, some of that is on top of some output changes to test-lib.sh I had
locally, but the "test", "source" etc. there is not a hardcoded part of
the output, it's corresponding to (some of which I re-labeled,
e.g. "comment" => "source") the individual object types the TAP::Parser
emits.

The code to do that is below, with brief (unindented) comments:

	package Git::TAP::Formatter::Session;
	use v5.18.2;
	use strict;
	use warnings;
	use base 'TAP::Formatter::Console::ParallelSession';
	
	our %STATE;
	sub result {
		my $self = shift;
		my $result = shift;

So here we just have the TAP object for the current tests (as in "ok",
"not ok" etc.), and save all of those away (both for successful and
non-successful) tests in %STATE for later:
	
		my $res = $self->SUPER::result($result);
		my $test_name = $self->name;
	
		# An AoO of test numbers and their output lines
		$STATE{$test_name} ||= [{lines => []}];
	
		push @{$STATE{$test_name}->[-1]->{lines}} => $result;
	
		# When we see a new test add a new AoA for its output. We do
		# end up with the "plan" type as part of the last test, and
		# might want to split it up
		if ($result->type eq 'test') {
			push @{$STATE{$test_name}} => {};
		}
	
		return $res;
	}

This "Fmt" package is a "prove" plugin. It's just hooking into the code
that emits the current summary, now it just shows the "Test Summary
Report" that your CL notes issues with, but this shows how easy it is to
change or amend it (you can override another accessor here to fully
suppress the current output, I just didn't do that):

	package Fmt;
	use strict;
	use warnings;
	use List::MoreUtils qw(firstidx);
	use base 'TAP::Formatter::Console';
	
	sub open_test {
		my $self = shift;
	
		my $session = $self->SUPER::open_test(@_);
		use Data::Dumper;
		#warn "session is = " . Dumper $session;
		return bless $session => 'Git::TAP::Formatter::Session';
	}
	
	sub summary {
		my $self = shift;
		$self->SUPER::summary(@_);
	
		## This state machine needs to go past the "ok" line and grab
		## the comments emitted by e.g. "say_color_tap_comment_lines" in
		## test_ok_()
		for my $test (sort keys %STATE) {
			for (my $i = 1; $i <= $#{$STATE{$test}}; $i++) {
				my @lines = @{$STATE{$test}->[$i]->{lines}};
				my $break = firstidx { $_->raw eq '' } @lines;
				my @source = splice @lines, 0, $break;
	
				splice @lines, 0, 1; # Splice out the '' item
				push @{$STATE{$test}->[$i - 1]->{lines}} => @source;
	
				$STATE{$test}->[$i]->{lines} = \@lines;
	
				# Since we parsed out the source already,
				# let's make it easily machine-readable, and
				# parse the rest.
				$STATE{$test}->[$i]->{source} = \@source;
				my @trace = map { $_->{is_trace} = 1 } grep { $_->raw =~ /^\+ / } @lines;
				$STATE{$test}->[$i]->{trace} = \@trace if @trace;
			}
		}
	
		my $aggregator = $_[0];
		for my $failed ($aggregator->failed) {
			my ($parser) = $aggregator->parsers($failed);
			for my $i ($parser->failed) {
				my $idx = $i - 1;
				my @lines = @{$STATE{$failed}->[$idx]->{lines}};
				my ($test) = grep { $_->is_test } @lines;
	
				say "Failed in $failed#$i:";
				say join "\n", map {
					s/^/ ==> /gr;
				} map {
					sprintf("%-6s => %s",
					     $_->{is_trace} ? "trace" :
					     $_->is_unknown ? "output" :
					     $_->is_comment ? "source" :
					     $_->type,
					     $_->raw,
				     );
				} sort {
					# the "is_trace" may be undef
					no warnings qw(uninitialized);
					# The "[not ]ok" line first...
					$b->is_test <=> $a->is_test ||
					# Then "comment" (i.e. test source)
					$b->is_comment <=> $a->is_comment ||
					# Then the "+ " trace of execution
					$b->{is_trace} <=> $a->{is_trace}
				} @lines;
			}
		}
	}
	
	1;


1. https://lore.kernel.org/git/cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com/
2. https://lore.kernel.org/git/220222.86y2236ndp.gmgdl@evledraar.gmail.com/
