Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3231EE014
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202664; cv=none; b=A2hcKXKeDJjHOayzlrdugwkhRgLYM1yJ94RZ96P1yvMJ3o3EpPZmTY6sYiPiBB7woG8jvwTwC7j6Aa65s95/9djEsiZKFnhBI+odju+GpmbuDiersX+6rrprbvhqLLJ+jfYvJq01XCFu3nVjKQrPnnp6JI1Vq5DvaOJtRIz0jgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202664; c=relaxed/simple;
	bh=AWqEk33JDOtKQEPfj/1/pyGsDuYJ7Q2VtO6dTpD1A94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG6tFM3CFlto1tnZH1x5VmmbEeXArICoaAEHiSB+ie678fCmIUU/mZg+zyvpqd6ZgsunVM/8Opjoctuy2tX4PE8++qpSmxGXM/rGpXqPE37g1CbwpSoXiAlc3rK3Z4hDVkYsz72Z5ZCiLbm8SF9stC0pUIt08O2BCHy3de+huoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxAd1r2U; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxAd1r2U"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84fcb020503so2421273241.0
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 04:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730202660; x=1730807460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev10ev/hnGOKLlEu0i3a4z+66qgJAXaqKtn7orcoOik=;
        b=SxAd1r2UpUIWmykqDPBeRMg0fgmQHtC/6BqPFDSSJF0rFX+mtdPQ1H8ahCRV8TCXRT
         2XoTm2Z2AI/yopcBT6SpOicL6POiKoPRdSNo8rJxIRJ5aGfGAHTZuNl903GszaNPdoX6
         4d6e8ZeGhBZ28bdlnDqmC6olOvqA9BhxBe0b9cK0Bf5zHNkkRCHvWHRQr16TiqetSpG5
         V1GzydSQ5UCybd4QloWTP5xQnBB+waf/p/wD9r9GKdKqfokkt2mFIupS2w76Ni4k10yf
         u+jhrB6O5OE28tQ9ZLgBH19zDxxOSbYSzjl/zl0CKtergiZPNtIr0Ym/oLHYuQBia4EY
         wdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202660; x=1730807460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ev10ev/hnGOKLlEu0i3a4z+66qgJAXaqKtn7orcoOik=;
        b=pg5baYYIEY7UALs2cQtqnq9tk2iLp2tBAI4vWKgDDxW0VhAtmz8sPt71A76P6WzFnB
         0LRXgKAksjK3wme5OihkfL4JAZRbrEB2jqSnPeIRCzckaeZwkDLIwNHh5fLo1AQX8RIP
         oJXasQ4/n3eNLsqfUGtEBCcdCvmDAr8Qvrgro0/DryahpQUo/lDVVI9E6teXXWcruC9y
         BW8+qTaw5tuUU7gNVQxWjSwRvvxyABmKjluJ+HRl2APNyAqMCGiZEbspiObP+WXby/qs
         ZkGk21H9rozEuMHEZ4zYmNiv8RVdo7tJz8Gyd8NJRL6L8o4ZcEHcN3UA2oTt/meuofBH
         s7aA==
X-Gm-Message-State: AOJu0YybjSUb/cFpaVECRQv8/SN9iuQawL+wMtyArlveT/VIeIXw6RX+
	FUKRW7I//wir6q0NR8roCDSg90GYQTucruUPaXml1SUxHSydOngzvp6dgDTMBzqibtJkoSdYBxH
	CehbAHgp9IHy4zju64PTh1HtuG3g=
