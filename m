Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B2D920966
	for <e@80x24.org>; Sun, 26 Mar 2017 03:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbdCZDQh (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 23:16:37 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:32933 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbdCZDQY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 23:16:24 -0400
Received: by mail-lf0-f42.google.com with SMTP id h125so8051738lfe.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 20:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=XOnmQUDx2o5SF4feFdMlTPjNnqX+/oxX3DNly9VFQCo=;
        b=F7ZSoBjoIOp8qll3CJFf/iRph5SGHmhDKW6Am4IGqB5q0WsFWCkb42nj9qwCByTsLb
         1Emwu2Mu+omUG1tGV6rnILKcK5KcslggQ4HCSvyOW6YNSIMbvoIxcyHQ60W7Z+wEmAI6
         lynxPusOZXjt77cdHdi/tE9usAcQ8QeHBOJ29JyW6xJYXMYd4xn3CHPLZkUDIm4N3sjF
         rRsyzOZ0x2ySEtI4HJ0C4kOtDXeRsvDQBQyT+gQEbkkAq5TgF3YmYuC+G1ZkuKUvLeKq
         5z3fPyv40psPF/BAa6NTlMRIyxKjfTV3EhkJl4KUs/4usxYKC72eu+630Q1z6pCFnMJ1
         YONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=XOnmQUDx2o5SF4feFdMlTPjNnqX+/oxX3DNly9VFQCo=;
        b=oTXuXd0Ock+/S5rU9RVTz7czGmu1raM4HCeRkYCAm7Lbqq6mZ0ihxz55Ga43FccokT
         H+Fk6tk/PqGiPZcjl4xH7gC4VQMO9/SzTkwLGE1gkMG+ugo1dkjSyaq/xmsE89cQM7Hc
         BCjoYK/A9RLBgvs9Hrr+Ll+GD5vXrkiD0re3PBTbmK2JgBTmedk1kI2wlBM39DllZ35N
         WVASbdU0lsN63GbYDPgM0an2fX+W7asq29YMYZhH4zThMxz/YkaQQVu7u0VtowpVwfIE
         EKiayjBY1nY0w6xcJ/4O8EYMYmqm3Iwz39VnX4uevAD50xZH2dc/G9axS2DzzJOsVNGa
         fENQ==
X-Gm-Message-State: AFeK/H08bcVjzGnFG0VZkY5kr6OPIumqEGlgE6ReJUlFm3eqwpg92LQnP2RzsBE2FgJfQiEOciDGJC+KLSgOEA==
X-Received: by 10.25.155.132 with SMTP id d126mr8320183lfe.110.1490498141678;
 Sat, 25 Mar 2017 20:15:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.18.73 with HTTP; Sat, 25 Mar 2017 20:15:11 -0700 (PDT)
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Sun, 26 Mar 2017 00:15:11 -0300
Message-ID: <CAEA2_RJEf4vjgcaux8a1KWh1-vxLLmv1--Vjf9wiEQoF+gVDtA@mail.gmail.com>
Subject: [GSoC] Proposal: turn git-add--interactive.perl into a builtin
To:     Git Mailing List <git@vger.kernel.org>
Cc:     johannes.schindelin@gmx.de, Stefan Beller <sbeller@google.com>,
        christian.couder@gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there. First of all, I'd like to thank all of the support up to now
with my microproject :). Here's a first draft of my proposal for
Google Summer of Code '17, based on the "Convert scripts to builtins"
idea. Please let me know what you think.

---

SYNOPSIS
There are many advantages to converting parts of git that are still
scripts to C builtins, among which execution speed, improved
compatibility and code deduplication. This proposal aims to apply this
to git-add--interactive, one of the most useful features of Git.

FEASIBILITY
Many git scripts have attracted attention for being turned into
builtins. There is ongoing work on git-stash
(https://public-inbox.org/git/20170321053135.thk77soxc4irxbqj@sigill.intra.=
peff.net/),
and porting interactive rebase is one of the ideas for this edition of
GSoC. Not as much attention, however, has been directed to
git-add--interactive.

There was only one discussion regarding the feasibility of its porting
(https://public-inbox.org/git/CAP8UFD2PcBsU6=3DFK4OHVrB7E98ycohS_0pYcbCBar=
=3Dof1HLx+Q@mail.gmail.com/).
It resulted in a consensus that doing it would be a task too large =E2=80=
=93
although interesting =E2=80=93 for GSoC 2015 based on the amount of its lin=
es
of code. It is, however, only a few lines larger than
git-rebase--interactive, which has been considered an appropriate
idea. As such, it looks like a possible project for three months of
full-time work.

Aside from the benefits cited above, turning git-add--interactive into
a builtin can reduce Git's dependency on Perl to the point where no
"common" command would continue to rely on it.

PROJECTED TIMELINE
- Prior to May 4
-- Refine my basic knowledge of Perl
-- Craft one or two small patches to some of Git's Perl components
(preferentially to git-add--interactive itself) to improve my
understanding of the language and of how Git's Perl scripts actually
work

- May 4 - May 30
-- Clarify implementation details with my mentor, and work on a more
detailed roadmap for the project
-- Investigate roughly how to replace command invocations from the
script with actual builtin functions; which Git APIs in Perl already
have functional equivalents in C; which parts will require a full
rewrite.

- May 30 - June 30 (start of coding period)
-- Define the architecture of the builtin within git (which
functions/interfaces will it have? where will its code reside?).
-- Implement a small subset of the builtin (to be defined with my
mentor) and glue it into the existing Perl script. Present this as a
first patch to get feedback early regarding the implementation and
avoid piling up mistakes early.
-- Do necessary changes based on this initial review.
-- Have roughly 1/3 of the script's functionality ported to C.

- June 30 - July 28
-- Port the remainder of the script to a builtin.
-- Have a weekly roadmap, sending a part of the patch every 15 days to
the mailing list for review and to avoid massive commits by the end of
GSoC.
-- Apply suggestions from community reviews when possible; if not,
save them for doing toward the end of GSoC (see below).
(Note: due to a previous commitment, during a five-day period of July
I will only be able to work part-time on GSoC. The actual week will be
known over the next weeks.)

- July 28 - August 29
-- By the start of this period, send a patch with the builtin fully
implemented to the mailing list.
-- Fix bugs, test extensively, possibly extend test coverage for
git-add--interactive.
-- Respond to the (predictably big) community feedback regarding the change=
.

I currently work full-time in a payments company (see below), but in
case of being accepted I am willing to quit my job some months early
to dedicate myself fully to GSoC starting June.

BIOGRAPHICAL INFORMATION
My name is Daniel Ferreira and I'm a student from S=C3=A3o Paulo, Brazil. I
was accepted by Stanford University last year and I will start college
this fall. I started coding C about six years ago writing up system
modifications ("tweaks") for jailbroken iPhones. Since then, I have
written/contributed to a couple of open-source projects like an IRC
bot and other assorted things =E2=80=93 all of them tracked on Git
(https://github.com/theiostream). I have also developed a
(closed-source) library in C for interacting with payment terminals in
the company I have worked for over the last two years (Pagar.me).
There, we use Git extensively for managing projects with around 20
people working concurrently.

MICROPROJECT
I have sent a series of patches to complete the microproject of
converting recursive calls to readdir() into calls to dir_iterator.
The most recent version can be found in
https://public-inbox.org/git/1490465551-71056-2-git-send-email-bnmvco@gmail=
.com/T/#u.

Thanks,
-- Daniel.
