Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CD2C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 11:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5263361964
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 11:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhC3L3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 07:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhC3L27 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 07:28:59 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A64C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 04:28:59 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so3683023oof.13
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EAHPkOl8aGdqQ9774Y1xWMq3Q718PjRWHqnZb+eGCK0=;
        b=jWi2yCp8dmdojO9gxkwHksmynlIc5f5MUThhEFNalZUEEkQ0hj31EDIBcSYFBdpPY2
         /tL4mfGPct0G0zvpMmX02VTEFK06ausMhNSbZ4rgYTV1+Ul55x7ho8FkKVBqYPjJhiwL
         OlOzHbOV3YZ3ErURMmK5L8ttOp/6tZ3rFywAmdMqBVamAZ6gnABJAB40uOUFwQYYYByH
         jsCtQnpBVRI7gJ2H7qA+M+nmrnLMoZq8U10DrhfYzBeNmJaHKVW10jy5JiHgpzOjzD/l
         Lc4dkORIfXXWU2oEHL1ZmsHt2U8ijxTbJ6z5fybNA8vkJbXOq2zPt/qv8GAhUZ8u1Pgn
         xtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EAHPkOl8aGdqQ9774Y1xWMq3Q718PjRWHqnZb+eGCK0=;
        b=N3gKA8EuKg0NVafBTKh5DxC700uX1ZhgjFz4Ca+mbTneRfmIIwLb+9ptAG2dPHw1kB
         PdFtA8tq2/Rbvuimzzh0eu6Kc4jdlsXPoxDaTS3K64OPvo2KejDl4VfWVxZTinRhEi+a
         F75u6AKMRGYhVJr5LhCaEC/B/wyt0cCc07o1vZN4B5C7uZDjNXDzLwqBcYdy9fGtoxES
         2lHhIFOX3HRd950O6GfQzLqRzjtHLvGoRUmBjE3M3lrMCK1ZYIhcikY/j655LS0M4lDb
         FHoYfMz4CKv4nwAo0vkoTHiUjBw17o6lDT3UMzP4qsOkj4uO+qFqlPoDKYjSHQSTwcfy
         Drzw==
X-Gm-Message-State: AOAM533DGSl8Y8LA84+SRLwbk/Jwroq9svjKJMFfDrkNrvG7TuG90YH8
        T+CU8YcSFqOWt6cK0BPFKOj62yZDqDW8pA==
X-Google-Smtp-Source: ABdhPJxEiTAHhmOTaDgN/51O0SLbKFCzx38fVUJi91+9DBSOic0URlnSlfMfigRLECYvZ2W2DHbYyw==
X-Received: by 2002:a4a:6b04:: with SMTP id g4mr25230225ooc.78.1617103738573;
        Tue, 30 Mar 2021 04:28:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:51d7:1436:793b:b3c9? ([2600:1700:e72:80a0:51d7:1436:793b:b3c9])
        by smtp.gmail.com with ESMTPSA id v6sm4284823ook.40.2021.03.30.04.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 04:28:57 -0700 (PDT)
Subject: Re: [PATCH v4 07/20] test-read-cache: print cache entries with
 --table
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?UTF-8?B?4buNYw==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
 <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
 <87r1k5pcmx.fsf@evledraar.gmail.com>
 <ca8a96a4-5897-2484-b195-57e5b3820576@gmail.com>
 <874kgzq4qi.fsf@evledraar.gmail.com>
 <CABPp-BGRwxn73sntpX8Q5aD-O192RZmOOy_jiU3SQp4-erivtg@mail.gmail.com>
 <87eeg0ng78.fsf@evledraar.gmail.com>
 <b1eee802-f20c-5381-366c-729755bfac8a@gmail.com> <xmqq5z19iqj9.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fbd0852b-eba0-a4a2-ed7a-3b12963609ee@gmail.com>
Date:   Tue, 30 Mar 2021 07:28:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq5z19iqj9.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/29/2021 5:44 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> I think changing 'ls-files' before the sparse index has stabilized is
>> premature. I said that a series like the RFC you sent would be
>> appropriate after this concept is more stable. I do _not_ recommend
>> trying to juggle it on top of the work while the patches are in flight.
> 
> I do not have a problem with either of approaches to help debugging
> (i.e. extending "ls-files --debug" or a new test helper), but I am
> curious to be reminded what the plan for "git ls-files [-s]" output
> is, when run in a repository in which sparse cone checkout is used.
> 
> Do we see trees and paths outside the cone omitted, or does the act
> of running "ls-files" dehydrate the trees into their constituent
> blobs?

At the moment, end-to-end behavior is identical as before: sparse
directory entries are expanded to all of the contained blobs instead
of writing the tree entries.

The sparse-index work will not be complete until every command is
audited for potential behavior change when disabling the
command_requires_full_index setting. That includes deciding what
is the best decision for ls-files, and will likely include an option
for both possible outputs (tree entries, or expanding to blobs). The
interesting discussion that is worth its own topic is whether or not
the tree entries should be displayed by default.

So the plan is: this _will_ be addressed, but in the future after
the core functionality and value of the sparse-index is set.

Thanks,
-Stolee
