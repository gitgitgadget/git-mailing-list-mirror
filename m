Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F304C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7235461260
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 18:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbhGNSoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhGNSoS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 14:44:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD3FC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 11:41:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c17so4841620ejk.13
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gi/Oc97r/njtVQoLGMEs2VCVD+9TjS1PriJkhNEsrvY=;
        b=hEuNKTvVhjs8/6DU6AWY3cu35oBxINTHyQX1pBeNEpyYnuvL7BmOYVCJfN6UQD6BUj
         cWWJot3qebnxWfpWlqxKgEiX7RMD9U2uwMbwBV3tbvfz5i43dVpK3V/VAey70zsLxwv2
         i6JwSdgPFLmKEOiukRNWmgRsKF6PRiFRaMR711Rn+qfhATQ0c27Fw/GYvLanp0+/5Df8
         ps6rWfXM+Vt/Sz5yZAjsrJ50x7EK0JQZFNDo9aN7GPUW9pJ9JL6EBcfUDp/RDLVgkTLd
         dUPpU4pwmyrgOHPKzsrV2Nl13IUAoWeIXYyP61prP43PKyLWnYQ/4Uu5qrwPc8HwADYH
         qVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gi/Oc97r/njtVQoLGMEs2VCVD+9TjS1PriJkhNEsrvY=;
        b=fXntIXw7FVqouwhWAWo2vMgOijJ+TAbytic3euRzwr/nAQ6PzVJXx0Gjmbm8hzVqFn
         vvap/YN8N9diet/3ZpKcgywxQi7D8rQrNRUsKjksl7IE7vzDQI54rMU3OJ304XXyGfuU
         YDhnVxPQF0EZ5skBCRfhCp2slX0JEdzBZedGM/stAjGrcF4CB2vt6ZggJCn2MGfpillG
         kTfHPRrRYS7TZ8waUcR3+m/D4Lw8oi86Zl0tLncfUJBZI/9AQaGGk5YvA4NK9fNcY1aJ
         vjJohSBexhCLc/z2Ioib/UevLPlnJOWLIDQfhTrRekMFVsQydomptGQu7mbraHzl5jj7
         /0UQ==
X-Gm-Message-State: AOAM531nCewgvIYbVkYRpA7PLcN0IJ80H0GfZMt8g3i8EyZs29b8uEys
        Md+HkbmxrnHb/IFL7r7Ms+0=
X-Google-Smtp-Source: ABdhPJxybAGiC5/533Usb1jmN21uDTyyonJsq+66YgmMqa3FLVdHLJ5L1QFS5uK3ICkpg+wNypuIzA==
X-Received: by 2002:a17:906:2bdb:: with SMTP id n27mr13900758ejg.312.1626288084236;
        Wed, 14 Jul 2021 11:41:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j24sm1380700edv.48.2021.07.14.11.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:41:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     Sun Chao <16657101987@163.com>, Taylor Blau <me@ttaylorr.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
Date:   Wed, 14 Jul 2021 20:19:15 +0200
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <87wnpt1wwc.fsf@evledraar.gmail.com> <YO5RZ0Wix/K5q53Z@nand.local>
 <ACE7ECBE-0D7A-4FB8-B4F9-F9E32BE2234C@163.com>
 <YO8XrOChAtxhpuxS@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YO8XrOChAtxhpuxS@nand.local>
Message-ID: <877dhs20x3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Taylor Blau wrote:

> On Thu, Jul 15, 2021 at 12:46:47AM +0800, Sun Chao wrote:
>> > Stepping back, I'm not sure I understand why freshening a pack is so
>> > slow for you. freshen_file() just calls utime(2), and any sync back to
>> > the disk shouldn't need to update the pack itself, just a couple of
>> > fields in its inode. Maybe you could help explain further.
>> >
>> > [ ... ]
>>
>> The reason why we want to avoid freshen the mtime of ".pack" file is to
>> improve the reading speed of Git Servers.
>>
>> We have some large repositories in our Git Severs (some are bigger than 10GB),
>> and we created '.keep' files for large ".pack" files, we want the big files
>> unchanged to speed up git upload-pack, because in our mind the file system
>> cache will reduce the disk IO if a file does not changed.
>>
>> However we find the mtime of ".pack" files changes over time which makes the
>> file system always reload the big files, that takes a lot of IO time and result
>> in lower speed of git upload-pack and even further the disk IOPS is exhausted.
>
> That's surprising behavior to me. Are you saying that calling utime(2)
> causes the *page* cache to be invalidated and that most reads are
> cache-misses lowering overall IOPS?
>
> If so, then I am quite surprised ;). The only state that should be
> dirtied by calling utime(2) is the inode itself, so the blocks referred
> to by the inode corresponding to a pack should be left in-tact.
>
> If you're on Linux, you can try observing the behavior of evicting
> inodes, blocks, or both from the disk cache by changing "2" in the
> following:
>
>     hyperfine 'git pack-objects --all --stdout --delta-base-offset >/dev/null'
>       --prepare='sync; echo 2 | sudo tee /proc/sys/vm/drop_caches'
>
> where "1" drops the page cache, "2" drops the inodes, and "3" evicts
> both.
>
> I wonder if you could share the results of running the above varying
> the value of "1", "2", and "3", as well as swapping the `--prepare` for
> `--warmup=3` to warm your caches (and give us an idea of what your
> expected performance is probably like).

I think you may be right narrowly, but wrong in this context :)

I.e. my understanding of this problem is that they have some incremental
backup job, e.g. rsync without --checksum (not that doing that would
help, chicken & egg issue)..

So by changing the mtime you cause the file to be re-synced.

Yes Linux (or hopefully any modern OS) isn't so dumb as to evict your FS
cache because of such a metadata change, but that's besides the point.

If you have a backup job like that your FS cache will get evicted or be
subject to churn anyway, because you'll shortly be having to deal with
the "rsync" job that's noticed the changed mtime competing for caching
resources with "real" traffic.

Sun: Does that summarize the problem you're having?

<large digression ahead>

Sun, also: Note that in general doing backups of live git repositories
with rsync is a bad idea, and will lead to corruption.

The most common cause of such corruption is that a tool like "rsync"
will iterate recursively through say "objects" followed by "refs".

So by the time it gets to the latter (or is doing a deep iteration
within those dirs) git's state has changed in such a way as to yield an
rsync backup in a state that the repository was never in.

(As an aside, I've often wondered what it is about git exactly makes
people who'd never think of doing the same thing with the FS part of an
RDMBS's data store think that implementing such an ad-hoc backup
solution for git would be a good idea, but I digress. Perhaps we need
more scarier looking BerkeleyDB-looking names in the .git directory :)

Even if you do FS snapshots of live git repositories you're likely to
get corruption, search this mailing list for references to fsync(),
e.g. [1].

In short, git's historically (and still) been sloppy about rsync, and
relied on non-standard behavior such as "if I do N updates for N=1..100,
and fsync just "100", then I can assume 1..99 are fsynced (spoiler: you
can't assume that).

Our use of fsync is still broken in that sense today, git is not a safe
place to store your data in the POSIXLY pedantic sense (and no, I don't
just mean that core.fsyncObjectFiles is `false` by default, it only
covers a small part of this, e.g. we don't fsync dir entries even with
that).

On a real live filesystem this is usually not an issue, because if
you're not dealing with yanked power cords (and even then, journals
might save you), then even if you fsync a file but don't fsync the dir
entry it's in, the FS is usually forgiving about such cases.

I.e. if someone does a concurrent request for the could-be-outdated dir
entry they'll service the up-to-date one, even without that having been
fsync'd, because the VFS layer isn't going to the synced disk, it's
checking it's current state and servicing your request from that.

But at least some FS snapshot implementations have a habit of exposing
the most pedantic interpretation possible of FS semantics, and one that
you wouldn't ever get on a live FS. I.e. you might be hooking into the
equivalent of the order in which things are written to disk, and end up
with a state that would never have been exposed to a running program
(there would be a 1=1 correspondence if we fsync'd properly, which we
don't).

The best way to get backups of git repositories you know are correct are
is to use git's own transport mechanisms, i.e. fetch/pull the data, or
create bundles from it. This would be the case even if we fixed all our
fsync issues, because doing so wouldn't help you in the case of a
bit-flip, but an "index-pack" on the other end will spot such issues.

1. https://lore.kernel.org/git/20200917112830.26606-2-avarab@gmail.com/
