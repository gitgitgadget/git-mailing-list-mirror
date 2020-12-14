Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C01AC2BB48
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C20520798
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408568AbgLNRhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 12:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502189AbgLNRgd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 12:36:33 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEA1C0613D3
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 09:35:35 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id d27so20048875oic.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 09:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7wQxsmoVl7X/0OTY8qkM7bBNKlzrKB0zbL86HVV0/w=;
        b=VHAmje1ebxZfi6Wi7Oc2yM93OKEJFje/iyc2znDOVzPCUDhbKxUBPIREkbz6Ef4KSy
         /XVwjugsElE9beixT+fMqncHwnq3ifHT+wL2+jg7aI550s58R+iIzjhD48HZeKIAz2tm
         rqo4x9uynBobXHCC4UR4IxEojvqEtAOtXVkmkK3xd1jrEOvdwaa4n1IvllI9mmXiBGDU
         YrqRnznaIOaOlX+M/0brgU27/VEx+XtUZcguTR+ZX6Qo5P4QVOLf+XcHl2ETq5mDbaQy
         XnGSLz9Mo1IMHm28mERpF35yZswEI68ITxBDsjJ8MKBE6c8rSKaBFiPeQCg5Iaa4e9Cv
         cyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7wQxsmoVl7X/0OTY8qkM7bBNKlzrKB0zbL86HVV0/w=;
        b=q+Rs+DYWaPwwdFVFz0QJ+MvoZmVo00/M7Dtfy9pUB6NYetiwalOqPds4p4SX9SdPU8
         Eg2/fBXEXYFZih1qG0iuHlmPzfrsH9Ul/pYAYkrcu/XH2GvbXApm4M1fUEoFGa2zThZG
         Rp4TzeoIUyQpcB2WQ2YQsJvqJ1S7MLyL60shocQwigxDWqnpbIAH2coZSLienWV9qiq6
         vDOmky8/Cm8gWhvy83K/GFCx7BIOqx3BoctNciKjLGilACP3bgNTd5xC+1Fs4ujcUYYp
         QUyttDhsWnIizjo3XNjqaGcWkjvHpb8z3optMCdJYdrPD9INVDD5RJUcpCM5/GKxOWWf
         pCZQ==
X-Gm-Message-State: AOAM532oD0wI74oKxtg5yccpOyP09HfETRoHFvmCgjt5OlkyxuNPabSI
        nFaiQLLBhK1k2ZirdtS9n1rLxGaHODpgES85iN8=
X-Google-Smtp-Source: ABdhPJzfmNPJp1nsk8Vejhgkc6HRDYkGk1s3OfkBlLMTLmOiaOqPX+BnOC+Dg8OSF/WYwGs0K4GRATJ/TXuQZkviTcc=
X-Received: by 2002:aca:e083:: with SMTP id x125mr19207050oig.31.1607967334933;
 Mon, 14 Dec 2020 09:35:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <b9e0e1a60b92a6a220193bf9fe80796df91126a7.1607542887.git.gitgitgadget@gmail.com>
 <84a4d97b-8496-4c83-5d32-19f57e17a871@gmail.com> <CABPp-BHa0zehQd-axmb4bF6fR4PTWwGu9uLjOzgTW8_Gu12iZA@mail.gmail.com>
 <7b0aafae-cd57-d4f7-ac85-238471428d24@gmail.com>
