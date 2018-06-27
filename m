Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF7A61F516
	for <e@80x24.org>; Wed, 27 Jun 2018 16:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754973AbeF0QkN (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 12:40:13 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51336 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754017AbeF0QkM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 12:40:12 -0400
Received: by mail-wm0-f48.google.com with SMTP id w137-v6so6591962wmw.1
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=soCVPVs7o7jsrT9+L9Z93i4Wuh8yfABPfVhPku9K3II=;
        b=pORVnN2QdvQAtu6Utvn7sV5ZT3oyCbKkFa4ADdqkoixg+KYEegUjZTyL7LdGx+eEbo
         Bf8R2wYgLu1rZx/RfuJItHFw5DgHdCovEzl8ts5Mb2n9qG6jP2EW+1ZhvdcMFnmUvW/b
         3LlvP15+MXxpvtdD6YfqiTJF+nfT7dXUD+ctyYtBGOp3lHc8am5nNUVsx3U4EHpkUNAb
         DvXPrX85RVs2cO6GYVHqLNpTEFLFoz/NTVYU75bwAUU0wwFUfmHRi9TFciJR22QBd4JK
         3YUCGMNf0IwdsWkKs2q5BlsBWIEACT8Uk1m1y3oHA22VIMceO78vYe2noxCSzVCBNKlL
         Qf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=soCVPVs7o7jsrT9+L9Z93i4Wuh8yfABPfVhPku9K3II=;
        b=uewUr+Wa7bpOIcT9MhEfrCjJStIKtqHEha1FDLR0hNG8erACFO55t13leJG8Vj1FZY
         L1XW/fUDezxjGErEcwizjSmYU1FSwxUEOHA3p7OCaFNAfApzy/+6C4VscHR6TE8oMTe4
         16KnfljBGF7ECyaHoZjfXEQzL9mr4NjOwzJgGeF36pXpqyhLgrtHM+En8cytFeVxRWiy
         u9lzeKj77Vnfib2pZJWNyvAV9Q35xZjEjfqheb6545Es4D0QF5PCuxfka4K1LJpZQi5Q
         itoMSsV7o1hhqXOSN2NLUn4Knm10qqIGyBMLIMUxwayrYdfzgqLk9cf1KuSBaN+bs8y8
         iOnA==
X-Gm-Message-State: APt69E3rLxXLUTetWjt8Je38WHAGLspdJ+vYBDYkF9lbM+9SNFbYozcf
        qDw/bRsinBuAyMTv3BONfdQ=
X-Google-Smtp-Source: AAOMgpfwnnA0kYirEbem2/XYX+H3d6KFE1YlSJ+VPvVGFFJhUp5nDzh3U/4MTrqJyqK8JRVNTIvg0w==
X-Received: by 2002:a1c:497:: with SMTP id 145-v6mr2266647wme.157.1530117611377;
        Wed, 27 Jun 2018 09:40:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q70-v6sm7372402wmd.45.2018.06.27.09.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 09:40:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/2] grep.c: teach 'git grep --only-matching'
References: <cover.1529961706.git.me@ttaylorr.com>
        <f156bd7c897359926ec407e805ecb0630a8b12da.1529961706.git.me@ttaylorr.com>
Date:   Wed, 27 Jun 2018 09:40:10 -0700
In-Reply-To: <f156bd7c897359926ec407e805ecb0630a8b12da.1529961706.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 25 Jun 2018 16:26:00 -0500")
Message-ID: <xmqqsh58gp3p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> -		if (sign == ':')
> -			match_color = opt->color_match_selected;
> -		else
> -			match_color = opt->color_match_context;
> -		if (sign == ':')
> -			line_color = opt->color_selected;
> -		else if (sign == '-')
> -			line_color = opt->color_context;
> -		else if (sign == '=')
> -			line_color = opt->color_function;
> +		if (opt->color) {
> +			if (sign == ':')
> +				match_color = opt->color_match_selected;
> +			else
> +				match_color = opt->color_match_context;
> +			if (sign == ':')
> +				line_color = opt->color_selected;
> +			else if (sign == '-')
> +				line_color = opt->color_context;
> +			else if (sign == '=')
> +				line_color = opt->color_function;
> +		}

The above change (specifically, the fact that this now is enclosed
in "if (opt->color) { ... }") unfortunately leaves match_color
undefined at this point in the control flow.  The next loop then
calls output_color() with an undefined match_color and tricks stupid
compiler to issue a warning and makes -Werror build to fail.

>  		*eol = '\0';
>  		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
>  			if (match.rm_so == match.rm_eo)
>  				break;
>
> -			output_color(opt, bol, match.rm_so, line_color);
> +			if (opt->only_matching)
> +				show_line_header(opt, name, lno, cno, sign);
> +			else
> +				output_color(opt, bol, match.rm_so, line_color);
>  			output_color(opt, bol + match.rm_so,
>  				     match.rm_eo - match.rm_so, match_color);

output_color() does check want_color(opt->color) before using its
last parameter, and want_color() gives false for opt->color that is
0 (i.e. leaves match_color to be undefined), so in this case, the
compiler is worried too much, but still, we should work it around if
it is easy to do so.

Just initializing match_color where it is defined at the beginning of
show_line() should be sufficient, I think.

