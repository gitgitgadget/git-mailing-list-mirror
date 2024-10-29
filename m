Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81615204036
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193238; cv=none; b=nUyEJIoZOuQTK1+SrkY+t7ZLIo4w5/uxqT8oCyy3yhiqNqCKQnrfs6tvnYvkLvIRFFdcjdTJ98CHn8Xj82mcE9tFlUqpLYFKPKbu+94i4yc5tNYzzU9kaZIRq0X0+G/tTUVvepXR+o6M+ZA+i5tnOfpYOegi/iaT5YFCklCvRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193238; c=relaxed/simple;
	bh=fS7k6OK2fS40jaTz4+LYrSD7cnlNMCWpKjummVypMm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2LXIQwgL/sikqsqKB5WcEcrByuhvDREozNe9wRlXshQQieu+HP/OxwZeZpYA7tqg1hZydTH2FrQCCXqe8RNV2zg1AEByPu9j+WvY51H9jdicgTj/gYeioIPiuKR+zllG22LYhzJWKG08/vp0Q5cgYuhMo/ugz5Vsgx1hh/j81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMGc3gmr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMGc3gmr"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cb615671acso3197593a12.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730193234; x=1730798034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YA+eVRZXUucdS/WZQOTZwmIEgQFxO/IcPLmriYLHtg=;
        b=ZMGc3gmrRjww6lgZ8obTMQbi0+DRNV2FSz1iL3XX0Eit0T747/OeeYHhqF5+1XTKC+
         uFe//SVcaL/ueVYhLBYnbEn6aiupEEhHcvqsrqs8YG/p0ycU7MrvuFHyugNGrfa0YkXa
         o1pWM8kqUaNMGSVqjp9O9LMn8tit1C6DxZHZ9MXR2NVeg8uzvDQ2G3jpxvbMNMSKyTeV
         HUlYKoXADHRE7Ntgqtjm/7ndCoXYm19G6h0QeZ9WxmYifKuEIbcoefcgeZyEVvV6CEan
         zHkIR0i9AEwth6uzK024arNqJ5ikqOTEQ9bL5rf+IXFd8KVEHJh8KmwZMDTvWFR9N2NB
         rFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730193234; x=1730798034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YA+eVRZXUucdS/WZQOTZwmIEgQFxO/IcPLmriYLHtg=;
        b=cdliEZgUcKcHT5Swq2xjVYPsbpLBqlVfdcjt4HBUNn3yyUneEaJRfuTr5IYok6Q1Gd
         POd2qDMJc337SaQwzVGCanXejkYyIbNut3tp+ZpPO34iTx95ew3Pj1ybSfoYb3lVrAT6
         oWLsJOJGkNRL2EsNYdwiLsdgi8Q9WedlAToeJ18ebhdb+6BYnVTn5ZPQU3SM6rEw8sLE
         6MTWNLSeKsdyiB3gHqSEDcnhU6duWCKYHhvlOraqCNX5VhsCPYgvW+1xhGL/pZtTJw1W
         QPvOOdcz6pY4oV5K3RaTbQgQHyJXt0QFsLoN06OslK/jBMLvDXmuzbBDoADE9aPVeP2O
         1NuA==
X-Gm-Message-State: AOJu0YyHjQSXw9D0Wskg2TUhZEiHt2TjIB9IW4pc8fJE++b81aW+N65K
	h6u9wAGmunUtE4AfsooG9CxGcksEMecZ9A+Y3C8vA440gG1orbhpqd0vJuxjCiXGgCgY9+Q+dEw
	5BTyPHI1tpSZlzqiP9Z4pi3HhFfCv/u8/
X-Google-Smtp-Source: AGHT+IESmAUfl/QreLPRYTHl/7yJJ6hRAQ+ZSPr4lAHuKxXDicEhvTPul3Jf3Xfvku0vNoDIpHdfFYinhDKz5zHnZs8=
X-Received: by 2002:a05:6402:5188:b0:5cb:f1d7:56ac with SMTP id
 4fb4d7f45d1cf-5cbf1d75726mr2658116a12.2.1730193233422; Tue, 29 Oct 2024
 02:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-4okXfiWZtSNArMjfXzja9wBrMaEayhqt1hvJpu-PHkQ@mail.gmail.com>
 <CAP8UFD2pLppDC9b-JV-uQa8x8xmpeTSJ4szHOEPz1OfqzrOMPw@mail.gmail.com>
 <CAPSxiM8NgFUK8R0TrE1nPctOYSD6M8cCe7=xJuniXWO2g-C6Nw@mail.gmail.com> <CAPSxiM-EorSBsStHCFAm845q2H+YNDtAvCkwON8cV4AyYvGz_w@mail.gmail.com>
