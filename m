Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A143EC433E2
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 06:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777AE2065F
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 06:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGlfAcJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgGMGTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbgGMGTF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 02:19:05 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A2FC061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 23:19:05 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so14827679eje.7
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 23:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9GzgFkmc17NyJ4tO13tnB83xEyeDolgA1dytGOC0Mak=;
        b=iGlfAcJNqbHgoo0/wIKYy90oNJCRrieGNT6fgir2xLI0uTaiFd7e+X5M2WxaMxD8FU
         IIH6wfvBqVwuJbUXrCxWdOvyrj+jw1rnydbf83z9SoGBYF5+mJJThFQazfhAMErwP6DB
         yue02WO++fnm9S9anaj2T5tZoRIvCYxl0uhPM/BAD7jinGZIgOYX6MhLPElWWx3BdTMZ
         unrO3qmTJS1Dne9Z8MIjqLHZ7M/ZPHuwYxuNtRD2d/Kt58+//U8xlHM/VvZ6k9LJO4Qy
         hCGuuzhJLTLi/t5RYo6YHZyoaX9AEEvvhNUPvNqpkGFfgdyVuV4vMVPJ9WXvoONMQw9M
         yA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9GzgFkmc17NyJ4tO13tnB83xEyeDolgA1dytGOC0Mak=;
        b=OnVl1LDt1wH/cTloyy+F3IsmXYBc0TPy62TGaXbNnIFPKcvdv/OD1VBc5bJOGmJkA8
         L7wh4ku4zjNJdwIQzhDDwS3PMcPu4exsU/3+xeg++ivRTMHUBm5QhrHnpk+e9qtQexHa
         1sTWYsVnu/Cq9pCuVtYvmIOWhXEd7FYIONIIDMzf0uYswHmfn5fJfbHZqWkVhuZ960fY
         RcosnSiKNK1ZUDwnfkQYb0pfsm6sR7y2T7AH97I8V0l70k2DOfdpHEC1R1lafdqGkskt
         U13wSQRWrQMo/C895wAj7nm8MjJkrNKEIh8OHyMHMMlnWLj8Aa2DM35ICOz1MOHuhswt
         S5kQ==
X-Gm-Message-State: AOAM533e+gO1SIvqcOd8mZmJQ32rt/tpF2wJYYXsMLZEHjxkrDGLWbhz
        ehiGUjXQcHRbW7DxY6aKEYfNAWfoivY+izvlgNU=
X-Google-Smtp-Source: ABdhPJy5nn2mA4YhMmUDCvCORNUr6g+g2+Zh2gVyEINKUWWa3WnjGtOkp3NPtkIu8GhDWTxMM1gj9QFDdFv9qzebI2k=
X-Received: by 2002:a17:906:3945:: with SMTP id g5mr76965086eje.549.1594621143638;
 Sun, 12 Jul 2020 23:19:03 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Mon, 13 Jul 2020 08:18:52 +0200
Message-ID: <CAL3xRKfTTr=Tkq2NY7zUwCSWGHXO2FAwEHKvV2-4AavX9Cs7ow@mail.gmail.com>
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto' customization
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org, jrnieder@gmail.com,
        peff@peff.net, phillip.wood123@gmail.com,
        sandals@crustytoothpaste.net, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

> This is a second attempt at redesigning Git's repository maintenance
> patterns. The first attempt [1] included a way to run jobs in the background
> using a long-lived process; that idea was rejected and is not included in
> this series. A future series will use the OS to handle scheduling tasks.
>
> [1]
> https://lore.kernel.org/git/pull.597.git.1585946894.gitgitgadget@gmail.com/
>
> As mentioned before, git gc already plays the role of maintaining Git
> repositories. It has accumulated several smaller pieces in its long history,
> including:
>
>  1. Repacking all reachable objects into one pack-file (and deleting
>     unreachable objects).
>  2. Packing refs.
>  3. Expiring reflogs.
>  4. Clearing rerere logs.
>  5. Updating the commit-graph file.

It's worth mentioning 'git worktree prune' as well.

