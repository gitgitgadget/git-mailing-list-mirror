Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D517464
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195539; cv=none; b=EnTOytBaDlnTgD0loSI/OqrYAzt/N14PE8q6bihCsadu3eZhLHcT3HRPY7D43qbeKCAA689A96KaEL/QqIDjzwxwHsCEV8efssPTOTuHsU/9Yg/WFRj+SkBecKQz0UZhAqItYacRhwZAMbLOoP8zSaxcKqxzMNbFZOcdJUAcsl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195539; c=relaxed/simple;
	bh=g/KLBFn5nfnPrpR5VPCElT+HIQP4LeQb1g6EjopZbtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WezlZERa+8mMTLWnLoeoDo3WSWgDDwGz+jLNtOqHzaEcMXNacnaVw/Pig3pfrtMejqrFtGIn8Z1gYmUm6c9U4wYr0EKfIOvWuxEhVXD1y86BRimKNLeSNc3RfCVbspm49mAOmw8PT+zX0SxhQZRMgzctVPivRPkLWVBkNuH8jgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvZnvfdl; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvZnvfdl"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fb56d2fb2so1577626241.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730195536; x=1730800336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+Q0vxN82qZtl/IrLA1v3UZBHkO1ZfAq0Cz5h75H3ZE=;
        b=XvZnvfdlJP/WI0DXVx+MhTcI/eP2/FNVRjvXXMu43yE2ptlKIgZVk7zXl0G8WnrwJw
         kPDMX/pMyKkLlKYnPAqb3jgxSQtbXA1ftpf9Rq+FtV1t6Vaxxa0Bc+II8EloFt/HNleS
         phW4tWZopRv5aCsNG7tAhLHroEmPB2MQSAX0Z2mnFriyII/T35dFTalpJ7fWNH0nqR9z
         Ufn7zNVzcS53nv5yzBcDgo1SsF+N4QPol4PbLwI84o8GPsraRZeszm+0hrSkswKKCSHC
         MU39h1e/tseZ4dZ3RH56CELqnIm/KEB137CcwAtOw3tpnPZV7OwM21dCwOepCYjwTToA
         tc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730195536; x=1730800336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+Q0vxN82qZtl/IrLA1v3UZBHkO1ZfAq0Cz5h75H3ZE=;
        b=vUbpzbWLu2h7D5DMFlGjAnc+e880OCnLg6tuQ53sgXoPZIqUjUY3bw53Dt4NX9bip3
         8hMxgxdLrREvWyszapp93xDTyR+puxrG4OSvdv4quEg52Sivbz2iq0JWhvI1faV2IKpx
         BBroQiufAVYW3GUG9jiJkctZhltA5IJFMRVQ0J0VcIwbZ+lbbuB2HxvPeja+ENxnYs2F
         xpdrfEqIKZCuHqtWmDrwRTJ1b5ZYu1ByV0IbgJQz7ZVoBgYSTuqy80fKWLDCC8HKzGBo
         CqsMyA3UQmxc4en066kMzLCkDw5G94bgAPaOX8eNAtt2MAK1nZ1m3qyECqmGMdcZ2mBw
         PvAQ==
X-Gm-Message-State: AOJu0YxlEuApFoOO/A2sXBpGfIGPe0eXz9w2BwF5GbmPqTdq/oZDnEzu
	gNAofQsx+ELf221OGeQDS8QikgZHUD4D49+Q3XaEz3uZ47tsp6VjCVuKn0XKMRQeLZmHtkReA09
	r7V9xF3J8Jh+C8fykhAMpDxGAEcg=
X-Google-Smtp-Source: AGHT+IHabjRGVdibtTKa5aw9hFyGV1uhGxr+QNCWDxUhNYnPc4N5K2NR+Hi6lnbnUWPllRcqZXVRhymyhax7RLLVNwU=
X-Received: by 2002:a05:6102:3a0b:b0:4a4:7a00:d5b4 with SMTP id
 ada2fe7eead31-4a8cfd30768mr8654295137.18.1730195535993; Tue, 29 Oct 2024
 02:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-4okXfiWZtSNArMjfXzja9wBrMaEayhqt1hvJpu-PHkQ@mail.gmail.com>
 <CAP8UFD2pLppDC9b-JV-uQa8x8xmpeTSJ4szHOEPz1OfqzrOMPw@mail.gmail.com>
 <CAPSxiM8NgFUK8R0TrE1nPctOYSD6M8cCe7=xJuniXWO2g-C6Nw@mail.gmail.com>
 <CAPSxiM-EorSBsStHCFAm845q2H+YNDtAvCkwON8cV4AyYvGz_w@mail.gmail.com> <CAP8UFD15F2bdQakdEK2K195FV5QrK+9Kw8Z2svysAjNGGL0Jmw@mail.gmail.com>
