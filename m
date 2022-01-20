Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4D4C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 12:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiATMKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 07:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiATMKj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 07:10:39 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2359FC061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 04:10:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id m11so27661950edi.13
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 04:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=I4AHspGcUCAzZPr2JDjtYsZ3y4TYDd9MzqX7WXk2V1M=;
        b=nqNTPGw42vvQ1nnPmEnuEk5HyVH5t3vuIL1Za/y/7tPOryYSrFeJXKS3vdbrN+2Ido
         zc81wVADQ/mWxHuXSs5/cXrIpGRou0zsAQj91LyZAhLQc33ABQTQu9mbFexRo0vnF7of
         AeC5nz2sPHQZUY/bpZkwE04pgkoe0AfMKUQj+OuAKNOb/jVFq8rfnR8q0AZOSXxLcpHx
         9p0gHpV2rIaY3EvxjStFnkiFxh1uXIBDdNnbKdpkf2mdy3umB/Ubz1cAVYhrXMNaU7Fx
         cqfGRVTDAMLuO7Fnujkvhn5pZY3BqwI3nDv3mLbG3KFF1mi44+R0UY5P9jQRCPKeQAZt
         KLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=I4AHspGcUCAzZPr2JDjtYsZ3y4TYDd9MzqX7WXk2V1M=;
        b=rSDzbT1vZzKcs37WapbIYJvnBMcM0h9TRs2Qw4FF3jeDUa2HNalyIPTR/u6qur0BHz
         4IZYP6Zsz3h5OZnAcucVjrUo7r5+Uy06uc9NDRa56AgzWHTOgglussVZoerYpXXZymMw
         zY33fiwNLR9+IfuNeOq3GUbJN84NxUVjICdYeldX9PyjI0EN5H65uQnKxBCU+mQqiOGM
         7l7313dooJwoWVZgBqNzKyhIIYZZeFzoG58j2xGKKJOyTjyAWPZTi3Y1u7xRTJ7TbvvO
         Tn8YOKgbuQnP0ad2CXhzui6TmdXOYt8ywJ2nF7l93Bp/7G13Q0SZOwrvQzJ55KczQ4lU
         X8SA==
X-Gm-Message-State: AOAM531Fm+fElg3U+p+qL6f2bDe1gfu+kyePGR5kaAZJFZLuseWWhwqU
        vb3iuBEUYlV+BukAY+0N4uvh8025Fs12lw==
X-Google-Smtp-Source: ABdhPJw/QNamfH6EaYy4tygWjtaeorfAgruqbf8xAoDu4yAQkcV7VZ+7OKkeKwEB5mfeXEXkx2ORyg==
X-Received: by 2002:a05:6402:1057:: with SMTP id e23mr29604416edu.140.1642680637543;
        Thu, 20 Jan 2022 04:10:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u12sm1245497edq.8.2022.01.20.04.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:10:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAWGy-001xxf-KE;
        Thu, 20 Jan 2022 13:10:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch,checkout: fix --track usage strings
Date:   Thu, 20 Jan 2022 13:05:52 +0100
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
 <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
Message-ID: <220120.86zgnqli9v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 18 2022, Josh Steadmon wrote:

> As =C3=86var pointed out in [1], the use of PARSE_OPT_LITERAL_ARGHELP wit=
h a
> list of allowed parameters is not recommended. Both git-branch and
> git-checkout were changed in d311566 (branch: add flags and config to
> inherit tracking, 2021-12-20) to use this discouraged combination for
> their --track flags.
>
> Fix this by removing PARSE_OPT_LITERAL_ARGHELP, and changing the arghelp
> to simply be "mode". Users may discover allowed values in the manual
> pages.
>
> [1]: https://lore.kernel.org/git/220111.86a6g3yqf9.gmgdl@evledraar.gmail.=
com/
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  builtin/branch.c   | 4 ++--
>  builtin/checkout.c | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 2251e6a54f..0c8d8a8827 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -638,9 +638,9 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
>  		OPT__VERBOSE(&filter.verbose,
>  			N_("show hash and subject, give twice for upstream branch")),
>  		OPT__QUIET(&quiet, N_("suppress informational messages")),
> -		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
> +		OPT_CALLBACK_F('t', "track",  &track, N_("mode"),
>  			N_("set branch tracking configuration"),
> -			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
> +			PARSE_OPT_OPTARG,
>  			parse_opt_tracking_mode),
>  		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
>  			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 94814c37b4..6a5dd2a2a2 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1549,9 +1549,9 @@ static struct option *add_common_switch_branch_opti=
ons(
>  {
>  	struct option options[] =3D {
>  		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named =
commit")),
> -		OPT_CALLBACK_F('t', "track",  &opts->track, "direct|inherit",
> -			N_("set up tracking mode (see git-pull(1))"),
> -			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
> +		OPT_CALLBACK_F('t', "track",  &opts->track, N_("mode"),
> +			N_("set branch tracking configuration"),
> +			PARSE_OPT_OPTARG,
>  			parse_opt_tracking_mode),
>  		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifica=
tions)"),
>  			   PARSE_OPT_NOCOMPLETE),
>
> base-commit: b56bd95bbc8f716cb8cbb5fdc18b9b0f00323c6a

Additional comment: I think this change is correct, as noted in my
just-sent
https://lore.kernel.org/git/220120.864k5ymx55.gmgdl@evledraar.gmail.com/;
it would be nice but not necessary to follow-up with an optbug() test as
noted in
https://lore.kernel.org/git/220119.867davokff.gmgdl@evledraar.gmail.com/
though.

But to not merely repeat myself, I also saw that we're emitting the
wrong output from usage_argh() in cases of !PARSE_OPT_NOARG. I.e. we
need this fix too:
=20=20=20=20
    diff --git a/parse-options.c b/parse-options.c
    index a8283037be9..2be1eabd84e 100644
    --- a/parse-options.c
    +++ b/parse-options.c
    @@ -915,8 +915,10 @@ static int usage_argh(const struct option *opts, F=
ILE *outfile)
                            s =3D literal ? "[=3D%s]" : "[=3D<%s>]";
                    else
                            s =3D literal ? "[%s]" : "[<%s>]";
    -       else
    +       else if (opts->flags & PARSE_OPT_NOARG)
                    s =3D literal ? " %s" : " <%s>";
    +       else
    +               s =3D literal ? "[=3D]%s" : "[=3D]<%s>";
            return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _(=
"..."));
     }

With that we'll now emit:
=20=20=20=20
    $ ./git add -h 2>&1|grep chmod
        --chmod[=3D](+|-)x      override the executable bit of the listed f=
iles

Which is correct, as we accept both of:

    git add --chmod +x
    git add --chmod=3D+x

But not:

    $ git add --chmod
    error: parse-options.c:58: option `chmod' requires a value

But the usage output stated that the "=3D" was mandatory before.
