Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11DFD20248
	for <e@80x24.org>; Fri, 22 Mar 2019 15:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfCVPMv (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 11:12:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39167 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfCVPMu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 11:12:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so1742475pfo.6
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+8M43QPAClle4HD+wr0reLoyCQmasGzEnJHX9GtUPYI=;
        b=Nd+vUwCDK8/nd0nvIgO9xdgS/vKd9RRIclxH2/4FRVNe3GAYREfwftlnZ2+CAMd8Dl
         /t3/7052/7YeABfMu8X2CLvfM6IcISMPSLiJeNelX00VT6eqFyDNwjMPTROUlKphdImG
         ngjs/UHwoGpUeJFi+rHq4/evExKX2wvuVlfQ+1vap6AnF8ZER5UZDZ5vgywCJe4Setjj
         knFoKRP1Xpm2HpiAC8aN0JTz7c82b1EBtikzjD8nrqWeo5pDbrfPCxK33J4WGZ1USb9h
         ThD4Y+M6VC9w40p2Dkck793WxZCLdRfBpw8sOrPE11YiJcwLiGbJfHnxwkyORaGnjDRS
         8s1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+8M43QPAClle4HD+wr0reLoyCQmasGzEnJHX9GtUPYI=;
        b=rhG+Yj0jiO6d12w+8AfY3AfKWXRlLW+riXEHG4cDznvTKWT0t1EJYUg+OXDik2xjiU
         8T/H08QqLuBWBeViDW1AlA0Q4occTRQOL2OArlYzFHNKvzotk9YTyuWQws8RS2JURGat
         d4nx/1pUN46ASC2a0e0x+AqM0sEmAn0XLKdDLoRKRi6ZgS4Fhs/1kOYcQDuV+uG5ktZP
         eXpvgwTsOLKXZ8/ojoQRbY3RqFZ/2whOgHfjf3ZC9UaHUNJwTsMRb/6akD5hlEgTU2rh
         aM5BgpzhJehd4YCkh5PDTZHhqxnsCbF7BQWcr2GYqG4Yb7PJqiRlUrHM2psPPDNxnZdw
         m9Vg==
X-Gm-Message-State: APjAAAVTrTBRiK4YnkyhkqMpwZhtJCqK3tKs/h4j6tk1sSLZqYqIduXu
        KEmQavYwXgGEA6s8A9IoI3on3yE1Y9Q=
X-Google-Smtp-Source: APXvYqzIamMCmhMWhXGDVWDlPc+HF2jHG3ld9c7iCNZZb/Jkz9xQTGixbf8OQnz6pmTWSVZmfz8iLw==
X-Received: by 2002:a17:902:7610:: with SMTP id k16mr10125877pll.215.1553267569200;
        Fri, 22 Mar 2019 08:12:49 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id e63sm10711527pfe.120.2019.03.22.08.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:12:47 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, Johannes.Schindelin@gmx.de,
        t.gummerer@gmail.com, christian.couder@gmail.com,
        artagnon@gmail.com, s-beyer@gmx.net
Subject: [GSoC][RFC] Proposal: Improve consistency of sequencer commands
Date:   Fri, 22 Mar 2019 20:41:57 +0530
Message-Id: <20190322151157.9550-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey People

I am Rohit Ashiwal and here my first draft of the proposal for the project
titled: `Improve consistency of sequencer commands' this summer. I need your
feedback and more than that I need help to improve the timeline of this
proposal since it looks very weak. Basically, it lacks the "how" component
as I don't know much about the codebase in detail.

Thanks
Rohit

PS: Point one is missing in the timeline from the ideas page[0], can someone
    explain what exactly it wants?


######################################################################################
                  Improve consistency of sequencer commands
######################################################################################


About Me
========

Personal Information
---------------+-----------------------------------------------------------------------
Name           |     Rohit Ashiwal
Major          |     Computer Science and Engineering
E-mail         |     rohit.ashiwal265@gmail.com
IRC            |     __rohit
Skype          |     rashiwal
Ph no          |     [ ph_no ]
Github         |     r1walz
Linkedin       |     rohit-ashiwal
Address        |     [                             Address                            ]
Postal Code    |     [ postal_code ]
Time Zone      |     IST (UTC +0530)
---------------+-----------------------------------------------------------------------


Background
----------
I am a sophomore at the Indian Institute of Technology Roorkee[1], pursuing
my bachelor's degree in Computer Science and Engineering. I was introduced
to programming at a very early stage of my life. Since then, Ive been trying
out new technologies by taking up various projects and participating in contests.
I am passionate about system software development and competitive programming,
and I also actively contribute to open-source projects. At college, I joined
the Mobile Development Group [MDG](2), IIT Roorkee - a student group that fosters
mobile development within the campus. I have been an active part of the Git
community since February of this year, contributing to git-for-windows.


Dev-Env
-------
I am fluent in C/C++, Java and Shell Scripting, otherwise, I can also program
in Python, JavaScript. I use both Ubuntu 18.04 and Windows 10 x64 on my laptop.
I prefer Linux for development unless the work is specific to Windows.
VCS: 	git
Editor: VS Code with gdb integrated


Contributions to Open Source
============================
My contributions to open source have helped me gain experience in understanding
the flow of any pre-written code at a rapid pace and enabled me to edit/add new
features.

List of Contributions at Git:
-----------------------------
Status: Merge in next revision
git/git:
[Micro](3): Use helper functions in test script.

Status: Merged
git-for-windows/git:
[#2077](4): [FIX] git-archive error, gzip -cn : command not found.

Status: Merged
git-for-windows/build-extra:
[#235](5): installer: Fix version of installer and installed file.


The Project: `Improve consistency of sequencer commands'
========================================================

Overview
--------
git-sequencer was introduced by Stephan Beyer <s-beyer@gmx.net> as his
GSoC 2008 project[6]. It executed a sequence of git instructions to  <HEAD>
or <branch> and the sequence was given by a <file> or through stdin. The
git-sequencer wants to become the common backend for git-am, git-rebase
and other git commands. The project was continued by Ramkumar <artagnon@gmail.com>
in 2011[7], converting it to a builtin and extending its domain to git-cherry-pick.
As of now, there are still some inconsistencies among these commands, e.g.,
there is no `--skip` flag in `git-cherry-pick` while one exists for `git-rebase`.
This project aims to remove inconsistencies in how the command line options are
handled.


Points to work on:
------------------
    - Add `git cherry-pick --skip` 
    - Implement flags that am-based rebases support, but not interactive
	  or merge based, in interactive/merge based rebases
    - [Bonus] Deprecate am-based rebases
    - [Bonus] Make a flag to allow rebase to rewrite commit messages that
	  refer to older commits that were also rebased


Proposed Timeline
-----------------
    + Community Bonding (May 6th - May 26th):
        - Introduction to community
        - Get familiar with the workflow
        - Study and understand the workflow and implementation of the project in detail

    + Phase 1  (May 27th - June 23rd):
        - Start with implementing `git cherry-pick --skip`
        - Write new tests for the just introduced flag(s)
        - Analyse the requirements and differences of am-based and other rebases flags

    + Phase 2  (June 24th - July 21st):
        - Introduce flags of am-based rebases to other kinds.
        - Add tests for the same.

    + Phase 3  (July 22th - August 19th):
        - Act on [Bonus] features
        - Documentation
        - Clean up tasks


Relevant Work
=============
Dscho and I had a talk on how a non-am backend should implement `git rebase
--whitespace=fix`, which he warned may become a large project (as it turns
out it is a sub-task in one of the proposed ideas[0]), we were trying to
integrate this on git-for-windows first.
Keeping warning in mind, I discussed this project with Rafael and he suggested
(with a little bit uncertainty in mind) that I should work on implementing
a git-diff flag that generates a patch that when applied, will remove whitespace
errors which I am currently working on.


Availability
============
My vacations start on 7 May and end on 15 July. The official GSoC period
is from 6 May to 19 August. I can easily devote 40-45 hours a week until
my college reopens and 35-40 hours per week after that. Im also free on
the weekends and I intend to complete most of the work before my college
reopens.

Other than this project, I have no commitments/vacations planned for the
summer. I shall keep my status posted to all the community members on a
weekly basis and maintain transparency in the project.


After GSoC
==========
Even after the Google Summer of Code, I plan on continuing my contributions
to this organization, by adding to my project  and working on open issues
or feature requests. With the community growing continuously, I feel
responsible for all the projects Im a part of. Having picked up a lot of
developing skills, my major focus would be to develop mentorship skills so
that I can give back to this community by helping other people navigate
around and reviewing their contributions.


[0]: https://git.github.io/SoC-2019-Ideas/
[1]: https://www.iitr.ac.in/
[2]: http://mdg.iitr.ac.in/
[3]: https://public-inbox.org/git/20190303122842.30380-1-rohit.ashiwal265@gmail.com/
[4]: https://github.com/git-for-windows/git/pull/2077
[5]: https://github.com/git-for-windows/build-extra/pull/235
[6]: https://public-inbox.org/git/20080607220101.GM31040@leksak.fem-net/
[7]: https://public-inbox.org/git/20110403172054.GA10220@kytes/
