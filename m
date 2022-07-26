Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E554C43334
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 07:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiGZHRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 03:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbiGZHRP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 03:17:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FBCA47A
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 00:17:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z22so16656090edd.6
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 00:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7oQOMWNNb8/mUAvoBndHg8IVY5gZ0BOjHR+4bd1fjNA=;
        b=A2cZMQcCFLXDTFvm7alUhClp7uMc5FMvdo4cnJK8d8g+vmzvlDeZoaVg3uV4yE9xK9
         Gtquaqrmo89AOX9ri2JNEilDIR3leI52jtzBFMsJVYUwXZIECbIQT5HEwTpP07PJ2/nH
         Ltp4ilhYF6JMunSWMpgfHCHDx8gHWJdZhiMcVup/+ZZHmdi2P8/zI1s6Q9/0zo7G15uI
         b7PI8qPfFKlkeo/0OLz1MQM4PbJfbDfwrRrZAOEau2CeiOblnotrE0Hdi2DgYM+hWy5i
         D42Ymut/M1um7C04fvyyrdDsDpb5gisLVQqtHrAY/nlthky4pgZFVlj59H2/HQCbVwzL
         wuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7oQOMWNNb8/mUAvoBndHg8IVY5gZ0BOjHR+4bd1fjNA=;
        b=ZHzEC03ijmTd/9ySh82zfFRQQtPatPkj3bwwRKFwREYb2tqRm6KAPy08MZlK0vEyFB
         Lw8CWPeyBbdV3i7txiw4YPIw4dlJT1EJVAkipP8vYYel4vMmvvk7BKEUsABiGc6/5e5b
         HDU/6/rmifh+0ggPhgiVuz2Wnl7Vv7Kz9hrRkXVW8jE7vs0Q8bLn9glram9XW36UXFNQ
         RVxHhD/XEWuComz47GfSWYR5TxBwz2GIRteLsZ3z3GXn6HitBE5fMZP8k4XP8VsVAw33
         2p1h20MbdruVNRhUp7c15Q1fL+urQpPxEifunwjv8Dk6VxTks+rIvh5J7QbiPmEiNEV8
         P/Pg==
X-Gm-Message-State: AJIora8NFt1gDeMbgNfhE2FOn/q66iDc2MAFsgVJctVSoUdHF4FYnK0L
        pUvhY5iIvjwXWQDux3TmLOo=
X-Google-Smtp-Source: AGRyM1vYnT/YHmlgO6GJb1DHzNCXRv+QxE7T/+4Zz9S4R8P1cNCSK5Vcs7Iz0j7/41WO6jP1U6dxvA==
X-Received: by 2002:a05:6402:ea9:b0:43b:b88f:62fe with SMTP id h41-20020a0564020ea900b0043bb88f62femr16364288eda.85.1658819832401;
        Tue, 26 Jul 2022 00:17:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bx4-20020a170906a1c400b0072a430d2abdsm6059910ejb.91.2022.07.26.00.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 00:17:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGEoZ-005y1F-2U;
        Tue, 26 Jul 2022 09:17:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v5 5/6] p5310-pack-bitmaps.sh: enable
 `pack.writeReverseIndex`
Date:   Tue, 26 Jul 2022 09:15:15 +0200
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
 <e7ef420f321b3936185b2729460b1c28f5384438.1658342304.git.gitgitgadget@gmail.com>
 <Yt9A4Lh5MzHigeVe@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yt9A4Lh5MzHigeVe@nand.local>
Message-ID: <220726.86bktcny14.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, Taylor Blau wrote:

> On Wed, Jul 20, 2022 at 06:38:23PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
>> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>>
>> Enable `pack.writeReverseIndex` before running pack-bitmap related
>> performance tests.
>>
>> The performance difference with `pack.writeReverseIndex` enabled and
>> with disabled are given below -
>
> Thanks; this order of changes in the t/perf suite makes sense to me. One
> note, this sort of change where we're comparing all of the tests in a
> single t/perf file against themselves before and after some change, it
> is helpful to do (in t/perf)
>
>   ./run HEAD . p5310-pack-bitmaps.sh
>
> which compares HEAD to what's in the current tree. You'll get the
> results side-by-side, which makes them a little easier to scan. You can
> also aggregate results together from multiple runs with the
> t/perf/aggregate.perl script.
>
> One gotcha (that has often bitten me in the past) is that when running
> the perf suite with `.` as your build target, it uses whatever git
> binary is sitting in your tree. So make sure that it is both (a)
> up-to-date, ie., that it is the result of compiling what's currently in
> your tree, and (b) that it is compiled with the same settings as what
> you built HEAD with.
>
> I have often scratched my head at why the result of running some perf
> suite on '.' seems much slower than it should be, only to realize that
> the "git" binary sitting in my tree was built with -O0 or something.

Rather than comparing HEAD to your current tree it's generally better
to do something like:

	GIT_PERF_MAKE_OPTS='-j3' ./run HEAD~ HEAD [...]
