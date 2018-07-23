Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7791F597
	for <e@80x24.org>; Mon, 23 Jul 2018 15:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbeGWQuL (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 12:50:11 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34112 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387968AbeGWQuL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 12:50:11 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so704770qkj.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 08:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uZRPR6WDdOD9UqTMI+Z0cH/ssDPUAVBi/PqSFoWUwIQ=;
        b=ucQqKmlkzJXEze9Vp8NMxNPKeBOuswmCsISwLLobTLuynzOZNeZifJxkaZb0IHZDbJ
         yWecbxl3kxORp5gmpy3bXeJejPjDhw/pAPtuAQLEsJH2URdItFqk0IAQkcxeO7vFySUI
         +o6fxhrbCw5mcfFAU4dp/Dz5+rLFArtGo/nrAkBB3yZVgqzKtaW6fxvbF9mH/ukrCDGV
         xEJ9GWCNaaO7LbiSiTDFqW1UeMrdeXjC4ttU/6KJEmPo351v+fCV8gu2bCzsFIgdnsms
         fGaPBT9pj2TCYHAGXplZYranKBTTdiJGdiriP5TcTYz1MvXdg/Uo1h6/UlP8ewJjWaiP
         hvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uZRPR6WDdOD9UqTMI+Z0cH/ssDPUAVBi/PqSFoWUwIQ=;
        b=tjRw7N4xQpblu9YM3ddzf+8PzxPzkc0TlcTV4n25zZv6bDYcGdiqJomDJyXBzqZ3ny
         +zuncpjnV7AA0mrpNxgvY5zxo1HMAuCLMQR9xDcawuc/Iub6A66cPkiSPJhApl6gN2uo
         Z33pMxB79rd6Ii5Y+JkU9SISjmPd9CwzPZPyhYK1RYL3MIUl3RZ9x8t36mujXfE1SqeZ
         7wOZ1lQZGyiPC0Nf1/bYB09bqQmStt1rpMhue0QgOhYpSNMZ3iI+kKW+E/sASL4ReavK
         xxbgGb21BbUKBUH95EiXDO1NSFUC1YiyznHvwYTADj1wZLpm+Ak8e/ajQo7lisHhoHiB
         p8Jg==
X-Gm-Message-State: AOUpUlG3IqNi/6Cvs4PasU5tsqv9tmGf2icfAJs8yDFZdxQJ9es3Hozq
        ZKWEqOWFMS7Mp1TAnGycXCA=
X-Google-Smtp-Source: AAOMgpdBKlNxCfWOux7PhNg0xMz4qxAJnj1pXngh/MeRwIdEaGzpFhLKO9udcU4p2PCKgqJCZouJ/g==
X-Received: by 2002:a37:109d:: with SMTP id 29-v6mr11260050qkq.315.1532360899816;
        Mon, 23 Jul 2018 08:48:19 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id c93-v6sm11607226qkh.90.2018.07.23.08.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 08:48:19 -0700 (PDT)
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
To:     Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
Date:   Mon, 23 Jul 2018 11:48:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718213420.GA17291@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/18/2018 5:34 PM, Jeff King wrote:
> On Wed, Jul 18, 2018 at 08:45:14PM +0000, Ben Peart wrote:
> 
>> When working directories get big, checkout times start to suffer.  Even with
>> GVFS virtualization (which limits git to only having to update those files
>> that have been changed locally) we�re seeing P50 times for checkout of 31
>> seconds and the P80 time is 43 seconds.
> 
> Funny aside: all of your apostrophes look like the unicode question
> mark. Looking at raw bytes of your mail, they're actually u+fffd
> (unicode "replacement character"). Your headers correctly claim to be
> utf8. So presumably they got munged by whatever converted to unicode and
> didn't have the original character in its translation table. I wonder if
> this was send-email (so really perl's encode module), or if your smtp
> server tried to do an on-the-fly conversion (I know many servers will
> switch the content-transfer-encoding, but I haven't seen a charset
> conversion before).
> 

This was my bad.  I wrote the email in Word so I could get spell 
checking and it has this 'feature' where it converts all straight quotes 
to "smart quotes."  I just forgot to search/replace them back to 
straight quotes before sending the mail.

> Anyway, on to the actual discussion:
> 
>> Here is a checkout command with tracing turned on to demonstrate where the
>> time is spent.  Note, this is somewhat of a �best case� as I�m simply
>> checking out the current commit:
>>
>> benpeart@gvfs-perf MINGW64 /f/os/src (official/rs_es_debug_dev)
>> $ /usr/src/git/git.exe checkout
>> 12:31:50.419016 read-cache.c:2006       performance: 1.180966800 s: read cache .git/index
>> 12:31:51.184636 name-hash.c:605         performance: 0.664575200 s: initialize name hash
>> 12:31:51.200280 preload-index.c:111     performance: 0.019811600 s: preload index
>> 12:31:51.294012 read-cache.c:1543       performance: 0.094515600 s: refresh index
>> 12:32:29.731344 unpack-trees.c:1358     performance: 33.889840200 s: traverse_trees
>> 12:32:37.512555 read-cache.c:2541       performance: 1.564438300 s: write index, changed mask = 28
>> 12:32:44.918730 unpack-trees.c:1358     performance: 7.243155600 s: traverse_trees
>> 12:32:44.965611 diff-lib.c:527          performance: 7.374729200 s: diff-index
>> Waiting for GVFS to parse index and update placeholder files...Succeeded
>> 12:32:46.824986 trace.c:420             performance: 57.715656000 s: git command: 'C:\git-sdk-64\usr\src\git\git.exe' checkout
> 
> What's the current state of the index before this checkout? 

This was after running "git checkout" multiple times so there was really 
nothing for git to do.

> I don't
> recall offhand how aggressively we prune the tree walk based on the diff
> between the index and the tree we're loading. If we're starting from > scratch, then obviously we do have to walk the whole thing. But in most
> cases we should be able to avoid walking into sub-trees where the index
> has a matching cache_tree record.
> 
> If we're not doing that, it seems like that's going to be the big
> obvious win, because it reduces the number of trees we have to consider
> in the first place.
> 

I agree this could be a big win.  Especially in large trees, the 
percentage of the tree that changes between two commits is often quite 
small.  Saving 100% of that is a much bigger win than actually doing all 
that work even in parallel. Today, we aren't aggressive at all and do no 
pruning.

This brings up a concern I have with this approach altogether. In an 
earlier patch series, I tried to optimize the "git checkout -b" code 
path to not update every file in the working directory but only to 
create the new branch and switch to it.  The feedback to that patch was 
that people rely on the current behavior of rewriting every file so the 
patch was rejected.  This earlier attempt/failure to optimize checkout 
makes me worried that _any_ effort to prune the tree will be rejected 
for the same reason.

I'd be interested in how we can prune the tree and only do the work 
required without breaking the implied behavior of the current 
implementation. Would it be acceptable to have two code paths 1) the old 
one for back compat that updates every file whether there are changes or 
not and 2) a new/optimized one that only does the minimum work required? 
  Then we could put which code path executes by default behind by a new 
