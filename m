Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3216EC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 05:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiBOFCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:02:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiBOFCU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 00:02:20 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61DEDD45F
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 21:02:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b14so5737209ede.9
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 21:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pe2iQuqH0+IiDSqNyve40IuDFDwE4nviMqRrde+2sPw=;
        b=HIVjYvXyop1sb1RcXNh01PCsMTb/LrFcIrcTRtm0Vn84/t3G5hK3RpL9HjLS4kF4yS
         DtdK6xomWRkOcRZsjWepYiNcrCNjKHNt5qyc1xtxY9PqnSQgX8T5udDZin5Q3TFDur8V
         rH2yDFdkqVbwJVz2mAfvHPtv75JoFc3xK6iV3bt8wdDsqD+qyKeNiV1kGpchowohJmJJ
         dQgWinJlD7NI04Neu0LszEkQHD6VmSGmw4/u2/ecAtWTzJNhDNB9XrCWrSpNHxWyZ9Bx
         r3w1im8yoOWok5lw282lXEAgBYT/IJ51KDs1vXtRI2RRSXDo8VPgHLPptV1ZumWRiIlo
         NLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pe2iQuqH0+IiDSqNyve40IuDFDwE4nviMqRrde+2sPw=;
        b=jbbNiNE8QI87d71Ks+hJUtEeQPHRbbonJkVJSkFecHm2s1ljNS7I4OTEZAJmzFAAM4
         5HDGysjYOmFGSjRCk5tFmtiwgn3vsLp7SYIsUjE3vfWBCmPrzihSuExAOgGPznwMwB3Q
         As4jRXktq5G2JtFHMu/jexFXODkRm6Vz2btgfiI9sTATa2QhzrcKzMqoUupsslGw2SIa
         MLyfzGByOz9R9yPChVmIlq5Oru0V0sgdGzZtAdl11RNvIRaY9jDuP5633q+Lb9aA+Jl2
         aAKgHx79DCkUgGwyhZCtIQLl/+UgRwS8NMhe/bj9I24iiX3hjwcWiRFZzSJjzMkZGLpc
         R/JA==
X-Gm-Message-State: AOAM533FCL6pGn0heLcqYuYOnmEjkXhpjdzwzNubsRHdWaqwB20m+GYT
        LHnvxbl9j20hBron60yJXv6wykM84kEP0Yxy90Fj7nW32RJSWg==
X-Google-Smtp-Source: ABdhPJwuN0u7B+OvTZAqjECmWPHs1JjOmJE1fh2eC9U61gfQqm5vXzkWQRgvy40je5S/uSSuu7bef7vY/3itQvURyUc=
X-Received: by 2002:aa7:d316:: with SMTP id p22mr2172095edq.380.1644901329237;
 Mon, 14 Feb 2022 21:02:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <e30119b96dfaf9fdb82039cab84f8b81caacc1de.1644712798.git.gitgitgadget@gmail.com>
 <d9bdf8c0-a449-ef12-fa80-5976ea9bd6c4@github.com>
In-Reply-To: <d9bdf8c0-a449-ef12-fa80-5976ea9bd6c4@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Feb 2022 21:01:57 -0800
Message-ID: <CABPp-BF-m5rTVzg2uoD3MK-GaU+FXn0Es+qG_TW9+_e0viPDUA@mail.gmail.com>
Subject: Re: [PATCH 7/7] sparse-checkout: make --cone the default and
 deprecate --no-cone
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 14, 2022 at 8:14 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Make --cone mode the default, and deprecate --no-cone mode.  While we
> > have no current plans to actually remove --no-cone mode, we think users
> > would be better off not using it.  Update the documentation accordingly,
> > including explaining why we think non-cone mode is problematic for
> > users.
>
> "deprecate" is a good word here. The functionality remains, but we make
> clear recommendations to not use it.
>
> > While at it, since the new default just uses directories and removes the
> > need to understand patterns, we can mark multiple sections in the manual
> > as "INTERNALS" to reflect the fact that users do not need to wade
> > through those sections to understand how to use the command any more.
> > We can instead add a simple EXAMPLES section to the manual which
> > distills the necessary bits from the more complex INTERNALS sections.
>
> > -SPARSE CHECKOUT
> > ----------------
> > +EXAMPLES
> > +--------
> > +`git sparse-checkout set MY/DIR1 SUB/DIR2`::
> > +
> > +     Change to a sparse-checkout with all files (at any depth) under
> > +     MY/DIR1/ and SUB/DIR2/ present in the working copy (plus all
> > +     files immediately under MY/ and SUB/ and the toplevel
>
> Do we like "toplevel" or "top-level"?

For consistency with the rest of the project, we should probably use
"toplevel" twice as frequently as "top-level":

$ git grep toplevel | wc -l
258
$ git grep top-level | wc -l
127

;-)

