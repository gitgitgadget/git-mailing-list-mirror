Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A3C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 08:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbiDNIDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 04:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiDNIDB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 04:03:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064743E5FC
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 01:00:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so8601317pjb.2
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 01:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S85jCb6sHrRdwSMlweoO8hGDoLAxNhiaJjlsXMnmI+A=;
        b=QD3BRKGP22ZoKkr1S7CwCwwrRWhLEO8xB5UZobvMN5CAwO1oeVlQNA0apwQgXqWXUH
         PVw4GuB5FdWdh5W9DA2ACRX6GQAunpxCwjRUoEyc5NxpbCypKdI0Wk4pp6J9hFdrFxnh
         dZDj34cdCk0xy+YeXDTTfDxgDYXZAfS6gORtci6Qc0If2hVvjkl/OCOJGK38ggVRW4MD
         6XdgnnVFOXOXG0IZgwwXdDbEd1SWL+niheIzFDgIVJGu/pnIPZtVIPp29R8CH8i7J9cI
         pm6+r5MILJkxP75z2zGPwCsu9glw1WqCAKi3QJ+POtXWYdel6D4JuNYD/+GhQVkgl+0A
         bspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S85jCb6sHrRdwSMlweoO8hGDoLAxNhiaJjlsXMnmI+A=;
        b=FL4Pt30TLto+FipPNyL2EcnrQppY+g/bPHQ9tZmtAMsjlbNb9nuWmlt1ZZ5JzbFITO
         ur2ph+8T/oM9sOXc2Tx0wnjXfw6/ubkkzaVQj1WiBn6sl2I6HYtrXx2qDFJIy1Oyoij0
         fjIZOEvVo26i7B2kY1C5Cuc3M+7nMixv5DjifimxVT19/Mlj0v4Aqs4bnQvndTxGhpgf
         wgkSzTQvP3zTwoQaCXLADsFG1545RzfGbzoNbaRCpuhNdJn5AJvMjWMJeNCrjdFTgbHz
         +tUz9/QMN/8SEcgVhV6lq+SoarBOy8Psdg8vPeRzEmUEKtZckMhMwqlN3PAhfXsU+KDr
         u/0A==
X-Gm-Message-State: AOAM530DAxFiCE7KD2whr0K/o6fWxS69QVgy3W9+tQrPziZcJcsB2XRq
        BRKB3L63PiffoGfgzINIAXg=
X-Google-Smtp-Source: ABdhPJyixhWrHFqM64Mt3s3csCUd2z7jfQeQWa5zc0aUpZKOMnFdgzgl73IS2AHAR9vuE3xzUOrLWA==
X-Received: by 2002:a17:90b:17c3:b0:1c6:b0ff:abf with SMTP id me3-20020a17090b17c300b001c6b0ff0abfmr2406583pjb.24.1649923236166;
        Thu, 14 Apr 2022 01:00:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:4060:209f:3abe:ccb:90ec:502c:d6b3])
        by smtp.gmail.com with ESMTPSA id y6-20020a626406000000b005060889f2cdsm1272144pfb.191.2022.04.14.01.00.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Apr 2022 01:00:35 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][RFC][PROPOSAL] Reachability bitmap improvements
Date:   Thu, 14 Apr 2022 13:28:46 +0530
Message-Id: <20220414075846.14059-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YlckmDHRAYnE1J5t@nand.local>
References: <YlckmDHRAYnE1J5t@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> Thanks so much for submitting this proposal! I have been excited to look
> through it, and am sorry for not getting to it sooner. Let me take a
> look now and give some of my thoughts.

Thanks so much Taylor for reviewing my proposal. It's my pleasure!

> Great! It sounds like working on Git would give you some new experience
> in a different domain than some of your past projects, and help you
> learn more about how it works and is developed.

Yeah, definitely! Looking forward to explore more in this domain :)

> Terrific! I am really glad that the MyFirst... documents were helpful
> and made it easier for you to contribute. The ProGit book is a great
> resource, too.

Thanks :)

> If you are looking for more resources, I would encourage you to search
> around for blog posts written by Git contributors, particularly related
> to reachability bitmaps (at least for this GSoC project). Some helpful
> places to start there would be:
>
>     https://github.blog/2015-09-22-counting-objects/
>     https://github.blog/2021-04-29-scaling-monorepo-maintenance/

I have read the "counting objects" article already. It is a very good
article to understand the reachability bitmaps in git. I would surely
go through the other article you shared.

