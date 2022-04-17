Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435F0C433F5
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 18:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiDQSTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Apr 2022 14:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiDQSTo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Apr 2022 14:19:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB875F9B
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 11:17:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p10so10771588plf.9
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language:content-transfer-encoding;
        bh=rFokgiWPLy0VdOO+/97Sx3LJYk1oZ3AliFoH9KlMprc=;
        b=lWqYBc1hrT3Prb6kngUV6ELlSJVks8IfrIU+lVAD7/4Ogw2VUc60es67fUrcNA0Jea
         oiD2Lrsswjwgxi4SF5CNIeogGbO9rxWHLg+iFnrGIB8osfoP/Nf/9bpMZbaTX6wf1/Gl
         dOGu/IphxKRgp0Bn6hVv55nJW4SDHVYw5z2r7tAg0OK3NsaAh/ZqD/RvfciE3+NQMZLJ
         6FqRC176bOPysJpZpTdu9cZA5jlH4m02LTmoju3ZcCsCvGZLD/XTtdi5R8/XGd8Xmu1r
         tA1ZbwLsMqu01/cZ1PnaRpBmxsYb5f1DJpL9VrzbHRYmGbQZTVAOZaRKWDV3cqD11qfT
         c3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:content-transfer-encoding;
        bh=rFokgiWPLy0VdOO+/97Sx3LJYk1oZ3AliFoH9KlMprc=;
        b=WSgPzMXsRd6hCTaiN6u/1JaGhwKiLwNLrcRbKWU6u+/FKymLE+6uynOnYDb+asQNpF
         ITiFWf5Uy9ZE9rOzCNMQzuxMf7HiogBGzlhXSP8lXoqMHYmADH4nimxz3UTlsh8C3KDY
         E7Ic8BZjieGPaWerisk5nY3O2aOmrtfME2HqR0WwTwMpkXMEqiXK5ZxwfqQG2cRTXQTP
         K4Zb6Wgy2PsbINPPZSw0vmdBYrBSYsUpACA0xkSCjcqQinjSUT5rc7MzY+f3KKXGjSTH
         MvDSgsKSV/fFLc6OuYA3CQwb6v8ws6x6MCSvLflRBgal9LR+PEtFRy8gbQrejl8gPjGq
         dvBQ==
X-Gm-Message-State: AOAM533HgSAvK9lgORXO49D94wQfWQaZD9nrbnqVaKd4wNn/XPhj6K94
        j01LfPcbS2ZdjGW7bCHnQz5SjxRUyMQQZA==
X-Google-Smtp-Source: ABdhPJzkwtnwgB28BJFr3GO7bFNsvMBbv5Mc6Rq2RbL5GekxRl7+Ef80gY32kd/UddWNp06I6D0EDQ==
X-Received: by 2002:a17:90a:af8f:b0:1ca:7bce:ce3b with SMTP id w15-20020a17090aaf8f00b001ca7bcece3bmr14700250pjq.224.1650219426468;
        Sun, 17 Apr 2022 11:17:06 -0700 (PDT)
Received: from ?IPV6:2405:201:a800:4df9:5194:c9b1:2d1f:598e? ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id 21-20020a630115000000b00382a0895661sm10331645pgb.11.2022.04.17.11.17.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 11:17:06 -0700 (PDT)
Message-ID: <7f2e9c1b-1d01-00af-810f-c81dd38c12ad@gmail.com>
Date:   Sun, 17 Apr 2022 23:47:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Jaydeep Das <jaydeepjd.8914@gmail.com>
Subject: [GSoC][RFC][Proposal] Unify ref filters in pretty.{c,h}
To:     Git Mailing List <git@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Sorry for being late in submitting the proposal. My end semester
examinations were over just yesterday so I somehow made this proposal
during the exam time.

===============
View in Google Docs: 
https://docs.google.com/document/d/1qq-Xze6dMGMSx3rPHD0VEc4f0a87KnHgbka1Dzpf8sc/edit?usp=sharing
===============
Proposal
===============

Unify ref-filters with other pretty formats.

Name		:	Jaydeep Prapanch Das
Email		:	jaydeepjd.8914@gmail.com
Contact		:	+91 6026139802
Github		:	JDeepD(https://github.com/JDeepD)
Linkedin	:	https://www.linkedin.com/in/jdeepd
Course		:	Computer Science and Engineering, 2025
Time Zone	:	IST(+5:30)

## About me:

I am a first year undergraduate at National Institute of Technology, 
Silchar  pursuing B.Tech in Computer Science and Engineering. My 
interests include FOSS development, Data Science and Robotics. I have 
been writing Python, C and shell scripts for about 3 years now. Apart 
from that I also blog[1] whenever I find an interesting topic to blog 
about. During the GSoC period I also plan to blog about the new things 
in git that I hope to learn.

[1]: https://jdeep.me/

## Micro-Project:

I am still a newbie in git development and made my first (minor) 
contribution in Feb 2022 [1]. This was a patch I made just to get 
familiar with the patching and sending patches to the mailing list. For 
my micro project, I worked on adding diff driver for the Kotlin language.[2]
The main objective was to make an xfuncname regex which matches keywords 
in Kotlin syntax so that they are considered as a single token
whenever diffs are generated. Along with that, a word_regex regex pattern
was also needed so that variable names, compound operators etc are not
broken into individual tokens by git diff when there is a change in them.
For ex,  if a == b is changed to  a != b , then the diff should show 
that entire
`==` token is replaced with the token `!=`. While working on this micro 
project, I learned a lot about the contribution and review workflow of 
git. It took 7 patches to incorporate all the reviews and suggestions so 
yeah, It did require some patience :-).


