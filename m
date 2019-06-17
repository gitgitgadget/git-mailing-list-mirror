Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32E01F609
	for <e@80x24.org>; Mon, 17 Jun 2019 04:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfFQEjt (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 00:39:49 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:30480 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfFQEjs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 00:39:48 -0400
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-09.nifty.com with ESMTP id x5H4XXUA021375
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 13:33:33 +0900
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x5H4XRaT027424
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 13:33:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x5H4XRaT027424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560746008;
        bh=MThotcFMyj5w8W8syae7U2zgDdKi+rFS8GobvWP+TFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vCNK/VQ4d/Uj75Z4N3kGu32o+hbqXbGAXuNmCJuQYnUWgBGnXrEitjLrA3yQRtWu9
         UZHOIMU9dDjIXj5Dcqy66ZGBxiKYfWWJfPskBWKThS8V2rv6mCXCZ/FwEauyIqkYar
         2h5XzRg/ObUDN4WQ7OfQy0B9b2MraB7Ly8ulPW5zCGp5WhO1qzMBaDDCnPsiOo0sc5
         wvlVgYDBxmWYITa0gR3wCUsBqu63XzQ8wPrnpab/0nQORopf3Rdd2KJ9zGkBRSWL7R
         FaU4Q07Hip4vz7Ke03I+Q5ppoxNkkDzNtPtXbX0OH6Qg4yBaz0kPPhdnANWhWlzRRS
         RpjNZWxJ9RAGw==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id u124so5298095vsu.2
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 21:33:28 -0700 (PDT)
X-Gm-Message-State: APjAAAX8sEn4L1z6yzO7V7ZDp6hgA0pvxi1+aiyNjT4QQnvQoB9aGgAe
        zN6kX6yDAy5HkkDS+QToYr0NKuGbPSzxpzsAfJ8=
X-Google-Smtp-Source: APXvYqzm7lvUfc6aWqaF4QzqSk6dPa+D56TqHNmf3u2CQkbLqFXAoR/jOhJ3JdI6xSxqh3At0wOG/gF+pGBcAE3MavM=
X-Received: by 2002:a67:ed04:: with SMTP id l4mr41135759vsp.179.1560746007349;
 Sun, 16 Jun 2019 21:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
 <20190614150758.GA22984@sigill.intra.peff.net>
In-Reply-To: <20190614150758.GA22984@sigill.intra.peff.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 17 Jun 2019 13:32:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNASueRR6narhHqe_D93ewXhTPXokWSCvQRh+Q6=-_AB+3g@mail.gmail.com>
Message-ID: <CAK7LNASueRR6narhHqe_D93ewXhTPXokWSCvQRh+Q6=-_AB+3g@mail.gmail.com>
Subject: Re: 'git interpret-trailers' is tripped by comment characters other
 than '#'
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 15, 2019 at 12:08 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jun 14, 2019 at 08:35:04PM +0900, Masahiro Yamada wrote:
>
> > Perhaps, 'git interpret-trailers' should be changed
> > to recognize core.commentChar ?
>
> It looks like the trailer code does respect it, but the
> interpret-trailers program never loads the config. Does the patch below
> make your problem go away?
>
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 8ae40dec47..f101d092b8 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -10,6 +10,7 @@
>  #include "parse-options.h"
>  #include "string-list.h"
>  #include "trailer.h"
> +#include "config.h"
>
>  static const char * const git_interpret_trailers_usage[] = {
>         N_("git interpret-trailers [--in-place] [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]"),
> @@ -112,6 +113,8 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
>                 OPT_END()
>         };
>
> +       git_config(git_default_config, NULL);
> +
>         argc = parse_options(argc, argv, prefix, options,
>                              git_interpret_trailers_usage, 0);
>

Yup, works for me.



> I do wonder if the trailer code is correct to always respect it, though.
> For example, in "git log" output we'd expect to see commit messages from
> people with all sorts of config. I suppose the point is that their
> comment characters wouldn't make it into the commit object at all, so
> the right answer there is probably not to look for comment characters at
> all.

I see some sort of over-wrap between 'git stripspace --strip-comments'
and 'git interpret-trailers'

The 'commit-msg' hook could pass the message to 'git interpret-trailers'
after trimming all comment lines by using 'git stripspace --strip-comments'.

Anyway, users' hooks already rely on the behavior that
'git interpret-trailers' ignores lines starting with '#'.

So, respecting core.commentChar is the right fix, I believe.


BTW, why is commit-msg hook is passed with a message
without comments unstripped?
I think the straightforward behavior would be
to strip comments first, then invoke the commit hook.


Thanks.


-- 
Best Regards
Masahiro Yamada