X-Google-Smtp-Source: AGHT+IFOwlZe8pl+jqNgLP5zFjujtBVxVFNku1O0pE8T0WIThOJHGdWuR0dioGly2vdIbXMmXsBILpwBgKoNFiYB4pw=
X-Received: by 2002:a05:6102:3594:b0:4a4:7e84:d654 with SMTP id
 ada2fe7eead31-4a8f6904986mr703621137.14.1730202659935; Tue, 29 Oct 2024
 04:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-4okXfiWZtSNArMjfXzja9wBrMaEayhqt1hvJpu-PHkQ@mail.gmail.com>
 <CAP8UFD2pLppDC9b-JV-uQa8x8xmpeTSJ4szHOEPz1OfqzrOMPw@mail.gmail.com>
 <CAPSxiM8NgFUK8R0TrE1nPctOYSD6M8cCe7=xJuniXWO2g-C6Nw@mail.gmail.com>
 <CAPSxiM-EorSBsStHCFAm845q2H+YNDtAvCkwON8cV4AyYvGz_w@mail.gmail.com>
 <CAP8UFD15F2bdQakdEK2K195FV5QrK+9Kw8Z2svysAjNGGL0Jmw@mail.gmail.com> <CAPSxiM_JCGtkcaxRN8+=cOCgpWtWZPC8W=Wv23dCcV_g-wwwPg@mail.gmail.com>
In-Reply-To: <CAPSxiM_JCGtkcaxRN8+=cOCgpWtWZPC8W=Wv23dCcV_g-wwwPg@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 29 Oct 2024 11:50:49 +0000
Message-ID: <CAPSxiM_rvt-tkQjHYmYNv-Wyr0=X4+123dt=vZKtc++PGRjQMQ@mail.gmail.com>
Subject: Re: [Outreachy][proposal]: Finish adding a 'os-version' capability to
 Git protocol v2
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
This is my updated version of my "Finish adding a 'os-version'
capability to Git protocol v2" proposal based on the comment provided
by Christian
Thank you.

---------<8----------<8----------<8----------<8----------<8----------<8

Personal Information
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Full Name: Usman Akinyemi
Email: usmanakinyemi202@gmail.com
Personal Blog: https://uniqueusman.hashnode.dev/
Personal Website: https://uniqueusman.tech
GitHub: https://github.com/Unique-Usman
Degree: Bachelor of Technology (B.Tech) in Computer Science and
Artificial Intelligence

About Me
=3D=3D=3D=3D=3D=3D=3D=3D

I am Usman Akinyemi, I often like to refer to myself as a nomadic
computer programmer as I love the ability to work on interesting
projects without being restricted to a physical location. I love the
Linux Operating System and most people already alias my name to Linux
as I also preach it to everyone everyday. I learnt programming in
multiple places, in college,  ALX Software Engineering program and
also personal studying. I have decent experience in contributing to
OpenSource projects. I have contributed to systemd, Cpython
documentation, Canonical website,  pep8speaks and Open Science
Initiative for Perfusion Imaging (OSIPI). Being someone who is a
product of the community, I value community development so much. I
have always tried my best to contribute to the community in my own
way. One case is when I organized a month-long program(structured
webinar) aimed at exposing young Nigerians to opportunities in tech.
The program focuses on topics such as OpenSource contributions,
securing internships, career development, freelancing, datascience,
and introduction to Github and Linux([ Youtube Recording
]https://www.youtube.com/watch?v=3DOrAThr-84t8&list=3DPLBW_HlYT-kP1tUqbzavM=
Aq-ZZQRhMkZH2&ab_channel=3DUsmanAkinyemi
). I have also volunteered for different communities one of which is
DesignIT where we train Nigerian youth on technology.


Past Experience with Git
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I have been a Git user for about three years now. I mainly use git for
personal projects, Group projects and OpenSource contributions. I have
also had the opportunity to introduce and teach people to Git. I am
really excited to be here in the Git community.
During the contribution stage, I have got more familiar with the
community and how to send patches to Git with the help of the Git
community. I have also learnt a couple of things, one of which is Git
contributor best practices.


Contributions to the Git Community
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

I joined the Git community after I got selected for Outreachy
Contribution Phase and I have been able to send some patches to the
Git codebase with the help of the Git community while also learning.
Below is the list of my contributions:

MICROPROJECT
------------------------
- Link: https://public-inbox.org/git/pull.1805.git.git.1728192814.gitgitgad=
get@gmail.com/T/#u
- Branch Name: ua/t3404-cleanup
- Status: merged into next/jch

