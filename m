Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A40C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 20:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAABF61040
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 20:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhG1UEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 16:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhG1UEp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 16:04:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91308C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 13:04:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x90so4859588ede.8
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZhdosbgoLlG9CC2K6sMBs5XLkqaQa4w3+zCVngSgAI=;
        b=v4zb/m1Y6shCqEv3pTGEeTXUDiMQ+9kpgnNjehR19t8E/VChK+BtfUekyqutDPKA6W
         +JIx6IgT/00no/vVjVnzw986WA739ppthg11GQ/ALCJPvb/XQmt+PrK8b8xbWFLh+zCR
         k8P6CoKAYa24JAQabk8LyQ9bIRjR0vdpAZbAwVkk/sV5n97DSNvaby9geYdk23ii29ar
         vM2ibnOi8eTg0tv6tnbXR3qALfrQ3e0UQPgBJtwYmmis+jimwkbjr7lAyXA1K4H+jy4X
         Tezf7LRd+V1/1MVxNNFIZ7yorrm2HQ07LnNktYwV/pes/uVS2PdquzCMieyj3v4cQyYs
         +zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZhdosbgoLlG9CC2K6sMBs5XLkqaQa4w3+zCVngSgAI=;
        b=Q89qcRSXATLY72udR1nkswLePj4jI7UPerGMI4nnv90JtcoRMyWdPVggvRVG6r2Egm
         om5DWpKjB/Dmn9BX9i7DAzE9NKK3wkOcYzLmxp22KvREjLkAqBqPtjfDsuO1P+8mEU/v
         +HU37giQD30IW4+qV4rKDFQzrPEwxvUFnnnH6IEC/Se/va5qIYbQ2FfPtdIXcFsMrm5h
         Fs9w+sQ2dZ/9wRM0i55CPHxL/xECieCec/KXWL4BgQ0F9fLColb0eHp0W8T6XKv+ybbK
         +u0rIbkHc+UwfPYY/wuShR6iEqJRP76t8Wj4+Hmc95lta1PCs/nWWy8x30qA4qB2uSCn
         4YlA==
X-Gm-Message-State: AOAM532xwTqvOv0OAaw4Wz/ZC8Bnpv604/Yf9Xa8ajA9Pc927QBOcXEy
        sDmahc9l6ljSe3v91rQpFxZ8EYkOHARroCbHKnc7HA==
X-Google-Smtp-Source: ABdhPJwSbXyuTSETsMh71Qs4CtBosFW/bBXSD/cIMyeRmbkdB+Gqg4tv+8o7NlU6bzmFwanyqrJklIhI1+BRlsThL2s=
X-Received: by 2002:a05:6402:1e91:: with SMTP id f17mr1764134edf.133.1627502682097;
 Wed, 28 Jul 2021 13:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210728024434.20230-1-jerry@skydio.com> <xmqqh7gfawlt.fsf@gitster.g>
 <CAMKO5CvZCMHuzRLSs2aHJ3iUH-LBJfFP3fG+GgwtQvsKQPtT5Q@mail.gmail.com>
