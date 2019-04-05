Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7930720248
	for <e@80x24.org>; Fri,  5 Apr 2019 21:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfDEVcJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 17:32:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32820 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEVcI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 17:32:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so3730907pgh.0
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EEXR+S2rjzEJrymfpqf/hpVXDrQ0ie6dwIwqYm8rDfo=;
        b=N2eOGx4umeuEtFo3CIHea6APX4j6eUKw5nsXPP+wQdz00Q7cz1Z4xMf4EKcP3gu3kz
         2HIaAKTiVrtuNnY+uguSMYCWlPnXRTNJ3cChtw13h2CH+/v+TWwNmZ7O1EbJ0UkFtAfx
         8pDZhlq5xMVuZAyxEOeV1j3XFZqNSFDV7qNBLMBcOXwXeS2r7OBS/cZL2hQlEZzeYGzj
         U6ov+CzowfaKwfGwc679dM/4PtDv7lNODkqZZwYksxCqPjQnH7+tLHq7odzbb8aS/JYl
         3R+HaYIiAUGfooLIArlf/vxHA7cH4co/waz2xAhtIitSRYQLK2mb6ivjoz5oFu9nXLNc
         bRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EEXR+S2rjzEJrymfpqf/hpVXDrQ0ie6dwIwqYm8rDfo=;
        b=HJCFA94VdXWeTPBAWuG1q09WfexnaEKBiNQ4VXqpMLARxFYQjqpTpi/iE3tIYJnVMB
         CstPvwwinUWdwGrVzt0PMRSURJ4zaCY7HyE/9uRpnmlvZmicJGthzhE9LIg69wZRfw6m
         zuLTfPuFbJRe+2o6WkJRHUanWoN1yzWt1rhnNvY7Q7mRAa1W62uIGbJwoejVznlNa4I2
         cCMFxELASyxMvRRJz+myrxPPr+8IYuFszNCWtZOShuFr1W8f/mVPCluJWf7r7iRBfY02
         KB14dwDTr7mEFEaxVnADdsH6RBX1bFKrSYDEBCDlIubjwe/LhzA0pZtS0bblptlE2Sd6
         INXA==
X-Gm-Message-State: APjAAAXAztDBjmt7chCbxDT+SKY6icTIS9zI41OFc27NS2xb9FD3r4Wz
        5evtYWjiyuhGnV33E8SRIc8=
X-Google-Smtp-Source: APXvYqxBeffRCdzQHqse7kkk5KtRSz2khmLY7ueHINbn2dqpXbdW9XMvJotiXo4GV+4lKTtWIqxrTA==
X-Received: by 2002:a62:5797:: with SMTP id i23mr14658648pfj.12.1554499926782;
        Fri, 05 Apr 2019 14:32:06 -0700 (PDT)
Received: from ar135.iitr.local (ipchair.iitr.ernet.in. [103.37.200.166])
        by smtp.gmail.com with ESMTPSA id d129sm33975964pfa.142.2019.04.05.14.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 14:32:04 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     newren@gmail.com
Cc:     Johannes.Schindelin@gmx.de, alban.gruin@gmail.com,
        artagnon@gmail.com, christian.couder@gmail.com,
        git@vger.kernel.org, rafa.almas@gmail.com,
        rohit.ashiwal265@gmail.com, s-beyer@gmx.net, t.gummerer@gmail.com
Subject: [GSoC][RFC v3] Proposal: Improve consistency of sequencer commands
Date:   Sat,  6 Apr 2019 03:01:00 +0530
Message-Id: <20190405213100.9577-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hiya

Here is one more iteration of my draft proposal[1]. RFC.

Thanks
Rohit

[1]: https://gist.github.com/r1walz/5588d11065d5231ee451c0136400610e

---------------------------------- >8 ------------------------------------------


# Improve consistency of sequencer commands

## About Me

### Personal Information

