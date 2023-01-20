Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2AFC004D4
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 01:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjATBy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 20:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjATByZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 20:54:25 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BEE5C0C6
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 17:54:23 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f34so5917501lfv.10
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 17:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V/Nt4HC05twtR40mBc6P5bObWTD9iOxCrYwb3g23RMA=;
        b=pooMBfQ629oB9d0rAbNQCnWnA6031kqnOPwHdFgDVROii1+dueyBYnG8b0PLl0Hxmf
         3ZDSzA9/Lak5cmmr7lh8Mcu7Rbrd64d58IB7I6bV+ENx/iusp65aWSIMjKlGEIUq0sG4
         3urFsNyTYPUEoq/+pQBuQu7Xbs/uE2+N5rGdBhxOOYWgWSiOt7855ZvbVIfFds934RZL
         ZJBTPKI+B2ec4HpGr50+wL+Eg+Hu8NHAVyBbj3SSRs0lRASsncVeAIvhA6PLBxdbvfw0
         MXDO3R+F66mm0L74JT9JwX8edcgFMJxRlVt5pUIeXqpn5n/r9FWh9Qx6gGoBuQq32ihX
         NhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/Nt4HC05twtR40mBc6P5bObWTD9iOxCrYwb3g23RMA=;
        b=sor/ScGwBHRsGB5r2JtbvqOGTuG/ahvomjMx/M3PsGCN3ENvMDgYtku3RIaX6uRSav
         RJTZ6blGuWhp8Gz+MVZyQ6/gC5Y+r+ApX2enAAUJft8FvhZlSjqBNNnT2HE6WnT75QAQ
         NweNyX/AGBkj4IgGL9mBwt/ZqJ3o+4GdA2xG2UHBAVu9w57l58xQJPwrrbe8TIiqWh+B
         Jb9m84CVE9j4LtPi+NfS0ah2X/0SR8mM2MjDT5RGpPH5KJIClsV3S/JunpIFngoa3iZH
         hIfxI6oHybBMpYskUeLameskKDA8OcMoF4VD5wYVP5/PjuksLR20pAHKk5kCxABEu+hk
         uvUg==
X-Gm-Message-State: AFqh2krpzF+uXfVU4/DkDPGNc/hmv2Nf1bvzjnASFkcaimVmQYb38c6c
        RAyaR04cXcFiuiBLqzGBLaIjP2Pr1+GrlYTpzbGF0WYc8N4=
X-Google-Smtp-Source: AMrXdXupvPWLSQIJtONDytbuZOUytsmOeAbGVvraGCXr+sEKxrR77TvyeVfNBH3Gaiw2fIAf8V2BG+ozh4Ykrh/iLX4=
X-Received: by 2002:a05:6512:3e11:b0:4cb:d46:94b7 with SMTP id
 i17-20020a0565123e1100b004cb0d4694b7mr672613lfv.405.1674179661425; Thu, 19
 Jan 2023 17:54:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com> <f480813c-7583-179f-0149-d970d3f2519f@github.com>
In-Reply-To: <f480813c-7583-179f-0149-d970d3f2519f@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Jan 2023 17:54:08 -0800
Message-ID: <CABPp-BFMJZx8BfWK5NPSt_4Mjz+MGA7d6_jwBivm-5A9fovbWw@mail.gmail.com>
Subject: Re: [PATCH] rebase: mark --update-refs as requiring the merge backend
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2023 at 1:47 PM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 1/19/2023 12:36 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > --update-refs is built in terms of the sequencer, which requires the
> > merge backend.  It was already marked as incompatible with the apply
> > backend in the git-rebase manual, but the code didn't check for this
> > incompatibility and warn the user.  Check and warn now.
>
> Thank you for submitting this version.
>
> > @@ -1514,6 +1514,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >               }
> >       }
> >
> > +     if (options.update_refs)
> > +             imply_merge(&options, "--update-refs");
> > +
>
> This solution is very elegant. The only downside is the lack of warning
> if --update-refs was implied by rebase.updateRefs=true, but I'm happy to
> delay implementing that warning in favor of your complete solution here.
>
> Thinking ahead to that option, are there other options that are implied
> by config that are required in imply_merge()? Is --autosquash in that
> camp? If so, then maybe it would make sense to expand imply_merge() to
> include a boolean config key and supply that warning within its
> implementation. (This consideration should not block this patch, as it
> is complete as-is.)