In-Reply-To: <7b0aafae-cd57-d4f7-ac85-238471428d24@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Dec 2020 09:35:23 -0800
Message-ID: <CABPp-BG4smguUNX5fz3q8ffFvv3tPt4ysBe2dzJ_4cAATTaYLg@mail.gmail.com>
Subject: Re: [PATCH 02/11] merge-ort: add initial outline for basic rename detection
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 14, 2020 at 6:33 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/13/2020 2:47 AM, Elijah Newren wrote:
> > Hi,
> >
> > Sorry for two different email responses to the same email...
> >
> > Addressing the comments on this patchset mean re-submitting
> > en/merge-ort-impl, and causing conflicts in en/merge-ort-2 and this
> > series en/merge-ort-3.  Since gitgitgadget will not allow me to submit
> > patches against a series that isn't published by Junio, I'll need to
> > ask Junio to temporarily drop both of these series, then later
> > resubmit en/merge-ort-2 after he publishes my updates to
> > en/merge-ort-impl.  Then when he publishes my updates to
> > en/merge-ort-2, I'll be able to submit my already-rebased patches for
> > en/merge-ort-3.
>
> Let's chat privately about perhaps creatin
>
> > A couple extra comments below...
>
>
> >>> +     int s, clean = 1;
> >>> +
> >>> +     memset(&combined, 0, sizeof(combined));
> >>> +
> >>> +     detect_regular_renames(opt, merge_base, side1, 1);
> >>> +     detect_regular_renames(opt, merge_base, side2, 2);
> >>
> >> Find the renames in each side's diff.
> >>
> >> I think the use of "1" and "2" here might be better situated
> >> for an enum. Perhaps:
> >>
> >> enum merge_side {
> >>         MERGE_SIDE1 = 0,
> >>         MERGE_SIDE2 = 1,
> >> };
> >>
> >> (Note, I shift these values to 0 and 1, respectively, allowing
> >> us to truncate the pairs array to two entries while still
> >> being mentally clear.)
> >
> > So, after mulling it over for a while, I created a
> >
> > enum merge_side {
> >     MERGE_BASE = 0,
> >     MERGE_SIDE1 = 1,
> >     MERGE_SIDE2 = 2
> > };
> >
> > and I made use of it in several places.  I just avoided going to an
> > extreme with it (e.g. adding another enum for masks or changing all
> > possibly relevant variables from ints to enum merge_side), and used it
> > more as a document-when-values-are-meant-to-refer-to-sides-of-the-merge
> > kind of thing.  Of course, this affects two previous patchsets and not
> > just this one, so I'll have to post a _lot_ of new patches...   :-)
>
> I appreciate using names for the meaning behind a numerical constant.
> You mentioned in the other thread that this will eventually expand to
> a list of 10 entries, which is particularly frightening if we don't
> get some control over it now.
>
> I generally prefer using types to convey meaning as well, but I'm
> willing to relax on this because I believe C won't complain if you
> pass a literal int into an enum-typed parameter, so the compiler
> doesn't help enough in that sense.

Yeah, I went through my 'ort' branch with all 10 entries and did a
regex search for \b[12]\b throughout merge-ort.c, then considered each
one in turn, updating to the new enum where it made sense.  Then
backported the changes across en/merge-ort-impl and en/merge-ort-3
(and I just /submit-ted the en/merge-ort-3 updates to the list).  Took
quite a while, of course, but I feel it's in good shape.

So, take a look at the new sets of series and let me know what you think.

> > Something I missed in my reply yesterday...
> >
> > Note that mi->clean is NOT from struct merge_result.  It is from
> > struct merged_info, and in that struct it IS defined as "unsigned
> > clean:1", i.e. it is a true boolean.  The merged_info.clean field is
> > used to determine whether a specific path merged cleanly.
> >
> > "clean" from struct merge_result is whether the entirety of the merge
> > was clean or not.  It's almost a boolean, but allows for a
> > "catastrophic problem encountered" value.  I added the following
> > comment:
> > /*
> > * Whether the merge is clean; possible values:
> > *    1: clean
> > *    0: not clean (merge conflicts)
> > *   <0: operation aborted prematurely.  (object database
> > *       unreadable, disk full, etc.)  Worktree may be left in an
> > *       inconsistent state if operation failed near the end.
> > */
> >
> > This also means that I either abort and return a negative value, or I
> > can continue treating merge_result's "clean" field as a boolean.
>
> Having this comment helps a lot!
>
> > But again, this isn't new to this patchset; it affects the patchset
> > before the patchset before this one.
>
> Right, when I had the current change checked out, I don't see the
> patch that introduced the 'clean' member (though, I _could_ have
> blamed to find out). Instead, I just got confused and thought it
> worth a question. Your comment prevents this question in the future.

Yeah, definitely worth the question.  I've been buried in
merge-recursive.c & related areas so long that I've forgotten that
certain things are weird or surprising on first look.  The more of
those we can flag and document, the better.
