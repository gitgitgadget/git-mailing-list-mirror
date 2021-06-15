Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD42C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165C86145C
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFOLzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOLzr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 07:55:47 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B141C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 04:53:40 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id a26so17820593oie.11
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=cErwkubTOm/konyxQbdjHEQ57jtv0WI0s7//Nv3l3Ek=;
        b=o0ttvmcAvORViLA0Xuz2TBUqeIPYUNk43qrSAjsuhidrmrh0+7itPIxRpIyCDt30gd
         aSzKM+vIzetx9rG+v7pn8AtkzT0nSzg3tRt4TWjOvTNxlNLMeP1O8QWrJvIKRyDlDsYy
         v22kmW8IbRmBlbFPiPGwxTrsa1LMUNFY7uAgyRaf1bpREPSwjw4Q7ysAS5KWODhMfD08
         Md30aA2wCCV0pPpXV3n4ZFOiZQ8yJlfeYmqOzBNzfrtBD78xZBP0Essp4+DYNYBgI+gc
         HFow0LhRilVBGc0/ct9UI++bsU5mkEeHe1dToW7HsCD44POIDnNO8v380y10MXO24rh3
         SpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=cErwkubTOm/konyxQbdjHEQ57jtv0WI0s7//Nv3l3Ek=;
        b=CA8JLGZfrdwE6cAKfahMycfL/sSo7nmtrRVAQyYi9xXY5AHNweAT4INdOvP2EVGSdO
         2bNpbFTxGV+2WmWfEysJmf/sZCVwSMM1WMlSU82eV+hvwbLJ7PV0NGtgWJ6ITa5d/5Hz
         VobgPtb2o3qguWhulw9PU2DgUOkkV2NGlRL6bGZt6DAvkMzO+imu2xOk5ukwYrQZL6BK
         Ty5iDbTVBDqbbncD4wEqQ01H9WET/7lvYq/7e9bXQWt7IDT+et08Gwwi5v1X+AdiELTt
         TDhmOJ9o4L4Mlvh4L52KKsV/wx8BjDE8ZpsiB/OqWduFdtwuVlcKQVBN/x/0q132HGF6
         l5OA==
X-Gm-Message-State: AOAM533Ew31fDRhyuPBzih6VdHAF53nJ88KsgC1p/78Zjtk5Ih0HCwoO
        w1jQ3tWXjNhHaPAfx7ZUuh0=
X-Google-Smtp-Source: ABdhPJx+KdBlHbgnnxkeawiGK0gv7DM+igBkBoAhKFsmNaMEzBHZPvxAgEmecTOUJd7NYLzGun41lw==
X-Received: by 2002:a05:6808:f08:: with SMTP id m8mr13380164oiw.69.1623758019632;
        Tue, 15 Jun 2021 04:53:39 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id z22sm3760662ooj.6.2021.06.15.04.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:53:39 -0700 (PDT)
Date:   Tue, 15 Jun 2021 06:53:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60c894c1daaed_e633208cb@natae.notmuch>
In-Reply-To: <CABPp-BHh9dfuOV3wM_K7Zks4hzry3RDxjsaxrLztLDy0FtELCA@mail.gmail.com>
References: <20210613004434.10278-1-felipe.contreras@gmail.com>
 <CAPig+cSE2h7A52drhELfZJLDEgQ1z+nEXoXhYMUSA00Z+S=OUA@mail.gmail.com>
 <60c588d452750_3d86c2085c@natae.notmuch>
 <CABPp-BE4r=Nhw2sJS++7Eh1K5rpyWgg+f8vDTf92JBayt1B_cA@mail.gmail.com>
 <60c63bc3f616_41f452086b@natae.notmuch>
 <CABPp-BHh9dfuOV3wM_K7Zks4hzry3RDxjsaxrLztLDy0FtELCA@mail.gmail.com>
Subject: Re: [PATCH] doc: revisions: improve single range explanation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Sun, Jun 13, 2021 at 10:09 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Elijah Newren wrote:

> > > I tend to agree with Eric.  I think the example you chose is likely to
> > > be misinterpreted and your wording magnifies it.  A..F B..E simplifies
> > > to B..F which is *almost* the union of A..F and B..E, it's only
> > > missing A.  Off-by-one errors are easy to miss.
> >
> > Yes, but right before it's explained that the ending point is F.
> > Not E, F.
> 
> I think this is somewhat of a useless distinction -- not for the end
> result, but in terms of helping users understand.  We started adding
> an explanation to the manual because users misunderstand how
> "start1..end1 start2..end2" is treated and we want to correct their
> misunderstandings.  In that context, the only misunderstanding I can
> think of that is dispelled by specifying F is the endpoint would be
> "two ranges are intersected to get the range of commits that log will
> operate on".  I've never seen users assume that or make such a
> mistake.  I've always seen them assume that the "two ranges are
> combined with a union".

Then that warrants yet another paragraph, because this one is for:

  Commands that are specifically designed to take two distinct ranges
  (e.g. "git range-diff R1 R2" to compare two ranges) do exist, but they
  are exceptions.

Probably outside the section of Dotted Range Notations, because if the
user is confused about what 'C B A A' should do, that has nothing to do
with this dotted ranges.

Maybe after the user has been told that:

  Specifying several revisions means the set of commits reachable from
  any of the given commits.

  A commit's reachable set is the commit itself and the commits in
  its ancestry chain.

> > > You make it more likely that they'll miss it, because there are only 6
> > > commits total in the union, and you are trying to explain why listing
> > > A..F B..E while not be 8 commits, which readers can easily respond
> > > with, "Well, of course it's not 8 commits.  There's only 6.
> >
> > If the reader understands that no more than 6 commits can be returned,
> > then the reader has understood the point that the operation is not
> > addition.
> 
> Who in the world ever assumes that "two dotted ranges are combined via
> list addition"?

I don't know, but that is the paragraph we are on:

  Commands that are specifically designed to take two distinct ranges
  (e.g. "git range-diff R1 R2" to compare two ranges) do exist, but they
  are exceptions.

If you are arguing for the removal of this entire paragraph and its
examples, I'd be fine with that.

> I've only ever come across users assuming the
> operation is a union (or, equivalently, addition on sets).  I don't
> understand why you even try to make that point, and think it's a
> distraction that does more harm than good.

If you think it's impossible for the user to assume two dotted ranges
means addition, please explain what is the point of this sentence:

  Unless otherwise noted, all "git" commands that operate on a set of
  commits work on a single revision range.

> > > When you do the union operation, of course the duplicates go away",
> > > and miss the actual point that A got excluded.
> >
> > But that is not the point. This is the point:
> >
> >   Unless otherwise noted, all git commands that operate on a set of
> >   commits work on a single revision range.
> >
> > You are missing the forest for the trees.
> 
> I think you are missing the boat.
> 
> That sentence on its own is completely insufficient to dispel the
> misunderstanding.

One misunderstanding, perhaps, not the one we are trying to tackle
here.

> All that sentence says to users is that if they specify what they
> think of as "two ranges" that we'll somehow treat it as one;

Didn't you just said the user would never think it's actually two
ranges?

What's the point in saying that if the user already knows it?

> but since users are prone to think that "revision range" is
> interchangeable with "set of revisions" (especially since we defined
> A..B elsewhere in set operations), this will merely make them think in
> terms of what set operation they need to perform on the "two ranges"
> to get the set of commits the operation will function on.

That belongs in a separate paragraph.

> The example you provide should attempt to help explain why that mental
> model is mistaken and provide them with a corrected one.  Your
> response to Eric suggests you're not even trying to provide a
> corrected mental model, and your response here suggests you are trying
> to only correct mistakes of the form "take two revision ranges and add
> them keeping duplicates" and "take two revision ranges and intersect
> them", neither of which I've observed in the wild.

I'm providing an example for the paragraph that is already written.

If you want me to rewrite the entire section I can certainly give it a
try.


> Commands that are specifically designed to take two distinct ranges
> (e.g. "git range-diff R1 R2" to compare two ranges) do exist, but they
> are exceptions.  Unless otherwise noted, all git commands that operate
> on a set of commits work on a single revision range.

Isn't this obvious for all users?

> Thus, just as "A..B" translates to "^A B", the expression "A..B C..D"
> translates to "^A B ^C D", i.e. all commits reachable from either B or
> D, as long as they are not reachable from either A or C.

How about we remove the entire paragraph and replace it with:

  When specifying two ranges, such as 'A..B C..D', the way this is
  interpreted is as a single range '^A B ^C D', that is: all commits
  reachable from either B or D, as long as they are not reachable from
  either A or C. Assuming a linear history, B would be reachable from C,
  so this is the same as '^C D'.

-- 
Felipe Contreras
