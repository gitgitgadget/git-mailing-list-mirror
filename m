Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB49CC2BB48
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EEB2251E
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgLORMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbgLORL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 12:11:56 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B913C06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:11:16 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id p126so24098638oif.7
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rb2D/Z/At77RfQ44rVRjrM0Q/k+g5vaWXsb0Y/GAn60=;
        b=s4Q0Hm+nzUBJNjY93lCKzO2wKHB+zKwo5LQ20o+clmth8lOPuo8PU+a1MpeONleJaD
         pxQeG71ljNN+qVsOZV5shoMOz4la0BBAogm16jckWsKyn6ghNo9DCG8zgiXgy7m7BI7V
         WRZudwmDMzNFuNzc6rmqwsHuJYeeABIie+qVTk+mfIeIzLMZZfRk2tkYchlyuf2DVCZo
         vSsIo5tDRPbsk8B+Cbgt2oQk0LWFvBHyYOQCKzEoZlJNtIO1BlxMyGAYzgjLHS26yqmR
         E1BO1nIChVuBcCfDnDNYNRzhnuXcFxsL0chWK6xyLUr6Nfnl9hL0ZZbQXda0hOns2THa
         mgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rb2D/Z/At77RfQ44rVRjrM0Q/k+g5vaWXsb0Y/GAn60=;
        b=CLgz1TfAErnZsH/YbBSjwilI7kXBf+wM1KzZSLaCdetBNAmOSNDDv2deInlkjk5sO+
         7IU0YWui4nq4Q0Pvu9h6GcA+HaseccSGPv57JmDh9P0GhWJpM5WBqXAwtHlvIiueqFy8
         3sF1Ij5+OS5PrkH0OHRRdiqs4AHxfO93gOVtPbMykG9T/nE+E1tbuIQ/UwIdVyOruh8d
         q6sjGPwYZe7g/gpoOKWYIq+tGum5Uitcn3roqxa04jX5G7qsMuR35+mHYsjabWRtZQkw
         mZSO/OPQujPa8ag/1FL3ErA79TelqR84WEPAnTVMJWAxTCKllWdViuEyJ95/ihFrz7Mz
         2XBg==
X-Gm-Message-State: AOAM53063+RTqwBoSr5xR8Mn4qSMLkBLXVel75Y69NbQXPdDShdgPqlI
        lPVMMekNh0ZvrMMrVBRkf4AVgT17000+9xekI/g=
X-Google-Smtp-Source: ABdhPJxQXTa/O52Gzpvwyb6vx11XRzRt/ZddNALXlqco88yqlS9Ser2V8WZf3FMTIxlL84WScm44zPBNbpFSyqHaFqw=
X-Received: by 2002:a05:6808:991:: with SMTP id a17mr21761995oic.167.1608052275635;
 Tue, 15 Dec 2020 09:11:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <pull.812.v2.git.1607962900.gitgitgadget@gmail.com> <ff09ddb9caf73632c9792c07f1f7499a75a09606.1607962900.git.gitgitgadget@gmail.com>
 <fcc6b18e-c5eb-27a1-b6b5-4dcdd97e2b90@gmail.com>
In-Reply-To: <fcc6b18e-c5eb-27a1-b6b5-4dcdd97e2b90@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Dec 2020 09:11:04 -0800
Message-ID: <CABPp-BGSCeffT-VnniGXM8D8BC=T6YWHr4ei2ij+1-+0ghg8OA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] merge-ort: add implementation of type-changed
 rename handling
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 6:31 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/14/2020 11:21 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Implement cases where renames are involved in type changes (i.e. the
> > side of history that didn't rename the file changed its type from a
> > regular file to a symlink or submodule).  There was some code to handle
> > this in merge-recursive but only in the special case when the renamed
> > file had no content changes.  The code here works differently -- it
> > knows process_entry() can handle mode conflicts, so it does a few
> > minimal tweaks to ensure process_entry() can just finish the job as
> > needed.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 9aac33c8e31..11e33f56edf 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -778,7 +778,32 @@ static int process_renames(struct merge_options *opt,
> >                        S_ISREG(newinfo->stages[target_index].mode));
> >               if (type_changed && collision) {
> >                       /* special handling so later blocks can handle this */
>
> Perhaps drop this comment, or incorporate it into the lower one?

Will do.

> > -                     die("Not yet implemented");
> > +                     /*
> > +                      * if type_changed && collision are both true, then this
> > +                      * was really a double rename, but one side wasn't
> > +                      * detected due to lack of break detection.  I.e.
> > +                      * something like
> > +                      *    orig: has normal file 'foo'
> > +                      *    side1: renames 'foo' to 'bar', adds 'foo' symlink
> > +                      *    side2: renames 'foo' to 'bar'
> > +                      * In this case, the foo->bar rename on side1 won't be
> > +                      * detected because the new symlink named 'foo' is
> > +                      * there and we don't do break detection.  But we detect
> > +                      * this here because we don't want to merge the content
> > +                      * of the foo symlink with the foo->bar file, so we
> > +                      * have some logic to handle this special case.  The
> > +                      * easiest way to do that is make 'bar' on side1 not
> > +                      * be considered a colliding file but the other part
> > +                      * of a normal rename.  If the file is very different,
> > +                      * well we're going to get content merge conflicts
> > +                      * anyway so it doesn't hurt.  And if the colliding
> > +                      * file also has a different type, that'll be handled
> > +                      * by the content merge logic in process_entry() too.
> > +                      *
> > +                      * See also t6430, 'rename vs. rename/symlink'
>
> I appreciate the callout to a test that exercises this behavior.
>
> > +                      */
> > +                     collision = 0;
> > +             }
>
> Here, we regain that closing curly brace, fixing the compiler errors from
> earlier.

So embarrassing.  I was pretty sure I tested the individual patches,
but maybe I somehow missed this series??  Anyway, yeah, I'll fix it
up.

>
> >               if (source_deleted) {
> >                       if (target_index == 1) {
> >                               rename_branch = opt->branch1;
> > @@ -858,7 +883,11 @@ static int process_renames(struct merge_options *opt,
> >                       newinfo->pathnames[0] = oldpath;
> >                       if (type_changed) {
> >                               /* rename vs. typechange */
> > -                             die("Not yet implemented");
> > +                             /* Mark the original as resolved by removal */
> > +                             memcpy(&oldinfo->stages[0].oid, &null_oid,
> > +                                    sizeof(oldinfo->stages[0].oid));
> > +                             oldinfo->stages[0].mode = 0;
> > +                             oldinfo->filemask &= 0x06;
>
> This matches your explanation in the comment above. I wonder if 0x06
> could be less magical, but we are really deep in the weeds here already.
>
> Thanks,
> -Stolee
>
