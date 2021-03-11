Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C252DC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797CC64FEC
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhCKPYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhCKPYR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 10:24:17 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171A2C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:24:17 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so761716oot.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VX044lxq6XMEkhTxUqhilme2LM9Vt6ARoLI9CTyOo2w=;
        b=i2hF7FsGOw5t6tEDQEB+zIOnVXvCOU6R+RjC1Ct16TXtOnSL0eirGlzyvBCyEfrxoj
         iSGoQrivDoyHgpu2LBL7xqJgaGbYSPcIJh1gT87CBRaUkF7jDksemfCRzF5AgIrNOHl8
         sG+eWErs/sF9okhCihO0KGP3mlV6t4tnPrdXgHU8Qz0jdAlzxhxkqY1hirB/UE/yq2m+
         S5l6reGu7C1L2volfyfv3hWnv5xqQJ37hl9+9fnTeYx5ZVBcE1yCpHnKR6j3jF44Sgr8
         /JG39WnSRj3YFJq+1xoEtrx9A9DKPbMdTJRG7xYE+Pm9Yu5Ap7RDbCQI3mEokYSwaWdw
         TOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VX044lxq6XMEkhTxUqhilme2LM9Vt6ARoLI9CTyOo2w=;
        b=rBUBUzTtxpl6/hgnEpxOqMYn5Wsl9DM8GuZPI41532A5yBnZE0qH3E/IDLr7zXwgfJ
         g9UZEzErGizVL5YpTgs3gGPXtC9RAcucUBELT00l/M6+7DGJ4gnM1+1oCRw6OdrzdP3l
         LSFcA6SSpzPEGzERhJGsPPMcrS/V17EypHgtAdTk0Ronm5KClDYtUQYVZnMkk4pySGh0
         LSW9Xyp4oWt5/hvNaMILKmZUG6M63U0LcUjlBRmDre4KwJUI9/77E9llQEZTpwCtOwe9
         wp8RsSoX82N3ZEEJEJNGLCwWQ0Ac8DMEU57/nIaLW8geB4aLXngkvZeezYPhUlilF8RY
         1RqA==
X-Gm-Message-State: AOAM5322HX4vlOJ74vm1wDdog0xp/DR8PyULbePbsjDZ/2dLXUbivDA7
        grZPD0MBlRXYMDAN83KCFq/MC0mDvdii5q0yyX+W/WSap50=
X-Google-Smtp-Source: ABdhPJxRP8YXlVCj//jQoJxnb5PAacvqfT5WoyFXjfWIqqUIEiBoljE6PQDnp+tcqe03K87oP19fRprbPDsCJX5iV30=
X-Received: by 2002:a4a:88ee:: with SMTP id q43mr7034512ooh.61.1615476256280;
 Thu, 11 Mar 2021 07:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-3-charvi077@gmail.com>
 <CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com>
In-Reply-To: <CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 11 Mar 2021 20:54:05 +0530
Message-ID: <CAPSFM5c8saGs=+OvXvZw-T2jPpdUfkmm9_BZOmZwUo=WO1sdQg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 11 Mar 2021 at 11:55, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
[...]
> Two style nits:
>
> * opening curly brace of function goes on its own line
>
> * we don't normally have a blank line at the top of the function body
> preceding the declarations
>
> So:
>
>     static int prepare_amend_commit(...)
>     {
>         const  char *buffer, *subject, *fmt;
>

Okay, I will fix it.

> > +       buffer = get_commit_buffer(commit, NULL);
> > +       find_commit_subject(buffer, &subject);
> > +       /*
> > +        * If we amend the 'amend!' commit then we don't want to
> > +        * duplicate the subject line.
> > +        */
> > +       fmt = starts_with(subject, "amend!") ? "%b" : "%B";
> > +       format_commit_message(commit, fmt, sb, ctx);
> > +       unuse_commit_buffer(commit, buffer);
> > +       return 0;
> > +}
>
> What is the significance of this function's return value? At least in
> this patch, the single caller of this function ignores the return
> value, which suggests that the function need not return any value.
> Will a later patch add other possible return values to indicate an
> error or something?
>

No, it will not return another value later. I will remove it from here.

> > @@ -745,15 +764,32 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
> > +               char *fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
> > +               commit = lookup_commit_reference_by_name(fixup_commit);
> >                 if (!commit)
> > +                       die(_("could not lookup commit %s"), fixup_commit);
> >                 ctx.output_encoding = get_commit_output_encoding();
> > +               format_commit_message(commit, fmt, &sb, &ctx);
> > +               free(fmt);
>
> Nit: it would reduce the cognitive load slightly if `fmt` is prepared
> just before it is used rather than being prepared at the top of the
> block:
>
>     fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
>     format_commit_message(commit, fmt, &sb, &ctx);
>     free(fmt);
>
> Subjective and not at all worth a re-roll.
>

Agree, will fix it.

> > @@ -1227,6 +1269,34 @@ static int parse_and_validate_options(int argc, const char *argv[],
> > +       if (fixup_message) {
> > +               /*
> > +                * To check if fixup_message that contains ':' is a commit
> > +                * reference for example: --fixup="HEAD^{/^area: string}" or
> > +                * a suboption of `--fixup`.
> > +                *
> > +                * As `amend` suboption contains only alpha character.
> > +                * So check if first non alpha character in fixup_message
> > +                * is ':'.
> > +                */
>
> I have a tough time figuring out what this comment is trying to say,
> and I don't think I would have understood it if Junio had not already
> explained earlier in this thread why this code is as complex as it is
> (rather than using, say, skip_prefix()). Perhaps the entire comment
> can be replaced with this:
>

I admit, this comment seems confusing...

>     Extract <option> (i.e. `amend`) from `--fixup=<option>:<commit>`,
>     if present. To avoid being fooled by a legitimate ":" in <commit>
>     (i.e. `--fixup="HEAD^{/^area: string}"`), <option> must be
>     composed of only alphabetic characters.
>
> Not necessarily worth a re-roll.
>

.. and I think we can reword it as suggested by Junio in patch[v4
3/6], as it seems more clear.

> > +               size_t len = get_alpha_len(fixup_message);
> > +               if (len && fixup_message[len] == ':') {
> > +                       fixup_message[len++] = '\0';
> > +                       fixup_commit = fixup_message + len;
>
> An alternate -- just about as compact and perhaps more idiomatic --
> way to write all this without introducing the new get_alpha_len()
> function:
>
>     char *p = fixup_mesage;
>     while (isalpha(*p))
>         p++;
>     if (p > fixup_message && *p == ':') {
>         *p = '\0';
>         fixup_commit = p + 1;
>
> Subjective and not at all worth a re-roll.
>

Earlier we had discussed[1] keeping a separate helper function, so
that it may re-use it later. But I agree above is easier to get and
compact so I think maybe it will be ok, for this patch series to
replace it with the above and remove the function.

[1] https://lore.kernel.org/git/xmqqpn0xdse8.fsf@gitster.g/
