Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06826C25B04
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 16:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLOQeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 11:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiLOQeC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 11:34:02 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B473AC70
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 08:34:01 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id x22so53525281ejs.11
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 08:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S87Ed0ltoZwEodI1+m+bcTkzXOvf88ZC01aCnAh1UkU=;
        b=KHNZZ2cYdtmfgiJgKVjpCx7vsiSu1uVRQdGCy5tkYE/GkaKiXgelvyFp2hP36VjdfI
         zoNqFx3mREiq38OI7g+H/AHGGy4ZhlUiL5SEVfni3S/93qjiGEdHYj82MyQONKrp/JlJ
         SxCpl+4J1Ifnhe3KqGiam+CRKdv2vZwNcRpUU6CwUnV7hCRUW8/VXcJPiIcuSwT3lNgW
         ocww+oeFXocnXlekIkB/YCpdd1xWcxnrx5GT5vf2qkn8BUaq4hVh2MpUs28TSXuU/XmV
         yfVr+a6meR7JWhoXEZjYUbDmzOguPy27T4KrqBumUnkt+O3Z+B1YrSxgVv28wzedItgu
         gJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S87Ed0ltoZwEodI1+m+bcTkzXOvf88ZC01aCnAh1UkU=;
        b=7wjcpB/bkyUoMNy36+acjTdBnt5rtkfr2bizo5VPFeAeLmZZsiOZIJ0mDPa2O1X5nL
         rl5pfT68S8ML+PvTN+tyGN5M4DiOjTG20jQFxZu+XCglVc9BW4j9uL+2vW1fnGmKv28+
         Y1MTT4Lqj5EeO9lEHXn5Wl685u7NjsDThnfyAjbox/MkF4dW+ZMWTKrcORF2t2gevaby
         mGNKGxxY0Lb8hfFLzX1orNqmecNyEm/VtYEBWi5Dk3csBX4IIXm1qxRZjfgDZvX9vZQu
         lkGA373+VUSiE+Vhp5UdB5xHy2yrgbp20TwS0Typa/8Tr01OQImo2p+ISnVnL159Yt6r
         +rgA==
X-Gm-Message-State: ANoB5pmOFV1+zCABNhpjZxudYi06cHsLN9CP453frkyBr3IamexS7vhh
        69yedbIEQvFUbm2Lx9JkrZNsj3f6AKNvJQ==
