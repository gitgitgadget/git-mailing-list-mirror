Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4E0C433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 00:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiKNAH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 19:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiKNAHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 19:07:25 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E3D2C3
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 16:07:24 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c15so5993137qtw.8
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 16:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oE5O4jbe9lKv6YSbksU4CCwPlJ0bBYR7X4mWOLcO4dg=;
        b=TlkQaybUL3B1wKrFUi657dlBYAHr2o4vDCvIMAkqgW4Ucv31+29LTj+/TSZJs28hQG
         AD8TJw0ctuzy4OD0m95zorDZi6WjiJHjelrF8qabZRm+EtCJ9QMsEP0oQeF3pvwqDbN0
         +dE/Qb7281KUUWDvu7ZGXX752vzAphGEbqInLRUKr/p/f/ahXSzhQDDC58stTAhoMnP2
         ZtTAfNxJS9R8vIZKkvn21ZXdXRYIbEhe63fe1hp0J7A0TA0cD0UlPaqKIGNpve0e3kAF
         6qWhquLkeQf1OTkWHAYWTqgxIgNYIp02AK1mvc5WZa2M85/8JoRsy7IHSioK7hO57iAT
         b5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oE5O4jbe9lKv6YSbksU4CCwPlJ0bBYR7X4mWOLcO4dg=;
        b=px8vNL9NWPJKMU6M9vuTlCA9/vs++Vi9suqWeAXHED0+hrJ4UtyDvFjAlQmnCJPTtS
         XE+x8jc7+mVcR/WEENy7YrXVH59s5gAJFmLeHjaOcsCXVLBVVFooXAqLAOeJpgkyJn9g
         b4CpYh+7q2sUNfEo49JoWoRWouipkWhKQI3+BEYezwZ6LVSG1lUqs5UlqyPjtHUKyYGP
         2d/oXl3WcB+V32G8qGeKTMIH0eCJL+GFnRQ100XLN6vloul06GrFfYQhoSN3hjG2J7aX
         hy+hZcura9hvAwBnr71aFnRgCemEdTQ5+kf1xo2qC/o7YdyAg7X1+HLR2Y/9Ylmfexlw
         LnJQ==
X-Gm-Message-State: ANoB5pkON+Qw5+Mbc3RT17JCTRztgUJt8diErhhB8bOgHmoTTMn47LHo
        Og7aIPyonxp9Ui5PsT8PLSQr
X-Google-Smtp-Source: AA0mqf5niQqsi4SwoGtqhkbZ0RE6UotmGgXqXy+eHbqItTqYQMM4PKnNiEtzvHmiFp+JNPHaJClw/w==
X-Received: by 2002:a05:622a:1dc6:b0:3a5:2704:d494 with SMTP id bn6-20020a05622a1dc600b003a52704d494mr10374711qtb.157.1668384443205;
        Sun, 13 Nov 2022 16:07:23 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e40a:199b:ce52:de2a? ([2600:1700:e72:80a0:e40a:199b:ce52:de2a])
        by smtp.gmail.com with ESMTPSA id d27-20020ac84e3b000000b00398313f286dsm4913171qtw.40.2022.11.13.16.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 16:07:22 -0800 (PST)
Message-ID: <0e156172-0670-2832-78cb-c7dfe2599192@github.com>
Date:   Sun, 13 Nov 2022 19:07:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file
 format
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CABPp-BEZK2KJHY+=Ta3VUzNjJKY=evPiAtp5UQFTVLMD0qreVQ@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BEZK2KJHY+=Ta3VUzNjJKY=evPiAtp5UQFTVLMD0qreVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/22 6:28 PM, Elijah Newren wrote:
> On Mon, Nov 7, 2022 at 11:01 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> Introduction
>> ============
>>
>> I became interested in our packed-ref format based on the asymmetry between
>> ref updates and ref deletions: if we delete a packed ref, then the
>> packed-refs file needs to be rewritten. Compared to writing a loose ref,
>> this is an O(N) cost instead of O(1).
>>
>> In this way, I set out with some goals:
>>
>>  * (Primary) Make packed ref deletions be nearly as fast as loose ref
>>    updates.
> 
> Performance is always nice.  :-)
> 
>>  * (Secondary) Allow using a packed ref format for all refs, dropping loose
>>    refs and creating a clear way to snapshot all refs at a given point in
>>    time.
> 
> Is this secondary goal the actual goal you have, or just the
> implementation by which you get the real underlying goal?

