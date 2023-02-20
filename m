Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFEEC636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 16:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjBTQrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 11:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjBTQrR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 11:47:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDB8206AA
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 08:46:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c12so1861666wrw.1
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EK4wrkbYzxYhOVl6IaLRpzbR8kScXy78rgapMoFYw24=;
        b=Z7ej16VBh112pQRl/4Mxvo/BlspRq+Umu/zzfxAsGggwzmRbyx+Vl7Tpy7ANTEqf1i
         mY2WZpwaV4a/eB4UDjkZu2X2EAHLRxhoBqqwusFv7/n6WHaCL9Tq6ToU9o/SJiWm5pig
         KUPg7hxbM7I9jM2OiDiCT4xmcQbYQa6PufORU/No+frB1Ug+TrKGht5rQyIonc/1g5I7
         oPKkVruhrt+p4P9VpmXZ6S+ps+EMUODC/mrLSmz/uzUto6gyufksBWWhiHlMW2Yp66ep
         P8ivtcNqfuDkCNU2h/U4tqi2kAISSqimuhGSD9AYrjJ06yfWrnAwt/mT7BkmJdaLo60V
         5fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK4wrkbYzxYhOVl6IaLRpzbR8kScXy78rgapMoFYw24=;
        b=kcHxUgqBP/L6YPpmKG76UNGs45HWzYtAU3a1t/21wNm2vT+PMK23Saygk2y3wB5034
         2Z2dtxngc0RKcPWRHKCbez7E8Bm9YhRZh9M2RdfYrFMavi7kSBnoA5G88uJ2vralyU8b
         9XPOZZdqPD1IE4tZtj1mbGIcB/1jBvc4p4LpiKSwXZKgcVjXK3JlkEzC+4JY0yDfxW/G
         fE56KXml+v0dd0YBfIZDv7koBrmOTGwR8/dSzuDWr+3Gamh7gRIrxWZoVy/cx6FM5tUk
         MIL7nCjbKQYZk5FWz5RK6AcxOb9HQj1mhKsrUhmmjsfdwFSHntRhSZaTjLikcgy13UJz
         eprA==
X-Gm-Message-State: AO0yUKXnaTFRmnOHFZomPDrjBYobVXEX5gr6xNgb3Wjofd8sj7ZremHw
        1IqM/TyBQO7Eb0Zn55xLunU=
X-Google-Smtp-Source: AK7set/pFppfaOrtSaBASA5YC9el6cGPkUBD3g7ReYs92ED32X1OHsiMY4BUWPH8zCUzojTsJ4c1xA==
X-Received: by 2002:a5d:4c4c:0:b0:2c5:8576:867c with SMTP id n12-20020a5d4c4c000000b002c58576867cmr3125783wrt.43.1676911546250;
        Mon, 20 Feb 2023 08:45:46 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600000cf00b002c559843748sm3363146wrx.10.2023.02.20.08.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 08:45:45 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <55818a65-046d-4f96-312b-1b5cae6e210f@dunelm.org.uk>
Date:   Mon, 20 Feb 2023 16:45:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
Content-Language: en-US
To:     Tao Klerks <tao@klerks.biz>
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk>
 <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
In-Reply-To: <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tao

On 20/02/2023 08:03, Tao Klerks wrote:
> On Sat, Feb 18, 2023 at 5:39 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 18/02/2023 03:17, Elijah Newren wrote:
>>>
>>> One concern I have is that "--rebase-merges" itself has negative user
>>> surprises in store.  In particular, "--rebase-merges", despite its
>>> name, does not rebase merges.  It uses the existing author & commit
>>> message info, but otherwise just discards the existing merge and
>>> creates a new one.  Any information it contained about fixing
>>> conflicts, or making adjustments to make the two branches work
>>> together, is summarily and silently discarded.
>>
>> That's a good point. Another potentially surprising behavior is that
>> when I'm rebasing an integration branch with -rno-rebase-cousins then if
>> one of the topic branches merged into the integration branch happens to
>> share the same base as the integration branch itself the topic branch
>> gets rebased as well.
> 
> I've been trying to understand how this behavior is (potentially)
> surprising - I imagine it's been discussed elsewhere but I'm having a
> hard time understanding, sorry.
> 
> The situation you described is a boundary condition between two others, right?
> * The topic branch could be branched from the integration branch
> (potentially *after* some other change were made to the integration
> branch, but not in this case) - in which case rebasing is what you
> would expect
> * The topic branch could be branched from the main branch (potentially
> *before* the integration branch branched, but not in this case) - in
> which case not rebasing is what you would expect.
> 
> If topic branched from main (at around the same time as integration),
> it might be surprising that it rebases;

