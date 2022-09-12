Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A69C6FA83
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 23:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiILXEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 19:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiILXEx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 19:04:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03853DF06
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 16:04:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j26so8015349wms.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 16:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=b+mXrejdB3UaPXjsdtyAwxEHEjB2wsWVSGbDyqy+LCc=;
        b=A9l4WCwgDWS2xSrzEJoXinxFeXAKUmpqyoGzaY5BPMR+nubZzjXTQpr1f63MAFKEfq
         OQhixxf2shi8kMC+kMmiRI4h6F/xOAyzSeworX1UnWjK1lo+vVA/nLnH8wUA1MuCYbyY
         kux2fzEJ0W/3NI4AnGvgTv6hbFKKkTHeJmd3N/cR8JtnGt8PLzDhyIJmzoWv8gVNrkIF
         ajEGMLfrVEcKfkVnq2XpptLGemPi3Go8tK/GeZSt7MsbFMNWpctvCs4rKkxeUBBq8G7H
         ff7uTRS8StG+08LCPqT5jkS9s31496aztn+wD1/1FNUw9xT+6UySrQQ3TydU25m60fWl
         xlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=b+mXrejdB3UaPXjsdtyAwxEHEjB2wsWVSGbDyqy+LCc=;
        b=6kQb5EIbnLa/ac3yQVNRvF2wRsJmJaybdlSWaTghqMFepc8kQbtd6uiq/ucWi7cu6C
         fKAndx+P9q42p82CvjUk0hpX8NXFf1jAtxL1Lu6Om5mbThr6BjdrYeDKEnWleIFOY5Tb
         eit7Ct/gdcP/ViIOJhhmnmZth9y/KvZ9fP9aamyNdYweg3UWQdba6qwhc+kGAKEHvLB6
         kBn7q/DpDtKxw9AKd5WWCEqmBLFYfoB/hU1BdednHgTl1OL+PXvgWuqm+qa6RYG39M0f
         QaW/bYYLNDfP8zCyoE3wkd62kuNnnUsyhkmAa0PFwiBeJki3FIXYaGNcsSS7kVv5qxVM
         tSkg==
X-Gm-Message-State: ACgBeo32wVn3TUj6rMZbR3BSRa34OWYpl9tDqNHl5DprtsZqei0xPwI8
        +ZR8LGwyPAhUQg4azVECKtKuvQsHuLE=
X-Google-Smtp-Source: AA6agR5xRXeXJ878ZDrRJ9ZWIaykkpyCvwCNDHflf48/okslATaMy3exSBd5NnfiGam6cKFWsbtrIA==
X-Received: by 2002:a05:600c:a14e:b0:3b4:7ff1:299b with SMTP id ib14-20020a05600ca14e00b003b47ff1299bmr403496wmb.18.1663023889302;
        Mon, 12 Sep 2022 16:04:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1-20020a056000118100b0022a2f4fa042sm8547152wrx.103.2022.09.12.16.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 16:04:49 -0700 (PDT)
Message-Id: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Sep 2022 23:04:48 +0000
Subject: [PATCH] chainlint: colorize problem annotations and test delimiters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

When `chainlint.pl` detects problems in a test definition, it emits the
test definition with "?!FOO?!" annotations highlighting the problems it
discovered. For instance, given this problematic test:

    test_expect_success 'discombobulate frobnitz' '
        git frob babble &&
        (echo balderdash; echo gnabgib) >expect &&
        for i in three two one
        do
            git nitfol $i
        done >actual
        test_cmp expect actual
    '

chainlint.pl will output:

    # chainlint: t1234-confusing.sh
    # chainlint: discombobulate frobnitz
    git frob babble &&
    (echo balderdash ; ?!AMP?! echo gnabgib) >expect &&
    for i in three two one
    do
    git nitfol $i ?!LOOP?!
    done >actual ?!AMP?!
    test_cmp expect actual

in which it may be difficult to spot the "?!FOO?!" annotations. The
problem is compounded when multiple tests, possibly in multiple
scripts, fail "linting", in which case it may be difficult to spot the
"# chainlint:" lines which delimit one problematic test from another.

To ameliorate this potential problem, colorize the "?!FOO?!" annotations
in order to quickly draw the test author's attention to the problem
spots, and colorize the "# chainlint:" lines to help the author identify
the name of each script and each problematic test.

Colorization is disabled automatically if output is not directed to a
terminal or if NO_COLOR environment variable is set. The implementation
is specific to Unix (it employs `tput` if available) but works equally
well in the Git for Windows development environment which emulates Unix
sufficiently.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
    chainlint: colorize problem annotations and test delimiters
    
    Peff nerd-sniped me yet again[1,2,3,4].
    
    This is atop "es/chainlint" (eab3357b05b2) in "next".
    
    [1]
    https://lore.kernel.org/git/YJzGcZpZ+E9R0gYd@coredump.intra.peff.net/
    [2]
    https://lore.kernel.org/git/Yx1x5lme2SGBjfia@coredump.intra.peff.net/
    [3]
    https://lore.kernel.org/git/CAPig+cRJVn-mbA6-jOmNfDJtK_nX4ZTw+OcNShvvz8zcQYbCHQ@mail.gmail.com/
    [4]
    https://lore.kernel.org/git/Yx4pg2t6JXR+lsd4@coredump.intra.peff.net/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1324%2Fsunshineco%2Fchainlintcolor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1324/sunshineco/chainlintcolor-v1
