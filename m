Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618C9E95A91
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 09:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbjJIJPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 05:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjJIJPM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 05:15:12 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275D297
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 02:15:11 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 5614622812f47-3ae2ec1a222so3077193b6e.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696842910; x=1697447710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2dC3G11JQeFKD1Y33U18+PHKkF5zC3Cj1LZU+DVpog=;
        b=cDSmlC1c8UDYVDLIiD9ZuwDEHmE/+mnfg120GlkI7sp1IcuezTK6pVTK088SBKnGsW
         /teWlGGGcI63c8BFodgA5aSp/RIdgwY25ck4rOqEyTN0lqNEeQl8CVBP9fVwMhGF/dH9
         D0f7oZYIli/epjyTUCH1NN9ctpxBuwAVPqTzqp/s5jJXKdzHKCQK8tdF0XHFg614y6bx
         1n3BrjzJ/pPKxla62SiONjsh2BhV9DPDTDahOV9IS98RwDErOk0OdYyKol4xfr+v0NRm
         F76IfrB26ysciu+iiBq11H4yr6FVu8QEFZD9AaTin+Q+w/FA24OxXflthVRixPhSLOyy
         wUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842910; x=1697447710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2dC3G11JQeFKD1Y33U18+PHKkF5zC3Cj1LZU+DVpog=;
        b=na5OGHbQudhVW7Cols3FrfQD+U6YaGTWBtAL2BL1HNrYWfK5aTQAu//2o9EFdcL02w
         bFc+nBcaXZJhWzkZFblrSR/6vomBKG0FNCh3rF21uDA2VWIbNM/cJLd9e2acO2Kj4EuW
         IV8Qtg8vZ3D6emkFkMbkzjSpiFHQzJU/KRutFVD0NNVin5L7kfjOqVvXqnN8PtiEMivH
         1tFVpa6u3ul1Qc5bpui/xJtZiGO8n3NxJ4LMVw6KS+Q5pgBAEQqvtt52wCZpXZ2uO/oz
         3FoIlM6Xoy1UiCLfYliiBsGUIwb2Ety8o3quX5MpMceWJvr44zdm3jACk7OYvi+UF99g
         ypTw==
X-Gm-Message-State: AOJu0YwERa7BvFuO2U4FACM6L/q/tjK68IJXSNGWNOQX8V5O/h/wiiLf
        Jkcn3tIq0NwQOTFyNb0IL8Dkzw4aIoVyu6qHh6Y=
X-Google-Smtp-Source: AGHT+IFPBDemqGpgBQwaMGV3Cp/tU3Ha4QHlUBSKPWlrqwqU/Y7TEYL3s1LyF7iuRHZUpS/1s4ZzwBrUC3We5cBrmd0=
X-Received: by 2002:a05:6358:9d82:b0:164:a045:e459 with SMTP id
 d2-20020a0563589d8200b00164a045e459mr2391055rwo.16.1696842910405; Mon, 09 Oct
 2023 02:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAFR+8DynAJ7eieMYUrezoNii5tzARNbESFxRCcT4w6okS5FZDg@mail.gmail.com>
 <xmqqedibzgi1.fsf@gitster.g> <CAFR+8DyN8vbuvdgZPkSVqS2=sqconwhx3QfcpJ0+Wi_oCA=s0w@mail.gmail.com>
In-Reply-To: <CAFR+8DyN8vbuvdgZPkSVqS2=sqconwhx3QfcpJ0+Wi_oCA=s0w@mail.gmail.com>
From:   Luma <ach.lumap@gmail.com>
Date:   Mon, 9 Oct 2023 10:15:02 +0100
Message-ID: <CAFR+8Dz717pcc2Lm_J29xxiBt-kUrMP4JAUbm=3XaJuJPYseHg@mail.gmail.com>
Subject: Re: [Outreachy] Move existing tests to a unit testing framework
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Community and Mentors,

I hope this email finds you well. My name is Achu Luma, and I am
excited to submit my application for the Outreachy program with the
Git project.
I have been a passionate open-source enthusiast and a dedicated Git
user for two years, and I am thrilled at the opportunity to contribute
to the Git community.

Introduction:
----------------
I study Computer Science from the University of Bamenda. Over the past
4 years, I have gained experience in software development and have
participated in various class projects.

Why I am a Good Fit:
----------------------
1. Proficient with Git: I have a good understanding of Git's version
control system and have successfully used it in both personal and
educational projects.

2. Strong Programming Skills: My programming skills in python, C etc
and experience with git, shell etc make me well-prepared to contribute
to Git's codebase.

