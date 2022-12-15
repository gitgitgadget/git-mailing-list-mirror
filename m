Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D5DC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 16:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiLOQ2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 11:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiLOQ2L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 11:28:11 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BF537F8C
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 08:27:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so2180869wmh.0
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pEbGwNDjrn5V+apabeNfeUNjmQo9QdpW7E88S9A00WQ=;
        b=O29c2WdrLg6UnRtSl1xWjascAaDwOg7hJXpH7mk18bcXm3yJMLYAwBGhDJQF7K0X1S
         KM0IotJfbbJg7JBNP+DqHBnLgC1RA49LioSjLJUhQnUCsr8y1lrQKIr0Sh77Qm4AuWcr
         7VQtMgmtHahQo0czndmOMWdsJMRlWGkId+2TMJZePRbaLppg+/pFFoCL7Cq/rhS4tk47
         zZTNJ1JdWJfhpfnkb+cH58DzPidFSuAvG4gvOV1DcaGiZwv/6crS2oxMFztbZtL2Dua6
         2QC4CoRuGhcF0rzcW6L3ppkw+2ia2JwGHm6iHIPg2N8n4E77Q7JZ2mdP0d7qm2wmVw8S
         oB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEbGwNDjrn5V+apabeNfeUNjmQo9QdpW7E88S9A00WQ=;
        b=tGTz1pRE7Y/mzZSEGfbH4fTLFp54AZ/6hUWFjDDeT+gN2lk/MknQOp4JsFUPj3HPIO
         6cpd2IuBzTWvJ1as2hC3woeud6ReBS9XYUflKAXgID0ML4+grFvEMIyvmtNzdphqw1j5
         AwbTyVbDpGGPNw38zJEcITzJRtF16OHNVvN33Py3U7AUdhtJgcz/8xqdGMcD8uECdLEt
         hxexTa/GZ8r/3FpYfvaZo0jUaJkBC5IFuFL/AGMxNwA4JPoUaoyZfvf9vecKvjxuxv4o
         10xadaRSmPqz1FtzO3KXBv23OQ0lXBIJD+HlH2a2X60CHCt2a78oDLpz/jwgIwsGhkPk
         e1Nw==
X-Gm-Message-State: ANoB5pmFnR0SbphmP4n/oE0e4bCsHpCPWdwXugacYgNZMZeGLtVpILC8
        j5H8jCGE2LfBOzCGt1x69XHq3mmRDJA=
X-Google-Smtp-Source: AA0mqf7LKlRN3DPOSlMbPtaBHRgeFHAtCVoYtWig574rLGwym2zdSusk4Zs1f/rmMaGC0gCxI+HW3A==
X-Received: by 2002:a05:600c:1e8f:b0:3cf:728e:c224 with SMTP id be15-20020a05600c1e8f00b003cf728ec224mr22376898wmb.6.1671121673959;
        Thu, 15 Dec 2022 08:27:53 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c2ca500b003d1e1f421bfsm7322928wmc.10.2022.12.15.08.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 08:27:53 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <e7da3e4c-e87d-0282-0b8a-2fa2fee371aa@dunelm.org.uk>
Date:   Thu, 15 Dec 2022 16:27:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ag/merge-strategies-in-c (was: What's cooking in git.git (Dec
 2022, #05; Wed, 14))
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alban Gruin <alban.gruin@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <xmqqiliewbje.fsf@gitster.g>
 <221215.865yed3tzv.gmgdl@evledraar.gmail.com>
 <c9c2c979-82b3-8be1-1edb-343661cf4b32@dunelm.org.uk>
 <221215.86a63o3c0i.gmgdl@evledraar.gmail.com>
In-Reply-To: <221215.86a63o3c0i.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 15/12/2022 15:32, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Dec 15 2022, Phillip Wood wrote:
> 
>> On 15/12/2022 09:14, Ævar Arnfjörð Bjarmason wrote:
>>> On Wed, Dec 14 2022, Junio C Hamano wrote:
>>>
>>>> * ag/merge-strategies-in-c (2022-08-10) 14 commits
>>>>    . sequencer: use the "octopus" strategy without forking
>>>>    . sequencer: use the "resolve" strategy without forking
>>>>    . merge: use the "octopus" strategy without forking
>>>>    . merge: use the "resolve" strategy without forking
>>>>    . merge-octopus: rewrite in C
>>>>    . merge-recursive: move better_branch_name() to merge.c
>>>>    . merge-resolve: rewrite in C
>>>>    . merge-one-file: rewrite in C
>>>>    . update-index: move add_cacheinfo() to read-cache.c
>>>>    . merge-index: add a new way to invoke `git-merge-one-file'
>>>>    . merge-index: drop the index
>>>>    . merge-index: libify merge_one_path() and merge_all()
>>>>    . t6060: add tests for removed files
>>>>    . t6060: modify multiple files to expose a possible issue with merge-index
>>>>
>>>>    An attempt to rewrite remaining merge strategies from shell to C.
>>>>
>>>>    Tired of waiting for too long.
>>>>    source: <20220809185429.20098-1-alban.gruin@gmail.com>
>>> I submitted a v9 of this during Taylor's maintainership, but it fell
>>> between the cracks. I've submitted a rebased-on-master v10 now (there
>>> were some conflicts):
>>> https://lore.kernel.org/git/cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com/
>>> It's just the "prep" patches, the real meaty part is converting the
>>> merge drivers, which will come after. Some of the performance numbers
>>> for those are really impressive...
>>
>> I think splitting this in two is a good idea as there were only a
>> couple of outstanding issues with the first half of Alban's V8. When
>> you posted V9 I looked at the range-diff hoping to see a couple of
>> localized changes addressing those issues. Instead it looks like
>> you've rewritten most of the patches that people have already spent a
>> considerable time reviewing. I don't think it is a good use of
>> reviewers' time to essentially start reviewing again from scratch.
> 
> What do you consider a good way to turn this comment into something
> actionable?

To address the issues noted in [1-3] by tweaking patches 3, 5 & 7 of v8 
and not rewrite all the other patches. Note that the sequencer cannot 
die() while merging so we need to be careful when fixing patch 3 - it 
should bail out early rather than dying when there is an error.

Best Wishes

Phillip

[1] https://lore.kernel.org/git/220817.86lernaa9i.gmgdl@evledraar.gmail.com
[2] https://lore.kernel.org/git/o759r3qn-nqn9-oq22-p90o-2nrn24085n80@tzk.qr
[3] https://lore.kernel.org/git/2r992r19-or36-733r-1139-4575n9o6o23s@tzk.qr

> To have a minimal re-submission of the v8 which simply fixes the
> semnatic & textual merge conflicts we've had on "master" in the interim?
> 
> I think such a re-submission would need to address the issues I noted in
> the v9 CL[1]. E.g. that in over-libifying merge-index its behavior was
> changed, e.g. emitting N error() instead of die()-ing on the 1st
> one. Addressing that is going to need to require around the same code
> changes.
> 
> This is also a case where the range-diff looks overly scary, aside from
> such specific fixes the end result is substantially the same, but I did
> split up (and mostly not rewrite) the existing patches to:
> 
> * Cleanly separate those bits that were changing behavior, from those
>    that were not (and precede them with tests to assert that)
> 
> * Make the eventual libification change as small as possible, now it
>    really benefits from the diff rename detection.
> 
> If you have some more specific suggestions for how to move forward I'm
> all ears.
> 
> 1. https://lore.kernel.org/git/cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com/
