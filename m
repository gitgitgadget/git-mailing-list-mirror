Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B7CC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D363322B2E
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgLJA0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgLJA0K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:26:10 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299EFC061793
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 16:25:30 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 11so3267883oty.9
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 16:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IfjDtQorzVCYA31n1Rd6YbzQRoTd1pdMiWJAHy5iWog=;
        b=VwvXor9hV6FiYdhB6oBVO/UjYCGOL2AUAWgJJscCdf5qIeKb63yDJAo5Th06ERt3or
         O0fkCXVhzkHsVmIr25US5Son73Oz6IfJGMv0SX7YD5IaLTinkSetMuUPGG+3nXyXDjUw
         sox5R+jwf4xZfD7XU0obkVfSn1oi6j/3C2tGNGtRdWNweMCU9+BadHSZcocgChmex9Ci
         rgh9ZkZwRxL0jTxtczEmCTrMRC5jBXIk7KAmIjy8ikaDnLHn8UL+iRvSUnK3/qgSFZq4
         /qVoyUP+M0X6PMREwZIrGecIrE23eOvFVuIBPllcDY6XDf2a46wz4b+4FEtqfsmBkWwx
         vcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IfjDtQorzVCYA31n1Rd6YbzQRoTd1pdMiWJAHy5iWog=;
        b=LSycO8qJXE11Mzh3rJQPiOVFEez1oB7seOccRTxz4G5Sf2fTJsHqZ/NrJVa6zXXqqW
         5ReshsOJ97ZHiH9U44+Ltwnltf6iPG6TyJFKCtriINLgePRnFnvLMAKXXIJGbKPNH/uK
         Qd/TiQvtV9OkewfQKLAg33UNwGyDDfEHlsmMoYeqB0qjv0ChJwjKia6W2dbAuNewQVNM
         khbjnWcP1nUZNKWR+b3ZrLAR5TNiZmCbF0RArAHY7qe8x8pZKt93gzCuE45K7ye0ywI/
         9E2mrb+9CtlaxiJtEypQjSZX/RL7ciR/SXZteJqnAZq8jQ7kjFXhTu8XLV665W8vUAJ2
         tomg==
X-Gm-Message-State: AOAM533rzqlr2h5MnoDzKoWmUbwhtZrRwmGrpvJjzd856eRKchY09Yee
        Q0MQxUPET+LxCSy7hxNUj/meoN+oWL82asU6Skg=
X-Google-Smtp-Source: ABdhPJzEjh/8A5+rkFWNACRebDsqYNdjZH2wvr4NlirHy41nOqfdOia3/sYr1PGQAM5POonzNQR8J9PKcqPGGSL0lRM=
X-Received: by 2002:a05:6830:10:: with SMTP id c16mr3951812otp.162.1607559929407;
 Wed, 09 Dec 2020 16:25:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <306a48820dd3c338d2b9e2288e5a3e1c7c89f36e.1607223276.git.gitgitgadget@gmail.com>
 <X9FScb3pzY0EBLvS@nand.local>
In-Reply-To: <X9FScb3pzY0EBLvS@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Dec 2020 16:25:18 -0800
Message-ID: <CABPp-BGPfdFj1q09XVa7UOVz-0K9yf9Lp-h2wh6+nVVbVu94yg@mail.gmail.com>
Subject: Re: [PATCH 6/7] diffcore-rename: simplify and accelerate register_rename_src()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 2:40 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Sun, Dec 06, 2020 at 02:54:35AM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > reigster_rename_src() took pains to create an array in rename_src which
> > was sorted by pathname of the contained diff_filepair.  However, the
> > fact that this array was sorted was not needed anywhere, and thus
> > represented wasted time.  Simply append to the end of the array, which
> > in a usecase of note saved 45% of diffcore_rename() setup time for me.
> >
> > Technically, there is one difference in the end result for the code.  IF
>
> s/IF/If ?

Indeed; will fix.

> > the caller of diffcore-rename provides a set of pairs with a duplicate
> > filename in the sources (an erroneous input condition), the old code
> > would simply ignore the duplicate (without warning or error).  The new
> > code will simply swallow it and thus allow multiple pairings for the
> > "same" source file.  Checking for this error condition is expensive
> > (basically undoing the optimization) and the only existing callers
> > already avoid passing such an invalid input.  If someone really wants to
> > add some error checking here on this input condition, I believe they
> > should add a separate function which can be called before
> > diffcore_rename(), and then other callers that don't need additional
> > checks because of their design (such as merge-ort) can avoid the extra
> > overhead.
>
> It seems like this is currently impossible to trigger, making any extra
> (expensive) checking of it worthless, no?

I believe that's what it currently amounts to, and I debated just
ripping the paragraph out.

However, a natural question that can easily arise for current
reviewers or future readers of the patch is why was there ever sorting
in the first place if the sorting isn't used?  That question came up
for me, and I dug into it.  Sorting is also used with rename_dst in
nearby code in the file, and there are a few reasons for it there.
The quick indexing that rename_dst needs doesn't apply to rename_src,
but it's not as obvious whether the
broken-trees-with-duplicate-entries rationale applies or not.  I spent
a while digging into it.  (And it's possible that I didn't correctly
check the callers or that in the seven months since I wrote this
message someone added another caller of this code that does pass
multiple diff_filepair-s for the "same" source file.)  Anyway, this
paragraph exists because I had to go down a goose chase to answer this
natural question, and I wanted to provide an answer to anyone else
asking the same question.  Also, in the off chance that anyone did
want to add callers that passed multiple copies of any source file, I
wanted to point out that this modified algorithm would result in a
slight behavioral difference, but that otherwise the modified
algorithm gives identical results.  (And if some future reader
stumbled on the paragraph because they had made such a change, I
wanted to provide a quick suggestion of how to get what they wanted
without adversely affecting performance.)

I hope that helps.  I'm sorry if my worrying about these cases and
discussing them made the patch harder to read or review, but I feel
like diffcore-rename is one of those low-level components you want to
be careful with.  diffcore-rename is one of those parts of the code
where a bug in it might not result in a directly observable breakage
to users but in some secondary or tertiary side-effect showing weird
results (e.g. in a merge you won't necessarily see that A was renamed
to B, instead you get a three-way content merge of original A, other
A, and new B -- or don't get a three-way content merge you might
expect).

> > Also, note that I dropped the return type on the function since it was
> > unconditionally discarded anyway.
> >
> > This patch is being submitted in a different order than its original
> > development, but in a large rebase of many commits with lots of renames
> > and with several optimizations to inexact rename detection,
> > diffcore_rename() setup time was a sizeable chunk of overall runtime.
> > This patch dropped execution time of rebasing 35 commits with lots of
> > renames by 2% overall.
>
> Neat!
>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  diffcore-rename.c | 30 +++---------------------------
> >  1 file changed, 3 insertions(+), 27 deletions(-)
> >
> > diff --git a/diffcore-rename.c b/diffcore-rename.c
> > index 3d637ba4645..816d2fbac44 100644
> > --- a/diffcore-rename.c
> > +++ b/diffcore-rename.c
> > @@ -76,36 +76,12 @@ static struct diff_rename_src {
> > [...]
>
> This looks obviously correct.

Thanks for taking a look!