3. Open Source Involvement: I have actively contributed to git
open-source project, including
https://public-inbox.org/git/20231003174853.1732-1-ach.lumap@gmail.com/T/#t
, where I have submitted a patch that has been well-received.

Project Idea - Moving Existing Tests to a Unit Testing Framework:
------------------------------------------------------------------
I am excited about "Moving Existing Tests to a Unit Testing Framework".
The objective of this project is to enhance the efficiency and
maintainability of Git's testing infrastructure by porting existing
unit tests to a unit testing framework.

**Project Plan**:
- Evaluate the existing tests in the `t/helper/` directory to identify
those suitable for migration to the unit testing framework.
- Develop a migration strategy and create detailed plans for adapting
these tests.
- Port the identified tests to the unit testing framework while
ensuring they maintain their functionality.
- Verify the correctness and reliability of the migrated tests through
thorough testing and validation.
- Collaborate with the Git community to gather feedback and make
necessary adjustments.

**Timeline**:
- Community Bonding (Oct 2 - Nov 20): Familiarize myself with the Git
project and establish communication channels.
- Coding Phase (Dec 4 - Jan 15): Implement the migration of tests and
seek feedback from mentors and the community.
- Testing and Validation (Jan 15 - Feb 15): Rigorously test the
migrated tests and make improvements based on feedback.
- Documentation and Finalization (Feb 15 - March 1): Document the
migration process and finalize the project.

**Contribution to Git Community**:
I have actively participated in Git's mailing-list discussions and
submitted a patch(
https://public-inbox.org/git/20231003174853.1732-1-ach.lumap@gmail.com/T/#t=
)
for review. I have received positive feedback on my contributions, and
it has been queued to be merged into official Git branches maintained
by Junio. Additionally, I have been involved in discussions related to
the git project.(https://public-inbox.org/git/CAFR+8DyN8vbuvdgZPkSVqS2=3Dsq=
conwhx3QfcpJ0+Wi_oCA=3Ds0w@mail.gmail.com/T/#t)

**Proposal Drafts**:
I have shared drafts of this proposal on the Git mailing list
git@vger.kernel.org  and will incorporate valuable feedback provided
by the community.

**Next Steps**:
I am eager to discuss my proposal further and collaborate with the Git
community to ensure the success of this project. I will continue to
engage with the community, seek guidance, and refine my proposal as
per your suggestions.

Thank you for considering my application. I look forward to the
opportunity to contribute to the Git project and help make it even
more robust and reliable.

Best Regards,

On Wed, Oct 4, 2023 at 12:36=E2=80=AFAM Luma <ach.lumap@gmail.com> wrote:
>
> oh yes, "Move existing tests to a unit testing framework" was the
> only listed project for this current Outreachy cohort. So, I used it
> to express my intent.
> I appreciate the clarification on authorship identity for patches. I
> will update subsequent patches with a legal full name to conform to
> the community rules.
>
> Regards.
>
> On Tue, Oct 3, 2023 at 7:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> >
> > Luma <ach.lumap@gmail.com> writes:
> >
> > > Hi;
> > > My name is Luma, and  I wanted to take a moment to introduce myself
> > > and share some
> > > insights on an essential aspect of  avoiding pipes in git related
> > > commands in test scripts.
> > >
> > > I am an outreachy applicant for the December 2023 cohort and look
> > > forward to learning from you.
> >
> > I notice that the title of the message and the immediate topic you
> > discuss in the body of the message do not match.  I presume that the
> > topic on the title is what you prefer to work on if the unit testing
> > framework is ready by the time Outreachy program starts, and the
> > mention about "do not clobber exit code of Git with pipes in the
> > tests" is your "dip the tip of a toe in water" microproject?
> >
> > Welcome to the Git development community.
> >
> > Do you have a single word name?  If so please disregard the below,
> > but in case "Luma" is just a nickname (e.g. like I am introducing
> > myself to my Git friends "Hi, I am Gitster!") you use online, please
> > read on.
> >
> > For signing off your patches, we'd prefer to see your real name
> > used, as Signed-off-by: is meant to have legal significance.  And
> > because we also expect the authorship identity to match the
> > name/e-mail of the sign-off, it would mean your patch submissions
> > are expected to look like:
> >
> >         From: Luma <ach.lumap@gmail.com>
> >         Subject: ... title of the patch goes here ...
> >
> >         ... body of the proposed commit log message goes here...
> >
> >         Signed-off-by: Luma <ach.lumap@gmail.com>
> >
> > but "Luma" replaced with your full real name.
> >
> > Thanks.
