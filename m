Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB9620986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbcJDR4W (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:56:22 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36474 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbcJDR4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:56:21 -0400
Received: by mail-qt0-f172.google.com with SMTP id m5so40788645qtb.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z3M+dzyElcbKGBOc1r8jQkwWOyEYLGEmajJl+B4BULQ=;
        b=RCn0xjJvM3WfuFZX4FOBi/a9OgYb3Pj32/ME7w2gGElWj7YdUQtV26ghqr3hgggkuv
         Fdlsf4i0zDOsEQ8CgbQkxmc/aRdfQiJQ6dpgIbg5vBCgvjFvqbWd8OIapeg/8WjhpOPq
         Q2IqelswPSzr2e6zXfVhv/8+NdBXMGax6laSQEemJDIUm78tbXVA3VkOK1QvvxZQEY97
         MwvELPIeu5CEC4z7qtuXwACqUTeRWte36yJsi7IE7ltTqFEKbKvVyBWadsqEIqqQHeH7
         vBL7RaQAvvGrA4mMNwifPQxzNrNC+z6Sg0eyVxb3n25+4eu4bLwTj/aeRPnh39kDdBmo
         /neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z3M+dzyElcbKGBOc1r8jQkwWOyEYLGEmajJl+B4BULQ=;
        b=lhsb6zHEWthEN/JXhv5wOtN10C3zOK63LG8cUpK65/jxGUauwJSVrvFJ/dO2TX8iWy
         7NHh1OSU2PzMrdY6XqkC1kLhbm9mWMDrPVjOY9VnyxaJ0fJ/XUtV+2PHqUa8hPq4+4t+
         2vLihdvwUqFn6vgX8BX/+dEpqpq7gSIGHpTiKT0gSMreNWUk47xcYh2NPIS4AC1+EU8m
         uVZCgAWPBYs9iAeUb8XenAEnPJihdmw9dsDa32F6NUz1vOfV6a+59OwWRm9hboxZ6e7n
         YJrLgYhzzn6mldl7N6RM7CYbKpkfGCEOAtY7nAgU8d/uv4b9ruSYNZc1bLoKwc8dZkZl
         xvEg==
X-Gm-Message-State: AA6/9RnvCrPmWHzpM6cvE03xvHO6BN0P8BC5FCxcHPdzvPYgRirhddM6LjyIT1dMsAl0heaO2JM4ZcQF8YCpMgYQ
X-Received: by 10.200.46.227 with SMTP id i32mr5180920qta.1.1475603780180;
 Tue, 04 Oct 2016 10:56:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 4 Oct 2016 10:56:19 -0700 (PDT)
In-Reply-To: <1475185723-36871-5-git-send-email-bmwill@google.com>
References: <1475099443-145608-1-git-send-email-bmwill@google.com>
 <1475185723-36871-1-git-send-email-bmwill@google.com> <1475185723-36871-5-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Oct 2016 10:56:19 -0700
Message-ID: <CAGZ79kbFiK0Wb6zpuyybwUOeXo-H=9oDpO8wnXihYmP8VwAHFQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] ls-files: add pathspec matching for submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 2:48 PM, Brandon Williams <bmwill@google.com> wrote:
> Pathspecs can be a bit tricky when trying to apply them to submodules.
> The main challenge is that the pathspecs will be with respect to the
> superproject and not with respect to paths in the submodule.  The
> approach this patch takes is to pass in the identical pathspec from the
> superproject to the submodule in addition to the submodule-prefix, which
> is the path from the root of the superproject to the submodule, and then
> we can compare an entry in the submodule prepended with the
> submodule-prefix to the pathspec in order to determine if there is a
> match.
>
> This patch also permits the pathspec logic to perform a prefix match against
> submodules since a pathspec could refer to a file inside of a submodule.
> Due to limitations in the wildmatch logic, a prefix match is only done
> literally.  If any wildcard character is encountered we'll simply punt
> and produce a false positive match.  More accurate matching will be done
> once inside the submodule.  This is due to the superproject not knowing
> what files could exist in the submodule.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/git-ls-files.txt         |   3 +-
>  builtin/ls-files.c                     |  27 +++++++--
>  dir.c                                  |  46 +++++++++++++-
>  dir.h                                  |   4 ++
>  t/t3007-ls-files-recurse-submodules.sh | 108 ++++++++++++++++++++++++++++++++-
>  5 files changed, 175 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index ea01d45..51ec9a1 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -140,8 +140,7 @@ a space) at the start of each line:
>
>  --recurse-submodules::
>         Recursively calls ls-files on each submodule in the repository.
> -       Currently there is only support for the --cached mode without a
> -       pathspec.
> +       Currently there is only support for the --cached.

s/--cached/--cached mode/ ?
The "the" in front of --cached sounds a bit strange for a non native
speaker here.


> +       /*
> +        * Find common prefix for all pathspec's
> +        * This is used as a performance optimization which unfortunately cannot
> +        * be done when recursing into submodules
> +        */
> +       if (recurse_submodules)
> +               max_prefix = NULL;
> +       else
> +               max_prefix = common_prefix(&pathspec);

Nit of the day:
While this is readable, you may want to explore how this reads shorter as

    max_prefix = recurse_submodules ? NULL : common_prefix(&pathspec);

?

> +       git ls-files --recurse-submodules "sub" >actual &&
> +       test_cmp expect actual &&
> +       git ls-files --recurse-submodules "sub/" >actual &&
> +       test_cmp expect actual &&
> +       git ls-files --recurse-submodules "sub/file" >actual &&
> +       test_cmp expect actual &&
> +       git ls-files --recurse-submodules "su*/file" >actual &&
> +       test_cmp expect actual &&
> +       git ls-files --recurse-submodules "su?/file" >actual &&
> +       test_cmp expect actual
> +'

> +
> +       git ls-files --recurse-submodules "s??/file" >actual &&
> +       test_cmp expect actual &&
> +       git ls-files --recurse-submodules "s???file" >actual &&
> +       test_cmp expect actual &&
> +       git ls-files --recurse-submodules "s*file" >actual &&
> +       test_cmp expect actual
>  '

Thanks for the tests!
