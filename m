Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1C4720989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbcJJSwT (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:52:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54139 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750830AbcJJSwT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:52:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 851E7442DD;
        Mon, 10 Oct 2016 14:52:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NRiRBARwV4kO6c6uEl1c/CB2Phk=; b=JOl/ky
        yMmc3plDF1p4kowffeah2kKJ5/d+KCsEG7J2nrzebuK/WCqNP7zN9MdSwaY2S/XD
        X8J08FswVxgqqEJsdUg4PcRrNjtiJ298JGV78dlilM5cw89fTVgmYzjJk/GkA3Cj
        Rfxj5ZE8/g8paJPzS+w7Q9LwqiZ5jXeV/14JU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CqwXReSjhTbUmYlbH3tmGxOX3XDhcDqw
        7i8YE2UuMwvGK6YUL/h/8MhXU1TKb/6BLNltBXrTpGj4rJ+7WNusEy1CRQyO1rWP
        GzsB2jJJGCpbuhjacAfYu17qtLMCS9nrm/I+ahtEFrC8TmMK4O8Qj6z02zotMgmR
        fsf2wBkm7Fk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79EC3442DC;
        Mon, 10 Oct 2016 14:52:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E18E3442DB;
        Mon, 10 Oct 2016 14:52:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>
Subject: Re: [PATCH] pretty: respect color settings for %C placeholders
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
        <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
        <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
        <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
        <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
        <CACsJy8CroyynVMctbPhuVr2VVQB7YyfcxDaMT25BikQ4R4We0Q@mail.gmail.com>
        <20161010142818.lglwrxpks6l6aqrm@sigill.intra.peff.net>
        <20161010151517.6wszhuyp57yfncaj@sigill.intra.peff.net>
Date:   Mon, 10 Oct 2016 11:52:14 -0700
In-Reply-To: <20161010151517.6wszhuyp57yfncaj@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 10 Oct 2016 11:15:17 -0400")
Message-ID: <xmqq1szof34x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA3C75C6-8F1A-11E6-82ED-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So here's what a patch to do that would look like. I admit that "I can't
> think of a good use" does not mean there _isn't_ one, but perhaps by
> posting this, it might provoke other people to think on it, too. And if
> nobody can come up with, maybe it's a good idea.

I do not have a fundamental opposition to this approach myself,
modulo a minor nit.

> +  By default, colors are shown only when enabled for log output (by
> +  `color.diff`, `color.ui`, or `--color`, and respecting the `auto`
> +  settings of the former if we are going to a terminal). `%C(auto,...)`
> +  is accepted as a historical synonym for the default. Specifying
> +  `%C(always,...) will show the colors always, even when colors are not
> +  otherwise enabled (to enable this behavior for the whole format, use
> +  `--color=always`).

It is not just "for the whole format", but also affects other parts
of the output, no?  I am thinking about "git log -p --format=...".

> diff --git a/pretty.c b/pretty.c
> index 25efbca..73e58b5 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -965,22 +965,31 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
>  
>  		if (!end)
>  			return 0;
> -		if (skip_prefix(begin, "auto,", &begin)) {
> +
> +		if (!skip_prefix(begin, "always,", &begin)) {
>  			if (!want_color(c->pretty_ctx->color))
>  				return end - placeholder + 1;
>  		}

As a way to say "when color is not enabled, ignore everything unless
it begins with 'always,'", this was a bit hard to read.  Perhaps an
in-code comment is in order?

> +
> +		/* this is a historical noop */
> +		skip_prefix(begin, "auto,", &begin);
> +
>  		if (color_parse_mem(begin, end - begin, color) < 0)
>  			die(_("unable to parse --pretty format"));
>  		strbuf_addstr(sb, color);
>  		return end - placeholder + 1;
>  	}
> -	if (skip_prefix(placeholder + 1, "red", &rest))
> +	if (skip_prefix(placeholder + 1, "red", &rest) &&
> +	    want_color(c->pretty_ctx->color))
>  		strbuf_addstr(sb, GIT_COLOR_RED);

Hmm.  If we are in "no I do not want color" mode and "always,red"
was given, we countermanded !want_color() check up above and come
here.  Then we check want_color() again and refuse to paint it red?

I must be reading the patch incorrectly, but I cannot quite tell
where I want astray...
