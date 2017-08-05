Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53AC720899
	for <e@80x24.org>; Sat,  5 Aug 2017 21:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbdHEVBE (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 17:01:04 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36767 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbdHEVBD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 17:01:03 -0400
Received: by mail-ua0-f178.google.com with SMTP id k43so18754929uaf.3
        for <git@vger.kernel.org>; Sat, 05 Aug 2017 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3bhc+rcwHtu7JS47acpv+e3Av0JAIh/mdc7MPJkGoXs=;
        b=B+RyL1jd/zdciBCh5JrpmVHJ68exqYzZnfvuer6Wij4ycojTu0ebMFnjnvmeRTbGNn
         zhWSMcKyt9zPBu5VH4GqKU/jYUDK7SavOGfJvaUK2cHPpMUOIub8pSQ9NkpgePCrNDg+
         2AaH8r9/ZwDb1Mmvhr9Ab8XBwhTpUDXYsQ3cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3bhc+rcwHtu7JS47acpv+e3Av0JAIh/mdc7MPJkGoXs=;
        b=DfcfFLsuP4ia2cs1L+vT/uyM95cYx597f2Wbo4vAy7J5+r9k2CPmiLGdPvT41ODyyt
         /toBYU2apKbcgk/yMb3Umg8AcaIah0d3lG7saidWOoD//MTHx16gkyrXm99SslCCKPYk
         Q/e3WwdMo4+lDp26qLgr9N0158mHCxY9b0ndUUagbZdXPldFDlRf7eVCET3wnfRD5Ash
         SLxWQcV5SPscb09X0fl7fVc3ErDSins9XwDeDTssTlgrt+3y8ynHXFjfB8pdGybmijlc
         Hj1WVZQFFV/kQmmdpoNPIxWcGr2B7ycg8TS5BJheVJUHGjvQ/pfmQc9kkQ5hxAiMzGDC
         jaRw==
X-Gm-Message-State: AIVw113pE6GtqLDAUivozS3oD9JE7NWbhkVrKFGT5VYqwc9DxjlONN/h
        GkavERvWciUjA0fY5feOCC8ZblLSK/JY
X-Received: by 10.176.74.8 with SMTP id q8mr4651658uae.33.1501966862292; Sat,
 05 Aug 2017 14:01:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Sat, 5 Aug 2017 14:00:41 -0700 (PDT)
In-Reply-To: <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
 <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com> <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Sat, 5 Aug 2017 14:00:41 -0700
Message-ID: <CAJo=hJszDQ2N8cAjSqbJTTja03ke=i5H323U2Af+sZhviG9m-A@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 6:51 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On Tue, Aug 1, 2017 at 4:27 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> On Mon, Jul 31, 2017 at 11:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> On Sun, Jul 30, 2017 at 8:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>>> 4th iteration of the reftable storage format.
>>>> [...]
>>>
>>> Before we commit to Shawn's reftable proposal, I wanted to explore
>>> what a contrasting design that is not block based would look like.
>>
>> I forgot to look at a 1k chunk size, as you suggested that might also
>> be suitable. Here is the more complete experiment table:
>>
>>        | size   | seek_cold | seek_hot  |
>> mh  1k | 29.4 M | 20.6 usec | 10.7 usec |   <== Row fixed
>> mh  4k | 28.3 M | 24.5 usec | 14.5 usec |
>> sp  4k | 29.2 M | 63.0 usec |  5.8 usec |
>> sp 64k | 27.7 M | 35.6 usec | 23.3 usec |

I modified reftable to use a mutli-level index as recommended by
Michael Haggerty, and re-ran the above table:

fmt |  bs | idx  |  size  | seek_cold | seek_hot  |
----|-----|------|--------|-----------|-----------|
 mh |  1k | 4 lv | 29.4 M | 20.1 usec |  7.1 usec |
 sp |  1k | 4 lv | 30.7 M | 21.0 usec |  5.5 usec |

 mh |  4k | 2 lv | 28.3 M | 23.4 usec | 11.2 usec |
 sp |  4k | 2 lv | 29.2 M | 19.9 usec |  5.4 usec |

 sp |  4k | 1 lv | 29.2 M | 62.9 usec |  5.6 usec |
 sp | 64k | 1 lv | 27.7 M | 35.6 usec | 21.6 usec |

fmt:  mh = Michael's proposal, sp = Shawn's reftable
bs:  chunk size or block size in bytes
idx:  how many levels of index
size:  total file size in bytes

I can't explain the slightly slower sp-1k-4lv vs. mh-1k-4lv cold_seek
in the first two rows. It might simply be the larger footer read
slowing down JGit. Its reliably flipped in the next two (at 4k).

reftable is more efficient in seek_hot at finding and parsing a
reference. For multi-level indexes both sp and mh implementations used
a lazy caching strategy that caches index blocks along the path to the
ref, but doesn't cache the final ref block. The tests amortized this
by performing 60,000 lookups on the same ref.

>> At least in this case, the 1k block size seems like a good tradeoff.

With the multi-level index now in reftable, it seems like reftable at
4k, 2 level index is a better tradeoff. It aligns with the most common
filesystem block size, and has lower seek times, both cold and hot.
Its slightly larger than Michael's alternative proposal (+921 K), but
compresses better than reftable at 1k (-1.5 M).
