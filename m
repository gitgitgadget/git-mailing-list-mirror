Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE4C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D5E61426
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGETu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhGETu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 15:50:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45642C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 12:48:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p21so12482701lfj.13
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 12:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QQvsQ0RZViT7bmCTr2z6aS2g3klpkfl0PXpvk+i5CqU=;
        b=GSa3cQtZKOxVmsOJxrGMISYEv8jnW7x6bJtd8K5PDFCFhEBocjcO626+Dkmp2nQHmA
         1Q7SNTBVCQM79cUN60X2CuAR6oy3ofF72UnQsstWgmTBeQyNQkZUThvkGri+DQEAvi12
         xXiTIhaeKz1aAXK7vIQdxjyxEvq7S3rUU5mNPatl3LHzm6aCQi+9+vxVlxeSZVGaIwwD
         /eToct33I+cXMuD5VKSgNd8kyT4nCslDX8P+mRtCR64rEQfO/gKa/KpW7PB6nec3ivdt
         317QCQdQXBG5hCFm1212us6avTSmammmIKvh4vX7s+mnEbe6zKrHbGPgkcoMOJNphID5
         oSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QQvsQ0RZViT7bmCTr2z6aS2g3klpkfl0PXpvk+i5CqU=;
        b=nRQ3ZykJ9NHUcMn7vsWLEJzDW7BrOo/k/XkTUy/b9Lu1Xg29FKipJZgfDruHwL2QBl
         vHUYlx7cuR55JJPdeqtCbSkomQeXcGTBPgdgyE6OLXfubJZmD39zovXFVWZzWiIXP2oN
         ila+P1DzhXFCED8cROh7PlCXlciUb58NGZ+MKJFvIZA5VQzWNfoaRmalvgGn87iT+b61
         ETkO0CkVjR87YxJOCUH/jGTwNuSpTD9tXlB3+aeZ42eIMS810u71Sg7i2ybRqKWVzys8
         T50cRuaRqFxk523NXMjlNZ9Gf5XMaht5UrWJOt+qjqs8QAXUhapQIxSy5UvXM5KQEjgE
         u/NQ==
X-Gm-Message-State: AOAM533adWfkBgs7Nf59jb1JHUh1aUitlVeV4LpaBHWmvCyNoSMMiL2m
        2b51UDm74OVWDocdPxmpVN1cwDJHzXjdJy1sHKs=
X-Google-Smtp-Source: ABdhPJw/7F3U71hKtEFfjhZDecqqPwQmpJZrjeTaMvHjCiGd6GC4Nz75s4dzfeAibkLVqrmGlVJ48BiTKgGd8nzLCoc=
X-Received: by 2002:ac2:5318:: with SMTP id c24mr11635892lfh.167.1625514496522;
 Mon, 05 Jul 2021 12:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
 <349748b4-3c48-7ca7-eb0f-e859a15cab0f@gmail.com> <7ee36923-0806-4316-729c-8418df5b6555@gmail.com>
 <xmqqpmvwn1qp.fsf@gitster.g> <xmqqlf6kmup4.fsf@gitster.g>
