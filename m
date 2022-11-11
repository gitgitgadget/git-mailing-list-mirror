Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9149C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 15:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiKKPGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 10:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiKKPFP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 10:05:15 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E6C73405
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 07:02:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k2so13203748ejr.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 07:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OWVRfEH++cn0n0iwawtj51QkMTdvs+jJSfz60wJM07k=;
        b=AFot3yLSk5n/A9XyX8N7gHKCCo+l7SNNOMdyjxrtEx6lZSD2rC+2w8KQOAg7R+n/an
         ALmt+OJuhEXDH3u/O6P6pPf095qm6ovbqPz5V/0kWjoUiLqQs8EIx5zho4il9H5J0+sV
         Bp8BocpBwjPBTe1K6981EE/czrj8CaJbFhQI/pRT7P60TIHeK2TUSqBauC4fiIqC5lUD
         9gPYbleNL4wjW6oupnU54EprlSlstbLg3kp+W1IsKLMJhk9iWIUymwEmLDomD6ExkVXi
         6t/5gDKkRLc407CHaMsS+1hB9qLxBO+ECam+nZQbkawl6Dh/LIQykU8Ju8COzhshgZMb
         i99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWVRfEH++cn0n0iwawtj51QkMTdvs+jJSfz60wJM07k=;
        b=gUgDupevvZ678JzQ3BK6pEhc8856zIjSUtPMjwicGld+z7ktm6edi7FU/hJqgJRtiM
         nhzGSBdsI7fh8HfNR+FXUO+dqz3sVKNDNZJUsRwleF7PDbe0wpSltcFwbZ1o9QlAAuoS
         A1zQIwlO2+8YUzHYlJXqcsLNqZ3rYx9rjC0ecHeY8Qd8HpjZdrjl9Ft4WY1QnLsLQ47D
         5Diq9iwxdgqdzYRNeYWJZiqmuvRCYT8jvcf6o/zreP7uhQtKmuWxbcJuLO7ZVooJJk1l
         lJ6rVUghrwLKg5FWyfL9ycf+8cKM4XaASZNsUi116SqdzS7hMJYSOt4BUdjhXHsG2meu
         Qtvg==
X-Gm-Message-State: ANoB5pnV3ELoAMHw0bcTn4d6c5eBqpRv7ddfQFJ9yyndopHkZjFfiLqm
        xgYK2KqiUxoz95uVn5b1MsM=
X-Google-Smtp-Source: AA0mqf6yIQmXmDepgMNycOeftI9TLHuvFg8cwOhDhOvKCWLnlViSzREMs6tT7vr/mU1SOUwsgDWKWQ==
X-Received: by 2002:a17:906:94d9:b0:7ac:a2b7:6c97 with SMTP id d25-20020a17090694d900b007aca2b76c97mr2019140ejy.497.1668178949524;
        Fri, 11 Nov 2022 07:02:29 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709061bb200b0077d37a5d401sm981724ejg.33.2022.11.11.07.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 07:02:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otVY4-001wey-09;
        Fri, 11 Nov 2022 16:02:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/3] chainlint: sidestep impoverished macOS "terminfo"
Date:   Fri, 11 Nov 2022 15:55:15 +0100
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
 <pull.1413.v2.git.1668152094.gitgitgadget@gmail.com>
 <de482cf9cf1c791418e4279523123580f330245b.1668152094.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <de482cf9cf1c791418e4279523123580f330245b.1668152094.git.gitgitgadget@gmail.com>
Message-ID: <221111.865yflo7p7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 11 2022, Eric Sunshine via GitGitGadget wrote:

