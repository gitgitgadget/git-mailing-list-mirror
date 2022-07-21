Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D54C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiGUTnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUTnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:43:15 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE5233A19
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:43:14 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id j11so1989220qvt.10
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxS/Rj+SJKPaeI7E7j/Coummc2rpFKrLECgtgTU/SQs=;
        b=Szh6rBafqiRTK1+16CBMSNef2ffvlol8XSkn8aYFfUv3jLVJ9wu53fviHUDHNr9y30
         tCwcO6ylpPxEHSSzZ8VBlZF4/7hpt2CEX89xVIGhbqeZSihCR7gnX4FViG1jazTZPy4j
         KZY4456XluNe046necMwGrhTKeEOJN4SuJY9li0XSQ0bULrmBQZTm+qMoL0nlnXf+kSJ
         STKEq2ymV03r6236EhOiBoraTazFN6pdZJ/4Vd2MwqBTy8dUIBtiGWXNdWZvgMRk53/1
         5focbDYyhNq2ruL3fts5CneOQltmp5aek2Dnk3eO0kX0VfPCS06iTj0Ei/A6NHLUSupB
         qtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxS/Rj+SJKPaeI7E7j/Coummc2rpFKrLECgtgTU/SQs=;
        b=coZm5S2/X0tDlYfo/TJdr1jtChuPxaEBJxniJJ3dBKlp7/pZW9Tly7xpFsiizeCOMm
         lqXpJYiUl7pO2rf5/pGlc71jHgyIPZSQ+qJqL6DgaX2gGf2otCEptDdQXn77I9JxPoZW
         5LHRIeuUz9FfY2tL3iUpz7M5yxBA54O+f7GFQ7r+ORohH0AUdargZYn+Cnl5wj26H/d3
         BKXcyXaJ+RGu6uFyhbEUFp8WOCyQ2tyb9EerihLpf+OJ9KR1laKs13yVzRupaGI5KlM/
         cwfs2/4gYH9ndPTyJX8eMhH+j34dljyuRtGIxc2cP5L6RJa7uuJz3VsIokhVrtvOHDp0
         Ih4Q==
X-Gm-Message-State: AJIora9YJ7jMuCW0HySlKTGDVBUafgD1w8TV2sYoe8FbhhaMqNCPKc9M
        CGLMUudaXZ8Fz/5u18bvvHfaU65iSl1lYLOIBWM=
X-Google-Smtp-Source: AGRyM1vrbtzhW377EjTEKpoSZBZXrvrR4ZSGf1xwaJFMi3JNPkO09eMr3SRiT7kWEoR29FsqkHXVhe8P4UnytdTXwRo=
X-Received: by 2002:ad4:5ae9:0:b0:473:62ef:601a with SMTP id
 c9-20020ad45ae9000000b0047362ef601amr131507qvh.69.1658432593429; Thu, 21 Jul
 2022 12:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com> <CABPp-BGKzcVatwoLhzXiJ3jkKXgWne+=5xNj+VmNO=pL5Kr1Og@mail.gmail.com>
 <f0f94d74-b49b-e26a-d38c-77687bbbb153@github.com>
In-Reply-To: <f0f94d74-b49b-e26a-d38c-77687bbbb153@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jul 2022 12:43:02 -0700
Message-ID: <CABPp-BEaX06dGC8YqjRPwnzpRcMorZsk=TCqCsWV4=CFgtvGng@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] rebase: update branches in multi-part topic
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 5:13 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 7/21/2022 12:35 AM, Elijah Newren wrote:
>
> > One thing I'm curious about (sorry to bring this up so late):
> > "pick" commands come with the old commit hash.  Perhaps the update-ref
> > commands should too?  (e.g. "update-ref refs/heads/topic from
> > <OLDHASH>")
>
> I don't personally see the value here other than to make it harder
> for someone to add new commands (and confusing when wanting to
> create a brand new ref).

I apologize if my late query caused frustration.  I was thinking it
made more sense to ask now than later and was genuinely curious for
thoughts on the idea, but perhaps it'd have been better if I just
didn't bring it up.  Sorry.

But, if you're curious why I was thinking about it...


There are four ways I can think of to handle the <oldvalue>: (A)
include it in the "update-ref" instruction, (B) manually get the
<oldvalue> at program invocation, (C) accept an increased race-window
by not grabbing <oldvalue> until the line is parsed, or (D) ignore
races and just don't provide <oldvalue> when updating refs.  If one
chooses (B), they can either (B1) pre-parse the entire todo list and
look up the current values of any refs mentioned in an update-ref
instruction, or (B2) record the value of all existing refs at
invocation.

Rebase is already paying the cost for pre-parsing the entire todo list
(i.e. B1).  In fact, you _also_ preemptively locking the refs
mentioned.  So, in a sense, rebase is already covered. However:
  * adding such a thing could potentially remove a small race window
(perhaps the user takes a while to edit the todo list, and the ref
somehow gets updated before they even finish that step; being able to
specify the oldref might help in such a case).
  * existing commands (pick, merge, etc.) give the oldrefs (or labels
to them), so having update-ref also do so might provide some "feel
good" consistency.

Perhaps those reasons are pretty weak for the rebase case, given you
already do B1.  However, `git replay` isn't going to do B1, and nor
will it preemptively lock refs.  I see `git replay` as a patch-based
analogue to the snapshot-based tools of fast-export and fast-import.
(fast-import doesn't pre-parse its entire input before starting to
process the first commit, nor does it preemptively lock refs.)  B2 is
not appealing because some repositories have gargantuan numbers of
refs.  Also, the update-ref-during-edit-of-todo rationale is more
important for `git replay`, because I want `git replay` to accept a
filename containing a todo list in lieu of a range of revisions to
replay -- perhaps users spent quite some time or programming effort
generating their todo list and it took some time to generate/review.
And that further undercuts both B1 and B2.  So, between all those
reasons, (A) is very appealing to me.

All that said, `git replay` already has other planned differences in
its todo list (e.g. a "reset" directive must be the first non-comment
directive, there's no separate "merge" directive, etc.), so if I have
to add another one, it's no big deal.

Your point about specifying <oldref> being seen as friction for some
users is well taken, and I'm thinking of making the "from <oldref>"
part of the instruction optional (though documenting that users are
accepting some race risk by switching from (A) to (C) when they omit
it).

> We could consider adding a comment in the
> future without any backwards compatibility issues:
>
>         update-ref refs/heads/my-ref # was 0123dead

Yes, this could certainly be added later (though none of my reasons
for wanting <oldref> were geared around pointers for the end user, so
this form wouldn't be helpful to me).

Also, if "from <oldref>" is optional, it could also be added later.


If you've read this far, let me just take a minute to again thank you
for your work on this --update-refs option to rebase.  It's some cool
work.  Also, thanks for listening to my random ideas and musings along
the way.  :-)
