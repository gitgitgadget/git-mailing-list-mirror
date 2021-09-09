Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBCBC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 15:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C1D611C4
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 15:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbhIIPDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 11:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbhIIPDK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 11:03:10 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CB1C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 08:02:01 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso2861388otp.1
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iE0yBajUSMwkR6T5Fjfve0/V++cyYY8izdtGcWo6R3Q=;
        b=HOhAVtVijcFeKCv2nkpDwRf+bMrzdPJIvjJsQkfWy+q8InPuCLhjFtSZpMt05M6Jut
         b8ze7sBv56EjEHiygGpInPlXAw9NmLji0WvN9pkW40g8MUPIGqm0nIQtlWGJiePSGakv
         bBUf/Jn8JAtZv1q5bYEe/sQAgPYsHoEhPAZKcUsmgnFWljjD9UN/gQLDVE9OiJmZyWk/
         Ag9mNHfygoZ/W+gh/eHcUpG2OmYk/0wvVwkJ7LbLNfNq1TPlTKOk4sBS5RWS6/j4rsVH
         bMr8jmN4iOss9sIobB94pmo1dA8FRfNRHF5wTJYlqXPbAnBkOFZQbI7OZGFN/k7n1cta
         4gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iE0yBajUSMwkR6T5Fjfve0/V++cyYY8izdtGcWo6R3Q=;
        b=H+02yK3pWKJkSY9R9ZNb94dMYpy4gsyqbKtw8iB+T8E5f5+ybCanoAeCAi8AXGomWP
         qfpv0ZDh3NLG21/OO3qRAhly/Cu35MjTHYeBBYmaEPLrrYDKktMfoclkH/vGAx5Es7kn
         q8uwa+sjHJIzQebgAEvBnCuARmKJWIHwS61bRupGF18tQFclJ14JvQLU9t6egggyM1Ch
         72iqw2vl0WiaGoSBWTKduTAsNX4RgH/Pvl9QRMpKlKoM4jXcDj7AT6wapB9McOXCIhzp
         S088UH7U+FYX64kSRizWXrKTBdwWui0rX6L5yXV9ehtYOpdRyhzt+TX9XKeKLTakYigS
         ugtw==
X-Gm-Message-State: AOAM530oTZnECLuduHPEfW1nwkatyHPY2X29q5bGrPBsM3Ww31wzisiF
        HiYqML1du61F+y8+1PQ+N8d2PjeQOIWJkKZY6j4=
X-Google-Smtp-Source: ABdhPJwPC6LYI9QGWcTfAAzbz1EbyFKmbFvO8BEZYbTuzKtu7vO+qU7sbk02NRZf13uv1/Z2rEt0LBN9rs9EskaHZpo=
X-Received: by 2002:a9d:609e:: with SMTP id m30mr265573otj.174.1631199718672;
 Thu, 09 Sep 2021 08:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
 <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com>
 <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com> <c42d4051-59cd-094a-4570-32cf4d38ec27@gmail.com>
 <e7224105-83c6-7f12-f63a-474bd477583a@gmail.com> <408dc1d3-44b8-a955-4d7b-94f23fa8a6bc@gmail.com>
