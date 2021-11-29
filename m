Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5D6C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhK2XGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbhK2XGA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:06:00 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B14C05814A
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:42:52 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so27041721otg.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fc0cmmhgGlKUsZV8WZZrtDQIXypUL0JrRSd2dnt2zaY=;
        b=mWdoCvyPyOdVPVDzTKq9LtWSKZzwJnx0pe3rvWkf1HC8Wv6NLopUjRBURzX+7cXnYR
         MyzMOarDKeKlMux8sCUVZLuOixnzGdt3nCOdlmSaYpU140WNxJFTKmFFQRKVQmcAMsQB
         MM85NOQXswRaBaLbXz516CfNOl5aUiTNUz7i5kr2TiH3XHeqeMumX8jiWq4YZwZeHymZ
         tVYsDbMbo3jVNk4KQpe5M8MxYQh3I4NncI2kyhtOhKNTXdnBGu5Mp8N1cTao047+2HMK
         MbkCIbIG3mV1md1c1CCcNwCwqMOixQpxzVtfAnkjVuJ4coUnNqUy+qlfwotWZJcM2CQE
         I0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fc0cmmhgGlKUsZV8WZZrtDQIXypUL0JrRSd2dnt2zaY=;
        b=T1PhjGD7ZA5V4ahoCRH0hhZ+LJdvNqTg+RgtVyHm7f+c1wGuGOMRVFhvEXfHaYZoIq
         sJVLl8yZWACuvvVuSuiUbp1F4VcIObmUHh+NJulGob+c/V2rTbhuJ20kV+/1rLpfsY38
         lFYKw4eVwJwwM60eCfRDM5m2Nis/wmDq3TKGtQSs76HgsXfxWYQgv2PQ5HSThXfqpews
         EAKUglqUwrg9JRGvsWshTzzpcJpTLuZ0qbgc3ETQF7uF1SZtp4pNhaxNpt93zX5QoGtj
         wtON/QPADFVB1hWfTMOoqXJLPZlJeYc2A+vI+BmYGYR5hWCpUaUDaD4UrPuxKi2UeN60
         JISg==
X-Gm-Message-State: AOAM533iRM1UWUMfLCqmv0SzAp02WJASw49h83vQwHOSiNbyIuuAt3i8
        xhU9xV8ks3bmS3W1Qj9VnPY=
X-Google-Smtp-Source: ABdhPJzAiy2jnts/VbTdtLKxxMt7CCEAVbjof5ZTeqA8ObCEeUcG51Gxn4fw30bxqhSiCIpRITGLTw==
X-Received: by 2002:a9d:6482:: with SMTP id g2mr45135141otl.57.1638214971189;
        Mon, 29 Nov 2021 11:42:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3085:654c:eb81:848b? ([2600:1700:e72:80a0:3085:654c:eb81:848b])
        by smtp.gmail.com with ESMTPSA id g1sm2362482ooq.2.2021.11.29.11.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 11:42:50 -0800 (PST)
Message-ID: <d0f7eb3e-fb8d-a1d5-b582-c2eb23ebb1f5@gmail.com>
Date:   Mon, 29 Nov 2021 14:42:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 07/11] rebase: do not attempt to remove
 startup_info->original_cwd
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
 <39b1f3a225ec74a79320503eff04ba47ae4259fd.1637966463.git.gitgitgadget@gmail.com>
 <7d90bf61-59c6-045e-1987-81d50454c260@gmail.com>
 <CABPp-BFr-U1kaqaj9HR+A=tRt0F_btcbDp89xeoZRdXewM4a2w@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BFr-U1kaqaj9HR+A=tRt0F_btcbDp89xeoZRdXewM4a2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2021 2:22 PM, Elijah Newren wrote:
> On Mon, Nov 29, 2021 at 9:50 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 11/26/2021 5:40 PM, Elijah Newren via GitGitGadget wrote:
>>>       cmd.git_cmd = 1;
>>>
>>> +     if (startup_info->original_cwd &&
>>> +         !is_absolute_path(startup_info->original_cwd))
>>> +             cmd.dir = startup_info->original_cwd;
>>
>> I was initially confused by the "!is_absolute_path()" because
>> it seemed to me like it would be natural to store an absolute
>> path there, but I see this comment in patch 2:
>>
>> +        * For convience, we would like to have the path relative to the
>> +        * worktree instead of an absolute path.
>>
>> So it seems that we won't store it as an absolute path. Is
>> there any value in this condition, then?
> 
> Good catch.  This is leftover from an earlier round; I'll remove it.
> From stash too.
> 
>> This assignment of cmd.dir to the relative path has a lot
>> of baked-in knowledge of this variable _and_ the current
>> state (Git chdir()'d to the root of the worktree). If the
>> path is always relative, then it should be a BUG() if we
>> see an absolute path. Also, it seems like we would want
>> cmd.dir to be a concatenation of the worktree root and the
>> original_cwd.
>>
>> Or perhaps I'm being overly cautious and this could all be
>> resolved with a comment about the expected state of the
>> working directory and original_cwd. The tests will catch if
>> any of those expectations change.
> 
> Yeah, with the extra condition in there I should have added a good
> explanation about why I had it in there.  But I think a simple
> 
> if (startup_info->original_cwd)
>     cmd.dir = startup_info->original_cwd;
> 
> should be good enough?  Or do you still want a comment for that?
 
This is the code I would expect to see. No comment needed.

Thanks,
-Stolee
