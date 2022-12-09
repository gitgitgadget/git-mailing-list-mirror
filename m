Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3293EC10F1E
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 15:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiLIPMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 10:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiLIPMA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 10:12:00 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900014219D
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 07:11:58 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id r72so2161901iod.5
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 07:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FyT6CTA8tFcHxbRZsl/IcoOMoqDZ8Hz0UJWfZje/vE=;
        b=CeACI0NdKd9D2QfbYgANGhHuCZNv+STHleRVsGF8xOuoDMAbl+am/YQc+0OG5bC46y
         GVKZvyHZGr8Fr+xyhQRf+Z23bztBakuwae8x99XpC90aaitVWBKgYYCcpPI1OaA+CmXI
         ioBs1+Es/F9LstifoIn8JmTd6DFEGrPZqQEEzjEBSnd8OC37kZdNUjf1DxrHOMM2/u/q
         /FQcfwmYf2CKPBo9HirQUzDWsi+8rSS5/1dhBrlxz1uXtw7ltd0yIXw8gFh+NpRRwzIw
         sjGcHn/79ACQLDfMr78EhUhB8jj08Vavbub5RUsHSoIHtjFH+GRYvysXtGsJylJSbF8R
         pWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FyT6CTA8tFcHxbRZsl/IcoOMoqDZ8Hz0UJWfZje/vE=;
        b=oU1AMt/vSSiw6i9T42ACwtjmVY7PCTDMkQ/OanVa4tUqiPX0ICLDZcH5IRuMHowt6W
         4RGcAyeIVKU+rGvsSJ+vL3aXMeUyxtB5eR2dHbgpsTAFB15EKfdKptiw9xkyjlGPCxY0
         jgdB1Dc8H8q2UKt4Us3iklxxTU13Yd9X3j1RFThYNxodMI/EHQ5Bzhnj9ksBkuWdJxG2
         JYJ21OWWuyIAOsKWCe+ii/q8aqLb9IJK72CIj+lfF+CRCjiiGB3EQrLtLIksKpsk4XGr
         o7zvoF9NzjpqlfRRIirzGs+3ff3dkk31q0YjkffHqFRbq1+PWfsMkghyAFicyY2QakeX
         dc1w==
X-Gm-Message-State: ANoB5pm/GyGRoQjJ3Vf9gnzGjJcPhkh4j7/O5T16JeLgu9KOsPSkkKp9
        emXMBE1mxtqEbvFofZLmTtOc6Z2Kt7PHGMw=
X-Google-Smtp-Source: AA0mqf6eK9bwrlnzvK7tVEdV2Fi9R6E7EfsFVJrmHaou8Yet9jkB6ivDIWME54DKxIMQva/M9Smkwg==
X-Received: by 2002:a6b:d916:0:b0:6c2:b477:441 with SMTP id r22-20020a6bd916000000b006c2b4770441mr3567460ioc.9.1670598717780;
        Fri, 09 Dec 2022 07:11:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a808:7643:3b7c:4df9? ([2600:1700:e72:80a0:a808:7643:3b7c:4df9])
        by smtp.gmail.com with ESMTPSA id p11-20020a5d8b8b000000b006dffde23fa9sm737420iol.24.2022.12.09.07.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 07:11:57 -0800 (PST)
Message-ID: <1e8386ed-6acb-0deb-2e46-2e9dbd6e4ad5@github.com>
Date:   Fri, 9 Dec 2022 10:11:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Auto packing the repository - foreground or background in
 Windows?
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
References: <CAPMMpoiN=Rj_z9VEJZ4EFhb8gBeqb6H7JhTUBbn-b-t-jHRVnA@mail.gmail.com>
 <4dcad1f5-9ebd-d15a-b663-a3513ae1bcb8@github.com>
 <CAPMMpoii52KrR2MBpPdSEH8-jc7uMPzi4DH5g2bchwd-RPNTJw@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPMMpoii52KrR2MBpPdSEH8-jc7uMPzi4DH5g2bchwd-RPNTJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/8/2022 9:52 AM, Tao Klerks wrote:
> On Tue, Dec 6, 2022 at 7:03 PM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> Instead, the modern recommendation for repositories where "git gc --auto"
>> would be slow is to run "git maintenance start" which will schedule
>> background maintenance jobs with the Windows scheduler. Those processes
>> are built to do updates that are non-invasive to concurrent foreground
>> processes. It also sets config to avoid "git gc --auto" commands at the
>> end of foreground Git processes.
>>
>> See [1] for more details.
>>
>> [1] https://git-scm.com/docs/git-maintenance
>>
> 
> Thanks Stolee, I've known about the existence of this system for a
> while, but I can't quite figure out what's recommended for who, when,
> given the doc at https://git-scm.com/docs/git-maintenance

Thanks for the feedback that this document could use a clearer
high-level description for recommended ways to use the command, and
_when_.

One goal when creating the documentation was to _not_ recommend a
specific use pattern, instead focusing on the many ways a user could
customize their maintenance patterns. Perhaps the feature has
stabilized enough (and shown its benefits) that we could add a
recommended use section.
 
> Clearly on Windows, one reason to do "git maintenance start" is to
> avoid foregrounded "git gc --auto" runs later. That's a clear enough
> benefit to say "frequent users of large repos on windows *should* run
> 'git maintenance start' (or have some setup process or GUI do it for
> them) on those large repos".
> 
> Is there a corresponding tangible benefit on MacOS and/or Linux, over
> simply getting "git gc --auto" do its backgrounded thing when it feels
> like it? Or is there an eventual plan to *switch* from the current
> "git gc --auto" spawning to a "git maintenance start" execution when
> trigger conditions are met? Are there any *dis*advantages to running
> "git maintenance start" in general or on any given platform?

For large repositories, the default 'git gc --auto' takes a lot of
resources to rewrite all object data into a single pack-file. The
background maintenance does smaller, incremental repacks. Here,
"large" means "more than 2GB of packed object data", since that's
the default limit for the incremental repacks starting a new pack.

There's other benefits where it does hourly prefetches, getting
object data from remotes before the user requests a ref update
through 'git fetch' or 'git pull'. Those foreground operations
speed up, as well.

> For "my users", I have something like Scalar that can start the
> maintenance on the repo where it's needed - but it seems like there
> will be lots of users out there in the world who clone things like the
> linux repo, which looks like it is big enough to warrant these kinds
> of concerns, but it doesn't seem obvious that anyone will ever find
> "https://git-scm.com/docs/git-maintenance" and decide to run "git
> maintenance start" on their own...

We do what we can to advertise these kinds of features, but at some
point users need to self-discover things. But that's also a motivation
for the Scalar command: the user can relax some control to allow the
Scalar command to choose those recommended settings on behalf of the
user.

> As I noted in another email, I propose to replace "Auto packing the
> repository for optimum performance" with something like "Auto packing
> the repository for optimum performance; to run this kind of
> maintenance in the background, see 'git maintenance' at
> https://git-scm.com/docs/git-maintenance." - but I imagine I'm missing
> a bigger picture / a long-term plan for how these two mechanisms
> should interact.

A message that points out 'git maintenance' like this might work best
as part of the "advice" API, so those who don't want to see the
message every time could disable it.

> My apologies if I've missed one or many conversations about this on
> the list, but maybe a pointer here can also help me add directional
> hints at https://git-scm.com/docs/git-maintenance for "outside users"?

I'm trying to think of a builtin whose documentation has such strong
"recommended use" language.

The best I could think about are commands with substantial "examples"
sections, such as 'git bundle'.

A more radical approach would be to create a new doc type that
provides recommendations for how to manage large repositories. I
imagine it would be sorted in order of increasing complexity,
something like:

 1. Use 'scalar' and see if it works for your needs.

 2. Self-serve with 'git maintenance start', 'git sparse-checkout',
    partial clone, and feature.manyFiles=true as needed.

 3. Go deep on individual plumbing commands and config options
    that provide knobs to tweak how Git manages information.

I think starting with some examples or a "recommended use" section
for 'git maintenance' would be a better first step.

Thanks,
-Stolee
