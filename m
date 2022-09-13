Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D973C6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 04:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiIMEBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 00:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiIMEBv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 00:01:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A45349B40
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 21:01:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id e18so2422432wmq.3
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 21:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=txWTLFOsDAPs1Q+Y2J6EixdGH7rj2nvsGs1S+gndTgc=;
        b=eVP4GdF2V+UmruTVyaKjg/8Wo/EHYfHYhm3fPXO6Hld8b0ttnKVuQphylYBhJUUh/T
         J7r2wpR1fr4hc8jbBNvGxQNJYAf9R8PHXDi/YD9wE/9nJkbknTp6YveoTE6a8rOaQNyC
         wMNwXqFHWO5RyStKLalAWKpw1yiF/FrLm4hBHL3PPUnJgQ8qtEVBURlBs7eObIl3uxcK
         sStY/Gt8YwxFHKIyPgl05z1ekt1pItk/5QK2XrBDLZ0G18UUce8sOUg5hC8492HCnkcQ
         nv8aBdPQEffKjL/u0d//2t9oAXGhFXRwLpUNaInF8Z7zk0J1xcz+LVZJo9UhXuVtvtrq
         wpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=txWTLFOsDAPs1Q+Y2J6EixdGH7rj2nvsGs1S+gndTgc=;
        b=qrcyNOUkveBbgxup4z93GqxFzQdx73obOYS4EMJ8JG+0vk32Xe3WJBXr/eyUZziiTo
         8+suwK1qLfdX+5UUp9VZxqGQjWos8gVvOWekVXdlQut7OCb9a0BWM0CejKOMA27sKrOU
         tCsfKnKckWNykUmNc/M0pC2fHlILxqYRu2VhmKcNfleWPqUTJ5oq0oxso776P79C/u3Z
         5GEZWhtW4pF999hhocSWtX+hAaDw3628uGBz+5yiYWQtS66YTNxu8BzCBmXF4EDf4CB7
         2jRzuMsxDMzIn2LquChXanpevOjSaOr072k5GpVWetebpA1VIYZtWLf7aeo2dBuflKoF
         EEZQ==
X-Gm-Message-State: ACgBeo2YN521ZUgZNcsKEPOhrj2gh14/eQ70iUHfGDe0hgMCtTDDpi5Z
        /r86arQQomxR3J2m2xYJs2TABR6WRfE=
X-Google-Smtp-Source: AA6agR7dmvBQPzbLVPeVb+v2a1YO7nB2hERFhK59l951Bs26twmpNgGKCjusItYGEfhGrEPbNWnGGA==
X-Received: by 2002:a05:600c:3d05:b0:3b4:9a42:10d0 with SMTP id bh5-20020a05600c3d0500b003b49a4210d0mr53390wmb.135.1663041708753;
        Mon, 12 Sep 2022 21:01:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n27-20020a05600c3b9b00b003b4764442f0sm9227434wms.11.2022.09.12.21.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 21:01:48 -0700 (PDT)
Message-Id: <pull.1324.v2.git.git.1663041707260.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 04:01:47 +0000
Subject: [PATCH v2] chainlint: colorize problem annotations and test
 delimiters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
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
    
    This is a re-roll of [1] which colorizes the output of "chainlint.pl"
    when it detects problems in Git test definitions. During discussion, it
    was noted that the eye could sometimes glide right over[2] the bold-red
    "?!FOO?!" annotations, so Junio suggested using reverse video, which is
    what v2 does.
    
    Reverse video certainly makes the "?!FOO?!" annotations pop out and draw
    the reader's attention. I find that I don't have a strong preference
    between this version and v1 which merely used bold-red, but I suspect
    that v2 with its reverse video is probably the better approach.
    
    [1]
    https://lore.kernel.org/git/pull.1324.git.git.1663023888412.gitgitgadget@gmail.com/
    [2]
    https://lore.kernel.org/git/CAPig+cTq3j5M7cz3T14h9U6e+H5PAu8JJ_Svq87W3WviwS6_qA@mail.gmail.com/
    [3] https://lore.kernel.org/git/xmqqo7vkazuh.fsf@gitster.g/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1324%2Fsunshineco%2Fchainlintcolor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1324/sunshineco/chainlintcolor-v2
Pull-Request: https://github.com/git/git/pull/1324