In-Reply-To: <CAMKO5CvZCMHuzRLSs2aHJ3iUH-LBJfFP3fG+GgwtQvsKQPtT5Q@mail.gmail.com>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Wed, 28 Jul 2021 13:04:31 -0700
Message-ID: <CAMKO5CsPK65wzkJSYv6dHO4wjsX1+U7yX5P95jS3UHXKThMjqw@mail.gmail.com>
Subject: Re: [PATCH] git-apply: fix --3way with binary patch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, lilinchao@oschina.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 28, 2021 at 12:38 PM Jerry Zhang <jerry@skydio.com> wrote:
>
> On Tue, Jul 27, 2021 at 9:30 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Jerry Zhang <jerry@skydio.com> writes:
> >
> > > Binary patches applied with "--3way" will
> > > always return a conflict even if the patch
> > > should cleanly apply because the low level
> > > merge function considers all binary merges
> > > without a variant to be conflicting.
> > >
> > > Fix by falling back to normal patch application
> > > for all binary patches.
> > >
> > > Add tests for --3way and normal applications
> > > of binary patches.
> > >
> > > Fixes: 923cd87ac8 ("git-apply: try threeway first when "--3way" is used")
> > > Signed-off-by: Jerry Zhang <jerry@skydio.com>
> > > ---
> > >  apply.c                   |  3 ++-
> > >  t/t4108-apply-threeway.sh | 45 +++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 47 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/apply.c b/apply.c
> > > index 1d2d7e124e..78e52f0dc1 100644
> > > --- a/apply.c
> > > +++ b/apply.c
> > > @@ -3638,7 +3638,8 @@ static int apply_data(struct apply_state *state, struct patch *patch,
> > >       if (load_preimage(state, &image, patch, st, ce) < 0)
> > >               return -1;
> > >
> > > -     if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0) {
> > > +     if (!state->threeway || patch->is_binary ||
> > > +             try_threeway(state, &image, patch, st, ce) < 0) {
> >
> > Thanks for a quick turnaround.  However.
> >
> > Because apply.c::three_way_merge() calls into ll_merge() that lets
> > the low-level custom merge drivers to take over the actual merge, I
> > do not think your "if binary, bypass and never call try_threway() at
> > all" is the right solution.  The custom merge driver user uses for
> > the path may successfully perform such a "trivial" three-way merge
> > and return success.
> I understand now, thanks for the explanation
> >
> > Why does the current code that lets threeway tried first fails to
> > fall back to direct application?  The code before your change, if
> > fed a binary patch that does not apply, would have failed the direct
> > application first *and* then fell back to the threeway (if only to
> > fail because we do not let binary files be merged), no?
> >
> > Is it that try_threeway()'s way to express failure slightly
> > different from how direct application reports failure, but your
> > change used the same "only if it is negative, we fail and fallback"
> > logic?  IIRC, apply_fragments() which is the meat of the direct
> > application logic reports failures by negative, but try_threeway()
> > can return positive non-zero to signal a "recoverable" failure (aka
> > "conflicted merge").  Which should lead us to explore a different
> > approach, which is ...
> >
> >     Would it be possible for a patch to leave conflicts when
> >     try_threeway() was attempted, but will cleanly apply if direct
> >     application is done?
> >
> > If so, perhaps
> >
> >  - we first run try_threeway() and see if it cleanly resolves; if
> >    so, we are done.
> >
> >  - then we try direct application and see if it cleanly applies; if
> >    so, we are done.
> >
> >  - finally we run try_threeway() again and let it fail with
> >    conflict.
> >
> > might be the right sequence?  We theoretically could omit the first
> > of these three steps, but that would mean we'd write 923cd87a
> > (git-apply: try threeway first when "--3way" is used, 2021-04-06)
> > off as a failed experiment and revert it, which would not be ideal.
> >
> >
> > Also, independent from this "if we claim we try threeway first and
> > fall back to direct application, we really should do so" fix we are
> > discussing, I think our default binary merge can be a bit more
> > lenient and resolve this particular case of applying the binary
> > patch taken from itself (i.e. a patch that takes A to B gets applied
> > using --3way option to A).  I wonder if it can be as simple as the
> > attached patch.  FWIW, this change is sufficient (without the change
> > to apply.c we are reviewing here) to make your new tests in t4108
> > pass.
> So basically, another way of stating the problem would be that binary
> patches can apply cleanly with direct application in some cases where
> merge application is not clean. If i understand correctly this is unique
> to binary files, although it would be possible for a user to supply a custom
> merge driver for text files that is worse than direct application, that is
> most likely heavy user error that we shouldn't have to cater to. However
> the issue with binary is that the *default* merge driver is actually worse
> than direct application (in some cases). Therefore our options are
>
> 1. do as you suggest and run 3way -> direct -> 3way. I would modify
> this and say we should only attempt this for binary patches, since a text
> file that fails 3way would most likely also fail direct, so it would be a waste
> of time to try it. furthermore if we cache results from the first 3way and
> return them after attempting direct, it can save us from having to compute
> the 3way twice, so would be no worse than our current performance.
>
> 2. improve the default binary merge driver to be at least as good as direct
> application. this would allow us to say overall that "merge drivers should
> be at least as intelligent as direct patch application" and would greatly
> simplify logic in apply.c. Your change is a good first step in allowing it
> to handle more cases. A trivial way to make the binary merge driver
> at least as good as patch application is to generate a patch and apply
> it as part of the merge. I imagine this would have other consequences
> though as many parts of git use the binary merge driver.

Hmm I would have thought that binary patches allow context, similar to this
test snippet
"
 test_expect_success 'apply complex binary file patch' '
     git reset --hard main &&
     cp $TEST_DIRECTORY/test-binary-1.png bin.png &&
     git add bin.png &&
     git commit -m "add binary file" &&

     echo 1 >>bin.png &&
     git diff --binary >bin.diff &&
     git reset --hard &&

     cat $TEST_DIRECTORY/test-binary-2.png
$TEST_DIRECTORY/test-binary-1.png >bin.png &&
     git add bin.png &&
     git commit -m "change binary file" &&

     # Apply must succeed.
     git apply bin.diff
 '
"
but upon running it I see that normal patch application still requires the
preimage to match exactly.
"
error: the patch applies to 'bin.png'
(836481bd1b9b6bd7a1bb8939cf4ea01e05946850), which does not match the
current contents.
error: bin.png: patch does not apply
"

So at least in regards to making the default binary merge driver "at
least as intelligent" as
direct patch application, your patch ought to do it.

>
> Separately I think it would be a worthwhile follow-up patch to also handle
> trivial three-way merges in try_threeway(). This would:
> 1. Allow us to compare oid instead of the entire file buffer, which would be
> faster.
> 2. Handle trivial merges of all file types, which would save time.
>
> >
> > ---- >8 ------- >8 ------- >8 ------- >8 ------- >8 ------- >8 ----
> > Subject: ll-merge: teach ll_binary_merge() a trivial three-way merge
> >
> > The low-level binary merge code assumed that the caller will not
> > feed trivial merges that would have been resolved at the tree level;
> > because of this, ll_binary_merge() assumes the ancestor is different
> > from either side, always failing the merge in conflict unless -Xours
> > or -Xtheirs is in effect.
> >
> > But "git apply --3way" codepath could ask us to perform three-way
> > merge between two binaries A and B using A as the ancestor version.
> > The current code always fails such an application, but when given a
> > binary patch that turns A into B and asked to apply it to A, there
> > is no reason to fail such a request---we can trivially tell that the
> > result must be B.
> >
> > Arguably, this fix may belong to one level higher at ll_merge()
> > function, which dispatches to lower-level merge drivers, possibly
> > even before it renormalizes the three input buffers.  But let's
> > first see how this goes.
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  ll-merge.c | 56 +++++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 39 insertions(+), 17 deletions(-)
> >
> > diff --git c/ll-merge.c w/ll-merge.c
> > index 261657578c..bc8038d404 100644
> > --- c/ll-merge.c
> > +++ w/ll-merge.c
> > @@ -46,6 +46,13 @@ void reset_merge_attributes(void)
> >         merge_attributes = NULL;
> >  }
> >
> > +static int same_mmfile(mmfile_t *a, mmfile_t *b)
> > +{
> > +       if (a->size != b->size)
> > +               return 0;
> > +       return !memcmp(a->ptr, b->ptr, a->size);
> > +}
> > +
> >  /*
> >   * Built-in low-levels
> >   */
> > @@ -58,9 +65,18 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
> >                            const struct ll_merge_options *opts,
> >                            int marker_size)
> >  {
> > +       int status;
> >         mmfile_t *stolen;
> >         assert(opts);
> >
> > +       /*
> > +        * With -Xtheirs or -Xours, we have cleanly merged;
> > +        * otherwise we got a conflict, unless 3way trivially
> > +        * resolves.
> > +        */
> > +       status = (opts->variant == XDL_MERGE_FAVOR_OURS ||
> > +                 opts->variant == XDL_MERGE_FAVOR_THEIRS) ? 0 : 1;
> > +
> >         /*
> >          * The tentative merge result is the common ancestor for an
> >          * internal merge.  For the final merge, it is "ours" by
> > @@ -68,18 +84,30 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
> >          */
> >         if (opts->virtual_ancestor) {
> >                 stolen = orig;
> > +               status = 0;
> >         } else {
> > -               switch (opts->variant) {
> > -               default:
> > -                       warning("Cannot merge binary files: %s (%s vs. %s)",
> > -                               path, name1, name2);
> > -                       /* fallthru */
> > -               case XDL_MERGE_FAVOR_OURS:
> > -                       stolen = src1;
> > -                       break;
> > -               case XDL_MERGE_FAVOR_THEIRS:
> > +               if (same_mmfile(orig, src1)) {
> >                         stolen = src2;
> > -                       break;
> > +                       status = 0;
> > +               } else if (same_mmfile(orig, src2)) {
> > +                       stolen = src1;
> > +                       status = 0;
> > +               } else if (same_mmfile(src1, src2)) {
> > +                       stolen = src1;
> > +                       status = 0;
> > +               } else {
> > +                       switch (opts->variant) {
> > +                       default:
> > +                               warning("Cannot merge binary files: %s (%s vs. %s)",
> > +                                       path, name1, name2);
> > +                               /* fallthru */
> > +                       case XDL_MERGE_FAVOR_OURS:
> > +                               stolen = src1;
> > +                               break;
> > +                       case XDL_MERGE_FAVOR_THEIRS:
> > +                               stolen = src2;
> > +                               break;
> > +                       }
> >                 }
> >         }
> >
> > @@ -87,13 +115,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
> >         result->size = stolen->size;
> >         stolen->ptr = NULL;
> >
> > -       /*
> > -        * With -Xtheirs or -Xours, we have cleanly merged;
> > -        * otherwise we got a conflict.
> > -        */
> > -       return opts->variant == XDL_MERGE_FAVOR_OURS ||
> > -              opts->variant == XDL_MERGE_FAVOR_THEIRS ?
> > -              0 : 1;
> > +       return status;
> >  }
> >
> >  static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
