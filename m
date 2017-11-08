Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459AA1F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 02:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbdKHCdR (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 21:33:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54145 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750830AbdKHCdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 21:33:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDF2EB0BE5;
        Tue,  7 Nov 2017 21:33:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s5g/HLq8iLIqbSL0txKjRSVnBQA=; b=EQQ8KB
        bRTuNR6jQ7Shu8X4BOdWfhmm7xUgQjWECABXzWe5Jg0FolLaUREZ5QY4s4Unnfjy
        KQoeg12JmTamstZAA6GZCTxIn7TskIf3pphjhqEae4ZS8VGFy6HVV4AtGdBwg5vi
        musSA0MZyJbKeyuCgk2d8BDBlFyFyYpj43WRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kF30GHRo+9nfTvp16B/rVDlLc8XpwPkS
        CswnrObh2wMokReyLdIyVDnadVch8HSGf5SZZaRN+dEw6Q5H+O6cex1MvJI/Ru6x
        smBS97jCV04nf5bf3ul+EjPpC8YZmp0OJ55j+w1TTUMaHAfd9h66dwTN0Xl0CiOn
        YYknXdG3TBo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C52DBB0BE3;
        Tue,  7 Nov 2017 21:33:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3209EB0BE2;
        Tue,  7 Nov 2017 21:33:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Rothman <max.r.rothman@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: add missing completions for log, diff, show
References: <CAGZ79kYKfZC1CzoGE_6G1b2vD+MCw1_rY7J_LeWyT8rp6CAuDw@mail.gmail.com>
        <0102015f985d387e-f50183c4-4b49-4a9f-b365-2a86ba24bbed-000000@eu-west-1.amazonses.com>
Date:   Wed, 08 Nov 2017 11:33:13 +0900
In-Reply-To: <0102015f985d387e-f50183c4-4b49-4a9f-b365-2a86ba24bbed-000000@eu-west-1.amazonses.com>
        (Max Rothman's message of "Tue, 7 Nov 2017 21:22:47 +0000")
Message-ID: <xmqq7ev1mrdi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C32E248-C42D-11E7-8C53-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Rothman <max.r.rothman@gmail.com> writes:

> From: Max Rothman <max-rothman@pluralsight.com>

Thanks.

>
> Teach git-log tab completion about the --no-* options for ease of use
> at the command line.
>
> Similarly, teach git-show tab completion about the --no-abbrev-commit,
> --expand-tabs, and --no-expand-tabs options.
>
> Also, teach git-diff (and all commands that use its options) tab
> completion about the --textconv and --indent-heuristic families of
> options. --indent-heuristic is no longer experimental, so there's no
> reason it should be left out of tab completion any more, and textconv
> seems to have simply been missed.

A couple of things that I found questionable in the above
descriptions are:

 * We do not write git subcommand names like git-foo these days, as
   nobody type them like so.

 * The patch is not teaching git-foo about completing its options.
   It teaches the bash completion about options for git subcommands
   it did not know about.

So perhaps

	The bash completion script knows some options to the "git
	log" only in the positive form (e.g. "--abbrev-commit") but
	not in their negated form (e.g. "--no-abbrev-commit").  Add
	them.

and similar?

> ---

Missed sign-off?

> @@ -1759,16 +1765,19 @@ _git_log ()
> ...
> -			--decorate --decorate=
> +			--decorate --decorate= --no-decorate
> ...
> @@ -2816,8 +2825,9 @@ _git_show ()
>  		return
>  		;;
>  	--*)
> -		__gitcomp "--pretty= --format= --abbrev-commit --oneline
> -			--show-signature
> +		__gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
> +			--oneline --show-signature --patch
> +			--expand-tabs --expand-tabs= --no-expand-tabs
>  			$__git_diff_common_options
>  			"
>  		return

It's a bit sad that the completion support does not know that "git
show" belongs to the "git log" family of commands.  A consequence of
this is that "git show --no-decorate" is perfectly acceptable but
needs to be taught separately to _git_show if we wanted to.

Perhaps some selected options _git_log understands may need to be
split $__git_log_ui_common_options [*1*], like we do for "git diff"
family with $__git_diff_common_options, and shared between _git_log
and _git_show.

I am mentioning this primarily as #leftoverbits and I do not want to
see such a change mixed into this patch, as it is totally outside
the scope of it.  It is (if you are inclined to do so) OK to make
this into two patch series, with 1/2 doing such a refactoring
without changing any externally visible functionality (i.e. just
move the ones _git_show knows about to $__git_log_ui_common_options,
and have _git_show and _git_log use it), and 2/2 adding more options
to that list to achieve what you wanted to do with this patch, though.

Thanks.


[Footnote]

*1* $__git_log_common_options is taken and it is about options
    common to "log/shortlog/gitk" but contains some that are not
    relevant to "git show", and that is why I am suggesting a
    separate and new variable.