+ [PATCH v7 1/2] t3404: avoid losing exit status with focus on `git
show` and `git cat-file`
- Description: In the Git t3404 test script, I improved error
detection by restructuring command chains to ensure accurate exit
status handling, preventing missed errors from piped commands.
The exit code of the preceding command in a pipe is disregarded. So if
that preceding command is a Git command that fails, the test would not
fail. Instead, by saving the output of that Git command to a file, and
removing the pipe, we make sure the test will fail if that Git
command fails. This particular patch focuses on all `git show` and
some instances of `git cat-file`.

+ [PATCH v7 2/2] t3404: replace test with test_line_count()
- Description: Refactor t3404 to replace instances of `test` with
`test_line_count()` for checking line counts. This improves
readability and aligns with Git's current test practices.

- Remarks: Through this process, I deepened my understanding of shell
scripting and command chaining, focusing on how exit statuses affect
testing accuracy. My mentors suggested keeping commands readable and
consistent with Git's scripting standards, emphasizing simplicity and
future maintainability. The result is a more robust, reliable test
script that better aligns with Git=E2=80=99s best practices, improving over=
all
test suite integrity. Also, through this patch, I was able to
understand the workflow involved in submitting a patch to Git which is
quite different from many other projects which I have worked on. This
is really an interesting learning experience.
I also learnt about the importance of following Git=E2=80=99s best practice=
s
and also how to submit patches with multiple commits.

LeftOverbits
-----------------
- Link: https://public-inbox.org/git/pull.1810.v3.git.git.1729574624.gitgit=
gadget@gmail.com/T/#t
- Branch Name: ua/atoi
- Status: merged into next/jch

After completing the microproject, I wanted to gain a deeper
understanding of Git=E2=80=99s codebase and workflow. I began looking throu=
gh
leftoverbits to work on and found a suitable one. Through this, I
learned how to add tests for my code additions, which helped me
understand the process of integrating and validating changes in the
codebase.

- General Description: In this series of patches, I replaced `atoi()`
with `strtoul_ui()` and `strtol_i()` across the daemon, merge, and
IMAP components to address the issue of inadequate error handling and
input validation. The use of `atoi()` could lead to undefined behavior
when parsing invalid inputs, such as letters, which might result in
incorrect program behavior. Now, invalid inputs trigger clear error
messages, ensuring safer parsing and preventing malformed responses. I
updated tests for the daemon and merged components to verify these
improvements, while IMAP changes didn't include tests since none
existed for `git-imap-send`. Overall, this update significantly
strengthens input validation and code reliability.

+ [PATCH v6 1/3] daemon: replace atoi() with strtoul_ui() and strtol_i()
Replace atoi() with strtoul_ui() for --timeout and --init-timeout
(non-negative integers) and with strtol_i() for --max-connections
(signed integers). This improves error handling and input validation
by detecting invalid values and providing clear error messages.

+ [PATCH v6 2/3] merge: replace atoi() with strtol_i() for marker size
validation
Replace atoi() with strtol_i() for parsing conflict-marker-size to
improve error handling. Invalid values, such as those containing
letters now trigger a clear error message.

+ [PATCH v6 3/3] imap: replace atoi() with strtol_i() for UIDVALIDITY
and UIDNEXT
Replace unsafe uses of atoi() with strtol_i() to improve error handling
when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
Invalid values, such as those with letters, now trigger error messages
and prevent malformed status responses.

- Remarks: In this patch series, I learnt a lot of things. The
importance of splitting large changes into Smaller changes for easy
review. I also learnt about how to submit multiple patches which are
not related by creating a new branch from origin/master. Also, I
learnt how to write better commit messages. And lastly, the importance
of asking for help and integrating suggestions from the community.

I also had the opportunity to review a patch and also answer doubt
from other Outreachy applicant mate

https://public-inbox.org/git/CAEqABkKvbpo-8-gDpFtfNcpmiC8A5mJMkcDXfhcdNrpwM=
vBsDA@mail.gmail.com/T/#u
https://public-inbox.org/git/CAPSxiM8SjJwb6x2bhCd4xsYLiNk+KhWYna7-rZhdNGpYN=
V1tLg@mail.gmail.com/


