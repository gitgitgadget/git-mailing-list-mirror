Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726A8C43219
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 21:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKAVYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 17:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiKAVYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 17:24:11 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14411054D
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 14:24:08 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h206so10010271iof.10
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C56N4SWXn/C8z+AxbrsmjbijCNOIfV1Yc3ohOI/6QUo=;
        b=zxn3QpxQDjOZNzYCpYOMlJkxHmvlkVi3jIUfZgAg9uNMvOZD/fvwXjsDfFZAOOZ6BO
         PLSK50jx9gzPV683Qnu2V3QsRWHqeWcWIe6XMvBD39On8QqOxQRdWWNVMEihS676pfwL
         iy1H17lncd4h/q5yZfZLdEHRHiATRMTw/1Pcpn2OmI3rQnoTZFMWiidEU6Z3Iulfo908
         cA0SRyIpPJMOe446Kn9E4iUNFdCXSWrxwRqdrlNYS/2ULgVaT56zEWBaQgO9e9m+VkJn
         FgOrp0RSAPjXze5elSQKEESMmLS4gUmZWPU2Xwurzp+xsaCwdPeC3T0KlR3EXCKon/Eg
         9snQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C56N4SWXn/C8z+AxbrsmjbijCNOIfV1Yc3ohOI/6QUo=;
        b=LHMKAS7tNX+uG18xSchKaCjUFOIWc+GejYuhc4ykgyTYjbCBX/TaIFcE9jAVI2ESxF
         IKOylQjJHPkWkGaiJx4JMEyFtM0XrNTOoof1ya1eMuCuOqoe4V8OhvMuDwt8T/y8qFPX
         WEXW5/80SHX08nftP2N30oP08z6A96ST3ZZJVSoKSBN3yEVQb1GVqxv+QMY79Yjh4tTT
         0o+UpFDCHB62eOCwsiSsk9F4Wo9cwCq+54oGaqRh3ux0NX6gDvMebWAm/baBlwUlqgiv
         0Unjv6X3xHNxqmIsfY9aHWLLbVl8/J7/FJcvkjXTOvqxfnUJ1VzBHktfRajLDA1BZZ7t
         jfMQ==
X-Gm-Message-State: ACrzQf2EY+j3aMlF+orHLf1Sy19ksuPQLHTaUX1cWlFaucwjqFr2hi3S
        DnRCegJJfX2uRHc6v9gfIt8W+Q==
X-Google-Smtp-Source: AMsMyM7zV9QFfw+ZOLwsWqU+1kr/ir+gaMw3VcsVUQxnG1EJhdd8GOp8ZaUkSeIm0csQUxM81YeO3w==
X-Received: by 2002:a05:6602:346:b0:6bb:f236:ae68 with SMTP id w6-20020a056602034600b006bbf236ae68mr12669057iou.161.1667337848244;
        Tue, 01 Nov 2022 14:24:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c17-20020a92d3d1000000b0030014a5556bsm3933753ilh.69.2022.11.01.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:24:07 -0700 (PDT)
Date:   Tue, 1 Nov 2022 17:24:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Documentation/howto/maintain-git.txt: a pair of
 bugfixes
Message-ID: <Y2GOdwOcb/GtR0LD@nand.local>
References: <cover.1667260044.git.me@ttaylorr.com>
 <Y2DSSM8ujceSgp+b@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2DSSM8ujceSgp+b@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 04:01:12AM -0400, Jeff King wrote:
> On Mon, Oct 31, 2022 at 07:47:33PM -0400, Taylor Blau wrote:
>
> > The documentation on how to use the scripts in 'todo' has a couple of
> > small typos that make it confusing when generating the Meta/redo-jch.sh
> > and Meta/redo-seen.sh scripts the first time.
> >
> > Correct these to avoid any confusion in the future.
>
> Thanks for writing these up. A little back-story: Taylor and I had
> looked at this together off-list, because the results of following the
> documentation to the letter made little sense.
>
> So both look good to me, with the giant grain of salt that I was party
> to the original head-scratching that led to the patches. Given that
> there's no urgency (unless you are hit by a bus in the next few weeks),
> it probably makes sense to queue these fixes and wait for Junio to
> review and (hopefully) merge them.

All true :-).

And indeed, if I'm hit by a bus in the next couple of weeks, I think
that whoever steps up will be clever enough to find this thread on the
list and work it out from there.

Let's hope that we don't have to go there. I'm mainly interested in
Junio's review, anyway, so I'll happily let this one sit until we hear
from him.

> There is one thing we wondered about, and I think only Junio can answer.
> The instructions after these patches yield two files, redo-jch.sh and
> redo-seen.sh. The first one has two sections separated by a "###"
> marker: the ones that are in 'next', and the ones that are in 'jch'.
> The third ones has topics that are only in 'seen' (which also contains
> all of the others).
>
> Why not have a single file with all of the topics, with two "###"
> markers? I.e., something like:

Thanks for writing our confusion up. I, too, think that this would be an
easier process to follow than juggling the topics between two files. I
could imagine that there was some circumstance that bit Junio in the
past (for which it really *is* easier to manage the set of topics broken
out across two files).

I could equally imagine the answer being, "it's always been this way",
and so the process is baked into his muscle memory. Whatever the reason
is, I'm definitely curious in the rationale behind it.

>   # build the topic list from what's in 'seen' now
>   Meta/Reintegrate master..seen >Meta/redo.sh
>
>   # rebuild the first part of jch, which is everything in next
>   git checkout -B master jch
>   Meta/redo.sh -c1
>
>   # now build actual next, which should end up with the same tree
>   git checkout next
>   git merge master ;# if necessary
>   Meta/redo.sh -c1 -e ;# -e to annotate any topics
>   git diff jch next ;# should be identical
>
>   # now build the rest of jch
>   git checkout jch
>   Meta/redo.sh -c2
>
>   # now build seen
>   git checkout -B seen master
>   Meta/redo.sh ;# no -c, do it all
>
> I _think_ the two are equivalent, and it seems more convenient to keep
> all of the topic names in one file (since they'd migrate across the cut
> to go from seen to jch, then jch to next). But maybe you (Junio) find it
> more convenient to keep them separate. The 'seen' list is a bit more
> fluid, and I'm sure you figured out how to copy lines between two
> different buffers in emacs. :)

Based on my own understanding of the scripts in 'todo', I agree that
they should be equivalent.

Thanks,
Taylor