Pull-Request: https://github.com/git/git/pull/1324

 t/chainlint.pl | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 386999ce65d..3a6d85ecfdd 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -585,12 +585,14 @@ sub check_test {
 	my $parser = TestParser->new(\$body);
 	my @tokens = $parser->parse();
 	return unless $emit_all || grep(/\?![^?]+\?!/, @tokens);
+	my $c = main::fd_colors(1);
 	my $checked = join(' ', @tokens);
 	$checked =~ s/^\n//;
 	$checked =~ s/^ //mg;
 	$checked =~ s/ $//mg;
+	$checked =~ s/(\?![^?]+\?!)/$c->{bold}$c->{red}$1$c->{reset}/mg;
 	$checked .= "\n" unless $checked =~ /\n$/;
-	push(@{$self->{output}}, "# chainlint: $title\n$checked");
+	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
 }
 
 sub parse_cmd {
@@ -615,6 +617,39 @@ if (eval {require Time::HiRes; Time::HiRes->import(); 1;}) {
 	$interval = sub { return Time::HiRes::tv_interval(shift); };
 }
 
+# Restore TERM if test framework set it to "dumb" so 'tput' will work; do this
+# outside of get_colors() since under 'ithreads' all threads use %ENV of main
+# thread and ignore %ENV changes in subthreads.
+$ENV{TERM} = $ENV{USER_TERM} if $ENV{USER_TERM};
+
+my @NOCOLORS = (bold => '', reset => '', blue => '', green => '', red => '');
+my %COLORS = ();
+sub get_colors {
+	return \%COLORS if %COLORS;
+	if (exists($ENV{NO_COLOR}) ||
+	    system("tput sgr0 >/dev/null 2>&1") != 0 ||
+	    system("tput bold >/dev/null 2>&1") != 0 ||
+	    system("tput setaf 1 >/dev/null 2>&1") != 0) {
+		%COLORS = @NOCOLORS;
+		return \%COLORS;
+	}
+	%COLORS = (bold  => `tput bold`,
+		   reset => `tput sgr0`,
+		   blue  => `tput setaf 4`,
+		   green => `tput setaf 2`,
+		   red   => `tput setaf 1`);
+	chomp(%COLORS);
+	return \%COLORS;
+}
+
+my %FD_COLORS = ();
+sub fd_colors {
+	my $fd = shift;
+	return $FD_COLORS{$fd} if exists($FD_COLORS{$fd});
+	$FD_COLORS{$fd} = -t $fd ? get_colors() : {@NOCOLORS};
+	return $FD_COLORS{$fd};
+}
+
 sub ncores {
 	# Windows
 	return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS});
@@ -630,6 +665,8 @@ sub show_stats {
 	my $walltime = $interval->($start_time);
 	my ($usertime) = times();
 	my ($total_workers, $total_scripts, $total_tests, $total_errs) = (0, 0, 0, 0);
+	my $c = fd_colors(2);
+	print(STDERR $c->{green});
 	for (@$stats) {
 		my ($worker, $nscripts, $ntests, $nerrs) = @$_;
 		print(STDERR "worker $worker: $nscripts scripts, $ntests tests, $nerrs errors\n");
@@ -638,7 +675,7 @@ sub show_stats {
 		$total_tests += $ntests;
 		$total_errs += $nerrs;
 	}
-	printf(STDERR "total: %d workers, %d scripts, %d tests, %d errors, %.2fs/%.2fs (wall/user)\n", $total_workers, $total_scripts, $total_tests, $total_errs, $walltime, $usertime);
+	printf(STDERR "total: %d workers, %d scripts, %d tests, %d errors, %.2fs/%.2fs (wall/user)$c->{reset}\n", $total_workers, $total_scripts, $total_tests, $total_errs, $walltime, $usertime);
 }
 
 sub check_script {
@@ -656,8 +693,9 @@ sub check_script {
 		my $parser = ScriptParser->new(\$s);
 		1 while $parser->parse_cmd();
 		if (@{$parser->{output}}) {
+			my $c = fd_colors(1);
 			my $s = join('', @{$parser->{output}});
-			$emit->("# chainlint: $path\n" . $s);
+			$emit->("$c->{bold}$c->{blue}# chainlint: $path$c->{reset}\n" . $s);
 			$nerrs += () = $s =~ /\?![^?]+\?!/g;
 		}
 		$ntests += $parser->{ntests};

base-commit: 50f0e44ec40b5fab5d618dd26ebd776c47e9af13
-- 
gitgitgadget