Past experience with other communities
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Systemd
------------

- I Developed a new unit test framework with assertion macros which
enhanced debugging by providing detailed error reports with file
names, line numbers, and expression values upon failure, improving
issue identification and resolution
- I Updated approximately 22 existing unit test files by modifying 403
lines of code to incorporate the new assertion macros, resulting in
improved logging details and enhanced overall test coverage and
debugging efficiency.
- I Implemented the --json option for the bootctl status command and
updated the integration tests, enabling machine-readable JSON output
for comprehensive bootloader status information

PR Link:
https://github.com/systemd/systemd/pull/31873
https://github.com/systemd/systemd/pull/31853
https://github.com/systemd/systemd/pull/31819
https://github.com/systemd/systemd/pull/31700
https://github.com/systemd/systemd/pull/31678
https://github.com/systemd/systemd/pull/31669
https://github.com/systemd/systemd/pull/31666
https://github.com/systemd/systemd/pull/32035

Python Official Documentation
-----------------------------------------
- I have contributed to improving Python's official documentation,
enhancing my Python knowledge, technical writing, and collaboration
skills in open-source.

PR Link:
https://github.com/python/cpython/pull/109696
https://github.com/python/cpython/pull/111574
https://github.com/python/docs-community/pull/96
https://github.com/python/cpython/pull/113209
https://github.com/python/docs-community/pull/97

OSIPI (Open Science Initiative for Perfusion Imaging organization)

---------------------------------------------------------------------------=
------------------------
- Added a command-line interface to the existing 4D IVIM phantoms
generator, with detailed documentation for usage.
- Created a Python script for efficient reading and writing of NIfTI
images, improving data processing workflows.
- Dockerized the TF2.4_IVIM-MRI_CodeCollection project and implemented
a GitHub Action for automated Docker image building and testing,
ensuring consistent deployment and a streamlined CI/CD pipeline.

PR Link:
https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/commit/92a80d61cfca3=
22da49d126dcd598996fca92668
https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/commit/163a187c5eaad=
33b55a0af0487bd9e19ca520828
https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/commit/56ee7173c91c7=
a1dd64412d3884a3167c7514665
https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/commit/e6a47211410ed=
57705e2ec32adb397ac6663d061
https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/pull/60
https://github.com/OSIPI/TF2.4_IVIM-MRI_CodeCollection/pull/74

Canonical Docs Website
---------------------------------
I developed a solution to integrate GitHub contributor information
into Sphinx documentation templates using the GitHub API, enhancing
documentation with contributor insights.

PR Link:
https://github.com/canonical/sphinx-docs-starter-pack/pull/203#issuecomment=
-2018521984

LLVM
--------
I fixed a bug in Clang's Extract API for Objective-C JSON generation
and optimized the test suite within the LLVM Compiler Infrastructure.
https://github.com/Unique-Usman/llvm-project/commit/32b53cf9d0c8c0e01ce5b0e=
7d5c717202a98cdf5


Experience as a user of OpenSource Software
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

As an avid user of open-source software, my experience has been
primarily with Linux distributions, particularly Arch, which serves as
my primary operating system. My past usage of Ubuntu has also
contributed to my understanding of different Linux environments.
In addition, I have extensively utilized various free software such as
MySQL for database management, LibreOffice for office productivity,
GCC and G++ for C and C++ programming, Python for scripting and
application development, React for web development, Clang for C/C++
compilation, Git for version control and many others. These
experiences have not only enriched my software knowledge but have also
deepened my understanding of the principles and benefits of
open-source development.


=E2=80=94---------------- Project Overview ---------------------------

In June 2024, a patch series was submitted to the Git mailing list
aimed at adding a new 'os-version' capability to the Git protocol v2.
This capability is designed to allow Git clients and servers to
exchange information about the Operating System (OS) they are using,
which can aid in diagnosing issues and collecting statistical data.
Following the patch submission, discussions arose regarding the
necessary improvements and issues, particularly with Windows
compatibility.
The objective of this internship is to address these outstanding
issues, implement the required improvements, and ensure the successful
integration of the 'os-version' capability into the Git protocol.

