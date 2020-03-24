Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D622C4332B
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 08:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCEE207FF
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 08:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7QWMvwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgCXIVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 04:21:51 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:36299 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgCXIVv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 04:21:51 -0400
Received: by mail-ed1-f54.google.com with SMTP id b18so19754897edu.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qo5Itd0v1MLopYDx0YdayAA0TgPqSRIB5+tZnrdHNF0=;
        b=a7QWMvwi3bEFvYZrAbt3lnOv6xFz9NFwSBWq8GYD80HnA5pBxvrr8R9rquhHt+folp
         +NmEcU7/c5jxCLehuMkIkSpJ/Mu7+qjOlBWlcszax2SomQc1KRgzhtthNsbsyAnIWKnZ
         dhrkeP8OIR2IGvSu/Lns/nqc9Lm1WLW/Hwyg88pVoJafYH8krKK9X+5TD0dhP8IipIAv
         CL5TqQmznvpk00xacDkzNXqqDknWR/DrJ0GO3gZxaH6AoxOTjLSc7ViqFniuQ8WyLdW5
         wydwrOlP4neQj8ai/DcpDdYPv+5GlOo8VYjaVAkRdcbmH5x8LEeBT3a3Lfu8aD3jpjCA
         1VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qo5Itd0v1MLopYDx0YdayAA0TgPqSRIB5+tZnrdHNF0=;
        b=fJPNYOVBtvdKgLhowIBIPvm8usuxEzNy3CsJ6IWvKENHPuMRmNf00B7NTtLPxfIGva
         b1jE8Q3NWIorK1dRjOtT2e62690LPxTzaT5uhSbujfp4HaQFj14uDa6kTSmVQfRmhtms
         55XNj+VDxDyh2d112+M2ReyA3ISDWhTHLwvAuAKdK+bB7LUIJM40W/KFxa5aik/u+6M0
         2/wlZoUJAGgFh/RCADs2I5fGJdNThLoewURoSxoWwSalTEytMiDX1oXuS057KxscjdLl
         34qNXv9IF5pVMYIcdTTgQEXBVl/v2PFz/BxlI99AiD+DMkc1R6Bg4KR5EAB6elTZJNaz
         CHkw==
X-Gm-Message-State: ANhLgQ10C+J5aLehRW+0BMKSrtCy/cvBguyPuJzZaAlzyxzk14RDp9wO
        2/P/3Dr+zi+jCguDDu56ObzXhlqQxYbLgZyxlKg=
X-Google-Smtp-Source: ADFU+vtU69B82ZrdCGsKKFQO97BoBPlQWvCZizWHekBQg8hS2ff/vspTfs14F4k02rmGq4T+fPfxud/3yJazFWpiaoY=
X-Received: by 2002:a17:906:2102:: with SMTP id 2mr9283627ejt.201.1585038107377;
 Tue, 24 Mar 2020 01:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200318191033.443-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200318191033.443-1-shouryashukla.oo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 24 Mar 2020 09:21:36 +0100
Message-ID: <CAP8UFD1PdRq7Wqbq1h6zZ8Jk2dmboFUM-Eg2-X_-vZtumvw8aw@mail.gmail.com>
Subject: Re: [GSoC][RFC][Proposal v3] Convert submodule to builtin
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

Hi,

On Wed, Mar 18, 2020 at 8:10 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> Hello everyone,
>
> Thank you so much once again for reviewing my proposal v2 Christian! :)
> Apologies for the late reply, I had been working on the conversion since =
and needed some concrete study for my proposal. This is the third draft of =
my GSoC Proposal. I have acted upon Christian's advice and reviews of my pr=
oposal.
>
> Changes made:
>         1. Corrected some of the links provided
>         2. Renamed 'Relevant Work' to 'Workflow'
>         3. Corrected grammatical errors and spelling mistakes
>         4. Added more information about the conversion process as well as=
 the current
>            state of the subcommands left to convert, along with a potenti=
al process and
>            direction of the conversion.

Great!

> I think the proposal needs to be even more descriptive conversion process=
 and direction, I will keep exploring the code even more and try to formula=
te an even better direction in the coming couple of days.
>
> One thing I wanted to ask was that how do I foresee a good strategy and r=
equired helper functions
> for the subcommands add, set-branch and set-url, as I am not working on t=
hem currently, hence I am
> not able to exactly predict a path as of now. I can foresee a skeleton fo=
r these subcommands but
> not a precise track for the same. :/