config setting that allows people to opt-in to the new/faster behavior.

Any other ideas or suggestions that don't require coming up with new git 
commands (ie "git fast-checkout") and retraining existing git users?

>> ODB cache
>> =========
>> Since traverse_trees() hits the ODB for each tree object (of which there are
>> over 500K in this repo) I wrote and tested having an in-memory ODB cache
>> that cached all tree objects.  This resulted in a > 50% hit ratio (largely
>> due to the fact we traverse the tree twice during checkout) but resulted in
>> only a minimal savings (1.3 seconds).
> 
> In my experience, one major cost of object access is decompression, both
> delta and zlib. Trees in particular tend to delta very well across
> versions. We have a cache to try to reuse intermediate delta results,
> but the default size is probably woefully undersized for your repository
> (I know from past tests it's undersized a bit even for the linux
> kernel).
> 
> Try bumping core.deltaBaseCacheLimit to see if that has any impact. It's
> 96MB by default.
> 
> There may also be some possible work in making it more aggressive about
> storing the intermediate results. I seem to recall from past
> explorations that it doesn't keep everything, and I don't know if its
> heuristics have ever been proven sane.
> 
> For zlib compression, I don't have numbers handy, but previous
> experiments showed that trees don't actually benefit all that much from
> zlib (presumably because they're mostly random-looking hashes). So one
> option would be to try repacking _just_ the trees with
> "pack.compression" set to 0, and see how the result behaves. I suspect
> that will be pretty painful with your giant multi-pack repo.
> 
> It might be slightly easier if we had an option to set the compression
> level on a per-type basis (both to experiment, and then of course if it
> works to actually tune your repo).
> 
> The numbers above aren't specific enough to know how much time was spent
> doing zlib stuff, though. And even with more specific probes, it's
> generally still hard to tell the difference between what's specific to
> the compression level, and what's a result of the fact that zlib is
> essentially copying all the bytes from the filesystem into memory.
> Still, my timings with zstd[1] showed something like 10-20% improvement
> on object access, so we should be able to get something at least as good
> by moving to no compression.
> 
> [1] https://public-inbox.org/git/20161023080552.lma2v6zxmyaiiqz5@sigill.intra.peff.net/
> 

Thanks, these are good ideas to pursue.  I've added them to my list of 
things to look into but believe pruning the tree or traversing it in 
parallel has more performance saving potential so I'll be looking there 
first.

<snip>


>> Multi-threading unpack_trees()
>> ==============================
>> The current model of unpack_trees() is that a single thread recursively
>> traverses each tree object as it comes across it.  One thought I had was to
>> multi-thread the traversal so that each tree object could be processed in
>> parallel.  To test this idea out, I wrote an unbounded
>> Multi-Product-Multi-Consumer queue and then wrote a
>> traverse_trees_parallel() function that would add any new tree objects into
>> the queue where they can be processed by a pool of worker threads.  Each
>> thread will wake up when there is work in the queue, remove a tree object,
>> process it adding any additional tree objects it finds.
> 
> I'm generally terrified of multi-threading anything in the core parts of
> Git. There are so many latent bits of non-reentrant or racy code.
> 
> I think your queue suggestion may be the sanest approach, though,
> because it makes it keeps the responsibilities of the worker threads
> pretty clear.
> 

I agree the thought of multi-threading unpack_trees() is daunting!  It 
would be nice if the model of pruning the tree was sufficient to get 
reasonable performance with large repos.  I guess we'll see...

>> When I brought up this idea with some other git contributors they mentioned
>> that multi threading unpack_trees() had been discussed a few years ago on
>> the list but that the idea was discarded.  They couldn�t remember exactly
>> why it was discarded and none of us have been able to find the email threads
>> from that earlier discussion. As a result, I decided to write up this RFC
>> and see if the greater git community has ideas, suggestions, or more
>> background/history on whether this is a reasonable path to pursue or if
>> there are other/better ideas on how to speed up checkout especially on large
>> repos.
> 
> I don't remember any specific discussion, and didn't dig anything up
> after a few minutes. But I'd be willing to bet that the primary reason
> it would not be pursued is the general lack of thread safety in the
> current codebase.
> 
> -Peff
> 