X-Google-Smtp-Source: AA0mqf7vVlB4I6954GQ5CADofzPe+bYCIYBbnGvMBtB0LzNqzR0IsQXaZVQy+c29A5r0g0/mQDb8pQ==
X-Received: by 2002:a17:906:70d0:b0:7c0:8371:97aa with SMTP id g16-20020a17090670d000b007c0837197aamr24786643ejk.28.1671122040215;
        Thu, 15 Dec 2022 08:34:00 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id la1-20020a170907780100b007c073be0127sm7160115ejc.202.2022.12.15.08.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 08:33:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p5rBH-006OcE-0z;
        Thu, 15 Dec 2022 17:33:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alban Gruin <alban.gruin@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: ag/merge-strategies-in-c (was: What's cooking in git.git (Dec
 2022, #05; Wed, 14))
Date:   Thu, 15 Dec 2022 17:29:57 +0100
References: <xmqqiliewbje.fsf@gitster.g>
 <221215.865yed3tzv.gmgdl@evledraar.gmail.com>
 <c9c2c979-82b3-8be1-1edb-343661cf4b32@dunelm.org.uk>
 <221215.86a63o3c0i.gmgdl@evledraar.gmail.com>
 <e7da3e4c-e87d-0282-0b8a-2fa2fee371aa@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <e7da3e4c-e87d-0282-0b8a-2fa2fee371aa@dunelm.org.uk>
Message-ID: <221215.86wn6s1v9k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 15 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 15/12/2022 15:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Dec 15 2022, Phillip Wood wrote:
>>=20
>>> On 15/12/2022 09:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> On Wed, Dec 14 2022, Junio C Hamano wrote:
>>>>
>>>>> * ag/merge-strategies-in-c (2022-08-10) 14 commits
>>>>>    . sequencer: use the "octopus" strategy without forking
>>>>>    . sequencer: use the "resolve" strategy without forking
>>>>>    . merge: use the "octopus" strategy without forking
>>>>>    . merge: use the "resolve" strategy without forking
>>>>>    . merge-octopus: rewrite in C
>>>>>    . merge-recursive: move better_branch_name() to merge.c
>>>>>    . merge-resolve: rewrite in C
>>>>>    . merge-one-file: rewrite in C
>>>>>    . update-index: move add_cacheinfo() to read-cache.c
>>>>>    . merge-index: add a new way to invoke `git-merge-one-file'
>>>>>    . merge-index: drop the index
>>>>>    . merge-index: libify merge_one_path() and merge_all()
>>>>>    . t6060: add tests for removed files
>>>>>    . t6060: modify multiple files to expose a possible issue with mer=
ge-index
>>>>>
>>>>>    An attempt to rewrite remaining merge strategies from shell to C.
>>>>>
>>>>>    Tired of waiting for too long.
>>>>>    source: <20220809185429.20098-1-alban.gruin@gmail.com>
>>>> I submitted a v9 of this during Taylor's maintainership, but it fell
>>>> between the cracks. I've submitted a rebased-on-master v10 now (there
>>>> were some conflicts):
>>>> https://lore.kernel.org/git/cover-v10-00.12-00000000000-20221215T08480=
3Z-avarab@gmail.com/
>>>> It's just the "prep" patches, the real meaty part is converting the
>>>> merge drivers, which will come after. Some of the performance numbers
>>>> for those are really impressive...
>>>
>>> I think splitting this in two is a good idea as there were only a
>>> couple of outstanding issues with the first half of Alban's V8. When
>>> you posted V9 I looked at the range-diff hoping to see a couple of
>>> localized changes addressing those issues. Instead it looks like
>>> you've rewritten most of the patches that people have already spent a
>>> considerable time reviewing. I don't think it is a good use of
>>> reviewers' time to essentially start reviewing again from scratch.
>> What do you consider a good way to turn this comment into something
>> actionable?
>
> To address the issues noted in [1-3] by tweaking patches 3, 5 & 7 of
> v8 and not rewrite all the other patches.=20
>
> Best Wishes
>
> Phillip
>
> [1] https://lore.kernel.org/git/220817.86lernaa9i.gmgdl@evledraar.gmail.c=
om
> [2] https://lore.kernel.org/git/o759r3qn-nqn9-oq22-p90o-2nrn24085n80@tzk.=
qr
> [3] https://lore.kernel.org/git/2r992r19-or36-733r-1139-4575n9o6o23s@tzk.=
qr

That seems to implicitly assume that the outstanding feedback on the v8
was the last word on outstanding issues with the series.

The v9..v10 combines addressing those, with issues that I discovered
along the way. I had not reviewed this series in any detail before.

So, I could submit such a v8.5, and then comment on it, and address
those comments, and then we'd be back to the same v9 in the end?

Since I didn't see the point of doing that I submitted the v9 directly.

> Note that the sequencer cannot die() while merging so we need to be
> careful when fixing patch 3 - it should bail out early rather than
> dying when there is an error.

Yes, part 2 will address that, i.e. there are callers that need to not
die() in the same process, but the v8 took the approach of changing the
entirety of the API to error(), but as it turns out the surface where we
needed to error() or die() is much smaller than that in the end.

>> To have a minimal re-submission of the v8 which simply fixes the
>> semnatic & textual merge conflicts we've had on "master" in the interim?
>> I think such a re-submission would need to address the issues I
>> noted in
>> the v9 CL[1]. E.g. that in over-libifying merge-index its behavior was
>> changed, e.g. emitting N error() instead of die()-ing on the 1st
>> one. Addressing that is going to need to require around the same code
>> changes.
>> This is also a case where the range-diff looks overly scary, aside
>> from
>> such specific fixes the end result is substantially the same, but I did
>> split up (and mostly not rewrite) the existing patches to:
>> * Cleanly separate those bits that were changing behavior, from
>> those
>>    that were not (and precede them with tests to assert that)
>> * Make the eventual libification change as small as possible, now it
>>    really benefits from the diff rename detection.
>> If you have some more specific suggestions for how to move forward
>> I'm
>> all ears.
>> 1. https://lore.kernel.org/git/cover-v9-00.12-00000000000-20221118T11005=
8Z-avarab@gmail.com/

