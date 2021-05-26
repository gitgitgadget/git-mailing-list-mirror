Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F86C47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 16:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1070D613BF
	for <git@archiver.kernel.org>; Wed, 26 May 2021 16:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhEZQJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 12:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhEZQJn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 12:09:43 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D77C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 09:08:11 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id n3-20020a9d74030000b029035e65d0a0b8so1470244otk.9
        for <git@vger.kernel.org>; Wed, 26 May 2021 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1M1K9d0I4ROJy/HNlapoIwiQobJVvef+gGD4ugPm5bk=;
        b=fkrVwYG3RFC5h6TIwphsXMLX7QNpAQL0jl52OOfDUyHPAku61RnTNvJpCygwvnfsMg
         SOgS42Tni4tZxC4ugz4liIt0FHl2pAqAL3dQLsehivggf244IFudJRTIXRLxMSgK0leH
         1FqrsRkewflZyd21LkRo32Eroc8pkf1VfqW43+CEoPIMASivj768pvgCR0oAJzokZ+mX
         PbRxFTi5Bl8CIIJKVOHmgRQ2SS+MR4nJme1J7jLXfzkfz0abY081Sugf/lSlXAHYCqta
         N8x9BJ9rtADMk1laY+9kVxjzaDeclFeDzYPG91mxQiPtmQWx1O5iB5QijJHhMA7HNGTD
         ppHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1M1K9d0I4ROJy/HNlapoIwiQobJVvef+gGD4ugPm5bk=;
        b=f8lvoYw1uUWjI5Vxca0wMfPRdcohyT1oVYjiYdyn8GDMApz0xmYfLkBVYxZ6kLS6A3
         RgNhEz4ZDE6nE3mpRayUNnoXb0wdyKWoQTFLvqRbmxlmvMg2ZICVCfFLeKAGdc+1XAK5
         6RTWDrR83CMoQ1AuBK8PDWlBzwCYfQAiceB+GGQzOgBoEgOf3b/yyMOg5cw7EwhbBFdW
         KOskFoX+fXJ2dJftdxkfj2L+pMgIGmWY2bl5PlmYjWQAb12dxtenTsmTXbi4nZIPVyTo
         NQclmjoPsBQagaausruDwQG2Ol+wyXM6z1RKipsMZwM7QgwQDh/PaH5cuTUXak0hmXEx
         RYxw==
X-Gm-Message-State: AOAM533Wumb5QSHujL0BZw2WkBC0jrqYuVH0bceybNEep6BgLyka4KzL
        E/ajOXDcT2Tx8/oTMxkCJVamFZxItsIK/Bi1+xOhrzhj8z8edw==
X-Google-Smtp-Source: ABdhPJyxvpVnzB9XHZS/U4yPh6MKvwFuWzao6eNPC7eOEkCLpNESoLcMdMiKM0A8EtHTER2NUF+vtU+fbHKqMJgolVs=
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr2889388otn.162.1622045291048;
 Wed, 26 May 2021 09:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <79e26cee-daed-d52b-76d7-692f5cb2e20a@gmail.com>
 <CABPp-BHq+=Q6EDNOHJGoUvJsezn=hbQORT=0NRghREf=cnwCYQ@mail.gmail.com> <45c23ea3-0e21-7654-3d2a-5597e159f847@gmail.com>
In-Reply-To: <45c23ea3-0e21-7654-3d2a-5597e159f847@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 May 2021 09:07:59 -0700
Message-ID: <CABPp-BF_JkDjXnWnLsYFj0ywpp-r-O7RaqMKFCtQWe8yeJB8Xw@mail.gmail.com>
Subject: Re: git status when merging non-conflicted 3-way merge says "All
 conflicts fixed"
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, May 26, 2021 at 8:13 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 26/05/2021 15:30, Elijah Newren wrote:
> > On Tue, May 25, 2021 at 1:22 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >> Supposed that we have following commit graph:
> >>
> >> ----A----B----C----D <- master
> >>                 \
> >>                  ----E <- e
> >>
> >> When we merge e branch by `git merge e`, obviously we will do 3-way
> >> merge. Assumed that the merge doesn't conflict, Git will fire up
> >> editor to edit `COMMIT_EDITMSG` for us to enter merge commit
> >> message. Then we abort the commit by either delete all the lines
> >> there, or comment all of them.
> >>
> >> But when we check status by `git status`, Git says:
> >>
> >>> On branch master
> >>> All conflicts fixed but you are still merging.
> >>>    (use "git commit" to conclude merge)
> >>
> >> That message above is misleading, because we know that our merge
> >> doesn't conflict (3-way merge applied successfully without conflict).
> >> However, it makes sense only when we have resolved all conflicts
> >> on the conflicted merge.
> >
> > Once upon a time, that message would have always been right.  Then a
> > --no-commit option was introduced to git merge, and editing of commit
> > messages for merges was also added.  As you note, both of those can
> > yield cases where the message is misleading/surprising.
> >
> >> So for non-conflicted merge, we can say instead:
> >>
> >>> On branch <branch>
> >>> You are still merging, and the merge applied without any conflicts.
> >>>    (use "git commit" to conclude merge)
> >
> > At the time this message is printed, there is no way for us to know
> > whether there had been conflicts.  We'd have to record that
> > information somewhere (probably the index, though introducing another
> > index format just for this seems like a really high lift for such a
> > small thing, and may conflict with other efforts to extend the index
> > format, such as the sparse-index work),
>
> Can we use the information that `git update-index --unresolve` uses to
> tell that there were conflicts? I'm not clear when that data gets
> cleared from the index - if it's not cleared when we commit then it wont
> be much use for this.
>

Wow, I was totally unaware of the resolve-undo extension for the
index.  Thanks for the pointer.  So, it looks like we already _can_
record some kind of specific unmerged information.  Perhaps that
information could be used as a proxy for "were there conflicts",
though I'm still a bit hesitant.  Some questions:
  * Can we rely on the extension being written and populated? (does it
get populated by all relevant codepaths in git?)
  * Even if all codepaths in git will populate it, might the lack of
this extension (or its lack of entries) imply that the user used some
other tool (jgit, something in libgit2, etc.) rather than that there
were no conflicts?
  * Can we rely on this for all types of conflicts?  For all merge
backends?  Are there conflict types that don't result in a higher
stage entry being recorded in the index?

Regarding lack of higher stage entries; some examples of where this
could possibly occur (there may be more, I just spent a few minutes
thinking about it):
* Files/directories in the working directory in the way of paths you
want to write from the merge (merge-recursive will not necessarily
abort early on these due to renames).
* "directory rename split" -- don't know where to rename individual
files added to old dir because half of old dir went to newdir1 and
half to newdir2
* A submodule is fast-forwarded by the merge operation, but updating
the submodule fails due to its working directory being unclean
(theoretical; we don't update submodules currently)
* Would directory/file conflicts (perhaps even combined with
rename/delete) always result in higher stage entries in the index?
I'm not sure if they always have historically; it seems likely that
some historical merge backends (or current or future external merge
tools) might yield a conflict without writing a higher stage entry in
the index for such a type of conflict.
* working tree and gitdir on different filesystems; working tree on a
full filesystem so we can't write out files even though we wrote out
new index and tree and blob objects successfully.

So, I'd still be more comfortable if we could just record some bit
"was_conflicted?" which gets written.  I'd rather not rely on a lack
of the bit being present to imply a yes or a no.


So, still seems like a can of worms to me.
