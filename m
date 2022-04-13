Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048EDC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiDMUGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiDMUGX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:06:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF337C7B3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:03:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso3438522pjf.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vopg88BHxKw+CemO/3C1/eNUcCjkv8Ks1RB8YNpFr7s=;
        b=BOJR297egKwVfucuP0Ifvrico8aqh7K0+V7wo+pIRbnsKVFLXyKDTyzeGZO9wjn5a5
         gTkjwVsgMbypJewW4+DGnjWwtcuhdHQKZCcgmKMoCZpo4XFBatN5w8BH7/ZE1GcLHcWC
         O+hd58CrS2aq9dFgnaU8Z2oQzLPOwOn/xeFT6fFQF5eWVYm/l99wtNN+gQmpJemnGoC9
         BjgomRXgCD67pPf7GDYqmo3sh57BhjMWYNm50UT+ufVzRLrOmcMXEqdRZT6ljTpPJ/K7
         Ctr4ju+aFQqvYXSe4Xg6AliTAa/GUAXqFKU8tBhDoAIAWcQfotob9kQJdgv0uNMqXi9i
         vN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vopg88BHxKw+CemO/3C1/eNUcCjkv8Ks1RB8YNpFr7s=;
        b=zg8+Tn6jVT0e44+0nFsVEWC7AAgcJwGHL5qkdwJxNxxxYxv9k6Q7MvoRcCR3rD5Gfn
         /5yXwNEJuSM8qtnU3HVjYaBNXWHn9ZRFEbX4moF5F8cUF3gcadjEjKUbFGhPxeEjXS+r
         nKG8CcSaNfoMjTJY0HMEk/W06ENdPG6GjCpnIwZFS2FluCDiCEi6bP7R4/is3ohrjZz1
         AY/Whiv5Lh2whr6fSVaD8sAcIvHJNd2WQRdldQBe0DyJg2DHHXOeo/qWoqxWGteLCSoA
         tGZOv9RMErWxsYDJotjGxW6uDsWcmuhNduLmlEpqa3SwYFvzisJQ5Z9S2zybQS18emJn
         vymw==
X-Gm-Message-State: AOAM53227Pr6OVVkobssTjQtBn+IxsmH1RxmcKcg4jJztrcGBDSrYZDY
        YQXKBV5ROmntH1qKpHPDQUpWLP1AZlU=
X-Google-Smtp-Source: ABdhPJwDynjNdiWt7+NYIbmpYZBgz7WiPFqnhxTmbY9tD0hEk1ZoxoZ1DaY7hAp896GumYTLEP2S1Q==
X-Received: by 2002:a17:90b:4b0e:b0:1cd:a983:6aac with SMTP id lx14-20020a17090b4b0e00b001cda9836aacmr402641pjb.33.1649880239038;
        Wed, 13 Apr 2022 13:03:59 -0700 (PDT)
Received: from [192.168.208.37] ([49.204.137.177])
        by smtp.gmail.com with ESMTPSA id q17-20020aa79831000000b0050566040330sm25169153pfl.126.2022.04.13.13.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 13:03:58 -0700 (PDT)
Message-ID: <c2190b9c-3393-730d-1bed-d793c1d32275@gmail.com>
Date:   Thu, 14 Apr 2022 01:33:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GSoC][RFC][PROPOSAL] Reachability bitmap improvements
Content-Language: en-US
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>
References: <20220406200959.27096-1-chakrabortyabhradeep79@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20220406200959.27096-1-chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

Thanks for drafting your initial GSoC proposal. Some thoughts inline:

On 07-04-2022 01:39, Abhradeep Chakraborty wrote:
>
> I am Abhradeep Chakraborty, currently pursuing B.Tech in Information
> Technology (now in my 3rd year) at Jalpaiguri Government Engineering
> College, India.
> 
> In the last two years, I mainly concentrated on learning and building
> web development things. I mainly use Django, React for my projects. But
> for the past 6 months, I have been learning about devops, cloud technologies
> ( e.g. docker, Kubernetes, AWS etc.), computer networking and core
> technologies (such as git, linux, gcc etc.). I also have an interest in
> some research based technologies like WebRTC, Web3 etc.
>