> From: Eric Sunshine <sunshine@sunshineco.com>
>
> Although the macOS Terminal.app is "xterm"-compatible, its corresponding
> "terminfo" entries -- such as "xterm", "xterm-256color", and
> "xterm-new"[1] -- neglect to mention capabilities which Terminal.app
> actually supports (such as "dim text"). This oversight on Apple's part
> ends up penalizing users of "good citizen" console programs which
> consult "terminfo" to tailor their output based upon reported terminal
> capabilities (as opposed to programs which assume that the terminal
> supports ANSI codes). The same problem is present in other Apple
> "terminfo" entries, such as "nsterm"[2], with which macOS Terminal.app
> may be configured.
>
> Sidestep this Apple problem by imbuing get_colors() with specific
> knowledge of capabilities common to "xterm" and "nsterm", rather than
> trusting "terminfo" to report them correctly. Although hard-coding such
> knowledge is ugly, "xterm" support is nearly ubiquitous these days, and
> Git itself sets precedence by assuming support for ANSI color codes. For
> other terminal types, fall back to querying "terminfo" via `tput` as
> usual.
>
> FOOTNOTES
>
> [1] iTerm2 FAQ suggests "xterm-new": https://iterm2.com/faq.html
>
> [2] Neovim documentation recommends terminal type "nsterm" with
>     Terminal.app: https://neovim.io/doc/user/term.html#terminfo
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/chainlint.pl | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/t/chainlint.pl b/t/chainlint.pl
> index 7972c5bbe6f..0ee5cc36437 100755
> --- a/t/chainlint.pl
> +++ b/t/chainlint.pl
> @@ -653,21 +653,32 @@ my @NOCOLORS = (bold => '', rev => '', reset => '', blue => '', green => '', red
>  my %COLORS = ();
>  sub get_colors {
>  	return \%COLORS if %COLORS;
> -	if (exists($ENV{NO_COLOR}) ||
> -	    system("tput sgr0 >/dev/null 2>&1") != 0 ||
> -	    system("tput bold >/dev/null 2>&1") != 0 ||
> -	    system("tput rev  >/dev/null 2>&1") != 0 ||
> -	    system("tput setaf 1 >/dev/null 2>&1") != 0) {
> +	if (exists($ENV{NO_COLOR})) {
>  		%COLORS = @NOCOLORS;
>  		return \%COLORS;
>  	}
> -	%COLORS = (bold  => `tput bold`,
> -		   rev   => `tput rev`,
> -		   reset => `tput sgr0`,
> -		   blue  => `tput setaf 4`,
> -		   green => `tput setaf 2`,
> -		   red   => `tput setaf 1`);
> -	chomp(%COLORS);
> +	if ($ENV{TERM} =~ /xterm|xterm-\d+color|xterm-new|xterm-direct|nsterm|nsterm-\d+color|nsterm-direct/) {
> +		%COLORS = (bold  => "\e[1m",
> +			   rev   => "\e[7m",
> +			   reset => "\e[0m",
> +			   blue  => "\e[34m",
> +			   green => "\e[32m",
> +			   red   => "\e[31m");
> +		return \%COLORS;
> +	}
> +	if (system("tput sgr0 >/dev/null 2>&1") == 0 &&
> +	    system("tput bold >/dev/null 2>&1") == 0 &&
> +	    system("tput rev  >/dev/null 2>&1") == 0 &&
> +	    system("tput setaf 1 >/dev/null 2>&1") == 0) {
> +		%COLORS = (bold  => `tput bold`,
> +			   rev   => `tput rev`,
> +			   reset => `tput sgr0`,
> +			   blue  => `tput setaf 4`,
> +			   green => `tput setaf 2`,
> +			   red   => `tput setaf 1`);
> +		return \%COLORS;
> +	}
> +	%COLORS = @NOCOLORS;
>  	return \%COLORS;
>  }

Doesn't test-lib.sh have the same problem then?

This is somewhat of an aside, as we're hardcoding thees colors in
t/chainlint.pl now, but I wondered when that was added (but I don't
think I commented then) why it needed to be re-hardcoding the coloring
we've got in test-lib.sh.

I.e. if test-lib.sh is running it could we handle these cases, and just
export a variable with the color info for "bold" or whatever in
GIT_TEST_COLOR_BOLD, then pick that up?

I have a local semi-related patch which made much the same change to
test-lib.sh itself, to support --color without going through whether
tput thinks we support colors:
https://github.com/avar/git/commit/c4914db758b

I think this is fine for now if you don't want to poke more at it, but
maybe this should all be eventually combined?

I also wonder to what extent this needs to be re-inventing
Term::ANSIColor, which has shipped with Perl since 5.6, so we can use it
without worrying about version compat, but that's another topic...