In-Reply-To: <CAP8UFD15F2bdQakdEK2K195FV5QrK+9Kw8Z2svysAjNGGL0Jmw@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 29 Oct 2024 09:52:04 +0000
Message-ID: <CAPSxiM_JCGtkcaxRN8+=cOCgpWtWZPC8W=Wv23dCcV_g-wwwPg@mail.gmail.com>
Subject: Re: [Outreachy][proposal]: Finish adding a 'os-version' capability to
 Git protocol v2
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:13=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Mon, Oct 28, 2024 at 10:27=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
>
> > Review the Current Patch Series
> > --------------------------------------------
> > 1. Examine the Patch: Thoroughly analyze the existing patch series
> > submitted to the Git mailing list. Understand its design and
> > functionality, focusing on:
> >    -  How the OS information is gathered and transmitted.
> >    -  Current configurations and their implications on data transmissio=
n.
> > 2. Feedback Analysis: Collect feedback from the Git mailing list
> > discussion regarding the patch. Identify key concerns, especially
> > related to:
> >     - Privacy issues.
> >     - Default behavior expectations.
> >     - Cross-platform compatibility.
> > 3. Consider User-Agent Integration: Investigate the suggestion to
> > integrate the 'os-version' data into the existing user-agent string
> > rather than creating a new capability. Evaluate:
> >     - The implications of combining this data with the user-agent.
> >     - How this approach might address concerns about telemetry and user=
 privacy.
