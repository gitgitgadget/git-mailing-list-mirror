Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7B91F462
	for <e@80x24.org>; Tue, 30 Jul 2019 11:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfG3Lyn (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 07:54:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45146 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbfG3Lym (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 07:54:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id x19so56373758eda.12
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 04:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=N1rSNbkn//Q/e+Y5eARwO1vmjWWnHz1+Tco/6g2LUxc=;
        b=KKtnAr2D76fH7Lde2SYSQbJmhxNwZCKQWlXDURA4OwRQ+3747zt7r0N/976NaVEvT9
         huGr7GHH8t70yhLu9/Mx2dsjguAVRgJY+/0qa2qCmKWpN2pt+z6r9LudpN0o5oXJ5Puk
         hGvFwJxJqdw8tCSnBmSsC+T2T9BNuKrR1PsndHyhrNwYJUW9TOgqjM3aS+Evt5v4n4Av
         0epaRvl3HehjR91en5WfM/OR1ajKhcWUYH0p6lKkApo2FlZYnu5h1dSzKZiPn4yEXCP+
         lcwyFi9Le3Kzg7iRiKtBCigcnK20xWk+pe+7818MGlOuCcI2SjZdtaS2wsYw5Ss0QF8X
         4DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=N1rSNbkn//Q/e+Y5eARwO1vmjWWnHz1+Tco/6g2LUxc=;
        b=q+UCNy6PvWErT8COOuWuOWYdrmmf7DbCWngd7zaLVL9+Ht0VUAnCwdGDdhh0a0hw6u
         yuuC3gJXcgtIEA9pLxyLihIULBmlCOavXLhBibmQIbaPUbVrtNW2J6piH0OhX4h16FBs
         /AO4Im3rq6m8mCsHZi2BvnPasuCk0EHXbDxHldEk3DKler+hVmhVdDQO7ZG+cta4OvDr
         kSGALfH0JqHEaJiXr66AClpo5s+aXgfwr4Lq9yd8HbhOT7K+trlKdBKdD0BsKWYTLJul
         24WYD23ih1EVoT/5hgsyftz4M/7vC7JmfqhwnmumKmwnYe3DnwNPrKK9VZGO5dOPSPDG
         Okfg==
X-Gm-Message-State: APjAAAXTvsCsxHKJZtshMe4eQuJIrMGSIttsyeuwd80MKv2buEKSHgsA
        4tw9o/auUPOmAIYEq8mpVVE=
X-Google-Smtp-Source: APXvYqzsC7wGt7WtCkBboO10flyQtsUr8mhw4wFIDVKd4dV5N4V2TRuOq3JALdhy31mC1SyR4v3/OQ==
X-Received: by 2002:a17:906:8409:: with SMTP id n9mr87884034ejx.128.1564487680764;
        Tue, 30 Jul 2019 04:54:40 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id nc6sm11941640ejb.62.2019.07.30.04.54.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 04:54:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: Re: [PATCH] send-email: Ask if a patch should be sent twice
References: <20190730001352.7477-1-dima@arista.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190730001352.7477-1-dima@arista.com>
Date:   Tue, 30 Jul 2019 13:54:39 +0200
Message-ID: <87r26768lc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 30 2019, Dmitry Safonov wrote:

> I was almost certain that git won't let me send the same patch twice,
> but today I've managed to double-send a directory by a mistake:
> 	git send-email --to linux-kernel@vger.kernel.org /tmp/timens/
> 	    --cc 'Dmitry Safonov <0x7f454c46@gmail.com>' /tmp/timens/`
>
> [I haven't noticed that I put the directory twice ^^]
>
> Prevent this shipwreck from happening again by asking if a patch
> is sent multiple times on purpose.
>
> link: https://lkml.kernel.org/r/4d53ebc7-d5b2-346e-c383-606401d19d3a@gmail.com
> Cc: Andrei Vagin <avagin@openvz.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  git-send-email.perl | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

There's tests for send-email in t/t9001-send-email.sh. See if what
you're adding can have a test added, seems simple enough in this case.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5f92c89c1c1b..0caafc104478 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -33,6 +33,7 @@
>  use Net::Domain ();
>  use Net::SMTP ();
>  use Git::LoadCPAN::Mail::Address;
> +use experimental 'smartmatch';

We depend on Perl 5.8, this bumps the requirenment to 5.10. Aside from
that ~~ is its own can of worms in Perl and is best avoided.

>  Getopt::Long::Configure qw/ pass_through /;
>
> @@ -658,6 +659,17 @@ sub is_format_patch_arg {
>  	}
>  }
>
> +sub send_file_twice {
> +	my $f = shift;
> +	$_ = ask(__("Patch $f will be sent twice, continue? [y]/n "),

These cases with a default should have "Y/n", not "y/n". See other
expamples in the file.

> +		default => "y",
> +		valid_re => qr/^(?:yes|y|no|n)/i);
> +	if (/^n/i) {
> +		cleanup_compose_files();
> +		exit(0);

Exit if we have just one of these? More on that later...

> +	}
> +}
> +
>  # Now that all the defaults are set, process the rest of the command line
>  # arguments and collect up the files that need to be processed.
>  my @rev_list_opts;
> @@ -669,10 +681,19 @@ sub is_format_patch_arg {
>  		opendir my $dh, $f
>  			or die sprintf(__("Failed to opendir %s: %s"), $f, $!);
>
> -		push @files, grep { -f $_ } map { catfile($f, $_) }
> +		my @new_files = grep { -f $_ } map { catfile($f, $_) }
>  				sort readdir $dh;
> +		foreach my $nfile (@new_files) {
> +			if ($nfile ~~ @files) {
> +				send_file_twice($nfile);
> +			}

One non-smartmatch idiom for this is:

    my %seen;
    for my $file (@files) {
        if ($seen{$file}++) { ...}
    }

Or:

    my %seen;
    my @dupes = grep { $seen{$_}++ } @files;

> +		}
> +		push @files, @new_files;
>  		closedir $dh;
>  	} elsif ((-f $f or -p $f) and !is_format_patch_arg($f)) {
> +		if ($f ~~ @files) {
> +			send_file_twice($f);
> +		}
>  		push @files, $f;

...but picking up the comment above, I'd expect this to be in the "if
($validate)" block below or something similar, seems like this fits
right in with --validate.

Then you can also ask "do you want to send this set of patches twice
<full list>?".

Now the user is asked a file-at-a-time.

>  	} else {
>  		push @rev_list_opts, $f;
