Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A7E1F424
	for <e@80x24.org>; Wed,  4 Apr 2018 07:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbeDDH1u (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 03:27:50 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:38060 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeDDH1u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 03:27:50 -0400
Received: by mail-qt0-f176.google.com with SMTP id z23so21430667qti.5;
        Wed, 04 Apr 2018 00:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hewN3nwZxrvDfIuwixZgunWC2jEqyI5ehG/niPTEC8E=;
        b=Ti0wFxe2hkZF/96KyD+JLzKklDuQlS614y/SSXPPDnvPap0ZliS8DoH+BLcgNaRRW4
         xJqz8UKtWfhmjWqpIMkmfFtAhgZqVsAcGf6vyl45E+JygTHX2pMIz2dcCrsNj32XsB1E
         9DZ5C+FjBgttnRAS+TGJN5f/j4J+ZmWzbSpDLrpJbULQKfkLITAKx2sqV9K2hnscuOUN
         XHodfstiG47nv92ZLSne6AxxN0XB8VclJ6l13LAwSSZER6DMaE9B9SOt+geXTTDJSZ/l
         RFZo3rZ0W0BjeyMR6yuYC/ar/iaztXfmCmg9xaEMzQ4CVXpzlJQm/NdiLFZdvMHlcZ0C
         WOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hewN3nwZxrvDfIuwixZgunWC2jEqyI5ehG/niPTEC8E=;
        b=lKH2BWY04FLMqa+mudA/u7jEL2mG114SwkehfA+aWr+W76bwkyqqkflR/FxL3xbFA3
         ELvwM+ZUjztAfP/Exfleb2KaIzTVdevVCJvcKjdBa6jRQR1wQZO/UGxp6nav8FxMRaIo
         v/UzQQrrwfW4orVxEWr5ZTwKPpvPHKgfoAygOomJCu8vxVS5yBRpJlS5BnMelrAMkj3a
         6hFAueN5D3J1Hfwcnzj/l0Pj0Z+CU9lz2Q+9WS36HSvn5BwiFiom46nXBCc6vR8iHMx3
         CBsKAh4TGp9ueOZqKY2PIDrz06qaxtvqz43FtPw72JD3ESzR6YWmYo4A/STMLxRiaO9j
         vlRw==
X-Gm-Message-State: ALQs6tDPCgh54NeVqAGx8Jidzl6wprg2uOvDhM7dPpL03P5vDN4eDQAc
        2o4ibJX907hK+PgAW1vFYQbAV2w0oablNNx1ywY=
X-Google-Smtp-Source: AIpwx4+xcYm5vVc8tucM93KLVsNfSMggAnZCHotW62+Obobw+e6UY9aqlK5PMCyHCJ9rl9in/sN0DN4py2+x/wS1LWk=
X-Received: by 10.237.57.166 with SMTP id m35mr23690168qte.220.1522826869275;
 Wed, 04 Apr 2018 00:27:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 4 Apr 2018 00:27:48 -0700 (PDT)
In-Reply-To: <20180404060743.39278-3-me@ttaylorr.com>
References: <20180328234719.595-1-me@ttaylorr.com> <20180404060743.39278-1-me@ttaylorr.com>
 <20180404060743.39278-3-me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Apr 2018 03:27:48 -0400
X-Google-Sender-Auth: 78RHy7m0SAlpO56EHllNpqpwJAk
Message-ID: <CAPig+cR4uFiC_gFsb2e9JR6SdP-wUQVz-E0MjRHR=vNHd+hvhA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, --@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 4, 2018 at 2:07 AM, Taylor Blau <me@ttaylorr.com> wrote:
> `git config` has long allowed the ability for callers to provide a 'type
> specifier', which instructs `git config` to (1) ensure that incoming
> values are satisfiable under that type, and (2) that outgoing values are
> canonicalized under that type.
>
> In another series, we propose to add extend this functionality with
> `--color` and `--default` to replace `--get-color`.
>
> However, we traditionally use `--color` to mean "colorize this output",
> instead of "this value should be treated as a color".
>
> Currently, `git config` does not support this kind of colorization, but
> we should be careful to avoid inhabiting this option too soon, so that
> `git config` can support `--color` (in the traditional sense) in the
> future, if that is desired.
>
> In this patch, we prefer `--type=[int|bool|bool-or-int|...]` over
> `--int`, `--bool`, and etc. This allows the aforementioned other patch
> to add `--color` (in the non-traditional sense) via `--type=color`,
> instead of `--color`.

I always find this last sentence confusing since it's not clear to
which ilk of "--color" option you refer. Perhaps say instead something
like:

    This normalization will allow the aforementioned upcoming patch to
    support querying a color value with a default via "--type=color
    --default=...".

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> @@ -160,30 +158,34 @@ See also <<FILES>>.
> +--type [type]::
> +  'git config' will ensure that any input output is valid under the given type
> +  constraint(s), and will canonicalize outgoing values in `[type]`'s canonical
> +  form.

Do the brackets in "[type]" mean that the argument is optional? If so,
what does 'type' default to when not specified? The documentation
should discuss this.

> diff --git a/builtin/config.c b/builtin/config.c
> @@ -61,6 +61,33 @@ static int show_origin;
> +static int option_parse_type(const struct option *opt, const char *arg,
> +                            int unset)
> +{
> +       [...]
> +       if (!strcmp(arg, "bool"))
> +               *type = TYPE_BOOL;
> +       else if (!strcmp(arg, "int"))
> +               *type = TYPE_INT;
> +       else if (!strcmp(arg, "bool-or-int"))
> +               *type = TYPE_BOOL_OR_INT;
> +       else if (!strcmp(arg, "path"))
> +               *type = TYPE_PATH;
> +       else if (!strcmp(arg, "expiry-date"))
> +               *type = TYPE_EXPIRY_DATE;
> +       else {
> +               die(_("unexpected --type argument, %s"), arg);

"unexpected" doesn't seem like the best word choice since an argument
to --type _is_ expected. Perhaps you mean "unrecognized"?

> +               return 1;
> +       }
> +       return 0;
> +}
