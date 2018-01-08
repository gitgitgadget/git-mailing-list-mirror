Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC53D1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 19:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756342AbeAHTOF (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 14:14:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51734 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755123AbeAHTOD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 14:14:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 316D3D449A;
        Mon,  8 Jan 2018 14:14:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0lIlEHhdjASzWty4ZKbko4MS8aU=; b=s0ug+N
        CLVvrRk1KFCH9sXKJH72eeoMzUjkCkE3/K5d169t86ePkmt5vyyi2WwCBOBcgxIt
        Na9YuRKZLneRhdXF8lkPwH2d5+I+Kmn2DkOhwZGrcxc3AqlD3FMWifKRTKhB6VqS
        CW5JX3cT3848BIb89XM2julbwrfhAga7aj7TU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PWFgsoEDOImUg326yFqXvJiR/8GCm0Fh
        cr/fA3xDMrtcT4viOt+9yxPKnb5oF5DjDEAHWLIgUNF5+TgnG5U9AeOW3KIIPggV
        sLIU2u0TJFO5UT0oFgiB59Nt0Cq84eGm9ZZRV2kCIsEExjbK0uYK62MFxvfDvEyi
        iGryp7cVtt0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29C32D4499;
        Mon,  8 Jan 2018 14:14:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D5B5D4496;
        Mon,  8 Jan 2018 14:14:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org
Subject: Re: [PATCHv3 1/4] color.h: document and modernize header
References: <20171110011002.10179-1-sbeller@google.com>
        <20180104224007.214548-1-sbeller@google.com>
        <20180104224007.214548-2-sbeller@google.com>
Date:   Mon, 08 Jan 2018 11:14:00 -0800
In-Reply-To: <20180104224007.214548-2-sbeller@google.com> (Stefan Beller's
        message of "Thu, 4 Jan 2018 14:40:04 -0800")
Message-ID: <xmqqr2r088p3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 166D5898-F4A8-11E7-AAD3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  /*
> - * Set the color buffer (which must be COLOR_MAXLEN bytes)
> - * to the raw color bytes; this is useful for initializing
> - * default color variables.
> + * NEEDSWWORK: document this function or refactor grep.c to stop using this
> + * function.
>   */
> -void color_set(char *dst, const char *color_bytes);
> +extern void color_set(char *dst, const char *color_bytes);

The original that is removed by the patch documents the function
well enough; as long as the NEEDSWORK comment is followed through
in a later step in the series, it's alright, though ;-)

> -int git_config_colorbool(const char *var, const char *value);
> -int want_color(int var);
> -int color_parse(const char *value, char *dst);
> -int color_parse_mem(const char *value, int len, char *dst);
> +/*
> + * Parse a config option, which can be a boolean or one of
> + * "never", "auto", "always". Return a constant of
> + * GIT_COLOR_NEVER for "never" or negative boolean,
> + * GIT_COLOR_ALWAYS for "always" or a positive boolean,
> + * and GIT_COLOR_AUTO for "auto".
> + */
> +extern int git_config_colorbool(const char *var, const char *value);

"never" and "always" not being part of usual boolean vocabulary
makes it a bit awkward to explain.

> +/*
> + * Output the formatted string in the specified color (and then reset to normal
> + * color so subsequent output is uncolored). Omits the color encapsulation if
> + * `color` is NULL. The `color_fprintf_ln` prints a new line after resetting
> + * the color. The `color_print_strbuf` prints the given pre-formatted strbuf
> + * instead, up to its first NUL character.
> + */

Obviously, it does not have to be part of this step nor series, but
the above observation makes us realize that color_print_strbuf()
would probably be an unreasonably narrow interface.  It is not too
much to ask the caller to dereference and pass only the .buf
component of the strbuf to an alternative helper that takes "const
char *" and by doing so would allow us to let other callers that do
not have a strbuf but just a plain string use it, too.

Looks good.
