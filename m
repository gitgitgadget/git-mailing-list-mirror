Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7953AC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 09:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJTJvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 05:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJTJvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 05:51:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7840015F33B
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 02:50:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 186-20020a1c02c3000000b003c6c154d528so1886325wmc.4
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4OJH1dsQjtZFYr6dtC0OU1pfI4K3bemS7X2cE/G8O14=;
        b=k0X+aOe8gInibS1CFyRd3pH5Gkdxhg04zKBWkNbfuv9HdJjpnlWOSteMQiiYx4XrJS
         BkONG/v8cUyPIG7VtM86GcHPGLSueXEMypveFxp8vW9IwifD+SR000qyD1zo7yiuyMmJ
         tAyBprLHYW2XK0dUwFRXmNEntagp0T4/BuCRaVRaMpDzbhCXCF9RHHIcR9h8ZB2Wsb3V
         Er3RZQdHn7aGmqp8RfNss0Lh4OIpb5qhMc0Vo0f4JGbyPu7Pwizxq/j5saE/GJ0eh4Na
         5dT3oDYI6uHiIruNeNEwFdSPqUF95yKA4MwaEeZEbfs6ZpJ1CKwAa26i15ZmSvPQ2Us4
         LXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OJH1dsQjtZFYr6dtC0OU1pfI4K3bemS7X2cE/G8O14=;
        b=Jm/T1T0lvc3CQfDU16fl/uJvgRy0wp0sJR72aRkjnqSk+d4t4S8p11E8eH//Hxe12x
         4el4doM5VLq5XI5xLM8TVFMEpWi1mhZeo17invd2fFhjS+nfSSuM6MmrIcX2yYjaLBCb
         jbvx8lhbyrowqtDyWbzhhSZHXYH1xKgpxllqMwZ8q+2t1CfMKtsi4zzEK4LDnvj/1rkP
         zieZr+CrOSPpI7JrP9lzPPLah9jztD6DXAdmUI4ThP33QbcNlXm3qpPE0+TIUWCg+gPs
         mzAhNWDVyMp/OueWRg7zg8oPCL0p6CajNmJJUBm3s5NI7edxsO4NcrHvf4+kPE2O79Af
         1k8Q==
X-Gm-Message-State: ACrzQf0qSXrP0zcqmE+hCnH8GCvwS1IAydSCAhO1mS45rPMw69n4XcZc
        K054b9/dkt1pPPyToB9tC5A=
X-Google-Smtp-Source: AMsMyM6Nu4A5Ue4MjqEpgHcpRrL+UT+XXV4+K7dBjKSQ6h5BvClU0ZOBTrAmYAd3K8J8l9mSwaw0zw==
X-Received: by 2002:a05:600c:3511:b0:3b4:bb85:f1dd with SMTP id h17-20020a05600c351100b003b4bb85f1ddmr8880373wmq.42.1666259443520;
        Thu, 20 Oct 2022 02:50:43 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id j18-20020adff012000000b00228fa832b7asm15840825wro.52.2022.10.20.02.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 02:50:42 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f1d75703-dfea-69ee-59e8-18afaf75cbf8@dunelm.org.uk>
Date:   Thu, 20 Oct 2022 10:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/8] rebase --apply: remove duplicated code
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, Victoria Dye <vdye@github.com>
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
 <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
 <a84cf971a753e294555ca8f2b7eaa4c75a8fa491.1665567312.git.gitgitgadget@gmail.com>
 <xmqqedvclqxm.fsf@gitster.g> <xmqq35brh9re.fsf@gitster.g>
In-Reply-To: <xmqq35brh9re.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 13/10/2022 19:13, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Use move_to_original_branch() when reattaching HEAD after a fast-forward
>>> rather than open coding a copy of that code. move_to_original_branch()
>>> does not call reset_head() if head_name is NULL but there should be no
>>> user visible changes even though we currently call reset_head() in that
>>> case.
>>
>> move_to_original_branch() uses both .head_msg and .branch_msg and
>> uses different messages for them, but the original code below only
>> feeds .head_msg while .branch_msg leaves NULL, which leads
>> reset.c::update_refs() to use the same message as .head_msg when it
>> wants to use .branch_msg (i.e. the message recorded in the reflog of
>> the branch).
>>
>> Doesn't this difference result in a different behaviour?

Yes, you're right

> I think "git rebase --apply A B" when B is already an descendant of
> A with a single strand of pearls would trigger the new logic, and
> instead of the old "rebase finished: %s onto %s" message used for
> both reflogs, calling move_to_original_branch() will give us "rebase
> finished: %s onto %s" in the branch reflog, while "rebase finished:
> returning to %s" in the HEAD reflog.
> 
> Note that I am not saying we should not change the behaviour.
> Saying "returning to X" in the reflog of HEAD may arguably be better
> than using the same "rebased X onto Y" for reflogs for both HEAD and
> the underlying branch.
> 
> But if that is what is going on, we should record it as improving
> the reflog message, not removing duplicated code.
> 
> Also, it would be good to have a test that demonstrates how the
> contents of the reflog changes with this change.  It took me some
> time to figure out how to reach that codepath, even though it was
> relatively easy to see how the reflog message(s) used before and
> after the patch are different.

I've just checked and the tests added in the next patch do test this 
path (they fail if I revert this commit). I should be able to swap the 
two patches round to demonstrate the change in behavior and rework the 
commit commit message for this patch.

Best Wishes

Phillip

>>> The reason for this is that the reset_head() call does not add a
>>> message to the reflog because we're not changing the commit that HEAD
>>> points to and so lock_ref_for_update() elides the update. When head_name
>>> is not NULL then reset_head() behaves like "git symbolic-ref" and so the
>>> reflog is updated.
>>
>>> Note that the removal of "strbuf_release(&msg)" is safe as there is an
>>
>> The patch is removing strbuf_reset(), not _release(), here, though.
>>
>> We have released already so there is no point to reset it again, so
>> the removal is still safe.
> 
> Thanks.