That's good to know. Do let us know if you have any experience with C
and shell programming outside of your contributions to Git.

> My ultimate objective is to be a dedicated and active contributor to all
> of these technologies. So, I want to start this contribution journey with
> `git` and therefore I want to be a part of this GSoC program.
> 
> ## Me & Git
> 
> I have started exploring the Git codebase since Sept 2021. At first, I
> mainly focused on knowing the git internals. During this time I read
> documentations (Under `Documentation` directory). `MyFirstContribution.txt`[1],
> `MyFirstObjectWalk.txt`[2] and `Hacking Git`[3] helped me to learn about the git
> contribution workflow, how `git log` ( in other words `object walk`) works
> internally.
> 
> Though I had read many documentations, I was still not able to fully
> understand the terminologies (like `refs`, `packfiles`, `blobs`, `trees`
> etc.). (ProGit)[https://git-scm.com/book/en/v2] helped me tremendously here.
> I read the full book and it cleared almost every doubt that came into my mind.
> 
> I have provided my git involvement history below. Activities are sorted
> by timeline from top to bottom.
> 
> ==============================
> PRs, Commits & Discussion Participations
> ==============================
 >
 > [ ... snip ... ]

Good to see your various contributions to Git so far. Good work!

> ## Proposed Project
> 
> ### Abstract
> 
> While sending large repositories, git has to decide what needs to be
> sent, how to be sent. For large repositories, git creates pack files
> where it packs all the related commits, trees, blobs( in the form of
> deltas and bases ), tags etc. Now, finding the related objects among
> all the objects might be very expensive.
> 
> As git only knows about the branch tips, it is very expensive to find
> the related objects from all the objects if we try to traverse down
> from the branch tips to all their respective related objects. It becomes
> more expensive as the number of objects (i.e. commits, trees, blobs
> etc.) increases. Ultimately resulting in slow fetching from the git
> daemon.
> 
> To counter that, reachability bitmaps were introduced. It uses bitmap
> data structure (an array of bits) to detect if an object is reachable
> from a particular commit or not. The commit messages of this
> (patch series)[https://lore.kernel.org/git/1372116193-32762-1-git-send-email-tanoku@gmail.com/]
> are itself a documentation of how it is achieved. All the bitmap
> indexes for selected commits (in a EWAH compressed form) are stored in
> a `.bitmap` file which has the same name of its respective packfile.
>

s/indexes/indices/

> [ ... snip ... ]
 >> ## Estimated Timeline
>
 > [ ... snip ... ]

Taylor has shared feedback on the proposal and timeline which I hope are 
helpful to you. Specifically, Taylor said:

> 
> So I think it makes sense to try and find a way you can dip your toes
> into 2-3 of the sub-projects and get a sense for what feels most doable
> and interesting, then focus on that before allocating time for more
> projects in the future.
 >

I agree with this. It's better to be practical than ambituous when 
planning the proposal.

> 
> ## Availability
> 
> I intentionally freed my summer slot for GSoC. So, there wouldn’t
> be much disturbance/inactive days while working on my project.
> Generally, I can spend nearly 35-40 hours a week on this project.
> If the college gets closed for some reason, then the amount of
> available time will increase. Smart India Hackathon finale would
> be held in July. So, I may be inactive for a few days. But overall,
> I will be available most of the time.
>

Thanks for letting us know of possible things that would interfere with 
GSoC! Do make sure to keep us posted in case you come to know of 
anything else.

> ## Post GSoC
> 
> Once the GSoC finishes, I would look into other issues/tickets and
> would send PRs solving those issues. As I said before, I want to
> be a long term contributor to git - I would definitely maintain the
> flow and continue to work on improving the overall git tool.
>

That's nice.

--
Sivaraam