I was not asking that you work on them with the goal of converting
them right away, but rather that you take a look at each of them to
see if they call a lot of other shell functions that might themselves
call a lot of other shell functions and so on.

If you don't look at that, you may for example, at the beginning of
your project, start converting a sub-command which requires many shell
functions to be converted first, which means that it might take a long
time before your first patches can be merged.

It's better if you start converting a sub-command that doesn't require
a lot of work. So that you can send patches early and then work on the
rest while your early patches are reviewed.

> Also, a small report on my progress: I have created a scaffolding of the =
'summary' subcommand as stated in this commit:
> https://github.com/periperidip/git/commit/d33948dfc5d4c8faede9d3213adc396=
4557f33e1

We don't ask that you start your project before the GSoC starts. We'd
rather have you do other things that regular contributors do, like
reviewers other's patches on the mailing list or implementing small
things to scratch your itches (though not things that would interfere
with your project).

> I have progressed further than this commit and I will update the GitHub f=
ork shortly. Currently, I am
> studying other subcommands and trying to find a better direction for the =
code. I am also studying
> Prathamesh Chavan's 2017 GSoC project and patches thoroughly.

Yeah, it's a good idea to study the different sub-commands and
previous GSoC students' work.

> PS: A prettier version of this proposal is on Docs, it is more readable t=
han the plain-text version :)
> Google Docs: https://docs.google.com/document/d/1vqu84h0E83BnNyuj19HkgoWs=
GYHsGgY2Jkc5kTB4fSs/edit?usp=3Dsharing
>
> PPS: I noticed that there are new subcommands in the 'submodule--helper.c=
' but they are not defined
> in submodule's documentation. Will they be added after the full completio=
n of the conversion?

I am not sure. They might just be temporary helper sub-commands that
should be removed when conversion to C is finished.

By the way it might be a good strategy if there are big shell
functions that need to be converted to convert them first into
temporary helper sub-commands. That's one reason why it's interesting
for you to study a bit each sub-command left to be converted.

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
> List: https://lore.kernel.org/git/20200116203622.4694-1-shouryashukla.oo@=
gmail.com/

Participating in discussions and reviewing other's patches can also be
valuable contributions, so please list them too.

> ## The Project: Convert submodule to builtin
>
> #### Outline
>
> Git commands were initially implemented directly in shell script with som=
e instances of Perl as well.

Not all the Git commands were implemented in shell scripts.

> As times progressed, various platforms to run Git on emerged, _enter_, pr=
oblems in production code. There were multiple problems with shell scripts,=
 such as: compatibility of code across platforms(e.g.: POSIX-to-Windows pat=
h conversion issues).

What do previous students who worked on porting some commands to C
have written about that?

> To fix this issue, it was decided to convert these scripts into portable =
C code(the original intention C was developed with, to have portable code a=
nd software).
>
> Various commands have been converted as of now, such as add, blame, bisec=
t(work in progress), etc. In my project, I intend to convert submodule into=
 C fully, hence making it a =E2=80=98builtin=E2=80=99.
>
>
> #### Previous Work
>
> There has been an ongoing work in the conversion of various Git commands =
such as 'add', 'commit', 'blame', etc. from their shell form into their C f=
orm. 'git submodule' is one of the commands left to fully convert into its =
C form. Stefan Beller <stefanbeller@gmail.com> converted a large part of th=
is command up until 2019. Prathamesh Chavan <pc44800@gmail.com> also aided =
in the conversion of the command during his GSoC project in the year 2017. =
In its current state, four subcommands are due for conversion, namely: 'add=
', 'set-branch', 'set-url' and 'summary'.

It might be clearer if you say "four 'git submodule' subcommands".

> Also, the Command Line parsing Interface needs improvements, such as bett=
er error messages and support for more subcommands.
>
> Prathamesh Chavan implemented and improved the subcommands summary, statu=
s, sync, deinit and some more. The relevancy of this to my project is that =
some helper functions(located in sbmodule.c) such as print_submodule_summar=
y(),prepare_submodule_summary(), etc. have been implemented beforehand.

"submodule.c" instead of "sbmodule.c".

> In the case of subcommand summary, the work left is to stitch these funct=
ions together and implement the main module_summary() function. The current=
 status of The conversion is:
>
>         add: pending conversion, full code needs to be written for the sa=
me. Need to implement
>              callback macros and structures, i.e. struct add_cb(), ADD_CB=
_INIT, as well as frontend                  function module_add(). Other he=
lper functions may be needed in the process as well.                     Co=
mpare with shell script and try to =E2=80=9Ctranslate=E2=80=9D it into C.

The above is not easy to understand. Could you find a way so that it
appears nice when converted to plain text?

>         set-branch: pending conversion, full code needs to be written for=
 the same. Need to implement                       macros and structures, i=
.e. struct _setbranch(), SETBRANCH_CB_INIT, as well as                     =
     frontend function module_setbranch(). Other helper functions may be ne=
eded in the                       process as well. Compare with shell scrip=
t and try to =E2=80=9Ctranslate=E2=80=9D it into C.        set-url: pending=
 conversion, full code needs to be written for the same. Need to implement =
                     macros and structures, i.e. struct _seturl(), SETURL_C=
B_INIT, as well as frontend                       function module_seturl().=
 Other helper functions may be needed in the process as                    =
    well. Compare with shell script and try to =E2=80=9Ctranslate=E2=80=9D =
it into C.Compare with shell                     script and try to =E2=80=
=9Ctranslate=E2=80=9D it into C. It will have a similar implementation to  =
                     set-branch because they are =E2=80=9Csetter=E2=80=9D f=
unctions

Also not easy to understand the above.

>         summary: pending conversion, work in progress; callback structure=
s, functions and macros have
>                  been created, also, basic scaffolding of the command is =
done, i.e., functions
>                  module_summary(), summary_submodule(), summary_submodule=
_cb(). As this is a
>                  prototype, some functions may be scrapped or added later=
. Other functions to
>                  complement the subcommand have already been created; lea=
rn from Prathamesh's
>                  mistakes and implement a better code.

What I'd like to see is an estimation of the effort required for each
of the module_summary(), summary_submodule() and
summary_submodule_cb() functions. For example it would be especially
interesting if there is one function that needs 5 times more work than
the others as maybe an helper command in 'submodule--helper.c' could
be created for this function.

>         status: conversion complete, currently in a functional state.
>         init: conversion complete, currently in a functional state.
>         deinit: conversion complete, currently in a functional state.
>         update: conversion complete, currently in a functional state.
>         foreach: conversion complete, currently in a functional state.
>         sync: conversion complete, currently in a functional state.
>         absorbgitdirs: conversion complete, currently in a functional sta=
te.
>
>
>
> I plan on working in a similar fashion by contributing changes to my GitH=
ub handle as well as the refined versions to the List, so that my mentors a=
re able to keep a track of my progress regularly. I plan to create a weekly=
 blog for the same, but in case it is not possible, I will post weekly upda=
tes on the List.

Ok.

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

Is it the UAV project?

>     --> My end-semester exams begin on April 23 hence I might be a bit bu=
sy before a week or so before the start date.

Could you also give the end date of your exams?

>     --> I plan on starting the conversion of =E2=80=98summary=E2=80=99 in=
 this period. Although, I am busy, I will try my best to implement a basic =
scaffolding and maybe
>         even complete some good portion of the subcommand for the command=
 and will keep my mentors posted regarding the same.
>
>   - Community Bonding Period (April 27 - May 18)
>     --> Get familiar with the community
>     --> Improve the project workflow: make some timeline changes if neces=
sary.
>     --> Finish implementation of `summary` subcommand
>
>   - Phase 1 (May 19 - June 6)
>     --> Convert 'set-url' subcommand
>     --> Improve CLI parsing(give out better error messages)
>
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
> ## Workflow
>
> I have divided the project into 3 subprojects(SP).
>
>     1. **SP 1:** Convert 'summary'
>     2. **SP 2:** Convert 'set-url' and and improve CLI(Command Line Inter=
face) parsing
>     3. **SP 3:** Convert 'add' and 'set-branch'
>
> After discussions with Christian Couder, I plan to start SP1 before GSoC =
itself. Currently,
> I am studying the code in detail and constructing a scaffolding for this =
implementation.
> I aim to complete the leftover bits of SP1 during Phase 1 and SP2 & SP3 d=
uring Phase 2 of
> GSoC.
>
> As Derrick Stolee advised[https://lore.kernel.org/git/nycvar.QRO 7.76.6.2=
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
> from May 10 and will be over by July 13.

So your exams are from April 23 to May 9?

> I can easily devote 45-50 hours per week until
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

Thanks,
Christian.