Range-diff vs v1:

 1:  d670570e81f ! 1:  acf9183ccc6 chainlint: colorize problem annotations and test delimiters
     @@ t/chainlint.pl: sub check_test {
       	$checked =~ s/^\n//;
       	$checked =~ s/^ //mg;
       	$checked =~ s/ $//mg;
     -+	$checked =~ s/(\?![^?]+\?!)/$c->{bold}$c->{red}$1$c->{reset}/mg;
     ++	$checked =~ s/(\?![^?]+\?!)/$c->{rev}$c->{red}$1$c->{reset}/mg;
       	$checked .= "\n" unless $checked =~ /\n$/;
      -	push(@{$self->{output}}, "# chainlint: $title\n$checked");
      +	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
     @@ t/chainlint.pl: if (eval {require Time::HiRes; Time::HiRes->import(); 1;}) {
      +# thread and ignore %ENV changes in subthreads.
      +$ENV{TERM} = $ENV{USER_TERM} if $ENV{USER_TERM};
      +
     -+my @NOCOLORS = (bold => '', reset => '', blue => '', green => '', red => '');
     ++my @NOCOLORS = (bold => '', rev => '', reset => '', blue => '', green => '', red => '');
      +my %COLORS = ();
      +sub get_colors {
      +	return \%COLORS if %COLORS;
      +	if (exists($ENV{NO_COLOR}) ||
      +	    system("tput sgr0 >/dev/null 2>&1") != 0 ||
      +	    system("tput bold >/dev/null 2>&1") != 0 ||
     ++	    system("tput rev  >/dev/null 2>&1") != 0 ||
      +	    system("tput setaf 1 >/dev/null 2>&1") != 0) {
      +		%COLORS = @NOCOLORS;
      +		return \%COLORS;
      +	}
      +	%COLORS = (bold  => `tput bold`,
     ++		   rev   => `tput rev`,
      +		   reset => `tput sgr0`,
      +		   blue  => `tput setaf 4`,
      +		   green => `tput setaf 2`,


 t/chainlint.pl | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 386999ce65d..976db4b8a01 100755
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
+	$checked =~ s/(\?![^?]+\?!)/$c->{rev}$c->{red}$1$c->{reset}/mg;
 	$checked .= "\n" unless $checked =~ /\n$/;
-	push(@{$self->{output}}, "# chainlint: $title\n$checked");
+	push(@{$self->{output}}, "$c->{blue}# chainlint: $title$c->{reset}\n$checked");
 }
 
 sub parse_cmd {
@@ -615,6 +617,41 @@ if (eval {require Time::HiRes; Time::HiRes->import(); 1;}) {
 	$interval = sub { return Time::HiRes::tv_interval(shift); };
 }
 
+# Restore TERM if test framework set it to "dumb" so 'tput' will work; do this
+# outside of get_colors() since under 'ithreads' all threads use %ENV of main
+# thread and ignore %ENV changes in subthreads.
+$ENV{TERM} = $ENV{USER_TERM} if $ENV{USER_TERM};
+
+my @NOCOLORS = (bold => '', rev => '', reset => '', blue => '', green => '', red => '');
+my %COLORS = ();
+sub get_colors {
+	return \%COLORS if %COLORS;
+	if (exists($ENV{NO_COLOR}) ||
+	    system("tput sgr0 >/dev/null 2>&1") != 0 ||
+	    system("tput bold >/dev/null 2>&1") != 0 ||
+	    system("tput rev  >/dev/null 2>&1") != 0 ||
+	    system("tput setaf 1 >/dev/null 2>&1") != 0) {
+		%COLORS = @NOCOLORS;
+		return \%COLORS;
+	}
+	%COLORS = (bold  => `tput bold`,
+		   rev   => `tput rev`,
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
@@ -630,6 +667,8 @@ sub show_stats {
 	my $walltime = $interval->($start_time);
 	my ($usertime) = times();
 	my ($total_workers, $total_scripts, $total_tests, $total_errs) = (0, 0, 0, 0);
+	my $c = fd_colors(2);
+	print(STDERR $c->{green});
 	for (@$stats) {
 		my ($worker, $nscripts, $ntests, $nerrs) = @$_;
 		print(STDERR "worker $worker: $nscripts scripts, $ntests tests, $nerrs errors\n");
@@ -638,7 +677,7 @@ sub show_stats {
 		$total_tests += $ntests;
 		$total_errs += $nerrs;
 	}
-	printf(STDERR "total: %d workers, %d scripts, %d tests, %d errors, %.2fs/%.2fs (wall/user)\n", $total_workers, $total_scripts, $total_tests, $total_errs, $walltime, $usertime);
+	printf(STDERR "total: %d workers, %d scripts, %d tests, %d errors, %.2fs/%.2fs (wall/user)$c->{reset}\n", $total_workers, $total_scripts, $total_tests, $total_errs, $walltime, $usertime);
 }
 
 sub check_script {
@@ -656,8 +695,9 @@ sub check_script {
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

base-commit: 76d57e004b0391503ca7719c932df2a0bd617d0a
-- 
gitgitgadget
