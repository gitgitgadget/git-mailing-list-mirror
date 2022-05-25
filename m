Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B7C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 19:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiEYTGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 15:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiEYTGF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 15:06:05 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74103F79
        for <git@vger.kernel.org>; Wed, 25 May 2022 12:06:01 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id r3-20020a9d5cc3000000b0060ae1789875so12561984oti.13
        for <git@vger.kernel.org>; Wed, 25 May 2022 12:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ostif-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QKC+yv6iIjpxUnJjlKm+pJuOsYz4rIoUGcU+vHdMM2g=;
        b=HkTf9Nkk9fBbbrUL6EOc1ufVwHgEdk52Odj12dZAv6NWh/O+2k2pd32ZyuvifNXUUu
         HqQi3RvyN0Y4B9FzWY/rzF9boUbRmrLKH9kdXN8cYLNhwskQKidgsGOWECdm1Vp2zMpY
         oOswQgb360rzyJCkXCoxUFocjK/c0McOK8HwYVasKMEHXCmouBAGYymGQtZUmTJuLICq
         X/Z5gNEkMOokoEMdUhqGxypCieppaJYC1akvux0bcCz6ruRxtQF2PZ968TNG8gKHp9oJ
         2Em88J+Zn/A/kqryei8f6DBziExLijUk5cmMzYsxDr6NEQ/NGRr63FQDXhOqnz6OFo93
         nMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=QKC+yv6iIjpxUnJjlKm+pJuOsYz4rIoUGcU+vHdMM2g=;
        b=3fzy8eI2WkgIXxWg4QJeMUq+youv3adwPNTLlqkUI3+Un+YDpNm2ebKP5YU8cRZCxW
         VtZrfHwDfsUkhEnKOKJ2NEYZcoKt8vpVSV4z05rmWZJERH5fCCJ4njOuCkZai2uuxcU9
         V/DyipggLjPSWpldAFab5PJn/IC2dNh9powRrE4GVHYE5kari0tp8YVthklbwezIchxQ
         f2PTuH5UGhjQ+3g8z6pBkbyDlXR2ENCDiAO59mYazXrybWejR9QwAuFXdnhdB/jrdLzm
         s5iFBMpZVRlM+K8gT8fehVm7/tGcW31FgrhuGS0g36/nrgqZXYjx1ZiULH3QGRjGxOzk
         ESbw==
X-Gm-Message-State: AOAM531g/+FR4ucmlQGHPJ/AjsZUg/K03jopy6G5Ppzz5+UGG7S6b4cd
        4l+7jUizogueoqh1D6szSc8s8BQ9M4gGIVio+/+216NXwbEWD+Gj
X-Google-Smtp-Source: ABdhPJwcdtT2kxTnw3wCLQM3D4a5UNSR4TDeVOKpu/t1BEy1CniPXZjy+A2atHThY/IsGmk00p9KBOhM1VMy/a7kdmw=
X-Received: by 2002:a9d:798f:0:b0:60b:298c:8bcc with SMTP id
 h15-20020a9d798f000000b0060b298c8bccmr2994935otm.176.1653505560489; Wed, 25
 May 2022 12:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJY0qZJ1A68kXOW5rzov-R4zXY-ssaqNn9OPRvQ=KhO835L=Pw@mail.gmail.com>
 <CALokGq-i9JgwejE+SbEVbY0GHAR1NTQx-Ngj__nw5wibve2FdA@mail.gmail.com>
 <CAJY0qZ+9o_B1XWVwwBRRih6ob6MVVMs4M-9MxF=-n8aUdHD79Q@mail.gmail.com>
 <CAG=8VoB3TRgFxdj7+QnYhUoJ-hw1f7G6-f=9c2CaHz66TJqxZA@mail.gmail.com>
 <CADKuG0vB=J+nQpRTWYH5MrK5=9R+unzLoP6DYQHmuvbRAKJ0mg@mail.gmail.com>
 <CADKuG0vngAk1RDV7COUfeGUzRLETHdV1WJFRTUiqp7CgSw3AFA@mail.gmail.com>
 <CAHhjvvnYf38XB8ECpT1GBWRL5MzPSoxsvmvtNuYC0zm-EcGp2Q@mail.gmail.com> <CADKuG0vBcXp4GYECUUfYqc14LXjReudp1+UnJ+k=81pe9XuHUw@mail.gmail.com>
