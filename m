Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271691F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 17:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390036AbeGKROV (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 13:14:21 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:45280 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390029AbeGKROV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 13:14:21 -0400
Received: by mail-wr1-f46.google.com with SMTP id c4-v6so6246940wrs.12
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fZ9MLffnHpjgHzjxCNEXMEoCljfDBz2hDqWevTwyleI=;
        b=qYSLZg527U45gwE0X9gUubor/+7+ZT1igX6iThU+I+/dEYZwxlYMTWrWXO0vuiUc7z
         RCwAastZgF2GocIMX+vf1YtQRqtSAAxSaD2E94RESLXfqG6IfzFekFIg9dPNxr1tUAE4
         uwdtsTBeGogVkTtDiWdgjJybN7cMkEr8PFQWDyI0SdqY9c3JqoTwpl6upXO5kI/qtghz
         fiED/Ew2PQyrK2iRpvePoEgtxoioOlj2yODPGvoqf5kN4rhxcPF01/pl1v5eQ3v0dOla
         3V19hUcEZkixd6+wnTZVx3pGKURsauz1AqoLHi6hGII0fSe9XMOzLq70xaYR6FpPtrYf
         htYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fZ9MLffnHpjgHzjxCNEXMEoCljfDBz2hDqWevTwyleI=;
        b=rxKS1XFU/HNBS5aLebXAfcf92h99MYujKvf+fosCsJ7oYRVtKwb9uIof679ILuqKFI
         7Db4zO6nFNJdqSUkQqwPa/Ua1pyGunAeY7Dclsx+aBObiwnnaE8W97VE981GZQXOKFPC
         StiX8SL+a9+slEqWSJBae81dKJ5kHzR9dorOCEbvGZO4RpEBLg7XRn7bwpX+UKKNdFnn
         KbBTdeHy1qr7bl6KHtb62Hy4Zh3IyrVVynuDQy3mBW3KNh3sKllOn8eq9cc4XCfMXqM3
         d4ZiSQ2qNvxT/Za3jjyzXA0/gWA8bMx0/XhE3oqkDR3NsAqdXC/5MX4eavxloB0YdktT
         6vBQ==
X-Gm-Message-State: APt69E1AfaQzhuVIG64MUB5KludwmQo+w+yJnBQ37gWL4C1eM5iURM9z
        FVpt+QPJ0FQ8EfvLjxisrilq/4lT
X-Google-Smtp-Source: AAOMgpdP9LlYpceQp0TH9Wwy0GlY6rq0iCfpfG6lbG5E8wOlI5J5vNnmKLOmx38BQdrqlipdivynhw==
X-Received: by 2002:a5d:4147:: with SMTP id c7-v6mr20772246wrq.61.1531328944307;
        Wed, 11 Jul 2018 10:09:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m17-v6sm31646669wrg.65.2018.07.11.10.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 10:09:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: Segfault on "git pull" on "bad object HEAD"
References: <87k1q2c9zq.fsf@evledraar.gmail.com>
        <20180711133402.GD23835@sigill.intra.peff.net>
Date:   Wed, 11 Jul 2018 10:09:03 -0700
In-Reply-To: <20180711133402.GD23835@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 11 Jul 2018 09:34:02 -0400")
Message-ID: <xmqqo9fd3djk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I feel like the right answer here is probably this:
>
> diff --git a/wt-status.c b/wt-status.c
> index d1c05145a4..5fcaa3d0f8 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -2340,7 +2340,16 @@ int has_uncommitted_changes(int ignore_submodules)
>  	if (ignore_submodules)
>  		rev_info.diffopt.flags.ignore_submodules = 1;
>  	rev_info.diffopt.flags.quick = 1;
> +
>  	add_head_to_pending(&rev_info);
> +	if (!rev_info.pending.nr) {
> +		/*
> +		 * We have no head (or it's corrupt), but the index is not
> +		 * unborn; declare it as uncommitted changes.
> +		 */
> +		return 1;
> +	}
> +
>  	diff_setup_done(&rev_info.diffopt);
>  	result = run_diff_index(&rev_info, 1);
>  	return diff_result_code(&rev_info.diffopt, result);
>
> That does quietly paper over the corruption, but it does the
> conservative thing, and a follow-up "git status" would yield "bad
> object: HEAD".

Sounds quite sensible.