=E2=80=94------- Internship objectives and plans  =E2=80=94-------
The goal of this internship is to finalize the implementation of the
'os-version' capability in Git protocol v2, as proposed in the patch
series sent to the Git mailing list in June 2024. This enhancement
will allow Git clients and servers to advertise their operating
systems (OS), aiding in diagnostics and data collection.

Detailed Tasks and Steps
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Review the Current Patch Series
--------------------------------------------
1. Examine the Patch: Thoroughly analyze the existing patch series
submitted to the Git mailing list. Understand its design and
functionality, focusing on:
   -  How the OS information is gathered and transmitted.
   -  Current configurations and their implications on data transmission.
2. Feedback Analysis: Collect feedback from the Git mailing list
discussion regarding the patch. Identify key concerns, especially
related to:
    - Privacy issues.
    - Default behavior expectations.
    - Cross-platform compatibility.
3. Consider User-Agent Integration: Investigate the suggestion to
integrate the 'os-version' data into the existing user-agent string
rather than creating a new capability. Evaluate:
    - The implications of combining this data with the user-agent.
    - How this approach might address concerns about telemetry and user pri=
vacy.

Implement Default Behavior for 'os-version'
----------------------------------------------------------
1. Modify Default Configuration: Adjust the implementation so that by
default, only the OS name (e.g., "Linux" or "Windows") is sent during
communications.
2. Impact Assessment: Evaluate how this change impacts existing users
and any potential performance implications.

Introduce a Configuration Variable
---------------------------------------------
1. Define Configuration Options
    - Disable Option: Allow users to disable the 'os-version'
capability entirely via configuration.
    - Verbose Option: Enable a verbose mode that sends detailed OS
information (e.g., the output of the uname -srvm command).
    - Custom Option: Allows users to specify components independently,
using variables such as %(os_name) for OS,  %(distro) for Linux
distribution, and %(arch) for architecture.
For example:
    i. "OS: %(os_name), Distro: %(distro), Arch: %(arch)" might output "OS:
Linux, Distro: Fedora, Arch: x86_64".
    ii.  "Distro: %(distro) Version, OS: %(os_name)" could yield "Distro:
Ubuntu 22.04, OS: Linux"
Send Patches for review from the Git community

2. Documentation: Improve the documentation outlining how to enable,
disable, and configure the 'os-version' capability. Include examples
for:
    - Basic usage (default OS name).
    - Detailed usage (full OS version information).
3. Implementation: Code the configuration settings and ensure they are
recognized by the Git system.

Fix Cross-Platform Tests
---------------------------------

1. Identify Issues and added tests for changes/addition: Investigate
existing test failures, particularly those occurring on Windows and .
     - Review the test logs and identify the root causes of failures.
     - Analyze differences in OS behaviors and how they affect the tests.
     - Cross-platform tests to validate the functionality on Linux,
Windows, and macOS environments.
2. Implement Fixes:
      - Modify tests to ensure they run correctly on Windows,
addressing any compatibility issues with the test framework or Git
commands.
      - Ensure all tests reflect the changes made to the OS reporting
capabilities.

Cross-Platform Testing Approach
--------------------------------------------
- To ensure robust compatibility, each development phase includes test
coverage across Linux, Windows, and other environments using Git's CI
pipeline. Tests will validate that features work seamlessly across all
platforms and that output is consistent across different environments.

- Direct Testing on Windows to address compatibility issues unique to
Windows and verify expected behavior.


Testing and Validation
------------------------------
Ensure comprehensive test coverage=E2=80=94including default behavior,
configuration options, and edge cases=E2=80=94integrate tests into the Git =
CI
pipeline for automatic execution, and share results with the community
for feedback on robustness and additional scenarios.

Documentation Updates
---------------------------------

1. User Documentation: Update the Git documentation to include:
    - Instructions on how to configure the feature, with practical examples=
