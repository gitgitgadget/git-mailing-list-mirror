Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F89218FDBC
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193760; cv=none; b=QUX8oQqHNAeufXqj5+fzVH4tDiiILx2sTRjZ9J8oh0JXPoLu5nPDW+AvFojavFRjqq1ovMUGQY5cr38ugfc9WkkDPawVGPJVXssy9L2NZ+KsyghjHmEIDBHH/LVzuFJ8VjW+fHsj7DrrlVUz658mTtxG6y83hzvju6KGwzr8dRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193760; c=relaxed/simple;
	bh=jL8lWMBb0Wv00ngTCSJZGUePqbusDVpAFA3LuEfPjiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZAdPIkG+gGdLa9ykh/OTsY7PeTYlmvU3zIL3Rr9xp4Kxs2QvinqsUmoet4PWtIrsrxxv6LZAXJobyzLhadDlISxpzcwDIABUQmXj+xSAGmtkO/Y5hSy0NoJvo312NEsXzk6u8pxHBAO/Q9CInU6NIsvn1rEOj4ao1HmPCT2q4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLRfSnSf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLRfSnSf"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539ee1acb86so5201831e87.0
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730193756; x=1730798556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NL5hM2psoT09M99uZHpv722kZktXSNaETLS1M6Jg7Vw=;
        b=RLRfSnSfLfotG8eENWIqWl6pzjTed2MQCGGJLq0MzmEGzgR38rIuN+I+ITeHO6h4qa
         +2c7lcpxBNLwTstlEnsEdXVWkrI0le2n3ZnD+HGf2oRbiXyKJrChBfyk4jFERKEymZ7R
         MPCHW5fQvWnGKMH/OOLDOGMtApww4oYOJ9mnezYvIwuFTwo+8BrNAV3Q2BOOtIAnqY19
         mdvFJPlROiFPZBbi2UCTugL++ikvlzWcPWBiMxl/ZySu4wvpz1L/FvZm5+JHhcq+muOY
         qJblOjbnnJSDwHeFucbVjLz+evE0uI7fOJLXqPs05DyV4mzqtF2XdeoyE2/5EQXWHILz
         E09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730193756; x=1730798556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NL5hM2psoT09M99uZHpv722kZktXSNaETLS1M6Jg7Vw=;
        b=SzU10rFqUbcZ1UoXHi9L3WOqo4KAQLBONHaoOIzgO9fqSITvJiNsY1jaYf+DowKoDR
         r6GWtOtTvv8wLkpMo/rX2u/FLQ0QwajnYb7+1lGxw1SPROl68xNsfQQ6sf8UCfwizAQt
         IM/tz78Yx3mDeYCSFrOBOcp/veSZlf6TJ/WnsL55Rtk2F094KksQdamjE5AvLVX+U1LW
         JM2Ey48dC/Swuoyk5BfTQ7iDfrIYY6ZpY/45FXwJ0nqM1x0iCYd8obZ0wa9F3uDW6LXt
         Sc2ajEnj38jpevTmQGm71JPrOgDGQRt8qTDqLxecRnj1lJ5q7UPtgvXIzZGC/TTmrb/s
         AhIQ==
X-Gm-Message-State: AOJu0Yzv5DPZlIujTiKisTFnwvZac7KlHRJkmLpJuzbLYTGf/RIjEIRS
	TWU30k6TqsuB50ptJUdAzkzeY38RUWmrtlVYUWyNSBKTDEAEurkSeY4OcvAOfuyEbLDKj6khgv3
	ZZcP3yexY8xvXIIfw2/mirEAfpPU=
X-Google-Smtp-Source: AGHT+IEh8hfD7so5iCNRR67999TXQ/XEKKeo5Ydhg90BaaZmIUzpV31427uqw7COhgEjGk7bLbKIVUmyIH8xBpwzFOs=
X-Received: by 2002:a05:6512:ad5:b0:530:aa82:a50a with SMTP id
 2adb3069b0e04-53b3491cd87mr4515890e87.45.1730193755213; Tue, 29 Oct 2024
 02:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYq+fYu-n_msHbFgfzN+i4Xxp+MpAPmgPZXYJzn5vs+kZCG3A@mail.gmail.com>
 <CAP8UFD3RUxp0G+fYPxL0CeuZvVthAE0GPwdEhUt4cfPuwkvR2A@mail.gmail.com>
