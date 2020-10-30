Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E3AC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 10:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51932221FA
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 10:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSFKSutv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgJ3KWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 06:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgJ3KWy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 06:22:54 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8277C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 03:22:53 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l62so499531oig.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 03:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ruJDifBeCgcWVhBooNevN/R1Q2VnHXeFfsRCvM4NTSY=;
        b=YSFKSutvv1Jr2aRJ89/lh61KCU5GoGZaDDTFiUioBFecCd0QyYJie1jVtmdqcWGfMI
         mUTi7xaZWtpO7WCXYtFQUXTN6u+FJdQMmusnjOiXkyDhV9QCZr6+yh7Hwrej9EPuKH/h
         VgAWA6KCpfIoPc/l5WltRI8jtrp6Rj0LfCcnLbFarX7w74Rtj/PEy2pLGgpwTblAduFy
         v63ZNohZt6LesnRmz6hroeL+cpvlCpWWtlNLhrgTlW21i7ySPVEKzMIf1LUJct7XOHlp
         0ZeMUCaQVzf7Yu5q9y2GczuLtIMa6aisszfTXPoaZhxIPKgiNAuNe38Mc4X+bQBdS5Dg
         m/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ruJDifBeCgcWVhBooNevN/R1Q2VnHXeFfsRCvM4NTSY=;
        b=eL7bK7t0LG5BnId5fefe95Eqao+w/2yCg0JQTDeoka/wYAcxto2LoqWkD4CRNVFKZ8
         xbF8Ln15qZrMBze+T8kErTxPDp4YSwdlnA29jP8dksVRrBXH0QG3xWoHCao6XX5Spuib
         vRm6M8H3g2wO6pifL+z08YQs1/gLjKH4IOfQv1FUQO2axGVLeUHdFRG6boj287/17T0u
         nhaUeWoNsQcDE1qPb/++7J3KoZFeC6dXFv4s4czVbTv7cHIz22P9YMJn+VL1FPy3dual
         3ViaHHTBAmORRWSyx+W67lJhM4r/9gSvytEgonUk8cqC8ovUE1LZ9Ud5eGUezUEpgjmK
         /BNA==
X-Gm-Message-State: AOAM530wyAfGb1XvvTKoDk0W1sXW09GDLlSpYylTg9wqeLPM+j4vKpNx
        Rp32k3BXOjl9Cv2SrGjiy7T1U4ijDSEwIvX3j/IzyopLHYknPA==
X-Google-Smtp-Source: ABdhPJyHqhXMKwS1LT4J1ZtcUt2OSOsMchTZYSb4/URMSPHP91P4bM+plcE0fy4DjteAJQR7baAcmZ58F47xenCXQjg=
X-Received: by 2002:aca:5d43:: with SMTP id r64mr1048437oib.163.1604053372773;
 Fri, 30 Oct 2020 03:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAAB2g-GYGmatT_TP7avySFifbHQ799gHJCQEv39ToOrcqcHPJw@mail.gmail.com>
 <CAAB2g-EWBSoytn-aF2LOuxBYZLmSURzwkf1-yM50ukOpo9TDrA@mail.gmail.com>
In-Reply-To: <CAAB2g-EWBSoytn-aF2LOuxBYZLmSURzwkf1-yM50ukOpo9TDrA@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 30 Oct 2020 15:52:41 +0530
Message-ID: <CAPSFM5exPpc5JW0aXY+EYDMe62XCUPa9eOup=WY6xnUH3uh-eg@mail.gmail.com>
Subject: [Outreachy][Proposal] : Improve droping and rewording commits in Git
 interactive rebase
To:     git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Everyone!

This is the initial version of my proposal. Although I realized that,
I am quite late for sending the proposal but I still hope to have
reviews from the community.
I also thank Phillip for helping me in understanding more about the
project details [1] .
I have made the timelines accordingly, but still I think I am lacking
in it as I don't know much about the codebase in detail . Need some
guidance for the timeline .
Also, there's a column for community-specific questions in the final
application. Is there anything specific that I have to fill in that part ?