Ooh, that does sound like a useful future idea to improve things further.

> > While at it, fix a typo in t3422...and fix some misleading wording (all
> > useful options other than --whitespace=fix have long since been
> > implemented in the merge backend).
>
> >  #
> > -# Rebase has lots of useful options like --whitepsace=fix, which are
> > -# actually all built in terms of flags to git-am.  Since neither
> > -# --merge nor --interactive (nor any options that imply those two) use
> > -# git-am, using them together will result in flags like --whitespace=fix
> > -# being ignored.  Make sure rebase warns the user and aborts instead.
> > +# Rebase has a useful option, --whitespace=fix, which is actually
> > +# built in terms of flags to git-am.  Since neither --merge nor
> > +# --interactive (nor any options that imply those two) use git-am,
> > +# using them together will result in --whitespace=fix being ignored.
> > +# Make sure rebase warns the user and aborts instead.
> >  #
>
> Thanks for the update here. The -C option is also used in this test,
> so --whitespace=fix isn't the only option, right? At least, -C doesn't
> make sense to port over to the merge backend, so maybe that's what
> you mean by --whitespace=fix being the last one?

Sorry if it was confusing.  I was trying to figure out how to word it
to remove the old confusion, and actually spent a while thinking about
this point you brought up...but after a while gave up and just
submitted my patch because it was taking too long and I didn't think
the -C option was worth as much brain power as has been spent on it.
But since you noted the incongruity, let me explain my thought process
a little...

* I stated that --whitespace=... was the last *useful* option, not
that it was the last option.  Yes, that was an implicit assertion that
-C is not useful, though I avoided stating it directly for fear I'd
have to dig up proof and/or spend a bunch of time trying to reproduce
an old bug and debug it.

* The correct way to port the '-C' option to the merge backend would
probably be to just accept the flag and ignore it.  The merge backend
already functions with entire files or essentially infinite context.
I can't think of any case where ignoring this option would result in
negative surprises, other than possibly confusing people about how the
algorithm behaves and making them decide to tweak it to no avail.  And
even if users were to waste time twiddling that flag in combination
with the merge backend, even that might be a correct "port" of the
existing -C option because...

* I once tried to use the '-C' option with the apply backend to see if
it could workaround a bug inherent to the apply backend (where people
have a source file with several very similar code blocks, and rebase
or am applying changes to the wrong one due to fuzz factor and large
deletions/insertions having happened upstream elsewhere in the file).
It appeared to have absolutely no effect.  I suspected it was buggy,
but didn't feel the option was worth debugging (I thought switching
the default rebase backend was a much better use of time).

* We have *zero* tests of the functionality of rebase's -C option in
the testsuite.  The only testing we do for rebase's -C option is
solely around option parsing.

....

And you inspired me to do some digging.  rebase -C was introduced with
67dad687ad ("add -C[NUM] to git-am", 2007-02-08).  Based on feedback
on the patch, the author added the -C option not just to git-am but
also to git-rebase.  However, the way it was added to rebase was to
just pass it through to git-am, with no corresponding option to
format-patch.  Therefore, format-patch is going to continue generating
patches with 3 lines of context, while we tell git-am/git-apply to pay
attention to more than 3 lines of context.  The -C<num> option is
documented as using all available context if <num> exceeds the number
of lines of context provided in the input patches.  So, the -C option
to rebase has never done anything useful, and the port from the legacy
rebase script to the builtin C did not accidentally introduce any
modicum of utility to this option; rather, it faithfully ported this
pointless option precisely as-is.

So, I'll adjust this series to include a preliminary patch that rips
the rebase -C option out.

> The user could also explicitly request the apply backend with --apply,
> but this test script doesn't check it, strangely. That seems like an
> oversight, but not a drawback to your patch.
>
> >  test_rebase_am_only () {
> > @@ -60,6 +60,11 @@ test_rebase_am_only () {
> >               test_must_fail git rebase $opt --exec 'true' A
> >       "
> >
> > +     test_expect_success "$opt incompatible with --update-refs" "
> > +             git checkout B^0 &&
> > +             test_must_fail git rebase $opt --update-refs A
> > +     "
> > +
>
> Thanks for adding this test. I would delay the rebase.updateRefs
> version until there is extra behavior to check, such as the
> warning message.
>
> Thanks,
> -Stolee
