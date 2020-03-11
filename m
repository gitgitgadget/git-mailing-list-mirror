Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80529C2BB1D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 21:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3762C2074C
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 21:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbBtN/6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgCKV1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:27:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33185 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgCKV1n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 17:27:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id z65so4775579ede.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 14:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BHvGHW80B3PRtDUeHvARVPSb2+TQLM7TtkjRQAsLT5U=;
        b=FbBtN/6nEDTI32WG9r2778aQtFdU3/tjWAUaoJsPX919r8D9yYPE6ms2Bz7wPnMmKs
         xsD/Jrzw9H0Ot5uQWz9qrZn4dF8E11igoT51cnRTJDOqiTC7aZti2s7pjvnG1YKj72wW
         UOZTaEIO6WiwMUydBwUQ5rH/75l/I9jB2PCJ5y96JrsOqrhxF4ieGleGV/YPFzKCQaIj
         LulQdCpHP2Pw3kVQfHUXUCU4ceI4ly5BV5Gqk3h3km2NK33F6JUiWcqifryyifCl/BQy
         4JaC248WnEtjV5tnWFzGtzfDDlLubNpuiJnGm8Hfp0jLFGaYIEnTfDP9+ALa9FHXwyAF
         5clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BHvGHW80B3PRtDUeHvARVPSb2+TQLM7TtkjRQAsLT5U=;
        b=NZXu/R6HBPWsFurC4fRQ5x4R6bIv6lNedNLe7NDi1b52Ecit2OCzw/E3X8fAtHAg79
         CxDOdsmfJ51uspwdh6jOzMysKlY9ZfjlcNUXRs927lj8yq/MTBXZMuIpOMmYjEOY0bPC
         tPssK6ZZXxhETBihN2iDhSpYqAWzVG/sNC0BXz3zPdwUWmNcm9Mu2bznx5O96cExVAtB
         8q+KBLS/KR8Ln4izxblFpeZkCvlAi6U5RAmEqMXAa8VEWR3TUPCZLJW5413AD9Xvuuey
         WpwLhFeP5d7HK3k45an8ia42ye9HCkKbmTOWHMrdzn3k+RWMOJBggCNcxs+gYzM+z7vl
         2VFQ==
X-Gm-Message-State: ANhLgQ1LwfCkGEDzvvX318pKwyfSed4lkWixhCPoUHXN5MsZrbqGa/1f
        TTNH4Vk0TpQByGMiMWKYgkjhi6tKwbLtbsrSv/U=
X-Google-Smtp-Source: ADFU+vtDepRN6w8+eFb+E3Oop9EAKF+BWwZCSkFlkyDzZwAIfNEitwbQd/pCCoHPD8jnowT59l6+40HOEMRpKK1Y9H0=
X-Received: by 2002:a50:f70c:: with SMTP id g12mr4955584edn.142.1583962060500;
 Wed, 11 Mar 2020 14:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200309131027.18994-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200309131027.18994-1-shouryashukla.oo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 11 Mar 2020 22:27:29 +0100
Message-ID: <CAP8UFD3gWbhyZX8t4e8hq8RW7Jy4802mDNQheRo891Th=q6HUQ@mail.gmail.com>
Subject: Re: [GSoC][RFC][Proposal v2] Convert submodule to builtin
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Heba Waly <heba.waly@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Mon, Mar 9, 2020 at 2:10 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:

> Changes made:
>         1. Improve project timeline
>         2. Separate 'Overview' into 'Outline' and 'Previous work'
>         3. Corrected grammatical errors and spelling mistakes
>         4. Provided some links to relevant things asked for.

Thanks for the improvements!

