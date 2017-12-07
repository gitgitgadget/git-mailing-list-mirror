Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E073520C32
	for <e@80x24.org>; Thu,  7 Dec 2017 00:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbdLGARG (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 19:17:06 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37909 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbdLGARF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 19:17:05 -0500
Received: by mail-wm0-f65.google.com with SMTP id 64so10013346wme.3
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 16:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YjkF7uuxbLecimDQZhMb3NGkdsvTNWTteqQoQJVl6W0=;
        b=KV9gLOxH/iX5hwRSebwJUT+E1rTLjKHX6k7cLysrLfeAe4UerAuE+mXgb4yvFcWu48
         1hGvct1XLsqqVLJugJhIrBHnmFGSIOKJ+J0thUE2L9LWWDH6QEqBERf+2SlBR1uZKGfq
         U3cqMvDebt0BmL6qozQqx5/tGoNEWXKUOjjdr6VNg3j5tPzR+jykn3ms4jFHkz2Sdu7D
         lDPVXcDBvCxp+jg4Ee/JHv6CdIqrkUi8StINsvfzYSHvFYENOkUvMiWlnFyiO3wTd0PP
         enLb0/tLT1UrmMmolDp62Is96xBIrIZxSi98c6RqkjM3W3U+CeXAvoBipml47tW7ZHn/
         UijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YjkF7uuxbLecimDQZhMb3NGkdsvTNWTteqQoQJVl6W0=;
        b=orN/e01FBv3emuQ2ShqRI+Xvj2XyWO0HAOhrKS7X6VrPDeW0XhVCcLvIReqNs0dWRR
         3lQxzYqvQMBQ5eKVamnf3Sarb3xP95uVr2vBFVcLkIxhOYWaiROqk3DU7yoTqnW6przF
         aKads1kthIBIlAs2i1TXffRsnhL8dyc7mqVRdzDgRpGes4OKbGYrnB/QqbviiGSTJ7qr
         0mA88LOXoiugPWJMeUA5pImwwiCDL17HWAPOwcZzmbn0/xmGMY/+Hpl23ZfPvA31w8u3
         J7VckqaI1sdCa1APo+Q36cgvKcO5lr7yiHAJiJwNkGGlcaDJxv7oX9upZJMdYd6P8GHC
         9/rg==
X-Gm-Message-State: AJaThX7oqKD2Y4UWj60mn8QFEFKWzUoA2SO8A3KkemHv8tFacjJtdEzP
        XWnAq+oEV2ZC9XBnfFkuNm6xz7y/urk/OXpFwKo=
X-Google-Smtp-Source: AGs4zMZfCAM/KHxyEK/CdSq8u5mqzDiGWn79g1q1uOJfm6pUk+2K2XUZDDkeO+tQUM3vGlKCjy8jz23Z/SzXoG/jsaY=
X-Received: by 10.80.165.109 with SMTP id z42mr41499684edb.18.1512605824267;
 Wed, 06 Dec 2017 16:17:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Wed, 6 Dec 2017 16:16:43 -0800 (PST)
In-Reply-To: <20171203170415.15939-3-chriscool@tuxfamily.org>
References: <20171203170415.15939-1-chriscool@tuxfamily.org> <20171203170415.15939-3-chriscool@tuxfamily.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 6 Dec 2017 16:16:43 -0800
Message-ID: <CA+P7+xqD80v=CsbT003b7czro4CZ77CJMppAhbQOPo1ssqTsKA@mail.gmail.com>
Subject: Re: [PATCH 3/3] diff: use skip_to_opt_val()
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 3, 2017 at 9:04 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> From: Christian Couder <christian.couder@gmail.com>
>
> Let's simplify diff option parsing using skip_to_opt_val().
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  diff.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 2ebe2227b4..067b498187 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4508,17 +4508,11 @@ int diff_opt_parse(struct diff_options *options,
>                 options->output_format |= DIFF_FORMAT_NUMSTAT;
>         else if (!strcmp(arg, "--shortstat"))
>                 options->output_format |= DIFF_FORMAT_SHORTSTAT;
> -       else if (!strcmp(arg, "-X") || !strcmp(arg, "--dirstat"))
> -               return parse_dirstat_opt(options, "");
> -       else if (skip_prefix(arg, "-X", &arg))
> -               return parse_dirstat_opt(options, arg);
> -       else if (skip_prefix(arg, "--dirstat=", &arg))
> +       else if (skip_prefix(arg, "-X", &arg) || skip_to_opt_val(arg, "--dirstat", &arg))
>                 return parse_dirstat_opt(options, arg);
>         else if (!strcmp(arg, "--cumulative"))
>                 return parse_dirstat_opt(options, "cumulative");
> -       else if (!strcmp(arg, "--dirstat-by-file"))
> -               return parse_dirstat_opt(options, "files");
> -       else if (skip_prefix(arg, "--dirstat-by-file=", &arg)) {
> +       else if (skip_to_opt_val(arg, "--dirstat-by-file", &arg)) {
>                 parse_dirstat_opt(options, "files");
>                 return parse_dirstat_opt(options, arg);
>         }
> @@ -4540,13 +4534,13 @@ int diff_opt_parse(struct diff_options *options,
>                 return stat_opt(options, av);
>
>         /* renames options */
> -       else if (starts_with(arg, "-B") || starts_with(arg, "--break-rewrites=") ||
> -                !strcmp(arg, "--break-rewrites")) {
> +       else if (starts_with(arg, "-B") ||
> +                skip_to_opt_val(arg, "--break-rewrites", &optarg)) {
>                 if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
>                         return error("invalid argument to -B: %s", arg+2);
>         }
> -       else if (starts_with(arg, "-M") || starts_with(arg, "--find-renames=") ||
> -                !strcmp(arg, "--find-renames")) {
> +       else if (starts_with(arg, "-M") ||
> +                skip_to_opt_val(arg, "--find-renames", &optarg)) {
>                 if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
>                         return error("invalid argument to -M: %s", arg+2);
>                 options->detect_rename = DIFF_DETECT_RENAME;
> @@ -4554,8 +4548,8 @@ int diff_opt_parse(struct diff_options *options,
>         else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
>                 options->irreversible_delete = 1;
>         }
> -       else if (starts_with(arg, "-C") || starts_with(arg, "--find-copies=") ||
> -                !strcmp(arg, "--find-copies")) {
> +       else if (starts_with(arg, "-C") ||
> +                skip_to_opt_val(arg, "--find-copies", &optarg)) {
>                 if (options->detect_rename == DIFF_DETECT_COPY)
>                         options->flags.find_copies_harder = 1;
>                 if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
> --
> 2.15.1.271.g1a4e40aa5d.dirty
>

This causes a regression in the --relative option which prevents it
from working properly.

If I have a repository with a modified file in a subdirectory, such as:

a/file

then git diff-index --relative --name-only HEAD from within "a" will
return "a/file" instead of "file"

This breaks git completion, (among other things).

Thanks,
Jake