In-Reply-To: <xmqqlf6kmup4.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 5 Jul 2021 13:48:05 -0600
Message-ID: <CAMMLpeQG-eYgWTXyG0YzgN3U8QDASAtNFpxyXDFFPSVNzfw18g@mail.gmail.com>
Subject: Re: [PATCH RFC] rebase: respect --ff-only option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 5, 2021 at 2:53 AM Phillip Wood <phillip.wood123@gmail.com> wro=
te:
>
> On 05/07/2021 05:45, Alex Henrie wrote:
> > index 12f093121d..b88f0cbcca 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -1345,12 +1349,14 @@ int cmd_rebase(int argc, const char **argv, con=
st char *prefix)
> >                        N_("ignore changes in whitespace")),
> >               OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
> >                                 N_("action"), N_("passed to 'git apply'=
"), 0),
> > -             OPT_BIT('f', "force-rebase", &options.flags,
> > -                     N_("cherry-pick all commits, even if unchanged"),
> > -                     REBASE_FORCE),
> > -             OPT_BIT(0, "no-ff", &options.flags,
> > -                     N_("cherry-pick all commits, even if unchanged"),
> > -                     REBASE_FORCE),
> > +             OPT_SET_INT_F('f', "force-rebase", &options.fast_forward,
> > +                           N_("cherry-pick all commits, even if unchan=
ged"),
> > +                           FF_NO, PARSE_OPT_NONEG),
>
> Why does this change rebase to start rejecting --no-force-rebase? This
> is the sort of behavior change that deserves a mention in the commit
> message.

That was accidental, sorry. I copied and pasted option code from
another place without paying attention to the PARSE_OPT_NONEG.

> > +             OPT_SET_INT(0, "ff", &options.fast_forward, N_("allow fas=
t-forward"),
> > +                         FF_ALLOW),
>
> The useful option when rebasing is '--no-ff', now that will no longer
> appear in the output of 'git rebase -h'

Yeah, that's a good point.

On Mon, Jul 5, 2021 at 3:36 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Sun, Jul 04 2021, Alex Henrie wrote:
>
> > +int error_ff_impossible(void)
> > +{
> > +     error(_("Not possible to fast-forward, aborting."));
> > +     return -1;
> > +}
>
> Here's one, the idiom is just "return error", i.e it itself returns -1.

That would indeed be simpler; thanks for pointing that out.

> FWIW I'd consider doing:
>
>         /* earlier, static scope */
>         static const char error_ff_impossible =3D N_("Not possible...");
>         /* later, function scope */
>             return error(error_ff_impossible);
>
> It's a small difference, but for translators who use the jump-to-source
> while translating not having the indirection helps, and in this case
> it's just used 3 times...

Wouldn't jump-to-source take the user to the English text in advice.c
either way? How does putting it in a static variable help?

> > [...]
> >       if (parent && parse_commit(parent) < 0)
> >               /* TRANSLATORS: The first %s will be a "todo" command lik=
e
> > @@ -2764,7 +2769,7 @@ static int populate_opts_cb(const char *key, cons=
t char *value, void *data)
> >       else if (!strcmp(key, "options.record-origin"))
> >               opts->record_origin =3D git_config_bool_or_int(key, value=
, &error_flag);
> >       else if (!strcmp(key, "options.allow-ff"))
> > -             opts->allow_ff =3D git_config_bool_or_int(key, value, &er=
ror_flag);
> > +             opts->fast_forward =3D git_config_bool_or_int(key, value,=
 &error_flag) ? FF_ALLOW : FF_NO;
>
> Since we're on nits, we try to wrap at 80 characters.

Thanks, I didn't know what the exact cutoff was.

> > +test_expect_success "rebase: impossible fast-forward rebase" '
> > +     test_config rebase.autostash true &&
> > +     git reset --hard &&
> > +     echo dirty >>file1 &&
> > +     (git rebase --ff-only unrelated-onto-branch || true) &&
>
> Never "||" git commands, better as test_might_fail. We don't want to
> hide segfaults.

Also thanks for the advice here.

On Mon, Jul 5, 2021 at 10:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Looking at origin/seen:builtin/pull.c we already check if we can
> > fast-forward and unconditionally merge in that case irrespective of
> > any '--rebase' option or pull.rebase config. It should be simple for
> > pull to error out if '--ff-only' is given and we cannot fast-forward.
>
> Excellent.
>
> Even though teaching even more special case on the "git pull" side
> makes me feel somewhat dirty, but I think it would be a small price
> to pay, and the end result would save an useless fork whose sole
> purpose is to make the integration step after fetch fail when "pull"
> can easily tell, as you said, that it ought to fail, so overall it
> would probably be a net win.

Okay, so it sounds like I should just scrap this patch and try again,
after "pull: cleanup autostash check" is in master, with a patch that
only modifies `git pull` and not `git rebase`. (Unless someone more
experienced wants to take over, which would be fine by me.)

Thanks anyway to Phillip and =C3=86var: Your feedback will help me write
better patches in the future.

-Alex
