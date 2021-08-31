Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CA6C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5F961059
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbhHaUAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHaUAV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:00:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DD6C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 12:59:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id y6so802281lje.2
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 12:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZSiwzMBbmIJarLe34gmF5l/isjgllM9GdEm5cyjKbY=;
        b=O7XfHxh5PgK6nhXWd/ICz/U+XnlHinqxbugqa+Q5v6+9p4HXVCa8rFuY7ssPHkNWXz
         wq1ldZabZHnqDOIaR5VIxRUBJFDuHcxCPTCNx8AEGejOIRu1QHaAhpJHnJqD+AXPmCd0
         6vh3UTDoZ7JMA7PhIPt/Xk7NMwVBIpxHEPo4Mr0gkBEHplG6TSMWzWIySQI2UloHbYjL
         I+OIBNCBZ4XXHknGC5bPZLiwh++HSeq8ilZav4DfwGccH64smdwJ+pGxQMT3ILpQf8Kn
         HRNP3pCzlDwRQcvJQS8578mLLopDMMkd9PwQm4UQXC7UoQeBwXDSJTY9e3yxn6KwKjHM
         EUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZSiwzMBbmIJarLe34gmF5l/isjgllM9GdEm5cyjKbY=;
        b=RQNtW6v9FfR1UmKNEXuM6YO4tCq6wJ8teKrVDF8cc/IikCORLWJl2iHtHZ0YefP/rj
         3nAKNdI3lLzI5vopf5dw87fZuA3oQB9rkplXuO4pd46m41mYi3tKAEfp3JOMx/9NAlKd
         6GdQVhP069iij2T7vbC9RAnKacsMk/ofCFRmYWfyAESojHaW/7CN/T1p1lB9ueh8RhUa
         lzT3lfuP8RrdaWkQedrmzaH8yPA1tA9ldpEcJDg/D8k2OWC5wHH5pt7BbTyKVKldArrm
         HERyjAAjImPuTEmVJHZGgcCDFg/DP4ArYBnLNqght0HGSxXNrPlO/VimD7IZdFJ26f/+
         tsog==
X-Gm-Message-State: AOAM530XF1Vcg3Cni45z8zRLVD8+dZdnh0V9un2SWoI3Qh0a34CnI879
        oO8bHcW4yQ1y/wyeaIvIWa7GbV0iyA/4OKJmLAE=
X-Google-Smtp-Source: ABdhPJwzc3ppsWli7uA9qNNkKVuq5T+W3rOd+YgWcPdhpqqPM3JhIn6jvLcjjyMc11fL7MSniMTzzUEHFDiP6zskTv4=
X-Received: by 2002:a2e:9b12:: with SMTP id u18mr26122969lji.350.1630439962466;
 Tue, 31 Aug 2021 12:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com>
 <87mtp5cwpn.fsf@evledraar.gmail.com> <CANQDOdd2FDNXnXLdm2FSmxUTk3oi+mQtiW2rf3YG7MJayrexPQ@mail.gmail.com>
 <20210826055024.GA17178@lst.de> <CANQDOdcr0gXsdXtqfN+FFRkAumNfYmr2C3qAcdzFxY26bDPWCQ@mail.gmail.com>
 <20210828065700.GA31211@lst.de>
In-Reply-To: <20210828065700.GA31211@lst.de>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 31 Aug 2021 12:59:14 -0700
Message-ID: <CANQDOdfV3omEBHOAq1b2P4Wb5=FCtrtsy22VvRu+FneFx9o9Gw@mail.gmail.com>
Subject: Re: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 11:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Aug 27, 2021 at 05:20:44PM -0700, Neeraj Singh wrote:
> > You're right. On re-read of the man page, sync_file_range is listed as
> > an "extremely dangerous"
> > system call.  The opportunity in the linux kernel is to offer an
> > alternative set of flags or separate
> > API that allows for an application like Git to separate a metadata
> > writeback request from the disk flush.
>
> How do you want to do that?  I metadata writeback without a cache flush
> is worse than useless, in fact it is generally actively harmful.
>
> To take XFS as an example:  fsync and fdatasync do the following thing:
>
>  1) writeback all dirty data for file to the data device
>  2) flush the write cache of the data device to ensure they are really
>     on disk before writing back the metadata referring to them
>  3) write out the log up until the log sequence that contained the last
>     modifications to the file
>  4) flush the cache for the log device.
>     If the data device and the log device are the same (they usually are
>     for common setups) and the log device support the FUA bit that writes
>     through the cache, the log writes use that bit and this step can
>     be skipped.
>
> So in general there are very few metadata writes, and it is absolutely
> essential to flush the cache before that, because otherwise your metadata
> could point to data that might not actually have made it to disk.
>
> The best way to optimize such a workload is by first batching all the
> data writeout for multiple fils in step one, then only doing one cache
> flush and one log force (as we call it) to cover all the files.  syncfs
> will do that, but without a good way to pick individual files.

Yes, I think we want to do step (1) of your sequence for all of the files, then
issue steps (2-4) for all files as a group.  Of course, if the log
fills up then we
can flush the intermediate steps.  The unfortunate thing is that
there's no Linux interface
to do step (1) and to also ensure that the relevant data is in the log
stream or is
otherwise available to be part of the durable metadata.

It seems to me that XFS would be compatible with this sequence if the
appropriate
kernel API exists.

>
> > Separately, I'm hoping I can push from the Windows filesystem side to
> > get a barrier primitive put into
> > the NVME standard so that we can offer more useful behavior to
> > applications rather than these painful
> > hardware flushes.
>
> I'm not sure what you mean with barriers, but if you mean the concept
> of implying a global ordering on I/Os as we did in Linux back in the
> bad old days the barrier bio flag, or badly reinvented by this paper:
>
>   https://www.usenix.org/conference/fast18/presentation/won
>
> they might help a little bit with single threaded operations, but will
> heavily degrade I/O performance for multithreaded workloads.  As an
> active member of (but not speaking for) the NVMe technical working group
> with a bit of knowledge of SSD internals I also doubt it will be very
> well received there.

I looked at that paper and definitely agree with you about the questionable
implementation strategy they picked. I don't (yet) have detailed knowledge of
SSD internals, but it's surprising to me that there is little value to
barrier semantics
within the drive as opposed to a full durability sync. At least for
Windows, we have
a database (the Registry) for which any single-threaded latency
improvement would
be welcome.
