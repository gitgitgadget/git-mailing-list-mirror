Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE2EC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 05:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC442084C
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 05:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki7AHEsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370629AbgJWFXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 01:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370615AbgJWFXc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 01:23:32 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF48C0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 22:23:30 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p10so231347ile.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 22:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpV420sXqyVkdY6y4YVYaMaWqAec4WZn7wrUxAqZ6Cc=;
        b=Ki7AHEsvi5ddQghVYcW/NE3wkhGpVj4prz664hNHl1xLLyf5PtzFMloIOCyJC/TE1r
         vD2+AZ20C7L/UhE3ATQ84U4g86NXkeVcj1EIRa7aHZs/H+N3FJg87ushFUedwZXqITQD
         U74BYVrRTIUhK5jlnWc3co/1Lq0DCkYBT81vGGKhRnUsJgje3pZhjnZImbQRwv7w/n21
         QpH7w/5S9ow4HKUNmOkwEf7CsdTp8GIuQmNhV+SOs7PSJFF/hXtmnKP4HnGAlEqLDxKq
         OqmgBMTUkzohNlWNHW2GHRIMm5V4hSDWHlq7GUJ4eh1xonQRMZ62elpW6nzi01UMzVZ5
         H3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpV420sXqyVkdY6y4YVYaMaWqAec4WZn7wrUxAqZ6Cc=;
        b=au3iXHOpi9a8GQId6YarpQ5Sru0XrHr6dZBO/m7C6+v/IGJAkLI6V+UX+xiIlNLNX8
         N4XhyGml27Vx3HMBh2HB2a3U9im8vDiMOTfNiZyN/tn4y9DupaCV32UG38g4MKgFAgNA
         1xgCRnqJxodwEfA4Grk7wDtfZOq0idB1RUaIf0XY5Qe5l+VEK2YZoKoGzoj3AKeGg9Da
         LzUif7Dae073QACvnY1usUuzI9VR6+feUdJqWqNbeXetiOIDEigsh6pGRpgjwQ8SDxCY
         0yRzpE4pBdmV9qLwWra63fPLjXar2ISPeL0uey9iChutUHjXzPZc8Thec6Zy7glr/Ze5
         L/XA==
X-Gm-Message-State: AOAM531+y8hvYLXF36R5k3UiWBwskNCqp1My448I+9cYPfV4jzSYGC4p
        aMavFITihuD1yyV9x23fJ6byMWh1RNqBeMOa1CpwdwNcogFFKw==
X-Google-Smtp-Source: ABdhPJxLw2Crhfi9hdtHfVWarwV1TSgW2rhDq20OpBd/2DYQhnuVs4/OCirbIVnV4a8Is1GLN6tF4VgsSfyUYn+bSjE=
X-Received: by 2002:a92:ce09:: with SMTP id b9mr496674ilo.14.1603430610006;
 Thu, 22 Oct 2020 22:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
 <20201022112201.51459-1-sangunb09@gmail.com> <xmqqft66m8wm.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft66m8wm.fsf@gitster.c.googlers.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Fri, 23 Oct 2020 10:53:19 +0530
Message-ID: <CAHjREB4qGO1=XCy-F+H39FP_KU_zZjKCDA=b9JxCe0WZdM06KQ@mail.gmail.com>
Subject: Re: [Outreachy] [PATCH v3] diff: do not show submodule with untracked
 files as "-dirty"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

Sorry for sending it over and over again. I couldn't figure out why
the mail is not reaching the community.

>
> Oops?
>

Sorry about this. Would correct it in the next patch.

> I'd suggest to follow the excellent first paragraph above with
> something like the following.
>
>         Make `--ignore-submodules=untracked` the default for `git
>         diff` when there is no configuration variable or command
>         line option, so that the command would not give '-dirty'
>         suffix to a submodule whose working tree has untracked
>         files, to make it consistent with `git describe --dirty`
>         that is run in the submodule working tree.

Very well written. Would update the description to this. Thanks.

> This new boolean is meant to be set only when non-default
> ignore-submodules option is given either from the command line or
> from the configuration---when the bit is unset, we are told to do
> whatever it is that is the default for us.

I fear I might not get your question clearly here. But from what I
understood this boolean( flags.ignore_submodule_set )  is set only
when diff.ignoreSubmodules is set in user-config.

> And the default is to flip only this bit on.  Do we need to turn off
> other bits that submodule.c::handle_ignore_submodules_arg() function
> touches?  [*1*]
>

We are not flipping the bit, we are setting it to 1. I guess we don't
have to turn off other bits because in case if
submodule.c::handle_ignore_submodules_arg() is called we don't have to
set the default value. So there's no point in flipping any other bits
as if any of them is set, the user should have added some arguments in
 ignoreSubmodules and therefore flags.ignore_submodule_set would be
set to 1 and we won't be setting the default value.

>
> I like the general idea of having one bit that is set if and only if
> the command line or configuration told us specifically what to do,
> so that we can dictate the default after they were taken care of.
>
> But I am not sure if this is a good implementation of that idea.
>
> Case in point.  I was wondering if the most future-proof way to
> answer the question I asked (marked with [*1*] above) was to avoid
> flipping the bits in options->flags ourselves, but to make a call
>
>         handle_ignore_submodules_arg(&options, "untracked");
>
> in repo_diff_setup().  When such an improvement is made after this
> patch lands, the assumption that only the end-user preference will
> call this function no longer holds.

I tried making the call directly like this:
handle_ignore_submodules_arg(&options, "untracked") without using the
extra bit, but in the case when the user specifies
diff.ignoreSubmodules in user-config, the
handle_ignore_submodules_arg() is called even before repo_diff_setup()
and therefore the default value overwrites the value mentioned in
user-config.

> Even without anticipating such a change in the future, there already
> is a callsite of this function in wt-status.c that hands a hardcoded
> string "dirty" to it.  That is *not* caused by an end-user request
> (be it a configuration variable or a command line option), so in a
> sense, the assumption is already broken.
>

I couldn't fully understand what assumption are you talking about. I
would be glad if you can explain it to me in a little more detail.
Thanks!

> I wonder, if we can do things in a more natural way (at least the
> natural way in this codebase).  Usually we do things in this order:
>
>  - initialize the status and option variables to their default state.
>
>  - read the configuration files to allow the state of these
>    variables to be modified from their default state.
>
>  - parse the command line arguments to further allow the state of
>    these variables to be modified.
>
> and then use the final state of these variables.  That way, we do
> not even need the extra bit that is only required if we did things
> in an unnatural way, which is
>
>  - read the config; remember if any bits were toggled
>  - parse the command line; remember if any bits were toggled
>  - only if bits weren't toggled in the above, set the default
>
> I dunno.

Ya, that makes sense. I would look into when the config values are
being read and bits are set and would try to find a way so that we can
get rid of the extra bit. Thanks for pointing this out.

>
> Noise.
>
I hope this is a substitute for nice. XD. Hearing this after a long
time. I used to hear this more frequently when I was in college.

>
> Misindented.

Noted. Would change that in the next patch.

Thanks and regards,
Sangeeta
