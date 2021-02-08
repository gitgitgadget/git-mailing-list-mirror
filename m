Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44121C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 16:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E4B64E6F
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 16:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhBHQLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 11:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbhBHQK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 11:10:58 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB150C061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 08:10:12 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id q4so3548478ood.8
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 08:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=akOcixirdExrp/akpDVflu5qSyT4X2O6VzrP1Jjj2+8=;
        b=pg6Zcjh1k1S0sPdv1Xl93Ii71/KTgWuMgvPtVKATnlLqTw7LkS4z3sQgKmmVroWQSV
         J384W6E9UVyyfyTQlP/CCldjAcBXjH301q8MPVtETnKmbtkKVeKaBdVgl+SUdKPldBmT
         lUKNqNTM/QEeYi4RiX+QA99t+8h3ivNFGLmXzTR2e3y0nLycEQn1HgBhhPvx1OXFLDzY
         ipWSlI0IK7VVYp6zS8FiMn3viR66O82MYF2BoLGdq8STETg8JjQ+udQmWLwvXvZZ83GZ
         O/6i8MLCtzx/LC6WM/ZDRftv8aW0EJ2D1WIUVudPiDJQwp4va5W1+l6agRmPPd1I3KdS
         +ATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=akOcixirdExrp/akpDVflu5qSyT4X2O6VzrP1Jjj2+8=;
        b=i+NhWQIoMKUiG8f9HlxBCzvjvorTK8/WR1TlRFoRyyKWONob/PS+Wjx3uZYy2McJ5z
         lhpxvqHg6DHEdWFZ0wja8U/9COL0LRSoIcd5zYfeMBeGGoyxEsVXGMaP3DzTe/+uVaYS
         R5K3fsSfensKmUSl3GYRdPRbkNH/8saLe1vCL7OxAoseYTv8gdqcktkBZNpqNleN7BtS
         CcmmCvGjCno2kYaTjcgUwC9fF4QcbxhRCh85vzVw6pAZqyQgHpRlANkQNC0X2WdnxQvm
         nszCQirDWCjnTk/K0T1EZx0NSm6v3oCBA5+W2kbEnuo6mNnYEp+7GFr/fF14J4u9Kd7g
         K+9g==
X-Gm-Message-State: AOAM530n7CzwZVMgtlk1p92hfHsDlCZFE7UHAcMwFu/Y76EQ1PhTHbLW
        u/2p/XRHQh7/qixRAXMzolpeZfsmiEJSxV8BSzI=
X-Google-Smtp-Source: ABdhPJwwzu5/kFkMuE4N1Tt4SL4D4BDaU5WlFp5pJPoVywNx8OjhzYJiA0SqnsXdNmFzmxWAYADsJlg3KTgvCZD8s+I=
X-Received: by 2002:a4a:9d0e:: with SMTP id w14mr12904642ooj.7.1612800612168;
 Mon, 08 Feb 2021 08:10:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
 <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com> <CABPp-BHPgUHFFzTd7suhqj=zEXQ61vxKU6X9gZvow5a=TLg3iw@mail.gmail.com>
 <b4eeb6a1-a801-e984-d245-f291a0cf9727@gmail.com>
In-Reply-To: <b4eeb6a1-a801-e984-d245-f291a0cf9727@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Feb 2021 08:09:59 -0800
Message-ID: <CABPp-BH7iVoCmnDqtQeyO6kgp37MGMbHA0X-4H+YJFD6jeUarw@mail.gmail.com>
Subject: Re: [PATCH 3/3] diffcore-rename: guide inexact rename detection based
 on basenames
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 8, 2021 at 3:31 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/8/2021 3:27 AM, Elijah Newren wrote:
> > Hi,
> >
> > On Sun, Feb 7, 2021 at 6:38 AM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 2/6/21 5:52 PM, Elijah Newren via GitGitGadget wrote:
> >>> From: Elijah Newren <newren@gmail.com>
> >>>
> >>> Make use of the new find_basename_matches() function added in the las=
t
> >>> two patches, to find renames more rapidly in cases where we can match=
 up
