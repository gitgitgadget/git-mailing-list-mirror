Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF882082F
	for <e@80x24.org>; Sun, 16 Jul 2017 06:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdGPGCK (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 02:02:10 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34035 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdGPGCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 02:02:09 -0400
Received: by mail-vk0-f54.google.com with SMTP id r125so63630096vkf.1
        for <git@vger.kernel.org>; Sat, 15 Jul 2017 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f0upwsoCO6sECjuCtNlUqZiIxj9E0LGflpL4GOKy2Uo=;
        b=MPIB3h7h+aoyQ6LCS+bZQszZol2Kg5+VUXlzUmhiWKhxL/iKj6pOF0rBZU7/Cz27DU
         8GxUSnwzTzpeQQ1iX3nKO03F65o2A8sL3L0vVBCubjjIS/vpqTSey+xRWUg6TVkPTOhr
         ZHgMeJh7VdPavO30Mz/1P6yvqXPu6NcVTU8u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f0upwsoCO6sECjuCtNlUqZiIxj9E0LGflpL4GOKy2Uo=;
        b=dynIMqW1W8/AKHBie8yMq7IYX6Na43FDcSQgXVTCu+n7DYkLSMknRDlkhpsOfaELCz
         tfE3q8xpSOZFzMpu7wiExWKnqeR6Kq94N1xGAnywtoEINDoFo9X2EBOwTQHrWEVPDIdi
         HJqk9jgRJx64DQjhayFxNeNoBWWtMMGtxdawZUaHr0AHrNWc6RHhXnAzJbZNF7nIcjnE
         B3Os6oXFgKs/Eu+PiHYojk2RPZCjW1y2lqWakqg8mhIjX/SJ8PRXk5vFc2yHc89kXOoj
         dvvNePi4yYKSOHLA5msuVJQ/nFdriMT+7iv2rAER/K2LENi7MzIStGWqXYNd8o43eNub
         w2ZA==
X-Gm-Message-State: AIVw111d+H9oqLAo5GxjUv5NHus8MJD60Bw1RxGki8GQxZAKUax4P88Z
        srT+kLsVgXIvVSuxti7aWgUkPxjObaCZxqVTmg==
X-Received: by 10.31.0.69 with SMTP id 66mr9008309vka.31.1500184927899; Sat,
 15 Jul 2017 23:02:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Sat, 15 Jul 2017 23:01:47 -0700 (PDT)
In-Reply-To: <20170714200830.iks5drqu72cypkny@sigill.intra.peff.net>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <20170713193234.fkxf73t6jevj4svg@sigill.intra.peff.net> <CAJo=hJts=wY4vBaLsOtoH8+LBFK_drBhHMxPvKoQcqtpOfJOog@mail.gmail.com>
 <20170714200830.iks5drqu72cypkny@sigill.intra.peff.net>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Sat, 15 Jul 2017 23:01:47 -0700
Message-ID: <CAJo=hJtMo4OSxcYbq4oecTQYnwTR0zK8HgyqVEhOYZ-4eu4S9w@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 1:08 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 13, 2017 at 05:11:52PM -0700, Shawn Pearce wrote:
>
> I think the "stack" implementation is what makes me most uncomfortable
> with this proposal. Atomicity with filesystem operations and especially
> readdir() is one of the things I think is most flaky about the current
> system. Here's an idea for an alternative implementation.
>
>   1. Write out reftables to files named after the hash of their content
>      (e.g., $GIT_DIR/reftables/1234abcd...).
>
>   2. The first block of the each reftable has a backpointer to the
>      previous table.
>
>   3. There's a well-known name (e.g., $GIT_DIR/reftable) that represents
>      the current state. We update it with the usual .lock/rename dance.
>
> That gives readers an easy atomic view; once they've called open() on
> "reftable", they follow back-pointers instead of computing the names
> (n-1, n-2, etc). They may still find that a compaction has removed a
> file they need, but:
>
>   - they only have to restart due to an actual compaction. They'll never
>     be tricked by a regular update.
>
>   - you can compact without immediately deleting the old reftables. So
>     you might compact, and then delete the reftables N seconds later. Any
>     reader which completes the read within N seconds wouldn't have to
>     restart.
>
> I think I can anticipate your answer, though. If you have a system where
> the latency to open and read a file is high, then you've just serialized
> the latencies as you walk the chain. Whereas with predictable names, you
> can pre-fetch refname.i through refname.j in parallel.
>
> How deep would you anticipate stacks getting? Would it be feasible for
> the tip to contain the names of the tables in the entire chain? If we're
> talking about 20 (or even 32) bytes per name, you could still fit over a
> hundred names in a 4K inode.

I think we'd want to keep the stacks under 32, which is a reasonable
amount of space used in the header of each reftable. I don't have this
yet in my updated document + implementation, but I'll look at trying
to add it over the next couple of days. Your idea to hold the explicit
list of the stack in each reftable makes for a very safe atomic reader
view.


> It doesn't escape me that I'm basically reinventing RefTree here, with
> reftables instead of tree objects. But I think breaking away from using
> real Git objects opens up a lot of efficiency tricks (like the prefix
> compression, and the parallel-fetch thing above). And it removes a lot
> of the gc complexity.

Yes, I agree. Also RefTree has trouble scaling due to the flat tree
object format. It depends on the user to sensibly break up the
reference space with '/' characters sprinkled about. This reftable
proposal does not suffer from that limitation, a user can use any
valid ref name structuring.


> So I'm worried about live-locking with a regular updater, not even a
> compacting one.

Ok. I think your idea of tracking an explicit list of the stack in the
top of every reftable solves this in a very neat way, so I'll look to
switch to that.


>> block  restart  size  lookup
>> 4k     16       29M    90.2 usec
>> 8k     16       29M    76.4 usec
>
> Thanks for these numbers. I was really thinking that blocks would be on
> the order of 4K (where you can see that the restarts help very little).
> For local disk that's a pretty reasonable size. For high-latency fetches
> to a specialized database, maybe not.
...
>> > One thing I didn't see is reflogs. They don't strictly have to be part
>> > of a ref-storage solution. But they do still consume at least one inode
>> > per ref in the current system. If you reflog everything, which in my
>> > opinion you should. Having an audit trail of ref updates is very useful
>> > for debugging (both bugs in Git, and trying to figure out what went
>> > wrong when a user goes berserk with "git push --prune").
>>
>> Yea, I glossed over that and ignored them. Mostly because one system
>> where I want to use reftable already has a separate database handling
>> the reflogs. In another (Gerrit Code Review), we disable reflogs for
>> the insane refs/changes/ namespace, as nearly every reference is
>> created once, and never modified.
>
> Even for created-once refs, I've found an audit trail of created when,
> by whom, using what program to be quite valuable.

Dave Borowitz agrees with you, Gerrit Code Review should be recording
reflog data, even for create-once refs. Its a limitation of the
current $GIT_DIR/logs that has forced it to be disabled. I'd really
like something like reftable, so we can record reflog.


>> One could abuse the reftable format to store a reflog. If the refname
>> field is just a sequence of bytes, one could store keys like refname +
>> '\0' + timestamp, and reuse the symbolic ref value format to store the
>> old/new/message, as its just a length delimited string.
>
> Gross, but it could work. I actually think David's LMDB proposal did
> something similar (encoding the entries in the keyname), but I'd have to
> double-check.

I added log support to the reftable format. I updated [1] to reflect
log blocks at the end of the file. I ran a year's worth of log
records, 149,932 log entries on 43,061 refs to test:

format                size
$GIT_DIR/logs  173 M
reftable                  4 M  (avg 30 bytes)

[1]: https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md

reftable gets these kinds of savings by packing many logs into a
single file (so no disk block overheads), clustering log records by
ref name, prefix compressing, and deflating log records using 128k
input blocks. I'm OK with using deflate for log records (and bigger
block sizes), as log records are infrequently accessed compared to
current refs.

There is a log index to perform efficient point-in-time lookup for a
single ref, and then iterate over its log records from that time, and
older. That answers most reflog queries quickly. Large batch log reads
like gc reachability can simply iterate through all log records,
clustered by ref, ordered by time descending.