In-Reply-To: <408dc1d3-44b8-a955-4d7b-94f23fa8a6bc@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Sep 2021 08:01:46 -0700
Message-ID: <CABPp-BEbY0BqkBP4r-6XpGk46J+Y+W8+7cVZXQg5fuJXYOntDQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Sep 9, 2021 at 6:57 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Philippe
>
> On 09/09/2021 13:40, Philippe Blain wrote:
> >>> While in general I think it's a good thing to avoid forking, this
> >>> change might result in behavioral differences. Any config that
> >>> affects 'git checkout' but not the internal 'reset.c::reset_head'
> >>> function might play a role in the rebase UX.
> >>>
> >>> One that immediately came to mind is 'submodule.recurse'. This
> >>> initial 'onto' checkout was pretty much the only part of 'git
> >>> rebase' that did something useful for submodules, so it's kind of
> >>> sad to see it regress.
> >>
> >> Thanks for pointing that out. As a non-submodule user my question
> >> would be is it actually useful for the initial checkout to work that
> >> way if the rest of rebase (and the checkout for the am backend)
> >> ignores submodules? reset.c::reset_head() just uses unpack trees like
> >> checkout so if rebase read 'submodule.recurse' then reset_head()
> >> would work like 'git checkout' and also 'git rebase --abort' and the
> >> "reset" command in the todo list would start checking out submodules.
>
> it would also affect fast-forwards
>
> >> I'm reluctant to do that until the merge backend also handles
> >> submodules unless there is a good reason that such partial submodule
> >> support would help submodule users.
> >
> > Yeah, it's not that useful, I have to admit; it can also be very confusing
> > since some parts of rebase are affected, and some not. For example, any
> > time
> > the rebase stops, like for 'edit', 'break', and when there are
> > conflicts, the
> > submodules are not updated. So I think a full solution is better than a
> > partial
> > solution; in the meantime I'm thinking the change you are proposing
> > would actually
> > be less confusing, even if it slightly changes behaviour...
> >
> > As an aside, I *think* reading submodule.recurse in rebase like it's
> > done in checkout
> > et al., i.e. something like this:
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 33e0961900..125ec907e4 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -26,6 +26,7 @@
> >   #include "rerere.h"
> >   #include "branch.h"
> >   #include "sequencer.h"
> > +#include "submodule.h"
> >   #include "rebase-interactive.h"
> >   #include "reset.h"
> >
> > @@ -1106,6 +1107,9 @@ static int rebase_config(const char *var, const
> > char *value, void *data)
> >           return git_config_string(&opts->default_backend, var, value);
> >       }
> >
> > +    if (!strcmp(var, "submodule.recurse"))
> > +        return git_default_submodule_config(var, value, data);
>
> That looks about right to me though I think it would be safer to call
> git_default_submodule_config() for submodule.* rather than just
> submodule.recurse
>
> >       return git_default_config(var, value, data);
> >   }
> >
> >
> > would actually also affect the merges
> > performed during the rebase, since that would affect the "global" state
> > in submodule.c.
> > I hacked exactly that the other day but did not test extensively...
>
> merge-ort.c:checkout() which is used by merge_switch_to_result() uses
> unpack_trees() so it will pick up the global state and hopefully should
> just work (cc'ing Elijah to check as I didn't look what happens when
> there are conflicts).

Yep, merge-ort was designed to just piggy back on checkout code.  The
checkout() function was basically just code lifted from
builtin/checkout.c.  Using that code means that merges now also
benefit from all the special working tree handling that is encoded
into git-checkout -- whether that's parallel checkout, submodule
handling, tricky D/F switches or symlink handling, etc.  In contrast
to merge-recursive, it does not need hundreds and hundreds of lines of
special worktree updating code sprayed all over the codebase.

Conflicts are not special in this regard; merge-ort creates a tree
which has files that include conflict markers, and then merge-ort
calls checkout() to switch the working copy over to that tree.

The only issue conflicts present for merge-ort, is that AFTER it has
checked out that special tree with conflict markers, it then has to go
and touch up the index afterwards to replace the entries for
conflicted files with multiple higher order stages.  (You could say
that merge-recursive is "index-first", since its design focuses on the
index -- updating it first and then figuring out everything else like
updating the working tree with special code afterwards.  In contrast,
merge-ort ignores the index entirely until the very end -- after a new
merge tree is created and after the working tree is updated.)

> merge-recursive.c:update_file_flags() does this
> when updating the work tree
>
>         if (S_ISGITLINK(contents->mode)) {
>
>                  /*
>
>                   * We may later decide to recursively descend into
>
>                   * the submodule directory and update its index
>
>                   * and/or work tree, but we do not do that now.
>
>                   */
>
>                  update_wd = 0;
>
>                  goto update_index;
>
>         }
>
>
>
> so it looks like it does not update the submodule directory. Given
> merge-ort is now the default perhaps it's time for rebase (and
> cherry-pick/revert) to start reading the submodule config settings (we
> parse the config before we know if we'll be using merge-ort so I don't
> know how easy it would be to only parse the submodule settings if we are
> using merge-ort).

I'd just parse any needed config in all cases.  The submodule settings
aren't going to hurt merge-recursive; it'll just ignore them.  (Or are
you worried about a mix-and-match of rebase calling both checkout and
merge code doing weird things, and you'd rather not have the checkout
bits update submodules if the merges won't?)