Minor patch(merged in master)
[1]: 
https://public-inbox.org/git/20220208092339.651761-2-jaydeepjd.8914@gmail.com/

Micro Project(merged in master)
[2]: 
https://public-inbox.org/git/20220312044832.718356-1-jaydeepjd.8914@gmail.com/


## Proposal:

Git has an old problem of duplicated implementations of some logic. For 
example, Git has at least 4 implementations to format commands for 
different commands. Previously, Olga Telezhnaya[1] and Hariom Verma[2] 
worked on this and eliminated most of the duplicate logic. But still, 
there are still some things left to do. Current task is to reuse 
ref-filter logic in pretty.

[1]: https://github.com/telezhnaya/git/commits/format
[2]: 
https://public-inbox.org/git/pull.707.git.1597841551.gitgitgadget@gmail.com/

## Previous Work:
Previous GSoC mentee Hariom Verma worked on this[1]. He worked on 
removing duplicate logic and reuse ref-filter’s logic in pretty. 
However, as per his report, some tasks are still left to do.

-> Around 30% log related tests are failing
-> Teach pretty-lib.{c,h} to handle incorrect formatting option
-> Email/MBoxed commit format needs work

[1]: https://harry-hov.github.io/blogs/posts/the-final-report

## GSoC Planning:
The main objective would be to start from where Hariom left and make 
further improvements in the related field if time permits.

Currently, because my end sems were just over yesterday, I am yet to do 
a full reading/understanding of the pretty and ref-filter code. I plan 
to first read the documentation of git-log and study the pretty formats 
and their implementation. Next would be to read the code and understand 
how it is working under the hood and try to find possible bugs and edge 
cases where the tests fail. I have already gone through the various 
must-read documentations suggested in the Hacking git[1] section of the 
git-scm website:

My First Contribution Tutorial[2]
My First Object Walk[3]

Apart from that, I also have a decent understanding of git internals, 
objects and porcelain commands from the Git Internals[4] documentation.
I want to start as early as possible since my main motivation for 
contributing to git is to improve something that millions of people, 
including me, use everyday in their day to day life.


[1]: https://git.github.io/Hacking-Git/
[2]: http://git-scm.com/docs/MyFirstContribution
[3]: 
https://github.com/git/git/blob/master/Documentation/MyFirstObjectWalk.txt
[4]: https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain



Estimated Timeline:

-> April 20 - May 14
Read the docs and go through the codebase. Make small code contribution 
if possible.

-> May 14 - May 21
Inactive Period
The covid lockdown is almost lifted and I would need to report back 
offline to college. So I would probably be busy for a week to get 
settled there.

-> May 22 - June 5
Community Bonding Period
Get in touch with the possible mentors(Christian Couder and Hariom 
Verma) and discuss the possible solutions.

-> June 6 - June 11
Inactive Period
Will be inactive for the week due to mid semester examinations

-> June 11 - July 24
Coding Phase 1
Fix the test cases that are failing
Eliminate more duplicate logic in pretty.{c,h}.
Update the documentation

July 25 - August 20
Coding Phase 2 (part 1)
Teach pretty.{c,h} to handle incorrect formatting options.
Make improvements in email/mboxed commit formats.
Update documentation


August 22 - August 27
Inactive Period
Will be inactive for the week due to end semester examinations.

August 27 - September 19
Coding Phase 2 (part 2)
Start where it left off in part 1 of coding phase 2.

During the coding phase 1, I would be able to dedicate 4 - 5 hours every 
working day. On weekends, I could dedicate the entire day or take a 
break depending upon the number of assignments I get. During the coding 
phase 2 part 1, I will be able to dedicate 4 - 5 hours easily except the 
hours may decrease some days before the end semester examinations.

## Blogging during the contribution period:
I plan to write bi monthly/monthly blogs during the contribution period 
which I would post on my personal website[1]. I would write about my 
progress and the new things that I will learn when I contribute to git.
I also plan to make a complete video tutorial after the GSoC period 
about the contribution workflow in the git codebase since I believe it 
would have greatly helped newcomers (like me) to get started quickly.

[1]: https://jdeep.me/posts/

## Post GSoC:
I would love to explore the git codebase and I am particularly 
interested in the sparse index feature of git. I would also love to 
co-mentor someone someday when I get more experience in the codebase. I 
have also noticed that there are some lesser known/underrated features 
of git ( like partial clones, sparse checkout, worktrees) and I plan to 
make video tutorials on these topics too.

## Closing Remarks:
As a whole, I feel it would be a great learning experience for me as 
this would be the first “really” big open source project where I would 
be contributing to. I am really excited about being a part of the git 
community.

Eagerly waiting for review.

Thanks,
Jaydeep