> >
> > Implement Default Behavior for 'os-version'
> > ----------------------------------------------------------
> > 1. Modify Default Configuration: Adjust the implementation so that by
> > default, only the OS name (e.g., "Linux" or "Windows") is sent during
> > communications.
> > 2. Impact Assessment: Evaluate how this change impacts existing users
> > and any potential performance implications.
> >
> > Introduce a Configuration Variable
> > ---------------------------------------------
> > 1. Define Configuration Options
> >     - Disable Option: Allow users to disable the 'os-version'
> > capability entirely via configuration.
> >     - Verbose Option: Enable a verbose mode that sends detailed OS
> > information (e.g., the output of the uname -srvm command).
> >     - Custom Option: Allows users to specify components independently,
> > using variables such as $OS_NAME for OS, $DISTRO for Linux
> > distribution, and $ARCH for architecture.
> > For example:
> >     i. "OS: $OS_NAME, Distro: $DISTRO, Arch: $ARCH" might output "OS:
> > Linux, Distro: Fedora, Arch: x86_64".
> >     ii.  "Distro: $DISTRO Version, OS: $OS_NAME" could yield "Distro:
> > Ubuntu 22.04, OS: Linux"
>
> Do you have ideas about how this configuration variable could be
> named? An example of what the doc for it could look like?
>
> I haven't looked much into it, so I don't know what's best, but for a
> custom option, an alternative to using $OS_NAME, $DISTRO, $ARCH, etc,
> might be to use things like %(os_name), %(distro), %(arch), etc which
> are used in ref-filter formats (see git for-each-ref documentation).
>
Hi Christian,
I think going with the one in git for-each-ref is better for
consistency across Git.
> > 2. Documentation: Improve the documentation outlining how to enable,
> > disable, and configure the 'os-version' capability. Include examples
> > for:
> >     - Basic usage (default OS name).
> >     - Detailed usage (full OS version information).
> > 3. Implementation: Code the configuration settings and ensure they are
> > recognized by the Git system.
> >
> > Fix Cross-Platform Tests
> > ---------------------------------
> >
> > 1. Identify Issues and added tests for changes/addition: Investigate
> > existing test failures, particularly those occurring on Windows and .
> >      - Review the test logs and identify the root causes of failures.
> >      - Analyze differences in OS behaviors and how they affect the test=
s.
> >      - Cross-platform tests to validate the functionality on Linux,
> > Windows, and macOS environments.
>
> It might be nice to explain how you plan to test on different platforms.
Noted, I will do that.
>
> > 2. Implement Fixes:
> >       - Modify tests to ensure they run correctly on Windows,
> > addressing any compatibility issues with the test framework or Git
> > commands.
> >       - Ensure all tests reflect the changes made to the OS reporting
> > capabilities.
> >
> > Testing and Validation
> > ------------------------------
> > Ensure comprehensive test coverage=E2=80=94including default behavior,
> > configuration options, and edge cases=E2=80=94integrate tests into the =
Git CI
> > pipeline for automatic execution, and share results with the community
> > for feedback on robustness and additional scenarios.
> >
> > Documentation Updates
> > ---------------------------------
> >
> > 1. User Documentation: Update the Git documentation to include:
> >     - Instructions on how to configure the feature, with practical exam=
ples.
> >     - Best practices regarding data privacy when using the capability.
> > 2 Developer Documentation: Include comments in the code for
> > maintainability and understanding of how the 'os-version' capability
> > works internally.
> >
> >  Prepare for Merging
> > ----------------------------
> > 1. Final Review: Conduct a thorough review of all code, tests, and
> > documentation. Ensure everything aligns with Git=E2=80=99s contribution
> > standards.
> > 2. Engagement with Community: Present the finalized patch to the Git
> > mailing list, addressing any additional concerns raised during the
> > discussions.
> > 3. Merge Process: Coordinate with the maintainers for merging the
> > patch into the main branch, ensuring all feedback has been
> > incorporated.
> >
> >
> > =E2=80=94------------------------- Timeline =E2=80=94------------------=
-------------------
> >
> > Community Feedback and Finalization
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > Dates: November 26 - December 8
> > Engage with the Git community to gather input, especially on privacy
> > concerns and minimal data sharing. Determine default behavior (sharing
> > only OS name) and finalize whether to use "user-agent" or another
> > identifier in the protocol(os-version).
> >
> > Minimal Default Implementation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > Dates: December 9 - December 20
> > Implement the core feature to share only the OS name by default,
> > keeping data minimal as per feedback.
> > Send Patches for review from the Git community
> >
> > Configurable Options for OS Version
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> > Dates: December 21 - December 30
> > Develop settings to allow users to disable OS data sharing or choose
> > verbose mode (e.g., uname -srvm output).
> > Send Patches for review from the Git community
>
> My opinion is that disabling OS data sharing will be required from the
> start, while choosing a verbose mode or a custom mode could be
> developed afterwards. So I think steps like the following make more
> sense:
>
> 1. Implement the core feature to share only the OS name by default, as
> well as an option to disable that feature.
> 2. Implement a verbose mode.
> 3. Implement a custom mode.
Noted, I will change that.
>
> > Cross-Platform Testing (Focus on Windows)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Dates: December 31 - January 13
> > Conduct robust testing across platforms, addressing prior Windows
> > compatibility issues.
> > Send Patches for review from the Git community
>
> My opinion is that testing on all the platforms will be required for
> each step, so that cannot be left for a later step. It should be
> integrated into each of the development steps.
Noted, I will make changes to that.
>
> > Beta Testing and Community Feedback
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > Dates: January 14 - January 27
> > Release for beta testing, integrate feedback, and refine functionality
> > based on real-world use.
>
> This should also be part of each of the development steps.
Yeah.
>
> Also new features often spend some time in the 'next' branch before
> being merged to master, which might be considered some kind of beta
> testing, but we don't call it "beta testing". Before a new release is
> tagged, we have a few rc0, rc1, etc releases, but they are not called
> "beta" releases either. They are actually called "rc" releases, "rc"
> meaning "Release Candidate". So overall, to avoid confusion, I think
> it's better to not use the "beta testing" term unless you explicitly
> say what you mean by it.
>
I will make use of rc here.
> > Documentation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Dates: January 28 - February 10
> > Document feature usage, configuration options, and setup instructions
> > for smooth adoption.
> > Send Patches for review from the Git community
>
> Documentation should also be part of each of the development steps.
Noted.
>
> > Final Review and Merge
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Dates: February 11 - March 6
> > The final review phase will include presenting the completed work to
> > the Git community for a thorough final assessment. Any remaining
> > concerns or suggestions will be addressed before the patch is prepared
> > for merge. This stage will allow for further feedback, particularly
> > from stakeholders and maintainers who raised the initial questions,
> > ensuring the solution is acceptable to the broad Git community. Once
> > consensus is achieved, the patch will be merged into the Git mainline
> > codebase, concluding the project.
>
> Not sure how things will go with reviews, but we prefer if development
> can be incremental. So I hope some initial patches will be merged well
> before the end of the internship.
>
> > Availability
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > I will be available to work for the required minimum of 40hours per wee=
k
> > during the internship period and will be happy to extend if required.
> >
> > Blogging
> > =3D=3D=3D=3D=3D=3D=3D
> > I also plan to keep writing blogs after two weeks, to track my
> > progress,  give updates about what I am currently working on and also
> > as a documentation for future contributors.
> >
> > Post Outreachy Internship
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > One of my dreams is to be an active member of an open-source community
> > which I can proudly support and contribute to. Continuing my
> > contributions after the internship is a big part of making that dream
> > a reality. I=E2=80=99m committed to contributing to Git long-term, help=
ing to
> > improve the project and supporting new contributors along the way.
> >
> > Appreciation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > I really appreciate the support and guidance I got from the Git
> > community. I also appreciate all the effort from the outreachy mentor.
> > Thanks for your time.
>
> Thanks for your application!
Thank you very much, I really appreciate the review. I will make the change=
s.
>
> > On Mon, Oct 28, 2024 at 9:09=E2=80=AFAM Usman Akinyemi
> > <usmanakinyemi202@gmail.com> wrote:
> > >
> > > On Mon, Oct 28, 2024 at 8:26=E2=80=AFAM Christian Couder
> > > <christian.couder@gmail.com> wrote:
>
> Please remove previous discussions you don't reply to at the bottom of
> your emails.
Noted.
>
> Thanks,
> Christian.
