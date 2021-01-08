Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9273C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 01:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A63C23601
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 01:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbhAHBwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 20:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbhAHBwz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 20:52:55 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22993C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 17:52:15 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a109so8309649otc.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 17:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+uuPiqr41BKR8zb9ALYF01gqqXIo5ov/wAzRRxk4Clg=;
        b=H42ghPGnTbLVNwkuOI9E0/ACd/FzZLwAoQnwxAwc62Gn3DHM4si+tJKTgGH8lijmCs
         GiMFLHvBuNIITcTXTzrBbwCea8R3c2ftG5WogAWKEAQ1W2Dai9A9hmDAfJO3N+H62lfP
         wFfKpKCBnTQDPPwRzVwikk1ibh0n7GKqYKn8aK8RoAP0d17CiFcRZ45jBitM0PTZDvSC
         jf1VBR0DsFhds/LO+A39yiQklGZhFc00WYFefip/1dv1M957VfsnghPYfYzDrtcn18iJ
         Hpyd55LZsJYSV9iaQAcKs+BZAfNRhozPFt4ZkvDYAkfOvQzDYYFylhr7FYIj2rVXcWaL
         A+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+uuPiqr41BKR8zb9ALYF01gqqXIo5ov/wAzRRxk4Clg=;
        b=a38mqxBBGqBj5TVfiz7o96FvE6XKN0lZ06E/+wdlg67jaMDgOqa6pI426vkZZPMJyS
         ZfSHxDHy8jx85iBQWDFwz0OhjGTa2Wd7XAcpcSRyBMJKrhIzyFv7Dm0JFd63WmOLmhOE
         Yj7EE8xdyU6d9fKHEjI8hkjr7pUdqpU18VwkHRgXwKxFXmTNfFGsn04Lvy4fLV4L26eG
         l9Hw9pAJDrJzlGUZS3Upx3A4cJ4c+PcwiDBoIvoiBqDG59KDDly0flORmUwcgp40DIFq
         VjcLbi/WZGy976nqMmNGnV8sg01qw7LgbnAUuj5Sco3fOCAxFaaNz5LzGYD8OPldPj47
         DLoA==
X-Gm-Message-State: AOAM530GkNSwM2f4ysW4WrOU29LUNMzZJarhiIQzAuVi070RfvefrSrC
        fr0Qkloimi5ZEGFob6Ty8jU=
X-Google-Smtp-Source: ABdhPJyofwA7B88Q5NBFJf/TChuJ57ghAj1I+YapwjETY6XISZoW4qUBGOtcF3wEZ5ebEnBLOUaxKA==
X-Received: by 2002:a05:6830:578:: with SMTP id f24mr975671otc.36.1610070734344;
        Thu, 07 Jan 2021 17:52:14 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id a18sm1490846otf.33.2021.01.07.17.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 17:52:13 -0800 (PST)
Subject: Re: [PATCH v2 14/14] update-index: remove static globals from
 callbacks
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
 <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
 <2b171a142b36b114d5ff526073fe3fd9517a4d32.1609821783.git.gitgitgadget@gmail.com>
 <CAPig+cTfHsd7WMvcX1_433WVOG+y4FceUACBx_4UfnjJTgVY6g@mail.gmail.com>
 <73f51832-583a-27e8-65fa-86eb0ebac4cf@gmail.com>
 <CAPig+cSLsLibDik3YYTPdwbHpywStMxR_4rRBZfYrX7S-cFnNA@mail.gmail.com>
 <xmqq4kjsmses.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e598f0e4-bdd9-4b59-f267-545204829a63@gmail.com>
Date:   Thu, 7 Jan 2021 20:52:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqq4kjsmses.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2021 2:57 PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>>> It could be possible to replace all references to 'istate' with
>>> 'repo->index' but the patches get slightly more messy. I also
>>> think the code looks messier, but you do make a good point that
>>> there is no concrete reason to separate the two.
>>
>> I agree that it would make the code a bit noisier (to read) if
>> `istate` is eliminated from the callback structure, however, even
>> though I didn't originally feel strongly one way or the other about
>> having both `repo` and `istate` in the structure, I'm now leaning more
>> toward seeing `istate` eliminated. My one (big) concern with `istate`
>> is that it confuses readers into wondering whether `istate` and
>> `repo->istate` will ever be different.
> 
> Some applications may want to work on more than one in-core index at
> the same time (perhaps a merge strategy may want to keep a copy of
> the original index and update a second copy with the result of the
> merge), and it may be useful for such applications if 'repo->istate'
> does not have to be the in-core index instance to be worked on.  So
> things that go in libgit.a may want to allow such distinction.
> 
> But what goes in builtin/ is a different story.  As long as this
> application has no need for such a feature and will always work on
> the primary in-core index, prepared for the in-core repository
> structure for convenience, it may not worth it to support such a
> feature that no callers benefit from.

I'll try to restructure my patches to do the following order:

1. replace compatibility macros with static global references, except
   i. use 'istate' in the methods that don't need a repository.
  ii. use 'repo->index' in the methods that need a repository.

2. replace static globals with method parameters.
   i. drop 'istate' static global with method parameters. Methods that
      have a repo will pass 'repo->index' to these methods.
  ii. drop 'repo' static global with method parameters.

3. replace static globals in callback methods using 'repo->index',
   where 'repo' is a member of the callback_data struct.

That should keep the structure as presented in v2 while also avoiding
this question of "can istate differ from repo->index?"

Thanks,
-Stolee
