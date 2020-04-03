Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0CAC2BA16
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217842076E
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sL9rXJYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgDCUsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44475 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgDCUsS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so10057449wrw.11
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=L+MmjOjlt0bx+fnxKDrxPxSS4vqBZ3EYSvBsRgS+xm8=;
        b=sL9rXJYV3tsyzWVkLN2wS6sCOGqXdgNjdeBzoF+zbZh5ue6xu4iUb+U7C76JxHDCJc
         jziOWgzw+vPq4F0q9ej3jA8VWdGC2slVDbw87UZA5llqI/Ffy8ltimu+2au53sgKPZWH
         QTwm5meZSSv3csLbKH+xsv9JPBqJ42d1y12jVUzMYeJ2dTdfpI6tS7Tg9wDbtln6SlBd
         quNgJmTYscsyr4c18BE+PPsWf5xS1lcIMs4YOrzHuX0ZKO8dI7JxkUFePMoemLqcYHHi
         /cbQpffMeFdU6fdLwqgL0gZa2FiYVZqWQbgM82MYLonbxJpczQsl6mHx0NT1+9yPnJB6
         VT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L+MmjOjlt0bx+fnxKDrxPxSS4vqBZ3EYSvBsRgS+xm8=;
        b=JliXApeXA7ZBuYcX/2jHzyy7MJWgS8bkorQt5cPK6GYVfAeik2Fd4bGu/AxrA8c37X
         DjVJUhMat1koq4tesdR9rO40vb8RDA0uI5NLkg9xBKzL4jdzJ2OLzQxXAcfHpOaZl+fD
         WsmDx/EAGIGBiTSUzd36qwIr3icmTDuuK8WFU0/wH08xAB9kjHm64g2HpbEPcSPhCQig
         EjpAtZjZtuUCnqWUgncKNnuio5o62xNESwMvhOFYZISBvW+jQElOM7jfV8A6B6UZ+RhJ
         DstgeWbJG14BT6Uc/mtRpnDgl85RHm8B9O/zUYa4a1Cq6hR6DFP5/Km1XLDeP7q1eH4S
         OdJw==
X-Gm-Message-State: AGi0Pub/nTZHMVsg1BSGlZqeMNJu1neRxIA9M21zyEJKkF5mypkhNFpo
        Zyt1EB2gSW3DHojxEQs+IQBXCMuq
X-Google-Smtp-Source: APiQypK31pi+9AbXikIXT2jtEfys9tOQtmnUATynQ3P2QHo97aLUEs2TmkY7ZOwHbGIp5rgWJQGppA==
X-Received: by 2002:adf:fd47:: with SMTP id h7mr11047532wrs.105.1585946895584;
        Fri, 03 Apr 2020 13:48:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm16439272wmj.1.2020.04.03.13.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:15 -0700 (PDT)
Message-Id: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:47:59 +0000
Subject: [PATCH 00/15] [RFC] Maintenance jobs and job runner
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Background maintenance. I've blogged about it [1]. I've talked about it [2].
I brought it up at the contributor summit [3]. I think it's important. It's
a critical feature in Scalar and VFS for Git. It's the main reason we
created the "scalar register" feature for existing repos (so the Scalar
background maintenance would apply to a "vanilla" Git repo).

[1] https://devblogs.microsoft.com/devops/introducing-scalar/[2] 
https://stolee.dev/docs/git-merge-2020.pdf[3] 
https://lore.kernel.org/git/35FDF767-CE0C-4C51-88A8-12965CD2D4FF@jramsay.com.au/

This RFC does the "maintenance" half of "background maintenance". It creates
two new builtins to assist users in scheduling their own background
maintenance:

 * git run-job <job-name>: This builtin will run a single instance of a
   maintenance job.
   
   
 * git job-runner [--repo=<path>]: This builtin will run an infinite loop
   that executes git run-job as a subcommand.
   
   

I believe that I could replace most maintenance steps in Scalar with the git
run-job command and all that we would lose is some logging. (The only one
that would remain is the one that sets recommended config settings, but that
could be changed to a one-time operation at service start-up.) I haven't
tested this yet, but I plan to before sending a non-RFC option.

Of course, just because we think these maintenance operations work for our
scenario does not mean that they immediately work as the "canonical"
maintenance activities. I attempt to demonstrate the value of these jobs as
they are implemented. My perspective is skewed towards very large
repositories (2000+ full-time contributors), but even medium-size
repositories (100-200 full-time contributors) can benefit from these jobs.

