Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A17C07E95
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 14:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D16610D2
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 14:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhGSNZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 09:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbhGSNZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 09:25:09 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F381C061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 06:30:13 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u11so20834420oiv.1
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SoYUTjcogOwLcL+D8v/8ybpbGCsnukrw6D6DbzdkNLI=;
        b=iGD9HY7D3GFTno9JcYJVqi47+NglEQQK/bE5DES3JGM9L+yV1rvvfbKSMisksx3d+k
         67QD8VCsW/DhC9yBJSbBXGKmpPMlfE0D84d8HTU9kjZ27RKqCRVHzsTwBdd6DQ6FAOWG
         VsmQ71v7CkSEAs0in/zeo0JLru8hHZzoPeX6YyBCc50pVlEpxCGQYzZ9FNinv05idVrl
         qiDezSEF1Bl+OA7mjfCTeMZEJdjvqC8xI2JRzTwU2d6stIWJWhMt9awoMMyrCPDqRCsW
         GGy0ch/8B5R5vlwcqlSJNAWrwrbpuZqhNFlvEuRAtZ+JyGBgIGWQeIOY3R/2hne8y1a+
         X9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SoYUTjcogOwLcL+D8v/8ybpbGCsnukrw6D6DbzdkNLI=;
        b=SIdrdZ1uvEGT9KOQ2EHKDctdLO8mSJJgkfWkVJVqQlBQ862p+tsClnTP9OCU8VYoue
         J03kxRZ5g1CN/EPdZfA2AqNRcMlEYhUYYf8iu21Z/SEAYqoMvUS9nOGQLV3Nzk/pn5Ip
         39DD8L6bidHnn9BY9gRrEeLCV0ASznHT8eGzrA/YoL4Og6XoSEMugVBgNuANqorPVL4N
         9Vhklb05tzCZB0ixNJovjbEp3WvNe7o/mQuDjfOM2HMVvOAaMYvCi/fmnmMSbutnvEPS
         QVwpQHk+Rg5/VmVy7yX1amNRe3eD9KnDZCyYPcNYBCgadYHZ4qpMZoE+/lFr1QylFOz4
         Cl7A==
X-Gm-Message-State: AOAM533r+0vGtfv4g6ud6K6Wx2vk0Tka9OoghPyBQnEKjhyD9m6y6dcs
        79lxar7aexM5KXFPDdm7N6g=
X-Google-Smtp-Source: ABdhPJwBoomc5GV9yCFMwCuJoKGa0FGbrHoMZ1yGeWNPiztksAMY/y85mHv9uVUFvI9inQko90zlkA==
X-Received: by 2002:a05:6808:2d2:: with SMTP id a18mr22322513oid.106.1626703547840;
        Mon, 19 Jul 2021 07:05:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:517d:c5fa:4375:5b79? ([2600:1700:e72:80a0:517d:c5fa:4375:5b79])
        by smtp.gmail.com with ESMTPSA id v4sm3176195otk.75.2021.07.19.07.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 07:05:46 -0700 (PDT)
Subject: Re: [PATCH 0/5] Sparse index: integrate with commit and checkout
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
 <CABPp-BF_i1QRCXaeKzqoc6Q2=3un-wku7aKUEdBbXfeVfTG8xg@mail.gmail.com>
 <b362c428-eec9-39e3-55a0-0738431e1d98@gmail.com>
 <c127ceed-10fd-9ad0-e858-db79bec0cf8d@gmail.com>
 <CABPp-BGCnV-xHH-+S58pqFFhPbPj_0Rt=_QUf_ShAbTCyW9deA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <91b81577-3ff8-3845-75d1-c47e8a42406e@gmail.com>
