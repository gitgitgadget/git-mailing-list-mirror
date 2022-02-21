Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1D8C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiBUSJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:09:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiBUSGb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:06:31 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E0220F5E
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 09:57:05 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id j5so7928052ila.2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 09:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4NNxPczqlUzrZex5NR+lRtPALuV4vw2WNUCsBArnZ+c=;
        b=bas32O/iRMsvRSVDI7Qf+t6Zm4MX3zNnRSvmNXwhMSTQgj7shwKzVlAd1g2pa3RkWU
         /3vwjZttsM5er0JzIk0o5ftALtDfV6VRr1qx8NY3LTQFcIuoV0RSJk7pjwryQOz84oZn
         cK0Nvgu/mkWxDJHfOYTZov+A/sAyMDN3lQBM6VojQZ2mrN6w6Z1kxv4yqqEGaK2SMyTQ
         frKM08PNAw5YFJy6NO1SgV7sv6KAdjYx13kew1c5oG6Swgt5VWh966LRYsIwZOjbfEYU
         6ErCFXUBntAsRdK8k4SB7HZiDn+OpaL+VgL1bNy29SkWGI9ix6Va7TEtVwcfb460fgF+
         s1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4NNxPczqlUzrZex5NR+lRtPALuV4vw2WNUCsBArnZ+c=;
        b=pQb5gH51DSmF6WziDfRBbnDYKuY2tWGweMYdq0irDRQkD3FTImVPvDKP3IAnylXPVv
         AkK/O7KI+d/CVkAzULFEcyRaHwd+qsWCWb203nqcmXrm6ZayZKMZSazwCwlhmhXCobO4
         W75UZ5u3xlr4sykXGLWm1hkRGnKklosJ6bm6GMsDaVfoc6+t05ZEsIvt6jWbQLzIC8aZ
         gmyl5fsFjcG6KH58T3ykjxgbgMkS3NwZkCRdWVI3t6CHXgE6Q5aUG5xWQ1Yo3NixEb/F
         mqJgVQz8sSmnr/ht6VvLghLH990rkkNuGFx4pigH04n5j4C/Ouzj6/MKl1Ts7YbM4ELe
         mOXQ==
X-Gm-Message-State: AOAM530NNXHzywuMGsd1mP1CjepRyj3ttxzHukazD9qiRQsW72X/5AXF
        2SwDdFaJB+UmlxSAJRu8RBHKF3+NRNf5Rjpu
X-Google-Smtp-Source: ABdhPJztxREsW9dwEM89ciIHQYjbQeiO8EYv0Tn0tAI0Ar30GKuPZPmAnMOvat12qNCUqBkNCNh++w==
X-Received: by 2002:a05:6e02:f14:b0:2c2:5d08:244c with SMTP id x20-20020a056e020f1400b002c25d08244cmr303346ilj.287.1645466224413;
        Mon, 21 Feb 2022 09:57:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k2sm10414717iow.7.2022.02.21.09.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 09:57:04 -0800 (PST)
Date:   Mon, 21 Feb 2022 12:57:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Robert Coup <robert.coup@koordinates.com>
Cc:     Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Message-ID: <YhPSb74x7davprsz@nand.local>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
 <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
 <YhMC+3FdSEZz22qX@nand.local>
 <CAFLLRp+JHi6B-RTeaWVPy2bZVHJ-y7EyMpymQy2LBynbZ8RzNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFLLRp+JHi6B-RTeaWVPy2bZVHJ-y7EyMpymQy2LBynbZ8RzNA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 03:38:03PM +0000, Robert Coup wrote:
> Hi,
>
> On Mon, 21 Feb 2022 at 03:11, Taylor Blau <me@ttaylorr.com> wrote:
> >
> > we would still be leaving repository
> > corruption on the table, just making it marginally more difficult to
> > achieve.
>
> While reviewing John's patch I initially wondered if a better approach
> might be something like `git repack -a -d --exclude-stdin`, passing a
> list of specific objects to exclude from the new pack (sourced from
> rev-list via a filter, etc). To me this seems like a less dangerous
> approach, but my concern was it doesn't use the existing filter
> capabilities of pack-objects, and we end up generating and passing
> around a huge list of oids. And of course any mistakes in the list
> generation aren't visible until it's too late.

Yeah; I think the most elegant approach would have pack-objects do as
much work as possible, and have repack be in charge of coordinating what
all the pack-objects invocation(s) have to do.

> I also wonder whether there's a race condition if the repository gets
> updated? If you're moving large objects out in advance, then filtering
> the remainder there's nothing to stop a new large object being pushed
> between those two steps and getting dropped.

Yeah, we will want to make sure that we're operating on a consistent
view of the repository. If this is all done in-process, it won't be a
problem since we'll capture an atomic snapshot of the reference states
once. If this is done across multiple processes, we'll need to make sure
we're passing around that snapshot where appropriate.

See the `--refs-snapshot`-related code in git-repack for when we write a
multi-pack bitmap for an example of the latter.

> My other idea, which is growing on me, is whether repack could
> generate two valid packs: one for the included objects via the filter
> (as John's change does now), and one containing the filtered-out
> objects. `git repack -a -d --split-filter=<filter>` Then a user could
> then move/extract the second packfile to object storage, but there'd
> be no way to *accidentally* corrupt the repository by using a bad
> option. With this approach the race condition above goes away too.
>
>     $ git repack -a -d -q --split-filter=blob:limit=1m
>     pack-37b7443e3123549a2ddee31f616ae272c51cae90
>     pack-10789d94fcd99ffe1403b63b167c181a9df493cd
>
> First pack identifier being the objects that match the filter (ie:
> commits/trees/blobs <1m), and the second pack identifier being the
> objects that are excluded by the filter (blobs >1m).

I like this idea quite a bit. We also have a lot of existing tools that
would make an implementation fairly lightweight, namely pack-objects'
`--stdin-packs` mode.

Using that would look something like first having `repack` generate the
filtered pack first, remembering its name [1]. After that, we would run
`pack-objects` again, this time with `--stdin-packs`, where the positive
packs are the ones we're going to delete, and the negative pack(s)
is/are the filtered one generated in the last step.

The second invocation would leave us with a single pack which represents
all of the objects in packs we are about to delete, skipping any objects
that are in the filtered pack we just generated. In other words, it
would leave the repository with two packs: one with all of the objects
that met the filter criteria, and one with all objects that don't meet
the filter criteria.

A client could then upload the "doesn't meet the filter criteria" pack
off elsewhere, and then delete it locally. (I'm assuming this last part
in particular is orchestrated by some other command, and we aren't
encouraging users to run "rm" inside of .git/objects/pack!)

> An astute --i-know-what-im-doing reader could spot that you could just
> delete the second packfile and achieve the same outcome as the current
> proposed patch, subject to being confident the race condition hadn't
> happened to you.

Yeah, and I think this goes to my joking remark in the last paragraph.
If we allow users to delete packs at will, all bets are off regardless
of how safely we generate those packs. But I think splitting the
repository into two packs and _then_ dealing with one of them separately
as opposed to deleting objects which don't meet the filter criteria
immediately is moving in a safer direction.

> Thanks,
> Rob :)

Thanks,
Taylor

[1]: Optionally "name_s_", if we passed the `--max-pack-size` option to
`git pack-objects`, which we can trigger via a `git repack` option of
the same name.