Name           |     Rohit Ashiwal
---------------|----------------------------------------------------------------
Major          |     Computer Science and Engineering
E-mail         |     \<rohit.ashiwal265@gmail.com>
IRC            |     __rohit
Skype          |     rashiwal
Ph no          |     [ ph_no ]
Github         |     [r1walz](https://github.com/r1walz/)
Linkedin       |     [rohit-ashiwal](https://linkedin.com/in/rohit-ashiwal/)
Address        |     [                         Address                         ]
Postal Code    |     [ postal_code ]
Time Zone      |     IST (UTC +0530)


### Background

I am a sophomore at the [Indian Institute of Technology Roorkee][1], pursuing my
bachelor's degree in Computer Science and Engineering. I was introduced to
programming at a very early stage of my life. Since then, I've been trying out
new technologies by taking up various projects and participating in contests.  I
am passionate about system software development and competitive programming, and
I also actively contribute to open-source projects. At college, I joined the
Mobile Development Group ([MDG][2]), IIT Roorkee - a student group that fosters
mobile development within the campus. I have been an active part of the Git
community since February of this year, contributing to git-for-windows.


### Dev-Env

I am fluent in C/C++, Java and Shell Scripting, otherwise, I can also program in
Python, JavaScript. I use both Ubuntu 18.04 and Windows 10 x64 on my laptop.  I
prefer Linux for development unless the work is specific to Windows. \
VCS **:** git \
Editor **:** VS Code with gdb integrated


## Contributions to Open Source

My contributions to open source have helped me gain experience in understanding
the flow of any pre-written code at a rapid pace and enabled me to edit/add new
features.

### List of Contributions at Git:

Repo                              |Status                      |Title
----------------------------------|----------------------------|-----------------------------------------------------------------------
[git/git][8]                      | [Will merge in master][13] | [Micro][3]**:** Use helper functions in test script
[git-for-windows/git][9]          | Merged and released        | [#2077][4]**:** [FIX] git-archive error, gzip -cn : command not found.
[git-for-windows/build-extra][10] | Merged and released        | [#235][5]**:** installer: Fix version of installer and installed file.


## The Project

### _Improve consistency of sequencer commands_

#### Overview

Since when it was created in 2005, the `git rebase` command has been
implemented using shell scripts that are calling other git commands. Commands
like `git format-patch` to create a patch series for some commits, and then
`git am` to apply the patch series on top of a different commit in case of
regular rebase and the interactive rebase calls `git cherry-pick` repeatedly
for the same.

Neither of these approaches has been very efficient though, and the main reason
behind that is that repeatedly calling a git command has a significant
overhead. Even the regular git rebase would do that as `git am` had been
implemented by launching `git apply` on each of the patches.

The overhead is especially big on Windows where creating a new process is quite
slow, but even on other Operating Systems it requires setting up everything
from scratch, then reading the index from disk, and then, after performing some
changes, writing the index back to the disk.

Stephan Beyer \<s-beyer@gmx.net> tried to introduce git-sequencer as his GSoC
2008 [project][6] which executed a sequence of git instructions to  \<HEAD> or
\<branch> and the sequence was given by a \<file> or through `stdin`. The
git-sequencer wants to become the common backend for git-am, git-rebase and
other git commands, so as to improve performance, since then it eliminated the
need to spawn a new process.

Unfortunately, most of the code did not get merged during the SoC period but he
continued his contributions to the project along with Christian Couder
\<chriscool@tuxfamily.org> and then mentor Daniel Barkalow
\<barkalow@iabervon.org>.

The project was continued by Ramkumar Ramachandra \<artagnon@gmail.com> in
[2011][7], extending its domain to git-cherry-pick. The sequencer code got
merged and it was now possible to "continue" and "abort" when cherry-picking or
reverting many commits.

A patch series by Christian Couder \<chriscool@tuxfamily.org> was merged in
[2016][16] to the `master` branch that makes `git am` call `git apply`’s
internal functions without spawning the latter as a separate process. So the
regular rebase will be significantly faster especially on Windows and for big
repositories in the next Git feature release.

Despite the success (of GSoC '11), Dscho had to improve a lot of things to make
it possible to reuse the sequencer in the interactive rebases making it faster.
His work can be found [here][15].

The learnings from all those works will serve as a huge headstart this year for
me.

As of now, there are still some inconsistencies among these commands, e.g.,
there is no `--skip` flag in `git-cherry-pick` while one exists for
`git-rebase`. This project aims to remove inconsistencies in how the command
line options are handled.


#### Points to work on:

1. Suggest relevant flags for operations that have such a concept like
    `git cherry-pick --skip`
2. Unify the suggestive messages of `git (cherry-pick|rebase-i)` with
    `git (am|rebase)`
3. Implement flags that am-based rebases support, but not interactive,
    in interactive rebases, e.g.:
```
    * --ignore-whitespace
    * --committer-date-is-author-date or --ignore-date
    * --whitespace=...
    * -C
```
4. Test and Documentation
5. `[Bonus]` Make a flag to allow rebase to rewrite commit messages that
  refer to older commits that were also rebased
6. `[Bonus]` Performance run on different backends of rebasing, if everything
  agrees, deprecate am-based rebases


#### "The Plan"

1. Start by introducing `git cherry-pick --skip`, this will help in step 2 of
"the plan", since we are required to unify the advice messages that show during
an interrupt of `git (cherry-pick|rebase -i)` when the incoming commit has
become "empty" (no change between commits).

    **_Files changed_ :**
    - revert.c: Introduce option `--skip` under `run_sequencer()`

2. There are two backends available for rebasing/cherry-picking, _viz_, the `am`
and the `interactive`.  Naturally, there shall be some features that are
implemented in one but not in the other.  One such quality is suggestive
messages. The am-based rebases (and am itself) will give advice to the user to
use `git rebase --skip` (or `git am --skip`) when a patch isn't needed. In
contrast, interactive-based and cherry-pick will suggest the user `git reset`.
Change this to match the message of `am` backend, so that everything appears
symmetric.

    **_Files changed_ :**
    - rebase.c: change flow so that `--skip` calls `git reset` while interactive
      rebasing
    - commit.c: change messages
    - sequencer.c: change suggestive message under `create_seq_dir()`

3. Now that I'm familiar with the code, I'll start picking the pace now. And
start implementing the meat of the project. The flags. I'll start implementing
the flags in the following order as [Elijah suggested][12]:
    1. --ignore-whitespace
    2. --committer-date-is-author-date
    3. --ignore-date
    4. --whitespace=...

    **_Files changed_ :**
    - rebase: introduce the flag
    - builtin/rebase--interactive: introduce the flag under `cmd_rebase__interactive()`
    - change messages wherever required

4. Testing and Documentation will go in sync with implementation. I intend to
follow `Test Driven Development` but let's see how it turns out.

5. `[Bonus]` As familiarity with the code increases, I might be able to implement
a flag to allow rebase to rewrite commit messages that refer to older commits that
were also rebased in time.

6. `[Bonus]` If everything goes well and time permits, discuss with the mentor(s)
the possibility of deprecating the am backend of rebase. This point is last to
work on as it provides no "cosmetic" difference on the user side. Elijah
[mentioned][12] the possibility of a "social" problem that might occur which shall
be discussed then.


#### Proposed Timeline

+ Community Bonding (May 6th - May 26th):
    - Introduction to community
    - Get familiar with the dataflow
    - Study and understand the workflow and implementation of the project in
      detail

+ Phase 1 (May 27th - June 23rd):
    - Start with implementing `git cherry-pick --skip`
    - Write new tests for the just introduced flag(s)
    - Analyse the requirements and differences of am-based and other rebases
      flags

+ Phase 2 (June 24th - July 21st):
    - Introduce flags of am-based rebases to other kinds.
    - Add tests for the same.

+ Phase 3 (July 22th - August 19th):
    - Act on [Bonus] features
    - Documentation
    - Clean up tasks


#### Relevant Work

Dscho and I had a talk on how a non-am backend should implement `git rebase
--whitespace=fix`, which he warned may become a large project (as it turns out
it is a sub-task in one of the [proposed ideas][11]), we were trying to
integrate this on git-for-windows first.

Keeping warning in mind, I discussed this project with Rafael and he suggested
(with a little bit uncertainty in mind) that I should work on implementing a
git-diff flag that generates a patch that when applied, will remove whitespace
errors which I am currently working on.


## Availability

My vacations start on 7 May and end on 15 July. The official GSoC period is from
6 May to 19 August. I can easily devote 40-45 hours a week until my college
reopens and 35-40 hours per week after that. I'm also free on the weekends and I
intend to complete most of the work before my college reopens.

Other than this project, I have no commitments/vacations planned for the summer.
I shall keep my status posted to all the community members on a weekly basis and
maintain transparency in the project.

## After GSoC

Even after the Google Summer of Code, I plan on continuing my contributions to
this organization, by adding to my project and working on open issues or
feature requests. With the community growing continuously, I feel responsible
for all the projects I'm a part of. Having picked up a lot of developing skills,
my major focus would be to develop mentorship skills so that I can give back
this community by helping other people navigate around and reviewing
contributions.


[0]: https://git.github.io/SoC-2019-Ideas/
[1]: https://www.iitr.ac.in/
[2]: http://mdg.iitr.ac.in/
[3]: https://public-inbox.org/git/20190303122842.30380-1-rohit.ashiwal265@gmail.com/
[4]: https://github.com/git-for-windows/git/pull/2077
[5]: https://github.com/git-for-windows/build-extra/pull/235
[6]: https://public-inbox.org/git/20080607220101.GM31040@leksak.fem-net/
[7]: https://public-inbox.org/git/20110403172054.GA10220@kytes/
[8]: https://github.com/git/git/commit/404110d2910aa617c7fb7e326694f8e085c5b2a0
[9]: https://github.com/git-for-windows/git/commit/ed2b22adeb760d967c567c5664d33d5d641db10e
[10]: https://github.com/git-for-windows/build-extra/commit/2e879f7fa5808f5f9cbfdd08ca456209f9ac5f1b
[11]: https://git.github.io/SoC-2019-Ideas/#improve-consistency-of-sequencer-commands
[12]: https://public-inbox.org/git/CABPp-BEdgSHGTkUcg_UDRu50Ag+cCqigmvU4_JaRZRnDpgWcdA@mail.gmail.com/
[13]: https://public-inbox.org/git/xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com/
[14]: https://git.github.io/rev_news/2016/10/19/edition-20/
[15]: https://public-inbox.org/git/cover.1472457609.git.johannes.schindelin@gmx.de/
[16]: https://public-inbox.org/git/20160904201833.21676-1-chriscool@tuxfamily.org/