> # Convert submodule to builtin
>
> ## Contact Information
> --------------------
>
> Name          : Shourya Shukla
> Major         : Computer Science and Engineering
> E-mail        : shouryashukla.oo@gmail.com
> IRC           : rasengan_chidori on #git & #git-devel
> Mobile no     : <<mobile no>>
> GitHub        : periperidip
> Linkedin      : shuklashourya
> StackOverflow : rasengan__
> Address       : <<address>>
> Time Zone     : IST (UTC +0530)
>
>
> ## Background
>
> I am Shourya Shukla, a sophomore in Computer Science and Engineering at t=
he Indian Institute of Technology Roorkee[https://www.iitr.ac.in/].
> I was introduced to programming at a young age and I have been trying to =
learn new concepts everyday since. My
> interests include modern mobile networks, Internet of Things and system s=
oftware development. I have been working
> on a research project[https://github.com/periperidip/UAV-based-wireless-n=
etworks-2] which involves providing cellular network
> access to users in a disaster-struck area via drones. I love low-level co=
ding and FLOSS as well. I have been an active part of
> the Git community since January of this year, contributing to Git.

Ok.

> ## Work Envinronment

Maybe "Environment".

> I am fluent in C/C++, Java and Shell script, and have an understanding of=
 Python
> as well. I use Git as my VCS and Visual Studio Code with integrated GDB a=
s my
> primary code editor and Ubuntu 19.10 as my primary Operating System unles=
s the
> work specifically needs Windows.
>
>
> ## Contributions to Git
>
> Contributing to Git helped me understand a lot about how modern & robust =
software
> work as well as how real world development takes place. I plan on contrib=
uting even
> more to Git and make my contributions count. As of now, my contributions =
at Git are:
>
> ---------------
> status: merged
> git/git:
> [Microproject]: Modernise tests and use helper functions in test script.
> GitHub: https://github.com/git/git/commit/c513a958b69090c02ad422b0cd46220=
09bb4b9f5
> List: https://github.com/git/git/commit/c513a958b69090c02ad422b0cd4622009=
bb4b9f5

Both links are the same.

> ## The Project: Convert submodule to builtin
>
> #### Outline
>
> Git was initially implemented directly in shell script with some instance=
s of Perl as well.

Do you talk about the `git submodule` command here? In Git there has
been a lot of C code since the beginning.

> As times progressed,
> various platforms to run Git on emerged, _enter_, problems in production =
code. There were multiple problems with
> compatibility of code across platforms(e.g.: POSIX-to-Windows path conver=
sion issues). To fix this issue, it was
> decided to convert these scripts into portable C code(the original intent=
ion C was developed with, to have portable
> code and software).

Platform portability is only one of the reasons why some commands have
been ported.

> Various commands have been converted as of now, such as add, blame, bisec=
t(work in progress), etc. In my project,
> I intend to convert submodule into C fully, hence making it a =E2=80=98bu=
iltin=E2=80=99.
>
>
> #### Previous Work
>
> There has been an ongoing work in the conversion of various Git commands =
such as 'add', 'commit', 'blame', etc. from
> their shell form into their C form. 'git submodule' is one of the command=
s left to fully convert into its C form.
> Stefan Beller <stefanbeller@gmail.com> converted a large part of this com=
mand up until 2019. Prathamesh Chavan <pc44800@gmail.com>
> also aided in the conversion of the command during his GSoC project in th=
e year 2017. In its current state, four subcommands are
> due for conversion, namely: 'add', 'set-branch', 'set-url' and 'summary'.=
 Also, the Command Line parsing Interface needs improvements,
> such as better error messages and support for more subcommands.
>
> Prathamesh Chavan implemented and improved the subcommands summary, statu=
s, sync, deinit and some more. The relevancy of this to my project
> is that some helper functions(located in submodule.c) such as print_submo=
dule_summary(),prepare_submodule_summary(), etc. have been implemented
> beforehand. In the case of subcommand summary, the work left is to stitch=
 these functions together and implement the main module_summary()
> function.

It is not very clear which subcommands have been fully converted into
C. Could you list all the subcommands and tell for each one what work
is left to do if any.

> I plan on working in a similar fashion by contributing changes to my GitH=
ub handle as well as the refined versions to the List,
> so that my mentors are able to keep a track of my progress regularly.

Ok, do you plan to have a weekly updated blog or to just send weekly
email updates to the mailing list?

> #### Project Timeline
>
> I have been studying the code of 'submodule.c', 'submodule--helper.c' and=
 'git-submodule.sh'
> since the submission of my microproject. After studying the codes, I trie=
d to devise an effective
> conversion strategy for 'submodule'. I noticed that 'submodule.c' contain=
s various helper functions
> for 'submodule--helper.c' whereas the latter houses the main "converted" =
command as of now.
>
> Therefore, the timeline looks like:
>
>   - Empty Period (Present - April 26)
>     --> I am writing a paper(of the project I have been working upon) for=
 a conference which I have to finalise and submit by first week of April.

You mean the UAV project, right?

>     --> My end-semester exams begin on April 23 hence I might be a bit bu=
sy before a week or so before the start date.
>     --> I plan on starting the conversion of =E2=80=98summary=E2=80=99 in=
 this period. Although, I am busy, I will try my best to implement
>         a basic scaffolding  and maybe even complete some good portion of=
 the subcommand for the command and will keep my
>         mentors posted regarding the same.

You wrote above that Prathamesh Chavan already worked on the =E2=80=98summa=
ry=E2=80=99
subcommand, so this would be about starting to finish it, right? Which
good portion you think you could complete?

>   - Community Bonding Period (April 27 - May 18)
>     --> Get familiar with the community
>     --> Improve the project workflow: make some timeline changes if neces=
sary.
>     --> Finish implementation of `summary` subcommand
>
>   - Phase 1 (May 19 - June 6)
>     --> Convert 'set-url' subcommand
>     --> Improve CLI parsing

Do you mean implementing better error messages in CLI parsing?

>   - Phase 2 (June 7- August 8)
>     --> Convert 'add' subcommand
>     --> Convert 'set-branch' subcommand
>
>   - Final Phase (August 9 - August 17)
>     --> Improve and add Documentation(if there is any still left)
>     --> Apply final touch-ups to code
>
> If there is some extra time left, I will try to implement some BONUS feat=
ures.
>
> **BONUS features:** Consist of command touch ups and improving some bugs =
such as code
>                     sections with 'NEEDSWORK' tags.
>
>
> ## Relevant Work
>
> I have divided the project into 3 subprojects(SP).
>
>     1. **SP 1:** Convert 'summary'
>     2. **SP 2:** Convert 'set-url' and and improve CLI(Command Line Inter=
face) parsing
>     3. **SP 3:** Convert 'add' and 'set-branch'

I am not sure that the above adds much information to what is in the
previous section (Project Timeline). At least I think you might want
to rename "Relevant Work" to something like "Subprojects".

> After discussions with Christian Couder, I plan to start SP1 before GSoC =
itself. Currently,
> I am studying the code in detail and constructing a scaffolding for this =
implementation.
> I aim to complete the leftover bits of SP1 during Phase 1 and SP2 & SP3 d=
uring Phase 2 of
> GSoC.
>
> As Derrick Stolee advised[https://lore.kernel.org/git/nycvar.QRO.7.76.6.2=
001301154170.46@tvgsbejvaqbjf.bet/T/#m232941f6cdcf92b97b3531f6fc582935c0673=
4cf],
> the conversion may not be possible in one whole summer, hence, I think an=
 early start might be needed to finish things in time if possible.
>
>
> ## Availability
>
> The official GSoC period starts from April 27 and ends on August 17. My v=
acations start
> from May 10 and will be over by July 13. I can easily devote 45-50 hours =
per week until
> the commencement of my Semester. Other than this project, I have no commi=
tments planned
> for my vacations. I shall keep the community posted in case of any change=
 in plans.
>
>
> ## Post GSoC
>
> Even after the completion of Google Summer of Code, I plan on continuing =
my contributions
> to Git, on the technical front(in terms of code and documentation contrib=
utions) as well
> as on the social front(solving people's doubts/problems on the List as we=
ll as on StackOverflow).
> I vision to convert the remaining of the commands as pointed out by Dscho=
[https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqb=
jf.bet/T/#m637c5c97d42dc68aab85420b5ffcaeb34c270ad3]
> as well as improve the test files.
>
> I aim to develop mentorship skills as well as the ability to guide others=
 and try to give back to
> the community by mentoring and guiding others as well(by reviewing their =
code, helping them out, etc.)

Ok.

I think it might be interesting to add a bit more information about
what should be done to implement the 'set-url', 'add' and 'set-branch'
subcommands.

Thanks,
Christian.
