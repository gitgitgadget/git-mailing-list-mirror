Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196D520409B
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196757; cv=none; b=pPxaxehMptH0gHc5x3cYyadBohLk3Hnu/8jN4H0CHsMeOv5dLtBW7fyULydXLQvGCFUIScxuftXkVG8QVxGlgzrqwVqRNYo1n/1coT+kIV14icOtsYUXDSlis4P+lU7Yv7+a3VGP8uQaqw+ggOQAEjWsRraKGcTIki3sd3ek6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196757; c=relaxed/simple;
	bh=RUb+fpTs6Jq0uqByPUF6K02NcfMkejggVbgcq4P3B8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2Bv9ZnH9arVenj3y/F5tuiNNKdo6EKfwj4gsvMFXJdDwe3ztJgXGfFIk7YSrJfy7wPJKvSuKo2QYmUwezScQTf4KtgKJ+tVJRTmh/2PPFujkYe3ZutHsOIT3BTdNI+0rB/FNZ7Ja7sRluRrzT4AWlNqVrd8qAmZGzeZIKB9Xm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNRdaFAt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNRdaFAt"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so50492655e9.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 03:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730196752; x=1730801552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWZRxCdJ2qw+1TOzXgVFv0KgzjKlB5E7+Q+uy2mSSHo=;
        b=KNRdaFAtNILlEUxwLK9lCkkA2SX/QO8M8zc5iT/VyewfnpcdfoMAgpaJsWLFwGlyC8
         8m0wEyRWBs2LolQtRK4JFyXL6aC7PmySUGVwCZ8BPh2KSsdpOnLbVb1tyoTraT9cdP+Q
         3F2qdaIrxBZJ0a8WFe4hx8UxaGXsN4nV44lCRcWvm1Ikv0Mn3HwqhfHvUScmicDKhqY8
         QVimCKKgPCdWmhZ90lmQjxs4HgNAh9u1nZvQ3zdPz1ZGckXtaT9/eUuIe3Gqh33Qn1CN
         lIagU17T8gSzCXzaOqnMrZNLyVkAgQYEqvdjPtgDvETIY14YDyu3X6XYD73tPv5m/P1i
         wOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730196752; x=1730801552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWZRxCdJ2qw+1TOzXgVFv0KgzjKlB5E7+Q+uy2mSSHo=;
        b=mUz+trCiIF/43pnQYzqi05J6qRIuC/967dPcnkHghhprqEZ01mFWLZt54DBx4cK/ax
         EVAKyMSMrmshzzwNc47yERmkwubX8Ac7FIOS6hHPaFOoUW4sPn4FmQ56W+QK7Koy5AYc
         EgavjfFI+1k9we6RnAOt5SZBpu7M/+WGEMxMoOKKxkfmg3W90de3411KKZhMOhrQZo6N
         Yxt8YJdKqNogdvd67fxmuMZjhgKdpDzENZIzBoCWwFd/BPO7AamfFnhw1W6hrPqIrcOB
         Lhu1hgsO7AeRqNf7Y5jDNLI2duEfL3MEQ13sBpdD/XnNAZ91YuAluCSZk96Iyz5qtNzF
         B0Xw==
X-Gm-Message-State: AOJu0Yzv4JIdmNfgmzx6DBLZfXtyjJq8BQKVPV6Wp3ai2h2E4bDs87f3
	79BpEvmC6Vs9zHhN4CuT27F86RS9AAKcWEKVbyLHSMIkgEA6r0Tpf2O1CRE3j969MZnfFB9A3zm
	6QVgt7qfyB7ug3RFyahqrIIuAxis=
X-Google-Smtp-Source: AGHT+IGILW80jE6BbA5fCbloPSFF+UF/bVvOwR+j0uYJkXq3/vlk47NEnTSP5XXlz1UOtRj0SbLXAITmIRSqlrlPe9A=
X-Received: by 2002:a05:600c:354b:b0:431:54a1:360e with SMTP id
 5b1f17b1804b1-4319ad2725cmr104768335e9.32.1730196752072; Tue, 29 Oct 2024
 03:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYq+fYu-n_msHbFgfzN+i4Xxp+MpAPmgPZXYJzn5vs+kZCG3A@mail.gmail.com>
 <CAP8UFD3RUxp0G+fYPxL0CeuZvVthAE0GPwdEhUt4cfPuwkvR2A@mail.gmail.com> <CADYq+faGvgfFtyYXdM8B0U059s9o3Xag1hMuRvjnxwRwfrVz8A@mail.gmail.com>