To me, the primary goal takes precedence. It turns out that the best
way to solve for that goal happens to also make it possible to store
all refs in a packed form, because we can update the packed form
much faster than our current setup. There are alternatives that I
considered (and prototyped) that were more specific to the deletions
case, but they were not actually as fast as the stacked method. Those
alternatives also would never help reach the secondary goal, but I
probably would have considered them anyway if they were faster, if
only for their simplicity.

> To me, it appears that such a capability would solve both (a) D/F
> conflict problems (i.e. the ability to simultaneously have a
> refs/heads/feature and refs/heads/feature/shiny ref), and (b) case
> sensitivity issues in refnames (i.e. inability of some users to work
> with both a refs/heads/feature and a refs/heads/FeAtUrE, due to
> constraints of their filesystem and the loose storage mechanism).  Are
> either of those the goal you are trying to achieve (I think both would
> be really nice, more so than the performance goal you have), or is
> there another?

For a Git host provider, these D/F conflict and case-sensitivity
situations probably would need to stay as restrictions on the
server side for quite some time because we don't want users on
older Git clients to be unable to fetch a repository just because
we updated our ref storage to allow for such possibilities.

The biggest benefit on the server side is actually for consistency
checks. Using a stacked packed-refs (especially with a tip file
that describes all of the layers) allows an atomic way to take a
snapshot of the refs and run a checksum operation on their values.
With loose refs, concurrent updates can modify the checksum during
its computation. This is a super niche reason for this, but it's
nice that the performance-only focus also ends up with a design
that satisfies this goal.

...

>> Further, there is a simpler model that satisfies my primary goal without the
>> complication required for the secondary goal. Suppose we create a stacked
>> packed-refs file but only have two layers: the first (base) layer is created
>> when git pack-refs collapses the full stack and adds the loose ref updates
>> to the packed-refs file; the second (top) layer contains only ref deletions
>> (allowing null OIDs to indicate a deleted ref). Then, ref deletions would
>> only need to rewrite that top layer, making ref deletions take O(deletions)
>> time instead of O(all refs) time. With a reasonable schedule to squash the
>> packed-refs stack, this would be a dramatic improvement. (A prototype
>> implementation showed that updating a layer of 1,000 deletions takes only
>> twice the time as writing a single loose ref.)
> 
> Makes sense.  If a ref is re-introduced after deletion, then do you
> remove it from the deletion layer and then write the single loose ref?

Loose refs always take precedence over the packed layer, so if the loose
ref exists we ignore its status in the packed layer. That allows us to not
update the packed layer unless it is a ref deletion or ref maintenance.

>> If we want to satisfy the secondary goal of passing all ref updates through
>> the packed storage, then more complicated layering would be necessary. The
>> point of bringing this up is that we have incremental goals along the way to
>> that final state that give us good stopping points to test the benefits of
>> each step.
> 
> I like the incremental plan.  Your primary goal perhaps benefits
> hosting providers the most, while the second appears to me to be an
> interesting usability improvement (some of my users might argue it's
> even a bugfix) that would affect users with far fewer refs as well.
> So, lots of benefits and we get some along the way to the final plan.

As I mentioned earlier in this reply, we have a ways to go before we
can realize the usability issue, but we can get started somewhere and
see how things progress.

>> In this part, the focus is on allowing the hashfile API to ignore updating
>> the hash during the buffered writes. We've been using this in microsoft/git
>> to optionally speed up index writes, which patch 2 introduces here. The file
>> format instead writes a null OID which would look like a corrupt file to an
>> older 'git fsck'. Before submitting a full version, I would update 'git
>> fsck' to ignore a null OID in all of our file formats that include a
>> trailing hash. Since the index is more short-lived than other formats (such
>> as pack-files) this trailing hash is less useful. The write time is also
>> critical as the performance tests demonstrate.
> 
> This feels like a diversion from your goals.  Should it really be up-front?
> 
> Reading through the patches, the first patch does appear to be
> necessary but isn't well motivated from the cover letter.  The second
> patch seems orthogonal to your series, though it is really nice to see
> index writes dropping almost to half the time.

This one I put up front only because it is a good candidate for
submitting soon, in parallel to any discussion about the rest of the
RFC.

The last part uses the chunk-format API for the packed-refs v2 format,
but the write speed is critical and hence we need this ability to skip
the hashing. Patch 1 mentions the application in the refs space as a
potential future, but the immediate benefit to index updates can help
lots of users right now.

