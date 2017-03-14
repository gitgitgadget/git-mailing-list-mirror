Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28ED201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 17:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbdCNRZJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 13:25:09 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34559 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdCNRZI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 13:25:08 -0400
Received: by mail-pf0-f173.google.com with SMTP id v190so73216523pfb.1
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+s8bxcZWy4ZBie0uipuNzumiMbqtxL1hMcjUYdSMiaU=;
        b=UkYbbh4KLHgoPHNjG+OJCEhiyiGTwfO/jnv/gbWfsHhhBIuVLW1tIsUXTO2TcTwJBG
         G/cio5nS3smiO9NsnDVVcwm1BB2qFcVX2VM65YFPGIA4XRV8hfggdykUZheo6cNL6IaB
         bkmbklK4G/P5WdAFsQkLBWEJguxExtwBSWVZ2OhmEx/5fXU9TTjgrqw+J8ly5DKXo2wp
         7EvkVlImDwFzH0TyiiwULcdjF6MeYNsIN9gl2UDkBJr2FwhqhuSW3o2SG/hpCYFfN8o0
         OXpZyVvV4O2TQJOUkGHM7UZefDyQ0lCdqR96QA/5N9O0v+ZVvfO5EKV5v5m+0wWFYPJI
         oIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+s8bxcZWy4ZBie0uipuNzumiMbqtxL1hMcjUYdSMiaU=;
        b=AyX7n2jDjB/OV1J7viKziZVuVTJcd6FA+TDPAyZr5gnAmpjnvpquxv1qkRnjGd/+7u
         2yATinLTLaK4O/DFfQg+Uv/lrx4Y0cBJ8APFpEooGJzrrVNtOOLkMsa+ojqspV+8dYXw
         7jBMLqnO4I9b/8mgtDY2PxJKzVfce+Au7MXSXmeCr38Mlj0OlSsWcVrnFtD3nT9Ai1LC
         mtzbEUi9beKsYgAvufWYxJN52dyyjhprHUcsxLJN00LM3v7nVV6iLBKPiNsKY0X6T/+m
         W8sUyA7spN0Ov84gd3IRvsZ22xKAttSFaKT0MnuDhA9qOsNA1A7/+R9p5eiUdpajy9aP
         KE4A==
X-Gm-Message-State: AMke39ljXHafirdpV0I26AIwp19gpom5F1kiK05DiO1rGThOJIFFBg/DOOO+FwNGWmxUkTms
X-Received: by 10.99.67.1 with SMTP id q1mr45542409pga.210.1489512306674;
        Tue, 14 Mar 2017 10:25:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:491b:baa8:63f0:3cf1])
        by smtp.gmail.com with ESMTPSA id t6sm40012794pgt.8.2017.03.14.10.25.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 10:25:05 -0700 (PDT)
Date:   Tue, 14 Mar 2017 10:25:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Wincent Colaiuta <win@wincent.com>,
        Mislav =?utf-8?B?TWFyb2huacSH?= <mislav.marohnic@gmail.com>
Subject: Re: [PATCH] add--interactive: do not expand pathspecs with ls-files
Message-ID: <20170314172504.GA102212@google.com>
References: <20170314163024.et2cp5e3imrrrf7k@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314163024.et2cp5e3imrrrf7k@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Jeff King wrote:
>   b. If the repository contains filenames with literal wildcard
>      characters (e.g., "foo*"), the original code expanded
>      them via "ls-files" and then fed those wildcard names
>      to "diff-index", which would have treated them as
>      wildcards. This was a bug, which is now fixed (though
>      unless you really go through some contortions with
>      ":(literal)", it's likely that your original pathspec
>      would match whatever the accidentally-expanded wildcard
>      would anyway).
> 
>      So this takes us one step closer to working correctly
>      with files whose names contain wildcard characters, but
>      it's likely that others remain (e.g., if "git add -i"
>      feeds the selected paths to "git add").

It definitely makes things more difficult when people use wildcard
characters in filenames.  Is there any reason people use wildcards as
literal characters in filenames other than them not knowing any better?

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index f5c816e27..77b4ed53a 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -275,20 +275,11 @@ sub list_modified {
>  	my ($only) = @_;
>  	my (%data, @return);
>  	my ($add, $del, $adddel, $file);
> -	my @tracked = ();
> -
> -	if (@ARGV) {
> -		@tracked = map {
> -			chomp $_;
> -			unquote_path($_);
> -		} run_cmd_pipe(qw(git ls-files --), @ARGV);
> -		return if (!@tracked);
> -	}
>  
>  	my $reference = get_diff_reference($patch_mode_revision);
>  	for (run_cmd_pipe(qw(git diff-index --cached
>  			     --numstat --summary), $reference,
> -			     '--', @tracked)) {
> +			     '--', @ARGV)) {
>  		if (($add, $del, $file) =
>  		    /^([-\d]+)	([-\d]+)	(.*)/) {
>  			my ($change, $bin);
> @@ -313,7 +304,7 @@ sub list_modified {
>  		}
>  	}
>  
> -	for (run_cmd_pipe(qw(git diff-files --numstat --summary --raw --), @tracked)) {
> +	for (run_cmd_pipe(qw(git diff-files --numstat --summary --raw --), @ARGV)) {

Such a small and easy change for that big of a perf win.

>  		if (($add, $del, $file) =
>  		    /^([-\d]+)	([-\d]+)	(.*)/) {
>  			$file = unquote_path($file);
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index aaa258daa..f9528fa00 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -412,4 +412,47 @@ test_expect_success 'patch-mode via -i prompts for files' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'add -p handles globs' '
> +	git reset --hard &&
> +
> +	mkdir -p subdir &&
> +	echo base >one.c &&
> +	echo base >subdir/two.c &&
> +	git add "*.c" &&
> +	git commit -m base &&
> +
> +	echo change >one.c &&
> +	echo change >subdir/two.c &&
> +	git add -p "*.c" <<-\EOF &&
> +	y
> +	y
> +	EOF
> +
> +	cat >expect <<-\EOF &&
> +	one.c
> +	subdir/two.c
> +	EOF
> +	git diff --cached --name-only >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'add -p does not expand argument lists' '
> +	git reset --hard &&
> +
> +	echo content >not-changed &&
> +	git add not-changed &&
> +	git commit -m "add not-changed file" &&
> +
> +	echo change >file &&
> +	GIT_TRACE=$(pwd)/trace.out git add -p . <<-\EOF &&
> +	y
> +	EOF
> +
> +	# we know that "file" must be mentioned since we actually
> +	# update it, but we want to be sure that our "." pathspec
> +	# was not expanded into the argument list of any command.
> +	# So look only for "not-changed".
> +	! grep not-changed trace.out
> +'
> +
>  test_done

Tests look sane to me.

-- 
Brandon Williams
