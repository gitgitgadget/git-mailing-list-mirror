Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 265DD1F453
	for <e@80x24.org>; Fri,  5 Oct 2018 08:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeJEPR3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 11:17:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36572 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeJEPR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 11:17:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so1041021wmf.1
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 01:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=oZ1RBH0YF5C1Xf0e3lNrGlbBZ0x3Lg6VrxMJCqkVrPU=;
        b=kmYcyUv9JTD5OJUdP9+jBQXsxTekFo1EwfdjrF7wKEJAHye5zIcmU/OdGDuktemLsi
         yZvyEHozsPt1QRcqz8KYpbXn5KE1+QW8CH1vfADp8JwGicXWjPwqZwJpu7J5KP90g/wV
         /7+0E5F5qKGddsSItGsUXTei+3NR3XLYPZIbaLsOakgZ4f1gHpuV8+lzH6nSc2/tsR7/
         nk65yzl6YDbwBpOjoz7hIPd8z89yjUCr4buzjHekU1CkSWns0FT3PGNxLVpRp+rTh42z
         PW9TPHyFu4RFWktNV8IDA+5A4NXZTUlkPXHWeREwuSMgChuQxFftz7+CQKpE0yJGd0s5
         aBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=oZ1RBH0YF5C1Xf0e3lNrGlbBZ0x3Lg6VrxMJCqkVrPU=;
        b=ptRAuAiyHdER1oexKHH2fMvyTCy7EMhOeLKMyurB2AVHh4QGuEBN3y6/m47AQIgyT6
         zDJLuxrsOfeZk891uLWoZtKz5JFnuo+YIoWGDZM/nEkrxPMGfCRIbTjHg3fr6upvxGED
         UIM9YDgpm+/5qn3NTdH8y+T2qb+jY1XnkYyB1GUeewNUK9zbDF7ICkANVeynRXm97msf
         8KJlyQzSYdwS1HiK9g6T6K+ScsOVShW+IMHwNvR7PhtfOUq7Z9rth/ML1Dzafcu/atGH
         UWQGFGkuU9li6n4yDygwEkSOqvWgf2Kb9B32UKDzPeZ1VVtbSwTDZ+jujqiZN82mny4i
         HBHg==
X-Gm-Message-State: ABuFfog9CvbGjcsGFDdFos+Jv1u7gEFHdImY3fUpQCpzSYZtROtZkoC9
        SabDcDd1qELU7iVgH9SdRxY=
X-Google-Smtp-Source: ACcGV62egafugC51SZh22AS/7diegJXekESVrRbfdMqSiRp2+XCHzi87f3ndhMUvp7KGdutWpETYwQ==
X-Received: by 2002:a1c:d4b:: with SMTP id 72-v6mr7547120wmn.102.1538727589738;
        Fri, 05 Oct 2018 01:19:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o14-v6sm4101761wrp.57.2018.10.05.01.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 01:19:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/3] help: redirect to aliased commands for "git cmd --help"
References: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
        <20181003114242.9858-1-rv@rasmusvillemoes.dk>
        <20181003114242.9858-2-rv@rasmusvillemoes.dk>
Date:   Fri, 05 Oct 2018 01:19:48 -0700
Message-ID: <xmqq8t3czty3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> As discussed in the thread for v1 of this patch [1] [2], this changes the
> rules for "git foo --help" when foo is an alias.
>
> (0) When invoked as "git help foo", we continue to print the "foo is
> aliased to bar" message and nothing else.
>
> (1) If foo is an alias for a shell command, print "foo is aliased to
> !bar" as usual.
>
> (2) Otherwise, break the alias string into words, and pretend that "git
> word0 --help" was called.
>
> At least for me, getting the man page for git-cherry-pick directly with
> "git cp --help" is more useful (and how I expect an alias to behave)
> than the short "is aliased to" notice. It is also consistent with
> "--help" generally providing more comprehensive help than "-h".
>
> I believe that printing the "is aliased to" message also in case (2) has
> value: Depending on pager setup, or if the user has help.format=web, the
> message is still present immediately above the prompt when the user
> quits the pager/returns to the terminal. That serves as an explanation
> for why one was redirected to "man git-cherry-pick" from "git cp
> --help", and if cp is actually 'cherry-pick -n', it reminds the user
> that using cp has some flag implicitly set before firing off the next
> command.
>
> It also provides some useful info in case we end up erroring out, either
> in the "bad alias string" check, or in the "No manual entry for gitbar"
> case.

These two paragraphs were misleading, because they sounded as if you
were lamenting that you were somehow forbidden from doing so even
though you believe doing it is the right thing.

But that is not what is happening.  I think we should update the (2)
above to mention what you actually do in the code, perhaps like so:

    (2) Otherwise, show "foo is aliased to bar" to the standard
        error stream, and then break the alias string into words and
        pretend as if "git word[0] --help" were called.  The former
        is necessary to help users when 'foo' is aliased to a
        command with an option (e.g. "[alias] cp = cherry-pick -n"),
        and hopefully remain visible when help.format=web is used,
        "git bar --help" errors out, or the manpage of "git bar" is
        short enough. It may not help if the help shows manpage on
        the terminal as usual, though.

As we explain why we show the alias information before going to the
manpage in the item itself and a brief discussion of pros-and-cons,
we can safely lose the "I believe..."  paragraph, which looks
somewhat out of place in a log message.

It also is strange to count from (0); if the patchset is rerolled
again, I'd prefer to see these start counting from (1), in which
case this item will become (3).

> [1] https://public-inbox.org/git/20180926102636.30691-1-rv@rasmusvillemoes.dk/
> [2] https://public-inbox.org/git/20180926184914.GC30680@sigill.intra.peff.net/
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> ---
>  builtin/help.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 8d4f6dd301..e0e3fe62e9 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -415,9 +415,37 @@ static const char *check_git_cmd(const char* cmd)
>  
>  	alias = alias_lookup(cmd);
>  	if (alias) {
> -		printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
> -		free(alias);
> -		exit(0);
> +		const char **argv;
> +		int count;
> +
> +		/*
> +		 * handle_builtin() in git.c rewrites "git cmd --help"
> +		 * to "git help --exclude-guides cmd", so we can use
> +		 * exclude_guides to distinguish "git cmd --help" from
> +		 * "git help cmd". In the latter case, or if cmd is an
> +		 * alias for a shell command, just print the alias
> +		 * definition.
> +		 */
> +		if (!exclude_guides || alias[0] == '!') {
> +			printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
> +			free(alias);
> +			exit(0);
> +		}
> +		/*
> +		 * Otherwise, we pretend that the command was "git
> +		 * word0 --help". We use split_cmdline() to get the
> +		 * first word of the alias, to ensure that we use the
> +		 * same rules as when the alias is actually
> +		 * used. split_cmdline() modifies alias in-place.
> +		 */
> +		fprintf_ln(stderr, _("'%s' is aliased to '%s'"), cmd, alias);
> +		count = split_cmdline(alias, &argv);
> +		if (count < 0)
> +			die(_("bad alias.%s string: %s"), cmd,
> +			    split_cmdline_strerror(count));
> +		free(argv);
> +		UNLEAK(alias);
> +		return alias;
>  	}
>  
>  	if (exclude_guides)