.
    - Best practices regarding data privacy when using the capability.
2 Developer Documentation: Include comments in the code for
maintainability and understanding of how the 'os-version' capability
works internally.

 Prepare for Merging
----------------------------
1. Final Review: Conduct a thorough review of all code, tests, and
documentation. Ensure everything aligns with Git=E2=80=99s contribution
standards.
2. Engagement with Community: Present the finalized patch to the Git
mailing list, addressing any additional concerns raised during the
discussions.
3. Merge Process: Coordinate with the maintainers for merging the
patch into the main branch, ensuring all feedback has been
incorporated.


=E2=80=94------------------------- Timeline =E2=80=94----------------------=
---------------

Community Feedback and Finalization
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Dates: November 26 - December 8
Engage with the Git community to gather input, especially on privacy
concerns and minimal data sharing. Determine default behavior (sharing
only OS name) and finalize whether to use "user-agent" or another
identifier in the protocol(os-version).

Preparation and Understanding
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dates: December 9 - December 12
- Retrieve patches and create a dedicated branch for this work.
- Set up a blog post to document the internship experience,
with an overview of project goals and initial reflections.

Initial Testing and Patching
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dates: December 13 - December 17
Apply patches to establish the foundation for further feature development.
Run initial tests on the patched branch.
Identify current issues, with an emphasis on Windows
compatibility challenges and cross-platform stability.

Incremental Development with Testing, Documentation, and Release Candidates=
 (RC)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dates: December 18 - February 24
Each feature development phase will follow an incremental approach,
where implementation, cross-platform testing, documentation, and RCs
for community feedback are all integrated.

Step 1: Minimal Default Implementation with RC Testing
------------------------------------------------------------------------
Dates: December 18 - January 5
Development: Implement the core feature to share only the OS name,
with an option to disable data sharing.
Testing: Conduct cross-platform testing, especially on Windows.
Documentation: Document default behavior and configuration options.
Release Candidate: Submit an RC patch for community review and
incorporate any feedback.

Step 2: Verbose Mode with RC Testing
----------------------------------------------------
Dates: January 6 - January 26
Development: Add a verbose mode, allowing detailed OS info (e.g.,
uname -srvm on Linux).
Testing: Run cross-platform testing to ensure verbose mode stability.
Documentation: Update documentation to cover verbose mode options and
configurations.
Release Candidate: Release an RC patch for verbose mode, collect
feedback, and address issues as necessary.

Step 3: Custom Mode with RC Testing
---------------------------------------------------
Dates: January 27 - February 16
Development: Implement a custom mode, enabling users to tailor OS data
preferences.
Testing: Execute extensive cross-platform testing to verify all modes.
Documentation: Finalize documentation to explain custom mode setup and usag=
e.
Release Candidate: Share an RC patch for custom mode with the
community, and make refinements based on feedback.

Last Review and Feedback Integration
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Dates: February 17 - March 6
Address any last revisions based on cumulative community and
maintainer feedback for each feature.
Conduct a thorough review of the code, documentation, and tests to
confirm readiness.
Prepare the finalized feature set for integration into Git=E2=80=99s mainli=
ne,
ensuring alignment with Git community expectations and protocols.


Availability
=3D=3D=3D=3D=3D=3D=3D=3D
I will be available to work for the required minimum of 40hours per week
during the internship period and will be happy to extend if required.

Blogging
=3D=3D=3D=3D=3D=3D=3D
I also plan to keep writing blogs after two weeks, to track my
progress,  give updates about what I am currently working on and also
as a documentation for future contributors.

Post Outreachy Internship
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
One of my dreams is to be an active member of an open-source community
which I can proudly support and contribute to. Continuing my
contributions after the internship is a big part of making that dream
a reality. I=E2=80=99m committed to contributing to Git long-term, helping =
to
improve the project and supporting new contributors along the way.

Appreciation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I really appreciate the support and guidance I got from the Git
community. I also appreciate all the effort from the outreachy mentor.
Thanks for your time.

Thank you.

Usman Akinyemi.