> Note that commits and trees can be stored as deltas against other
> commits and trees (which themselves might be packed as deltas) and so
> on. But we only consider a pair of objects to be delta candidates for
> one another when they share a common type (e.g., we would never delta a
> tree object against a blob or vice-versa).

Oops. That is new to me. I didn't know that commits and trees can also
be delta-ed. Thanks for this info!!

> Exactly; though note that since that series we now have multi-pack
> bitmaps, too, which use a slightly different ordering called the
> "pseudo-pack" order, which (more or less) looks like all of the objects
> in a MIDX first sorted by which pack they came from, and then sorted by
> their order within the pack, removing duplicates in favor of the
> "preferred" pack.
>
> More thorough documentation on this can be found in the
> "multi-pack reverse indexes" section of
> "Documentation/technical/pack-format.txt".

Thanks. Will look into it :)

> But I want to be careful about the word "slow" here. They might be slow,
> or it might be really fast to decompress a given bitmap, depending on
> the disk performance, CPU pressure, how large the bitmaps are, and so
> on. So I think a good first step here is to validate our assumption that
> EWAH decompression is even slow to begin with.
>
> (Of course, the literature on newer formats will readily tell you that
> the old stuff is slower, but I think it's worth reevaluating those
> statements in the context of a practical application instead of in
> theory / benchmarks).

I think, it is "conceptually/theoritically" slow approach. Because as
you said -
> we can't begin to interpret the bitmaps until after decompressing them

It has to decompress the whole thing instead of evaluating the target
bitmap. Hardwares can make it fast but theoritically the time complexity
is slow.

I will validate whether it is practically slow or not though.

> Same comments here about whether or not this is slow to begin with. From
> my experimental patches in this area earlier, I found that we could get
> a significant speed-up in some cases, but that the speed-up was
> basically obliterated whenever we had to do any follow-on traversal if
> the bitmap coverage wasn't completely up-to-date.

True. But atleast it is faster(hopefully) when bitmap coverage is up-to-date.
We may optimize/improve it to make it fast overall.

> Arguably we could do this whether or not we solve the above, but doing
> some combination of the above may make it easier (e.g., if we wanted to
> change the bitmap selection to store dramatically more commits, then we
> may want to investigate how much of a bottleneck the sequential read
> requirement of .bitmap files would become for different numbers of
> selected commits).

True.

> For bitmaps, the number one thing we care about is correctness. I have
> never thought about using Bloom filters before; even though the
> one-sided nature of their errors means that we would never forget to
> send an object that we should have, having an absolute result is vastly
> preferred.
>
> After that, I think we mostly care about how quickly they can be
> decompressed. And after that, I think we care about things like "how
> fast can they be written", and "how large are they".

That's obvious. I had included those probabilistic approaches because
I thought we could have a check whether the obtained result is right
or wrong. In case of wrong answers (2% chance for Hyperloglog), we can
follow another approach that alters only the wrong results. But I
think, it will become complex. More research is needed to check whether
it can be done or not.

For other approaches ( i.e. Roaring+run and sroar), I think these two
fits the criteria you listed in your comment. Though, I need to work
more to fully understand the sroar methodology.

> This all sounds very good and ambitious. Keep in mind, though, that
> these projects have a tendency to take much more time than expected ;-).
> If we get one done, I'll be thrilled! (The goal with suggesting a few
> potential directions to go in is not to say: "let's do all of these
> things", but rather to give you some options in terms of what you find
> most interesting and exciting to work on).
>
> So I think it makes sense to try and find a way you can dip your toes
> into 2-3 of the sub-projects and get a sense for what feels most doable
> and interesting, then focus on that before allocating time for more
> projects in the future.
>
> > ## Estimated Timeline
>
> Like I said, I'm fine if you spend your entire GSoC project working on
> just one of these projects. So I don't want to get hung up on specific
> timelines just yet. If you end up working on this, I would suggest
> budgeting a week or so to try out a couple of different sub-projects,
> and then decide where to spend your time from there.

If that is the case, then I would go for the first sub-project i.e.
"Think of an better alternative of EWAH". It interests me a lot. Though
I will do what you suggested i.e. "try and find a way you can dip your
toes into 2-3 of the sub-projects and get a sense for what feels most
doable and interesting".

Should I remove "Estimated Timeline" ( or/and point 2, 3 from "The Plan"
section) for now then?

> Thanks very much for your interest and the time you spent putting this
> proposal together. I hope that some of my comments were helpful in
> refining it, and that you didn't mind my slow response too much.

The comments and suggestions are indeed helpful! I even didn't mind
anything.

Thanks :)