In-Reply-To: <CADYq+faGvgfFtyYXdM8B0U059s9o3Xag1hMuRvjnxwRwfrVz8A@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 29 Oct 2024 10:12:21 +0000
Message-ID: <CADYq+fYOi=9E0KPHL+0rRdVZYN_+AQUiYiiuAcrhv2o=Q-kbpw@mail.gmail.com>
Subject: Re: [Outreachy][proposal]: Finish Adding an os-version Capability to
 Git Protocol v2
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:22=E2=80=AFAM Samuel Abraham
<abrahamadekunle50@gmail.com> wrote:
>
> On Tue, Oct 29, 2024 at 8:19=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > Hi Samuel,
> >
> >
> > On Mon, Oct 28, 2024 at 9:07=E2=80=AFAM Samuel Abraham
> > <abrahamadekunle50@gmail.com> wrote:
> > >
> > > Hello Git Community,
> > > I hope you are doing well.
> > >
> > > ## Introduction:
> > > My name is Abraham Samuel, I am participating in the December 2024
> > > Outreachy internship program and
> > > this is my proposal for the project "Finish adding os-version
> > > capability to Git protocol v2".
> > >
> > > ## Contribution to the Git Community:
> > >
> > > I have participated in contributions to Git=E2=80=99s codebase after =
getting
> > > accepted into the contribution phase in October 2024, working on what
> > > I found doable and within my reach. Below is the list of my
> > > contributions:
> > >
> > > - [PATCH v4] t7300-clean.sh: use test_path* helper functions for erro=
r logging.
> > >
> > >        List thread:
> > > https://lore.kernel.org/git/pull.1811.v4.git.1728498122419.gitgitgadg=
et@gmail.com/
> > >
> > >        Status: merged into master
> > >
> > >        Merge Commit: 77af53f56f100b49fdcf294f687b36064d16feca
> > >
> > >        Description: The patch converted instances of  =E2=80=9Ctest -=
 [def]=E2=80=9D