Even if the community said "this packed-refs v2 is a bad idea" I would
still want to submit these two patches. That's the main reason they are
up front.

(Also: one thing I didn't mention in this cover letter or in the later
patches is that we could enable the hashing on the packed-refs v2 via
a config value, eventually. That would allow users who really care
about validating their file hashes an option to do so. While this
would make packed-refs v2 writes slower than v1 writes, the v1 format
does not have a checksum available, so that might be a valuable option
to those users.)

>> Part II: Create extensions.refFormat
>> ====================================
>>
>> [2] https://github.com/derrickstolee/git/pull/24 Packed-refs v2 Part II:
>> create extensions.refFormat (Patches 3-7)
>>
>> This part is a critical concept that has yet to be defined in the Git
>> codebase. We have no way to incrementally modify the ref format. Since refs
>> are so critical, we cannot add an optionally-understood layer on top (like
>> we did with the multi-pack-index and commit-graph files). The reftable draft
>> [6] proposes the same extension name (extensions.refFormat) but focuses
>> instead on only a single value. This means that the reftable must be defined
>> at git init or git clone time and cannot be upgraded from the files backend.
>>
>> In this RFC, I propose a different model that allows for more customization
>> and incremental updates. The extensions.refFormat config key is multi-valued
>> and defaults to the list of files and packed.
> 
> This last sentence doesn't parse that well for me.  Perhaps "...and
> defaults to a combination of 'files' and 'packed', meaning supporting
> both loose refs and packed refs "?

Sounds good to me. Thanks.

>> Part III: Allow a trailing table-of-contents in the chunk-format API
>> ====================================================================
>>
>> [3] https://github.com/derrickstolee/git/pull/25 Packed-refs v2 Part III:
>> trailing table of contents in chunk-format (Patches 8-17)
>>
>> In order to optimize the write speed of the packed-refs v2 file format, we
>> want to write immediately to the file as we stream existing refs from the
>> current refs. The current chunk-format API requires computing the chunk
>> lengths in advance, which can slow down the write and take more memory than
>> necessary. Using a trailing table of contents solves this problem, and was
>> recommended earlier [7]. We just didn't have enough evidence to justify the
>> work to update the existing chunk formats. Here, we update the API in
>> advance of using in the packed-refs v2 format.
>>
>> We could consider updating the commit-graph and multi-pack-index formats to
>> use trailing table of contents, but it requires a version bump. That might
>> be worth it in the case of the commit-graph where computing the size of the
>> changed-path Bloom filters chunk requires a lot of memory at the moment.
>> After this chunk-format API update is reviewed and merged, we can pursue
>> those directions more closely. We would want to investigate the formats more
>> carefully to see if we want to update the chunks themselves as well as some
>> header information.
> 
> I like how you point out additional benefits the series could provide,
> but leave them out.  Perhaps do the same with the optional index
> hashing in patch 2?

The index hashing is just _so easy_ that I couldn't bring myself to
leave it out. I didn't include the skip_hash option for these other
formats since the write times are not as critical for these files as
write time is for the index.

Updating these formats to a v2 that uses a trailing format (and
likely other small deviations based on what we've learned since they
were first created) would be an interesting direction to pursue with
care. Absolutely not something to do while blocking the refs work.

>> Part IV: Abstract some parts of the v1 file format
>> ==================================================
>>
>> [4] https://github.com/derrickstolee/git/pull/26 Packed-refs v2 Part IV:
>> abstract some parts of the v1 file format (Patches 18-21)
>>
>> These patches move the part of the refs/packed-backend.c file that deal with
>> the specifics of the packed-refs v1 file format into a new file:
>> refs/packed-format-v1.c. This also creates an abstraction layer that will
>> allow inserting the v2 format more easily.
>>
>> One thing that doesn't exist currently is a documentation file describing
>> the packed-refs file format. I would add that file in this part before
>> submitting it for full review. (I also haven't written the file format doc
>> for the packed-refs v2 format, either.)
> 
> Sounds like another win-win opportunity to get someone from the
> community to contribute.  :-)   ..Or maybe that's not the best
> strategy, since recent empirical evidence suggests that trick doesn't
> work.  Oh well, it was worth a shot.

Hey, if someone beats me to it, I won't complain. They should expect
me to CC them on reviews for the packed-refs v2 format ;)

Thanks,
-Stolee
