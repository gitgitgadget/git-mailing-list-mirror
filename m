Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B9DC4332F
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 23:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJKX0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 19:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJKX0S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 19:26:18 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6256D55E
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 16:26:17 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id p1-20020aa78601000000b00565a29d32e5so106713pfn.5
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 16:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SplnN1MJ9uiVkJNb9QrYHIK9GjJ0WYn8bClz4bx2c08=;
        b=JwimEOgZYPLZ84jCy/PYL6KzHa3TdVbIwY7fDKrVT/Ya0kmlWtsfZMZdjbt86pH85x
         LcQQHWWY+iKEs0qRtjAjgbX1DcFIthCTuWQc+8oUe6BN0i5PzO3ujiE2jVYpH8PDFB2M
         AGX6g4jlJshUsIB0jpw6s8IGMCfuoyLfK1+bVpF4vnZBW+arehlMFOv4PtFQNyhdd9Kt
         dRzjkZ4jm+JBTXQA8zODcYVSWqpbWqbEzkli4K1CXCbkhVZXePwvZ5DauQQ/bgvhsgWS
         mbRgLh6glungWOieWBvpKV/ixQYuviRwhZ5uPVPBs8BbP16NzN8nf8bUlUHsf73LWwxy
         jJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SplnN1MJ9uiVkJNb9QrYHIK9GjJ0WYn8bClz4bx2c08=;
        b=KraRCK0dKbnTwVm4hEYWpPeAJeyYKmlBoYpxoURVnOcoHOTwPtdAaSZDxn+Smeyt9L
         Dc89loBcc91KIWdQ3PAyVQivOlBufKv0qDrB9Yi7+8VEZvDsNmVpi1S1jUdk0tOmvgfZ
         BKh/6yNeZrMpfQGRqgX2fMnQtMQlrsKHVB+TCGWxY5eOGuk4m5p1N+nTx6DFkT/toC+F
         CXEQEI3u8ZP4IQ0zTAyQs8vPp3vNSNruAbI1fSiiPvEmrrOGtKVT/7eBSLcBZlIJUftm
         Ij2hZjHCQznDn3tbKusp2z2uYqB/u7dzeJkMhw6jlhETl2UaU/L/EOtK/zzUS6F+Jks9
         jfpg==
X-Gm-Message-State: ACrzQf1bDIIV0FYnmow3G8GMpNT0YX6CfjQIz9+DqgrGrGu8Cyuu6d07
        hpk6xKdisuC6gg8VK2f7x99NXwU0+pSuMS6tkHe0/iFHqEJ/Mh+wZOn2k6g9dvjYJ4baUmCYKmz
        ZO/6ObQjgK4bNa2UKekPtqIiyp0oESe0NqJpRsTIKNbJdjF3rE73f+Qt5ghANlZO9RA==
X-Google-Smtp-Source: AMsMyM5Ed+Eb/qXevhkUJ9CpOJ5ZdKuvS5XiRcwzccASAGd6YcmTFhGPRLNstMQjC3+hCny2/aOsm525Ol6o9qI=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:1f86:b0:205:d3d0:1931 with SMTP
 id so6-20020a17090b1f8600b00205d3d01931mr1739015pjb.211.1665530776765; Tue,
 11 Oct 2022 16:26:16 -0700 (PDT)
Date:   Tue, 11 Oct 2022 23:26:00 +0000
In-Reply-To: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011232604.839941-1-calvinwan@google.com>
Subject: [PATCH v2 0/4] submodule: parallelize diff
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1

This series is now rebased on top of Avar's run-command refactor
series[1], which allows new functions to be easily added to
run_parallel_processes without having to change other callers.

The config option has been renamed to submodule.diffJobs. This name
accurately reflects what functionality is affected. While other APIs
parse for config options from the initial command, this config option is
parsed for in the diff-lib.c library. This is because there are so many
entry points into run_diff_files resulting in signicant code changes
required to pass in this config option.

I also wanted to pose another question to list regarding defaults for
parallel processes. For jobs that clearly scale with the number of
processes (aka jobs that are mostly processor bound), it is obvious that
setting the default number of processes to the number of available cores
is the most optimal option. However, this changes when the job is mostly
I/O bound or has a combination of I/O and processing. Looking at my use
case for `status` on a cold cache (see below), we notice that increasing
the number of parallel processes speeds up status, but after a certain
number, it actually starts slowing down. This is because `status` spends
most of its time reading from the index. While SSDs are able to do a
certain amount of reads in parallel, this limit can be significantly
smaller than the number of cores and going past that limit causes the
read head to constantly swap, slowing down `status`. With an HDD,
parallel reads aren't even possible and while I haven't tested my patch
on an HDD, I have a suspicion that adding multiple processes would
probably make `status` slower than the baseline. How should the default
be set then? In my case, the safe option would be to default it to 1,
but then many users wouldn't be able to discover this optimization.
There are also multiple places in the git documentation where we say
that setting a config option for a parallel process to 0 will result in
a "reasonable amount" of processes, which generally entails the number
of available cores. Can this be problematic for other parallel processes
that spend a significant time in I/O? Should my option even have the
option to set it to 0 given the pitalls?

