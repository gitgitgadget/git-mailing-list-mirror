Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF65D2047F
	for <e@80x24.org>; Tue,  1 Aug 2017 20:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbdHAUXk (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 16:23:40 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35436 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbdHAUXj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 16:23:39 -0400
Received: by mail-vk0-f42.google.com with SMTP id d124so10645488vkf.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/jLICzY7L4k63CM7y4n9H3jBxtE57HMvU/m2zHLyIxs=;
        b=Lw1z7DMPaUP4G8qg0FZtz6CkwPNIQyZxstmqAoitShQmNql7P02ZZenadQgK7u0WFp
         2H/DK1ddLgg3dhr0aI3Yc1cnXvMC+hKUtbpL7NClRUuTpdZ0uNw4FFud/GG22J/y2Avu
         gb8ks2dCo7accdIQinfLxpa+CTp9UPAxboyw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/jLICzY7L4k63CM7y4n9H3jBxtE57HMvU/m2zHLyIxs=;
        b=XD+qBmu2RZ+8krJyxS08RZnipgbgQzgmcC+3YltnVXkYPLJhssp23MwYs2qKBaTz7u
         kSlDy/FY49uSeCsZoD9kyGgwaakZibUVFz6aIcTeEzuLlLgGep8rqBt/rM1D8j3WZlXS
         lciXv7r+vYJHrq3Xhu7N/tX+5TFlMLlGjjG09fcasdunqNCp5cnIdViw45qbKsoCaR6N
         skCjYJBEo4pyCzRkLt/Fzm8WN7XPhPgP4s75YUq+ge49FzoTwwHohbT4DJE25+mtTP6x
         lh7PZCyWLo0YL3xtMce6b/MyoAv8LdY7Z9zQ2uFzEM37I3ulk5FJufxlQclgHmBwVtSb
         P+9A==
X-Gm-Message-State: AIVw1108/TgNK0/bN0MaXOY+cP+T4CkWovmnwPAPF9IzL9q1Ms1L7tUw
        jqgV/dmYWEI15JxFt6HxatF7XQz87HIljLgVkA==
X-Received: by 10.31.211.70 with SMTP id k67mr12866530vkg.129.1501619018586;
 Tue, 01 Aug 2017 13:23:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Tue, 1 Aug 2017 13:23:18 -0700 (PDT)
In-Reply-To: <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 1 Aug 2017 13:23:18 -0700
Message-ID: <CAJo=hJtrdCOF-RxzXfyLx7R-1f2-7pZVO_UOg28J=wUDNdf3yw@mail.gmail.com>
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

On Mon, Jul 31, 2017 at 11:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On Sun, Jul 30, 2017 at 8:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> 4th iteration of the reftable storage format.
>> [...]
>
> Before we commit to Shawn's reftable proposal, I wanted to explore
> what a contrasting design that is not block based would look like. So
> I threw together a sketch of such a design. It is not as refined as
> Shawn's, and I haven't had time to program an implementation or
> collect statistics, but maybe it is interesting anyway.

Thanks for taking the time to write this out. Its constructive to see
other possible approaches.

I roughly implemented your proposed design in JGit for references
only. I skipped the object lookup and log handling for the sake of
studying the basics of this approach.

       | size   | seek_cold | seek_hot  |
mh     | 28.3 M | 24.5 usec | 14.5 usec |
sp  4k | 29.2 M | 63.0 usec |  5.8 usec |
sp 64k | 27.7 M | 35.6 usec | 23.3 usec |

All tests were run with a 4K chunk/block size on an 866k ref example.
The mh approach does not use padding between chunks, so chunks are
variable sized, but not exceeding 4K. The differences between cold and
hot is whether or not the file was held open, and the root of the ref
index stays in memory.

In the mh approach with a 4K chunk size and 866k refs, the index is 2
levels deep. A cold seek needs to perform 3 disk reads to navigate the
index, hot seek is 2 disk reads.


> It seems to me that the block-orientation of Shawn's spec adds a lot
> of complication to the design (e.g., padding, optional blocks, varying
> block sizes for different parts of the file). It also seems that the
> format has been heavily optimized to be read in 64k blocks, whereas
> most users will be storing their references to local hard disks or
> (increasingly) to local SSDs. So I tried to come up with a design that
> is friendlier to the latter, hopefully without being much worse for
> the former.

Yes, my design is biased to run well on a 64k block size, where the
underlying disk is slow. Ideally reads require only one or two block
reads. Torn blocks (where a range of data lies on two different
blocks) are expensive, as both 64k blocks have to be loaded to acquire
data that lies across the boundary. Given how fast SSDs are, I don't
think this causes any problems for SSD users.


> One thing that I realized is that, assuming that reference values and
> reflogs are usually compacted separately, there will basically be
> three types of reftable files:
>
> 1. Accumulated references and their values (potentially very large)
>
> 2. Accumulated reflogs (potentially gigantic)
>
> 3. Recent transaction(s), which include both refs and reflogs (usually
>    quite small).
>
> The first two types of file don't benefit from separating reference
> data from reflog data in the file (because they only include one or
> the other). The third kind of file doesn't care because such files
> will be small.

In principal, I agree with your simplification. The important thing is
keeping the reflog away from the accumulated references, such that
scans of references (e.g. current ls-remote advertisement) is
efficient. I think I was also aiming to do this even for the
transaction log files, as ls-remote operations don't need the log
record data.


> So let's store all of the data related to a single reference in one
> spot. This simplifies the file format and removes the need for two
> separate indexes and/or variants that special-case the omission of an
> index. A disadvantage is that, it prevents compression of reflog
> entries across references. I think that is a reasonable tradeoff,
> because most reflog entries (in the repositories I checked; that might
> differ in Gerrit-managed repos) correspond to references that have
> been updated many times. To partly compensate for the resulting
> reduction in compression, I added some features to reduce the storage
> of redundant information in reflog entries.

I found the encoding of reflog entries below somewhat complicated, but
I haven't been able to implement it to compare storage size vs. the
deflated block I proposed.


> On the other hand, this design does not support binary searching for
> refnames. Instead, the refnames are distributed into a multiple-level
> tree. When looking for a reference, each tree node on the way to the
> reference needs to be parsed serially. But the nodes are small enough
> (due to the multilevel indexing scheme) that I hope that isn't a
> problem. I'd rather read less data at the expense of parsing a little
> bit more.

Looking at the numbers above, the binary search within a 4k block does
reduce lookup time. E.g. reftable has ~7 binary search restart points
within each 4k block, vs. your approach needing to parse up to 119
refs in a 4k chunk.


> * Multiple related chunks can be stored in a 64 kiB block (interesting
>   for people who prefer to read files in 64k segments). By storing
>   related chunks near each other, the number of seeks will probably
>   typically be smaller than the number of chunks that have to be
>   accessed.

This is difficult. The most related chunks are actually index chunks
in the multi-level index. You want the next step(s) near the current
step to avoid an actual disk seek. But that is hard to do when the
index is several levels deep.


> * The file can be written in two possible ways: with cross-references
>   between chunks always pointing to later parts of the file (probably
>   preferable if the data will be read from a local hard disk) or
>   always pointing to earlier parts of the file (to accomodate writers
>   who need to write their data in order). See the `offsets_negative`
>   field in the header. (I'm not sure that the former variant is
>   actually needed.)

This seems like unnecessary complexity. I'd prefer to just say the
offsets are negative, and reference backwards.
