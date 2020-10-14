Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80ECC433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44052221EB
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlXc1C32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbgJNRjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgJNRjN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 13:39:13 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB7EC061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:39:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 65so384294otu.9
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLSJfvEq5pxf/Injy5OWN2WT/V/o9rgt7n9inS87XH4=;
        b=IlXc1C32mfsoJTZcjfkrKa6IgR0mP+6+iuIzUaYzLd12pnI72cFsLKbwMD5J/q2SlW
         r6YVqD/8oDjuvFnVK7Myd4UVknkfPqw8haMqZauArgVr0+Qt7WB58rLLtPn3GjJWAaMr
         TSvkPlurrAM/yMWMMaVzbYb5uswp8avU0kBTP0/qE2GPUALVNu57CMmWva2ybnjAFFhB
         4LiUgE2fPA7qcFu2Uzn8jjFIYnTJoX9jHgyK2CP/KMCNA2SD/D35Rs9vqiKa/anuTiEz
         csPRsbIaMe8hCYR9ucqY6arEYK/zrbgSmw6SK4p89uAMO6QaxcEzvUobdYBSb3mWyhh8
         B5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLSJfvEq5pxf/Injy5OWN2WT/V/o9rgt7n9inS87XH4=;
        b=l0qRqmfrpnvBzZqOQwBZpa/yjYxm+C9RgowDH1JCgkG2Du9GVzbMIDomjarVIpNFCB
         sWxAJJX7FqcYZts1EBVW0YHkLusHwkPYrTfssGEQmVYi/G1Qj3u8GWogFxkoEsWN2xNP
         YiJbL/MPdR2KQU+/VU77pJI17HEjMkbYiiqc6FasO9dC4CmV0n1C/djPf7tRSncoVEgk
         nt3/87whENkkSY68JBUJvIZtWkGTzhIFfCg8XcwR3xEW3z8OiycY+uNg3zuWW0ZYAoLx
         ktTSLzfZ7fJJ5UWxi7GoiId1aYCZ0s9XgDepQYNDXgy5OK4icapt1O9Y8+D1g/KS59jA
         1yGA==
X-Gm-Message-State: AOAM532w4nlUA8/ZVvAEjo4lHhbT05bOA3wGfKsdFSyoMb4pZv1xUARN
        gX2Ua+wEaW4HQFbWpNaHpDuCs+N8U8AbtTwTf3E=
X-Google-Smtp-Source: ABdhPJyBfAHlYySR1UGMFZu8cThTwzvlQjxf7ZDIozmxHv9aMk9liBfw9HRM9QEwJaJpKDmovX1r0vEuAKG12UMEStY=
X-Received: by 2002:a05:6830:30ac:: with SMTP id g12mr204398ots.162.1602697152589;
 Wed, 14 Oct 2020 10:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com> <85a4ca164a9f665016d4aad0f29cbef6f62f36b0.1602616786.git.gitgitgadget@gmail.com>
 <20201014165329.GA21687@coredump.intra.peff.net>
In-Reply-To: <20201014165329.GA21687@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Oct 2020 10:39:01 -0700
Message-ID: <CABPp-BERKaLTLFjXYSo2mbT+3RSMR+5M7pzPmHH-0hNP2KFMOA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] test-lib: reduce verbosity of skipped tests
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 9:53 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 13, 2020 at 07:19:46PM +0000, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > When using the --run flag to run just two or three tests from a test
> > file which contains several dozen tests, having every skipped test print
> > out dozens of lines of output for the test code for that skipped test
> > adds up to hundreds or thousands of lines of irrelevant output that make
> > it very hard to fish out the relevant results you were looking for.
> > Simplify the output for skipped tests down to just showing the one-line
> > descriptions.
>
> This last sentence is inaccurate in this version, isn't it?

Maybe I could make it clearer, but I think that it is accurate[1].  If
this wording seems confusing, though, I could simplify the commit
message by reducing the sentence to "Simplify the output for skipped
tests."

[1] The original code showed the one-line description (with a
"skipping test:" prefix) AND the full test code AND then repeated the
one-line description on an "ok" line.  My v1 version of this patch
ripped out the long middle portion -- the full test code -- and thus
only showed the other bits, namely showing the one-line descriptions
twice (once with the "skipping test:" prefix, and the second time with
an "ok <number> # " prefix).  This v2 version of the patch shows the
one-line description only once with the "ok <number> #" prefix.  So,
I'd say the commit message is still accurate: the code only shows the
one-line description in both v1 and v2, though there is a question of
how many times it is shown.

> Other than that, I think this is a good change (I admit I never noticed
> the irrelevant output because it is only shown with "-v", and that is
> already full of irrelevant bits. But I have trouble imagining how it
> would be useful).
>
> Earlier discussion mentioned shortening the "ok 2 # skip" line, but I
> think removing this fd-3 version is the only sane direction. The other
> one gets parsed by TAP tools like prove, and may be shown. E.g., "prove
> --directive t0003-attributes.sh" shows the description of the skipped
> tests (likewise, "-v" shows all tests but highlights the skipped ones).

Make sense, thanks.
