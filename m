Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5E320248
	for <e@80x24.org>; Fri, 29 Mar 2019 22:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfC2Wd1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 18:33:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46636 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfC2Wd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 18:33:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so1841682pgv.13
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0sonw0e0ofxRseGsVa/aRXFSwOmfWB1W86GlI/z6uEk=;
        b=F8ZDiyhfK/D8ZmCT6r0X+6Q2CywP3cnXJu7uLns3ZURIe/36cf76sbnDyCq5ERf940
         nO2Yzc8G4pWEDsW4pNN2edbq9FxXfqNqjxyFIGD9vxavKEn2433yaiIOLykLUVilO1wt
         YSdj1QHSZVh3x13FXk41yDc2Am9V/edWwk/sfErEyldYOr4jkKFbTt6rKw9881LyLM/C
         4XdJ2BsP50+6cs0t1P9qktHH77fsk2Njo+QrISAoz8Xlc2oa7StloYWja6Myh2ei9bEF
         4oyCzldmuOFE6ncW+0dWsLjM9GC1eGrq7w20mbE0tYpY7/N5ewspW9y7ay0G9p2z1R6w
         PVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0sonw0e0ofxRseGsVa/aRXFSwOmfWB1W86GlI/z6uEk=;
        b=pEGY1mgQNTQXUkkttefC3AXIlNuWYbmTf+feOiAsaPSRD9mL5ymd7i2MZCduD4OjTt
         oWrldf7qLV7QSWIffKvS0ivk9IG9c7fd2zBg4J9NAtbtZdgb4mUdGDtZpMESO7vdbxW9
         X42Pj9P/N4cFOSDSni7HgxWx3uXmvRBmhVkZEgf3CoFt03cQg4uqsPOiiga0l6rpnkqm
         iJF8UgdZEXGKfuk77CK2nAp5pDL0ZffBd4hctAPv1IPV0L7m215KUOb7F7Th/PTzqy2E
         zHpfIBuUkM0dHF31V4qGhzKdoR+SDobPxeEX9J3AMosx2f1movF0QRqAfciv3LVPC0kX
         8vxw==
X-Gm-Message-State: APjAAAU310GP9pvGP9porwU4Vv+JcYAzThL1yHStpPb74U+zwkTbtsxU
        Don4GLYXNJJWixbECmZAHj0=
X-Google-Smtp-Source: APXvYqz3apYGHBFxFkaY/zENymHJXjmHMfi3CZVZJSNsaWFgwJfeJtYfiXlR6ETGz299b1mn2FJ0dw==
X-Received: by 2002:a62:1881:: with SMTP id 123mr49169932pfy.25.1553898804518;
        Fri, 29 Mar 2019 15:33:24 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id o68sm8487233pfi.140.2019.03.29.15.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 15:33:23 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, artagnon@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, newren@gmail.com,
        s-beyer@gmx.net, t.gummerer@gmail.com, alban.gruin@gmail.com,
        rafa.almas@gmail.com
Subject: [GSoC][RFC v2] Improve consistency of sequencer commands
Date:   Sat, 30 Mar 2019 04:02:28 +0530
Message-Id: <20190329223228.4924-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hiya

This is the v2 of the draft proposal[1]. I've added some details to the proposal,
it talks more about what to implement instead of how. It is still incomplete.

I'm currently adding more to the overview section, where I'll document the work
done by Dscho and Alban. After that I'll find files that will be changed while
implementing rest of the flags, finally add the basic control and/or data flow
of the 'how' part.

Thanks
Rohit

[1]: https://gist.github.com/r1walz/5588d11065d5231ee451c0136400610e
https://public-inbox.org/git/20190322151157.9550-1-rohit.ashiwal265@gmail.com/

------------------------------- >8 -------------------------------------

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

Repo                              |        Status           |                   Title
-|-|-
[git/git][8]                      | Merged in 'next' branch | [Micro][3]**:** Use helper functions in test script
[git-for-windows/git][9]          | Merged and released     | [#2077][4]**:** [FIX] git-archive error, gzip -cn : command not found.
[git-for-windows/build-extra][10] | Merged                  | [#235][5]**:** installer: Fix version of installer and installed file.


## The Project

### _Improve consistency of sequencer commands_

#### Overview

Stephan Beyer \<s-beyer@gmx.net> tried to introduce git-sequencer as his GSoC
2008 [project][6] which executed a sequence of git instructions to  \<HEAD> or
\<branch> and the sequence was given by a \<file> or through `stdin`. The
git-sequencer wants to become the common backend for git-am, git-rebase and
other git commands. Unfortunately, most of the code did not get merged during
the SoC period but he continued his contributions to the project along with
Christian Couder \<chriscool@tuxfamily.org> and then mentor Daniel Barkalow
\<barkalow@iabervon.org>.

The project was continued by Ramkumar Ramachandra \<artagnon@gmail.com> in
[2011][7], converting it to a builtin and extending its domain to
git-cherry-pick.

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
    * --signoff
    * --whitespace=...
    * -C
```
4. Test and Documentation
5. `[Bonus]` Make a flag to allow rebase to rewrite commit messages that
  refer to older commits that were also rebased
6. `[Bonus]` Deprecate am-based rebases


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
    5. `[Bonus]` --signoff

    **_Files changed_ :** [currently searching for files to be changed]

4. Testing and Documentation will go in sync with implementation. I intend to
follow `Test Driven Development` but let's see how it turns out.

5. `[Bonus]` As familiarity with the code increases, I might be able to implement
the feature of rewriting commits in time.

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