Yes that's what I was referring to, on the one hand it isn't surprising 
at all because both the topic and integration branch have the same base 
but on the other hand using no-rebase-cousins is supposed to stop the 
topic branches being rebased.

> if it branched from
> integration (before that had any changes), then it is expected.

Yes

>> -rno-rebase-cousins is also slower that it needs
>> to be because it creates a todo list that contains all the commits on
>> the topic branches merged into the integration branch rather than just
>> the merges. The commits on the topic branches are fast-forwarded rather
>> than rewritten so long as they don't share the same base as the
>> integration branch but it noticeably slower than using a todo list with
>> just the merge commands.
> 
> This seems improvable, but no worse than a plain legacy rebase (as
> Alex's new patch would have it, "rebase-merges=drop"), right? Insofar
> as we're discussing why it might make sense to avoid promoting this
> over a plain rebase, I don't understand the concern.

My concern is to have a good understanding of the issues around 
--rebase-merges before we start promoting it over a plain rebase. It is 
not a reason not to make the change but it does show --rebase-merges 
would benefit from some additional polish.

>>> My personal opinion would be adding such a capability should be step
>>> 2.5 in your list, though I suspect that would make Tao unhappy (it's a
>>> non-trivial amount of work, unlike the other steps in your list).
>>
>> I've got a couple of patches[1] that cherry-pick the merge if only one
>> of the parents has changed. I've never tried upstreaming them as it is
>> only a partial solution to the problem of rebasing merges but that
>> approach should work well with "git pull --rebase=merges" as only the
>> upstream side will have changed (when rebasing my git integration branch
>> with that patch the merges are cherry-picked). They might make a useful
>> starting point if anyone wants to try and improve the rebasing of merges.
>>
> 
> This is awesome!
> 
> It feels like the first step towards the general strategy that was (I
> believe) best described by Buga at
> https://public-inbox.org/git/a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com/
> !
> 
> (unless I'm missing something, the result of this is exactly the same
> as the result of that strategy, in these "simple" cases where it kicks
> in)

Yes

> The one concern I have with this is that, *if I understand correctly*,
> it sometimes throws away the existing merge information, and sometimes
> doesn't, and there's no easy way to know which it is at runtime.

Right, there are two ways the existing merge can be thrown away.

  (i) The existing merge has conflicts when being cherry picked
      and so we redo the merge (that is a choice, we could present
      the user with the conflicts from the cherry-pick). It is
      possible that the merge succeeds where the cherry-pick failed
      but most of the time we'd stop because if the cherry-pick has
      conflicts the merge will probably have conflicts as well.

(ii) More than one parent has changed and so we redo the merge

> Would
> adding a warning on stderr when a both-parents merge is encountered
> (and any merge resolutions or related changes are still discarded) be
> enough to make this shippable?

I'm not sure. It works well enough for what I use it for (which is 
essentially "git pull --rebase") but sometimes cherry-picking and 
sometimes remerging does make it more complicated for users. If we 
printed a warning what is the user going to do? An experienced user can 
use the reflog to get back to the original state and redo the rebase 
with some break statements added in to let them fix up the merges. A 
less experienced user is going to think git lost their work.

> Are there *any* circumstances where the new cherry-picking behavior
> introduced here wouldn't be the right thing to have happen?

Not that I can think of

Best Wishes

Phillip