> > > in test cases to test_path_* functions to get error logs when the tes=
t
> > > case fails when testing for the existence of a file or directory afte=
r
> > > =E2=80=9Cgit clean=E2=80=9D or =E2=80=9Cgit clean -d=E2=80=9D is call=
ed as the case may be.
> > >
> > >
> > >
> > > - [PATCH v4] notes: teach the -e option to edit messages in the edito=
r
> > >
> > >        Status: integrated into Seen
> >
> > It looks like it has even been merged into 'next' and its status in
> > the last "What's cooking in git.git ..." email is "Will merge to
> > master?"
> >
> > It would be nice to give the branch name "sa/notes-edit" to make the
> > topic easier to track.
>
> Okay thank you Christian.
> >
> > >        List thread:
> > > https://lore.kernel.org/git/pull.1817.git.1729296853800.gitgitgadget@=
gmail.com/
> > >
> > >        Description: The patch worked on a #leftover bit which added
> > > the =E2=80=9C-e=E2=80=9D option to =E2=80=9Cgit notes add=E2=80=9D an=
d =E2=80=9Cgit notes append=E2=80=9D subcommands
> > > when the message is supplied with the -F and/or -m options. The patch
> > > enables fine-tuning the message by invoking the user=E2=80=99s defaul=
t editor
> > > prefilling the message in the editor to allow editing the message to
> > > the required taste before adding the note to the commit
> > >
> > > ## Project Overview:
> > > This proposal outlines a plan to complete the work on the os-version =
capability
> > > patch series for Git's protocol v2. Initially introduced in June 2024=
,
> > > this feature intends to enhance
> > > communication by allowing Git clients and servers to share their
> > > operating system (OS) information.
> > > The capability aims to provide metadata that can improve issues
> > > diagnosis and enable statistical insights.
> > >
> > > This project will involve refining the original patch which already
> > > started the process of adding this feature,
> > > addressing Windows compatibility issues, and implementing
> > > configuration options to customise how the OS is
> > > shared.
> > >
> > > ## Intern objectives:
> > > The key objectives of this project are;
> > > 1. Finalize 'os-version' Capability: Modify the existing patch series
> > > to meet community requirements and improve
> > > functionality, ensuring compatibility with different OS environments.
> > > 2. Add configuration options: Create options that allow users to:
> > >     - Share only the OS name by default (eg, "Linux", "Windows")
> > >     - Disable OS information sharing completely
> > >     - Include a more verbose OS version display using commands like
> > > uname -srvm on Linux
> >
> > Making it possible to customize what is shared, for example something
> > like "OS: Linux, Arch: x86_64" might be nice too.
> >
>
> Okay thank you for the insight.
>
> > > 3. Fix Windows Compatibility: Review and resolve issues with the
> > > current tests on Windows, ensuring full cross-platform
> > > support
> > > 4. Ensure Tests Coverage and Reliability:  Create robust tests to
> > > verify the feature's functionality across supported platforms,
> > > incorporating community feedback to refine and improve the patch seri=
es.
> > >
> > > ## Approach and Methodology
> > > 1. Analyze and retrieve the existing patch series:
> > >     - Retrieve patches from the Git mailing list
> > >     - Review the current code and community feedback to understand
> > > necessary improvements and privacy concerns
> > >
> > > 2. Apply and test the patch on a new branch:
> > >     - Set up a new branch based on master to isolate the work on the
> > > os-version feature
> > >     - Apply the patches and perform an initial round of tests to
> > > determine specific errors and how to address them
> > >
> > > 3. Address Community concerns and implement improvements
> > >     - Implement feedback on sending only the OS name (eg, "Windows")b=
y
> > > default using uname or equivalent method on different OSes
> > >     - Add configuration options for users to adjust the level of
> > > detail in OS information sharing
> > >     - Allow toggling the feature off for privacy or preference
> > >     - Ensure that configuration changes are well-documented and user-=
friendly
> > >
> > > 4. Resolve Windows Compatibility issues:
> > >     - Address current test failures on Windows, working closely with
> > > community inputs to meet compatibility standards
> > >     - Modify any OS-specific code or test as needed, to work across e=
nvironments
> > >
> > > 5. Develop and refine tests:
> > >     - Ensure the test case covers all functionality: OS name  sharing=
,
> > > version details and disabled state
> > >     - Conduct platform-specific tests on Linux, Windows and other
> > > environments to confirm accuracy
> >
> > It might be nice to explain how you plan to test on different platforms=
.
> >
>
> Okay I will dot that.
> > >     - Incorporate feedback from mentors and the community to finalize
> > > the feature's functionality and robustness.
> > >
> > > 6. Document the feature and prepare for submission:
> > >     - Write documentation and examples for configuring the os-version
> > > capability, explaining options and use cases
> > >     - Prepare the final patch series, following Git's contribution
> > > guidelines for submission to the Git mailing list
> > >
> > > ## Timeline
> > > 1. Community Onboarding: (Week 1 -2):
> > >     Tasks:
> > >         - Retrieve patches and create a dedicated branch
> > >         - Study past discussions and understand the improvements requ=
ired
> > >         - Set up blog post to write about internship experience
> > > 2. Initial Testing and Patching (Week 3 - 4):
> > >     Tasks:
> > >         - Apply Patches
> > >         - Run Initial tests
> > >         - Identify current issues, especially Windows compatibility
> > > 3. Implement OS version configuration option (Week 5 - 7):
> > >     Tasks:
> > >         - Add options for OS name, detailed OS version and disabled s=
tate
> > >         - submit the initial patch series to the Git mailing list for=
 review
