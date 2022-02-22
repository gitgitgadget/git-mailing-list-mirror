Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8071C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 17:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiBVRRM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 12:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiBVRRL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 12:17:11 -0500
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EAF7DE01
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 09:16:44 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id m11so12637801pls.5
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 09:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFOAbc9L7yO858W/frQ3V6o+nyEJJEL+AH0ArqTQt4Y=;
        b=wDCoIxzR9gkPE8sFaWCtU0iwTmEelvjwJ5oSsKbRYOPox6GKhGk43ipNYVTlK5U13G
         KlsygxfVnGlIBFddMvX75Y5J19CUzWH8fdeHCyO8O6054z6JjQpXBTBaVH08mPhqMlBW
         W48oQ2z2dtqVcgvrntYek7UhC60HrFfpiwJLVgJgWBeFHar95qKf3QBtKTnQuBUBdGAb
         Y7j9p2lRSQwPBluuLb1VkWnjxNpaRkoTnj1kO7026evUFrpKDX1HpCba/l7Adr3o5WmC
         YFNKd78+/1FWyRhXT/ixwFBxGOZSVVr0+fpjc3xVuY1uPf4A3/hxsqArFQ56KuSqBFvA
         J6lg==
X-Gm-Message-State: AOAM533GIc1XKi6iFjOGdsVdB4kQwD47ssoDt2qDq+1LETk8lCrkxF+q
        hXyNtZ/02cCwlbTs2yMgOIDoCx036XnQlaKNx/s=
X-Google-Smtp-Source: ABdhPJyY1nMsO0Wp0KDxx7ps+VPHmHzUPjstzL3+uzVMDfrZff3kXpScpcYcsIDV+3F6440v+K5yKC/mCgKdoartmr0=
X-Received: by 2002:a17:902:cec8:b0:14f:f55:6fb7 with SMTP id
 d8-20020a170902cec800b0014f0f556fb7mr24246663plg.35.1645550204211; Tue, 22
 Feb 2022 09:16:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.1147.git.1645030949730.gitgitgadget@gmail.com> <pull.1147.v2.git.1645545507689.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v2.git.1645545507689.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Feb 2022 12:16:33 -0500
Message-ID: <CAPig+cRq7H2bnkcU-V5uiWA9z=FLvxj3ji0bhO3DMX9HfptHtQ@mail.gmail.com>
Subject: Re: [PATCH v2] add usage-strings check and amend remaining usage strings
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Lawall <julia.lawall@inria.fr>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 11:27 AM Abhradeep Chakraborty via
GitGitGadget <gitgitgadget@gmail.com> wrote:
> Usage strings for git (sub)command flags has a style guide that
> suggests - first letter should not capitalized (unless requied)

s/requied/required/

> and it should skip full-stop at the end of line. But there are
> some files where usage-strings do not follow the above mentioned
> guide. Moreover, there are no checks to verify if all usage strings
> are following the guide/convention or not.
>
> Amend the usage strings that don't follow the convention/guide and
> add a check in the `parse_options_check()` function in `parse-options.c`
> to check the usage strings against the style guide.

This is a relatively minor observation, but it might make sense to
split this into two patches, the first of which fixes the offending
usage strings, and the second which adds the check to parse-options.c
to prevent more offending strings from entering the project in the
future. Anyhow, not necessarily worth a reroll.

> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
> diff --git a/parse-options.c b/parse-options.c
> @@ -492,6 +492,15 @@ static void parse_options_check(const struct option *opts)
> +               if (opts->type != OPTION_GROUP && opts->help &&
> +                       !(starts_with(opts->help, "HEAD") ||
> +                         starts_with(opts->help, "GPG") ||
> +                         starts_with(opts->help, "DEPRECATED") ||
> +                         starts_with(opts->help, "SHA1")) &&
> +                         (opts->help[0] >= 65 && opts->help[0] <= 90))
> +                       err |= optbug(opts, xstrfmt("help should not start with capital letter unless needed: %s", opts->help));

This list of hardcoded exceptions may become a maintenance burden. I
can figure out why OPTION_GROUP is treated specially here, but why use
magic numbers 65 and 90 rather than a more obvious function like
isupper()?

Perhaps instead of hardcoding an exception list and magic numbers, we
can use a simple heuristic instead. For instance, if the first two
characters of the help string are uppercase, then assume it is an
acronym (i.e. "GPG") or special name (i.e. "HEAD"), thus allowed.
Maybe something like this:

    if (opts->type != OPTION_GROUP && opts->help &&
        opts->help[0] && isupper(opts->help[0]) &&
        !(opts->help[1] && isupper(opts->help[1])))

> +               if (opts->help && !ends_with(opts->help, "...") && ends_with(opts->help, "."))
> +                       err |= optbug(opts, xstrfmt("help should not end with a dot: %s", opts->help));