>
> While expiring reflogs, clearing rererelogs, and deleting unreachable
> objects are suitable under the guise of "garbage collection", packing refs
> and updating the commit-graph file are not as obviously fitting. Further,
> these operations are "all or nothing" in that they rewrite almost all
> repository data, which does not perform well at extremely large scales.
> These operations can also be disruptive to foreground Git commands when git
> gc --auto triggers during routine use.
>
> This series does not intend to change what git gc does, but instead create
> new choices for automatic maintenance activities, of which git gc remains
> the only one enabled by default.
>
> The new maintenance tasks are:
>
>  * 'commit-graph' : write and verify a single layer of an incremental
>    commit-graph.
>  * 'loose-objects' : prune packed loose objects, then create a new pack from
>    a batch of loose objects.
>  * 'pack-files' : expire redundant packs from the multi-pack-index, then
>    repack using the multi-pack-index's incremental repack strategy.
>  * 'fetch' : fetch from each remote, storing the refs in 'refs/hidden//'.

As some of the previous discussions [1] have raised, I think 'prefetch' would
communicate the refs' purpose better than just 'hidden'.
In-fact, I would suggest naming the task 'prefetch' instead, just to avoid
potential communication issue between 'git fetch' and 'git maintenance fetch'.

[1]: https://lore.kernel.org/git/xmqqeet1y8wy.fsf@gitster.c.googlers.com/

>
> These tasks are all disabled by default, but can be enabled with config
> options or run explicitly using "git maintenance run --task=". There are
> additional config options to allow customizing the conditions for which the
> tasks run during the '--auto' option. ('fetch' will never run with the
> '--auto' option.)
>
>  Because 'gc' is implemented as a maintenance task, the most dramatic change
> of this series is to convert the 'git gc --auto' calls into 'git maintenance
> run --auto' calls at the end of some Git commands. By default, the only
> change is that 'git gc --auto' will be run below an additional 'git
> maintenance' process.
>
> The 'git maintenance' builtin has a 'run' subcommand so it can be extended
> later with subcommands that manage background maintenance, such as 'start',
> 'stop', 'pause', or 'schedule'. These are not the subject of this series, as
> it is important to focus on the maintenance activities themselves.
>
> An expert user could set up scheduled background maintenance themselves with
> the current series. I have the following crontab data set up to run
> maintenance on an hourly basis:
>
> 0 * * * * git -C /<path-to-repo> maintenance run --no-quiet >>/<path-to-repo>/.git/maintenance.log

Perhaps the logging should be included inside the maintenance command instead
of relying on the append here?
Given that we have 'gc.log', I would imagine 'maintenance.log' is not
too far-fetched?

>
> My config includes all tasks except the 'gc' task. The hourly run is
> over-aggressive, but is sufficient for testing. I'll replace it with daily
> when I feel satisfied.
>
> Hopefully this direction is seen as a positive one. My goal was to add more
> options for expert users, along with the flexibility to create background
> maintenance via the OS in a later series.
>
> OUTLINE
> =======
>
> Patches 1-4 remove some references to the_repository in builtin/gc.c before
> we start depending on code in that builtin.
>
> Patches 5-7 create the 'git maintenance run' builtin and subcommand as a
> simple shim over 'git gc' and replaces calls to 'git gc --auto' from other
> commands.
>
> Patches 8-15 create new maintenance tasks. These are the same tasks sent in
> the previous RFC.
>
> Patches 16-21 create more customization through config and perform other
> polish items.
>
> FUTURE WORK
> ===========
>
>  * Add 'start', 'stop', and 'schedule' subcommands to initialize the
>    commands run in the background.
>
>
>  * Split the 'gc' builtin into smaller maintenance tasks that are enabled by
>    default, but might have different '--auto' conditions and more config
>    options.
>
>
>  * Replace config like 'gc.writeCommitGraph' and 'fetch.writeCommitGraph'
>    with use of the 'commit-graph' task.
>
>
>
> Thanks, -Stolee

Thanks,
Son Luong.