> >>> files based on basenames.
> >>
> >> This is a valuable heuristic.
> >>
> >>> For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> >>> performance work; instrument with trace2_region_* calls", 2020-10-28)=
,
> >>> this change improves the performance as follows:
> >>>
> >>>                             Before                  After
> >>>     no-renames:       13.815 s =C2=B1  0.062 s    13.138 s =C2=B1  0.=
086 s
> >>>     mega-renames:   1799.937 s =C2=B1  0.493 s   169.488 s =C2=B1  0.=
494 s
> >>>     just-one-mega:    51.289 s =C2=B1  0.019 s     5.061 s =C2=B1  0.=
017 s
> >>
> >> These numbers are very impressive.
> >>
> >> Before I get too deep into reviewing these patches, I do want
> >> to make it clear that the speed-up is coming at the cost of
> >> a behavior change. We are restricting the "best match" search
> >> to be first among files with common base name (although maybe
> >> I would use 'suffix'?). If we search for a rename among all
> >> additions and deletions ending the ".txt" we might find a
> >> similarity match that is 60% and declare that a rename, even
> >> if there is a ".txt" -> ".md" pair that has a 70% match.
> >
> > I'm glad you all are open to possible behavioral changes, but I was
> > proposing a much smaller behavioral change that is quite different
> > than what you have suggested here.  Perhaps my wording was poor; I
> > apologize for forgetting that "basename" has different meanings in
> > different contexts.  Let me try again; I am not treating the filename
> > extension as special in any manner here; by "basename" I just mean the
> > portion of the path ignoring any leading directories.  Thus
> >     src/foo.txt
> > might be a good match against
> >     source/foo.txt
> > but this optimization as a preliminary step would not consider
> > matching src/foo.txt against any of
> >     source/bar.txt
> >     source/foo.md
> > since the basenames ('bar.txt' and 'foo.md') do not match our original
> > file's basename ('foo.txt').
> >
> > Of course, if this preliminary optimization step fails to find another
> > "foo.txt" to match src/foo.txt against (or finds more than one and
> > thus doesn't compare against any of them), then the fallback inexact
> > rename detection matrix might match it against either of those two
> > latter paths, as it always has.
>
> Thank you for making it clear that I had misunderstood what the
> optimization is actually doing. A much more narrow scope makes
> more sense, and avoids the quadratic problem even when many files
> of the same suffix are renamed.
>
> >> This could be documented in a test case, to demonstrate that
> >> we are making this choice explicitly.
>
> My test is thus bogus, but you could have a similar one for
> your actual optimization.

Yes, good point.

> >> So, in this way, we are changing the optimization function
> >> that is used to determine the "best" rename available. It
> >> might be good to update documentation for how we choose
> >> renames:
> >
> > Seems reasonable; I'll add some commentary below on the rules...
>
> Your commentary is helpful. I look forward to reading your
> carefully-written docs in the next version ;).

:-)

> >>      i. among files with the same basename (trailer
> >>         after final '.') select pairs with highest
> >>         similarity.
> >
> > This is an interesting idea, but is not what I implemented.
>
> That's what I get for reading the commit messages quickly and
> commenting on what I _think_ is going on instead of actually
> reading the code carefully. Sorry about that.

There's absolutely no need to apologize.  If you read all three commit
messages and you didn't understand the idea, then clearly there's a
bug in my commit messages.  Thanks for highlighting it; I'll figure
out how to reword or add extra verbiage to make it clear.  Something
in these follow-up emails seemed to work, so I'll try to incorporate
stuff from them.

> >  It is
> > possible that your suggestion is also a useful optimization; it'd be
> > hard to know without trying.  However, as noted in optimization batch
> > 8 that I'll be submitting later, I'm worried about having any
> > optimization pre-steps doing more than O(1) comparisons per path (and
> > here you suggest comparing each .txt file with all other .txt files);
> > doing that can interact badly with optimization batch 9.
> > Additionally, unless we do something to avoid re-comparing files again
> > when doing the later all-unmatched-files-against-each-other check,
> > then worst case behavior can approach twice as slow as the original
> > code.
>
> Right. If Git decides to reorganize all of its *.c files in one
> commit, we would still get quadratic behavior in rename detection.
> Maybe it's not _that_ much of an improvement.
>
> Thanks,
> -Stolee
