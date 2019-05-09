Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC53B1F45F
	for <e@80x24.org>; Thu,  9 May 2019 12:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEIMdw (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 08:33:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36810 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfEIMdw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 08:33:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so1884605edx.3
        for <git@vger.kernel.org>; Thu, 09 May 2019 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=kfhJ7a1kIe+a06DpZ7ZpS4Abm9vCf5j1cc8L+wkNMqk=;
        b=ZNFl0dSddx9289UQokqBnNfiIpWEN1VX7BGydjJ8Eu/tM1mGEK8LcV455+Nw2Yu+mr
         WH1XCajRNwfSlh+7NjhF0szfIIYvMXiTDVIZOTe60ZelCM1iNOMrplwDQfxxupTVoG5b
         dLcRsuWPHAP7kWWZJjfmIfZfYSEvfuOnCEf2esUWvrYzDPnjeCjUHRkCr6uhe3b07jCV
         JMne5BCZSQI/Hypl+POviuWORIs+5LF4hW2a46f5qBiURB5rmGcD1VybqeIqjhy+QCYX
         hHJSNV8Zv7CBHawZneTUAVE/6cXPOzTEILILYCgbhCugYcd+xRShLKBXaSXUA054NHpS
         OpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=kfhJ7a1kIe+a06DpZ7ZpS4Abm9vCf5j1cc8L+wkNMqk=;
        b=T6XvINsOAopoITMmD0NU5J9myKhKCiFoY+Ts8XBK7sSiT8qYkirE3xQcdvuEq+RAiP
         q5tylklseWuaEiZRK8v0owuY0zaLPPFZJ+u3EpGc+y0yZ6ywEzEyM3Pavu+sq5I2aT6x
         K+PFC5OxDIi6O7cOd/eY+ZWrLNI5sTEXV6bJvXxcV0maInJYmapdnFWndBm9yRZ6xBl8
         oeZgTzXTNZQxGgRS1w7iMr8EZFUsCbM/pvj84jdkqzhvAqgNZejbS5AX7tX/tyJ6qj1h
         2wxUP7dmj4dZirjtgn2dw4MgDv2W77/enfdOAq2e0cT2LboshGkftB55dBSI6hHfuCyf
         qYVw==
X-Gm-Message-State: APjAAAXmX/EjrPIQ7MIPKn58lSPSDpkhoCTUVunbeKxzMEO1XXBF+/XU
        w9XFmKe2lqg8ctXgoW3+caF8RBTwBws=
X-Google-Smtp-Source: APXvYqzUaoGhnqq8OA65igZUdmRQfwauYskCtZtjN6PSHNy5PE01QT74PMvvvXfFdmCqhh6JO8nwfQ==
X-Received: by 2002:a50:8fa4:: with SMTP id y33mr3634138edy.197.1557405229925;
        Thu, 09 May 2019 05:33:49 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id g30sm556519edg.57.2019.05.09.05.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 05:33:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>
Subject: Re: [PATCH] check-non-portable-shell: support Perl versions older than 5.10
References: <CAH8yC8nTyq5Fjc-6fUNn1iwkCO9i1Vrc0vFqxEVg4Eor3h-0Lw@mail.gmail.com> <20190509102037.27044-1-sunshine@sunshineco.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190509102037.27044-1-sunshine@sunshineco.com>
Date:   Thu, 09 May 2019 14:33:48 +0200
Message-ID: <87ftpnhknn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 09 2019, Eric Sunshine wrote:

> For thoroughness when checking for one-shot environment variable
> assignments at shell function call sites, check-non-portable-shell
> stitches together incomplete lines (those ending with backslash). This
> allows it to correctly flag such undesirable usage even when the
> variable assignment and function call are split across lines, for
> example:
>
>     FOO=bar \
>     func
>
> where 'func' is a shell function.
>
> The stitching is accomplished like this:
>
>     while (<>) {
>         chomp;
>         # stitch together incomplete lines (those ending with "\")
>         while (s/\\$//) {
>             $_ .= readline;
>             chomp;
>         }
>         # detect unportable/undesirable shell constructs
>         ...
>     }
>
> Although this implementation is well supported in reasonably modern Perl
> versions (5.10 and later), it fails in a couple ways with older versions
> (such as Perl 5.8 shipped with ancient Mac OS 10.5).
>
> In particular, in older Perl versions, 'readline' is not connected to
> the file handle associated with the "magic" while (<>) {...} construct,
> so 'readline' throws a "readline() on unopened filehandle" error.
> Furthermore, $_ assigned by the outer while-loop is read-only, so the
> attempt to modify it via "$_ .= readline" in the inner while-loop fails
> with a "Modification of a read-only value" error.
>
> Avoid both problems by collecting the stitched-together line in a
> variable other than $_ and dropping the inner loop entirely.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/check-non-portable-shell.pl | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
> index 166d64d4a2..60e607ba42 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -27,14 +27,14 @@ sub err {
>  	close $f;
>  }
>
> +my $line = '';
>  while (<>) {
>  	chomp;
> +	$line .= $_;
>  	# stitch together incomplete lines (those ending with "\")
> -	while (s/\\$//) {
> -		$_ .= readline;
> -		chomp;
> -	}
> +	next if $line =~ s/\\$//;
>
> +	local $_ = $line;
>  	/\bcp\s+-a/ and err 'cp -a is not portable';
>  	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
>  	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
> @@ -48,6 +48,7 @@ sub err {
>  	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
>  	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
>  		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
> +	$line = '';
>  	# this resets our $. for each file
>  	close ARGV if eof;
>  }

This fix is fine, but just for the record: There's no problem with
assigning to $_, it just throws an error about $_ *because* of the
readline() issue, i.e. it'll fail, clobber $_ to a read-only value, and
off we go.

So just assigning to $_ is fine, and you don't need to localize it.

Anyway, I tested this on 5.8, it works, then looked at the output and
wondered if I could improve it, came up with this:

    diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
    index 60e607ba42..d5fd0a3050 100755
    --- a/t/check-non-portable-shell.pl
    +++ b/t/check-non-portable-shell.pl
    @@ -8,13 +8,26 @@

     my $exit_code=0;
     my %func;
    +my $start_nr = 0;
    +my $line = '';

     sub err {
     	my $msg = shift;
    -	s/^\s+//;
    -	s/\s+$//;
    -	s/\s+/ /g;
    -	print "$ARGV:$.: error: $msg: $_\n";
    +	if (/\n/) {
    +		$. = $start_nr;
    +		my ($ws) = $_ =~ /^(\s+)/;
    +		for (split /^/) {
    +			s/^\Q$ws\E//;
    +			print "$ARGV:$.: error: $msg: $_";
    +			$.++;
    +		}
    +		print "\n";
    +	} else {
    +		s/^\s+//;
    +		s/\s+$//;
    +		s/\s+/ /g;
    +		print "$ARGV:$.: error: $msg: $_\n";
    +	}
     	$exit_code = 1;
     }

    @@ -27,14 +40,16 @@ sub err {
     	close $f;
     }

    -my $line = '';
     while (<>) {
     	chomp;
    -	$line .= $_;
     	# stitch together incomplete lines (those ending with "\")
    -	next if $line =~ s/\\$//;
    -
    -	local $_ = $line;
    +	if (s/\\$//) {
    +		$start_nr ||= $.;
    +		$line .= "$_\n";
    +		next;
    +	} else {
    +		$_ = $line . $_;
    +	}
     	/\bcp\s+-a/ and err 'cp -a is not portable';
     	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
     	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
    @@ -48,7 +63,11 @@ sub err {
     	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
     	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
     		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
    +
    +	# No longer spanning lines
    +	$start_nr = 0;
     	$line = '';
    +
     	# this resets our $. for each file
     	close ARGV if eof;
     }
    diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
    index c03054c538..b4af7032ad 100755
    --- a/t/t0000-basic.sh
    +++ b/t/t0000-basic.sh
    @@ -156,8 +156,11 @@ test_expect_success 'pretend we have a fully passing test suite' "
     "

     test_expect_success 'pretend we have a partially passing test suite' "
    -	test_must_fail run_sub_test_lib_test \
    -		partial-pass '2/3 tests passing' <<-\\EOF &&
    +	test_must_fail penis run_sub_test_lib_test \
    +		partial-pass '2/3 tests passing' <<-\\EOF \
    +		partial-pass '2/3 tests passing' <<-\\EOF \
    +		partial-pass '2/3 tests passing' <<-\\EOF \
    +		cp -a hi there &&
     	test_expect_success 'passing test #1' 'true'
     	test_expect_success 'failing test #2' 'false'
     	test_expect_success 'passing test #3' 'true'
    diff --git a/t/t0001-init.sh b/t/t0001-init.sh
    index 1f462204ea..a25ac208e5 100755
    --- a/t/t0001-init.sh
    +++ b/t/t0001-init.sh
    @@ -122,6 +122,7 @@ test_expect_success 'plain bare with GIT_WORK_TREE' '

     test_expect_success 'GIT_DIR bare' '
     	mkdir git-dir-bare.git &&
    +	cp -a foo bar &&
     	GIT_DIR=git-dir-bare.git git init &&
     	check_config git-dir-bare.git true unset
     '

I.e. now for these multi-line issues we'll print the whole offending
multi-line invocation

    $ ~/g/perl/miniperl -I ~/g/perl/lib check-non-portable-shell.pl t[0-9]*.sh
    t0000-basic.sh:159: error: cp -a is not portable: test_must_fail penis run_sub_test_lib_test
    t0000-basic.sh:160: error: cp -a is not portable:       partial-pass '2/3 tests passing' <<-\\EOF
    t0000-basic.sh:161: error: cp -a is not portable:       partial-pass '2/3 tests passing' <<-\\EOF
    t0000-basic.sh:162: error: cp -a is not portable:       partial-pass '2/3 tests passing' <<-\\EOF
    t0000-basic.sh:163: error: cp -a is not portable:       cp -a hi there &&
    t0001-init.sh:125: error: cp -a is not portable: cp -a foo bar &&

I figured it was better than the current output just squashing such a
long line together, i.e. it'll print this now (before/after this patch):

    $ ~/g/perl/miniperl -I ~/g/perl/lib check-non-portable-shell.pl t[0-9]*.sh
    t0000-basic.sh:163: error: cp -a is not portable: test_must_fail penis run_sub_test_lib_test partial-pass '2/3 tests passing' <<-\\EOF partial-pass '2/3 tests passing' <<-\\EOF partial-pass '2/3 tests passing' <<-\\EOF cp -a hi there &&
    t0001-init.sh:125: error: cp -a is not portable: cp -a foo bar &&

There's ways to make that WIP patch shorter etc. I wasn't trying to golf
it, also I think we can get rid of that s/\s+$// if we split up lines
like this.