> > > 4. Windows Compatibility (Week 8 - 9):
> > >     Tasks:
> > >         - Review, debug and resolve Windows-specific issues
> > >         - Perform cross-platform testing and verify functionality
> > > 5. Test Expansion (Week 9 - 11):
> > >     Tasks:
> > >         - Write comprehensive tests for OS version capabilities.
> > >         - Integrate tests to cover each configuration option.
> > >         - Submit initial patches for tests to the Git mailing list
> > >        - Implement community feedback and reviews on submitted test p=
atches
> > > 6. Finalizing and Documentation:( Week 12 - 14):
> > >     Tasks:
> > >        - Finalize code based on community inputs
> > >        - Prepare final patch patch submission with full documentation
> > >       - Complete my blog on internship experience
> > >
> > > ## Availability:
> > > I will be available to work for a minimum of 30 hours per week and I
> > > am not currently
> > > enrolled in any academic activities or have any jobs.
> > >
> > > ## Post Outreachy:
> > > The Git community fosters proper and effective communication,
> > > regardless of one=E2=80=99s level of experience. The patience, guidan=
ce and
> > > explanation of technical concepts shown by community members are
> > > wonderful and this has made me grow not just technically but also
> > > behaviorally. Due to this, I plan to continue actively participating
> > > the in Git community and be part next generation of those saddled wit=
h
> >
> > Nit: maybe s/part next/part of the next/
>
> Noted.
> >
> > > sustaining this great project and preserving its legacy.
> > >
> > > ## Appreciation:
> > >  A special appreciation to everyone on the mailing list for reviewing
> > > my patches, the mentorship and guidance
> > > I am grateful to you all.
> >
> > Thanks,
> > Christian.


Hello Git Community,
I hope you are doing well.

## Introduction:
My name is Abraham Samuel, I am participating in the December 2024
Outreachy internship program and
this is my proposal for the project "Finish adding os-version
capability to Git protocol v2".

## Contribution to the Git Community:

I have participated in contributions to Git=E2=80=99s codebase after gettin=
g
accepted into the contribution phase in October 2024, working on what
I found doable and within my reach. Below is the list of my
contributions:

- [PATCH v4] t7300-clean.sh: use test_path* helper functions for error logg=
ing.
      Branch name: aa/t7300-modernize
       List thread:
https://lore.kernel.org/git/pull.1811.v4.git.1728498122419.gitgitgadget@gma=
il.com/
       Status: merged into master
       Merge Commit: 77af53f56f100b49fdcf294f687b36064d16feca
       Description: The patch converted instances of  =E2=80=9Ctest - [def]=
=E2=80=9D
in test cases to test_path_* functions to get error logs when the test
case fails when testing for the existence of a file or directory after
=E2=80=9Cgit clean=E2=80=9D or =E2=80=9Cgit clean -d=E2=80=9D is called as =
the case may be.


- [PATCH v4] notes: teach the -e option to edit messages in the editor
       Status: integrated into next
       Branch: sa/notes-edit
       List thread:
https://lore.kernel.org/git/pull.1817.git.1729296853800.gitgitgadget@gmail.=
com/
       Description: The patch worked on a #leftover bit which added
the =E2=80=9C-e=E2=80=9D option to =E2=80=9Cgit notes add=E2=80=9D and =E2=
=80=9Cgit notes append=E2=80=9D subcommands
when the message is supplied with the -F and/or -m options. The patch
enables fine-tuning the message by invoking the user=E2=80=99s default edit=
or
prefilling the message in the editor to allow editing the message to
the required taste before adding the note to the commit

## Project Overview:
This proposal outlines a plan to complete the work on the os-version capabi=
lity
patch series for Git's protocol v2. Initially introduced in June 2024,
this feature intends to enhance
communication by allowing Git clients and servers to share their
operating system (OS) information.
The capability aims to provide metadata that can improve issues
diagnosis and enable statistical insights.

This project will involve refining the original patch which already
started the process of adding this feature,
addressing Windows compatibility issues, and implementing
configuration options to customise how the OS is
shared.