In-Reply-To: <CADKuG0vBcXp4GYECUUfYqc14LXjReudp1+UnJ+k=81pe9XuHUw@mail.gmail.com>
From:   Amir Montazery <amir@ostif.org>
Date:   Wed, 25 May 2022 14:05:49 -0500
Message-ID: <CADKuG0ukPErr75yd-bdosuxgkyALFqGqkWFJTLaM+npBzwEWFg@mail.gmail.com>
Subject: Fwd: Syncing up team members for the comprehensive security review of Git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git mailing list! The purpose of this email is to inform you of
the coordinated security effort for git, and hopefully source some
contacts for questions and follow up. An overview of the effort is as
follows. It is broken up into three work packages. It would be great
to have at least one contact/maintainer for each work package.

Work Package 1: git source code review and threat modeling: This will
be done by the team at x41-dsec with a Gitlab team.

Work Package 2: Supply chain security / CI infrastructure review with
Chainguard and Gitlab team.

Work Package 3: A new setup of CodeQL for git with Xavier and his team
from Github.

Please let me know if you have any questions. Thank you in advance! We
are aiming to start the week of June 13th 2022.

- Amir

Amir Montazery
Managing Director
Open Source Technology Improvement Fund
https://ostif.org/
https://calendly.com/ostif


---------- Forwarded message ---------
From: Amir Montazery <amir@ostif.org>
Date: Wed, May 25, 2022 at 1:38 PM
Subject: Re: Syncing up team members for the comprehensive security
review of Git
To: Xavier Ren=C3=A9-Corail <xcorail@github.com>, Markus Vervier
<markus.vervier@x41-dsec.de>, Eric Sesterhenn
<eric.sesterhenn@x41-dsec.de>
Cc: Dennis Appelt <dappelt@gitlab.com>, Derek Zimmer
<derek@ostif.org>, Joern Schneeweisz <jschneeweisz@gitlab.com>, Eddie
Zaneski <eddiezane@chainguard.dev>, Adolfo Veytia
<puerco@chainguard.dev>, Tracy Miranda <tracy@chainguard.dev>, Ethan
Strike <estrike@gitlab.com>


Adding +Markus Vervier and +Eric Sesterhenn  to the thread. Sorry, I
got my threads mixed up.

On Wed, May 25, 2022 at 12:38 PM Xavier Ren=C3=A9-Corail <xcorail@github.co=
m> wrote:
>
> Hey Amir,
>
> Sorry for the late reply, busy times here. I am trying to find the best p=
ersons on our side an will let you know ASAP.
>
> --
> Cheers
> Xavier
>
>
> On Tue, May 24, 2022 at 1:18 PM Amir Montazery <amir@ostif.org> wrote:
>>
>> Hello all,
>>
>> Please see the following doc. The next steps are as follows:
>>
>> Confirm information is accurate.
>> Confirm who else, in anyone, should be engaged as part of this effort.
>> Schedule intro meetings.
>>
>> Please let us know your thoughts and feedback! Thank you in advance!
>>
>> Link to doc: https://docs.google.com/document/d/1kRLVuvOFkXS1Jt_voDLBVZV=
QMpgfXUOCJQpnNXDZhQo
>>
>>
>> On Tue, May 24, 2022 at 3:00 PM Amir Montazery <amir@ostif.org> wrote:
>>>
>>> Wonderful. Thank you everyone! We are finalizing a doc that will help g=
uide the work and keep everyone informed. Once that is shared, we can confi=
rm the info is accurate and move forward with scheduling a sync.
>>>
>>> Thank you,
>>> Amir
>>>
>>> On Mon, May 16, 2022 at 6:56 AM Dennis Appelt <dappelt@gitlab.com> wrot=
e:
>>>>
>>>> Hi Derek - sounds good. Looking forward to learning more about the eff=
ort.
>>>>
>>>> On Fri, May 13, 2022 at 6:13 PM Derek Zimmer <derek@ostif.org> wrote:
>>>>>
>>>>> Nice to meet you Dennis!
>>>>>
>>>>> The supply chain side is Eddie, Tracy, and Adolfo. I believe they are=
 all going to Kubecon so it will be sometime after that.
