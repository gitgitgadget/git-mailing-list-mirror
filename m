Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02BEC433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 05:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2380619D6
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 05:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhCaFgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 01:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhCaFgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 01:36:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986ADC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 22:36:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id jy13so28202724ejc.2
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOxpSHUGQySxYteW7WriMnYsygBUeD8NHkTbYOPDdDU=;
        b=Jv6Lzn78HWw5b/BIfGThXumSEbfXrhlZlAPBGa6q9HaVMgN7cU5Aa57hxar3wUTCGu
         qapMpbucaqOt79Kc1wcF/kCgWj1qQxqmmDZX8Vl3UJjtSZKpr3Qa6kiaZr+KHD/EP9Yd
         cmra1LbtWdPE8YbcWwLQ5yzcHnt1xZL2eHCMitTPgbRnRhY8Fe/g1b/H6xLjVT5HaPX0
         oO5tSfScaWP/F15/WerLMfUnq0qUQM1enjxis40LmA2AMD3WcZVUxBXCNeQCslFAQLAZ
         IBNGhQG5fg6NIItMm6DU1YDADon2vqwzHBS9/WZAZ+LSj1rrYw5aFaBt1a320XCGiZIh
         bNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOxpSHUGQySxYteW7WriMnYsygBUeD8NHkTbYOPDdDU=;
        b=byYWvayvdZvYU3qpfY58a49VCuJpY/jMxsodZXDgatJPQsE2Hkm0YhR+ln+m3AJQW+
         cO+JosLbHLIBlXtzlHEVmnrJEfMySsbyI6ZQWS8jsFUACqWqeILIKlf5pkVaV2GP8M7F
         joffuEg82TpjrvSVKGebBP0VvRMaIL8u4XTbGFBrRIGme2pgWd5b/ULYv9yXgq9iAlMa
         fH/4Ln6Zc2HfPbikAKbQwlyDBVtk66syVWNtbo7Edy+3HGkmP+WyGFEZcRsVN4y0namy
         6esFOUwNAf93RcQ0bgxPSdsLUu9nBy0zrq78t70gH6fFnn9RbUGCMRkJiojSek+48Cua
         oCCg==
X-Gm-Message-State: AOAM531P5M0CkSniLpdJ7QwmpoEpCbecvPrMxPHhj/j5pQ0bCihA73A5
        3zEr1/7hzVJrY/JDwOayorUBr6/TkeAgsaP8RKbQsqU+39lnmw==
X-Google-Smtp-Source: ABdhPJzsqZcZuhe5Yb2mEoKv6/vaujqRHT4loYmOAZfF0UzON53ts+vPz3+pv/rTG+gto/EoPL+5VMykt1WGugE5yA4=
X-Received: by 2002:a17:906:2795:: with SMTP id j21mr1663909ejc.283.1617168974151;
 Tue, 30 Mar 2021 22:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616015337.git.matheus.bernardino@usp.br> <0592740ec14c4ab72b8d46a7fecf1c66e7a497fd.1616015337.git.matheus.bernardino@usp.br>
In-Reply-To: <0592740ec14c4ab72b8d46a7fecf1c66e7a497fd.1616015337.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 31 Mar 2021 07:36:02 +0200
Message-ID: <CAP8UFD3XkU6H==pHCFLpchKrb9cNj8fFnmF4HmCG-SaYj8C-Vg@mail.gmail.com>
Subject: Re: [PATCH 5/5] parallel-checkout: add design documentation
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 10:12 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:

> +For the purposes of discussion here, the current sequential
> +implementation of Step 3 has 3 layers:

You refer to these layers as "steps" below, so you might want to use
"sub-steps" instead of "layers".

> +* Step 3a: `unpack-trees.c:check_updates()` contains a series of
> +  sequential loops iterating over the `cache_entry`'s array. The main
> +  loop in this function calls the next layer for each of the

Not sure what "layer" means here. Does it mean Step 3b below? In this
case I would suggest using "Step 3b" instead of "layer".

> +  to-be-updated entries.
> +
> +* Step 3b: `entry.c:checkout_entry()` examines the existing working tree
> +  for file conflicts, collisions, and unsaved changes. It removes files
> +  and create leading directories as necessary. It calls the next layer

s/create/creates/

I guess the "next layer" is Step 3c below.

> +  for each entry to be written.
> +
> +* Step 3c: `entry.c:write_entry()` loads the blob into memory, smudges
> +  it if necessary, creates the file in the working tree, writes the
> +  smudged contents, calls `fstat()` or `lstat()`, and updates the
> +  associated `cache_entry` struct with the stat information gathered.
> +
> +It wouldn't be safe to perform Step 3b in parallel, as there could be
> +race conditions between file creations and removals. Instead, the
> +parallel checkout framework lets the sequential code handle Step 3b,
> +and use parallel workers to replace the sequential
> +`entry.c:write_entry()` calls from Step 3c.