## Intern objectives:
The key objectives of this project are;
1. Finalize 'os-version' Capability: Modify the existing patch series
to meet community requirements and improve
functionality, ensuring compatibility with different OS environments.
2. Add configuration options: Create options that allow users to:
    - Share only the OS name by default (eg, "Linux", "Windows")
    - Disable OS information sharing completely
    - Include a more verbose OS version display using commands like
uname -srvm on Linux
3. Fix Windows Compatibility: Review and resolve issues with the
current tests on Windows, ensuring full cross-platform
support
4. Ensure Tests Coverage and Reliability:  Create robust tests to
verify the feature's functionality across supported platforms,
incorporating community feedback to refine and improve the patch series.

## Approach and Methodology
1. Analyze and retrieve the existing patch series:
    - Retrieve patches from the Git mailing list
    - Review the current code and community feedback to understand
necessary improvements and privacy concerns

2. Apply and test the patch on a new branch:
    - Set up a new branch based on master to isolate the work on the
os-version feature
    - Apply the patches and perform an initial round of tests to
determine specific errors and how to address them

3. Address Community concerns and implement improvements
    - Implement feedback on sending only the OS name (eg, "Windows")by
default using uname or equivalent method on different OSes
    - Add configuration options for users to adjust the level of
the detail in OS information sharing
    - Add a custom option to allow users to customize shared OS
information for example
      user can specify OS name only, OS name and architecture or OS
name, architecture,
distribution and version.
    - Allow toggling the feature off for privacy or preference
    - Ensure that configuration changes are well-documented and user-friend=
ly

4. Resolve Windows Compatibility issues:
    - Address current test failures on Windows, working closely with
community inputs to meet compatibility standards
    - Modify any OS-specific code or test as needed, to work across environ=
ments

5. Develop and refine tests:
    - Ensure the test case covers all functionality: OS name sharing,
version details and disabled state
    - ensure test coverage on Linux, Windows and other
environments to confirm accuracy by leveraging Git's CI pipeline to ensure
tests work seamlessly across all platforms and output variations align
with each environment.
    - Incorporate feedback from mentors and the community to finalize
the feature's functionality and robustness.

6. Document the feature and prepare for submission:
    - Write documentation and examples for configuring the os-version
capability, explaining options and use cases
    - Prepare the final patch series, following Git's contribution
guidelines for submission to the Git mailing list

## Timeline
1. Community Onboarding: (Week 1 -2):
    Tasks:
        - Retrieve patches and create a dedicated branch
        - Study past discussions and understand the improvements required
        - Set up blog post to write about internship experience
2. Initial Testing and Patching (Week 3 - 4):
    Tasks:
        - Apply Patches
        - Run Initial tests
        - Identify current issues, especially Windows compatibility
3. Implement OS version configuration option (Week 5 - 7):
    Tasks:
        - Add options for OS name, detailed OS version, custom option
and disabled state
        - submit the initial patch series to the Git mailing list for revie=
w
4. Windows Compatibility (Week 8 - 9):
    Tasks:
        - Review, debug and resolve Windows-specific issues
        - Perform cross-platform testing and verify functionality
5. Test Expansion (Week 9 - 11):
    Tasks:
        - Write comprehensive tests for OS version capabilities.
        - Integrate tests to cover each configuration option.
        - Submit initial patches for tests to the Git mailing list
       - Implement community feedback and reviews on submitted test patches
6. Finalizing and Documentation:( Week 12 - 14):
    Tasks:
       - Finalize code based on community inputs
       - Prepare final patch patch submission with full documentation
      - Complete my blog on internship experience

## Availability:
I will be available to work for a minimum of 30 hours per week and I
am not currently
enrolled in any academic activities or have any jobs.

## Post Outreachy:
The Git community fosters proper and effective communication,
regardless of one=E2=80=99s level of experience. The patience, guidance and
explanation of technical concepts shown by community members are
wonderful and this has made me grow not just technically but also
behaviorally. Due to this, I plan to continue actively participating
in the Git community and be part of the next generation of those saddled wi=
th
sustaining this great project and preserving its legacy.

## Appreciation:
 A special appreciation to everyone on the mailing list for reviewing
my patches, the mentorship and guidance
I am grateful to you all.

Thanks
Abraham Samuel