Thanks and Regards ,
Charvi
[1] https://lore.kernel.org/git/CAPSFM5e9tXx_LuwNK+e1wOjaHb6kiTCEt3WeL851KA=
bTPNsEow@mail.gmail.com/

---------------------------------------------------------------------------=
----
Link to docs : https://docs.google.com/document/d/19LYskEBWFp2q2Yi2hfibbxT5=
kt6czLZk_ZCajkHQ4QQ/edit?usp=3Dsharing
---------------------------------------------------------------------------=
----
## Project

Improve droping and rewording commits in Git interactive rebase

## Contact Information

Name                  :   Charvi Mendiratta
E-mail                 :   charvi077@gmail.com
IRC                     :   charvi077 on #git or #git-devel
Linkedin              :   charvi077 [https://www.linkedin.com/in/charvi077/=
]
Github                 :   charvi-077 [https://github.com/charvi-077]
Time Zone           :   IST (UTC +0530)

## Background

I am Charvi Mendiratta, recently graduated from Panjab University,
India in Electronics and Communication. I like to learn and explore
new things in my day to day life. I have worked mostly on Robotics
Software development, college projects and have internship experience.
I=E2=80=99ve been writing code in C/C++ and Python. I have worked a bit on
shell scripts also during my semester project. Besides this I always
prefer to make my work and projects open source on github, contribute
to other projects and to promote open source culture.

## Contribution to Git

Contributing to git helped me a lot understanding about the workflow,
getting familiar with the mailing list, overview of writing test
scripts and  about the git commands itself. I will keep contributing
to Git, solving more issues or through review discussions.

#### Microproject :

Modernize the test script t7201,t7101,t7102
List: https://lore.kernel.org/git/20201015175709.20121-1-charvi077@gmail.co=
m/

#### Status :

cm/t7xxx-cleanup (2020-10-22) 6 commits
(merged to 'next' on 2020-10-26 at 8b58e54942)

## Project Overview

Git commit commands include the two options for the use with rebase
--autosquash, '--fixup=3D<commit>', that creates the commit message with
a prefix of 'fixup!' with the subject line from the specific commit
and '--squash=3D<commit>' . At the same time, to reword the commit
message one has to deal with fixups and editing a todo list upon
rebase --autosquash to reword the commit message .
Implementing the reword! commit will make it easy and give the options
to either reword the old commit message or to change the both content
and message of the old commit at the same time.

Next, the current  way of marking the commit to be excluded in
subsequent rebase --autosquash is git revert -n <commit> && git commit
-m 'drop!' '$(git show -s --oneline <commit>)'. Implementing the drop!
commit will make it easy to drop the changes and the effect of drop
commit can be reversed for any commit built on top of the drop! commit
before rebase.

## Discussions and points to work on

The project is mentioned by Dscho in the issue
[https://github.com/gitgitgadget/git/issues/259] and further discussed
briefly
[https://public-inbox.org/git/alpine.DEB.2.21.1.1710151754070.40514@virtual=
box/].
Also there is discussion
[https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com=
/]
regarding the implementation of the reword! commit. Apart from this, I
also discussed with the Phillip Wood regarding the project
[https://lore.kernel.org/git/CAPSFM5e9tXx_LuwNK+e1wOjaHb6kiTCEt3WeL851KAbTP=
NsEow@mail.gmail.com/]

Considering all the past threads and discussions, I summed up with the
following points to work on :

#### Adding reword command  in the rebase

In the past patches of Phillip Wood=E2=80=99s work
[https://github.com/phillipwood/git/commits/wip/rebase-amend] , the
'reword!' is implemented as 'amend!' in git rebase .

- Need to figure out the implementation of the reword in the rebase.
As of  now the possible options are :

To avoid the reword command and instead use the 'fixup -C' as
discussed with Phillip
[https://lore.kernel.org/git/29fc2f59-1cca-a3db-5586-bbd7b2e4806d@gmail.com=
/].

Otherwise if we are using it then, also the name 'reword' must be
changed to 'revise' or 'amend' or may be other, because the content
and commit message both are changing in the reword! commit.

- Implement the way to handle empty commits in the git rebase.

#### Implementation of reword! Commit

- Figure out the user interface for the --reword.
As of now as mentioned by Phillip
[https://lore.kernel.org/git/966470c3-8883-faf1-629f-89fc8d18b339@gmail.com=
/],
there is the possible way of implementing the reword! Commit as
'--fixup=3D reword/amend:commit'.

- Look into the present codebase of --fixup commit and implement the
reword! commit option in it.

#### Implementation of drop! commit and adding drop command in rebase

- Figure out the way to add drop commit, as of now one of possible
ways to add it is 'git revert --drop' also looking for its
implementation in Git rebase .

- Look for its related codebase and work on its implementation .

#### Tests and Documentation

- Write the test scripts of every codebase I add and also complete its
documentation following the proper guidelines .

## Project Timeline

#### Nov 23 - Dec 1 (Before internship officially starts)

- Interact with git community regarding the project for any suggestion
- Get familiar with the Coding Guidelines, test scripts and
documentation  instructions to be followed
- Discuss with mentors regarding the prerequisites that are being
essential to be completed or tested for the smooth flow of the project
- Understand and implement the Phillip=E2=80=99s work [
https://github.com/phillipwood/git/commits/wip/rebase-amend]

#### Dec 1 - Dec 11 (Phase 1)

- Figure out and discuss with the community, regarding the
implementation of --reword in the git interactive rebase
- Make changes in Phillips Wood=E2=80=99s work, as per the decided UI for
--reword in the rebase
- Implement the way to handle empty commits in the rebase
- Complete the documentation of the above work


#### Dec 12 - Jan 12 (Phase 2)

- Figure out and discuss with the community, regarding the user
interface for the git reword! commit
- Discuss with mentors regarding the related codebase to be changed
- Implement the reword! commit
- Write the test scripts for the code base added
- Add the documentation of the reword! commit

#### Jan 12 - February 16 (Phase 3)

- Figure out and discuss with the community, regarding the user
interface for the git drop! commit and also for the implementation of
drop in git interactive rebase
- Discuss with mentors regarding the related codebase to be changed
- Implement drop! commit and write the test cases for the added codebase
- Addition of the drop! commit
- Implement the drop commit in the rebase
- Write the test scripts for the drop command code that is added

#### February 16 - March 2 (Buffer time)

- Check for the major issues if any leftovers are in the project.
- Complete the documentation of drop command in rebase

## Contribution process and Interaction with the mentors

I will keep committing changes on my Github fork
[https://github.com/charvi-077/git] and finally post a patch series on
the Mailing List. I will make sure to interact with the community as
well as mentors regularly and will take feedback from them after every
phase mentioned in the project timeline.
Also, I aim to  weekly update my progress report on the blog and share
it on the List. Apart from that I will document anything new I learn,
its related references and will share it on my blog.

## Availability

I have no commitments planned for the Internship period. So, I can
easily devote 40-45 hours a week on this project.

## After Outreachy

Even after completion of Outreachy, I plan on continuing my
contribution to Git, by solving more issues or review discussions. I
vision to do more improvements to the git interactive rebase or
writing its wrapper as pointed out by Phillip
[https://lore.kernel.org/git/966470c3-8883-faf1-629f-89fc8d18b339@gmail.com=
/].

Besides this, I always like the way the Open Source community works
and I aim to get involved in the same way, develop mentorship skills
as well as the ability to help each other and try to give back to the
community by mentoring and guiding others.
