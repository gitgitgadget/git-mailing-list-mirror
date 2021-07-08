Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA42AC07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 17:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A5161879
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 17:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhGHRgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhGHRgL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 13:36:11 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09C5C061762
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 10:33:29 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id h9so8751976oih.4
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=flBnC1opOBench1ncp0BjLi/9Faw4iOjAvLQwoANKyY=;
        b=q6/EW41196Rj9IbV82trcxeX5p4hWnjYZS05V1gcSvhZ9raxSdqMecSfBnqpzzD3NE
         er3UVWSca25h1STeqerINEwK4C9z2A+csVlmHey1qtMUehvWokcA/B7Oy5GKuTv+Rzhe
         JYmiqC2sFB0mYgvMDmPZWDyBaicCZ+aNy886u/io2QZUXNXRxVrxWcypKPgqwPOegHUt
         7BXUMoqbRIiUNnSmxrevSWTd+CYDROHzBngPdYsY1YqIw4tnO9/Oa4ZvHaHbxgoF/uaT
         gZic/c4Mo2t8xYfcnjjEd+wbDdBKTO6t1VB1iRtB67L2ikPJUSE6vu8VklyN3uSoC7ci
         Roaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=flBnC1opOBench1ncp0BjLi/9Faw4iOjAvLQwoANKyY=;
        b=SpM/mF9FbpsVLXg7+S8q/8Y8J30xhdR4msqIMfIxeXpmuZapRiYFb18siyI1uptfJN
         r5hWw7Sb7g6s5Zd/ZApeuLMB27SKJfWM9FkAkF0TmBR18Ty9vAxyYlu6L8blcy/3aGrS
         T2zoQHQGrxp5A/uOv7kNNxIdKLJfduef1CIhzV/ObPI5V7nil2iFUMjOASHgb7gFQ3wg
         oR/RPnet8XWUXn97ohZUiiMCHCDpvPwsJIslyB7/vtECiT3PZdUC/gWKG+sK9CwW2ahZ
         iDPLpcmX9otTjK8ML+B2ixDT7FaOYx/yl0MSmDu/hsBVTlylMBdcWcl2ZCgT3wDtV5KV
         nhpA==
X-Gm-Message-State: AOAM5304WjydcJySZFcR08DqYAK1P7Z+e1BZ2IgTUjWT6JTFEQhIdMKy
        yiV1qidCiGCmH7E05v5wN7ilj5/7F7w=
X-Google-Smtp-Source: ABdhPJxA0mb2mNGSUkd9QjkfA458A9Km1P0xt36fz7q2/oAIDxGP9I21W3Zy/26xjoyha6hmln8X/Q==
X-Received: by 2002:aca:59c3:: with SMTP id n186mr24984693oib.98.1625765609198;
        Thu, 08 Jul 2021 10:33:29 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id 16sm598449otc.52.2021.07.08.10.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 10:33:28 -0700 (PDT)
Date:   Thu, 08 Jul 2021 12:33:27 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e736e72da68_30939020850@natae.notmuch>
In-Reply-To: <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
Subject: Re: What actually is a branch?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 08/07/2021 05:39, Felipe Contreras wrote:
> > 
> > Yeap, the tails of branch_1 and branch_2 could be literally anywhere.
> > 
> > That information is not recoverable from the current data structures of
> > git, thus the proposal to add a new one.
> 
> Ok, thanks for the all the explanation.
> 
> A word on the name "tail". IMHO really confusing. I get where it is 
> coming from.
> But a lot of people will know head and tail utilities from their shell. 
> And "tail" is the one that shows lines on the end of the file to which 
> new data is added. Which is "head" in git.
> 
> Also a tail is something that follows, but (except for rebase), the base 
> point is fixed.
> 
> 
> I think (despite my earlier comment) "base" is a better word.
> It also goes along with "git rebase" which acts on the "base".
> 
> 
> However wording around that topic probably still needs to be very careful.
> "base" must be clearly distinguished from "start". Because "start" might 
> imply that only commits from here on forward are contained, but that 
> contradicts --contains which reports root to head.

I'm not really proposing such feature at this point. I did it on 2013
just to have a solution to this problem, but I didn't push for it back
then.

If I ever work on that feature again I will consider the name "base",
sure, but the only reason I mentioned this @{tail} concept is to try to
define in a more accurate way what a branch actually is.

>  > Suppose branch_2 was created this way:
>  >
>  >   git switch --create branch_2 A
>  >
>  > Then commit B was created under branch_2. Then master was fast-forwarded
>  > to branch_2, so you have:
>  >
>  >                  A => B master
>  >                  ^    ^
>  >   tail/branch_2 -+    +- head/branch_2
>  >
>  > Both branches have A, but only branch_2 has A as tail.
> 
> 
> So base (tail) is the shared commit "A" on which branch_2 was created. 
> (rather than the first commit made in branch_2 which is "B")
> 
> I can see how that is needed for "git rebase" so @{base} can be used for 
> <upstream>.

Yes and no. <upstream> is where branch is rebased *to*, not where it's
rebased *from*:

  git rebase --onto foo@{upstream} foo@{base} foo

This command rebases all the commits foo@{base}..foo on top of
foo@{upstream}.

Another way to think of it is that you'll cherry-pick foo@{base}..foo on
top of foo@{upstream}.

> What happens if branch_2 is rebased?
> Will the base be set to the commit onto which the branch was rebased?
> 
> A => B => C => D => E master
>             \ => F => G  foo (base = B)
> 
> foo was created on B, then fast forwarded to C, then diverged.
> 
> 
>     git rebase --onto A  foo@{base}  foo
> 
> Now that foo diverges before B, having B as base for foo seems odd. 
> (Also A will have C' as child, So the base really is A now)

Yes, A is the new base.

>     git rebase --onto E  foo@{base}  foo
> 
> In this case C is already contained in master, so it will be skipped.
> If the base is moved, then foo@{base}..foo will no longer contain C. 
> IMHO that is correct, because rebase skipped it.

The new base is E.

It's not complicated, the base is whatever --onto is.

> Will there be a way to manually repoint the base?
> 
> A => B => C => D master
>        \ => E => F  foo
>                  \ => G => H  bar (base = F)
> 
> 
> If I do
> 
>    git rebase --onto master  bar@{base} bar
> 
> then the commits E and F will not be part of the rebase.
> That is fine. I must handle them before.
> 
> But if I deleted foo (or for other reasons decide E and F should be 
> handled if I rebase bar) can I make them to be included?
> Something like
> 
>    git base --repoint B  bar
> 

I did not code that, but it's something people probably would need at
some point. I would do `git branch --set-base` though.


Anyway, it seems I wasn't very clear, I'm not really proposing this
feature. Although I think it's something that git is missing, it would
be a pain in the ass to attempt to get it merged, I have much more
important features I want to get done, and those don't have much chance
of being merged either.

The only reason I mentioned @{tail} (or @{base}) is to have a better
mental model of what a branch is.

 1. A branch is whatever is inside `branch@{base}..branch`
 2. `branch` is the branch head (`branch@{head}`), but it's not the
    branch itself

For all intents and purposes on the git documentation the branch, the
branch name, and the branch head are used interchangeably, but
semantically speaking they are not the same thing.

When you change the branch head you are effectively changing the branch.
If @{base} existed, then changing the base would also change the branch
(although that would be a much less dangerous operation).

Does that make sense?

-- 
Felipe Contreras
