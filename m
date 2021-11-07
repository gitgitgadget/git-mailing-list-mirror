Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29D1C433EF
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 17:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC15E6128B
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 17:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhKGRJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 12:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhKGRI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 12:08:59 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C25BC061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 09:06:16 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id h23so14665950ila.4
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 09:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/2fKVhQIUR6Kkojwv4iKAmTBHF28HF8N8DMBvdgfe8A=;
        b=ArwaQ9eLUwDEyGkYBKkr9FNWKW2QVR+LORZ0UySCnIalhwcLq/rz0b2/4M3I3YCtmU
         qlJtCB4O0QAcjBYzZQCIhO8sJbbRs6U7VHlvTeJYTwWHuW3uhYkBojKSMPMtEdSbqRXb
         2m0kpRbRNyCUF4owWjswbCNRChitAUkyZ1Yw0x4eRKa1gsC4Dewl5qyJbpIaa4fGfext
         PbmSIutJfxr/WhuswXAKFSkaPMJSCJVVGJwBFIioJ+yubpADiB6WrDQ9C8f/dxkNLYuq
         MgeIJVXq3nn6nUAObJzojJr8LeTaRO0e+u5Z8X/TljaeLUk2Z8CGjYk9XmrkpbkAnXA0
         DJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/2fKVhQIUR6Kkojwv4iKAmTBHF28HF8N8DMBvdgfe8A=;
        b=wbtvsGsOOovDOeVmm7eJjr2u8F9jP3FfPBpKRg7eUXbYGRq4DSxLzsjvvaZZ2pRR8m
         5PP03/4ngVGX/t7R/cBtku2AOZr/ffdRbqR7KLmAWbCvJPd13RX87m/z2GHg0hem5PfQ
         JTvOjDt+Dmcy8qD6nmV4P9MBnwFAnuPI3hskTXp5/u+B/o9fGxwJgllisPUDOQ9i41Kn
         ZFlN+2fqJPm0t062QswcR46asuuRLZpFXsLkt6wi5oBAU+YVspVp7nT0PshD1mwbwVNF
         Yfnadp9/VAJQPES8wXOHkoXnvyNoA+Oa/Pr7XLUwtjVKIsrDcdUAGJGRauVfSu34gMcD
         z5Bw==
X-Gm-Message-State: AOAM5325ow5PaGPUtiJZL6T4JDElCqBL15GOvi8ip0xHFI4VKUPHyz7q
        Mh84ycIwRSxP78a7028alUOayw==
X-Google-Smtp-Source: ABdhPJzn5thl/2gohITWeWb31khkk881WCTz7+S0N+o1DtoyWOjtjL8rJsBkOcudg7/a0gjWEOhmHQ==
X-Received: by 2002:a05:6e02:190f:: with SMTP id w15mr35027561ilu.56.1636304774900;
        Sun, 07 Nov 2021 09:06:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j16sm8028977iow.24.2021.11.07.09.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 09:06:14 -0800 (PST)
Date:   Sun, 7 Nov 2021 12:06:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: move some test-tools to 'unstable plumbing' built-ins (was:
 [PATCH] test_bitmap_hashes(): handle repository without bitmaps)
Message-ID: <YYgHhaOAsv7pVAMi@nand.local>
References: <YYTy6+DG5guzJIO7@coredump.intra.peff.net>
 <xmqq35oaxwnz.fsf@gitster.g>
 <YYWBz6rjF+I+JkO3@nand.local>
 <211106.86fss9hq3f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211106.86fss9hq3f.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 06, 2021 at 05:08:25AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > On the test-tool vs. plumbing thing: I think there are some compelling
> > reasons in either direction. There's no *good* home for these in our
> > current set of plumbing tools. E.g., the closest example we have is `git
> > rev-list --test-bitmap <rev>`, which is kind of ugly. When we needed
> > these new inspection tools for some of the newer bitmap-related tests,
> > adding them via the test-helper suite was a conscious choice to not
> > build on the ugliness of `--test-bitmap`.
> >
> > But on occasion these test-tool things are useful to have "in the
> > field", as you say. It's rare enough that I usually just clone a copy of
> > our fork as needed and build it when I do find myself reaching for
> > test-helpers.
>
> As part of the proposed integration for "scalar" I added a category to
> the command-list.txt called "optionalcontrib", which we'll list on its
> own in "man git" as (paraphrasing) super-duper-experimental.
>
> I really don't see why we shouldn't do so very lightly with some of
> these remotely-useful test-tool tools.
>
> It's pretty much the same amount of work to create a new built-in as a
> new test-tool, and as long as we make it clear in our documentation that
> these aren't in the same "plumbing" category I don't see why we
> shouldn't add those quite freely.

I'm not sure that I agree completely.

Just because it's easy to create a new builtin (or as easy as it is to
make a new test helper) does not alone make it a good reason to do so.
I think that your idea to make a distinction between these and normal
plumbing tools is a good one.

But...

> It seems to me that we've ended up with the current status quo of not
> adding "new plumbing" because we'll need to support it forever out of
> some self-imposed constraint that we couldn't add new categories to the
> "git" manual page.
>
> But if we just prominently list them as being unstable helpers aimed at
> git experts, and note the same thing prominently in their manual page
> (trivially done via an include) everyone should be on the same page
> about their stability, and we'll be able to use stuff like "test-tool
> pkt-line" "in the field".

...just because we say that these tools are unstable does not mean that
users will listen to us (or even read the relevant documentation saying
so).

In my experience I *rarely* rely on test-helpers when debugging wedged
repositories, and much more often end up either in gdb, or in an
anonymized copy of the repository on a different server. I would imagine
that others have similar experiences.

So unless we had a much more compelling reason to have the test helpers
more readily available, I do not think that the risk our users will
begin to depend on these unstable tools is worth taking.

Thanks,
Taylor