In-Reply-To: <CAP8UFD3RUxp0G+fYPxL0CeuZvVthAE0GPwdEhUt4cfPuwkvR2A@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 29 Oct 2024 09:22:21 +0000
Message-ID: <CADYq+faGvgfFtyYXdM8B0U059s9o3Xag1hMuRvjnxwRwfrVz8A@mail.gmail.com>
Subject: Re: [Outreachy][proposal]: Finish Adding an os-version Capability to
 Git Protocol v2
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 8:19=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Samuel,
>
>
> On Mon, Oct 28, 2024 at 9:07=E2=80=AFAM Samuel Abraham
> <abrahamadekunle50@gmail.com> wrote:
> >
> > Hello Git Community,
> > I hope you are doing well.
> >
> > ## Introduction:
> > My name is Abraham Samuel, I am participating in the December 2024
> > Outreachy internship program and
> > this is my proposal for the project "Finish adding os-version
> > capability to Git protocol v2".
> >
> > ## Contribution to the Git Community:
> >
> > I have participated in contributions to Git=E2=80=99s codebase after ge=
tting
> > accepted into the contribution phase in October 2024, working on what
> > I found doable and within my reach. Below is the list of my
> > contributions:
> >
> > - [PATCH v4] t7300-clean.sh: use test_path* helper functions for error =
logging.
> >
> >        List thread:
> > https://lore.kernel.org/git/pull.1811.v4.git.1728498122419.gitgitgadget=
@gmail.com/
> >
> >        Status: merged into master
> >
> >        Merge Commit: 77af53f56f100b49fdcf294f687b36064d16feca
> >
> >        Description: The patch converted instances of  =E2=80=9Ctest - [=
def]=E2=80=9D
> > in test cases to test_path_* functions to get error logs when the test
> > case fails when testing for the existence of a file or directory after
> > =E2=80=9Cgit clean=E2=80=9D or =E2=80=9Cgit clean -d=E2=80=9D is called=
 as the case may be.
> >
> >
> >
> > - [PATCH v4] notes: teach the -e option to edit messages in the editor
> >
> >        Status: integrated into Seen
>
> It looks like it has even been merged into 'next' and its status in
> the last "What's cooking in git.git ..." email is "Will merge to
> master?"
>
> It would be nice to give the branch name "sa/notes-edit" to make the
> topic easier to track.

Okay thank you Christian.
>
> >        List thread:
> > https://lore.kernel.org/git/pull.1817.git.1729296853800.gitgitgadget@gm=
ail.com/
> >
> >        Description: The patch worked on a #leftover bit which added
> > the =E2=80=9C-e=E2=80=9D option to =E2=80=9Cgit notes add=E2=80=9D and =
=E2=80=9Cgit notes append=E2=80=9D subcommands
> > when the message is supplied with the -F and/or -m options. The patch
> > enables fine-tuning the message by invoking the user=E2=80=99s default =
editor
> > prefilling the message in the editor to allow editing the message to
> > the required taste before adding the note to the commit
> >
> > ## Project Overview:
> > This proposal outlines a plan to complete the work on the os-version ca=
pability
> > patch series for Git's protocol v2. Initially introduced in June 2024,
> > this feature intends to enhance
> > communication by allowing Git clients and servers to share their
> > operating system (OS) information.
> > The capability aims to provide metadata that can improve issues
> > diagnosis and enable statistical insights.
> >
> > This project will involve refining the original patch which already
> > started the process of adding this feature,
> > addressing Windows compatibility issues, and implementing
> > configuration options to customise how the OS is
> > shared.
> >
> > ## Intern objectives:
> > The key objectives of this project are;
> > 1. Finalize 'os-version' Capability: Modify the existing patch series
> > to meet community requirements and improve
> > functionality, ensuring compatibility with different OS environments.
> > 2. Add configuration options: Create options that allow users to:
> >     - Share only the OS name by default (eg, "Linux", "Windows")
> >     - Disable OS information sharing completely
> >     - Include a more verbose OS version display using commands like
> > uname -srvm on Linux
>
> Making it possible to customize what is shared, for example something
> like "OS: Linux, Arch: x86_64" might be nice too.
>

Okay thank you for the insight.