>
> > +     directory).  If already in a sparse checkout, change which files
>
> There is some inconsistency between "a sparse checkout" and
> "a sparse-checkout" here. I'm happy with either as long as we
> stay consistent.
>
> > +     are present in the working copy to this new selection.  Note
> > +     that this command will also delete all ignored files in any
> > +     directory that no longer has either tracked or
> > +     non-ignored-untracked files present.
> > +
> > +`git sparse-checkout disable`::
> > +
> > +     Repopulate the working directory with all files, disabling sparse
> > +     checkouts.
> > +
> > +`git sparse-checkout add SOME/DIR/ECTORY`::
> > +
> > +     Add all files under SOME/DIR/ECTORY/ (at any depth) to the
> > +     sparse checkout, as well as all files immediately under
> > +     SOME/DIR/ and immediately under SOME/.  Must already be in a
> > +     sparse checkout before using this command.
> > +
> > +`git sparse-checkout reapply`::
> > +
> > +     It is possible for commands to update the working tree in a way
> > +     that does not respect the selected sparsity directories, either
> > +     because of special cases (such as hitting conflicts when
> > +     merging/rebasing), or because some commands didn't fully support
> > +     sparse checkouts (e.g. the old `recursive` merge backend had
> > +     only limited support).  This command reapplies the existing
> > +     sparse directory specifications to make the working directory
> > +     match.
> > +
> > +INTERNALS -- SPARSE CHECKOUT
> > +----------------------------
>
> I like this switch to talk about "internals".
>
> > +INTERNALS -- NON-CONE PROBLEMS
> > +------------------------------
> > +
> > +The `$GIT_DIR/info/sparse-checkout` file populated by the `set` and
> > +`add` subcommands is defined to be a bunch of patterns (one per line)
> > +using the same syntax as `.gitignore` files.  In cone mode, these
> > +patterns are restricted to matching directories (and users only ever
> > +need supply or see directory names), while in non-cone mode any
> > +gitignore-style pattern is permitted.  Using the full gitignore-style
> > +patterns in non-cone mode has a number of shortcomings:
> ...
> > +For all these reasons, non-cone mode is deprecated.  Please switch to
> > +using cone mode.
>
> I appreciate your very clear description here, as it helps make the
> case for us.
>
> > +INTERNALS -- FULL PATTERN SET
> > +-----------------------------
> > +
> > +As noted above, the sparse-checkout file uses the same syntax as
> > +`.gitignore` files; see linkgit:gitignore[5] for details.  Here, though,
> > +the patterns are being used to select which files to include rather than
> > +which files to exclude.
> > +
> > +To complicate things a bit further, while
> > +`$GIT_DIR/info/sparse-checkout` is usually used to specify what files
> > +are included, you can also specify what files are _not_ included, using
> > +negative patterns. For example, to select everything, and then to remove
> > +the file `unwanted`:
>
> ...
>
> > -----------------
> > +INTERNALS -- CONE PATTERN SET
> > +-----------------------------
>
> I wonder if this should be moved further up, above of the non-cone
> internals.
>
> > -The full pattern set allows for arbitrary pattern matches and complicated
> > -inclusion/exclusion rules. These can result in O(N*M) pattern matches when
> > -updating the index, where N is the number of patterns and M is the number
> > -of paths in the index. To combat this performance issue, a more restricted
> > -pattern set is allowed when `core.sparseCheckoutCone` is enabled.
> > +The full pattern set allows for arbitrary pattern matches and
> > +complicated inclusion/exclusion rules. As noted above, this can result
> > +in O(N*M) pattern matches when updating the index, where N is the number
>
> I see you are including information about O(N*M) "as noted above". I think
> the cone pattern set should shift to assume it's the first mode people read,
> and then the comparisons can happen in the non-cone mode internals.

Okay, I'll try reordering.

> >  If your repository contains one or more submodules, then submodules
> >  are populated based on interactions with the `git submodule` command.
> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index 6e0af166f80..aa2c66f15e3 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -395,13 +395,13 @@ static int update_modes(int *cone_mode, int *sparse_index)
> >
> >       /* Set cone/non-cone mode appropriately */
> >       core_apply_sparse_checkout = 1;
> > -     if (*cone_mode == 1) {
> > +     if (*cone_mode == 1 || *cone_mode == -1) {
> >               mode = MODE_CONE_PATTERNS;
> > -             core_sparse_checkout_cone = 1;
> > +             if (record_mode)
> > +                     core_sparse_checkout_cone = 1;
> >       } else {
> >               mode = MODE_ALL_PATTERNS;
> > -             if (record_mode)
> > -                     core_sparse_checkout_cone = 0;
> > +             core_sparse_checkout_cone = 0;
> >       }
>
> Ok, this "record_mode" is showing up again here, so I assume it is
> important and based on whatever is the default.

Actually, no, it was either from an earlier version of the series or
just a misunderstanding on my part.  It actually has no net effect;
I'll remove it.

> You are right that this commit is big. I think there are a few ways
> to split it up to be easier to review:
>
> 1. Make test changes to insert "--no-cone" wherever needed.
> 2. Make default switch in code and change docs only to say which is
>    the default.
> 3. Rename the sections of the document and move their current
>    contents.
> 4. Update the non-cone docs with the reasons for its deprecation.
>
> I also think that you've got two full _series_ on your hands. The
> patches 1-6 are likely easier to review quickly and get merged while
> we leave this deprecation series (this patch, split up as you see
> fit) up for discussion.

Yeah, that may make sense.  The first six patches won't have the same
dependencies on other series and might be able to be merged
independently (though there's some minor conflicts with
ds/sparse-checkout-requires-per-worktree-config).  The the last patch
will depend on 4 series -- this one, plus the other three I already
mentioned.

> I am in support of this idea, and I will make that case on your
> cover letter.

Thanks.