Ok.

> +Rejected Multi-Threaded Solution
> +--------------------------------
> +
> +The most "straightforward" implementation would be to spread the set of
> +to-be-updated cache entries across multiple threads. But due to the
> +thread-unsafe functions in the ODB code, we would have to use locks to
> +coordinate the parallel operation. An early prototype of this solution
> +showed that the multi-threaded checkout would bring performance
> +improvements over the sequential code, but there was still too much lock
> +contention. A `perf` profiling indicated that around 20% of the runtime
> +during a local Linux clone (on an SSD) was spent in locking functions.
> +For this reason this approach was rejected in favor of using multiple
> +child processes, which led to a better performance.

Nice explanation.

> +Multi-Process Solution
> +----------------------
> +
> +Parallel checkout alters the aforementioned Step 3 to use multiple
> +`checkout--helper` background processes to distribute the work. The
> +long-running worker processes are controlled by the foreground Git
> +command using the existing run-command API.
> +
> +Overview
> +~~~~~~~~
> +
> +Step 3b is only slightly altered; for each entry to be checked out, the
> +main process:

Maybe: s/main process:/main process performs the following steps:/

If you apply this suggestion, you may also want the following below:

s/M1: Checks/M1: Check/
s/and decides/and decide/
s/M2: Creates/M2: Create/
...

> +* M1: Checks whether there is any untracked or unclean file in the
> +  working tree which would be overwritten by this entry, and decides
> +  whether to proceed (removing the file(s)) or not.
> +
> +* M2: Creates the leading directories.
> +
> +* M3: Loads the conversion attributes for the entry's path.
> +
> +* M4: Checks, based on the entry's type and conversion attributes,
> +  whether the entry is eligible for parallel checkout (more on this
> +  later). If it is eligible, enqueues the entry and the loaded
> +  attributes to later write the entry in parallel. If not, writes the
> +  entry right away, using the default sequential code.
> +
> +Note: we save the conversion attributes associated with each entry
> +because the workers don't have access to the main process' index state,
> +so they can't load the attributes by themselves (and the attributes are
> +needed to properly smudge the entry). Additionally, this has a positive
> +impact on performance as (1) we don't need to load the attributes twice
> +and (2) the attributes machinery is optimized to handle paths in
> +sequential order.

Nice!

> +After all entries have passed through the above steps, the main process
> +checks if the number of enqueued entries is sufficient to spread among
> +the workers. If not, it just writes them sequentially. Otherwise, it
> +spawns the workers and distributes the queued entries uniformly in
> +continuous chunks. This aims to minimize the chances of two workers
> +writing to the same directory simultaneously, which could increase lock
> +contention in the kernel.
> +
> +Then, for each assigned item, each worker:
> +
> +* W1: Checks if there is any non-directory file in the leading part of
> +  the entry's path or if there already exists a file at the entry' path.
> +  If so, mark the entry with `PC_ITEM_COLLIDED` and skip it (more on
> +  this later).
> +
> +* W2: Creates the file (with O_CREAT and O_EXCL).
> +
> +* W3: Loads the blob into memory (inflating and delta reconstructing
> +  it).
> +
> +* W4: Filters the blob.

Not sure what "Filters" means here. Is this related to the smudge filter?