> > 3. Fix Windows Compatibility: Review and resolve issues with the
> > current tests on Windows, ensuring full cross-platform
> > support
> > 4. Ensure Tests Coverage and Reliability:  Create robust tests to
> > verify the feature's functionality across supported platforms,
> > incorporating community feedback to refine and improve the patch series=
.
> >
> > ## Approach and Methodology
> > 1. Analyze and retrieve the existing patch series:
> >     - Retrieve patches from the Git mailing list
> >     - Review the current code and community feedback to understand
> > necessary improvements and privacy concerns
> >
> > 2. Apply and test the patch on a new branch:
> >     - Set up a new branch based on master to isolate the work on the
> > os-version feature
> >     - Apply the patches and perform an initial round of tests to
> > determine specific errors and how to address them
> >
> > 3. Address Community concerns and implement improvements
> >     - Implement feedback on sending only the OS name (eg, "Windows")by
> > default using uname or equivalent method on different OSes
> >     - Add configuration options for users to adjust the level of
> > detail in OS information sharing
> >     - Allow toggling the feature off for privacy or preference
> >     - Ensure that configuration changes are well-documented and user-fr=
iendly
> >
> > 4. Resolve Windows Compatibility issues:
> >     - Address current test failures on Windows, working closely with
> > community inputs to meet compatibility standards
> >     - Modify any OS-specific code or test as needed, to work across env=
ironments
> >
> > 5. Develop and refine tests:
> >     - Ensure the test case covers all functionality: OS name  sharing,
> > version details and disabled state
> >     - Conduct platform-specific tests on Linux, Windows and other
> > environments to confirm accuracy
>
> It might be nice to explain how you plan to test on different platforms.
>

Okay I will dot that.
> >     - Incorporate feedback from mentors and the community to finalize
> > the feature's functionality and robustness.
> >
> > 6. Document the feature and prepare for submission:
> >     - Write documentation and examples for configuring the os-version
> > capability, explaining options and use cases
> >     - Prepare the final patch series, following Git's contribution
> > guidelines for submission to the Git mailing list
> >
> > ## Timeline
> > 1. Community Onboarding: (Week 1 -2):
> >     Tasks:
> >         - Retrieve patches and create a dedicated branch
> >         - Study past discussions and understand the improvements requir=
ed
> >         - Set up blog post to write about internship experience
> > 2. Initial Testing and Patching (Week 3 - 4):
> >     Tasks:
> >         - Apply Patches
> >         - Run Initial tests
> >         - Identify current issues, especially Windows compatibility
> > 3. Implement OS version configuration option (Week 5 - 7):
> >     Tasks:
> >         - Add options for OS name, detailed OS version and disabled sta=
te
> >         - submit the initial patch series to the Git mailing list for r=
eview
> > 4. Windows Compatibility (Week 8 - 9):
> >     Tasks:
> >         - Review, debug and resolve Windows-specific issues
> >         - Perform cross-platform testing and verify functionality
> > 5. Test Expansion (Week 9 - 11):
> >     Tasks:
> >         - Write comprehensive tests for OS version capabilities.
> >         - Integrate tests to cover each configuration option.
> >         - Submit initial patches for tests to the Git mailing list
> >        - Implement community feedback and reviews on submitted test pat=
ches
> > 6. Finalizing and Documentation:( Week 12 - 14):
> >     Tasks:
> >        - Finalize code based on community inputs
> >        - Prepare final patch patch submission with full documentation
> >       - Complete my blog on internship experience
> >
> > ## Availability:
> > I will be available to work for a minimum of 30 hours per week and I
> > am not currently
> > enrolled in any academic activities or have any jobs.
> >
> > ## Post Outreachy:
> > The Git community fosters proper and effective communication,
> > regardless of one=E2=80=99s level of experience. The patience, guidance=
 and
> > explanation of technical concepts shown by community members are
> > wonderful and this has made me grow not just technically but also
> > behaviorally. Due to this, I plan to continue actively participating
> > the in Git community and be part next generation of those saddled with
>
> Nit: maybe s/part next/part of the next/

Noted.
>
> > sustaining this great project and preserving its legacy.
> >
> > ## Appreciation:
> >  A special appreciation to everyone on the mailing list for reviewing
> > my patches, the mentorship and guidance
> > I am grateful to you all.
>
> Thanks,
> Christian.
