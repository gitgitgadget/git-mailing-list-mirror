Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD285C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897CE6109E
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbhGOQGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhGOQGf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 12:06:35 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782DAC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:03:41 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u15so7212088oiw.3
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Xj0ZX2u2/XND3TyEFXYp3cJjFIR5ity+3tpH8OpYRk=;
        b=UKG1FgvMIAjoLw+m80X22oghoRrStbsCmz2lsW4hE+FJManN09ZnQa7sHAfZkzNjbL
         CDV1JYCnGJTMR3JZfXKkR0Eo7nWIKvAlUBJyYkSWPuG8j3JA6v5qvvD6xX7RXPaQtraR
         7n/E3UAHrKs7si5XHiAzZ3DGB9/VQwO3aIynRV3x0Vc9T8sFN0lN6jPDwbu70/pPbI11
         zM4ewWdSraVW1u2q/IrDMjsO+5e5U4wjphIDTN8b7xbiLuJvyBen6XsdWX4YJmfcvO1w
         hYvrM6Q+XghldawRxTdGzUWAf+L+s8Jr/4yOMxvJ8ZXBPWsmiwTnvp6G1G50u72nJ9Qj
         orcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Xj0ZX2u2/XND3TyEFXYp3cJjFIR5ity+3tpH8OpYRk=;
        b=jMjZpkU2PTUy5kLgU5XJ/MtrJnHaonvfq092KjFYuam52NpOhHPLYwpuEJUu0k5bDz
         2QSA7xI2h/j/HDpXB31FaKAH+BZfi1BQ0skDFBzd+ikGFFZ/zCrVgsEsAUqVQ1N4QZB+
         fD7qu8wWPfNk6F4vL1y+PrSnv7mVftaGkVTECDH9qhXLMQuPqoOJRQFlAuneEQEFjbZm
         jwdFH7nt6fUDYbH2bYw5v4egx6OHf/IAf1OjA6YplS16NQNtJG1HfROXGA+MRFebscx2
         XBt+nh1mPAxN01qrREV0jbf9wzr+tLhI6rt9eEMbRccD28xZGu0kKX+F0ouQmbkcDbfb
         Ql3g==
X-Gm-Message-State: AOAM533I3+IuMJhvTmDIqoS4CNuv30f6CspgV27mbJjgaBGhBXkbTnFm
        xPhJVrbZObGMCCTcld5Z+/ALNcaRdXjdCo53liQ=
X-Google-Smtp-Source: ABdhPJyV2XmvoQsmUz32Cvw7Z5BUAlJCSPkRhn4lfBZ72jhYws0NcnKCHlYhICfJUbdNkwfRnxGaVMNwY1Hv5t8+TUc=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr8468490oie.167.1626365020865;
 Thu, 15 Jul 2021 09:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com> <317553eadb68ce162b5ebea24045a9ca75342e91.1626204784.git.gitgitgadget@gmail.com>
 <24a7bea5-6325-289d-8d49-619b5e7ec65b@gmail.com>
In-Reply-To: <24a7bea5-6325-289d-8d49-619b5e7ec65b@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 15 Jul 2021 09:03:29 -0700
Message-ID: <CABPp-BGX-02M2Aw+Fw-bArNd5tOdp_sgcE_oRGiTDicNsgxdgA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] merge-ort: defer recursing into directories when
 merge base is matched
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 7:43 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/13/2021 3:33 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> ...
> > +             /*
> > +              * Check for whether we can avoid recursing due to one side
> > +              * matching the merge base.  The side that does NOT match is
> > +              * the one that might have a rename destination we need.
> > +              */
> > +             assert(!side1_matches_mbase || !side2_matches_mbase);
> > +             side = side1_matches_mbase ? MERGE_SIDE2 :
> > +                     side2_matches_mbase ? MERGE_SIDE1 : MERGE_BASE;
> > +             if (filemask == 0 && (dirmask == 2 || dirmask == 4)) {
> > +                     /*
> > +                      * Also defer recursing into new directories; set up a
> > +                      * few variables to let us do so.
> > +                      */
> > +                     ci->match_mask = (7 - dirmask);
> > +                     side = dirmask / 2;
>
> Clever.
>
> > +             }
> > +             if (renames->dir_rename_mask != 0x07 &&
> > +                 (side != MERGE_BASE) &&
>
> nit: these parens are not necessary?

Indeed; I'll remove them.

> > +                 renames->trivial_merges_okay[side] &&
> > +                 !strset_contains(&renames->target_dirs[side], pi.string)) {
>
> Does this last condition mean "this directory is not already a parent of a
> chosen rename target"?

I'm not sure what you mean by "chosen" here.  If by "chosen" you mean
"cached" (which comes from ort-perf-batch-11's caching of upstream
renames from previously cherry-picked commits), then yes.

Perhaps it's worth noting that rename detection has not yet been run
for this merge by the time we hit this logic, so the only renames we
can know are the cached ones from a previous pick.

> > +                     strintmap_set(&renames->possible_trivial_merges[side],
> > +                                   pi.string, renames->dir_rename_mask);
> > +                     renames->dir_rename_mask = prev_dir_rename_mask;
> > +                     return mask;
> > +             }
> > +
> > +             /* We need to recurse */
> >               ci->match_mask &= filemask;
> Thanks,
> -Stolee