Date:   Mon, 19 Jul 2021 10:05:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGCnV-xHH-+S58pqFFhPbPj_0Rt=_QUf_ShAbTCyW9deA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/17/2021 11:37 AM, Elijah Newren wrote:
> On Fri, Jul 16, 2021 at 6:59 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 7/12/2021 2:46 PM, Derrick Stolee wrote:
>>> On 7/9/2021 5:26 PM, Elijah Newren wrote:
>>>> On Mon, Jun 28, 2021 at 7:13 PM Derrick Stolee via GitGitGadget
>>>> <gitgitgadget@gmail.com> wrote:
>>>>>
>> ...
>>> Further, I expect it to be simpler to modify the behavior
>>> here to match the full checkout case than to make the
>>> sparse-index case match the normal sparse-checkout case.
>>> The "natural" thing would be to keep the staged "folder1/"
>>> directory, but that would present as adding all contained
>>> content, not just the single staged entry.
>> Taking a closer look at the full checkout case, I discovered that the
>> 'git checkout df-conflict' command succeeds in the full checkout case if I
>> apply it directly to the 'master' branch. In that situation, it completely
>> removes the staged change to folder1/edited-content! This seems like
>> incorrect behavior, and has nothing to do with the sparse-checkout feature.
> 
> I was not able to reproduce.  Do you have other modifications to git,
> or is there some other special setup required to trigger the bug that
> I am missing in reading the paragraph above?  Here's what I see:
> 
> <Add an "exit 1 &&" right after "init_repos &&" in the 'diff with
> directory/file conflicts' test, run until first failure, then:
> 
> $ cd trash directory.t1092-sparse-checkout-compatibility/full-checkout
> $ git reset --hard
> $ git checkout rename-in-to-out
> $ echo more stuff >>folder1/edited-content
> $ git add -u
> $ git checkout df-conflict
> error: Your local changes to the following files would be overwritten
> by checkout:
> folder1/edited-content
> Please commit your changes or stash them before you switch branches.
> Aborting
> 
> This looks like the expected behavior to me, and is what I'd also
> expect from the sparse-checkout and sparse-index cases.

It is fragile to the data shape in my test, so I'll be sure to
include one in the next series version that demonstrates the change.

>> It just happens that a sparse-checkout will have a _different_ kind of
>> incorrect behavior!
>>
>> However, when adding the test on top of the ds/status-with-sparse-index
>> branch, the full checkout case matches the sparse-checkout! I bisected
>> this to the additions of files adjacent to folder1/ (folder1. folder1-,
>> etc) in e669ffb (t1092: expand repository data shape, 2021-07-14). If I
>> switch the test to conflict on folder2, then I get the strange behavior
>> that I was noticing on 'master'.
>>
>> Some very subtle things are going on here, and they don't necessarily
>> involve the sparse index. Adding the sparse index to the mix creates a
>> third incorrect behavior to this already-broken case.
>>
>> If we agree that the correct thing to do here is to reject the merge and
>> fail the command, then I can start working on making that change in
>> isolation (because _none_ of the existing behaviors are correct).
> 
> Yes, rejecting the merge is the correct behavior.  This is implied by
> the existing documentation for both the --merge and --force options to
> checkout.
> 
>> That leaves a question as to whether we should hold up this series for
>> that reason, or if I should pursue a fix to this kind of conflict as a
>> forward fix on top of it. What do you think, Elijah and Junio?
> 
> I only dug in and found the sparse-checkout/sparse-index bugs because
> the D/F changes you made to twoway_merge() looked clearly wrong to me
> and I was trying to find a case that would demonstrate it and make it
> easier for you to fix up.  I still think the patch is wrong and that
> it adds a bug.  If you can drop that patch, and still get correct
> behavior in your tests, then I think we can ignore other bugs in this
> area, but I'm not happy with that particular patch.  If you need that
> patch, then it needs to be corrected, which probably means figuring
> out all these bugs.

That's a good point. I reverted the patch and re-ran the test and
found that actually the patch is necessary in order to match the
_incorrect_ behavior. Without the patch, the sparse-index case
(correctly) refuses to complete the checkout.

I'll replace this patch with a test change that demonstrates these
subtleties and marks them as NEEDSWORK.

Thanks,
-Stolee

