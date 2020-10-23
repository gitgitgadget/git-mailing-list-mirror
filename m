Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D9DC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 18:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0E320878
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 18:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2YaCVCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464889AbgJWSRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464869AbgJWSRc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 14:17:32 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CFCC0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 11:17:32 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id p9so2293878ilr.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWjoF6yZoG+o+3piIpwrayKMh2Kg92QFKsnUKI+5yK0=;
        b=m2YaCVCqLc/ZGYl5UU7Mje/RZjwJAWOdOoz2jx4Y9Op33EQSpveAAjMlcE3c6UJjoT
         69EWc8qNs24qnfwbJB3vnqkVLOJFbJTnPKBNVGWOvNs8moD8ihER7REFWEabxL7R/mqX
         rBLH4h7wCI8MEpyDT5KCmL1Hm1nrRVdMdp27x7VBDmRyJN0oT2bh/zasF2Zs6VTJUclk
         864RF59tY/DJS2z9K1vEghghVycEg7qughTWNvpGHj7ezribxtR5ZPBYeAid6fmXwA0o
         UbU+CwDPkhHC2NYAiYNFcHChn2h67BjNiAyD60847T2NZhEYoQTDwrBwdwa09QZjdQug
         IC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWjoF6yZoG+o+3piIpwrayKMh2Kg92QFKsnUKI+5yK0=;
        b=POd747szcu3mam73uVUN6HITBwf3rCWk2lokC9CHJeC/cF2R+P5qa1nfjc0SlT7v/A
         hvhFnzlTUd1HG2xCp6ZsE0DDgqE33UhZfqQDrGnMVQp+4Gz9p8Xw5Xdlq35DNPx+WqNa
         65a879CxFCmc9h2bEGLDK8EGwsuzgq16by1utqvrRCk5FYbDxP5L5tbvmHurRoJj64WN
         soKCSyK39wS0i/91rj5LOQ0TfJYiMwCO05GtJrQlcsGzWnt4Yy8F6Tp1u8NLAujpFV9j
         tDFFksSx+B83lpQlIyPuKe8v6Wtzedj8t9buj4662lgn6lntMySzgZsBJz+dsc1caoBq
         bGkg==
X-Gm-Message-State: AOAM533131nTdVeeat8VBKoe6D9SgI8lpJ7ozQm4I/Pppg2cFzV9fYRH
        0lNIAKMUFVyxmM016ZHSS/WVOJSF2xJe1VDe3m0=
X-Google-Smtp-Source: ABdhPJxTEYimuTc3o5QLCE6HgQGkCRWdT4jFLDoNQoNPscgvBakiUbnvAAmEpoZijNo6eYzVOVdCVFuUW1vuFtAp9Oc=
X-Received: by 2002:a05:6e02:c2e:: with SMTP id q14mr1661710ilg.14.1603477051773;
 Fri, 23 Oct 2020 11:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
 <20201022112201.51459-1-sangunb09@gmail.com> <xmqqft66m8wm.fsf@gitster.c.googlers.com>
 <CAHjREB4qGO1=XCy-F+H39FP_KU_zZjKCDA=b9JxCe0WZdM06KQ@mail.gmail.com> <xmqqr1pphsvs.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1pphsvs.fsf@gitster.c.googlers.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Fri, 23 Oct 2020 23:47:20 +0530
Message-ID: <CAHjREB4egt95fCz6pzON2h5rVH-XvYKf1oGnyU-8gVL-U3WrmA@mail.gmail.com>
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

> The four-line paragraph I wrote above is not a question.  It is
> normal to "think aloud" to express what the reader understood what
> the patch does/intends to do during the review, which gives the
> contributor a chance to spot misunderstanding by the reviewer.
>
Oh okay. I thought you meant to ask something. But ya "think aloud" is
a nice practice. Sorry for the confusion.

> In any case, when "git diff --ignore-submodules=<when>" command line
> option is parsed, diff_opt_ignore_submodules() gets called, which in
> turn calls handle_ignore_submodules_arg(), and you set the bit
> there.
>
> So this is not limited to configuration, I think.  Command line
> option given by the user can also affect it.

Umm, so when diff.ignoreSubmodules is set in user config,
git_diff_ui_config() is called which is called(which calls
handle_ignore_submodules_arg) even before repo_git_setup() and
therefore it sets the bit there. But in the case of command-line
options, as you mentioned, diff_opt_ignore_submodules() gets called by
the prep_parse_options() which is called after we are checking for
that bit. So when we are checking for the bit, prep_parse_options() is
not yet called, and therefore that bit is not set.

>
> Yeah, flipping it to on is setting it to 1.  We are saying the same
> thing, aren't we?

Ya, sorry for the misunderstanding. We are saying the same thing.

>
>
> The reason why a helper function handle_ignore_submodules_arg()
> exists in the first place is because the way ignore_* bits are
> managed in the diff_options.flags is tricky and with a helper in
> between the callers and the actual bits, is easier to update in the
> future if needed.
>
> So even if we assume that everybody who reacted to end-user
> preference would have called handle_ignore_submodules_arg(), hence
> we do not want to force our default when the .ignore_submodule_set
> bit set and we do want to do so when the bit is unset, we should
> do
>
>         if (!options->flags.ignore_submodule_set)
>                 handle_ignore_submodules_arg("untracked");
>
> instead of only toggling the .ignore_untracked_in_submodules bit on
> manually.
>

Oh okay, that makes sense. Would update that in the next patch.

>
> Have you looked for "dirty" (with double-quote around the word) in
> wt-status.c already?  The call to handle_ignore_submodules_arg(),
> which would cause your new bit set, is made not as a reaction to any
> end-user input.  Rather it is "if end-user did not say anything, use
> this hardcoded setting".  And it overrides the "if the end user did
> not specify anything, we want to use this default" logic you added
> with this change, because it dictates "dirty" there without end-user
> asking.
>
> Is that desirable?  I dunno.

This change was added in this[1] commit and as said there the "dirty"
was used because here[2] if no arguments are provided with
ignoreSubmodules then it set it to all and it might be confusing for
`git status` as then even when the user chooses to record a new commit
for an ignored submodule by adding it manually this change won't show
up under the to-be-committed changes.(as mentioned in [1])

[1] https://github.com/git/git/commit/1d2f393ac9bfb4c20f14d6ead7bb4c56e766ab77
[2] https://github.com/git/git/blob/master/diff.c#L5139

So I think that's desirable.

> I found this change a "noise":

Oh okay, Again sorry for the misunderstanding.

>
>         strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
>         if (ignore_untracked)
> -               strvec_push(&cp.args, "-uno");
> +               strvec_push (&cp.args, "-uno");
>
> If it were going the other direction, "we fix coding style violation
> while at it" may be a good justification to do so, but this
> particular change (1) is not neeeded for the purpose of this patch,
> and (2) is making the code worse by deviating from the coding
> guideline.  Please drop it.
>

This part of the change was introduced because we had a failing test
here[3]. There was some problem it getting both the flags propagated
through the nested submodule and that's why this change. Maybe we can
do something better to fix that. It would be great if you can have a
look at it.

[3] https://github.com/git/git/blob/master/t/t3600-rm.sh#L690

Thanks and Regards,
Sangeeta