In-Reply-To: <CAPSxiM-EorSBsStHCFAm845q2H+YNDtAvCkwON8cV4AyYvGz_w@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 29 Oct 2024 10:13:41 +0100
Message-ID: <CAP8UFD15F2bdQakdEK2K195FV5QrK+9Kw8Z2svysAjNGGL0Jmw@mail.gmail.com>
Subject: Re: [Outreachy][proposal]: Finish adding a 'os-version' capability to
 Git protocol v2
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 28, 2024 at 10:27=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:

> Review the Current Patch Series
> --------------------------------------------
> 1. Examine the Patch: Thoroughly analyze the existing patch series
> submitted to the Git mailing list. Understand its design and
> functionality, focusing on:
>    -  How the OS information is gathered and transmitted.
>    -  Current configurations and their implications on data transmission.
> 2. Feedback Analysis: Collect feedback from the Git mailing list
> discussion regarding the patch. Identify key concerns, especially
> related to:
>     - Privacy issues.
>     - Default behavior expectations.
>     - Cross-platform compatibility.
> 3. Consider User-Agent Integration: Investigate the suggestion to
> integrate the 'os-version' data into the existing user-agent string
> rather than creating a new capability. Evaluate:
>     - The implications of combining this data with the user-agent.
>     - How this approach might address concerns about telemetry and user p=
rivacy.
>
> Implement Default Behavior for 'os-version'
> ----------------------------------------------------------
> 1. Modify Default Configuration: Adjust the implementation so that by
> default, only the OS name (e.g., "Linux" or "Windows") is sent during
> communications.
> 2. Impact Assessment: Evaluate how this change impacts existing users
> and any potential performance implications.
>
> Introduce a Configuration Variable
> ---------------------------------------------
> 1. Define Configuration Options
>     - Disable Option: Allow users to disable the 'os-version'
> capability entirely via configuration.
>     - Verbose Option: Enable a verbose mode that sends detailed OS
> information (e.g., the output of the uname -srvm command).
>     - Custom Option: Allows users to specify components independently,
> using variables such as $OS_NAME for OS, $DISTRO for Linux
> distribution, and $ARCH for architecture.
> For example:
>     i. "OS: $OS_NAME, Distro: $DISTRO, Arch: $ARCH" might output "OS:
> Linux, Distro: Fedora, Arch: x86_64".
>     ii.  "Distro: $DISTRO Version, OS: $OS_NAME" could yield "Distro:
> Ubuntu 22.04, OS: Linux"

Do you have ideas about how this configuration variable could be
named? An example of what the doc for it could look like?

I haven't looked much into it, so I don't know what's best, but for a
custom option, an alternative to using $OS_NAME, $DISTRO, $ARCH, etc,
might be to use things like %(os_name), %(distro), %(arch), etc which
are used in ref-filter formats (see git for-each-ref documentation).

> 2. Documentation: Improve the documentation outlining how to enable,
> disable, and configure the 'os-version' capability. Include examples
> for:
>     - Basic usage (default OS name).
>     - Detailed usage (full OS version information).
> 3. Implementation: Code the configuration settings and ensure they are
> recognized by the Git system.
>
> Fix Cross-Platform Tests
> ---------------------------------
>
> 1. Identify Issues and added tests for changes/addition: Investigate
> existing test failures, particularly those occurring on Windows and .
>      - Review the test logs and identify the root causes of failures.
>      - Analyze differences in OS behaviors and how they affect the tests.
>      - Cross-platform tests to validate the functionality on Linux,
> Windows, and macOS environments.

It might be nice to explain how you plan to test on different platforms.