> +* W5: Writes the result to the file descriptor opened at W2.
> +
> +* W6: Calls `fstat()` or lstat()` on the just-written path, and sends
> +  the result back to the main process, together with the end status of
> +  the operation and the item's identification number.
> +
> +Note that steps W3 to W5 might actually be performed together, using the
> +streaming interface.

Not sure what "performed together" means here. Does it mean by a
single function or set of functions?

> +Also note that the workers *never* remove any files. As mentioned

Maybe: s/any files/any file/

> +earlier, it is the responsibility of the main process to remove any
> +files that block the checkout operation (or abort it). This is crucial

Maybe: s/files/file/ and s/block/blocks/ and s/abort/aborts/

> +to avoid race conditions and also to properly detect path collisions at
> +Step W1.
> +
> +After the workers finish writing the items and sending back the required
> +information, the main process handles the results in two steps:
> +
> +- First, it updates the in-memory index with the `lstat()` information
> +  sent by the workers. (This must be done first as this information
> +  might me required in the following step.)
> +
> +- Then it writes the items which collided on disk (i.e. items marked
> +  with `PC_ITEM_COLLIDED`). More on this below.
> +
> +Path Collisions
> +---------------
> +
> +Path collisions happen when two different paths correspond to the same
> +entry in the file system. E.g. the paths 'a' and 'A' would collide in a
> +case-insensitive file system.
> +
> +The sequential checkout deals with collisions in the same way that it
> +deals with files that were already present in the working tree before
> +checkout. Basically, it checks if the path that it wants to write
> +already exists on disk, makes sure the existing file doesn't have
> +unsaved data, and then overwrite it. (To be more pedantic: it deletes

s/overwrite/overwrites/

> +the existing file and creates the new one.) So, if there are multiple
> +colliding files to be checked out, the sequential code will write each
> +one of them but only the last will actually survive on disk.
> +
> +Parallel checkout aims to reproduce the same behavior. However, we
> +cannot let the workers racily write to the same file on disk. Instead,
> +the workers detect when the entry that they want to check out would
> +collide with an existing file, and mark it with `PC_ITEM_COLLIDED`.
> +Later, the main process can sequentially feed these entries back to
> +`checkout_entry()` without the risk of race conditions. On clone, this
> +also has the effect of marking the colliding entries to later emit a
> +warning for the user, like the classic sequential checkout does.
> +
> +The workers are able to detect both collisions among the entries being
> +concurrently written and collisions among parallel-eligible and
> +ineligible entries. The general idea for collision detection is quite
> +straightforward: for each parallel-eligible entry, the main process must
> +remove all files that prevent this entry from being written (before
> +enqueueing it). This includes any non-directory file in the leading path
> +of the entry. Later, when a worker gets assigned the entry, it looks
> +again for the non-directories files and for an already existent file at

Maybe: s/existent/existing/

> +the entry's path. If any of these checks finds something, the worker
> +knows that there was a path collision.
> +
> +Because parallel checkout can distinguish path collisions from the case
> +where the file was already present in the working tree before checkout,
> +we could alternatively choose to skip the checkout of colliding entries.
> +However, each entry that doesn't get written would have NULL `lstat()`
> +fields on the index. This could cause performance penalties for
> +subsequent commands that need to refresh the index, as they would have
> +to go to the file system to see if the entry is dirty. Thus, if we have
> +N entries in a colliding group and we decide to write and `lstat()` only
> +one of them, every subsequent `git-status` will have to read, convert,
> +and hash the written file N - 1 times. By checking out all colliding
> +entries (like the sequential code does), we only pay the overhead once,
> +during checkout.
> +
> +Eligible Entries for Parallel Checkout
> +--------------------------------------
> +
> +As previously mentioned, not all entries passed to `checkout_entry()`
> +will be considered eligible for parallel checkout. More specifically, we
> +exclude:
> +
> +- Symbolic links; to avoid race conditions that, in combination with
> +  path collisions, could cause workers to write files at the wrong
> +  place. For example, if we were to concurrently check out a symlink
> +  'a' -> 'b' and a regular file 'A/f' in a case-insensitive file system,
> +  we could potentially end up writing the file 'A/f' at 'a/f', due to a
> +  race condition.
> +
> +- Regular files that require external filters (either "one shot" filters
> +  or long-running process filters). These filters are black-boxes to Git
> +  and may have their own internal locking or non-concurrent assumptions.
> +  So it might not be safe to run multiple instances in parallel.
> ++
> +Besides, long-running filters may use the delayed checkout feature to
> +postpone the return of some filtered blobs. The delayed checkout queue
> +and the parallel checkout queue are not compatible and should remain
> +separated.

Are files that require some other internal filters eligible though?

> +Ineligible entries are checked out by the classic sequential codepath
> +*before* spawning workers.
> +
> +Note: submodules's files are also eligible for parallel checkout (as
> +long as they don't fall into the two excluding categories mentioned
> +above). But since each submodule is checked out in its own child
> +process, we don't mix the superproject's and the submodules' files in
> +the same parallel checkout process or queue.

Ok.

> +The API
> +-------
> +
> +The parallel checkout API was designed with the goal to minimize changes
> +to the current users of the checkout machinery. This means that they
> +don't have to call a different function for sequential or parallel
> +checkout. As already mentioned, `checkout_entry()` will automatically
> +insert the given entry in the parallel checkout queue when this feature
> +is enabled and the entry is eligible; otherwise, it will just write the
> +entry right away, using the sequential code. In general, callers of the
> +parallel checkout API should look similar to this:
> +
> +----------------------------------------------
> +int pc_workers, pc_threshold, err = 0;
> +struct checkout state;
> +
> +get_parallel_checkout_configs(&pc_workers, &pc_threshold);
> +
> +/*
> + * This check is not strictly required, but it
> + * should save some time in sequential mode.
> + */

It might be nice if this comment was also in front of the real code.

> +if (pc_workers > 1)
> +       init_parallel_checkout();
> +
> +for (each cache_entry ce to-be-updated)
> +       err |= checkout_entry(ce, &state, NULL, NULL);
> +
> +err |= run_parallel_checkout(&state, pc_workers, pc_threshold, NULL, NULL);
