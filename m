Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1088C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 10:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1AFD61101
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 10:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbhHSKHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 06:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237889AbhHSKHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 06:07:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A1BC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 03:06:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso6424516wmb.2
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JMAOyadSm3aOvdUjDvv0SWygI9M8DFnpM83QPpIXiZw=;
        b=YNDe3wOLGv50eMJ6douskYw9lU0LNo3GeGFz0eV0Z6iyBOERAPR2Gt4pLP/GYhfSqm
         I0T5MOuP8Y1qu+C2/c00qxNEY7E0EFK45OZtWovMSTMI4OdYbopSV6dzrqCPRsAIHuU7
         1cGVag0fBz3bdLKdPnoD6kUeHe8KWMAUjkmBw4ESs8taEhcVVpwtH1hTv9GN2J+HnBQ/
         4dPWdfasA9dAySB3Qi3mfSix7+0hdMYNs8YcAchzUzOrBkEd9Gj62U46o4cecvzJEjCp
         kHSxn0WbnkEcOfk0zpn/qgHL7jGFsdH4JpFHr8H2HWq9WGAR0fLObGmyih+mEwrVoUlU
         J49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JMAOyadSm3aOvdUjDvv0SWygI9M8DFnpM83QPpIXiZw=;
        b=EtK6xi/c6Ke2W4/VGWnEM5oKPanvLs3On6VeHkE6JA5ZbmWS/OR+Sv+jVxRv1RankR
         zS6x9BNQA4QdINLIQQrhdjotRev1slj/yaKC6GLd+8/dXxaC/82POYBhyZM1QHD9Br0o
         RaHsKX6GRWvw543B6uwVq2ANS5IIB4+4SFNzoDJ3qLLv+RylIGRLAt/wM62gpXF0GeVW
         oHnkKqgp1BqIydLjwi7Q8JSEOq4i8MmjtQELOCunyZAlD0+8AG+NP5D0vTKgcIZNPQCb
         8ARgsWR9Z4UQUtnu3XsN4vDZPojygqEOqYNNSnprwTA/sK+EN8HGAQr0SZEhCb2PAa7T
         BDDQ==
X-Gm-Message-State: AOAM5319jWtZGJ+s+IhU/AUox+ngsMv9cuxpsqkaePESYxOuOL4aqS0B
        uWHJ/SeL5M/67KUM488H5JSV55WbvWM=
X-Google-Smtp-Source: ABdhPJyay2uiJYZy1lcoqGnjV18KesQvBWeGexf1PNBcmN+AfUU3kWMJSiH004Ooe9dkO8f18hQfTg==
X-Received: by 2002:a1c:43c1:: with SMTP id q184mr830361wma.140.1629367601521;
        Thu, 19 Aug 2021 03:06:41 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id l19sm2185296wmi.4.2021.08.19.03.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 03:06:41 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqv945ng61.fsf@gitster.g>
 <92511bbe-5ef3-cfef-0a0b-30fbda2df201@gmail.com> <xmqqh7fonhlo.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2fde9f61-0b7b-63c2-d08b-50c3dd5b2c3c@gmail.com>
Date:   Thu, 19 Aug 2021 11:06:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7fonhlo.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 17/08/2021 20:32, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> * pw/rebase-skip-final-fix (2021-08-13) 3 commits
>>>    - rebase --continue: remove .git/MERGE_MSG
>>>    - rebase --apply: restore some tests
>>>    - t3403: fix commit authorship
>>>    Checking out all the paths from HEAD during the last conflicted
>>>    step in "git rebase" and continuing would cause the step to be
>>>    skipped (which is expected), but leaves MERGE_HEAD file behind in
>>>    $GIT_DIR and confuses the next "git commit", which has been
>>>    corrected.
>>>    Will merge to 'next'.
>>
>> Thanks
> 
> Thank *you* for the series, and you do not need to comment on your
> topic only to say that.  But if you need to _stop_ me from merging a
> topic to 'next' (because you want to replace it one more time, or
> you see something wrong with it), please don't hesitate to do so.

Sure, I would not have replied just to say thanks but as I was writing 
anyway I thought I would.

Best Wishes

Phillip

>>> * lh/systemd-timers (2021-07-02) 3 commits
>>>    - maintenance: add support for systemd timers on Linux
>>>    - maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
>>>    - cache.h: Introduce a generic "xdg_config_home_for(…)" function
>>>    "git maintenance" scheduler learned to use systemd timers as a
>>>    possible backend.
>>>    Waiting for reviews.
>>
>> I'd really like to see this merged, there was some discussion a couple
>> of weeks ago (cf <4aed0293-6a48-d370-3b72-496b7c631cb5@gmail.com>), it
>> petered out but no one seemed to be objecting to merging it.
> 
> Thanks for paying attention to this item.
> 
> My impression was that everybody liked the ability to use systemd
> timers as an alternative to cron, but as Derrick summarised in the
> message you pointed at, the implementation is not quite there, I
> think.
> 
> So "Waiting for reviews" was a mislabel; we are waiting for a
> reroll.
> 
>>> * zh/cherry-pick-advice (2021-08-14) 1 commit
>>>    - cherry-pick: use better advice message
>>>    The advice message that "git cherry-pick" gives when it asks
>>>    conflicted replay of a commit to be resolved by the end user has
>>>    been updated.
>>
>> I think this is getting there now, I need to look at the tests in v5
>> but the changes to sequencer.c looked good to me.
> 
> Yes.
> 
>>> * jk/commit-edit-fixup-fix (2021-08-15) 1 commit
>>>    - commit: restore --edit when combined with --fixup
>>>    "git commit --fixup" now works with "--edit" again, after it was
>>>    broken in v2.32.
>>>    Will merge to 'next'?
>>
>> Yes please, there was a new version posted at the weekend but I've
>> just checked and you've already picked it up in seen.
> 
> Yes, this looked good to me, too.
> 
> Thanks.
> 