>>>>>
>>>>> Derek Zimmer
>>>>> Executive Director
>>>>> Open Source Technology Improvement Fund
>>>>>
>>>>>
>>>>> On Thu, May 12, 2022 at 8:16 AM Joern Schneeweisz <jschneeweisz@gitla=
b.com> wrote:
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> sorry for just replying to a subset here, but I didn't want to spam =
everyone with scheduling questions.
>>>>>>
>>>>>> Regarding:
>>>>>>
>>>>>> > -Supply chain security / CI infrastructure review with Chainguard =
and Joern from Gitlab (if he so chooses to assist).
>>>>>>
>>>>>> My colleague Dennis (in cc:) is interested in joining this effort as=
 he did quite some research in the supply chain field.
>>>>>> For our scheduling and to decide how we can join the review we'd nee=
d to know the timeline for the supply chain and CI infra review.
>>>>>>
>>>>>> Thanks and looking forward to collaborate
>>>>>>
>>>>>> joern
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Wed, May 11, 2022 at 6:54 PM Derek Zimmer <derek@ostif.org> wrote=
:
>>>>>>>
>>>>>>> Hello everyone,
>>>>>>>
>>>>>>> We've had all of our initial meetings with the stakeholders on this=
 project and I'm here to fill us all in on communication channels and respo=
nsibilities. If I've missed anyone that is participating from any of the or=
gs involved, please add them to this email so that we can all get on the sa=
me page and have all of the required contacts.
>>>>>>>
>>>>>>> Because of the wide scope of this project there will be some overla=
p between the work of the teams, and it is crucial that we ensure that ever=
yone has access to the information that they need to make this work as frui=
tful as possible.
>>>>>>>
>>>>>>> We have three main work packages that we are executing:
>>>>>>> -Git source code review and threat modeling: This will be done by t=
he team at x41-dsec with Joern from Gitlab.
>>>>>>> -Supply chain security / CI infrastructure review with Chainguard a=
nd Joern from Gitlab (if he so chooses to assist).
>>>>>>> -A new setup of CodeQL for git with Xavier and his team from Github=
.
>>>>>>>
>>>>>>> Because Git is an enormous project with hundreds of contributors, w=
e've been directed by the maintainers to refer questions to the mailing lis=
t. If we get no response or need some specific responses or access, OSTIF c=
an reach out to the maintainers directly to find the people required (if th=
e mailing list fails to produce results). The mailing list is at git@vger.k=
ernel.org (PLAIN TEXT EMAIL ONLY, ANYTHING ELSE IS AUTOMATICALLY REJECTED).
>>>>>>>
>>>>>>> Our next step is to find everyone's availability so that we can gen=
erally set expectations about who is doing work and when. These projects do=
 not have to happen simultaneously as each work package has different end-g=
oals, but we should share relevant information between teams to prevent red=
undant work and wasted resources.
>>>>>>>
>>>>>>> So the questions to answer:
>>>>>>>
>>>>>>> Do we have everyone here?
>>>>>>> Is everyone's role understood?
>>>>>>> When can your respective teams begin?
>>>>>>>
>>>>>>>
>>>>>>> Thank you all for participating in this! I'm confident that this ef=
fort is going to help secure all of open source!
>>>>>>>
>>>>>>> All the best,
>>>>>>>
>>>>>>> Derek Zimmer
>>>>>>> Executive Director
>>>>>>> Open Source Technology Improvement Fund
>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Joern SchneeweiszStaff Security Engineer, Security Research | GitLab
>>>>>>
>>>>>> GitLab GmbH
>>>>>>
>>>>>> Elsenheimerstra=C3=9Fe 7
>>>>>> c/o RPI Roehm + Partner 80687 M=C3=BCnchen
>>>>>> Registergericht: Amtsgericht M=C3=BCnchen, HRB 237630
>>>>>> Gesch=C3=A4ftsf=C3=BChrer: Sytse Rients Sijbrandij
>>>>
>>>>
>>>>
>>>> --
>>>>
>>>> Dennis Appelt Security Engineer | GitLab
>>>
>>>
>>>
>>> --
>>> Amir Montazery
>>> Managing Director
>>> Open Source Technology Improvement Fund
>>> https://ostif.org/
>>> https://calendly.com/ostif
>>>
>>
>>
>> --
>> Amir Montazery
>> Managing Director
>> Open Source Technology Improvement Fund
>> https://ostif.org/
>> https://calendly.com/ostif
>>


--=20
Amir Montazery
Managing Director
Open Source Technology Improvement Fund
https://ostif.org/
https://calendly.com/ostif



--=20
Amir Montazery
Managing Director
Open Source Technology Improvement Fund
https://ostif.org/
https://calendly.com/ostif