> 2. Implement Fixes:
>       - Modify tests to ensure they run correctly on Windows,
> addressing any compatibility issues with the test framework or Git
> commands.
>       - Ensure all tests reflect the changes made to the OS reporting
> capabilities.
>
> Testing and Validation
> ------------------------------
> Ensure comprehensive test coverage=E2=80=94including default behavior,
> configuration options, and edge cases=E2=80=94integrate tests into the Gi=
t CI
> pipeline for automatic execution, and share results with the community
> for feedback on robustness and additional scenarios.
>
> Documentation Updates
> ---------------------------------
>
> 1. User Documentation: Update the Git documentation to include:
>     - Instructions on how to configure the feature, with practical exampl=
es.
>     - Best practices regarding data privacy when using the capability.
> 2 Developer Documentation: Include comments in the code for
> maintainability and understanding of how the 'os-version' capability
> works internally.
>
>  Prepare for Merging
> ----------------------------
> 1. Final Review: Conduct a thorough review of all code, tests, and
> documentation. Ensure everything aligns with Git=E2=80=99s contribution
> standards.
> 2. Engagement with Community: Present the finalized patch to the Git
> mailing list, addressing any additional concerns raised during the
> discussions.
> 3. Merge Process: Coordinate with the maintainers for merging the
> patch into the main branch, ensuring all feedback has been
> incorporated.
>
>
> =E2=80=94------------------------- Timeline =E2=80=94--------------------=
-----------------
>
> Community Feedback and Finalization
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> Dates: November 26 - December 8
> Engage with the Git community to gather input, especially on privacy
> concerns and minimal data sharing. Determine default behavior (sharing
> only OS name) and finalize whether to use "user-agent" or another
> identifier in the protocol(os-version).
>
> Minimal Default Implementation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Dates: December 9 - December 20
> Implement the core feature to share only the OS name by default,
> keeping data minimal as per feedback.
> Send Patches for review from the Git community
>
> Configurable Options for OS Version
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> Dates: December 21 - December 30
> Develop settings to allow users to disable OS data sharing or choose
> verbose mode (e.g., uname -srvm output).
> Send Patches for review from the Git community

My opinion is that disabling OS data sharing will be required from the
start, while choosing a verbose mode or a custom mode could be
developed afterwards. So I think steps like the following make more
sense:

1. Implement the core feature to share only the OS name by default, as
well as an option to disable that feature.
2. Implement a verbose mode.
3. Implement a custom mode.

> Cross-Platform Testing (Focus on Windows)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Dates: December 31 - January 13
> Conduct robust testing across platforms, addressing prior Windows
> compatibility issues.
> Send Patches for review from the Git community

My opinion is that testing on all the platforms will be required for
each step, so that cannot be left for a later step. It should be
integrated into each of the development steps.

> Beta Testing and Community Feedback
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> Dates: January 14 - January 27
> Release for beta testing, integrate feedback, and refine functionality
> based on real-world use.

This should also be part of each of the development steps.

Also new features often spend some time in the 'next' branch before
being merged to master, which might be considered some kind of beta
testing, but we don't call it "beta testing". Before a new release is
tagged, we have a few rc0, rc1, etc releases, but they are not called
"beta" releases either. They are actually called "rc" releases, "rc"
meaning "Release Candidate". So overall, to avoid confusion, I think
it's better to not use the "beta testing" term unless you explicitly
say what you mean by it.

> Documentation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Dates: January 28 - February 10
> Document feature usage, configuration options, and setup instructions
> for smooth adoption.
> Send Patches for review from the Git community

Documentation should also be part of each of the development steps.

> Final Review and Merge
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Dates: February 11 - March 6
> The final review phase will include presenting the completed work to
> the Git community for a thorough final assessment. Any remaining
> concerns or suggestions will be addressed before the patch is prepared
> for merge. This stage will allow for further feedback, particularly
> from stakeholders and maintainers who raised the initial questions,
> ensuring the solution is acceptable to the broad Git community. Once
> consensus is achieved, the patch will be merged into the Git mainline
> codebase, concluding the project.

Not sure how things will go with reviews, but we prefer if development
can be incremental. So I hope some initial patches will be merged well
before the end of the internship.

> Availability
> =3D=3D=3D=3D=3D=3D=3D=3D
> I will be available to work for the required minimum of 40hours per week
> during the internship period and will be happy to extend if required.
>
> Blogging
> =3D=3D=3D=3D=3D=3D=3D
> I also plan to keep writing blogs after two weeks, to track my
> progress,  give updates about what I am currently working on and also
> as a documentation for future contributors.
>
> Post Outreachy Internship
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> One of my dreams is to be an active member of an open-source community
> which I can proudly support and contribute to. Continuing my
> contributions after the internship is a big part of making that dream
> a reality. I=E2=80=99m committed to contributing to Git long-term, helpin=
g to
> improve the project and supporting new contributors along the way.
>
> Appreciation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I really appreciate the support and guidance I got from the Git
> community. I also appreciate all the effort from the outreachy mentor.
> Thanks for your time.

Thanks for your application!

> On Mon, Oct 28, 2024 at 9:09=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> >
> > On Mon, Oct 28, 2024 at 8:26=E2=80=AFAM Christian Couder
> > <christian.couder@gmail.com> wrote:

Please remove previous discussions you don't reply to at the bottom of
your emails.

Thanks,
Christian.