I've tried to split the series into logical commits. This includes each
specific maintenance job being completely described in its own commit (plus
maybe an extra one to allow a custom option).

Most commit messages have "RFC QUESTION(S)" for things I was unsure about.

I'm currently testing this locally by setting job.repo in my global config
to be a few important repos on my Linux VM then running 
GIT_TRACE2_PERF=<path> git job-runner --daemonize to launch a background
process that logs the subcommands to <path>.

Here I will call out things that could definitely be improved:

 1. The git job-runner process is not tested AT ALL. It's a bit tricky to
    test it since it shouldn't exit when things work as expected. I expect
    to create a --no-loop option to stop after one iteration of the job
    loop. But I would like a bit more feedback on the concept before jumping
    into those tests. (I do test the git run-job builtin for each job, but
    not the customization through arguments and config.) Perhaps we could do
    some funny business about mocking git using --exec-path to check that it
    is calling git run-job in the correct order (and more importantly, not 
    calling it when certain config settings are present).
    
    
 2. The --daemonize option at the end is shamelessly stolen from git gc
    --daemonize and git daemon, but has limited abilities on some platforms
    (I've tested on Linux and macOS). I have not done my research on how far
    this gets us to allowing users to launch this at startup or something. 
    
    
 3. As I said, this is the "maintenance" "half" of "background maintenance".
    The "background" part is harder in my opinion because it involves
    creating platform-specific ways to consistently launch background
    processes. For example, Unix systems should have one way to service
    start X while Windows has another. macOS has launchd to launch processes
    as users log in, which should be a good way forward. Scalar implements a
    Windows Service that runs as root but impersonates the latest user to
    log in, and it implements a macOS "service" that is running only with
    the current user. I expect to need to create these services myself as a
    follow-up, but I lack the expertise to do it (currently). If someone
    else has experience creating these things and wants to take over or
    advise that half then I would appreciate the help!
    
    
 4. I noticed late in the RFC process that I'm not clearing my argv_arrays
    carefully in the job-runner. This will need to be rectified and
    carefully checked with valgrind before merging this code. While it leaks
    memory very slowly, it will be important that we don't leak any memory
    at all since this is a long-lived process. There's also some places
    where I was careful to not include too much of libgit.a to help keep the
    memory footprint low.
    
    

Thanks, -Stolee

Derrick Stolee (15):
  run-job: create barebones builtin
  run-job: implement commit-graph job
  run-job: implement fetch job
  run-job: implement loose-objects job
  run-job: implement pack-files job
  run-job: auto-size or use custom pack-files batch
  config: add job.pack-files.batchSize option
  job-runner: create builtin for job loop
  job-runner: load repos from config by default
  job-runner: use config to limit job frequency
  job-runner: use config for loop interval
  job-runner: add --interval=<span> option
  job-runner: skip a job if job.<job-name>.enabled is false
  job-runner: add --daemonize option
  runjob: customize the loose-objects batch size

 .gitignore                       |   2 +
 Documentation/config.txt         |   2 +
 Documentation/config/job.txt     |  37 +++
 Documentation/git-job-runner.txt |  63 +++++
 Documentation/git-run-job.txt    | 102 +++++++
 Makefile                         |   2 +
 builtin.h                        |   2 +
 builtin/job-runner.c             | 347 +++++++++++++++++++++++
 builtin/run-job.c                | 458 +++++++++++++++++++++++++++++++
 cache.h                          |   4 +-
 command-list.txt                 |   2 +
 commit-graph.c                   |   2 +-
 commit-graph.h                   |   1 +
 daemon.h                         |   7 +
 git.c                            |   2 +
 midx.c                           |   2 +-
 midx.h                           |   1 +
 t/t7900-run-job.sh               | 137 +++++++++
 18 files changed, 1168 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/config/job.txt
 create mode 100644 Documentation/git-job-runner.txt
 create mode 100644 Documentation/git-run-job.txt
 create mode 100644 builtin/job-runner.c
 create mode 100644 builtin/run-job.c
 create mode 100644 daemon.h
 create mode 100755 t/t7900-run-job.sh


base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-597%2Fderrickstolee%2Fjobs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-597/derrickstolee/jobs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/597
-- 
gitgitgadget