Original cover letter:

When running 'git status' in a superproject, git spawns a subprocess in
series to run status for every submodule. For projects with many large
submodules, parallelizing status subprocesses can significantly speed
up the runtime for both cold and warm caches. While my initial
intention was to speedup status, it turns out that much of the runtime
spent on status is in diff-lib.c, resulting in speedups for many
different other commands that utilize this library.

Here are some timing tests from running status on the Android Open
Source Project (AOSP). My machine has an SSD and 48 cores.=20
  Warm Cache:
    git 2.37
Time (mean =C2=B1 =CF=83):     17.685 s =C2=B1  2.040 s    [User: 5.041 s, =
System: 22.799 s]
Range (min =E2=80=A6 max):   16.168 s =E2=80=A6 22.804 s    10 runs

    this patch (status.parallelSubmodules=3D1)
Time (mean =C2=B1 =CF=83):     13.102 s =C2=B1  0.500 s    [User: 4.894 s, =
System: 19.533 s]
Range (min =E2=80=A6 max):   12.841 s =E2=80=A6 14.447 s    10 runs

    this patch (status.parallelSubmodules=3D5)
Time (mean =C2=B1 =CF=83):      3.994 s =C2=B1  0.152 s    [User: 4.998 s, =
System: 20.805 s]
Range (min =E2=80=A6 max):    3.744 s =E2=80=A6  4.163 s    10 runs

    this patch (status.parallelSubmodules=3D10)
Time (mean =C2=B1 =CF=83):      3.445 s =C2=B1  0.085 s    [User: 5.151 s, =
System: 20.208 s]
Range (min =E2=80=A6 max):    3.319 s =E2=80=A6  3.586 s    10 runs

    this patch (status.parallelSubmodules=3D20)
Time (mean =C2=B1 =CF=83):      3.626 s =C2=B1  0.109 s    [User: 5.087 s, =
System: 20.366 s]
Range (min =E2=80=A6 max):    3.438 s =E2=80=A6  3.763 s    10 runs

We can see that there are diminishing returns and even slightly worse
performance after a certain number of max processes, but optimally
there is a speed up factor of around 5.

  Cold Cache:
    git 2.37
      mean of 3 runs: 6m32s
    this patch (status.parallelSubmodules=3D1)
      mean of 3 runs: 5m34s
    this patch (status.parallelSubmodules=3D5)
      mean of 3 runs: 2m23s
    this patch (status.parallelSubmodules=3D10)
      mean of 3 runs: 2m45s
    this patch (status.parallelSubmodules=3D20)
      mean of 3 runs: 3m23s

We can witness the same phenomenon as above and optimally there is a
speed up factor of around 2.7.

Patch 1 adds output piping to run_processes_parallel_opt so the output
from each submodule can be parsed. Patches 2 and 3 move preexisting
functionality into separate functions and refactor code to prepare
for patch 4 to implement parallelization.

Future work: The reason why status is much slower on a cold cache vs
warm cache is mainly due to refreshing the index. It is worth
investigating whether this is entirely necessary.

[1] https://lore.kernel.org/git/cover-00.15-00000000000-20220930T111343Z-av=
arab@gmail.com/

Calvin Wan (4):
  run-command: add pipe_output_fn to run_processes_parallel_opts
  submodule: move status parsing into function
  diff-lib: refactor match_stat_with_submodule
  diff-lib: parallelize run_diff_files for submodules

 Documentation/config/submodule.txt |  12 ++
 diff-lib.c                         | 108 ++++++++++++--
 run-command.c                      |  12 +-
 run-command.h                      |  22 +++
 submodule.c                        | 230 +++++++++++++++++++++++++----
 submodule.h                        |   9 ++
 t/helper/test-run-command.c        |  18 +++
 t/t0061-run-command.sh             |  65 ++++----
 t/t4027-diff-submodule.sh          |  19 +++
 t/t7506-status-submodule.sh        |  19 +++
 10 files changed, 441 insertions(+), 73 deletions(-)

--=20
2.38.0.rc1.362.ged0d419d3c-goog

